//==================================================================================================
// 2012-07-15 by Capella at http://www.worldwide-invest.org
// - Removed protection
//==================================================================================================

#property copyright "ForexHacked 2.5"
#property link      "http://www.ForexHacked.com"

/*
#import "wininet.dll"
   int InternetOpenA(string a0, int a1, string a2, string a3, int a4);
   int InternetOpenUrlA(int a0, string a1, string a2, int a3, int a4, int a5);
   int InternetReadFile(int a0, string a1, int a2, int& a3[]);
   int InternetCloseHandle(int a0);
#import
*/

//extern string User = "Your ForexHacked.com Username";
extern string _________ = "Magic Number Must be UNIQUE for each chart!";
extern int MagicNumber = 133714;
extern double Lots = 0.01;
extern double TakeProfit = 45.0;
extern double Booster = 1.7;
double gd_120 = 0.0;
extern int PipStarter = 31;
double gd_132 = 0.0;
int gi_unused_140 = 0;
int gi_144 = 0;
extern int MaxBuyOrders = 9;
extern int MaxSellOrders = 9;
extern bool AllowiStopLoss = FALSE;
extern int iStopLoss = 300;
extern int StartHour = 0;
extern int StartMinute = 0;
extern int StopHour = 23;
extern int StopMinute = 55;
extern int StartingTradeDay = 0;
extern int EndingTradeDay = 7;
extern int slippage = 3;
extern bool allowTrending = FALSE;
extern int trendTrigger = 3;
extern int trendPips = 5;
extern int trendStoploss = 5;
int gi_208 = 5000;
int gi_212 = 0;
int gi_216 = 0;
extern double StopLossPct = 100.0;
extern double TakeProfitPct = 100.0;
extern bool PauseNewTrades = FALSE;
extern int StoppedOutPause = 600;
double gd_244;
bool gi_260;
int g_period_264 = 7;
int gi_268 = 0;
int g_ma_method_272 = MODE_LWMA;
int g_applied_price_276 = PRICE_WEIGHTED;
double gd_280 = 0.25;
double gd_288 = 0.2;
extern bool SupportECN = TRUE;
extern bool MassHedge = FALSE;
extern double MassHedgeBooster = 1.01;
extern int TradesDeep = 5;
extern string EA_Name = "ForexHacked 2.5";
int g_datetime_324;
double g_point_328;
int gi_336;
bool gi_unused_340 = FALSE;
string gs_dummy_344;
int gi_352;
int gi_356;
int gi_360 = 0;
int gi_364 = 1;
int gi_unused_368 = 3;
int gi_372 = 250;
string gs_376;
bool gi_384;
bool gi_388;
bool gi_392;
bool gi_396;
int g_ticket_400;
int g_cmd_404;
string gs__hedged_408 = " hedged";
int g_file_416;

void f0_13(string as_0) {
   if (g_file_416 >= 0) FileWrite(g_file_416, TimeToStr(TimeCurrent(), TIME_DATE|TIME_SECONDS) + ": " + as_0);
}

int f0_4() {
   double ld_4 = MarketInfo(Symbol(), MODE_MINLOT);
   for (int count_0 = 0; ld_4 < 1.0; count_0++) ld_4 = 10.0 * ld_4;
   return (count_0);
}

double f0_2(double a_minlot_0) {
   double minlot_32;
   double ld_8 = AccountEquity() - gi_208;
   double ld_16 = gi_212;
   double ld_24 = gi_216;
   if (gi_212 == 0 || gi_216 == 0) minlot_32 = a_minlot_0;
   else {
      ld_16 = gi_208 * ld_16 / 100.0;
      Print("tmp=" + ld_8 + ",AccountEquity()=" + AccountEquity() + ",InitEquity=" + gi_208);
      ld_24 /= 100.0;
      if (ld_8 > 0.0) ld_8 = MathPow(ld_24 + 1.0, ld_8 / ld_16);
      else {
         if (ld_8 < 0.0) ld_8 = MathPow(1 - ld_24, MathAbs(ld_8 / ld_16));
         else ld_8 = 1;
      }
      minlot_32 = NormalizeDouble(a_minlot_0 * ld_8, f0_4());
      if (minlot_32 < MarketInfo(Symbol(), MODE_MINLOT)) minlot_32 = MarketInfo(Symbol(), MODE_MINLOT);
   }
   if (minlot_32 < 0.0) Print("ERROR tmp=" + ld_8 + ",a=" + ld_16 + ",b=" + ld_24 + ",AccountEquity()=" + AccountEquity());
   f0_13("Equity=" + AccountEquity() + ",lots=" + minlot_32);
   return (minlot_32);
}

