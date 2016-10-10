#property copyright "Copyright © HELLTEAM^Pirat"
#property link      "http://www.fxmania.ru"

//+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
//+
//| 03/07/2011 ver. 3.8.5 Äîáàâëåíî îãðàíè÷åíèå íà îòêðûòèå òîëüêî îäíîãî îðäåðà âíóòðè ñâå÷è (â äàííîì ñëó÷àå ðàç â 15 ìèíóò), ñì. ôóíêöèþ OneOrderInBar è ïàðàìåòð OneOrderInBarMode.
//| Ïðîôèêñåí áàã ñ ïîñòîÿííî âûñêàêèâàþùèìè ñîîáùåíèÿìè î ïðåâûøåíèè ñïðåäà, òåïåðü ñîîáùåíèå áóäåò ïîÿâëÿòüñÿ, òîëüêî åñëè ïðè ïîïûòêå îòêðûòèÿ ñïðåä ïðåâûøåí.
//| Äîáàâëåíà ïðàâèëî, ïðè êîòîðîì ìîæåò ïðîèñõîäèòü îòêðûòèå ïðîòèâîïîëîæíûõ îðäåðîâ (íàïðèìåð íà ïàðàõ USDCAD è USDCHF ìîæåò îòêðûâàòüñÿ). Ðàíüøå ìîæíî áûëî îòêðûâàòü òîëüêî 1
//| îðäåð, ëèáî äëèííûé, ëèáî êîðîòêèé. Òåïåðü ïðè æåëàíèè ìîæíî îòêðûâàòüñÿ â îáå ñòîðîíû. Ñì. ïàðàìåòð No_Hedge_Trades.
//| Äîáàâëåíà äîïîëíèòåëüíàÿ ôóíêöèÿ ìîäèôèêàöèè (ñì. ôóíêöèþ ModifyOrder).
//|
//| 06/06/2011 ver. 3.8.4 Äîáàâëåíî ðûíî÷íîå èñïîëíåíèå (ñì. ïàðàìåòð IsMarketExecution), òî åñòü îðäåð îòêðûâàåòñÿ áåç sl è tp, à äàëåå ïðîèñõîäèò ìîäèôèêàöèÿ.
//| Íåîáõîäèìî äëÿ NDD ñ÷åòîâ. Òàêæå èçìåíåíà ôóíêöèÿ îòêðûòèÿ è çàêðûòèÿ îðäåðîâ, òåïåðü ïðè ðåêâîòàõ ñîâåòíèê ïîâòîðÿåò ïîïûòêè îòêðûòèÿ. ×èñëî ïîïûòîê ìîæíî çàäàòü â
//| ïàðàìåòðå RequoteAttempts.
//+
//+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
//| WallStreet Forex Robot ver. 3.8.5 FINAL (Pirate Edition)
//| 
//| Ðàáî÷èå ïàðû EURUSD, GBPUSD, USDCHF, USDJPY, USDCAD. Òàéìôðåéì M15. Äëÿ êàæäîé ïàðû íåîáõîäèìû ñâîè íàñòðîéêè.
//| Ïî óìîë÷àíèþ ýêñïåðò íàñòðîåí ïîä òîðãîâëþ íà ïàðå EURUSD M15. Äëÿ îñòàëüíûõ ïàð ïîäãðóæàéòå ôàéëû íàñòðîåê
//| .set èç ïàïêè sets.
//|
//| Äëÿ îïòèìèçàöèè èñïîëüçóéòå ôàéë for_optimisation_wsfr_3.8.5_final.set. Îïòèìèçàöèþ ìîæíî ïðîâîäèòü ïî
//| êîíòðîëüíûì òî÷êàì. Æåëàòåëüíî îïòèìèçèðîâàòü íà òèêîâûõ êîòèðîâêàõ (99% ìîäåëèðîâàíèå) ïî âñåì òèêàì.
//| Ñðåäíåå âðåìÿ îïòèìèçàöèè ïî âñåì òèêàì çàíèìàåò 10 äíåé. Ïî êîíòðîëüíûì òî÷êàì 1 ñóòêè.
//| Ðåêîìåíäóåìûé ïåðèîä îïòèìèçàöèè 1,5 ãîäà + 6 ìåñÿöåâ ôîðâàðä. Îïòèìèçàöèþ íåîáõîäèìî ïðîâîäèòü ðàç â êâàðòàë.
//| Òàêæå ìîæíî ñìåëî òîðãîâàòü íà ïàðå EURUSD m15 íà ñòàíäàðòíûõ "çàâîäñêèõ" íàñòðîéêàõ.
//|
//| Äàííûå äëÿ ñâÿçè:
//| 
//| e-mail: fxmania.ru@gmail.com
//| icq: 8-345-89-91
//| skype: fxmania.ru
//+--------------------------------------------------------------------------------------------------------------+

//+--------------------------------------------------------------------------------------------------------------+
//| Îñíîâíûå âõîäíûå ïàðàìåòðû. Òåéê-ïðîôèò, ñòîï-ëîññ, âûâîä â áåçóáûòîê è ðàçìåð ëîòà.
//+--------------------------------------------------------------------------------------------------------------+

extern string Name = "WallStreet Forex Robot ver. 3.8.5 FINAL (Pirate Edition)";
extern string Copy = "Copyright © HELLTEAM^Pirat";
extern string Op2 = "Îïòèìèçàöèÿ äëÿ ïàðû";
extern string Symbol_Op = "EURUSD m15";
extern string Op = "Äàòà îïòèìèçàöèè";
extern datetime Date = D'12.05.2011'; //--- Ñäåëàë ÷èñòî äëÿ ñåáÿ, ÷òîáû âèäåòü îò êàêîé äàòû îïòèìèçàöèÿ (äàòà çàáèâàåòñÿ âðó÷íóþ)
extern string _TP = "Îñíîâíûå âõîäíûå ïàðàìåòðû";
//---
extern int TakeProfit = 26; //--- (10 2 60)
extern int StopLoss = 120; //--- (100 10 200)
extern bool UseStopLevels = TRUE; //--- Âêëþ÷åíèå ñòîïîâûõ îðäåðîâ. Åñëè âûêëþ÷åíà, òî ðàáîòàþò òîëüêî âèðòóàëüíûå òåéêè è ëîññû.
extern bool IsMarketExecution = FALSE; //--- Âêëþ÷åíèå ðûíî÷íîãî èñïîëíåíèÿ îòêðûòèÿ îðäåðîâ (ñíà÷àëî îòêðûâàåò, çàòåì ìîäèôèöèðóåò)
//---
extern int SecureProfit = 1; //--- (0 1 5) Âûâîä â áåçóáûòîê
extern int SecureProfitTriger = 10; //--- (10 2 30)
extern int MaxLossPoints = -65; //--- (-200 5 -20) Ìàêñèìàëüíàÿ ïðîñàäêà äëÿ çàêðûòèÿ îðäåðîâ Buy è Sell ïðè èçìåíåíèè ñèãíàëà (Ïðè ïðîñàäêå ðàâíîé îò - MaxLossPoints èëè ìåíüøå (íàïðèìåð ïðèáûëü 0), îðäåð çàêðîåòñÿ)

extern string _MM = "Íàñòðîéêà MM";
//---
extern bool RecoveryMode = FALSE; //--- Âêëþ÷åíèå ðåæèìà âîññòàíîâëåíèÿ äåïîçèòà (óâåëè÷åíèå ëîòà åñëè ñëó÷èëñÿ ñòîï-ëîññ)
extern double FixedLot = 0.1; //--- Ôèêñèðîâàííûé îáú¸ì ëîòà
extern double AutoMM = 0.0; //--- ÌÌ âêëþ÷àåòñÿ åñëè AutoMM > 0. Ïðîöåíò ðèñêà. Ïðè RecoveryMode = FALSE, ìåíÿòü íóæíî òîëüêî ýòî çíà÷åíèå.
//--- Ïðè AutoMM = 20 è äåïîçèòå â 1000$, ëîò áóäåò ðàâåí 0,2. Äàëåå ëîò áóäåò óâåëè÷èâàòüñÿ èñõîäÿ èç ñâîáîäíûõ ñðåäñòâ, òî åñòü óæå ïðè äåïîçèòå â 2000$ ëîò áóäåò ðàâåí 0,4.
extern double AutoMM_Max = 20.0; //--- Ìàêñèìàëüíûé ðèñê
extern int MaxAnalizCount = 50; //--- ×èñëî çàêðûòûõ ðàíåå îðäåðîâ äëÿ àíàëèçà(Èñïîëüçóåòñÿ ïðè RecoveryMode = True)
extern double Risk = 25.0; //--- Ðèñê îò äåïîçèòà (Èñïîëüçóåòñÿ ïðè RecoveryMode = True)
extern double MultiLotPercent = 1.1; //--- Êîýôôèöèåíò óìíîæåíèå ëîòà (Èñïîëüçóåòñÿ ïðè RecoveryMode = True)

//+--------------------------------------------------------------------------------------------------------------+
//| Ïåðèîäû èíäèêàòîðîâ. Êîë-âî áàðîâ äëÿ êàæäîãî èíäèêàòîðà.
//+--------------------------------------------------------------------------------------------------------------+

extern string _Periods = "Ïåðèîäû èíäèêàòîðîâ";

//--- Ïåðèîäû èíäèêàòîðîâ (Òîæå ìîæíî áóäåò çàîïòèòü, òàê êàê äëÿ êàæäîé ïàðû ñâîè)
extern int iMA_Period = 75; //--- (60 5 100)
extern int iCCI_Period = 18; //--- (10 2 30)
extern int iATR_Period = 14; //--- (10 2 30) (!) Ìîæíî íå îïòèòü
extern int iWPR_Period = 11; //--- (10 1 20)

//+--------------------------------------------------------------------------------------------------------------+
//| Íàñòðîéêè èç DLL
//+--------------------------------------------------------------------------------------------------------------+
//| EURUSD     | GBPUSD     | USDCHF     | USDJPY     | USDCAD     |
//+----------------------------------------------------------------
//| TP=26;     | TP=50;     | TP=17;     | TP=27;     | TP=14;     |
//| SL=120;    | SL=120;    | SL=120;    | SL=130;    | SL=150;    |
//| SP=1;      | SP=2;      | SP=0;      | SP=2;      | SP=2;      |
//| SPT=10;    | SPT=24;    | SPT=15;    | SPT=14;    | SPT=10;    |
//| MLP=-65;   | MLP=-200;  | MLP=-40;   | MLP=-80;   | MLP=-30;   |
//+----------------------------------------------------------------
//| MA=75;     | MA=75;     | MA=70;     | MA=85;     | MA=65;     |
//| CCI=18;    | CCI=12;    | CCI=14;    | CCI=12;    | CCI=12;    |
//| ATR=14;    | ATR=14;    | ATR=14;    | ATR=14;    | ATR=14;    |
//| WPR=11;    | WPR=12;    | WPR=12;    | WPR=12;    | WPR=16;    |
//+----------------------------------------------------------------
//| FATR=6;    | FATR=6;    | FATR=3;    | FATR=0;    | FATR=4;    |
//| FCCI=150;  | FCCI=290;  | FCCI=170;  | FCCI=2000; | FCCI=130;  |
//+----------------------------------------------------------------
//| MAFOA=15;  | MAFOA=12;  | MAFOA=8;   | MAFOA=5;   | MAFOA=5;   |
//| MAFOB=39;  | MAFOB=33;  | MAFOB=25;  | MAFOB=21;  | MAFOB=15;  |
//| WPRFOA=-99;| WPRFOA=-99;| WPRFOA=-95;| WPRFOA=-99;| WPRFOA=-99;|
//| WPRFOB=-95;| WPRFOB=-94;| WPRFOB=-92;| WPRFOB=-95;| WPRFOB=-89;|
//+----------------------------------------------------------------
//| MAFC=14;   | MAFC=18;   | MAFC=11;   | MAFC=14;   | MAFC=14;   |
//| WPRFC=-19; | WPRFC=-19; | WPRFC=-22; | WPRFC=-27; | WPRFC=-6;  |
//+--------------------------------------------------------------------------------------------------------------+

