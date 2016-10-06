//+------------------------------------------------------------------+
//|                      SteadyWinner V6.0a Small Account Version.mq4|
//|                                     Copyright 2014, QQ:125808047 |
//+------------------------------------------------------------------+
#property copyright "www.125808047.com"
#property link      "http://www.125808047.com/"

string gs_unused_76 = "SteadyWinner V6.0a";
int g_acc_number_84 = 0;
double gd_unused_88 = 0.0;
double gd_unused_96 = 60.0;
double gd_104 = 900.0;
double gd_112 = 4.0;
bool gi_120 = TRUE;
int gi_124 = 15;
int gi_128 = 15;
bool gi_132 = TRUE;
extern string NoteEA = "Magic No.& Comments, pls change it";
extern int MagicNo = 33338888;
extern string CommentTxt = "SW-V6";
double gd_156 = 50.0;
double gd_164 = 50.0;
double gd_172 = 25.0;
double gd_180 = 0.0;
double gd_188 = 0.0;
double g_lots_196 = 0.1;
double gd_204 = 0.0;
double gd_212 = 0.1;
double gd_220 = 0.1;
string g_text_228 = "SteadyWinner V6.0a Startup";
int g_color_236 = LightGreen;
double gd_240;
double gd_248;
double gd_256 = 0.0;
string gs_healthy_264 = "Healthy";
bool gi_272 = FALSE;
double g_order_profit_276 = 0.0;
bool gi_284 = FALSE;
double g_order_profit_288 = 0.0;
double gd_296 = 0.0;
double g_maxlot_304 = 0.0;
double g_lotstep_312 = 0.0;
double gd_320 = 0.0;
int g_slippage_328 = 3;
bool gi_332 = TRUE;
int gi_336 = 0;
int gi_340 = 23;
int gi_344 = -1;
bool gi_348 = TRUE;
string gs_352 = "alert.wav";
int g_color_360 = Blue;
int g_color_364 = Aqua;
int g_color_368 = Red;
int g_color_372 = Aqua;
string gs_unused_376 = "0";
string gs_dummy_384;


void init() {
   string ls_60;
   string ls_68;
   gd_296 = MarketInfo(Symbol(), MODE_MINLOT);
   g_maxlot_304 = MarketInfo(Symbol(), MODE_MAXLOT);
   g_lotstep_312 = MarketInfo(Symbol(), MODE_LOTSTEP);
   gd_188 = 0;
   gd_320 = f0_4(Symbol());
   f0_7();
   f0_2();
   f0_3();
   int li_0 = 20;
   int li_4 = 40;
   int li_8 = 60;
   int li_12 = 80;
   int li_16 = 100;
   int li_20 = 120;
   int li_24 = 140;
   int li_28 = 160;
   int li_32 = 180;
   int li_36 = 200;
   int li_40 = 220;
   int li_44 = 240;
   int li_48 = 10;
   int li_52 = 200;
   int li_56 = 380;
   f0_0("Title1", li_0 - 5, li_48, "SteadyWinner V6.0a Small a/c version - Place on EURUSD(H1) ", 13, 
"Verdana", MediumSeaGreen);
   f0_0("Title2", li_4, li_48, "http://www.125808047.com    ", 9, "Verdana", White);
   f0_0("Line1a", li_8, li_48, "---------------------------", 10, "Verdana", Goldenrod);
   f0_0("Line1b", li_8, li_52, "--- Key Settings ------------------------------", 10, "Verdana", Goldenrod);
   f0_0("txtRisk", li_12, li_48, "Trade Lot Risk%:  N/A", 9, "Verdana", Gold);
   f0_0("txtFix", li_12, li_52, "Trade Lot Fixed:   N/A", 9, "Verdana", Gold);
   f0_0("txtScale", li_12, li_56, "Test Lot Scale:  N/A", 9, "Verdana", Gold);
   f0_0("TxtMaxLot", li_16, li_48, "Min Lots:              " + DoubleToStr(gd_296, 2), 9, "Verdana", Gold);
   f0_0("TxtMinLot", li_16, li_52, "Lot Step:              " + DoubleToStr(g_lotstep_312, 2), 9, "Verdana", Gold);
   f0_0("TxtLotStep", li_16, li_56, "Max Lots:         " + DoubleToStr(g_maxlot_304, 2), 9, "Verdana", Gold);
   if (gi_120) ls_60 = "Trade after Friday " + DoubleToStr(gi_124, 0) + ":00:        TEST LOT ONLY";
   else ls_60 = "Trade after Friday " + DoubleToStr(gi_124, 0) + ":00:        NO";
   f0_0("TxtFri", li_20, li_48, ls_60, 9, "Verdana", Gold);
   f0_0("TxtPipStepping", li_20, li_56, "Pip Stepping:   NA", 9, "Verdana", Gold);
   if (gi_132) ls_68 = "Trade after December " + DoubleToStr(gi_128, 0) + "th:    TEST LOT ONLY";
   else ls_68 = "Trade after December " + DoubleToStr(gi_128, 0) + "th:    NO";
   f0_0("TxtDec", li_24, li_48, ls_68, 9, "Verdana", Gold);
   f0_0("TxtMaxSpread", li_24, li_56, "Max Spread:    " + DoubleToStr(gd_112, 1), 9, "Verdana", Gold);
   f0_0("Line2a", li_28, li_48, "---------------------------", 10, "Verdana", Goldenrod);
   f0_0("Line2b", li_28, li_52, "-- Operating Data -----------------------------", 10, "Verdana", Goldenrod);
   f0_0("TxtCurRisk", li_32, li_48, "-", 9, "Verdana", Silver);
   f0_0("TxtCurRskLvl", li_32, li_52, "-", 9, "Verdana", Silver);
   f0_0("txtCurSpread", li_32, li_56, "-", 9, "Verdana", Silver);
   f0_0("TxtCurBal", li_36, li_48, "-", 9, "Verdana", Silver);
   f0_0("TxtTradeLots", li_36, li_52, "-", 9, "Verdana", Silver);
   f0_0("TxtTestLots", li_36, li_56, "-", 9, "Verdana", Silver);
   f0_0("Line3a", li_40, li_48, "---------------------------", 10, "Verdana", Goldenrod);
   f0_0("Line3b", li_40, li_52, "---- EA Message ------------------------------", 10, "Verdana", Goldenrod);
   f0_0("TxtMM", li_44, li_48, g_text_228, 9, "Verdana", g_color_236);
}