/*
int f0_3(bool ai_0) {
   string ls_4;
   if (gi_352 == 0) {
      ls_4 = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Q312461)";
      gi_352 = InternetOpenA(ls_4, gi_360, "0", "0", 0);
      gi_356 = InternetOpenA(ls_4, gi_364, "0", "0", 0);
   }
   if (ai_0) return (gi_356);
   return (gi_352);
}

int f0_6(string as_0, string &as_8) {
   int lia_24[] = {1};
   string ls_28 = "x";
   int li_16 = InternetOpenUrlA(f0_3(0), as_0, "0", 0, -2080374528, 0);
   if (li_16 == 0) return (0);
   int li_20 = InternetReadFile(li_16, ls_28, gi_372, lia_24);
   if (li_20 == 0) return (0);
   int li_36 = lia_24[0];
   for (as_8 = StringSubstr(ls_28, 0, lia_24[0]); lia_24[0] != 0; as_8 = as_8 + StringSubstr(ls_28, 0, lia_24[0])) {
      li_20 = InternetReadFile(li_16, ls_28, gi_372, lia_24);
      if (lia_24[0] == 0) break;
      li_36 += lia_24[0];
   }
   li_20 = InternetCloseHandle(li_16);
   if (li_20 == 0) return (0);
   return (1);
}
*/

int deinit() {
   FileClose(g_file_416);
   return (0);
}

int init() {
   if (Digits == 3) {
      gd_132 = 10.0 * TakeProfit;
      gi_unused_140 = 10.0 * PipStarter;
      gi_144 = 10.0 * iStopLoss;
      g_point_328 = 0.01;
   } else {
      if (Digits == 5) {
         gd_132 = 10.0 * TakeProfit;
         gi_unused_140 = 10.0 * PipStarter;
         gi_144 = 10.0 * iStopLoss;
         g_point_328 = 0.0001;
      } else {
         gd_132 = TakeProfit;
         gi_unused_140 = PipStarter;
         gi_144 = iStopLoss;
         g_point_328 = Point;
      }
   }
   if (Digits == 3 || Digits == 5) {
      trendTrigger = 10 * trendTrigger;
      trendPips = 10 * trendPips;
      trendStoploss = 10 * trendStoploss;
   }
   gi_336 = MathRound((-MathLog(MarketInfo(Symbol(), MODE_LOTSTEP))) / 2.302585093);
   gi_384 = FALSE;
   gi_388 = FALSE;
   gi_392 = FALSE;
   gi_396 = FALSE;
   g_ticket_400 = -1;
   gi_260 = FALSE;
   g_file_416 = FileOpen(WindowExpertName() + "_" + Time[0] + "_" + Symbol() + "_" + MagicNumber + ".log", FILE_WRITE);
   g_cmd_404 = -1;
   if (IsDemo() == TRUE) gs_376 = "approved";
   else {
//      f0_6("http://www.forexhacked.com/query.php?accountnumber=" + AccountNumber() + "&login=" + User, gs_376);
      Print("init is done");
      return (0);
   }
   return (0);
}

int f0_9() {
   int li_8;
   if (DayOfWeek() < StartingTradeDay || DayOfWeek() > EndingTradeDay) return (0);
   int li_0 = 60 * TimeHour(TimeCurrent()) + TimeMinute(TimeCurrent());
   int li_4 = 60 * StartHour + StartMinute;
   li_8 = 60 * StopHour + li_8;
   if (li_4 == li_8) return (1);
   if (li_4 < li_8) {
      if (!(li_0 >= li_4 && li_0 < li_8)) return (0);
      return (1);
   }
   if (li_4 > li_8) {
      if (li_0 >= li_4 || li_0 < li_8) return (1);
   } else return (0);
   return (0);
}