//+--------------------------------------------------------------------------------------------------------------+
//| Ïàðàìåòðû îïòèìèçàöèè äëÿ ïðàâèë îòêðûòèÿ è çàêðûòèÿ ïîçèöèè.
//+--------------------------------------------------------------------------------------------------------------+
extern string _Add_Op = "Ðàñøèðåííûå ïàðàìåòðû îïòèìèçàöèè";
//---
extern string _AddOpenFilters = "---";
//---
extern int FilterATR = 6; //--- (0 1 10) Ïðîâåðêà íà âõîä ïî ATR äëÿ Buy è Sell (if (iATR_Signal <= FilterATR * pp) return (0);) (!) Ìîæíî íå îïòèòü
extern double iCCI_OpenFilter = 150; //--- (100 10 400) Ôèëüòð ïî iCCI äëÿ Buy è Sell. Ïðè îïòèìèçàöèè ïîä JPY ðåêîìåíäóåìî îïòèòü ïî ïðàâèëó (100 50 4000)
//---
extern string _OpenOrderFilters = "---";
//---
extern int iMA_Filter_Open_a = 15; //--- (4 2 20) Ôèëüòð ÌÀ äëÿ îòêðûòèÿ Buy è Sell (Ïóíòû)
extern int iMA_Filter_Open_b = 39; //--- (14 2 50) Ôèëüòð ÌÀ äëÿ îòêðûòèÿ Buy è Sell (Ïóíòû)
extern int iWPR_Filter_Open_a = -99; //--- (-100 1 0) Ôèëüòð WPR äëÿ îòêðûòèÿ Buy è Sell
extern int iWPR_Filter_Open_b = -95; //--- (-100 1 0) Ôèëüòð WPR äëÿ îòêðûòèÿ Buy è Sell
//---
extern string _CloseOrderFilters = "---";
//---
extern int Price_Filter_Close = 14; //--- (10 2 20) Ôèëüòð öåíû îòêðûòèÿ äëÿ çàêðûòèÿ Buy è Sell (Ïóíòû)
extern int iWPR_Filter_Close = -19; //--- (0 1 -100) Ôèëüòð WPR äëÿ çàêðûòèÿ Buy è Sell

//+--------------------------------------------------------------------------------------------------------------+
//| Ðàñøèðåííûå íàñòðîéêè
//+--------------------------------------------------------------------------------------------------------------+

extern string _Add = "Ðàñøèðåííûå íàñòðîéêè";
extern bool LongTrade = TRUE; //--- Âûêëþ÷àòåëü äëèííûõ ïîçèöèé
extern bool ShortTrade = TRUE; //--- Âûêëþ÷àòåëü êîðîòêèõ ïîçèöèé
extern bool No_Hedge_Trades = TRUE; //--- Îäíîâðåìåííîå îòêðûòèå îäíîãî Buy è îäíîãî Sell îðäåðà. Ïðè True íå õåäæèðóåò.
extern bool OneOrderInBarMode = TRUE; //--- Ïðè True ñîâåòíèê áóäåò îòêðûâàòü òîëüêî 1 îðäåð â 1 ñâå÷å. (Â äàííîì ñëó÷àå íå áîëåå ÷åì 1 ðàç â 15 ìèíóò). Â òåñòåðå íå ðàáîòàåò, òàê êàê çàìåäëÿåò åãî â 10 ðàç.
extern int MagicNumber = 777;
extern double MaxSpread = 2;
extern double OpenSlippage = 2; //--- Ïðîñêàëüçûâàíèå äëÿ îòêðûòèÿ îðäåðà
extern double CloseSlippage = 3; //--- Ïðîñêàëüçûâàíèå äëÿ çàêðûòèÿ îðäåðà
extern int RequoteAttempts = 3; //--- Ìàêñèìàëüíîå ÷èñëî ïîâòîðåíèé ïðè îòêðûòèè/çàêðûòèè îðäåðà ïðè ðåêâîòàõ è äðóãèõ îøèáêàõ
extern bool WriteLog = TRUE; //--- //--- Âêëþ÷åíèå âñïëûâàþùèõ îêîí â òåðìèíàëå.
extern bool WriteDebugLog = TRUE; //--- Âêëþ÷åíèå âñïëûâàþùèõ îêîí îá îøèáêàõ â òåðìèíàëå.
extern bool PrintLogOnChart = TRUE; //--- Âêëþ÷åíèå êîììåíòàðèåâ íà ãðàôèêå (ïðè òåñòèðîâàíèè âûêëþ÷àåòñÿ àâòîìàòè÷åñêè)

//+--------------------------------------------------------------------------------------------------------------+
//| Áëîê äîïîëíèòåëüíûõ ïåðåìåííûõ
//+--------------------------------------------------------------------------------------------------------------+

double pp;
int pd;
double cf;
string EASymbol; //--- Òåêóùèé ñèìâîë
int SP;
int CloseSP;
int MaximumTrades = 1;
double NDMaxSpread; //--- Ìàêñèìàëüíûé ñïðåä ââèäå ïóíêòîâ
bool CheckSpreadRuleBuy; //--- Ïðàâèëî äëÿ ïðîâåðêè ñïðåäà ïåðåä îòêðûòèåì (Îñòàíàâëèâàåò çàöèêëèâàíèå ñîîáùåíèé î ïðåâûøåííîì ñïðåäå)
bool CheckSpreadRuleSell;
string OpenOrderComment = "WSFR v3.8.5 FINAL";
int RandomOpenTimePercent = 0; //--- Èñïîëüçóåòñÿ ïðè çàíÿòîì ïîòîêå êîììàíä òåðìèíàëà, ñâîåáðàçíàÿ ðåíäîìíàÿ ïàóçà. Âûðàæàåòñÿ â ñåêóíäàõ.
//---

//--- Ïàðàìåòðû äëÿ àâòîëîòà
double MinLot = 0.01;
double MaxLot = 0.01;
double LotStep = 0.01;
int LotValue = 100000;
double FreeMargin = 1000.0;
double LotPrice = 1;
double LotSize;

//--- Ïàðàìåòðû íà îòêðûòèå

int iWPR_Filter_OpenLong_a;
int iWPR_Filter_OpenLong_b;
int iWPR_Filter_OpenShort_a;
int iWPR_Filter_OpenShort_b;

//--- Ïàðàìåòðû íà çàêðûòèå

int iWPR_Filter_CloseLong;
int iWPR_Filter_CloseShort;

//---
color OpenBuyColor = Blue;
color OpenSellColor = Red;
color CloseBuyColor = DodgerBlue;
color CloseSellColor = DeepPink;


//+--------------------------------------------------------------------------------------------------------------+
//| INIT. Èíèöèàëèçàöèÿ íåêîòîðûõ ïåðåìåííûõ, óäàëåíèå îáúåêòîâ íà ãðàôèêå.
//+--------------------------------------------------------------------------------------------------------------+
void init() {
//+--------------------------------------------------------------------------------------------------------------+

   //---
   if (IsTesting() && !IsVisualMode()) {PrintLogOnChart = FALSE; OneOrderInBarMode = FALSE;} //--- Åñëè òåñòèðóåì, òî îòêëþ÷àþòñÿ êîììåíòàðèè íà ãðàôèêå è ôóíêöèÿ OneOrderInBarMode
   if (!PrintLogOnChart) Comment("");
   //---
   EASymbol = Symbol(); //--- Èíèöèàëèçàöèÿ òåêóùåíî ñèìâîëà
   //---
   if (Digits < 4) {
      pp = 0.01;
      pd = 2;
      cf = 0.01;
   } else {
      pp = 0.0001;
      pd = 4;
      cf = 0.0001;
   }
   //---
   SP = OpenSlippage * MathPow(10, Digits - pd); //--- Ðàñ÷åò ïðîñêàëüçûâàíèÿ öåíû äëÿ ïÿòèçíàêà
   CloseSP = CloseSlippage * MathPow(10, Digits - pd);
   NDMaxSpread = NormalizeDouble(MaxSpread * pp, pd + 1); //--- Ïðåîáðàçîâàíèå çíà÷åíèÿ MaxSpread â ïóíêòû
   //---
   if (ObjectFind("BKGR") >= 0) ObjectDelete("BKGR");
   if (ObjectFind("BKGR2") >= 0) ObjectDelete("BKGR2");
   if (ObjectFind("BKGR3") >= 0) ObjectDelete("BKGR3");
   if (ObjectFind("BKGR4") >= 0) ObjectDelete("BKGR4");
   if (ObjectFind("LV") >= 0) ObjectDelete("LV");
   //---
   
   //--- Èíèöèàëèçàöèÿ ïàðàìåòðîâ äëÿ MM
   
   MinLot = MarketInfo(Symbol(), MODE_MINLOT);
   MaxLot = MarketInfo(Symbol(), MODE_MAXLOT);
   LotValue = MarketInfo(Symbol(), MODE_LOTSIZE);
   LotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   FreeMargin = MarketInfo(Symbol(), MODE_MARGINREQUIRED);
   
   //--- Ïîëó÷åíèå çíà÷åíèÿ ñòîèìîñòè ëîòà êîíêðåòíîãî ñèìâîëà èñõîäÿ èç ïàðàìòåðîâ âàøåãî áðîêåðà.
   double SymbolBid = 0;
   if (StringSubstr(AccountCurrency(), 0, 3) == "JPY") {
      SymbolBid = MarketInfo("USDJPY" + StringSubstr(Symbol(), 6), MODE_BID);
      if (SymbolBid > 0.1) LotPrice = SymbolBid;
      else LotPrice = 84;
   }
   //---
   if (StringSubstr(AccountCurrency(), 0, 3) == "GBP") {
      SymbolBid = MarketInfo("GBPUSD" + StringSubstr(Symbol(), 6), MODE_BID);
      if (SymbolBid > 0.1) LotPrice = 1 / SymbolBid;
      else LotPrice = 0.6211180124;
   }
   //---
   if (StringSubstr(AccountCurrency(), 0, 3) == "EUR") {
      SymbolBid = MarketInfo("EURUSD" + StringSubstr(Symbol(), 6), MODE_BID);
      if (SymbolBid > 0.1) LotPrice = 1 / SymbolBid;
      else LotPrice = 0.7042253521;
   }
   
   //--- Ïàðàìåòðû íà îòêðûòèå
   
   iWPR_Filter_OpenLong_a = iWPR_Filter_Open_a;
   iWPR_Filter_OpenLong_b = iWPR_Filter_Open_b;
   iWPR_Filter_OpenShort_a = -100 - iWPR_Filter_Open_a;
   iWPR_Filter_OpenShort_b = -100 - iWPR_Filter_Open_b;

   //--- Ïàðàìåòðû íà çàêðûòèå
   
   iWPR_Filter_CloseLong = iWPR_Filter_Close;
   iWPR_Filter_CloseShort = -100 - iWPR_Filter_Close;
   
   //---
   return (0);
   
}

