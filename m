Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD82857046D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGKNhU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 09:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKNhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 09:37:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20A3DBF9;
        Mon, 11 Jul 2022 06:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhYgiju+B7bBQs/1UOpTMFzD35yrQFE/8UqTbXcT8Vomcq7VgecjctsGJgMEKe1bcbnBhm1cnt+LsbqMZ/cxv95b8S9XoD0ZWdndRB8LKkrNJxELKU6xs7tAIWw8D5TbvC6+NttCPrKf21zAvTx2qwQSIFwxVA3R2xTXX83CnmCIuVBWp3uN4cdfzIfixCIkWZzYEviIYYoI1mZc3cvPUrdwFB7BsWWjNxSEeckPV7EntOfUW0wq1S44MtXaxbSD4B8C/Y+VHnJouNcB1RhPbUl0jH4Fcc86Rjq7VQRYpMqtwZj6/oATqjU23Ce37dY+6RjfMRSPfPXaPLy32T27Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDK5UzieMdObw9Gp4J8NagMKGkNbKAupqd5Mm97ddY8=;
 b=CawfYV3S/SLHd9FSJJuGQRd+GR+k4EKfFX3c3hnT1GHk3yZQPZYT8zBVD5jjI52g9W7nhx16OBFlYO76P83LJ9Mhs553ygm3vTJQ1f/a8OE2ZreUs1mb9Uvr4dNentBjVzzqNh8nx3tJkBxwS33KmFA6Lgd+kWYbCOkn0g4EuOn0BWc0jJnEi8p77+56az1Bub19u6agQAluPNpNEI8kW5owZMnSo+WAQmpuOtldVvypE9i3/n6WUIKBwTm5uZocRK7/It3kYt7bEDgRVNZwvdfywPCKXeITfLr6HjPM9FkdnzBmNQCGMxvYgIDnNDQyaM6mJ0mDHDU4num5f6gPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDK5UzieMdObw9Gp4J8NagMKGkNbKAupqd5Mm97ddY8=;
 b=ER85121dryParzsqU69r6t1Q3wZD1SJKTn22PHFG9MZB/piFjZ1A4zHtPNGlLiUDyYlqD3arbfLWnvNZJIpbQ7ob5BkDc+Pv2sA5uXHOJitLFmq/Lyp0E7Fb5rSUvckoU22S5NL55TtS1qo+4wCbUaXOG3l6K59CUTKLD7zhAH4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6913.jpnprd01.prod.outlook.com (2603:1096:400:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 13:37:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce%8]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 13:37:15 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Andy Gross <agross@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Patrick Venture <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v2 15/15] iio: inkern: fix coding style warnings
Thread-Topic: [PATCH v2 15/15] iio: inkern: fix coding style warnings
Thread-Index: AQHYlSh1MmB5hz2fuEC85zhThtwVIa15KP5AgAACIoCAAADZYA==
Date:   Mon, 11 Jul 2022 13:37:15 +0000
Message-ID: <OS0PR01MB59227884F494F5C9DCF936E886879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
 <20220711123835.811358-16-nuno.sa@analog.com>
 <CAHp75VcnuAtc+n+nhQ16yP9S-veX2c6ruquSewtPJdcqQwpyAQ@mail.gmail.com>
 <OS0PR01MB592214D4F12E0636DB7B98CD86879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAHp75Ve1mAj9u3rVU7qseZ-MYw_PDjAAFA+69XeRv_pvEW-ZrQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve1mAj9u3rVU7qseZ-MYw_PDjAAFA+69XeRv_pvEW-ZrQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4300455f-5410-4271-23cf-08da634277b4