double f0_7(int ai_0) {
   for (int pos_4 = OrdersTotal() - 1; pos_4 >= 0; pos_4--) {
      if (OrderSelect(pos_4, SELECT_BY_POS)) {
         if (OrderMagicNumber() == MagicNumber) {
            if (StringFind(OrderComment(), gs__hedged_408) == -1) {
               f0_13("GetLastLotSize " + ai_0 + ",OrderLots()=" + OrderLots());
               return (OrderLots());
            }
         }
      }
   }
   f0_13("GetLastLotSize " + ai_0 + " wasnt found");
   return (0);
}

int f0_8(bool ai_0 = FALSE) {
   int ticket_4;
   double lots_40;
   double price_8 = 0;
   double price_16 = 0;
   string ls_24 = "";
   bool li_ret_32 = TRUE;
   if (TimeCurrent() - g_datetime_324 < 60) return (0);
   if (ai_0 && (!gi_392)) return (0);
   if (!GlobalVariableCheck("PERMISSION")) {
      GlobalVariableSet("PERMISSION", TimeCurrent());
      if (!SupportECN) {
         if (ai_0) {
            if (OrderSelect(g_ticket_400, SELECT_BY_TICKET)) price_16 = OrderTakeProfit() - MarketInfo(Symbol(), MODE_SPREAD) * Point;
         } else price_8 = Ask + gd_132 * Point;
      }
      if (ai_0) ls_24 = gs__hedged_408;
      if (AllowiStopLoss == TRUE) price_16 = Ask - gi_144 * Point;
      if (ai_0) lots_40 = NormalizeDouble(f0_7(1) * MassHedgeBooster, 2);
      else lots_40 = f0_2(gd_244);
      if (!SupportECN) ticket_4 = OrderSend(Symbol(), OP_BUY, lots_40, Ask, slippage, price_16, price_8, EA_Name + ls_24, MagicNumber, 0, Green);
      else {
         ticket_4 = OrderSend(Symbol(), OP_BUY, lots_40, Ask, slippage, 0, 0, EA_Name + ls_24, MagicNumber, 0, Green);
         Sleep(1000);
         OrderModify(ticket_4, OrderOpenPrice(), price_16, price_8, 0, Black);
      }
      g_datetime_324 = TimeCurrent();
      if (ticket_4 != -1) {
         if (!ai_0) {
            g_ticket_400 = ticket_4;
            f0_13("BUY hedgedTicket=" + g_ticket_400);
         } else {
            f0_13("BUY Hacked_ticket=" + ticket_4);
            g_cmd_404 = 0;
         }
      } else {
         f0_13("failed sell");
         li_ret_32 = FALSE;
      }
   }
   GlobalVariableDel("PERMISSION");
   return (li_ret_32);
}