//+--------------------------------------------------------------------------------------------------------------+
//| DEINIT. Óäàëåíèå îáúåêòîâ íà ãðàôèêå.
//+--------------------------------------------------------------------------------------------------------------+
int deinit() {
//+--------------------------------------------------------------------------------------------------------------+

   if (ObjectFind("BKGR") >= 0) ObjectDelete("BKGR");
   if (ObjectFind("BKGR2") >= 0) ObjectDelete("BKGR2");
   if (ObjectFind("BKGR3") >= 0) ObjectDelete("BKGR3");
   if (ObjectFind("BKGR4") >= 0) ObjectDelete("BKGR4");
   if (ObjectFind("LV") >= 0) ObjectDelete("LV");
   //---
   return (0);
   
}

//+--------------------------------------------------------------------------------------------------------------+
//| START. Ïðîâåðêà íà îøèáêè, à òàêæå ñòàðò ôóíêöèè Scalper.
//+--------------------------------------------------------------------------------------------------------------+
int start() {
//+--------------------------------------------------------------------------------------------------------------+
   
   if (PrintLogOnChart) ShowComments (); //--- Âêëþ÷åíèå êîììåíòàðèåâ íà ãðàôèêå
   //---
   CloseOrders(); //--- Ñîïðîâîæäåíèå îðäåðîâ
   ModifyOrders(); //--- Âûâîä â áåçóáûòîê
   
   //--- Èíèöèàëèçàöèÿ îáú¸ìà ñäåêè
   if (AutoMM > 0.0 && (!RecoveryMode)) LotSize = MathMax(MinLot, MathMin(MaxLot, MathCeil(MathMin(AutoMM_Max, AutoMM) / LotPrice / 100.0 * AccountFreeMargin() / LotStep / (LotValue / 100)) * LotStep));
   if (AutoMM > 0.0 && RecoveryMode) LotSize = CalcLots(); //--- Åñëè âêëþ÷åí RecoveryMode èñïîëüçóåì CalcLots
   if (AutoMM == 0.0) LotSize = FixedLot;
   
   //--- Ïðîâåðêà íàëè÷èÿ èñòîðè÷åñêèõ äàííûõ äëÿ òàéìôðåéìà M15
   if(iBars(Symbol(), PERIOD_M15) < iMA_Period || iBars(Symbol(), PERIOD_M15) < iWPR_Period || iBars(Symbol(), PERIOD_M15) < iATR_Period || iBars(Symbol(), PERIOD_M15) < iCCI_Period)
   {
      Print("Íåäîñòàòî÷íî èñòîðè÷åñêèõ äàííûõ äëÿ òîðãîâëè");
      return;
   }
   //---
   if (DayOfWeek() == 1 && iVolume(NULL, PERIOD_D1, 0) < 5.0) return (0);
   if (StringLen(EASymbol) < 6) return (0);   
   //---
   if ((!IsTesting()) && IsStopped()) return (0);
   if ((!IsTesting()) && !IsTradeAllowed()) return (0);
   if ((!IsTesting()) && IsTradeContextBusy()) return (0);
   //---
   HideTestIndicators(TRUE);
   //---
   Scalper();
   //---
   return (0);
}

//+--------------------------------------------------------------------------------------------------------------+
//| Scalper. Îñíîâíàÿ ôóíêöèÿ. Ñíà÷àëî ïðîèçâîäèòñÿ ïðîâåðêà ñïðåäà, äàëåå ïðîâåðêà ñèãíàëîâ íà âõîä.
//+--------------------------------------------------------------------------------------------------------------+
void Scalper() {
//+--------------------------------------------------------------------------------------------------------------+

   bool OpenBuyRule = TRUE;
   bool OpenSellRule = TRUE;
   
   //--- Ïðàâèëî äëÿ îòêðûòèÿ ïðîòèâîïîëîæíûõ îðäåðîâ.
   if (No_Hedge_Trades == TRUE && CheckOpenTrade(OP_SELL)) OpenBuyRule = FALSE;
   if (No_Hedge_Trades == TRUE && CheckOpenTrade(OP_BUY)) OpenSellRule = FALSE;
      
   //--- Ïðîâåðêà íà îòêðûòèå äëèííîãî îðäåðà
   if (OpenLongSignal() && !CheckOpenTrade(OP_BUY) && OpenBuyRule && OneOrderInBar(OP_BUY) && LongTrade) {
         
      //--- Ñîîáùåíèå î ïðåâûøåííîì ñïðåäå
      if (MaxSpreadFilter()) {
         if (!CheckSpreadRuleBuy && WriteDebugLog) {
         //---
         Print("Òîðãîâûé ñèãíàë íà ïîêóïêó ïðîïóùåí èç-çà áîëüøîãî ñïðåäà.");
         Print("Òåêóùèé ñïðåä = ", DoubleToStr((Ask - Bid) / pp, 1), ",  MaxSpread = ", DoubleToStr(MaxSpread, 1));
         Print("Ýêñïåðò WSFR 3.8.5 áóäåò ïðîáîâàòü ïîçæå, êîãäà ñïðåä ñòàíåò äîïóñòèìûì.");
         }
         //---
         CheckSpreadRuleBuy = TRUE;
      //---
      } else {
      //---
      CheckSpreadRuleBuy = FALSE;
      OpenPosition(OP_BUY);}
   }//--- Çàêðûòèå if (OpenLongSignal()
      
   //--- Ïðîâåðêà íà îòêðûòèå êîðîòêîãî îðäåðà   
   if (OpenShortSignal()&& !CheckOpenTrade(OP_SELL) && OpenSellRule && OneOrderInBar(OP_SELL) && ShortTrade) {
         
      //--- Ñîîáùåíèå î ïðåâûøåííîì ñïðåäå
      if (MaxSpreadFilter()) {
         if (!CheckSpreadRuleSell && WriteDebugLog) {
         //---
         Print("Òîðãîâûé ñèãíàë íà ïðîäàæó ïðîïóùåí èç-çà áîëüøîãî ñïðåäà.");
         Print("Òåêóùèé ñïðåä = ", DoubleToStr((Ask - Bid) / pp, 1), ",  MaxSpread = ", DoubleToStr(MaxSpread, 1));
         Print("Ýêñïåðò WSFR 3.8.5 áóäåò ïðîáîâàòü ïîçæå, êîãäà ñïðåä ñòàíåò äîïóñòèìûì.");
         }
         //---
         CheckSpreadRuleSell = TRUE;
      //---
      } else {
      //---
      CheckSpreadRuleSell = FALSE;
      OpenPosition(OP_SELL);}
   } //--- Çàêðûòèå  if (OpenShortSignal()
}

