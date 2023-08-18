Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A778114A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378913AbjHRRKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378966AbjHRRKI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:10:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27230D8;
        Fri, 18 Aug 2023 10:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0QdVBYDtKBqYDd+42fo6qq3s7OaMroK5tWlM5HXjqD+9Xq3io6tzferapeBtmZ1yFOPgbyVu80Fye42yULGCOq1C9QgpDise4MT1Kj1KTHfrsDDCGWX4NfbdvoRKEdlWspaWQJHJQRUjIi0crblG/dLJa5B1IuLOeyp+wdKZ2bwEs2bB+JJEKdFj2u3vH0S+RbTK0+3OAaTmJ0pfQoZx022V+HaPGsvC6v992my0nl3ngr/YI3NHtFLIR4McSTT2lhzCJV509aYNDdzRafYqPxAHcP6J/BzdnQcU8KAfQJVaJG6bPdkewRP3sLL79Lob/o+aHqy4q+m1FMhAeWDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47iU+6VcXvyws48AAfM/HdosbGhUnqXF3Mi/zOnsMkM=;
 b=HaB2Y9bsGFII7IXVQ8FYs69NwQec4Se2S9visrL50uA80SNJSf6d6+iUOM6ClHECGGEv+QbX2uKpemDHBLIv8llzCmbc8OMra0mZdPFD8SpYZOdmxdQ+/38+6M/JKCv5noSsS0VR5/a+hzzE+WliOjfqDO+PJKDGGycC8KSpXIBklOb8L7dO76AvYVabc8pUL0d2DkrHZiNaladH2I+ZaSa4Vy5OtiH9x0WEEuAkdsZj3fqjMrdgDIQlDZqBmd6c/CCFmK83L4fhYwKmO+RS1AfeZ80XNh82ak3pmb12u08OwMNRmgpIQqGhgLnC/uKQsoZtPMhSxJdkwtGB54mN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47iU+6VcXvyws48AAfM/HdosbGhUnqXF3Mi/zOnsMkM=;
 b=j5SJJKdYFXl6TG78SgTnSw81W+UxvN/rHedB6+uVtu12X6EhITcV9p5adoaQkPj70KH6xe21KtNySMt9OF8KPGoYGKQgB2Y8VscgF81HikTE5jqlGdMCQG61piCkNmheOWop8abEZF7bDf0XLd3thwGGGj7GUclsB4ewgLC7nko=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8399.jpnprd01.prod.outlook.com (2603:1096:604:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 17:10:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 17:10:03 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Thread-Topic: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Thread-Index: AQHZ0al+MNQOBUPx202UR8p64ZlFNa/v63YAgAA5OACAAAsYAIAAAk6AgAAWsQCAAAD2cA==
Date:   Fri, 18 Aug 2023 17:10:03 +0000
Message-ID: <OS0PR01MB5922225B11C6419DEFDDDEF7861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
 <ZN9WVvo+pixspCsw@smile.fi.intel.com>
 <CAMuHMdX0cnPDNHdUoquGTzZJE-CD81Lor=3q+j36rJyS23mJqw@mail.gmail.com>
 <ZN+PpLsAayzfgTtb@smile.fi.intel.com>
 <CAMuHMdXAG8JmOaGzeRd8kgoZqMmG1Qf7PFjZFJiQBXpp9Sa8pg@mail.gmail.com>
 <ZN+knFD5pFilfBcT@smile.fi.intel.com>
In-Reply-To: <ZN+knFD5pFilfBcT@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8399:EE_
x-ms-office365-filtering-correlation-id: 3a28445a-9293-44f7-e547-08dba00df680
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F78Af6+aDsdcRKT1HAsw+p0vtjGK0cTfCdwtMXimpErVv+Zhg/3FyZlL9OUuNBeat1OuqeSyJhVaSCLBpXD7lIZDvTBy2PNgI2ebv8uSmKaqkzqlRn0e7kf1JD+6tm5tIaZsquSEguJhpqYrRG3r4P58xTBJItl0IsF/YLy7A0dnS1fvDA9Ezq8797O4A8jM2V/KFNhDbuX5l6Ibp6sdh9T8INVqx4oESpVzte4TRTTZ3WA+3/mFlk+0JBpyhAU2Iz2GI7RCbryKJJFJtJu4BZN0Jyt+ku7/tcYPa3yQIQKe2ifXNWRMNZ8ZyKm1cIbAqF+tPp1lvsXZlLP9i0EPbwzjXQAm7Ab4O3fRYlFXoaI5OBCy3L8CbEpwjllVsFacWTGVEXj7Q8XG3YniJNiD7epgbF7iFZPLX5w4ZWoqInhQp5dL4dZGDGoo5Rn1uYoPlilLxvdGoFDdatbkmy3Sqef1DWhlqJPW05C+e8FChJ2bfTILuyvN9LXVpKdE8Z5XBL3NBmEY4avLD/5UPL1AxFjuSidi2ZdnoUVC03YAuD64SCf5AnXxri1HQvnHPp843teAJJNyQOI29dz7AhFG0W/qe2x+VX3/SIsEnek1VR4dfM9FqNjwZ8SDa02e4X6X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(33656002)(86362001)(55016003)(122000001)(316002)(64756008)(66446008)(66476007)(66946007)(66556008)(54906003)(478600001)(110136005)(76116006)(41300700001)(38100700002)(38070700005)(26005)(6506007)(71200400001)(9686003)(7696005)(53546011)(8676002)(52536014)(4326008)(5660300002)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDBSTFdIQW9YM2FzQWNXOTNtSkFIK0F4Rm9PZlU5aGYyQk5yY0FDZmJaYzM0?=
 =?utf-8?B?YWlTOFJ2RlBhRndGK21od3E4MFBTcDA1enhRUGo2cTQ4TEJFRXdpN2hlSXRs?=
 =?utf-8?B?b2NleTVmdzVJVytQR3VmUVNGVTFoTkpsaUdqcXozc25xYW1CWEZQTDFLUXh3?=
 =?utf-8?B?K2p6VEFPK3BESmdMZWdjTEdMeDVYc2s1QldLNmJhQVdUd1lpNTZYL0FZbzAw?=
 =?utf-8?B?Q0llTXpab2p6cjFoSEpmT29sWU1tYXlaSnVtR1FDcWVGMXhWNm1qL2pXcXZ2?=
 =?utf-8?B?VDd0eU1CcWloVjJSeW5iRFZwNFdwN0lsSSt6VjVRelNLWU92ZW5iaC9saWc5?=
 =?utf-8?B?Qm0rNHlXeEkrS3Zad3lkMmdoWVBZVzJHbXgvNWZSR2dOMWY5Zm1NNEp0Y000?=
 =?utf-8?B?RVhEMzVWU1FwdnVpUkVTOFNhYnBvZWxxK0tnWXo5alhaZlljTDB4N1Q3cHRH?=
 =?utf-8?B?ekoyRm9tYzJkcTdFSm9OOHJxVWVVZlUwMmxnaW1FMmtSMWtQVWFRaktSOGRj?=
 =?utf-8?B?dUo2aFpOZ0dXc2RQQ1RhYSthcmhhVnBEdnJNQnBGU2VYcENCeDYxMi9mUVVH?=
 =?utf-8?B?OVdIMTZMOVN3aSt3WGtXQlRaVUdJZFQwNU9aRWcvTG5pVmJTNnl3OTBLQThM?=
 =?utf-8?B?SE9jdWs5M1Z4NUZWVU43NC93VFJLVVI5RUZxOXAzc0ltVGN0akhtQlM2TDVC?=
 =?utf-8?B?UkFWSWVqcGdxQ3NRQzl4LzEzZkhYdXMzWklIbVhQQmtnc25xS1hHd20yQ2xE?=
 =?utf-8?B?bTVHeTMrS1dva0djcGxob2E5U1dUTEYxWDBxdTJZUWF3eXloT2wzbHhRR245?=
 =?utf-8?B?Y1h2Z1BoQnp2WmRFMi9DYmZyVXVMOGZZS050RmlwdGdkMU13U3JWbVhkSFBu?=
 =?utf-8?B?cG1ENGJidTU4ZnpTNHZaeGYxcEhkQTFGOE5BSS9HOUpPaGpVdnRpdmUwSVp3?=
 =?utf-8?B?LzRzeCs4QnNEWHZzeDJpN3dXVHJGY1hWVTVEU0JGd0FtM05JVVoxVGZ2aG9j?=
 =?utf-8?B?YWpxaHdXWnVkZTY1Ui9yUzBGTlY0bTdBQ2hUeHYwWFU2c2Fwd2kvY0ZteEJq?=
 =?utf-8?B?WGIxMm5yZU1YL1hRMi9GUHpFY253bXFhNGh3b3BrbytaSUJZNWo5VHk5Q0t1?=
 =?utf-8?B?SjBxdWdTc20zTHVCS1Y3WUQvR3UwZFVLVXQ2WFBnSTZFc0JhZk0zck9XTEd1?=
 =?utf-8?B?NDJuQUVsemVoUE5JM1hVbWFobGhSSi95OTNoM1o5ZEFRcHF5b1gwdk9tWDNM?=
 =?utf-8?B?OXZYRG1MeG5wWmt3aTVjT3BBZ0RzRjBoRG8vRnJXUWRNVkVvcHBPVmc3cTBi?=
 =?utf-8?B?NkVoVGNDYXd6OHE3Qng5MWovOE9yUWg2RzRVTVBBUTl2TXJuaUlEajkzcVV4?=
 =?utf-8?B?dDI1TVNEQU5QdEFONjNRdnlHa2wxL3BOWDJTVHZtenJuZHRTcWc5aDVzQ2VE?=
 =?utf-8?B?YklBSVkwUUF3eXZFNFUxNXd5SjlxcHNPMDlUNEFIOVVoZ3ZuZUhpeUtnY0RQ?=
 =?utf-8?B?cjcraUVyWEkxNWZjVDdheTd4THZvTllZc0lwMU1sM25JSzgzN09NNldCTVIz?=
 =?utf-8?B?WXpZS242Z0oyNE5Kb3c5RWgvVDBRT0FKRUxHRnlvL05XNXFaVVhhazVMbExP?=
 =?utf-8?B?QjlSdlQxUHRRMmRzNDM5OE5SS0Jqay95UFNyMHF3ZXEyUUZwTlR4VE5JQTV1?=
 =?utf-8?B?WGxOL2JSV2xkTEJGeUZHQWtPZFRLRGYycmgyeE1PbXBiSXJlU3R6VWszUXFZ?=
 =?utf-8?B?Y1RZQ2MvaVBCeEIvMGdPL0hmZ25hUG5RcEtvazRyVUY0UnRBM3Q5Q2RtSVFm?=
 =?utf-8?B?eHk4RjlEdFAxdTlPS0FpK01kTkdOOEE1WDVsWEFuM3J4Nmh2ZjFtdUVyNDE4?=
 =?utf-8?B?ZEZDQVIzZmRjN1N5V1lXOWdCeVNFUDE5TGxveE5KM1VPUzdpSVNXWjc4Tjh1?=
 =?utf-8?B?c2ptcjFJSDNhMU9XcXlrdTNUV1B0R3BHYkpMb01nRzhFWWh1YTdLeDMyZlY5?=
 =?utf-8?B?RExpSGlxRnVNV3pkSHZiSHQxTDA3MDFxaWRlTFA4ZVI2L2hWTHFqSUhSMjdC?=
 =?utf-8?B?OTI1Y3ZQVkZodzNSM0kzVzFUMmY1S01VWm5NbXkrUzRTcmxTQ2FiV0VYNFVE?=
 =?utf-8?Q?e3w7VhXHIHHrTSdss6I+jmqWd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a28445a-9293-44f7-e547-08dba00df680
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 17:10:03.3593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACbw2cuZIjLSFvr0kG3EYdrbSaJGGsGeQqif0MzJsrWcM+/IcibnHYqdz3cW+EjBOWriOlMv6GrXiu8vO45YukY3dF3VneqzY3zyA4WO2Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8399
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiA1LzVdIGlpbzogbWFnbmV0b21ldGVyOiBhazg5NzU6IFNvcnQgT0YgdGFibGUNCj4g
DQo+IE9uIEZyaSwgQXVnIDE4LCAyMDIzIGF0IDA1OjQzOjE1UE0gKzAyMDAsIEdlZXJ0IFV5dHRl
cmhvZXZlbiB3cm90ZToNCj4gPiBPbiBGcmksIEF1ZyAxOCwgMjAyMyBhdCA1OjM14oCvUE0gQW5k
eSBTaGV2Y2hlbmtvDQo+ID4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3Jv
dGU6DQo+ID4gPiBPbiBGcmksIEF1ZyAxOCwgMjAyMyBhdCAwNDo1NToxOFBNICswMjAwLCBHZWVy
dCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgQXVnIDE4LCAyMDIzIGF0IDE6
MzDigK9QTSBBbmR5IFNoZXZjaGVua28NCj4gPiA+ID4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4
LmludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCBBdWcgMTgsIDIwMjMgYXQgMDg6
NTY6MDBBTSArMDEwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gPiA+ID4gPiBTb3J0IE9GIHRhYmxl
IGFscGhhYmV0aWNhbGx5IGJ5IGNvbXBhdGlibGVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBT
dWdnZXN0ZWQtYnk6IEFuZHkgU2hldmNoZW5rbw0KPiA+ID4gPiA+ID4gPGFuZHJpeS5zaGV2Y2hl
bmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdyb25nLCBJIGhhdmVu
J3Qgc3VnZ2VzdGVkIHRoYXQuIFNlZSBjb21tZW50IHRvIHRoZSBwcmV2aW91cyBwYXRjaC4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEFuZCB0aGlzIGlzIGRlZmluaXRlbHkgd3JvbmcgYXMgR2VlcnQg
ZXhwbGFpbmVkIGFscmVhZHkgd2h5Lg0KPiA+ID4gPiA+IFlvdSBuZWVkIHRvIGZpeCB0aGUgY29k
ZSB0aGF0IGhhbmRsZXMgdGhlIElEIHRhYmxlIGZpcnN0Lg0KPiA+ID4gPg0KPiA+ID4gPiBJIHJl
dHJhY3RlZCBteSBvd24gY29tbWVudDoNCj4gPiA+ID4NCj4gPiA+ID4gVXBvbiBhIHNlY29uZCBy
ZWFkLCBJIGFncmVlIG15IHJlcGx5DQo+ID4gPiA+DQo+ID4gPiA+ICAgICBTZWVtcyBsaWtlIGl0
IGlzLCBjZnIuIHRoZSBzY29yaW5nIHN5c3RlbSBpbiBkcml2ZXJzL29mL2Jhc2UuYw0KPiA+ID4g
Pg0KPiA+ID4gPiB3YXMgY29uZnVzaW5nLCBhcyBpdCB3YXMgbm90IHN1cGVyIGNsZWFyIGlmIGl0
IHdhcyBhIHJlc3BvbnNlIHRvDQo+ID4gPiA+IHRoZSBmaXJzdCBvciB0aGUgc2Vjb25kIGxpbmUg
b2YgeW91ciBjb21tZW50Og0KPiA+ID4gPg0KPiA+ID4gPiAgICAgWW91IG1lYW4gdGhlIE9GIElE
IGxpc3QgbXVzdCBiZSBzcGVjaWZpY2FsbHkgb3JkZXJlZD8hIFdoYXQgYQ0KPiA+ID4gPiBuaWNl
IG1pbmVmaWVsZCENCj4gPiA+ID4gICAgIFRoaXMgaGFzIHRvIGJlIGZpeGVkIHNvbWV3aGVyZSBl
bHNlLCBzdXJlbHkuDQo+ID4gPiA+DQo+ID4gPiA+IENvbmNsdXNpb246IHRoZXJlIGlzIG5vIGlz
c3VlLCB0aGUgc2NvcmluZyBzeXN0ZW0gaGFuZGxlcyBwcmltYXJ5DQo+ID4gPiA+IHZzLiBmYWxs
YmFjayBjb21wYXRpYmxlIHZhbHVlcywgaXJyZXNwZWN0aXZlIG9mIG9yZGVyaW5nLg0KPiA+ID4N
Cj4gPiA+IE5vdyBJJ20gdG90YWxseSBjb25mdXNlZC4gUHJldmlvdXNseSB5b3UgbWVudGlvbmVk
IGEgY291cGxlIG9mDQo+ID4gPiBkaWZmZXJlbnQgQVBJcyDigJQgb25lIGluIE9GLCBvbmUgaW4g
U29DLiBBRkFJVSB0aGUgc2Vjb25kIG9uZSBzdGlsbA0KPiA+ID4gbmVlZHMgdG8gYmUgZml4ZWQg
dG8gZm9sbG93IHRoZSBsb2dpYyB0aGF0IE9GIGRvZXMuDQo+ID4gPg0KPiA+ID4gTXkgcHJldmlv
dXMgdW5kZXJzdGFuZGluZyB3YXMgdGhhdA0KPiA+ID4gICBPRiBjb2RlIOKAlCBubyBpc3N1ZQ0K
PiA+ID4gICBTb0MgY29kZSDigJQgdGhlIG9yZGVyaW5nIGlzIHJlcXVpcmVkIHRvIGJlIGNvcnJl
Y3QNCj4gPg0KPiA+IENvcnJlY3QuDQo+ID4NCj4gPiA+IENhbiB5b3UgY29uZmlybSB0aGF0IHRo
ZXJlIGlzIG5vIGlzc3VlIGluIHRoYXQgc2Vjb25kIGNhc2U/DQo+ID4gPiBBbmQgaWYgdGhlcmUg
aXMgbm9uZSwgd2h5IGRpZCB5b3UgbWVudGlvbiBpdD8NCj4gPg0KPiA+IFRoZXJlIGlzIHN0aWxs
IGFuIGlzc3VlIChyZWFkOiB5b3UgaGF2ZSB0byBiZSBjYXJlZnVsKSBpbiB0aGUgc2Vjb25kDQo+
ID4gY2FzZSwgd2hpY2ggZG9lcyBub3QgbWF0dGVyIGhlcmUsIGFzIHRoaXMgZHJpdmVyIGRvZXMg
bm90IHVzZQ0KPiA+IHNvY19kZXZpY2VfbWF0Y2goKS4NCj4gPiBJIG1lbnRpb25lZCBzb2NfZGV2
aWNlX21hdGNoKCkgYmVjYXVzZSBpdCBpcyB0aGUgc2Vjb25kIHBvcHVsYXIgd2F5IHRvDQo+ID4g
bWF0Y2ggb24gT0YgcGxhdGZvcm1zLCBidXQgYmVoYXZlcyBzbGlnaHRseSBkaWZmZXJlbnQgdGhh
bg0KPiA+IG9mX21hdGNoX25vZGUoKS4NCj4gDQo+IE5vdyBpdCdzIGNsZWFyLCB0aGFua3MuDQo+
IEJpanUsIHBsZWFzZSBhZGQgdGhhdCB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCk9LLCB3aWxs
IG1lbnRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFib3V0ICJzb2NfZGV2aWNlX21hdGNoIi4N
Cg0KQ2hlZXJzLA0KQmlqdQ0K