int f0_10(bool ai_0 = FALSE) {
   int ticket_4;
   double lots_36;
   double price_8 = 0;
   double price_16 = 0;
   string ls_24 = "";
   bool li_ret_32 = TRUE;
   if (TimeCurrent() - g_datetime_324 < 60) return (0);
   if (ai_0 && (!gi_396)) return (0);
   if (!GlobalVariableCheck("PERMISSION")) {
      GlobalVariableSet("PERMISSION", TimeCurrent());
      if (!SupportECN) {
         if (ai_0) {
            if (OrderSelect(g_ticket_400, SELECT_BY_TICKET)) price_16 = OrderTakeProfit() + MarketInfo(Symbol(), MODE_SPREAD) * Point;
         } else price_8 = Bid - gd_132 * Point;
      }
      if (ai_0) ls_24 = gs__hedged_408;
      if (AllowiStopLoss == TRUE) price_16 = Bid + gi_144 * Point;
      if (ai_0) lots_36 = NormalizeDouble(f0_7(0) * MassHedgeBooster, 2);
      else lots_36 = f0_2(gd_244);
      if (!SupportECN) ticket_4 = OrderSend(Symbol(), OP_SELL, lots_36, Bid, slippage, price_16, price_8, EA_Name + ls_24, MagicNumber, 0, Pink);
      else {
         ticket_4 = OrderSend(Symbol(), OP_SELL, lots_36, Bid, slippage, 0, 0, EA_Name + ls_24, MagicNumber, 0, Pink);
         Sleep(1000);
         OrderModify(ticket_4, OrderOpenPrice(), price_16, price_8, 0, Black);
      }
      g_datetime_324 = TimeCurrent();
      if (ticket_4 != -1) {
         if (!ai_0) {
            g_ticket_400 = ticket_4;
            f0_13("SELL hedgedTicket=" + g_ticket_400);
         } else {
            f0_13("SELL Hacked_ticket=" + ticket_4);
            g_cmd_404 = 1;
         }
      } else {
         f0_13("failed sell");
         li_ret_32 = FALSE;
      }
   }
   GlobalVariableDel("PERMISSION");
   return (li_ret_32);
}

void f0_12() {
   int datetime_0 = 0;
   double order_open_price_4 = 0;
   double order_lots_12 = 0;
   double order_takeprofit_20 = 0;
   int cmd_28 = -1;
   int ticket_32 = 0;
   int pos_36 = 0;
   int count_40 = 0;
   for (pos_36 = 0; pos_36 < OrdersTotal(); pos_36++) {
      if (OrderSelect(pos_36, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderMagicNumber() == MagicNumber && OrderType() == OP_BUY) {
            count_40++;
            if (OrderOpenTime() > datetime_0) {
               datetime_0 = OrderOpenTime();
               order_open_price_4 = OrderOpenPrice();
               cmd_28 = OrderType();
               ticket_32 = OrderTicket();
               order_takeprofit_20 = OrderTakeProfit();
            }
            if (OrderLots() > order_lots_12) order_lots_12 = OrderLots();
         }
      }
   }
   int li_44 = MathRound(MathLog(order_lots_12 / Lots) / MathLog(Booster)) + 1.0;
   if (li_44 < 0) li_44 = 0;
   gd_244 = NormalizeDouble(Lots * MathPow(Booster, li_44), gi_336);
   if (li_44 == 0 && f0_5() == 1 && f0_9()) {
      if (f0_8())
         if (MassHedge) gi_384 = TRUE;
   } else {
      if (order_open_price_4 - Ask > PipStarter * g_point_328 && order_open_price_4 > 0.0 && count_40 < MaxBuyOrders) {
         if (!(f0_8())) return;
         if (!(MassHedge)) return;
         gi_384 = TRUE;
         return;
      }
   }
   for (pos_36 = 0; pos_36 < OrdersTotal(); pos_36++) {
      OrderSelect(pos_36, SELECT_BY_POS, MODE_TRADES);
      if (OrderMagicNumber() != MagicNumber || OrderType() != OP_BUY || OrderTakeProfit() == order_takeprofit_20 || order_takeprofit_20 == 0.0) continue;
      OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), order_takeprofit_20, 0, Pink);
      Sleep(1000);
   }
}

int f0_5() {
   double isar_0 = iSAR(NULL, 0, gd_280, gd_288, 0);
   double ima_8 = iMA(NULL, 0, g_period_264, gi_268, g_ma_method_272, g_applied_price_276, 0);
   if (isar_0 > ima_8) return (-1);
   if (isar_0 < ima_8) return (1);
   return (0);
}