//+--------------------------------------------------------------------------------------------------------------+
//| OpenPosition. Ôóíêöèÿ îòêðûòèÿ ïîçèöèè.
//+--------------------------------------------------------------------------------------------------------------+
int OpenPosition(int OpType) {
//+--------------------------------------------------------------------------------------------------------------+

   int RandomOpenTime; //--- Çàäåðæêà ïî âðåìåíè íà îòêðûòèå
   color OpenColor; //--- Öâåò îòêðûòèÿ ïîçèöèè. Åñëè Buy òî ãîëóáàÿ, åñëè Sell òî êðàñíàÿ
   int OpenOrder = 0; //--- Îòêðûòèå ïîçèöèè
   int OpenOrderError; //--- Îøèáêà îòêðûòèÿ
   string OpTypeString; //--- Ïðåîáðàçîâàíèÿ âèäà ïîçèöèè â òåêñòîâîå çíà÷åíèå
   double OpenPrice; //--- Öåíà îòêðûòèÿ
   int    maxtry = RequoteAttempts;
   int    lasterror = 0;
   double price = 0;
   //---
   double TP, SL;
   double OrderTP = NormalizeDouble (TakeProfit * pp , pd); //--- Ïðåîáðàçóåì òåéê-ïðîôèò â âèä Points
   double OrderSL = NormalizeDouble (StopLoss * pp , pd); //--- Ïðåîáðàçóåì ñòîï-ëîññ â âèä Points
     
   //--- Çàäåðæêà â ñåêóíäàõ ìåæäó îòêðûòèÿìè
   if (RandomOpenTimePercent > 0) {
      MathSrand(TimeLocal());
      RandomOpenTime = MathRand() % RandomOpenTimePercent;
      
      if (WriteLog) {
      Print("DelayRandomiser: çàäåðæêà ", RandomOpenTime, " ñåêóíä.");
      }
      
      Sleep(1000 * RandomOpenTime);
   } //--- Çàêðûòèå if (RandomOpenTimePerc
   
   double OpenLotSize = LotSize; //--- Ðàñ÷åò îáú¸ìà ïîçèöèè
   
   //--- Åñëè íå õâàòåò ñðåäñòâ, âîçâðàùàåì îøèáêó
   if (AccountFreeMarginCheck(EASymbol, OpType, OpenLotSize) <= 0.0 || GetLastError() == 134/* NOT_ENOUGH_MONEY */) {
      //---
      if (WriteDebugLog) {
      //---
         Print("Äëÿ îòêðûòèÿ îðäåðà íåäîñòàòî÷íî ñâîáîäíîé ìàðæè.");
         Comment("Äëÿ îòêðûòèÿ îðäåðà íåäîñòàòî÷íî ñâîáîäíîé ìàðæè.");
      //---
      }
      return (-1);
   } //--- Çàêðûòèå if (AccountFreeMarginCheck  
   
   RefreshRates();
   
   //--- Åñëè äëèííàÿ ïîçèöèÿ, òî
   if (OpType == OP_BUY) {
      OpenPrice = NormalizeDouble(Ask, Digits);
      OpenColor = OpenBuyColor;
      
      //---
      if (UseStopLevels) { //--- Åñëè âêëþ÷åíû ñòîï-óðîâíè (ñòîï-ëîññ è òåéê-ïðîôèò)
      
      TP = NormalizeDouble(OpenPrice + OrderTP, Digits); //--- Òî ðàñ÷èòûâàåò òåéê-ïðîôèò
      SL = NormalizeDouble(OpenPrice - OrderSL, Digits); //--- è ñòîï-ëîññ
      //---
      } else {TP = 0; SL = 0;}
   
   //--- Åñëè êîðîòêàÿ ïîçèöèÿ, òî   
   } else {
      OpenPrice = NormalizeDouble(Bid, Digits);
      OpenColor = OpenSellColor;
      
      //---
      if (UseStopLevels) {
       
      TP = NormalizeDouble(OpenPrice - OrderTP, Digits);
      SL = NormalizeDouble(OpenPrice + OrderSL, Digits);
      }
      //---
      else {TP = 0; SL = 0;}
   }
   
//--- Åñëè òèï èñïîëíåíèÿ Market Execution (ðûíî÷íîå èñïîëíåíèå), òî ñíà÷àëî îòêðûâàåì îðäåð áåç sl è tp, à ïîñëå ìîäèôèöèðóåì åãî

if (IsMarketExecution && UseStopLevels)
   {
   OpenOrder = OrderSend(EASymbol, OpType, OpenLotSize, OpenPrice, SP, 0, 0, OpenOrderComment, MagicNumber, 0, OpenColor);
   if (OpenOrder > 0)
      {
      OrderModify(OpenOrder,OrderOpenPrice(),SL,TP,0);
      return(OpenOrder);
      }
   }
   
      //--- Åñëè æå íåò, òî ñðàçó îòêðûâàåì ñ sl è tp
      
      else
   {
   OpenOrder = OrderSend(EASymbol, OpType, OpenLotSize, OpenPrice, SP, SL, TP, OpenOrderComment, MagicNumber, 0, OpenColor);
   if (OpenOrder > 0) return(OpenOrder);
   }

//--- Åñëè òèï îðäåðà íå âåðåí, òî ïîâòîðÿåì îïåðàöèþ.

if ((OpType != OP_BUY) && (OpType != OP_SELL)) return(OpenOrder);

//--- Åñëè îðäåð îòêðûëñÿ óñïåøíî, òî îòïðàâëÿåì ñîîáùåíèå íà e-mail (åñëè âêëþ÷åíà îòïðàâêà)

if (OpenOrder < 0) { //--- Åñëè îðäåð íå îòêðûëñÿ, òî
   OpenOrderError = GetLastError(); //--- Âîçâðàùàåì îøèáêó
         //---
   if (WriteDebugLog) {
      if (OpType == OP_BUY) OpTypeString = "OP_BUY";
         else OpTypeString = "OP_SELL";
            Print("Îòêðûòèå: OrderSend(", OpTypeString, ") îøèáêà = ", ErrorDescription(OpenOrderError)); //--- Êîä îøèáêè íà Ðóññêîì
         } //--- Çàêðûòèå if (WriteDebugLog)
}

//--- Ïðè ðåêâîòàõ ïîâòîðÿåì îïåðàöèþ.

lasterror = GetLastError();

if ((OpenOrder < 0) && ((lasterror == 135) || (lasterror == 138) || (lasterror == 146)))
   {
   Print("Requote. Error" + lasterror + ". Ticket: " + OpenOrder);
   }
      else
   {
   return(OpenOrder);
   }

//--- Öèêë îòêðûòèÿ îðäåðà ïðè âîçíèêíîâåíèè îøèáîê (Ìàêñèìàëüíîå ÷èñëî ïîïûòîê îòêðûòèÿ ïðè âîçíèêíîâåíèè îøèáîê ðàâíî çíà÷åíèþ RequoteAttempts) 

price = OpenPrice;

for (int attempt = 1; attempt <= maxtry; attempt++)
   {
   RefreshRates();
   if (OpType == OP_BUY)
      {
      if (Ask <= price)
         {
         if (IsMarketExecution && UseStopLevels)
            {
            OpenOrder = OrderSend(EASymbol, OpType, OpenLotSize, NormalizeDouble(Ask,Digits), SP, 0, 0, OpenOrderComment, MagicNumber, 0, OpenColor);
            if (OpenOrder > 0)
               {
               OrderModify(OpenOrder,OrderOpenPrice(),SL,TP,0);
               return(OpenOrder);
               }
            }
               else
            {
            OpenOrder = OrderSend(EASymbol, OpType, OpenLotSize, NormalizeDouble(Ask,Digits), SP, SL, TP, OpenOrderComment, MagicNumber, 0, OpenColor);
            if (OpenOrder > 0) return(OpenOrder);
            }
         if ((GetLastError() != 135) && (GetLastError() != 138) && (GetLastError() != 146)) return(OpenOrder);
         Print("Requote. " + "Attempt " + (attempt + 1));
         continue;
         }
      }
   if (OpType == OP_SELL)
      {
      if (Bid >= price)
         {
         if (IsMarketExecution && UseStopLevels)
            {
            OpenOrder = OrderSend(EASymbol, OpType, OpenLotSize, NormalizeDouble(Bid,Digits), SP, 0, 0, OpenOrderComment, MagicNumber, 0, OpenColor);
            if (OpenOrder > 0)
               {
               OrderModify(OpenOrder,OrderOpenPrice(),SL,TP,0);
               return(OpenOrder);
               }
            }
               else
            {
            OpenOrder = OrderSend(EASymbol, OpType, OpenLotSize, NormalizeDouble(Bid,Digits), SP, SL, TP, OpenOrderComment, MagicNumber, 0, OpenColor);
            if (OpenOrder > 0) return(OpenOrder);
            }
         if ((GetLastError() != 135) && (GetLastError() != 138) && (GetLastError() != 146)) return(OpenOrder);
         Print("Requote. " + "Attempt " + (OpenOrder + 1));
         }
      }
   }

//---
return(-1);

}

//+--------------------------------------------------------------------------------------------------------------+
//| ModifyOrders. Ìîäèôèêàöèÿ îðäåðîâ â áåçóáûòîê.
//+--------------------------------------------------------------------------------------------------------------+
void ModifyOrders() {
//+--------------------------------------------------------------------------------------------------------------+

   int total = OrdersTotal() - 1;
   int ModifyError = GetLastError();
   
   //---
   for (int i = total; i >= 0; i--) { //--- Ñ÷åò÷èê îòêðûòûõ îðäåðîâ
      if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (WriteDebugLog) Print("Ïðîèçîøëà îøèáêà âî âðåìÿ âûáîðêè îðäåðà. Ïðè÷èíà: ", ErrorDescription(ModifyError));
      
      } else {
      
      //--- Ìîäèôèêàöèÿ îðäåðà íà ïîêóïêó
      if (OrderType() == OP_BUY) {
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == EASymbol) {
            if (Bid - OrderOpenPrice() > SecureProfitTriger * pp && MathAbs(OrderOpenPrice() + SecureProfit * pp - OrderStopLoss()) >= Point) {
               //--- Ìîäèôèöèðóåì îðäåð
               ModifyOrder(EASymbol, OrderOpenPrice(), NormalizeDouble(OrderOpenPrice() + SecureProfit * pp, Digits), OrderTakeProfit(), Blue);
               }
            }
         } //--- Çàêðûòèå if (OrderType() == OP_BUY)
      
      //--- Ìîäèôèêàöèÿ îðäåðà íà ïðîäàæó
      if (OrderType() == OP_SELL) {
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == EASymbol) {
            if (OrderOpenPrice() - Ask > SecureProfitTriger * pp && MathAbs(OrderOpenPrice() - SecureProfit * pp - OrderStopLoss()) >= Point) {
               //--- Ìîäèôèöèðóåì îðäåð
               ModifyOrder(EASymbol, OrderOpenPrice(), NormalizeDouble(OrderOpenPrice() - SecureProfit * pp, Digits), OrderTakeProfit(), Red);
               }
            }
         } //--- Çàêðûòèå if (OrderType() == OP_SELL)
      }
   } //--- Çàêðûòèå for (int i = total - 1; i >= 0; i--)
}

//+--------------------------------------------------------------------------------------------------------------+
//| ModifyOrder. Ìîäèôèêàöèÿ ïðåäâàðèòåëüíî âûáðàííîãî îðäåðà.
//|  
//| Ïàðàìåòðû:
//|   sy - íàèìåíîâàíèå èíñòðóìåíòà  ("" - òåêóùèé ñèìâîë)
//|   pp - öåíà îòêðûòèÿ ïîçèöèè, óñòàíîâêè îðäåðà
//|   sl - öåíîâîé óðîâåíü ñòîïà
//|   tp - öåíîâîé óðîâåíü òåéêà
//|   cl - öâåò
//+--------------------------------------------------------------------------------------------------------------+
void ModifyOrder(string sy="", double pp=-1, double sl=0, double tp=0, color cl=CLR_NONE) {
//+--------------------------------------------------------------------------------------------------------------+

   int ModifyTicketID = OrderTicket();
   
   if (sy=="") sy=Symbol();
   bool   fm; //--- Ìîäèôèêàöèÿ îðäåðà
   double pAsk=MarketInfo(sy, MODE_ASK);
   double pBid=MarketInfo(sy, MODE_BID);
   int    dg, err, it;
   int    PauseAfterError = 5; //--- Ïàóçà â ñåêóíäàõ ìåæäó ïîïûòêàìè ìîäèôèêàöèé
   int    NumberOfTry = 10; //--- Êîë-âî ïîïûòîê ìîäèôèêàöèé ïðè âîçíèêíîâåíèè îøèáîê
   
   //--- Ïðîâåðêà íà îøèáêè ïåðåìåííûõ 
   if (pp<=0) pp=OrderOpenPrice();
   if (sl<0) sl=OrderStopLoss();
   if (tp<0) tp=OrderTakeProfit();
   
   //--- Èíèöèàëèçàöèÿ ïàðàìåòðîâ 
   dg=MarketInfo(sy, MODE_DIGITS);
   pp=NormalizeDouble(pp, dg);
   sl=NormalizeDouble(sl, dg);
   tp=NormalizeDouble(tp, dg);
   
   //--- Äîïîëíèòåëüíàÿ ïðîâåðêà íà îøèáêè ïåðåìåííûõ, ïîñëå êîòîðîé
   if (pp!=OrderOpenPrice() || sl!=OrderStopLoss() || tp!=OrderTakeProfit()) {
      
      //--- Íà÷èíàåì öèêë ïîïûòîê ìîäèôèêàöèé
      for (it=1; it<=NumberOfTry; it++) {
         if (!IsTesting() && (!IsExpertEnabled() || IsStopped())) break;
         while (!IsTradeAllowed()) Sleep(5000);
         RefreshRates();
         
         //--- Ìîäèôèöèðóåì îðäåð
         fm=OrderModify(OrderTicket(), pp, sl, tp, 0, cl);
         
         //--- Åñëè ïðîèçîøëà îøèáêà, òî
         if (!fm) {
         err=GetLastError();
         
         //--- Âûäà¸ì îøèáêó, åñëè âêëþ÷åíî îòîáðàæåíèå îøèáîê
         if (WriteDebugLog) Print("Ïðîèçîøëà îøèáêà âî âðåìÿ ìîäèôèêàöèè îðäåðà (", GetNameOP(OrderType()), ",", ModifyTicketID, "). Ïðè÷èíà: ", ErrorDescription(err),". Ïîïûòêà ¹",it);
         
         //--- Æä¸ì PauseAfterError ñåêóíä, ïîñëå ÷åãî ïîâòîðÿåì ïîïûòêó ìîäèôèêàöèé
         Sleep(1000*PauseAfterError);
         
         } //--- Çàêðûòèå if (!fm) {
      }
   }
}

