Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728A557044A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiGKN2O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiGKN2I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 09:28:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8EE48CB0;
        Mon, 11 Jul 2022 06:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffEhgYUYN8TU4vPyiIvdGapxFRWGvwy1pS8X4qGETitulrdGuMTo2l0vafdcQ+UJBegxxXT4vnOwqBvxIomXl7E310J8NEQHycGLaHr5GKHeCUhBf+Jh0F58yILCxOepMXTEDJZLYZXJfPh4fsKXx91uwHQqfbzKQSKbqgqcmGUqiZCyUKUD0cMLpwjzbd/1er3vs6JYTo0m7tZgdbcI26Gh1vnM4Wfd1oIAqGNTRU3SCZ2qultq5XMnp6Zbipo8IqVuf0HPFATrlVMCuVo95f4JHgeFT2S1XWF+PbvgWa1gSvXqfrCBOCBzRp7TLRpG4FhwldxC/liLVqXsHVL/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCCRluuBThWvrkzfgoCX+ovCE3YnQ0ZJRCAoS1b9qF8=;
 b=cGr1JTjA/xHtqIqkYMBZrphPgjUeG/HjdjEbSXgOZCBTvpDsn/thW2d0eWB7jy/wUyX5Rh8zHopf8zksdWsE+5o/DYFpqAGWcSze8CfFC7qduUomW0UaTmKNTO8ubg6liJg47iLkzS9XC5Doy56W82d7pT8M/YYEqwwq2g7UtwrcK7teZkEXYAIHe1J2uIuKPaaFyvoWranjlEdgls2Bz1lKaCl0wx66E+Qeibu5p91c6iLlMgRaWY3cuj6R53RFFHh5HsCdufe4BIuCiJ2YkY3v25xsnK5Rz1nIAkjXrQtXD9F8yw0sWc+jputVKdZwA1/zp7mD4Y6za8ohsvEkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCCRluuBThWvrkzfgoCX+ovCE3YnQ0ZJRCAoS1b9qF8=;
 b=nYdK2/mbk2IYYyUyYc0H0bHsy4AAMonoMDFnnb79NcCPM37R4dzuwFoNinfo52ZI0d17cB6SqkdPj2WGmFf/0C1wlVtw/+93ttwjchYbGUEHJG/8LJ0IQiJJoB5Zniqq9d3H8DA4U1VVX/dR4N3xvdwsbATwNZZsAw2DRAytww0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5054.jpnprd01.prod.outlook.com (2603:1096:404:12c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 13:28:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce%8]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 13:28:01 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
CC:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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
Thread-Index: AQHYlSh1MmB5hz2fuEC85zhThtwVIa15KP5A
Date:   Mon, 11 Jul 2022 13:28:01 +0000
Message-ID: <OS0PR01MB592214D4F12E0636DB7B98CD86879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
 <20220711123835.811358-16-nuno.sa@analog.com>
 <CAHp75VcnuAtc+n+nhQ16yP9S-veX2c6ruquSewtPJdcqQwpyAQ@mail.gmail.com>