void f0_11() {
   int datetime_0 = 0;
   double order_open_price_4 = 0;
   double order_lots_12 = 0;
   double order_takeprofit_20 = 0;
   int cmd_28 = -1;
   int ticket_32 = 0;
   int pos_36 = 0;
   int count_40 = 0;
   for (pos_36 = 0; pos_36 < OrdersTotal(); pos_36++) {
      if (OrderSelect(pos_36, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderMagicNumber() == MagicNumber && OrderType() == OP_SELL) {
            count_40++;
            if (OrderOpenTime() > datetime_0) {
               datetime_0 = OrderOpenTime();
               order_open_price_4 = OrderOpenPrice();
               cmd_28 = OrderType();
               ticket_32 = OrderTicket();
               order_takeprofit_20 = OrderTakeProfit();
            }
            if (OrderLots() > order_lots_12) order_lots_12 = OrderLots();
         }
      }
   }
   int li_44 = MathRound(MathLog(order_lots_12 / Lots) / MathLog(Booster)) + 1.0;
   if (li_44 < 0) li_44 = 0;
   gd_244 = NormalizeDouble(Lots * MathPow(Booster, li_44), gi_336);
   if (li_44 == 0 && f0_5() == -1 && f0_9()) {
      if (f0_10())
         if (MassHedge) gi_388 = TRUE;
   } else {
      if (Bid - order_open_price_4 > PipStarter * g_point_328 && order_open_price_4 > 0.0 && count_40 < MaxSellOrders) {
         if (!(f0_10())) return;
         if (!(MassHedge)) return;
         gi_388 = TRUE;
         return;
      }
   }
   for (pos_36 = 0; pos_36 < OrdersTotal(); pos_36++) {
      if (OrderSelect(pos_36, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderMagicNumber() == MagicNumber && OrderType() == OP_SELL) {
            if (OrderTakeProfit() == order_takeprofit_20 || order_takeprofit_20 == 0.0) continue;
            OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), order_takeprofit_20, 0, Pink);
         }
      }
   }
}

int start() {
   double order_takeprofit_20;
   double price_28;
   double price_36;

   if (allowTrending) {
      for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
         if (OrderSelect(pos_0, SELECT_BY_POS)) {
            if (MagicNumber == OrderMagicNumber()) {
               if (OrderType() == OP_BUY)
                  if (OrderTakeProfit() - Bid <= trendTrigger * Point && Bid < OrderTakeProfit()) OrderModify(OrderTicket(), 0, Bid - trendStoploss * Point, OrderTakeProfit() + trendPips * Point, 0, White);
               if (OrderType() == OP_SELL)
                  if (Ask - OrderTakeProfit() <= trendTrigger * Point && Ask > OrderTakeProfit()) OrderModify(OrderTicket(), 0, Ask + trendStoploss * Point, OrderTakeProfit() - trendPips * Point, 0, White);
            }
         }
      }
   }
   int count_4 = 0;
   int count_8 = 0;
   for (int pos_12 = 0; pos_12 < OrdersTotal(); pos_12++) {
      if (OrderSelect(pos_12, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderMagicNumber() == MagicNumber) {
            if (StringFind(OrderComment(), gs__hedged_408) == -1) {
               if (OrderType() == OP_BUY) {
                  count_4++;
                  continue;
               }
               if (OrderType() == OP_SELL) count_8++;
            }
         }
      }
   }
   if (count_4 >= TradesDeep) {
      if (!gi_396) {
         f0_13("Allow long hedge! trades=" + count_4 + ",TradesDeep=" + TradesDeep);
         gi_396 = TRUE;
      }
   }
   if (count_8 >= TradesDeep) {
      if (!gi_392) {
         f0_13("Allow short hedge! trades=" + count_8 + ",TradesDeep=" + TradesDeep);
         gi_392 = TRUE;
      }
   }
   bool li_16 = FALSE;
   if ((100 - StopLossPct) * AccountBalance() / 100.0 >= AccountEquity()) {
      f0_13("AccountBalance=" + AccountBalance() + ",AccountEquity=" + AccountEquity());
      gi_260 = TRUE;
      li_16 = TRUE;
   }
   if ((TakeProfitPct + 100.0) * AccountBalance() / 100.0 <= AccountEquity()) gi_260 = TRUE;
   if (gi_260) {
      for (pos_0 = OrdersTotal() - 1; pos_0 >= 0; pos_0--) {
         if (OrderSelect(pos_0, SELECT_BY_POS)) {
            if (OrderMagicNumber() == MagicNumber) {
               f0_13("close #" + OrderTicket());
               if (!OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), MarketInfo(Symbol(), MODE_SPREAD), White)) {
                  f0_13("error");
                  return (0);
               }
            }
         }
      }
      gi_260 = FALSE;
      if (li_16) {
         Sleep(1000 * StoppedOutPause);
         li_16 = FALSE;
      }
      gi_396 = FALSE;
      gi_392 = FALSE;
   }
   if (SupportECN) {
      order_takeprofit_20 = 0;
      if (OrderSelect(g_ticket_400, SELECT_BY_TICKET)) order_takeprofit_20 = OrderTakeProfit();
      for (pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
         if (OrderSelect(pos_0, SELECT_BY_POS)) {
            if (OrderMagicNumber() == MagicNumber) {
               if (OrderTakeProfit() == 0.0 && StringFind(OrderComment(), gs__hedged_408) == -1) {
                  if (OrderType() == OP_BUY) {
                     OrderModify(OrderTicket(), 0, OrderStopLoss(), OrderOpenPrice() + gd_132 * Point, 0, White);
                     continue;
                  }
                  if (OrderType() != OP_SELL) continue;
                  OrderModify(OrderTicket(), 0, OrderStopLoss(), OrderOpenPrice() - gd_132 * Point, 0, White);
                  continue;
               }
               if (StringFind(OrderComment(), gs__hedged_408) != -1 && g_cmd_404 == OrderType()) {
                  price_28 = order_takeprofit_20 - MarketInfo(Symbol(), MODE_SPREAD) * Point;
                  price_36 = order_takeprofit_20 + MarketInfo(Symbol(), MODE_SPREAD) * Point;
                  if (OrderStopLoss() == 0.0 || (OrderType() == OP_BUY && OrderStopLoss() != price_28) || (OrderType() == OP_SELL && OrderStopLoss() != price_36)) {
                     if (OrderType() == OP_BUY) {
                        OrderModify(OrderTicket(), 0, price_28, OrderTakeProfit(), 0, White);
                        continue;
                     }
                     if (OrderType() == OP_SELL) OrderModify(OrderTicket(), 0, price_36, OrderTakeProfit(), 0, White);
                  }
               }
            }
         }
      }
   }
   if (f0_0() != 0) {
      f0_12();
      f0_11();
      if ((!PauseNewTrades) && f0_9()) {
         if (gi_388)
            if (f0_8(1)) gi_388 = FALSE;
         if (gi_384)
            if (f0_10(1)) gi_384 = FALSE;
      }
      f0_14();
      return (0);
   }
   return (0);
}