//+--------------------------------------------------------------------------------------------------------------+
//| CloseTrades. Âèðòóàëüíûé òåéê-ïðîôèò è ñòîï-ëîññ.
//| Åñëè âêëþ÷åíà ôóíêöèÿ UseStopLevels, òî èñïîëüçóåòñÿ êàê ôóíêöèÿ ðåçåðâíîãî çàêðûòèÿ.
//+--------------------------------------------------------------------------------------------------------------+
void CloseOrders() {
//+--------------------------------------------------------------------------------------------------------------+

   int total = OrdersTotal() - 1;
   int SelectCloseError = GetLastError();
   
   //---
   for (int i = total; i >= 0; i--) { //--- Ñ÷åò÷èê îòêðûòûõ îðäåðîâ
      if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (WriteDebugLog) Print("Ïðîèçîøëà îøèáêà âî âðåìÿ âûáîðêè îðäåðà. Ïðè÷èíà: ", ErrorDescription(SelectCloseError));
      
      } else {
      
      //--- Çàêðûòèå ïî ïðîôèòó èëè ëîññó îðäåðîâ íà ïîêóïêó
      if (OrderType() == OP_BUY) {
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == EASymbol) {
            if (Bid >= OrderOpenPrice() + TakeProfit * pp || Bid <= OrderOpenPrice() - StopLoss * pp || CloseLongSignal(OrderOpenPrice(), ExistPosition())) {
               //---
               CloseOrder(OrderTicket(),Bid);
               //---
            }
         }
      } //--- Çàêðûòèå if (OrderType() == OP_BUY)
      
      //--- Çàêðûòèå ïî ïðîôèòó èëè ëîññó îðäåðîâ íà ïðîäàæó
      if (OrderType() == OP_SELL) {
         if (OrderMagicNumber() == MagicNumber && OrderSymbol() == EASymbol) {
            if (Ask <= OrderOpenPrice() - TakeProfit * pp || Ask >= OrderOpenPrice() + StopLoss * pp || CloseShortSignal(OrderOpenPrice(), ExistPosition())) {
               //---
               CloseOrder(OrderTicket(),Ask);
               //---
               }
            }
         } //--- Çàêðûòèå if (OrderType() == OP_SELL)
      } 
   } //--- Çàêðûòèå for (int i = total - 1; i >= 0; i--) {
}

//+--------------------------------------------------------------------------------------------------------------+
//| CloseOrder. Ôóíêöèÿ çàêðûòèÿ îðäåðà.
//+--------------------------------------------------------------------------------------------------------------+
int CloseOrder(int ticket, double prce) {
//+--------------------------------------------------------------------------------------------------------------+

//--- Èíèöèàëèçàöèÿ ïåðåìåííûõ íåîáõîäèìûõ äëÿ ïîâòîðà îòêðûòèÿ ïðè ðåêâîòàõ èëè ïðîñòûõ îøèáêàõ.

double price;
int    slippage;
double p = prce;
int    maxtry = RequoteAttempts;
color  CloseColor;

OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES);

int ordtype = OrderType();
if (ordtype == OP_BUY) {price = NormalizeDouble(Bid,Digits); CloseColor = CloseBuyColor;}
if (ordtype == OP_SELL) {price = NormalizeDouble(Ask,Digits); CloseColor = CloseSellColor;}

if (MathAbs(OrderTakeProfit() - price) <= MarketInfo(Symbol(),MODE_FREEZELEVEL) * Point) return(0); //--- Ïðîâåðêà óðîâíåé çàìîðîçêè òåéê-ïðîôèòà
if (MathAbs(OrderStopLoss() - price) <= MarketInfo(Symbol(),MODE_FREEZELEVEL) * Point) return(0); //--- Ïðîâåðêà óðîâíåé çàìîðîçêè ñòîï-ëîññà

if (OrderClose(ticket,OrderLots(),price,CloseSlippage,CloseColor)) return(1); //--- Åñëè îðäåð îòêðûò óñïåøíî, òî âîçâðàùàåì 1)
if ((GetLastError() != 135) && (GetLastError() != 138) && (GetLastError() != 146)) return(0); //--- Åñëè íåò òî 0

Print("Requote");

//--- Öèêë çàêðûòèÿ îðäåðà ïðè âîçíèêíîâåíèè îøèáîê (Ìàêñèìàëüíîå ÷èñëî ïîïûòîê îòêðûòèÿ ïðè âîçíèêíîâåíèè îøèáîê ðàâíî çíà÷åíèþ RequoteAttempts) 

for (int attempt = 1; attempt <= maxtry; attempt++)
   {
   RefreshRates();
   if (ordtype == OP_BUY)
      {
      slippage = MathRound((Bid - p) / pp);
      if (Bid >= p)
         {
         Print("Closing order. Attempt " + (attempt + 1));
         if (OrderClose(ticket,OrderLots(),NormalizeDouble(Bid,Digits),slippage,CloseColor)) return(1);
         if (!((GetLastError() != 135) && (GetLastError() != 138) && (GetLastError() != 146))) continue;
         return(0);
         }
      }
   if (ordtype == OP_SELL)
      {
      slippage = MathRound((p - Ask) / pp);
      if (p >= Ask)
         {
         Print("Closing order. Attempt " + (attempt + 1));
         if (OrderClose(ticket,OrderLots(),NormalizeDouble(Ask,Digits),slippage,CloseColor)) return(1);
         if ((GetLastError() != 135) && (GetLastError() != 138) && (GetLastError() != 146)) return(0);
         }
      }
   }
}

//+--------------------------------------------------------------------------------------------------------------+
//| OpenLongSignal. Ñèãíàë íà îòêðûòèå äëèííîé ïîçèöèè.
//+--------------------------------------------------------------------------------------------------------------+
bool OpenLongSignal() {
//+--------------------------------------------------------------------------------------------------------------+

bool result = false;
bool result1 = false;
bool result2 = false;
bool result3 = false;

//--- Ðàñ÷åò îñíîâíûõ ñèãíàëîâ íà âõîä
double iClose_Signal = iClose(NULL, PERIOD_M15, 1);
double iMA_Signal = iMA(NULL, PERIOD_M15, iMA_Period, 0, MODE_SMMA, PRICE_CLOSE, 1);
double iWPR_Signal = iWPR(NULL, PERIOD_M15, iWPR_Period, 1);
double iATR_Signal = iATR(NULL, PERIOD_M15, iATR_Period, 1);
double iCCI_Signal = iCCI(NULL, PERIOD_M15, iCCI_Period, PRICE_TYPICAL, 1);
//---
double iMA_Filter_a = NormalizeDouble(iMA_Filter_Open_a*pp,pd);
double iMA_Filter_b = NormalizeDouble(iMA_Filter_Open_b*pp,pd);
double BidPrice = Bid; //--- (iClose_Signal >= BidPrice) Ñðàâíåíèå èä¸ò èìåííî ñ Bid (à íå ñ Ask, êàê äîëæíî áûòü), òàê êàê öåíà çàêðûòèÿ ñâå÷è iClose_Signal ôîðìèðóåòñÿ íà îñíîâàíèè çíà÷åíèÿ Bid
//---

//--- Ñâåðÿåì ñèãíàë ïî ÀÒÐ ñ åãî ôèëüòðîì
if (iATR_Signal <= FilterATR * pp) return (0);
//---
if (iClose_Signal - iMA_Signal > iMA_Filter_a && iClose_Signal - BidPrice >= - cf && iWPR_Filter_OpenLong_a > iWPR_Signal) result1 = true;
else result1 = false;
//---
if (iClose_Signal - iMA_Signal > iMA_Filter_b && iClose_Signal - BidPrice >= - cf && - iCCI_OpenFilter > iCCI_Signal) result2 = true;
else result2 = false;
//---
if (iClose_Signal - iMA_Signal > iMA_Filter_b && iClose_Signal - BidPrice >= - cf && iWPR_Filter_OpenLong_b > iWPR_Signal) result3 = true;
else result3 = false;
//---
if (result1 == true || result2 == true || result3 == true) result = true;
else result = false;
//---
return (result);

}

//+--------------------------------------------------------------------------------------------------------------+
//| OpenShortSignal. Ñèãíàë íà îòêðûòèå êîðîòêîé ïîçèöèè.
//+--------------------------------------------------------------------------------------------------------------+
bool OpenShortSignal() {
//+--------------------------------------------------------------------------------------------------------------+

bool result = false;
bool result1 = false;
bool result2 = false;
bool result3 = false;

//--- Ðàñ÷åò îñíîâíûõ ñèãíàëîâ íà âõîä
double iClose_Signal = iClose(NULL, PERIOD_M15, 1);
double iMA_Signal = iMA(NULL, PERIOD_M15, iMA_Period, 0, MODE_SMMA, PRICE_CLOSE, 1);
double iWPR_Signal = iWPR(NULL, PERIOD_M15, iWPR_Period, 1);
double iATR_Signal = iATR(NULL, PERIOD_M15, iATR_Period, 1);
double iCCI_Signal = iCCI(NULL, PERIOD_M15, iCCI_Period, PRICE_TYPICAL, 1);
//---
double iMA_Filter_a = NormalizeDouble(iMA_Filter_Open_a*pp,pd);
double iMA_Filter_b = NormalizeDouble(iMA_Filter_Open_b*pp,pd);
double BidPrice = Bid;
//---

//--- Ñâåðÿåì ñèãíàë ïî ÀÒÐ ñ åãî ôèëüòðîì
if (iATR_Signal <= FilterATR * pp) return (0);
//---
if (iMA_Signal - iClose_Signal > iMA_Filter_a && iClose_Signal - BidPrice <= cf && iWPR_Signal > iWPR_Filter_OpenShort_a) result1 = true;
else result1 = false;
//---
if (iMA_Signal - iClose_Signal > iMA_Filter_b && iClose_Signal - BidPrice <= cf && iCCI_Signal > iCCI_OpenFilter) result2 = true;
else result2 = false;
//---
if (iMA_Signal - iClose_Signal > iMA_Filter_b && iClose_Signal - BidPrice <= cf && iWPR_Signal > iWPR_Filter_OpenShort_b) result3 = true;
else result3 = false;
//---
if (result1 == true || result2 == true || result3 == true) result = true;
else result = false;
//---
return (result);

}