In-Reply-To: <CAHp75VcnuAtc+n+nhQ16yP9S-veX2c6ruquSewtPJdcqQwpyAQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a518306a-0a53-4699-cec5-08da63412dd3
x-ms-traffictypediagnostic: TYAPR01MB5054:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tGPBzQYA7Ny84RYsy+/FyMS+2e765lVo0DRuzkaKGzjnW6szZFHV7Y1oKJRRgaZCWP3j1WEMt2HktU3P7JOkXyVR5qtE7gkgWRsftFVrTgWHnaW5DTWrrwJmBtdUqyHR7DfARZhoR3n0vlbfEpy+8Xtt9NGBcNWk9l1BU1WEI0Hy7tAsT1Ynf87Fc2AYDD8QSr2385V5T8eU1ErEnJmSDoe7xkUXDQ+3WvQ4e/pwm+VtXaoAlgJVPVBlx6Ulv1AsN25pthYEIn50GHBdiO/rb+6c8SQtoyIe8GoGbb2l0HeHBzYUNH7uWOft3m9/wJpTJV+sDl3xFY/q5nDeCVkrUP8Art5msmQwlIRa3VuaTAqFvSbMD3sfN7x0y2sBIRCGQOmpmt++g9RZFx4IfS1By27OlQQUcLFeT9QSfRfaM1hMf1Je0qzpnuaW70N4399NWB3kIO6tuVNrdXC1XmRRU7CiaEF7YcQWsEJS3p6mnsoIwM4loaxwBxld8z5fmSh3ar3lvhqUNOnYkd8RIP8C4QkazRGkWFWxl2Bk/uTRF3SJRpBcZkjZyfNfOqfSKCjEGgdqIGJWDq4BUu9el/knw+g95hD/sEcimsqQ+diSucV3wRF5fh2dqnkodfHKUd5Phng0UGu7DCKS2dL/iGAWHndBZZ8E4K/r6xLbYgixUzol9QBFR99LAAge6Uk5isSi8oA2EBo4aQ3FPDBDltJcsegQZ1I5UrNi22BfHELgWDdUttwLnMch/yQYcrOyD6Q+vaROoBJBkG0omCbxJJaOPafay6VcBPrH8en1ib6kHPkFaAClx6ogRuP+WGPVVDoF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(66946007)(316002)(8676002)(64756008)(66446008)(55016003)(76116006)(66476007)(4326008)(66556008)(71200400001)(478600001)(4744005)(52536014)(7366002)(7406005)(5660300002)(83380400001)(110136005)(8936002)(33656002)(7416002)(54906003)(86362001)(41300700001)(2906002)(38100700002)(53546011)(122000001)(186003)(7696005)(6506007)(9686003)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlJHeUZHTnUrUEdIdFJPTjFzaTBhZGFIY1lhQ0t2dVEwb1FxTGZ6NFA4NUF3?=
 =?utf-8?B?b2t6K2NLWkFLVDFDSGJtVmQ4WCtYYWtXamlVeFBPc0dOTzQ4SzJNaU1QNGJD?=
 =?utf-8?B?WHhjc0N5SnVoc0ZJQkU4L2FmNXlRUm14THpNTUpHbEhYYitLb1RwREF1RTFK?=
 =?utf-8?B?WmlVUHVDRnRZU1ZucTFoQnN5VzN6OVZoWlc1SXlwakluYUVhVmpRUlJKbVhZ?=
 =?utf-8?B?RFBNL1BtZUlDMEhFS1Y0bXA3Q1hNRk9ubzY1dEQ4dTdhQ0dKMkIydFdId014?=
 =?utf-8?B?TXM0Mzc1dWptSzF2ZEIvdFAycGc5bE5MU3FPaU1YOE5lMWV4bHF2RVRlSjhQ?=
 =?utf-8?B?QzR3WkxGdlJXN2dLMzRBaitUbURrMEljZnh3aEhaZWpObk1Hb1VUOVBTMy9i?=
 =?utf-8?B?bTFJZ1ZiUEhQVEExSi82emd2TGdlRDcvWmRKZ2Y3MEZMV1ZrdElXN2NVWVho?=
 =?utf-8?B?eDN0MkNVZlcxTUlnbmpsTXVWRUwvNDQ1UGpZaGlwREtrc1lvWm9zdGFPWmQ4?=
 =?utf-8?B?ZmhJV1pyYWtjZU9LWVhwNFBvQ0VBU2IzMEM4aFhReVM4Q0pXM1krNlV1bUlS?=
 =?utf-8?B?akRYVXcraXY3R3pQODMxdi9nTkxhUzhzcDI1Z3FSWnZFeUhaaVRJTUZhNjNL?=
 =?utf-8?B?d2xlWEkzRm9rTkJkMGdnL09ZUktsNUplMFZvSlEvSTdDSlUweEsvZFRNczF0?=
 =?utf-8?B?MkFnUENKYkswUGE3WGwrNThMMlk4V2syT0dwdlp4WTR0dEpnM1FRdTU5Wmt0?=
 =?utf-8?B?aGJiL2NzcTA3NWJub0xNN2tCRXYxMzRtbG44MktmTjlTOFAxRDcySFcxcUFh?=
 =?utf-8?B?T1MzaDB5WGtWT1IwbWNQNW9vcjRzQS9EczNvQlFKMXRtb2xVVTQ2aXhFdzdp?=
 =?utf-8?B?TmExbEJReTZ3UmJTMjVZWldQM2JOTlR3VXJoNFl0VHdwOGVPblNtN041YUJV?=
 =?utf-8?B?ZGQvdWpmd2tNc042NkxXZjRJNllxK0RvZGdEaTc4K0pCaXRkNG9mcWk1ckd1?=
 =?utf-8?B?VUxLV3REZW5OWEJqUTYwYW9TQXM1NlNuMHlvNERDZ242R0RqaytHR1lLaDJW?=
 =?utf-8?B?RzNKS1lCdVhUWnY0YklTaDd4aDhRRnd5aUVUc2JEb01hc3NqZmxJbmhzMTZo?=
 =?utf-8?B?emYwZU1JOXlWODJsTTNQZVZ3eG01V09GWG5pQUw2TzlxZWRqOXc2RnN2RlJi?=
 =?utf-8?B?RExNZG5hY1NUd0hXV1dJbjJyYkhjbEtUcWZhSEJEejgxYWhIM3NJbElaaGsv?=
 =?utf-8?B?dXduU1JabDQ1K09xejhPeFRWZWpRVUhwbkFhRDZXeEh1RUNoRGEzTkgrNWFs?=
 =?utf-8?B?VzNUbVFtbDREZmkvNGxGWE5NdkhCaTBoSW80aHNVMEZZSnRWSlJ2TUJSN21t?=
 =?utf-8?B?UTZmd3d1ZVluTlN1N1hIR0R0YXZGaTVNMHFoTTNmdkFwajgrUUV1ODhzRzRa?=
 =?utf-8?B?Nm5aZnBQdFdPR2tWbGVqbFNodlMrTHBzNE9KcFFvL0VtK2R3T2pIOStRR2N2?=
 =?utf-8?B?WlB6SXV3Q3NCOWpWdmlITkZSY01lQTdPK3dXbURBT0txRHpXK3B0NHY5MnRV?=
 =?utf-8?B?Y2IzdC9zMFZQNm9XWVRXYmJmUHAzTnZHd2lFZFpEdUpOeDNneE16d1FhNmd4?=
 =?utf-8?B?MmIvZUExQWU2WGZUUnhOajY4c0hZTm12SUlscEs1VDA3MUxQZ2dYYkpnZHA4?=
 =?utf-8?B?N2FLRVMxc3Z3dm9CbkdXUll4YkNsQmNIT0JiQVJ0OXZ2bWVkb1JkMW16anZj?=
 =?utf-8?B?M3oveDRhUDFzYkhLbm5QOFBac3RCdFo4TVAybDlwQkVXRjhxbEZYQUROcmZJ?=
 =?utf-8?B?aHFrN3hXSnVLdXRsZ0JGTlR1M1lkMUdzSWlHRm1NbXdISFA5QWFTbnZMUkFH?=
 =?utf-8?B?amlrckR4ZEdqK2lsbGpkUlRSbGNaZUJnZit3UHRaSzVrSGpiTnZnZFNQUlhW?=
 =?utf-8?B?TXcybFYza0M4U1VRbFpweGF4Zk9XeTdUUllVR05qR0pVS20vRkUxSjhwdVY2?=
 =?utf-8?B?d2tmZCsyMWZqcGFvVEJ1bEpkcjlqM0NoeDJmbjdURXkwb08yZnZtTmEzN3dh?=
 =?utf-8?B?TDA5ZnhSYTR2NzhuQW1kUmdUWExZbHhQaWtFbjRJS2tVQ3ZicnErZTlyc1o2?=
 =?utf-8?B?V3Q5Ym9kUUthVTA2aHNzV21LZ21xOXNnRXBSMm5PbzNMZVJaWUFSa0hQRmRE?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a518306a-0a53-4699-cec5-08da63412dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 13:28:01.8913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A06TXjp7eeCG7gHU1vThebuYBrxIInCWQE4zbqNhgmWnRr39Yu2+zj7dbjfixD8rRnExKWU9KzQZXQRTJtbqXVoNnvEXIhkd0lp2IvRo8bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5054
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
Mjo0MCBQTSBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gPg0KPiA+IEp1
c3QgY29zbWV0aWNzLiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4uLg0KPiANCj4gLi4u
DQo+IA0KPiA+IC0gICAgICAgaWYgKG5hbWUgPT0gTlVMTCAmJiBjaGFubmVsX25hbWUgPT0gTlVM
TCkNCj4gPiArICAgICAgIGlmICghbmFtZSAmJiAhY2hhbm5lbF9uYW1lKQ0KPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCj4gDQo+IEFmdGVyIHRoaXMgY2hhbmdl
IGluIHBsYWNlLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGNvbnZlcnQgaXQgdG8NCj4gDQo+ICAg
aWYgKCEobmFtZSB8fCBjaGFubmVsX25hbWUpKQ0KDQpJdCBzaG91bGQgYmUgbmFtZSAmJiBjaGFu
bmVsX25hbWUNCg0KU2VlIGJlbG93Lg0KICghICggMSB8fCAwKS0+ICAoISAoMSAmJiAxKQ0KDQpD
aGVlcnMsDQpCaWp1DQoNCj4gDQo+IHdoaWNoIHNob3dzIGludGVudGlvbnMgY2xlYXJlci4NCj4g
DQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