void f0_14() {
   string dbl2str_0 = DoubleToStr(f0_1(2), 2);
   for (int pos_8 = 0; pos_8 < OrdersHistoryTotal(); pos_8++)
      if (OrderSelect(pos_8, SELECT_BY_POS, MODE_HISTORY) && OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() && OrderType() <= OP_SELL) gd_120 += OrderProfit() + OrderCommission() + OrderSwap();
   Comment(" \nForexHacked V2.5 Loaded Successfully™ ", 
      "\nAccount Leverage  :  " + "1 : " + AccountLeverage(), 
      "\nAccount Type  :  " + AccountServer(), 
      "\nServer Time  :  " + TimeToStr(TimeCurrent(), TIME_SECONDS), 
      "\nAccount Equity  = ", AccountEquity(), 
      "\nFree Margin     = ", AccountFreeMargin(), 
   "\nDrawdown  :  ", dbl2str_0, " \n" + Symbol(), " Earnings  :  " + gd_120);
}

int f0_0() {
   return (1);
}

double f0_1(int ai_0) {
   double ld_ret_4;
   if (ai_0 == 2) {
      ld_ret_4 = (AccountEquity() / AccountBalance() - 1.0) / (-0.01);
      if (ld_ret_4 <= 0.0) return (0);
      return (ld_ret_4);
   }
   if (ai_0 == 1) {
      ld_ret_4 = 100.0 * (AccountEquity() / AccountBalance() - 1.0);
      if (ld_ret_4 <= 0.0) return (0);
      return (ld_ret_4);
   }
   return (0.0);
}