//+--------------------------------------------------------------------------------------------------------------+
//| CloseLongSignal. Ñèãíàë íà çàêðûòèå äëèííîé ïîçèöèè.
//+--------------------------------------------------------------------------------------------------------------+
bool CloseLongSignal(double OrderPrice, int CheckOrders) {
//+--------------------------------------------------------------------------------------------------------------+

bool result = false;
bool result1 = false;
bool result2 = false;
//---
double iWPR_Signal = iWPR(NULL, PERIOD_M15, iWPR_Period, 1);
double iClose_Signal = iClose(NULL, PERIOD_M15, 1);
double iOpen_CloseSignal = iOpen(NULL, PERIOD_M1, 1);
double iClose_CloseSignal = iClose(NULL, PERIOD_M1, 1);
//---
double MaxLoss = NormalizeDouble(-MaxLossPoints * pp,pd);
//---
double Price_Filter = NormalizeDouble(Price_Filter_Close*pp,pd);
double BidPrice = Bid;
//---

//---
if (OrderPrice - BidPrice <= MaxLoss && iClose_Signal - BidPrice <= cf && iWPR_Signal > iWPR_Filter_CloseLong && CheckOrders == 1) result1 = true;
else result1 = false;
//---
if (iOpen_CloseSignal > iClose_CloseSignal && BidPrice - OrderPrice >= Price_Filter && CheckOrders == 1) result2 = true;
else result2 = false;
//---
if (result1 == true || result2 == true) result = true;
else result = false;
//---
return (result);

}

//+--------------------------------------------------------------------------------------------------------------+
//| CloseShortSignal. Ñèãíàë íà çàêðûòèå êîðîòêîé ïîçèöèè.
//+--------------------------------------------------------------------------------------------------------------+
bool CloseShortSignal(double OrderPrice, int CheckOrders) {
//+--------------------------------------------------------------------------------------------------------------+

bool result = false;
bool result1 = false;
bool result2 = false;
//---
double iWPR_Signal = iWPR(NULL, PERIOD_M15, iWPR_Period, 1);
double iClose_Signal = iClose(NULL, PERIOD_M15, 1);
double iOpen_CloseSignal = iOpen(NULL, PERIOD_M1, 1);
double iClose_CloseSignal = iClose(NULL, PERIOD_M1, 1);
//---
double MaxLoss = NormalizeDouble(-MaxLossPoints*pp,pd);
//---
double Price_Filter = NormalizeDouble(Price_Filter_Close*pp,pd);
double BidPrice = Bid;
double AskPrice = Ask;
//---

//---
if (AskPrice - OrderPrice <= MaxLoss && iClose_Signal - BidPrice >= - cf && iWPR_Signal < iWPR_Filter_CloseShort && CheckOrders == 1) result1 = true;
else result1 = false;
//---
if (iOpen_CloseSignal < iClose_CloseSignal && OrderPrice - AskPrice >= Price_Filter && CheckOrders == 1) result2 = true;
else result2 = false;
//---
if (result1 == true || result2 == true) result = true;
else result = false;
//---
return (result);

}

//+--------------------------------------------------------------------------------------------------------------+
//| CalcLots. Ôóíêöèÿ ðàñ÷åòà îáüåìà ëîòà.
//| Ïðè AutoMM > 0.0 && RecoveryMode ôóíêöèÿ CalcLots ðàñ÷èòûâàåò îáú¸ì ëîòà îòíîñèòåëüíî ñâîáîäíûõ ñðåäñòâ.
//| 
//| Òàêæå ðàñ÷åò ëîòà ïðîèçâîäèòüñÿ èñõîäÿ èç ÷èñëà îòêðûòûõ â ïðîøëîì îðäåðîâ. Òî åñòü óâåëè÷åíèå ëîòà òåïåðü
//| çàâèñèò íå òîëüêî îò ñâîáîäíûõ ñðåäñòâ, íî è îò ÷èñëà îòêðûòûõ â ïðîøëîì ñîâåòíèêîì îðäåðîâ.
//| 
//| Ïîìèìî ïðîñòîãî ÌÌ, ôóíêöèÿ ðàññ÷èòûâàåò ëîò èñõîäÿ èç ïðîèçîøåäøèõ ðàíåå ñòîï-ëîññîâ ïðè âêëþ÷åííîì
//| ïàðàìåòðå RecoveryMode, òî åñòü, ïðè æåëàíèè ìîæíî âêëþ÷èòü ðåæèì âîññòàíîâëåíèÿ äåïîçèòà.
//+--------------------------------------------------------------------------------------------------------------+
double CalcLots() {
//+--------------------------------------------------------------------------------------------------------------+

   double SumProfit; //--- Ñóììàðíûé ïðîôèò
   int OldOrdersCount; //--- Òåêóùåå êîë-âî çàêðûòûõ ñîâåòíèêîì îðäåðîâ
   double loss; //--- Ïðîñàäêà
   int LossOrdersCount; //--- ×èñëî ëîñåé â ïðîøëîì
   double pr; //--- Ïðîôèò
   int ProfitOrdersCount; //--- Êîë-âî ïðèáûëüíûõ îðäåðîâ û ïðîøëîì
   double LastPr; //--- Ïðåäûäóùåå çíà÷åíèå ïðîôèò
   int LastCount; //--- Ïðåäûäóùåå çíà÷åíèå ñ÷åò÷èêà îðäåðîâ
   double MultiLot = 1; //---  Îáíóëåíèå çíà÷åíèÿ óìíîæåíèÿ ëîòà
   //---
   
   //--- Åñëè ÌÌ âêëþ÷åí, òî
   if (MultiLotPercent > 0.0 && AutoMM > 0.0) {
      
      //--- Îáíóëÿåì çíà÷åíèÿ
      SumProfit = 0;
      OldOrdersCount = 0;
      loss = 0;
      LossOrdersCount = 0;
      pr = 0;
      ProfitOrdersCount = 0;
      //---
      
      //--- Âûáèðàåì çàêðûòèå ðàíåå îðäåðà
      for (int i = OrdersHistoryTotal() - 1; i >= 0; i--) {
         if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
               OldOrdersCount++; //--- Ñ÷èòàåì îðäåðà
               SumProfit += OrderProfit(); //--- è ñóììàðíûé ïðîôèò
               
               //--- Åñëè ñóììàðíûé ïðîôèò áîëüøå pr (äëÿ íà÷àëà áîëüøå 0)
               if (SumProfit > pr) {
                  //--- Èíèöèàëèçèðóåì ïðîôèò è ñ÷åò÷èê ïðèáûëüíûõ îðäåðîâ
                  pr = SumProfit;
                  ProfitOrdersCount = OldOrdersCount;
               }
               //--- Åñëè ñóììàðíûé ïðîôèò ìåíüøå loss (äëÿ íà÷àëà áîëüøå 0)
               if (SumProfit < loss) {
                  //--- Èíèöèàëèçèðóåì ïðîñàäêó è ñ÷åò÷èê óáûòî÷íûõ îðäåðîâ
                  loss = SumProfit;
                  LossOrdersCount = OldOrdersCount;
               }
               //--- Åñëè òåêóùåå êîë-âî ïîäñ÷èòàííûõ îðäåðîâ áîëüøå èëè ðàâíî MaxAnalizCount (50), òî â áóäóùåì ñ÷èòàåì òîëüêî ñâåæåíüêèå îðäåðà à ñòàðûå âû÷èòàåì.
               if (OldOrdersCount >= MaxAnalizCount) break;
            }
         }
      } //--- Çàêðûòèå for (int i = OrdersHistoryTotal() - 1; i >= 0; i--) {
      
      
      //--- Åñëè ÷èñëî ïðèáûëüíûõ îðäåðîâ ìåíüøå èëè ðàâíî ÷èñëó ëîñåé, òî ðàñ÷èòûâàåì çíà÷åíèå óìíîæåíèÿ ëîòà MultiLot
      if (ProfitOrdersCount <= LossOrdersCount) MultiLot = MathPow(MultiLotPercent, LossOrdersCount);
      
      //--- Åñëè íåò, òî
      else {
         
         //--- Èíèöèàëèçèðóåì ïàðàìåòðû ïî ïðîôèòó
         SumProfit = pr;
         OldOrdersCount = ProfitOrdersCount;
         LastPr = pr;
         LastCount = ProfitOrdersCount;
         
         //--- Âûáèðàåì çàêðûòèå ðàíåå îðäåðà (ìèíóñ ÷èñëî ïðèáûëüíûõ îðäåðîâ)
         for (i = OrdersHistoryTotal() - ProfitOrdersCount - 1; i >= 0; i--) {
            if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) {
               if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
                  //--- Åñëè âûáðàíî áîëåå 50 îðäåðîâ ïðåêðàçùàåì âûáèðàòü
                  if (OldOrdersCount >= MaxAnalizCount) break;
                  //---
                  OldOrdersCount++; //--- Ñ÷èòàåì êîë-âî îðäåðîâ
                  SumProfit += OrderProfit(); //--- è ïðîôèò
                  
                  //--- Åñëè íîâûé ïðîôèò ìåíüøå ïðåäûäóùåãî (LastPr), òî
                  if (SumProfit < LastPr) {
                     //--- Ïåðåèíèöèàëèçèðóåì çíà÷åíèÿ ïðîôèòà è êîë-âî îðäåðîâ
                     LastPr = SumProfit;
                     LastCount = OldOrdersCount;
                  }
               }
            }
         } //--- Çàêðûòèå for (i = OrdersHistoryTotal() - ProfitOrdersCount - 1; i >= 0; i--) {
         
         //--- Åñëè çíà÷åíèå ñ÷åò÷èêà LastCount ðàâíî ñ÷åò÷èêó ïðèáûëüíûõ îðäåðîâ èëè ïðîøëûé ïðîôèò ðàâåí òåêùåìó, òî
         if (LastCount == ProfitOrdersCount || LastPr == pr) MultiLot = MathPow(MultiLotPercent, LossOrdersCount); //--- ðàñ÷èòûâàåì çíà÷åíèå óìíîæåíèÿ ëîòà MultiLot
         
         //--- Åñëè íåò, òî
         else {
            //--- Äåëèì ïîëîæèòåëüíûé (loss - pr) íà ïîëîæèòåëüíûé (LastPr - pr) è ñðàâíèâàåì ñ ðèñêîì, ïîñëå ðàñ÷èòûâàåì óìíîæåíèå ëîòà MultiLot
            if (MathAbs(loss - pr) / MathAbs(LastPr - pr) >= (Risk + 100.0) / 100.0) MultiLot = MathPow(MultiLotPercent, LossOrdersCount);
            else MultiLot = MathPow(MultiLotPercent, LastCount);
         }
      }
   } //--- Çàêðûòèå if (MultiLotPercent > 0.0 && AutoMM > 0.0) {
   
   //--- Ïîëó÷àåì ôèíàëüíûé îáú¸ì ëîòà, èñõîäÿ èç âûïîëíåííûõ âûøå äåéñòâèé
   for (double OpLot = MathMax(MinLot, MathMin(MaxLot, MathCeil(MathMin(AutoMM_Max, MultiLot * AutoMM) / 100.0 * AccountFreeMargin() / LotStep / (LotValue / 100)) * LotStep)); OpLot >= 2.0 * MinLot &&
      1.05 * (OpLot * FreeMargin) >= AccountFreeMargin(); OpLot -= MinLot) {
   }
   return (OpLot);
}

