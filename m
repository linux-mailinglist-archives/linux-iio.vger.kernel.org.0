Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF59D7CF0C8
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 09:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjJSHJC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344867AbjJSHIp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 03:08:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A3D71;
        Thu, 19 Oct 2023 00:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRdBQR5dUuw4jVWQ6WqKgsfCxd0Uetd0qdf+RJsx0jqINgeBuaicZHG2YU8/fHb15MNorAajbyb8mlpUm6Vj8HsuHnovCa9hluSh4tD7P8LC9g4aNRU8/s8ZYduDC3j7mcjnsLh/NRhRFY80gsmLm3PeJExU/Nz65rNqqX/XQKxhp7HQElG0rL7LvVXMHtAhZ3mP+HUMqux/YDw7UBscoTxeV/4eJUB2w/SKZj425UMi3NY4dXXgeflcmqD/RNZygcbw0gcT4L+77PFfY4dE7KpDEwgFttXhR7lqmeN2baQkbp7ieXfd0Vufn6taK6w+lnsuzjFdpuK6TR57JH6ojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b5Ywux4GmwygZExFkfMAf7BdYN6lscTYSX5ffO6IHE=;
 b=nWClj5nE9iGmdrxCtxZsuApx6iNTkPXcaW2AYtxQuuBgGgu5VcdUVhLPa2VeIXo26QlWcSOx35e6hCfXTR2baeXMjyQkECDi4bynDpbpfhUh23QX/zk1y4azBbtUJdlZSlcwNE0PhKeNkKM27wvEaVJsxJY028HNKXb/IfBgD+V3fzQLPa5NXe/CCPPvGeJU7JUAFFGhP+2xUvzkbnR6u6cF8fuNn2qdNQPelDCG7qgC0AkRD+ILqRrofIUpmp+m4cLsDxeXdrjlt5C5rc3ZS1UYEAdKo3xfkefeTM6PmxnTTcaIi8ZyxWDr0rnvpB9MZexlLk3qZb2Vu+zGwrtKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b5Ywux4GmwygZExFkfMAf7BdYN6lscTYSX5ffO6IHE=;
 b=HZwlk4V3yloQh+BWhhMQRjAISMiZYMgQPSBvcdmhYM0HdYQKx48vnckrIbb6DYTZ8RLKkp0AG3C1mzWkOCg3cRsw3ndNjUCn0Uk+m4jW8EMsPDpqMO7+RWnFc0jnNALVP0NJH5QS+aQZg5ZDjo0FkVbm6o71jk7EObgqThQStqE=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB10744.jpnprd01.prod.outlook.com
 (2603:1096:400:294::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 07:08:23 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c90e:cd43:c967:5218]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c90e:cd43:c967:5218%5]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 07:08:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?QW5kcsOpIEFwaXR6c2No?= <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Topic: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Index: AQHZ0al0blpUu/Wm+0SusYyQOb+0BLBO2cgAgAClowCAANSSgIAACZOAgACvvWCAAAQnMA==
Date:   Thu, 19 Oct 2023 07:08:23 +0000
Message-ID: <TYCPR01MB11269D21D7DD5356A64E5679586D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
         <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
         <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
         <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
         <20231018204533.39399b0b@jic23-huawei>
 <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
 <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB10744:EE_