x-ms-traffictypediagnostic: TYCPR01MB6913:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AEDuIHto4xjVZ+QsjqPgOdUwEexhEBLITJq14iWcDQkgpgnK/D5FXzsTe0R9F6u9cAzxVH+c8aCX+TwA4doJ5svsbtjlAdcjO6QU/fHYk6RU5tQC11KK/y34+8DYY1XorUf7Vse0QwOqbXYygIY2gcxi2XY+Vlm2Z7dkX08/vTS9rjq2IT0h+7FjDhS3dq8p0OsogJ9OzJRr6e1ZYU4bfEbc3a29piduCmJih4HiB+ZreEQleBS5L/i1hWdwydkzegwRI3Z8CMZZm0ds8jwY4Nf9/rd3bZGJr8jO5/dIxt/1THwe+Pbv8mTErBXwIZg9AtWcKJnFXsA+wcqLATWn6pI/FLcaWVMbdZ/4Xc1FPILKK23QBNBx8R/8lmYXGP25/SJMgMTmVHscWk+NJacAF90f68jkMtHanjrXCRMQ1XyvFIEnXRqpi1xx/ezs2hohHtjK4VOMlGOpt9w/ZTBR7wmcGAnBciRu7iY1najGhpBLK6KbqRFdFfaWi4LnQkzLQ9YjR0mEKShcilZmbIkFFIq1KLxIfTZ89t9Lzx24G7QaY++B3u5+VIFxbI7dAwwP9oX2d5Wyr+w5o0INls0XTJKA7HQVGrjRZQHJVd2wSDaDtfxqKY8z6VjKmfL7f3tOoJPH2zKByVEUmsLAowNEdediUimcV9VIueAyj1y46jY7J9onPYpqeym6pLIUh+mLU65vCfhYy4/0Mz7fmld1Hg6oHwkUcSJgF6djlzwQrLaBefpl98XWuugvaqm+y5rmy+pA92ZqG1iZ1IRbe49s8ZNNptG5kGkkD5Xzv5nfr+ALmjpqy8Lx3Nh0f9427kLg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(86362001)(6506007)(5660300002)(52536014)(4326008)(66556008)(66476007)(41300700001)(478600001)(7696005)(7366002)(4744005)(8936002)(53546011)(7416002)(38070700005)(9686003)(33656002)(7406005)(2906002)(26005)(38100700002)(122000001)(55016003)(71200400001)(83380400001)(76116006)(54906003)(186003)(66946007)(316002)(6916009)(64756008)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czVUd2RhM2NPdElzMWJMbzhYQUdjOWZud0Y5NW94UVA3SFpiZWlFUVB5THlm?=
 =?utf-8?B?MFNseFRhb2NVVXg1WjZqb3NyZDZxWnZTbG9LSlpJcDdnSXhYYllsUHJEdXhH?=
 =?utf-8?B?M25sVjBsdThDY3FWYVVPd1VpTm0vWVYzWkN1T3NMcFJtM2twNm42ZTNneVZ6?=
 =?utf-8?B?SU5VeXRlb1hnM2trelhZcHZCUldXc25jRVo4UzI4aVYxaWx3U3MrS0RXdVR5?=
 =?utf-8?B?SXJ1SE8vTWNHalZxY2FNMi9vdFFPNWlUbjAvaEhHQ2RpT2NYdTgvOTBVUkVn?=
 =?utf-8?B?dSs2WDdDVXl0Zm95MmFUbkJqT2lOdU9TRzgwVm9ocndQYTcyWHYrNnltbFpC?=
 =?utf-8?B?dW5WNUhhT0NEc1N0Vld1aEEzSktOSjhMSm8zRi9JRUp0OU9IcDFUQ3VUa0sy?=
 =?utf-8?B?NG5wcDN2Y0lKL3A4Y3VZR3dyRi9zYmFGSHh3UWhQRWZZQ3N0RXhVQ1Iya0U2?=
 =?utf-8?B?bThML2hqQlF6T0RlK3hVSEdSN2Rxc0JpcEhQMjlhcHlGb3o0NHA5K3dHTElQ?=
 =?utf-8?B?c2d3MmI4N2ZTRjM3OWFWSjZ1U3FMMU1CeFkzZnR6YU5YSitPR0J4UVpNVjMx?=
 =?utf-8?B?OWozaG82VjYxT3k0Y01WK0VsRzBBUVNYcmRORGVoSEdmY29hVXk1SmdlSFRq?=
 =?utf-8?B?QjFNQm5VU1RFc0txZHNSVEFqR3JTM1R6d244cE1EcEkrOUhNYnh2djJJbUZx?=
 =?utf-8?B?aUdUdXlleWdxK0xGaTJUUWNZdVlPcm1tQmhyVzdRdlV4b2FFN0lKMWVMNXNo?=
 =?utf-8?B?cFEzYTNvaGJZUWk0ZTVQSW1WWEJncEhGWkpJT0tZVUVQRDhFSzhyRGpUOG9s?=
 =?utf-8?B?TElTYU03T1ZPSFFaajRQN1o4eU1FZE4yZmJ2WkE5QVpwZ2FpR2kwaSt0WTBS?=
 =?utf-8?B?UkdLTWVBd3lvMDcySE1VSk52b0V2ZHY0K1ZCU1kzd3I2a2FScWtERk9qZlhQ?=
 =?utf-8?B?eEk2dUdsd2tFdWtvNmdnNUN4akk1R0RYQUJJUmUrSjJkdjU5SE1LbGlnWHV0?=
 =?utf-8?B?T3lRYlhidnd2TW5mdHhsNlBuczdTUk1aTUFsYTZxUTBNajRQaS9KbWpSTDNx?=
 =?utf-8?B?YTYyYzYxVExrMHNHSFRGMStwRlYrK3BpR1hFb0FhUTR3RDl0S3ZsMTdBNFQx?=
 =?utf-8?B?NmpkMWpEcGU4Z2VpK2d0cTFhWkU2bHdSRXFvOUtJazRCb0l2dU1YcXIzZlJX?=
 =?utf-8?B?RU10MEtQUlFhcjRVekVMc1JUdWZvc29ucWNOcXBCbUxPUG9QbFJGaWxxc2gv?=
 =?utf-8?B?RVU3UXpXNitMdmN1OE0wd2xBNnFIVW5NZ2tDdzBDR2IvRUVRYTdlWDZ6ZnVu?=
 =?utf-8?B?ZUdybDFMWmtaY1c0T1l1Vko1N1ErVXUrQlNzV0Z1cnNrNmRmMm1admt3Vldx?=
 =?utf-8?B?bDc3WmhENEd6dkdrZFM0YTI4a3FUZitKMUkvWFFmN1hjTW5uZE04TWlqQWpw?=
 =?utf-8?B?VlJDV1cySCtCakxnR2lLczliS2o4Q3kxbFI4T3k2ZEsyZTBoUytRMHAwcmdl?=
 =?utf-8?B?U0RxYWZpWCtZN3phUFFndm56QnlSWDlTaHJFRlphZWJWQ2xzQnhGK2FVUjk0?=
 =?utf-8?B?Nkh1L2dnc1YzV2RyTDhwdGRYdHh6SkwrY3NWdWdqL0c4Y25kMHFmYjBPdnds?=
 =?utf-8?B?a0NOTGgvTVczalZOcWYwTXZZckJIQWo0cC9PazhyTlYralVsZUZnUnVic0lO?=
 =?utf-8?B?TWJXK21uSTlJd281UGdmdDVjSS9jNU8rdUZyVzNLYTd1RUV1bXowdUxZUStJ?=
 =?utf-8?B?OGVrYzRmczRYSHZuUGlBSXNCM2lhZythOU83c1k3Y1N3bmJwZml1TE9OYXE0?=
 =?utf-8?B?Zm8rbGc5RTlPTWV3SzhNZzc4VjYwNVROMkZRRTc5YnFXZTNWWnJkSFRwdkRD?=
 =?utf-8?B?cDJXWTJ6ZGdmUmtyNkx2WWttS1l2RS9nWXFqMW5Wa2FEN3lXMStnM2hFNHJN?=
 =?utf-8?B?UGoraUdwaHYwRFhPdlliWU5ZaEFNODlHaW51dWVBV0k1cEc4ZmFiY1Rna0FN?=
 =?utf-8?B?bGlheXZsZXd6TlAwK083TkxyeHd0M0hLeXdpeStOVisvVys5bGZQUlpWL2Y5?=
 =?utf-8?B?bWpMNGdlSTZnaTlGdjhmYjd6WnRxaE9IalRabG1xakJsbEZjdjdwRDhveVhs?=
 =?utf-8?B?Uytmd1ZIeDQ3UVpFUUM5ZGdiY3JaTnpKYnM5Rkg3SDZOSXFWSlIwLzgvUFV0?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4300455f-5410-4271-23cf-08da634277b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 13:37:15.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 538ML/L2QC4FWfCam53etBivki7rqseDB51hOagVDTVN34ZMl5KklBWYiHphBDV/IgUwCsa2wlOHeRo/8PG0++cpooCw57+PT3mhbndUmAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6913
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDE1LzE1XSBpaW86IGlua2Vybjog
Zml4IGNvZGluZyBzdHlsZSB3YXJuaW5ncw0KPiANCj4gT24gTW9uLCBKdWwgMTEsIDIwMjIgYXQg
MzoyOCBQTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0K
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxNS8xNV0gaWlvOiBpbmtlcm46IGZpeCBjb2Rp
bmcgc3R5bGUgd2FybmluZ3MNCj4gPiA+IE9uIE1vbiwgSnVsIDExLCAyMDIyIGF0IDI6NDAgUE0g
TnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4g
PiA+IC0gICAgICAgaWYgKG5hbWUgPT0gTlVMTCAmJiBjaGFubmVsX25hbWUgPT0gTlVMTCkNCj4g
PiA+ID4gKyAgICAgICBpZiAoIW5hbWUgJiYgIWNoYW5uZWxfbmFtZSkNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9ERVYpOw0KPiA+ID4NCj4gPiA+IEFmdGVyIHRo
aXMgY2hhbmdlIGluIHBsYWNlLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGNvbnZlcnQgaXQgdG8N
Cj4gPiA+DQo+ID4gPiAgIGlmICghKG5hbWUgfHwgY2hhbm5lbF9uYW1lKSkNCj4gPg0KPiA+IEl0
IHNob3VsZCBiZSBuYW1lICYmIGNoYW5uZWxfbmFtZQ0KPiA+DQo+ID4gU2VlIGJlbG93Lg0KPiA+
ICAoISAoIDEgfHwgMCktPiAgKCEgKDEgJiYgMSkNCj4gDQo+IEkgZGlkbid0IGdldCB3aGF0IHlv
dSBhcmUgaW1wbHlpbmcgaGVyZS4gUGxlYXNlLCBjaGVjayBhZ2FpbiB3aGF0J3MgaW4NCj4gdGhl
IG9yaWdpbmFsIGNvZGUgYW5kIHdoYXQncyBiZWluZyBzdWdnZXN0ZWQuDQoNCk9rLCB5b3UgYXJl
IHJpZ2h0LiBJIHdhcyBsb29raW5nIGF0IHRoZSBtb2RpZmllZCBjb2RlLg0KDQpDaGVlcnMsDQpC
aWp1DQo=