//+--------------------------------------------------------------------------------------------------------------+
//| MaxSpreadFilter. Ôóíêöèÿ äëÿ ðàñ÷åòà ðàçìåðà ñïðåäà è ñðàâíåíèÿ åãî ñî çíà÷åíèåì MaxSpread.
//| Åñëè òåêóùèé ñïðåä ïðåâûøåí, òî âîçâðàùàåì TRUE.
//+--------------------------------------------------------------------------------------------------------------+
bool MaxSpreadFilter() {
//+--------------------------------------------------------------------------------------------------------------+

   RefreshRates();
   if (NormalizeDouble(Ask - Bid, Digits) > NDMaxSpread) return (TRUE);
   //---
   else return (FALSE);
}

//+--------------------------------------------------------------------------------------------------------------+
//| ExistPosition. Ôóíêöèÿ ïðîâåðêè îòêðûòûõ îðäåðîâ.
//| Åñëè îòêðûò îðäåð âîçâðàùàåò True, åñëè íåò, äàåò ðàçðåøåíèå (False, 0) íà îòêðûòèå.
//+--------------------------------------------------------------------------------------------------------------+
int ExistPosition() {
//+--------------------------------------------------------------------------------------------------------------+

   int trade = OrdersTotal() - 1;
   for (int i = trade; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderMagicNumber() == MagicNumber) {
            if (OrderSymbol() == EASymbol)
               if (OrderType() <= OP_SELL) return (1);
         }
      }
   }
   //---
   return (0);
}

//+--------------------------------------------------------------------------------------------------------------+
//| OneOrderInBar. Ôóíêöèÿ ïðîâåðÿåò, îòêðûâàëñÿ ëè îðäåð âíóòðè íóëåâîé ñâå÷è.
//+--------------------------------------------------------------------------------------------------------------+
bool OneOrderInBar(int OpType = -1){
//+--------------------------------------------------------------------------------------------------------------+
   
   //--- Åñëè îòêëþ÷åíà ôóíêöèÿ, òî íè÷åãî íå ðàñ÷èòûâàåì.
   if (OneOrderInBarMode == FALSE) return(True);
   
   int Bar = Period(); //--- Ñâå÷à
   
   //--- Äåëàåì âûáîðêó ïî çàêðûòûì îðäåðàì
   for(int i = OrdersHistoryTotal(); i>=0; i--){
      //---
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)){
         //---
         if(OrderSymbol() == EASymbol && OrderType() == OpType && OrderMagicNumber() == MagicNumber) {
            
            //--- Åñëè âðåìÿ çàêðûòèÿ îðäåðà áîëüøå âðåìåíè îòêðûòèÿ íóëåâîãî áàðà, òî çàïðåùàåì îòêðûòèå íîâîãî îðäåðà.
            if(OrderCloseTime()>iTime(EASymbol,Bar,0)) return(False);
            }
         }
      }

   //---
   return(True);
}

//+--------------------------------------------------------------------------------------------------------------+
//| CheckOpenTrade. Ôóíêöèÿ äëÿ ïðîâåðêè îòêðûòîãî îðäåðà. Ïðîâåðÿåò áûë ëè îòêðûò îðäåð ïî OrderType.
//| Åñëè áûë îòêðûò, òî âîçâðàùàåò TRUE, åñëè íåò, òî FALSE.
//+--------------------------------------------------------------------------------------------------------------+
bool CheckOpenTrade(int OpType) {
//+--------------------------------------------------------------------------------------------------------------+
   
   int total = OrdersTotal();
   for (int i = total - 1; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS) == TRUE)
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber && OrderType() == OpType) return (TRUE);
   }
   //---
   return (FALSE);
}