// 52D46093050F38C27267BCE42543EF60
void deinit() {
   ObjectDelete("Title1");
   ObjectDelete("Title2");
   ObjectDelete("Line1a");
   ObjectDelete("Line1b");
   ObjectDelete("Line2a");
   ObjectDelete("Line2b");
   ObjectDelete("Line3a");
   ObjectDelete("Line3b");
   ObjectDelete("TxtRisk");
   ObjectDelete("TxtFix");
   ObjectDelete("TxtScale");
   ObjectDelete("TxtCurBal");
   ObjectDelete("TxtTradeLots");
   ObjectDelete("TxtTestLots");
   ObjectDelete("TxtMinLot");
   ObjectDelete("TxtLotStep");
   ObjectDelete("TxtMaxLot");
   ObjectDelete("TxtCurRisk");
   ObjectDelete("TxtCurRskLvl");
   ObjectDelete("TxtCurSpread");
   ObjectDelete("TxtMaxSpread");
   ObjectDelete("TxtFri");
   ObjectDelete("TxtPipStepping");
   ObjectDelete("TxtDec");
   ObjectDelete("TxtFXOpenECN");
   ObjectDelete("TxtMM");
}

// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   int is_closed_128;
   int is_closed_132;
   bool li_140;
   f0_3();
   ObjectSetText("TxtCurBal", "Acct Balance:      " + DoubleToStr(gd_240, 2), 9, "Verdana", Silver);
   ObjectSetText("TxtTradeLots", "Trade Lot Size:     " + DoubleToStr(gd_212, 2), 9, "Verdana", Silver);
   ObjectSetText("TxtTestLots", "Test Lot Size:    " + DoubleToStr(gd_220, 2), 9, "Verdana", Silver);
   ObjectSetText("TxtCurRisk", "Cur Risk%:          " + DoubleToStr(gd_256, 2), 9, "Verdana", Silver);
   ObjectSetText("TxtCurRskLvl", "Cur Risk Level:     " + gs_healthy_264, 9, "Verdana", Silver);
   ObjectSetText("TxtCurSpread", "Cur Spread:      " + DoubleToStr(gd_248, 1), 9, "Verdana", Silver);
   ObjectSetText("TxtMM", g_text_228, 9, "Verdana", g_color_236);
   if (gi_332) {
      if (!(Hour() >= gi_336 && Hour() <= gi_340)) {
         Comment("Time for trade has not come else!");
         return (0);
      }
   }
   if (Bars < 100) {
      Print("bars less than 100");
      return (0);
   }
   if (g_acc_number_84 > 0 && g_acc_number_84 != AccountNumber()) {
      Comment("Trade on account :" + AccountNumber() + " FORBIDDEN!");
      return (0);
   }
   double ima_0 = iMA(NULL, PERIOD_M15, 100, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_8 = iMA(NULL, PERIOD_M15, 200, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_16 = iMA(NULL, PERIOD_M15, 300, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_24 = iMA(NULL, PERIOD_M15, 400, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_32 = iMA(NULL, PERIOD_M15, 500, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_40 = iMA(NULL, PERIOD_M15, 600, 0, MODE_EMA, PRICE_CLOSE, 0);
   double iclose_48 = iClose(NULL, PERIOD_M1, 0);
   double ima_56 = iMA(NULL, PERIOD_M1, 700, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_64 = iMA(NULL, PERIOD_M5, 600, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_72 = iMA(NULL, PERIOD_M15, 500, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ima_80 = iMA(NULL, PERIOD_M30, 400, 0, MODE_EMA, PRICE_CLOSE, 0);
   double iwpr_88 = iWPR(NULL, PERIOD_H1, 5, 0);
   double imfi_96 = iMFI(NULL, PERIOD_M15, 1, 0);
   double idemarker_104 = iDeMarker(NULL, PERIOD_M15, 1, 0);
   bool bool_112 = FALSE;
   bool bool_116 = FALSE;
   bool bool_120 = FALSE;
   bool bool_124 = FALSE;
   f0_7();
   if (g_order_profit_276 > 0.0) {
      bool_112 = idemarker_104 < 0.01 && imfi_96 < 0.01 && iwpr_88 < -99.99 && ima_56 < iclose_48 && 
ima_64 < iclose_48 && ima_72 < iclose_48 && ima_80 < iclose_48 && ima_8 > ima_16 &&
         ima_16 > ima_24 && ima_24 > ima_32 && ima_32 > ima_40;
      bool_116 = idemarker_104 > 0.99 && imfi_96 > 99.9 && iwpr_88 > -0.01 && ima_56 > iclose_48 && 
ima_64 > iclose_48 && ima_72 > iclose_48 && ima_80 > iclose_48 && ima_8 < ima_16 &&
         ima_16 < ima_24 && ima_24 < ima_32 && ima_32 < ima_40;
   } else {
      bool_112 = OrderType() == OP_SELL && TimeCurrent() - OrderOpenTime() > gd_104 && (idemarker_104 < 0.01 && 
imfi_96 < 0.01 && iwpr_88 < -99.99);
      bool_116 = OrderType() == OP_BUY && TimeCurrent() - OrderOpenTime() > gd_104 && (idemarker_104 > 0.99 && 
imfi_96 > 99.9 && iwpr_88 > -0.01);
   }
   f0_2();
   if (g_order_profit_288 > 0.0) {
      bool_120 = idemarker_104 > 0.5 && imfi_96 > 50.0 && iwpr_88 > -50.0;
      bool_124 = idemarker_104 < 0.5 && imfi_96 < 50.0 && iwpr_88 < -50.0;
   } else {
      bool_120 = idemarker_104 > 0.99 && imfi_96 > 99.9 && iwpr_88 > -0.01;
      bool_124 = idemarker_104 < 0.01 && imfi_96 < 0.01 && iwpr_88 < -99.99;
   }
   if (!gi_284) {
      gi_344 = -1;
      if (bool_112) {
         f0_3();
         gi_344 = 0;
         gd_204 = 0;
         f0_6();
         return (0);
      }
      if (bool_116) {
         f0_3();
         gi_344 = 0;
         gd_204 = 0;
         f0_8();
         return (0);
      }
   }
   if (gi_284) {
      if (gi_344 < 1) {
      }
      if (OrderType() == OP_BUY) {
         if (bool_120) {
            is_closed_128 = OrderClose(OrderTicket(), OrderLots(), Bid, g_slippage_328, g_color_364);
            if (!(is_closed_128 && gi_348)) return (0);
            PlaySound(gs_352);
            return (0);
         }
      }
      if (OrderType() == OP_SELL) {
         if (bool_124) {
            is_closed_132 = OrderClose(OrderTicket(), OrderLots(), Ask, g_slippage_328, g_color_372);
            if (!(is_closed_132 && gi_348)) return (0);
            PlaySound(gs_352);
            return (0);
         }
      }
   }
   if (gd_172 > 0.0 || gd_172 > 0.0) {
      for (int pos_136 = 0; pos_136 < OrdersTotal(); pos_136++) {
         if (OrderSelect(pos_136, SELECT_BY_POS, MODE_TRADES)) {
            li_140 = TRUE;
            if (MagicNo > 0 && OrderMagicNumber() != MagicNo) li_140 = FALSE;
            if (OrderSymbol() == Symbol() && li_140) {
               if (OrderType() == OP_BUY && gd_172 > 0.0) {
                  if (Bid - OrderOpenPrice() > gd_172 * gd_320) {
                     if (OrderStopLoss() < Bid - (gd_172 + gd_204) * gd_320) {
                        if (gi_344 == 0) {
                           f0_1(Bid - NormalizeDouble((gd_172 - gd_180) * gd_320, 5));
                           gi_344 = 1;
                           gd_204 = gd_188;
                        } else f0_1(Bid - NormalizeDouble(gd_172 * gd_320, 5));
                     }
                  }
               }
               if (OrderType() == OP_SELL) {
                  if (OrderOpenPrice() - Ask > gd_172 * gd_320) {
                     if (OrderStopLoss() > Ask + (gd_172 + gd_204) * gd_320 || OrderStopLoss() == 0.0) {
                        if (gi_344 == 0) {
                           f0_1(Ask + NormalizeDouble((gd_172 - gd_180) * gd_320, 5));
                           gi_344 = 1;
                           gd_204 = gd_188;
                           continue;
                        }
                        f0_1(Ask + NormalizeDouble(gd_172 * gd_320, 5));
                     }
                  }
               }
            }
         }
      }
   }
   return (0);
}

int f0_2() {
   bool li_4;
   g_order_profit_288 = 0;
   gi_284 = FALSE;
   for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
      if (OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES)) {
         li_4 = TRUE;
         if (MagicNo > 0 && OrderMagicNumber() != MagicNo) li_4 = FALSE;
         if (OrderSymbol() == Symbol() && li_4) {
            g_order_profit_288 = OrderProfit();
            gi_284 = TRUE;
            return (1);
         }
      }
   }
   return (0);
}

int f0_7() {
   g_order_profit_276 = 0;
   gi_272 = FALSE;
   for (int pos_0 = OrdersHistoryTotal() - 1; pos_0 >= 0; pos_0--) {
      bool cg = OrderSelect(pos_0, SELECT_BY_POS, MODE_HISTORY);
      if (OrderMagicNumber() == MagicNo) {
         g_order_profit_276 = OrderProfit();
         pos_0 = 0;
         gi_272 = TRUE;
      }
   }
   return (0);
}

void f0_1(double ad_0) {
   bool bool_8 = OrderModify(OrderTicket(), NormalizeDouble(OrderOpenPrice(), 5), NormalizeDouble(ad_0, 5), 
NormalizeDouble(OrderTakeProfit(), 5), 0, CLR_NONE);
   if (bool_8 && gi_348) PlaySound(gs_352);
}

void f0_6() {
   double price_0;
   double price_8;
   int ticket_16;
   if (g_lots_196 != 0.0) {
      price_0 = 0;
      price_8 = 0;
      ticket_16 = OrderSend(Symbol(), OP_BUY, g_lots_196, Ask, g_slippage_328, 0, 0, CommentTxt, MagicNo, 0,
 g_color_360);
      if (ticket_16 > -1) {
         bool cg = OrderSelect(ticket_16, SELECT_BY_TICKET);
         if (gd_156 > 0.0) price_0 = NormalizeDouble(OrderOpenPrice() - gd_156 * gd_320, Digits);
         if (gd_164 > 0.0) price_8 = NormalizeDouble(OrderOpenPrice() + gd_164 * gd_320, Digits);
         cg = OrderModify(OrderTicket(), OrderOpenPrice(), price_0, price_8, 0, Green);
      }
      if (ticket_16 > -1 && gi_348) PlaySound(gs_352);
   }
}

void f0_8() {
   double price_0;
   double price_8;
   int ticket_16;
   if (g_lots_196 != 0.0) {
      price_0 = 0;
      price_8 = 0;
      ticket_16 = OrderSend(Symbol(), OP_SELL, g_lots_196, Bid, g_slippage_328, 0, 0, CommentTxt, MagicNo, 0, 
g_color_368);
      if (ticket_16 > -1) {
         bool cg = OrderSelect(ticket_16, SELECT_BY_TICKET);
         if (gd_156 > 0.0) price_0 = NormalizeDouble(OrderOpenPrice() + gd_156 * gd_320, Digits);
         if (gd_164 > 0.0) price_8 = NormalizeDouble(OrderOpenPrice() - gd_164 * gd_320, Digits);
         cg = OrderModify(OrderTicket(), OrderOpenPrice(), price_0, price_8, 0, Green);
      }
      if (ticket_16 > -1 && gi_348) PlaySound(gs_352);
   }
}

void f0_3() {
   gd_248 = f0_9(Symbol());
   gd_240 = AccountBalance();
   gd_212 = 2.0 * gd_296;
   gd_220 = gd_296;
   double ld_0 = gd_212 * (gd_156 * f0_5(Symbol())) / 0.02;
   gd_256 = 100.0 * (gd_156 * f0_5(Symbol()) * gd_212 / gd_240);
   if (gd_256 <= 2.0) gs_healthy_264 = "Healthy";
   else {
      if (gd_256 <= 5.0) gs_healthy_264 = "Medium";
      else {
         if (gd_256 <= 10.0) gs_healthy_264 = "High";
         else gs_healthy_264 = "Too High";
      }
   }
   if (gi_272) {
      if (g_order_profit_276 > 0.0) {
         g_text_228 = "Last order was a winner, SW will open Trade Lot order next";
         g_color_236 = LightGreen;
         g_lots_196 = gd_212;
      } else {
         g_text_228 = "Last order wasn`t a winner, SW will open Test Lot order next";
         g_color_236 = Pink;
         g_lots_196 = gd_220;
      }
   } else {
      g_text_228 = "Last order not found, SW will begin with a Test Lot order";
      g_color_236 = Silver;
      g_lots_196 = gd_220;
   }
   if (DayOfWeek() == 5 && Hour() > gi_124) {
      g_text_228 = "It\'s Friday after " + DoubleToStr(gi_124, 0) + ":00, ";
      g_color_236 = Silver;
      if (!gi_120) {
         g_lots_196 = 0;
         g_text_228 = g_text_228 + "SW will not open new order";
      } else {
         g_lots_196 = gd_220;
         g_text_228 = g_text_228 + "SW will open Test Lot order only";
      }
   }
   if (Month() == 12 && Day() > gi_128) {
      g_text_228 = "It\'s December after " + DoubleToStr(gi_128, 0) + "th, ";
      g_color_236 = Silver;
      if (!gi_132) {
         g_lots_196 = 0;
         g_text_228 = g_text_228 + "SW will not open new order";
      } else {
         g_lots_196 = gd_220;
         g_text_228 = g_text_228 + "SW will open new Test Lot orders only";
      }
   }
   if (gd_248 > gd_112) {
      g_text_228 = "Spread is too high, SW will not open new orders";
      g_color_236 = Silver;
      g_lots_196 = 0;
   }
   if (gs_healthy_264 == "High") {
      g_text_228 = "SW ALERT: CurRisk > 5%, pls bring Acct Balance above $" + DoubleToStr(ld_0, 0);
      g_color_236 = Pink;
   }
   if (gs_healthy_264 == "Too High") {
      g_text_228 = "SW STOPPED: CurRisk > 10%, Pls bring Acct balance above $" + DoubleToStr(ld_0, 0);
      g_color_236 = HotPink;
      g_lots_196 = 0;
   }
   if (gi_284) {
      g_text_228 = "SW IS TRADING: Pls leave it alone";
      g_color_236 = Yellow;
   }
}

double f0_4(string a_symbol_0) {
   int digits_16 = MarketInfo(a_symbol_0, MODE_DIGITS);
   double ld_ret_8 = 0.0001;
   if (digits_16 == 2 || digits_16 == 3) ld_ret_8 = 0.01;
   return (ld_ret_8);
}

double f0_5(string a_symbol_0) {
   double tickvalue_32 = MarketInfo(a_symbol_0, MODE_TICKVALUE);
   double ticksize_24 = MarketInfo(a_symbol_0, MODE_TICKSIZE);
   double ld_16 = f0_4(a_symbol_0);
   double ld_ret_8 = tickvalue_32 * (ld_16 / ticksize_24);
   return (ld_ret_8);
}

double f0_9(string a_symbol_0) {
   double ticksize_24 = MarketInfo(a_symbol_0, MODE_TICKSIZE);
   double ld_16 = f0_4(a_symbol_0);
   double ld_ret_8 = MarketInfo(a_symbol_0, MODE_SPREAD) * (ticksize_24 / ld_16);
   return (ld_ret_8);
}

void f0_0(string a_name_0, int a_y_8, int a_x_12, string a_text_16, int a_fontsize_24, string a_fontname_28, 
color a_color_36) {
   ObjectCreate(a_name_0, OBJ_LABEL, 0, 0, 0);
   ObjectSet(a_name_0, OBJPROP_CORNER, 0);
   ObjectSet(a_name_0, OBJPROP_XDISTANCE, a_x_12);
   ObjectSet(a_name_0, OBJPROP_YDISTANCE, a_y_8);
   ObjectSetText(a_name_0, a_text_16, a_fontsize_24, a_fontname_28, a_color_36);
}