x-ms-office365-filtering-correlation-id: f549a1ef-250b-4593-d5f3-08dbd0722eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLJZ34XZ1FJ0yGFgKG1aMOpCNPa1IM5MuzPqN4PYgTsmUn1tydouZIzPR3dOUYHyGTDWX6H7gWvrp8IwA5Nt7iClV2bObaj0jApuZMVlwF8IfpVveWABZsV0Z0NKBmmfpndoiNrKhFnb+nr8wwNCSzTlmq5VCc+sdlUliUvefDRjKVm9ymDtGrj+5XHhyvaV2Lh+0kbbW1RK96XwN2xNAqoPSSNl7Jh5/+teuJrLd+DMxupNYHNKsoTr5Ezmg3ce5D1fhnY33DXNrTfoElWCP7ueq0ecTSq8iJ7Nd8mkAbulKpLxaJQ6zRxJN6RQ75cz4ppWKKHLbSi3m4VxsOr2SzxUJOzdlV5kdDOGEJaRaJzTGdcGHZll6abwMDclnFPsZKJfzhK2QUUWuxgTba9r+L1oHlLsllmWlilm8O4PV83NCxvu5NORqZaieWKdBc9BRuVybPg+z/wxqsg3Vwmj2mEFbZoFwmkX9sri7+BiHLQJx4YTTZwCe3JNEzxAe8iDuq2snihYkh0gq/q+Oh4GVMNQD3N+RNXyeoCV/yMIGs7bE0yfRbE3riFjvZAKowpsXwbUM5p5EGiQZMX6ccpHgLIoedCGXBOBB+caDj9p/myaKjxxQjEuyCyqnTUHsEQ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(55016003)(6506007)(38100700002)(41300700001)(52536014)(8676002)(4326008)(26005)(2906002)(7696005)(5660300002)(86362001)(83380400001)(122000001)(9686003)(53546011)(2940100002)(38070700005)(71200400001)(33656002)(478600001)(8936002)(54906003)(66556008)(76116006)(66446008)(110136005)(316002)(66946007)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXQ1U3ZJSERzT1BYYWhocXBqNzVhaTIrSkJGV0dDdE5ETUJzZFZWd2NvQTBs?=
 =?utf-8?B?eHN1bTk3MlQxR29ZdUh6K1JodnRlMjJ0cytMcHRlOExKY1J3ZjBlTEJocVhr?=
 =?utf-8?B?em12c2VHd2FQOXNzcXNmS2RGdkFTV0dtOUNzbUx6Wk4waVZRdXFYWUc4ZGdu?=
 =?utf-8?B?NDlGTWRmamVPSkxoN0ZTUk13NDRKdlA2YVBWY01SZ1BWNzM1RVQvbWpMRy9w?=
 =?utf-8?B?RjRqeS9EUGRGLzdIdEdOMkc3Sm5EK2lnb3VMaXZMY2J5eHNhbHhoZCtKV3I5?=
 =?utf-8?B?VlhOSkczaUQzSDhKdGJjSUVlSzZ1T2luTmRZUjU3WVpiN0lEZnRodWwzdTUz?=
 =?utf-8?B?UlVLMUhZNjljNGhOSThKQzl3N1ZLWkZ4RUxjVmNxcU1HRDRIdlJtZEh4enZy?=
 =?utf-8?B?aVFGc0Jtc3RqWjU0SVJsVStld0FPL1ovc2Y3bmNoYTloT3owSndtdHdNdjVJ?=
 =?utf-8?B?MmdCWWdxQ054cjN6NzN4TmJySWUxSWloUjE2ZU5hUXI0MFZyZnhDK1hwbFZt?=
 =?utf-8?B?TDRoS1ZwSVI2RXJ6OW91RU92TjM2dHZCTkcveHFLcG1WWW10NzRuTjYxSjJy?=
 =?utf-8?B?dnhTQTZ2blNIZ0pVMisyMENHUW9MYmF5Nk1paHdGeFAxUVRYSC9RdkUvcktm?=
 =?utf-8?B?U25NQS9sTzFPM1k2WEdMeU9xK2xpVUVwdXF4YjY4QjlIc0ZvMEx6bGRsVmJn?=
 =?utf-8?B?QkJkK0w2TllpdEJYQ2c0cWczWUE5bGJNSjlrT3lmLy90QTNrT0xBV2w4UTN0?=
 =?utf-8?B?YzNEVzRnUU5kSUY1cHhrWDZ1MVBXZHZIbHVnRlJkZ1ozR0NieW9oMFZqUjU2?=
 =?utf-8?B?d1RZUkVoZmY4dnJkeTNWeGFSb2dKY2VPSmNMdytTV3RJNzVCQjlUMGt1RFZw?=
 =?utf-8?B?NWxkNnZraHBJYU1LMEdmdHo5aDVDWnBkcHg4RE9XL1lWeUMyaktMZkdtbXND?=
 =?utf-8?B?QnVtZTN0TEFXaS9sRVMzZkhlY0hzdVdJak1JN1VKdHV1QXF3QkNwTnAzRE9s?=
 =?utf-8?B?bHorWTBDTldNYkRhZ255VS9wOVQzSEpVbnB6dEZhcUNzUVNlRSs1aDc3OGha?=
 =?utf-8?B?cG9CQ0lJYUJSVnRESktyQzJQU2F2Vy9VTkZTRGZTRDhUT1BmVWlPWnNldmcz?=
 =?utf-8?B?WUcwNlZGeEhnK01JdnZCOXNOd2VoV0ZsWUhOTjgzWWFUOWdxalBueVNQZ3lh?=
 =?utf-8?B?NlRvVmFSSXlBOWRFTDV6cUFPbGUwTkFDTnhQaC9KSk1RZW9udkI2elFUek1s?=
 =?utf-8?B?ZzVZZHZ4R2ZRWmkrd29FUGhrMk9sTTZaUTVqeXA5bTVSUSs3WXhyS21SaUJu?=
 =?utf-8?B?VG9hOVd3UzVNS1BjUnZsNkM2MGpPQW03NSs2NGJqa3lkdytUNFowZENoUGRt?=
 =?utf-8?B?V1BXamhTaVRLYXlMS3UzamRHK1YxUXV5WXNCUG5kTmVrcWZDU3grV3ZaVHB3?=
 =?utf-8?B?ODN5N2FUT0xTQ1hYQkNaeEswclhjRU5JSjBRRW9ubmQ1YXFCQzBwa1JpL2ZO?=
 =?utf-8?B?T2NhRmFPR08rWnl6Wk5Vb28xOVRFeXNsODVIU1ZHUXBvRDhNYlp5aVZkSFZL?=
 =?utf-8?B?Q2ZvbzlXaVVLUFkwa1lOVGxnLytUZDhRNDF2eGxJemthZVIzK0l1UzRoU3RY?=
 =?utf-8?B?RlNpeUN5WjQ1V1BpZTBzWE0vTCsxc3JIREJybTJHd2hRTVI4K3dlS3h0cC81?=
 =?utf-8?B?TjBOVWs4SUR6MnNkTmU5eWRJTEM2WlVqdFdPNzVLNE9qZnBJMS9zV0ZMSmt2?=
 =?utf-8?B?L0hGN1ZoaWRkVWtSc1lubVVqVUZuN3M5cFl3a1VJMm1wd2ZVZ3hWNjY0YU9T?=
 =?utf-8?B?SUxVbWc0d2dkQnFodnhuYUJSNUMrNDFHSVJ6Y2V0Y2RQUVRINWZ5SitPazhH?=
 =?utf-8?B?VzkvNGZQcmNsclU0Q3lWVnR0NjFMZGViNEU5L1c2MkF4OHJzdWFUblpTVUFn?=
 =?utf-8?B?UTlaMEtFQjNFdEovcCt2OU15aDVEV3d3cnFEM2VGTngweForWERBcWZVNEo3?=
 =?utf-8?B?aHRUSDMweWlmY2JIQXc1Wk5DN2RUUVpITXhZSFpqZUkyQWdmL3B0ZmljQ251?=
 =?utf-8?B?aGpDU0pOV0NMeUlqWlBvTnZ3bVBNNThhRzJSRkU4eUpmKzk3MjU0K2xCcWJ2?=
 =?utf-8?B?c3JlTGRSNWNqamRDZ1QxejBFeW9zbmR1aXp2ZFI2RFZqUWJHQW96RFB2Z0lh?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f549a1ef-250b-4593-d5f3-08dbd0722eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 07:08:23.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3Z4nQ+5zb4ohVDKJbafynq2++x/8SJy18+NaWTbCm1wNMHrdmfvLcW8v3gzVJ1+J2zW6c7HDdDYtusuutlTSecL/4yqiQ8vD3yJCEIb3yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10744
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDEvNV0gaWlvOiBtYWduZXRvbWV0ZXI6IGFrODk3NTog
Q29udmVydCBlbnVtLQ0KPiA+cG9pbnRlciBmb3IgZGF0YSBpbiB0aGUgbWF0Y2ggdGFibGVzDQo+
IA0KPiBIaSBBbmRyZSwNCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzVdIGlpbzog
bWFnbmV0b21ldGVyOiBhazg5NzU6IENvbnZlcnQgZW51bS0NCj4gPiA+cG9pbnRlciBmb3IgZGF0
YSBpbiB0aGUgbWF0Y2ggdGFibGVzDQo+ID4NCj4gPiBBbSBNaXR0d29jaCwgZGVtIDE4LjEwLjIw
MjMgdW0gMjA6NDUgKzAxMDAgc2NocmllYiBKb25hdGhhbiBDYW1lcm9uOg0KPiA+ID4gT24gV2Vk
LCAxOCBPY3QgMjAyMyAwOTowNDo0NCArMDIwMA0KPiA+ID4gR2VlcnQgVXl0dGVyaG9ldmVuIDxn
ZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBIaSBBbmRyw6ksDQo+
ID4gPiA+DQo+ID4gPiA+IE9uIFR1ZSwgT2N0IDE3LCAyMDIzIGF0IDExOjEy4oCvUE0gQW5kcsOp
IEFwaXR6c2NoIDxnaXRAYXBpdHpzY2guZXU+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IEFt
IEZyZWl0YWcsIGRlbSAxOC4wOC4yMDIzIHVtIDA4OjU1ICswMTAwIHNjaHJpZWIgQmlqdSBEYXM6
DQo+ID4gPiA+ID4gPiBDb252ZXJ0IGVudW0tPnBvaW50ZXIgZm9yIGRhdGEgaW4gdGhlIG1hdGNo
IHRhYmxlcyB0byBzaW1wbGlmeQ0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBwcm9iZSgp
DQo+ID4gPiA+ID4gPiBieSByZXBsYWNpbmcgZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgYW5kDQo+
ID4gPiA+ID4gPiBpMmNfY2xpZW50X2dldF9kZXZpY2VfaWQgYnkNCj4gPiA+ID4gPiA+IGkyY19n
ZXRfbWF0Y2hfZGF0YSgpIGFzIHdlIGhhdmUgc2ltaWxhciBJMkMsIEFDUEkgYW5kIERUDQo+ID4g
PiA+ID4gPiBtYXRjaGluZyB0YWJsZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+DQo+
ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvYWs4OTc1LmMNCj4gPiA+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9hazg5NzUuYw0KPiA+ID4gPiA+
ID4gQEAgLTg4MywxMCArODgzLDcgQEAgc3RhdGljIGludCBhazg5NzVfcHJvYmUoc3RydWN0IGky
Y19jbGllbnQNCj4gPiA+ID4gPiA+ICpjbGllbnQpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgIHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCBn
cGlvX2Rlc2MgKmVvY19ncGlvZDsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqAgc3RydWN0IGdwaW9f
ZGVzYyAqcmVzZXRfZ3Bpb2Q7DQo+ID4gPiA+ID4gPiAtwqDCoMKgwqAgY29uc3Qgdm9pZCAqbWF0
Y2g7DQo+ID4gPiA+ID4gPiAtwqDCoMKgwqAgdW5zaWduZWQgaW50IGk7DQo+ID4gPiA+ID4gPiDC
oMKgwqDCoMKgIGludCBlcnI7DQo+ID4gPiA+ID4gPiAtwqDCoMKgwqAgZW51bSBhc2FoaV9jb21w
YXNzX2NoaXBzZXQgY2hpcHNldDsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqAgY29uc3QgY2hhciAq
bmFtZSA9IE5VTEw7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoCAvKg0KPiA+
ID4gPiA+ID4gQEAgLTkyOCwyNyArOTI1LDE1IEBAIHN0YXRpYyBpbnQgYWs4OTc1X3Byb2JlKHN0
cnVjdA0KPiA+ID4gPiA+ID4gaTJjX2NsaWVudA0KPiA+ID4gPiA+ID4gKmNsaWVudCkNCj4gPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoCAvKiBpZCB3aWxsIGJlIE5VTEwgd2hlbiBlbnVtZXJh
dGVkIHZpYSBBQ1BJICovDQo+ID4gPiA+ID4gPiAtwqDCoMKgwqAgbWF0Y2ggPSBkZXZpY2VfZ2V0
X21hdGNoX2RhdGEoJmNsaWVudC0+ZGV2KTsNCj4gPiA+ID4gPiA+IC3CoMKgwqDCoCBpZiAobWF0
Y2gpIHsNCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hpcHNldCA9ICh1
aW50cHRyX3QpbWF0Y2g7DQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5h
bWUgPSBkZXZfbmFtZSgmY2xpZW50LT5kZXYpOw0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgIH0gZWxz
ZSBpZiAoaWQpIHsNCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hpcHNl
dCA9IChlbnVtIGFzYWhpX2NvbXBhc3NfY2hpcHNldCkoaWQtDQo+ID4gPiA+ID4gPiA+IGRyaXZl
cl9kYXRhKTsNCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmFtZSA9IGlk
LT5uYW1lOw0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgIH0gZWxzZQ0KPiA+ID4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT1NZUzsNCj4gPiA+ID4gPiA+IC0NCj4gPiA+
ID4gPiA+IC3CoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShha19kZWZfYXJyYXkp
OyBpKyspDQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChha19kZWZf
YXJyYXlbaV0udHlwZSA9PSBjaGlwc2V0KQ0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4gPiA+ID4gPiAtDQo+ID4gPiA+ID4g
PiAtwqDCoMKgwqAgaWYgKGkgPT0gQVJSQVlfU0laRShha19kZWZfYXJyYXkpKSB7DQo+ID4gPiA+
ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJmNsaWVudC0+ZGV2LCAiQUtN
IGRldmljZSB0eXBlDQo+ID4gPiA+ID4gPiB1bnN1cHBvcnRlZDoNCj4gPiA+ID4gPiA+ICVkXG4i
LA0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y2hpcHNldCk7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqAgZGF0YS0+ZGVmID0gaTJjX2dldF9tYXRj
aF9kYXRhKGNsaWVudCk7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqAgaWYgKCFkYXRhLT5kZWYpDQo+
ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsNCj4g
PiA+ID4gPiA+IC3CoMKgwqDCoCB9DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLcKgwqDCoMKg
IGRhdGEtPmRlZiA9ICZha19kZWZfYXJyYXlbaV07DQo+ID4gPiA+ID4gPiArwqDCoMKgwqAgLyog
SWYgZW51bWVyYXRlZCB2aWEgZmlybXdhcmUgbm9kZSwgZml4IHRoZSBBQkkgKi8NCj4gPiA+ID4g
PiA+ICvCoMKgwqDCoCBpZiAoZGV2X2Z3bm9kZSgmY2xpZW50LT5kZXYpKQ0KPiA+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuYW1lID0gZGV2X25hbWUoJmNsaWVudC0+ZGV2KTsN
Cj4gPiA+ID4gPiA+ICvCoMKgwqDCoCBlbHNlDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG5hbWUgPSBpZC0+bmFtZTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJIGp1c3Qgbm90aWNlZCwgdGhhdCB3aXRoIHRoZSBhYm92ZSBjaGFuZ2UgJzAtMDAwZCcg
aW5zdGVhZCBvZg0KPiA+ID4gPiA+IHRoZSBwcmV2aW91cyBhbmQgZXhwZWN0ZWQgJ2FrMDk5MTEn
IGlzIHNob3duIG5vdyBhcyBuYW1lIGZvciB0aGUNCj4gPiA+ID4gPiBtYWduZXRvbWV0ZXIgaW4g
bG9uZ2NoZWVyIGw5MTAwIFsxXS4NCj4gPiA+ID4NCj4gPiA+ID4gV2hpbGUgdGhpcyBkb2Vzbid0
IGhlbHAgbXVjaCwgbm90ZSB0aGF0IHRoZSBvbGQgbmFtZSB3b3VsZCBicmVhaw0KPiA+ID4gPiB0
aGUgY2FzZSBvZiBoYXZpbmcgdHdvIGluc3RhbmNlcyBvZiB0aGUgc2FtZSBkZXZpY2UuDQo+ID4g
Pg0KPiA+ID4gV2h5PyBJbiBJSU8gQUJJLCB0aGlzIGlzIHRoZSBwYXJ0IG51bWJlciAtIGl0J3Mg
YWJzb2x1dGVseSBmaW5lIHRvDQo+ID4gPiBoYXZlIHR3byBkZXZpY2Ugd2l0aCBzYW1lIG5hbWUu
IFRoZXJlIGFyZSBsb3RzIG9mIG90aGVyIHdheXMgb2YNCj4gPiA+IGZpZ3VyaW5nIG91dCB3aGlj
aCBpcyB3aGljaCAocGFyZW50IGRldmljZSBiZWluZyB0aGUgZWFzaWVzdCkuDQo+ID4gPg0KPiA+
ID4gVGhpcyBpcyBpbmRlZWQgYSBidWcgYnV0IGl0IGlzbid0IGEgbmV3IG9uZSBhbmQgaXQncyBi
ZWVuIHRoZXJlIGxvbmcNCj4gPiA+IGVub3VnaCB0aGF0IHRoZXJlIG1heSBiZSB1c2Vyc3BhY2Ug
Y29kZSByZWx5aW5nIG9uIGl0Li4uDQo+ID4gPg0KPiA+IEF0IGxlYXN0IGZvciB0aGUgbG9uZ2No
ZWVyIGw5MTAwIGl0IGlzIGEgbmV3IGJ1ZyB0aGF0IHdhcyBpbnRyb2R1Y2VkDQo+ID4gYnkgdGhp
cyBwYXRjaC4gQnV0IGFzIG15IG9ubHkgdXNlIGZvciB0aGlzIG5hbWUgaXMgdmlhIGh3dGVzdFsx
XSwNCj4gPiB3aGljaCB1c2VzIHRoZSBuYW1lIGFzICJwcmV0dHkgbW9kZWwgbmFtZSIsIGl0J3Mg
ZmluZSB3aXRoIG1lIGlmIGl0DQo+IGNhbm5vdCBiZSBmaXhlZC4NCj4gDQo+IEFzIG1lbnRpb25l
ZCBpbiB0aGUgcGF0Y2guDQo+IC8qIElmIGVudW1lcmF0ZWQgdmlhIGZpcm13YXJlIG5vZGUsIGZp
eCB0aGUgQUJJICovDQo+IA0KPiBMb29rcyBsaWtlIHRoaXMgaXNzdWUgaXMgbm90IGludHJvZHVj
ZWQgYnkgdGhpcyBwYXRjaC4NCj4gVGhlIHByZXZpb3VzIGNvZGUgdXNlcyBkZXZpY2VfZ2V0X21h
dGNoX2RhdGEoKSB3aGljaCByZXR1cm5zIGEgbWF0Y2ggYXMgaXQNCj4gdXNlcyBEVCBub2RlIGFu
ZCBpdCB1c2VzIGRldl9uYW1lKCZjbGllbnQtPmRldikgaW5zdGVhZCBvZiBpZC0+bmFtZTsNCj4g
DQo+IEFtIEkgbWlzc2luZyBhbnl0aGluZyBoZXJlPyBJZiBpdCBpcyBqdXN0IGEgdGVzdCBwcm9n
cmFtLCBjYW4gaXQgYmUgZml4ZWQ/Pw0KPiANCj4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSBhbSB3
cm9uZy4NCg0KSSBqdXN0IHJlYWxpemVkIHRoYXQgdGhlcmUgaXMgbm8gLmRhdGEgaW4gcHJldmlv
dXMgY29kZSBmb3IgT0YgdGFibGVzLg0KDQpNYXliZSB3ZSBzaG91bGQgYWRkIGEgY2hlY2ssIGlm
IGl0IGlzIERUIG5vZGUsDQpyZXR1cm4gaWQtPm5hbWU/IA0KDQpJcyB0aGVyZSBhbnkgQVBJIHRv
IGRpc3Rpbmd1aXNoIERUIG5vZGUgZnJvbQ0KQUNQST8/DQoNCkNoZWVycywNCkJpanUNCg==