//+--------------------------------------------------------------------------------------------------------------+
//| ShowComments. Ôóíêöèÿ äëÿ îòîáðàæåíèÿ êîììåíòàðèåâ íà ãðàôèêå.
//+--------------------------------------------------------------------------------------------------------------+
void ShowComments() {
//+--------------------------------------------------------------------------------------------------------------+

string ComSpacer = ""; //--- "/n"
datetime MyOpDate = TIME_DATE; //--- Âûâîä â êîììåíòàðèé äàòû îïòèìèçàöèè (ôîðìàò)
//---
ComSpacer = ComSpacer
      + "\n  " 
      + "\n "
      + "\n  Version 3.8.5 (FINAL)"
      + "\n  Copyright © HELLTEAM^Pirat"
      + "\n  http://www.fxmania.ru"
      + "\n -----------------------------------------------"
      + "\n  Sets for: " + Symbol_Op
      + "\n  Optimization date: " + TimeToStr (Date, MyOpDate)
      + "\n -----------------------------------------------" 
      + "\n  SL = " + StopLoss + " pips / TP = " + TakeProfit + " pips" 
   + "\n  Spread = " + DoubleToStr((Ask - Bid) / pp, 1) + " pips";
   if (NormalizeDouble(Ask - Bid, Digits) > NDMaxSpread) ComSpacer = ComSpacer + " - TOO HIGH";
   else ComSpacer = ComSpacer + " - NORMAL";
   ComSpacer = ComSpacer 
   + "\n -----------------------------------------------";
   if (AutoMM > 0.0) {
      ComSpacer = ComSpacer 
         + "\n  AutoMM - ENABLED" 
      + "\n  Risk = " + DoubleToStr(AutoMM, 1) + "%";
   }
   ComSpacer = ComSpacer 
   + "\n  Trading Lots = " + DoubleToStr(LotSize, 2);
   ComSpacer = ComSpacer 
   + "\n -----------------------------------------------";
   if (UseStopLevels) {
      ComSpacer = ComSpacer 
      + "\n  Stop Levels - ENABLED";
   } else {
      ComSpacer = ComSpacer 
      + "\n  Stop Levels - DISABLED";
   }
      if (RecoveryMode) {
      ComSpacer = ComSpacer 
      + "\n  Recovery Mode - ENABLED";
   } else {
      ComSpacer = ComSpacer 
      + "\n  Recovery Mode - DISABLED";
   }
   ComSpacer = ComSpacer 
   + "\n -----------------------------------------------";
   Comment(ComSpacer);
   
   if (ObjectFind("LV") < 0) {
      ObjectCreate("LV", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("LV", "WALL STREET ROBOT", 9, "Tahoma Bold", White);
      ObjectSet("LV", OBJPROP_CORNER, 0);
      ObjectSet("LV", OBJPROP_BACK, FALSE);
      ObjectSet("LV", OBJPROP_XDISTANCE, 13);
      ObjectSet("LV", OBJPROP_YDISTANCE, 23);
   }
   if (ObjectFind("BKGR") < 0) {
      ObjectCreate("BKGR", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("BKGR", "g", 110, "Webdings", DarkViolet  );
      ObjectSet("BKGR", OBJPROP_CORNER, 0);
      ObjectSet("BKGR", OBJPROP_BACK, TRUE);
      ObjectSet("BKGR", OBJPROP_XDISTANCE, 5);
      ObjectSet("BKGR", OBJPROP_YDISTANCE, 15);
   }
   if (ObjectFind("BKGR2") < 0) {
      ObjectCreate("BKGR2", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("BKGR2", "g", 110, "Webdings", MidnightBlue);
      ObjectSet("BKGR2", OBJPROP_BACK, TRUE);
      ObjectSet("BKGR2", OBJPROP_XDISTANCE, 5);
      ObjectSet("BKGR2", OBJPROP_YDISTANCE, 60);
   }
   if (ObjectFind("BKGR3") < 0) {
      ObjectCreate("BKGR3", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("BKGR3", "g", 110, "Webdings", MidnightBlue);
      ObjectSet("BKGR3", OBJPROP_CORNER, 0);
      ObjectSet("BKGR3", OBJPROP_BACK, TRUE);
      ObjectSet("BKGR3", OBJPROP_XDISTANCE, 5);
      ObjectSet("BKGR3", OBJPROP_YDISTANCE, 45);
   }
   if (ObjectFind("BKGR4") < 0) {
      ObjectCreate("BKGR4", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("BKGR4", "g", 110, "Webdings", MidnightBlue);
      ObjectSet("BKGR4", OBJPROP_CORNER, 0);
      ObjectSet("BKGR4", OBJPROP_BACK, TRUE);
      ObjectSet("BKGR4", OBJPROP_XDISTANCE, 5);
      ObjectSet("BKGR4", OBJPROP_YDISTANCE, 84);
   }
}

//+--------------------------------------------------------------------------------------------------------------+
//| GetNameOP. Ôóíêöèé âîçâðàùàåò íàèìåíîâàíèå òîðãîâîé îïåðàöèè
//| Ïàðàìåòðû:
//|   op - èäåíòèôèêàòîð òîðãîâîé îïåðàöèè
//+--------------------------------------------------------------------------------------------------------------+
string GetNameOP(int op) {
//+--------------------------------------------------------------------------------------------------------------+

  switch (op) {
    case OP_BUY      : return("Buy");
    case OP_SELL     : return("Sell");
    case OP_BUYLIMIT : return("Buy Limit");
    case OP_SELLLIMIT: return("Sell Limit");
    case OP_BUYSTOP  : return("Buy Stop");
    case OP_SELLSTOP : return("Sell Stop");
    default          : return("Unknown Operation");
  }
}

//+--------------------------------------------------------------------------------------------------------------+
//| ErrorDescription. Âîçâðàùàåò îïèñàíèå îøèáêè ïî å¸ íîìåðó.
//+--------------------------------------------------------------------------------------------------------------+
string ErrorDescription(int error) {
//+--------------------------------------------------------------------------------------------------------------+

   string ErrorNumber;
   //---
   switch (error) {
   case 0:
   case 1:     ErrorNumber = "Íåò îøèáêè, íî ðåçóëüòàò íåèçâåñòåí";                        break;
   case 2:     ErrorNumber = "Îáùàÿ îøèáêà";                                               break;
   case 3:     ErrorNumber = "Íåïðàâèëüíûå ïàðàìåòðû";                                     break;
   case 4:     ErrorNumber = "Òîðãîâûé ñåðâåð çàíÿò";                                      break;
   case 5:     ErrorNumber = "Ñòàðàÿ âåðñèÿ êëèåíòñêîãî òåðìèíàëà";                        break;
   case 6:     ErrorNumber = "Íåò ñâÿçè ñ òîðãîâûì ñåðâåðîì";                              break;
   case 7:     ErrorNumber = "Íåäîñòàòî÷íî ïðàâ";                                          break;
   case 8:     ErrorNumber = "Ñëèøêîì ÷àñòûå çàïðîñû";                                     break;
   case 9:     ErrorNumber = "Íåäîïóñòèìàÿ îïåðàöèÿ íàðóøàþùàÿ ôóíêöèîíèðîâàíèå ñåðâåðà";  break;
   case 64:    ErrorNumber = "Ñ÷åò çàáëîêèðîâàí";                                          break;
   case 65:    ErrorNumber = "Íåïðàâèëüíûé íîìåð ñ÷åòà";                                   break;
   case 128:   ErrorNumber = "Èñòåê ñðîê îæèäàíèÿ ñîâåðøåíèÿ ñäåëêè";                      break;
   case 129:   ErrorNumber = "Íåïðàâèëüíàÿ öåíà";                                          break;
   case 130:   ErrorNumber = "Íåïðàâèëüíûå ñòîïû";                                         break;
   case 131:   ErrorNumber = "Íåïðàâèëüíûé îáúåì";                                         break;
   case 132:   ErrorNumber = "Ðûíîê çàêðûò";                                               break;
   case 133:   ErrorNumber = "Òîðãîâëÿ çàïðåùåíà";                                         break;
   case 134:   ErrorNumber = "Íåäîñòàòî÷íî äåíåã äëÿ ñîâåðøåíèÿ îïåðàöèè";                 break;
   case 135:   ErrorNumber = "Öåíà èçìåíèëàñü";                                            break;
   case 136:   ErrorNumber = "Íåò öåí";                                                    break;
   case 137:   ErrorNumber = "Áðîêåð çàíÿò";                                               break;
   case 138:   ErrorNumber = "Íîâûå öåíû - Ðåêâîò";                                        break;
   case 139:   ErrorNumber = "Îðäåð çàáëîêèðîâàí è óæå îáðàáàòûâàåòñÿ";                    break;
   case 140:   ErrorNumber = "Ðàçðåøåíà òîëüêî ïîêóïêà";                                   break;
   case 141:   ErrorNumber = "Ñëèøêîì ìíîãî çàïðîñîâ";                                     break;
   case 145:   ErrorNumber = "Ìîäèôèêàöèÿ çàïðåùåíà, òàê êàê îðäåð ñëèøêîì áëèçîê ê ðûíêó";break;
   case 146:   ErrorNumber = "Ïîäñèñòåìà òîðãîâëè çàíÿòà";                                 break;
   case 147:   ErrorNumber = "Èñïîëüçîâàíèå äàòû èñòå÷åíèÿ îðäåðà çàïðåùåíî áðîêåðîì";     break;
   case 148:   ErrorNumber = "Êîëè÷åñòâî îòêðûòûõ è îòëîæåííûõ îðäåðîâ äîñòèãëî ïðåäåëà "; break;
   //---- 
   case 4000:  ErrorNumber = "Íåò îøèáêè";                                                 break;
   case 4001:  ErrorNumber = "Íåïðàâèëüíûé óêàçàòåëü ôóíêöèè";                             break;
   case 4002:  ErrorNumber = "Èíäåêñ ìàññèâà - âíå äèàïàçîíà";                             break;
   case 4003:  ErrorNumber = "Íåò ïàìÿòè äëÿ ñòåêà ôóíêöèé";                               break;
   case 4004:  ErrorNumber = "Ïåðåïîëíåíèå ñòåêà ïîñëå ðåêóðñèâíîãî âûçîâà";               break;
   case 4005:  ErrorNumber = "Íà ñòåêå íåò ïàìÿòè äëÿ ïåðåäà÷è ïàðàìåòðîâ";                break;
   case 4006:  ErrorNumber = "Íåò ïàìÿòè äëÿ ñòðîêîâîãî ïàðàìåòðà";                        break;
   case 4007:  ErrorNumber = "Íåò ïàìÿòè äëÿ âðåìåííîé ñòðîêè";                            break;
   case 4008:  ErrorNumber = "Íåèíèöèàëèçèðîâàííàÿ ñòðîêà";                                break;
   case 4009:  ErrorNumber = "Íåèíèöèàëèçèðîâàííàÿ ñòðîêà â ìàññèâå";                      break;
   case 4010:  ErrorNumber = "Íåò ïàìÿòè äëÿ ñòðîêîâîãî ìàññèâà";                          break;
   case 4011:  ErrorNumber = "Ñëèøêîì äëèííàÿ ñòðîêà";                                     break;
   case 4012:  ErrorNumber = "Îñòàòîê îò äåëåíèÿ íà íîëü";                                 break;
   case 4013:  ErrorNumber = "Äåëåíèå íà íîëü";                                            break;
   case 4014:  ErrorNumber = "Íåèçâåñòíàÿ êîìàíäà";                                        break;
   case 4015:  ErrorNumber = "Íåïðàâèëüíûé ïåðåõîä";                                       break;
   case 4016:  ErrorNumber = "Íåèíèöèàëèçèðîâàííûé ìàññèâ";                                break;
   case 4017:  ErrorNumber = "Âûçîâû DLL íå ðàçðåøåíû";                                    break;
   case 4018:  ErrorNumber = "Íåâîçìîæíî çàãðóçèòü áèáëèîòåêó";                            break;
   case 4019:  ErrorNumber = "Íåâîçìîæíî âûçâàòü ôóíêöèþ";                                 break;
   case 4020:  ErrorNumber = "Âûçîâû âíåøíèõ áèáëèîòå÷íûõ ôóíêöèé íå ðàçðåøåíû";           break;
   case 4021:  ErrorNumber = "Íåäîñòàòî÷íî ïàìÿòè äëÿ ñòðîêè, âîçâðàùàåìîé èç ôóíêöèè";    break;
   case 4022:  ErrorNumber = "Ñèñòåìà çàíÿòà";                                             break;
   case 4050:  ErrorNumber = "Íåïðàâèëüíîå êîëè÷åñòâî ïàðàìåòðîâ ôóíêöèè";                 break;
   case 4051:  ErrorNumber = "Íåäîïóñòèìîå çíà÷åíèå ïàðàìåòðà ôóíêöèè";                    break;
   case 4052:  ErrorNumber = "Âíóòðåííÿÿ îøèáêà ñòðîêîâîé ôóíêöèè";                        break;
   case 4053:  ErrorNumber = "Îøèáêà ìàññèâà";                                             break;
   case 4054:  ErrorNumber = "Íåïðàâèëüíîå èñïîëüçîâàíèå ìàññèâà-òàéìñåðèè";               break;
   case 4055:  ErrorNumber = "Îøèáêà ïîëüçîâàòåëüñêîãî èíäèêàòîðà";                        break;
   case 4056:  ErrorNumber = "Ìàññèâû íåñîâìåñòèìû";                                       break;
   case 4057:  ErrorNumber = "Îøèáêà îáðàáîòêè ãëîáàëüíûåõ ïåðåìåííûõ";                    break;
   case 4058:  ErrorNumber = "Ãëîáàëüíàÿ ïåðåìåííàÿ íå îáíàðóæåíà";                        break;
   case 4059:  ErrorNumber = "Ôóíêöèÿ íå ðàçðåøåíà â òåñòîâîì ðåæèìå";                     break;
   case 4060:  ErrorNumber = "Ôóíêöèÿ íå ïîäòâåðæäåíà";                                    break;
   case 4061:  ErrorNumber = "Îøèáêà îòïðàâêè ïî÷òû";                                      break;
   case 4062:  ErrorNumber = "Îæèäàåòñÿ ïàðàìåòð òèïà string";                             break;
   case 4063:  ErrorNumber = "Îæèäàåòñÿ ïàðàìåòð òèïà integer";                            break;
   case 4064:  ErrorNumber = "Îæèäàåòñÿ ïàðàìåòð òèïà double";                             break;
   case 4065:  ErrorNumber = "Â êà÷åñòâå ïàðàìåòðà îæèäàåòñÿ ìàññèâ";                      break;
   case 4066:  ErrorNumber = "Çàïðîøåííûå èñòîðè÷åñêèå äàííûå â ñîñòîÿíèè îáíîâëåíèÿ";     break;
   case 4067:  ErrorNumber = "Îøèáêà ïðè âûïîëíåíèè òîðãîâîé îïåðàöèè";                    break;
   case 4099:  ErrorNumber = "Êîíåö ôàéëà";                                                break;
   case 4100:  ErrorNumber = "Îøèáêà ïðè ðàáîòå ñ ôàéëîì";                                 break;
   case 4101:  ErrorNumber = "Íåïðàâèëüíîå èìÿ ôàéëà";                                     break;
   case 4102:  ErrorNumber = "Ñëèøêîì ìíîãî îòêðûòûõ ôàéëîâ";                              break;
   case 4103:  ErrorNumber = "Íåâîçìîæíî îòêðûòü ôàéë";                                    break;
   case 4104:  ErrorNumber = "Íåñîâìåñòèìûé ðåæèì äîñòóïà ê ôàéëó";                        break;
   case 4105:  ErrorNumber = "Íè îäèí îðäåð íå âûáðàí";                                    break;
   case 4106:  ErrorNumber = "Íåèçâåñòíûé ñèìâîë";                                         break;
   case 4107:  ErrorNumber = "Íåïðàâèëüíûé ïàðàìåòð öåíû äëÿ òîðãîâîé ôóíêöèè";            break;
   case 4108:  ErrorNumber = "Íåâåðíûé íîìåð òèêåòà";                                      break;
   case 4109:  ErrorNumber = "Òîðãîâëÿ íå ðàçðåøåíà";                                      break;
   case 4110:  ErrorNumber = "Äëèííûå ïîçèöèè íå ðàçðåøåíû";                               break;
   case 4111:  ErrorNumber = "Êîðîòêèå ïîçèöèè íå ðàçðåøåíû";                              break;
   case 4200:  ErrorNumber = "Îáúåêò óæå ñóùåñòâóåò";                                      break;
   case 4201:  ErrorNumber = "Çàïðîøåíî íåèçâåñòíîå ñâîéñòâî îáúåêòà";                     break;
   case 4202:  ErrorNumber = "Îáúåêò íå ñóùåñòâóåò";                                       break;
   case 4203:  ErrorNumber = "Íåèçâåñòíûé òèï îáúåêòà";                                    break;
   case 4204:  ErrorNumber = "Íåò èìåíè îáúåêòà";                                          break;
   case 4205:  ErrorNumber = "Îøèáêà êîîðäèíàò îáúåêòà";                                   break;
   case 4206:  ErrorNumber = "Íå íàéäåíî óêàçàííîå ïîäîêíî";                               break;
   case 4207:  ErrorNumber = "Îøèáêà ïðè ðàáîòå ñ îáúåêòîì";                               break;
   default:    ErrorNumber = "Íåèçâåñòíàÿ îøèáêà";
   }
   //---
   return (ErrorNumber);
}
Hide details
Change log
r41 by imalkevich on Jul 11, 2011   Diff
[No log message]
Go to:  
Project members, sign in to write a code review
Older revisions
All revisions of this file
File info
Size: 65844 bytes, 1326 lines
View raw file
