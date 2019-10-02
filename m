Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152FCC890D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 14:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfJBMyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 08:54:16 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:8292 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfJBMyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 08:54:15 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92CqhLq023926;
        Wed, 2 Oct 2019 08:53:47 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2050.outbound.protection.outlook.com [104.47.49.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2va456dd05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 08:53:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYLyVXiWVFGmOjqn/FunH87GxMdWAWacjX5EO7UT4MF9Tb4FhVH3tnU7F9YqIfzEd60xblKvkqgJjNK6zR6MuK9k1SRQHzX+RCxM6ukBwGstmp5yvCwC+Q7xq0UZF5JNjdeVng9/EQaxHU9XmYgt2tQsD4AoZqbIbbT2XfUQowomJVsZg8aeHw5h8Na213cr4wzEfOJMDCtKCU9WqahQCpx/Mr1+lSDwbAuyT1zJwk/D/TrkA8YECT7nA+kgZaSyRi0UEDwLMYNeHw14wimBNKgMqJXk/MvTUV+M3PGYAGOzPYeNf4FJmQw9w0wLEICL/NXvuoThCsLMRfTxhKukcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z84kIMnSMQBgkpKKBraongjgpuf1lPj+gKLq70iOg+k=;
 b=gNsmYXaO+LstFaWjCGRHWkj1FHOXblGYu2E528Xyw/D0hp9Qetv7Y92P6k5gihe+PfIexdq0ONdY2ku1S8W6fk+MmmLisUXsxHLKF4NnS4oJTc3Skfvd3qI9staqn5fs67zusmGOvSjou8cKE7vOkuEMrKmoaJc2LaCzBypaz3WY/pSpnpLqHVoDQ0c2fB+zdvL1SXRRWGpzM1VPxIYz74yxj7aVwsCNd/648ObcW4XmL4xxyg66zyuQcgJ/1bBoPptuSFSLrbWRhtsiNLYOYcZB06EX9bnGdzOw6O/eIJM1grlekqN2nLLJToEcPcCw3DmQPqrPFCC6AIsZsAStxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z84kIMnSMQBgkpKKBraongjgpuf1lPj+gKLq70iOg+k=;
 b=JNfoSPdIByn1UsWGZjiKbxVi3+/aO+UmG63zq5Hupcsy3B0ezV3YkXbNixuZd1T+SfS86dKP1YlyKwXKhhn7ExmxuwSDEbJTF9b3SvKoQfxitFXZ9Bn3BgBOirXdGeJ1rJ2mgFc094izRBfFKSx6YnDhla1FgAYka5bbsOKkIRo=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.171.137) by
 MN2PR03MB4751.namprd03.prod.outlook.com (20.179.83.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 12:53:45 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::6006:4c13:a8c1:b359]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::6006:4c13:a8c1:b359%4]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 12:53:45 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RESEND PATCH v2 2/2] dt-bindings: iio: Add ltc2983 documentation
Thread-Topic: [RESEND PATCH v2 2/2] dt-bindings: iio: Add ltc2983
 documentation
Thread-Index: AQHVd3vg84rVTe40c0yJcD6YTDZANadFgsWAgAHPOYA=
Date:   Wed, 2 Oct 2019 12:53:44 +0000
Message-ID: <2f2748b81a353fb91b6b1a07382a9fe29c17fb44.camel@analog.com>
References: <20190930104247.21519-1-nuno.sa@analog.com>
         <20190930104247.21519-2-nuno.sa@analog.com>
         <20191001101613.50d825a9@archlinux>
In-Reply-To: <20191001101613.50d825a9@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 949e3dfa-024a-4d86-5356-08d747378f73
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR03MB4751:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <MN2PR03MB47511B4954BCEE88CCA1882D999C0@MN2PR03MB4751.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(26005)(66556008)(66946007)(66476007)(64756008)(66446008)(91956017)(76116006)(8936002)(66066001)(71190400001)(54906003)(76176011)(36756003)(71200400001)(14454004)(478600001)(3846002)(6916009)(186003)(316002)(2501003)(2616005)(25786009)(476003)(966005)(6116002)(446003)(11346002)(229853002)(6486002)(4326008)(6436002)(2906002)(6512007)(6306002)(5660300002)(2351001)(486006)(99286004)(305945005)(6506007)(81156014)(7736002)(102836004)(81166006)(30864003)(6246003)(256004)(86362001)(5640700003)(118296001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4751;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsVecH8hHYKSIqx6Mw09hVde4XkuJeLZRvlcGBe8QWgO5qlP5azZqTK3AA/QbQjWiPiZoegIbdtiOGHpCkQB22ddygB8XYkYKjDPPGoPd6opKwmaldaS7jdF8fbtP8hDRG60pfRgpb/z2WCbgLzENSn11zuMNb12yKHCvTCtgMoGpMimc9ch2EP+Xw9V0nfAUtiG+ySUh3a4a+0BgJ7O46aOI10UL8uMTGxHpG6kl06V9+5pBzsgMB36a4l+jkSS7/EhgSU/NLQpBxIdscuPnvSa24HiCu+BRCVa8GfEMEXtKo5TTYOvY4c7D/Gs/TDxwbcG9ybpKRf2bGJ1wOVcehjy/wJKLysfHi0ve6Ua4Mev6ttr6fVtuYZSAarbj0+aQwLS/6W2FKFStf5eCi4t/iwZqriIyN/ANahXS1sOTUutX9c+sm7uiO5nxNnj1qnH4gbuqGwTxLhzDzDa2Q76aQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A918EC62A068C4592E3E1672C94365F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949e3dfa-024a-4d86-5356-08d747378f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 12:53:44.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJnGjRotfwsGW0inKEy/D/jI4BeHeiSwTUREYCgSQzFL2IN5uZodQiLRwkL84sOjS+z+yFi9ok4zqlePBwI0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4751
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_06:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTAxIGF0IDEwOjE2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiANCj4gT24gTW9uLCAzMCBTZXAgMjAxOSAxMjo0Mjo0NyArMDIwMA0KPiBOdW5vIFPDoSA8
bnVuby5zYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+ID4gRG9jdW1lbnQgdGhlIExUQzI5ODMg
dGVtcGVyYXR1cmUgc2Vuc29yIGRldmljZXRyZWUgYmluZGluZ3MuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gDQo+IEhpIE51bm8sDQo+
IA0KPiBBIGZldyBjb21tZW50cyBpbmxpbmUuICBUaGlzIGlzIGEgY29tcGxleCBvbmUgc28gSSds
bCBkZWZpbml0ZWx5IGJlDQo+IGxvb2tpbmcgZm9yIGEgcmV2aWV3IGZyb20gUm9iIG9yIE1hcmss
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2Vz
IGluIHYyOg0KPiA+ICAqIERyb3AgbWF4SXRlbXMgaW4gbm9uLWFycmF5IGVsZW1lbnRzOw0KPiA+
ICAqIFNldCBhZGksbXV4LWRlbGF5LWNvbmZpZy11cyBpbnN0ZWFkIG9mIGFkaSxtdXgtZGVsYXkt
Y29uZmlnOw0KPiA+ICAqIFdyYXBwZWQgbGluZXMgYXQgODAgY2hhcjsNCj4gPiAgKiBBZGRlZCBj
b21hcyB0byBlbnVtIGVsZW1lbnRzOw0KPiA+ICAqIFVzZSByZWFsIHVuaXRzIGluIGFkaSxleGNp
dGF0aW9uLWN1cnJlbnQ7DQo+ID4gICogTW92ZWQgc29tZSBlbnVtcyB0byBtaW5pbXVtIGFuZCBt
YXhpbXVtOw0KPiA+ICAqIEdyb3VwZWQgcGF0dGVyblByb3BlcnRpZXMgYW5kIG1vdmVkIHJlZyBw
cm9wZXJ0eSBhcyBhIGdlbmVyaWMNCj4gPiBwcm9wZXJ0eS4NCj4gPiANCj4gPiAgLi4uL2JpbmRp
bmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4My55YW1sIHwgNDA2DQo+ID4gKysrKysrKysr
KysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNDA3IGluc2VydGlvbnMoKykNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4My55YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVy
ZS9hZGksbHRjMjk4My55YW0NCj4gPiBsDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaWlvL3RlbXBlcmF0dXJlL2FkaSxsdGMyOTgzLnlhbQ0KPiA+IGwNCj4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZGY2OGI4MjMzZTVlDQo+
ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKw0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4My55YW0NCj4gPiBsDQo+ID4gQEAg
LTAsMCArMSw0MDYgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0K
PiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+ID4gaHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvaWlvL3RlbXBlcmF0dXJlL2FkaSxsdGMyOTgzLnlhbWwjDQo+ID4gKyRz
Y2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+
ICsNCj4gPiArdGl0bGU6IEFuYWxvZyBEZXZpY2VzIExUQzI5ODMgTXVsdGktc2Vuc29yIFRlbXBl
cmF0dXJlIHN5c3RlbQ0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBOdW5vIFPD
oSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiAr
ICBBbmFsb2cgRGV2aWNlcyBMVEMyOTgzIE11bHRpLVNlbnNvciBEaWdpdGFsIFRlbXBlcmF0dXJl
DQo+ID4gTWVhc3VyZW1lbnQgU3lzdGVtDQo+ID4gKyAgDQo+ID4gaHR0cHM6Ly93d3cuYW5hbG9n
LmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRhLXNoZWV0cy8yOTgzZmMu
cGRmDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAg
ICBlbnVtOg0KPiA+ICsgICAgICAtIGFkaSxsdGMyOTgzDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4g
PiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBt
YXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBhZGksdGVtcGVyYXR1cmUtY2VsY2l1czoNCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBJZiB0aGlzIHByb3BlcnR5IGlzIHByZXNlbnQs
IHRoZSB0ZW1wZXJhdHVyZSBpcyByZXBvcnRlZCBpbg0KPiA+IENlbHNpdXMuDQo+ID4gKyAgICB0
eXBlOiBib29sZWFuDQo+ID4gKw0KPiA+ICsgIGFkaSxtdXgtZGVsYXktY29uZmlnLXVzOg0KPiA+
ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFRoZSBMVEMyOTgzIHBlcmZvcm1zIDIgb3Ig
MyBpbnRlcm5hbCBjb252ZXJzaW9uIGN5Y2xlcyBwZXINCj4gPiB0ZW1wZXJhdHVyZQ0KPiA+ICsg
ICAgICByZXN1bHQuIEVhY2ggY29udmVyc2lvbiBjeWNsZSBpcyBwZXJmb3JtZWQgd2l0aCBkaWZm
ZXJlbnQNCj4gPiBleGNpdGF0aW9uIGFuZA0KPiA+ICsgICAgICBpbnB1dCBtdWx0aXBsZXhlciBj
b25maWd1cmF0aW9ucy4gUHJpb3IgdG8gZWFjaCBjb252ZXJzaW9uLA0KPiA+IHRoZXNlDQo+ID4g
KyAgICAgIGV4Y2l0YXRpb24gY2lyY3VpdHMgYW5kIGlucHV0IHN3aXRjaCBjb25maWd1cmF0aW9u
cyBhcmUNCj4gPiBjaGFuZ2VkIGFuZCBhbg0KPiA+ICsgICAgICBpbnRlcm5hbCAxbXMgZGVsYXkg
ZW5zdXJlcyBzZXR0bGluZyBwcmlvciB0byB0aGUgY29udmVyc2lvbg0KPiA+IGN5Y2xlIGluIG1v
c3QNCj4gPiArICAgICAgY2FzZXMuIEFuIGV4dHJhIGRlbGF5IGNhbiBiZSBjb25maWd1cmVkIHVz
aW5nIHRoaXMgcHJvcGVydHkuDQo+ID4gVGhlIHZhbHVlIGlzDQo+ID4gKyAgICAgIHJvdW5kZWQg
dG8gbmVhcmVzdCAxMDB1cy4NCj4gPiArICAgIGFsbE9mOg0KPiA+ICsgICAgICAtICRyZWY6IC9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgICAtIG1heGlt
dW06IDI1NQ0KPiA+ICsNCj4gPiArICBhZGksZmlsdGVyLW5vdGNoLWZyZXE6DQo+ID4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPiArICAgICAgU2V0J3MgdGhlIGRlZmF1bHQgc2V0dGluZyBvZiB0aGUg
ZGlnaXRhbCBmaWx0ZXIuIFRoZSBkZWZhdWx0DQo+ID4gaXMNCj4gPiArICAgICAgc2ltdWx0YW5l
b3VzIDUwLzYwSHogcmVqZWN0aW9uLg0KPiA+ICsgICAgYWxsT2Y6DQo+ID4gKyAgICAgIC0gJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICAgIC0g
bWluaW11bTogMA0KPiA+ICsgICAgICAtIG1heGltdW06IDINCj4gDQo+IFRoaXMgb25lIGlzIGFu
IG9kZGl0eSBhbmQgeW91IHNob3VsZCBkZWZpbmUgd2hhdCB0aGUgMyB2YWx1ZXMgbWVhbi4NCj4g
SWYgdGhlIHNlbnNvciBoYWQgc3VwcG9ydGVkIG5vIG5vdGNoIHJlamVjdGlvbiBhdCBhbGwgcmF0
aGVyIHRoYW4NCj4ganVzdA0KPiA1MCwgNjAsIDUwLzYwIEkgd291bGQgaGF2ZSBzdWdnZXN0ZWQg
dHdvIGJvb2xzIGJ1dCBhcyBpdCBzdGFuZHMgSQ0KPiBndWVzcw0KPiB0aGlzIHdpbGwganVzdCBu
ZWVkIHRvIGJlIGFuIGVudW0uDQoNClllcywgSSBndWVzcyB3ZSBuZWVkIHRoZSBlbnVtIG9yIGxp
a2UgaXQgaXMgcmlnaHQga25vdy4gSSB3aWxsIGFkZA0KbWVhbmluZyB0byB0aGUgdmFsdWVzLg0K
DQo+ID4gKw0KPiA+ICsgICcjYWRkcmVzcy1jZWxscyc6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+
ICsNCj4gPiArICAnI3NpemUtY2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDANCj4gPiArDQo+ID4g
K3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICsgICIuKkAoWzEtOV18MVswLTldfDIwKSQiOg0KPiA+
ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gKw0KPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiArICAg
ICAgcmVnOg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgICAgICBUaGUg
Y2hhbm5lbCBudW1iZXIuIEl0IGNhbiBiZSBjb25uZWN0ZWQgdG8gb25lIG9mIHRoZSAyMA0KPiA+
IGNoYW5uZWxzIG9mDQo+ID4gKyAgICAgICAgICB0aGUgZGV2aWNlLg0KPiA+ICsgICAgICAgIG1p
bmltdW06IDENCj4gPiArICAgICAgICBtYXhpbXVtOiAyMA0KPiA+ICsNCj4gPiArICAgIHJlcXVp
cmVkOg0KPiA+ICsgICAgICAtIHJlZw0KPiA+ICsNCj4gPiArICAgIHBhdHRlcm5Qcm9wZXJ0aWVz
Og0KPiA+ICsgICAgICAiXnRoZXJtb2NvdXBsZUAuKiI6DQo+ID4gKyAgICAgICAgdHlwZTogb2Jq
ZWN0DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgIFJlcHJlc2Vu
dHMgYSB0aGVybW9jb3VwbGUgc2Vuc29yIHdoaWNoIGlzIGNvbm5lY3RlZCB0bw0KPiA+IG9uZSBv
ZiB0aGUgZGV2aWNlDQo+ID4gKyAgICAgICAgICBjaGFubmVscy4NCj4gPiArDQo+ID4gKyAgICAg
ICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICAgIGFkaSxzZW5zb3ItdHlwZToNCj4gPiArICAg
ICAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgICAgICBJZGVudGlmaWVzIHRo
ZSB0eXBlIG9mIHRoZXJtb2NvdXBsZSBjb25uZWN0ZWQgdG8gdGhlDQo+ID4gZGV2aWNlLg0KPiA+
ICsgICAgICAgICAgICBhbGxPZjoNCj4gPiArICAgICAgICAgICAgICAtICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgICAgICAgICAgIC0gbWlu
aW11bTogMQ0KPiA+ICsgICAgICAgICAgICAgIC0gbWF4aW11bTogOA0KPiANCj4gTWVhbmluZyBv
ZiB2YWx1ZXMgc2hvdWxkIGJlIGRlZmluZWQuLi4NCg0KYWNrLg0KDQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgYWRpLHNlbnNvci1jb25maWc6DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiB8
DQo+ID4gKyAgICAgICAgICAgICAgUmF3IHZhbHVlIHdoaWNoIHNldCdzIHRoZSBzZW5zb3IgY29u
ZmlndXJhdGlvbi4gTG9vaw0KPiA+IGF0IHRhYmxlIDE0DQo+ID4gKyAgICAgICAgICAgICAgb2Yg
dGhlIGRhdGFzaGVldCBmb3IgaG93IHRvIHNldCB0aGlzIHZhbHVlIGZvcg0KPiA+IHRoZXJtb2Nv
dXBsZXMuDQo+ID4gKyAgICAgICAgICAgIGFsbE9mOg0KPiA+ICsgICAgICAgICAgICAgIC0gJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICAgICAg
ICAgICAgLSBtaW5pbXVtOiAxDQo+ID4gKyAgICAgICAgICAgICAgLSBtYXhpbXVuOiAxNQ0KPiBI
bW0uICBXaGlsc3QgdGhlcmUgYXJlIHF1aXRlIGEgZmV3IHRoaW5ncyBpbiBoZXJlLCBpdCB3b3Vs
ZCBiZSBuaWNlDQo+IHRvIGJyZWFrIGl0IHVwDQo+IGludG8gaHVtYW4gcmVhZGFibGUgZWxlbWVu
dHMuICBJdCdzIG9ubHkgMyB0aGluZ3MgYW5kIHRoZXJlIGFyZSBhDQo+IGJ1bmNoIG9mIGRvbid0
DQo+IGNhcmUgc3RhdGVzIGl0IHNlZW1zLg0KDQpZZXMsIG5vdyB0aGF0IEkgZ2F2ZSBpdCBtb3Jl
IHRob3VnaHQsIEkgc2VlIEkgd2FzIGxhenkgaGVyZS4gSSB3aWxsDQpyZXBsYWNlIHRoaXMgcHJv
cGVydHkgd2l0aCAyIG90aGVyIHByb3BlcnRpZXMuIEEgYm9vbGVhbiBmb3Igc2luZ2xlLQ0KRW5k
ZWQgYW5kIGFub3RoZXIgdWludDMyIHByb3AgZm9yIG9wZW4tY2lyY3VpdC1jdXJyZW50LiBXaXRo
IHRob3NlIDINCnByb3BlcnRpZXMgSSBjYW4gc2V0IHRoZSBzZW5zb3ItY29uZmlnIGJpdHMuDQog
DQo+ID4gKw0KPiA+ICsgICAgICAgICAgYWRpLGNvbGQtanVuY3Rpb24taGFuZGxlOg0KPiA+ICsg
ICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgICAgIFBoYW5kbGUgd2hp
Y2ggcG9pbnRzIHRvIGEgc2Vuc29yIG9iamVjdCByZXNwb25zaWJsZQ0KPiA+IGZvciBtZWFzdXJp
bmcNCj4gPiArICAgICAgICAgICAgICB0aGUgdGhlcm1vY291cGxlIGNvbGQganVuY3Rpb24gdGVt
cGVyYXR1cmUuDQo+ID4gKyAgICAgICAgICAgICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy9waGFuZGxlIg0KPiA+ICsNCj4gPiArICAgICAgICAgIGFkaSxjdXN0b20tc2Vu
c29yOg0KPiA+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgICAg
IFRoaXMgaXMgYSB0YWJsZSwgd2hlcmUgZWFjaCBlbnRyeSBzaG91bGQgYmUgYSBwYWlyDQo+ID4g
b2YNCj4gPiArICAgICAgICAgICAgICB2b2x0YWdlKG12KS10ZW1wZXJhdHVyZShLKS4gVGhlIGVu
dHJpZXMgbXVzdCBiZQ0KPiA+IGdpdmVuIGluIG52IGFuZCB1Sw0KPiA+ICsgICAgICAgICAgICAg
IHNvIHRoYXQsIHRoZSBvcmlnaW5hbCB2YWx1ZXMgbXVzdCBiZSBtdWx0aXBsaWVkIGJ5DQo+ID4g
MTAwMDAwMC4gRm9yDQo+ID4gKyAgICAgICAgICAgICAgbW9yZSBkZXRhaWxzIGxvb2sgYXQgdGFi
bGUgNjkgYW5kIDcwLg0KPiA+ICsgICAgICAgICAgICBhbGxPZjoNCj4gPiArICAgICAgICAgICAg
ICAtICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ludDY0LWFycmF5DQo+
ID4gKyAgICAgICAgICAgICAgLSBtaW5JdGVtczogNg0KPiA+ICsgICAgICAgICAgICAgIC0gbWF4
SXRlbXM6IDEyOA0KPiA+ICsNCj4gPiArICAgICAgICByZXF1aXJlZDoNCj4gPiArICAgICAgICAg
IC0gYWRpLHNlbnNvci10eXBlDQo+ID4gKw0KPiA+ICsgICAgICAiXmRpb2RlQC4qIjoNCj4gPiAr
ICAgICAgICB0eXBlOiBvYmplY3QNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsg
ICAgICAgICAgUmVwcmVzZW50cyBhIGRpb2RlIHNlbnNvciB3aGljaCBpcyBjb25uZWN0ZWQgdG8g
b25lIG9mDQo+ID4gdGhlIGRldmljZQ0KPiA+ICsgICAgICAgICAgY2hhbm5lbHMuDQo+ID4gKw0K
PiA+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgICBhZGksc2Vuc29yLXR5cGU6
DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiBJZGVudGlmaWVzIHRoZSBzZW5zb3IgYXMg
YSBkaW9kZS4NCj4gPiArICAgICAgICAgICAgY29uc3Q6IDI4DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgYWRpLHNlbnNvci1jb25maWc6DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+
ID4gKyAgICAgICAgICAgICAgUmF3IHZhbHVlIHdoaWNoIHNldCdzIHRoZSBzZW5zb3IgY29uZmln
dXJhdGlvbi4gTG9vaw0KPiA+IGF0IHRhYmxlIDE3DQo+ID4gKyAgICAgICAgICAgICAgb2YgdGhl
IGRhdGFzaGVldCBmb3IgaG93IHRvIHNldCB0aGlzIHZhbHVlIGZvcg0KPiA+IGRpb2Rlcy4NCj4g
PiArICAgICAgICAgICAgYWxsT2Y6DQo+ID4gKyAgICAgICAgICAgICAgLSAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgICAgICAgICAgICAtIG1p
bmltdW06IDANCj4gPiArICAgICAgICAgICAgICAtIG1heGltdW06IDcNCj4gQW5vdGhlciBvbmUg
SSdkIGxpa2UgdG8gc2VlIGJyb2tlbiB1cC4NCg0KYWNrLiBJIGNhbiB1c2UgMyBib29sZWFucyBo
ZXJlLg0KDQo+ID4gKw0KPiA+ICsgICAgICAgICAgYWRpLGV4Y2l0YXRpb24tY3VycmVudC1taWNy
b2FtcDoNCj4gPiArICAgICAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgICAg
ICBUaGlzIHByb3BlcnR5IGNvbnRyb2xzIHRoZSBtYWduaXR1ZGUgb2YgdGhlDQo+ID4gZXhjaXRh
dGlvbiBjdXJyZW50DQo+ID4gKyAgICAgICAgICAgICAgYXBwbGllZCB0byB0aGUgZGlvZGUuIERl
cGVuZGluZyBvbiB0aGUgbnVtYmVyIG9mDQo+ID4gY29udmVyc2lvbnMNCj4gPiArICAgICAgICAg
ICAgICBjeWNsZXMsIHRoaXMgcHJvcGVydHkgd2lsbCBhc3N1bWUgZGlmZmVyZW50DQo+ID4gcHJl
ZGVmaW5lZCB2YWx1ZXMgb24NCj4gPiArICAgICAgICAgICAgICBlYWNoIGN5Y2xlLiBKdXN0IHNl
dCB0aGUgdmFsdWUgb2YgdGhlIGZpcnN0IGN5Y2xlDQo+ID4gKDFsKS4NCj4gPiArICAgICAgICAg
ICAgYWxsT2Y6DQo+ID4gKyAgICAgICAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgICAgICAgICAgICAtIGVudW06IFsxMCwgMjAs
IDQwLCA4MF0NCj4gPiArDQo+ID4gKyAgICAgICAgICBhZGksaWRlYWwtZmFjdG9yLXZhbHVlOg0K
PiA+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgICAgIFRoaXMg
cHJvcGVydHkgc2V0cyB0aGUgZGlvZGUgaWRlYWxpdHkgZmFjdG9yLiBUaGUNCj4gPiByZWFsIHZh
bHVlIG11c3QNCj4gPiArICAgICAgICAgICAgICBiZSBtdWx0aXBsaWVkIGJ5IDEwMDAwMDAgdG8g
cmVtb3ZlIHRoZSBmcmFjdGlvbmFsDQo+ID4gcGFydC4gRm9yIG1vcmUNCj4gPiArICAgICAgICAg
ICAgICBpbmZvcm1hdGlvbiBsb29rIGF0IHRhYmxlIDIwIG9mIHRoZSBkYXRhc2hlZXQuDQo+ID4g
KyAgICAgICAgICAgIGFsbE9mOg0KPiA+ICsgICAgICAgICAgICAgIC0gJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKw0KPiA+ICsgICAgICAgIHJlcXVp
cmVkOg0KPiA+ICsgICAgICAgICAgLSBhZGksc2Vuc29yLXR5cGUNCj4gPiArDQo+ID4gKyAgICAg
ICJecnRkQC4qIjoNCj4gPiArICAgICAgICB0eXBlOiBvYmplY3QNCj4gPiArICAgICAgICBkZXNj
cmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgUmVwcmVzZW50cyBhIHJ0ZCBzZW5zb3Igd2hpY2gg
aXMgY29ubmVjdGVkIHRvIG9uZSBvZiB0aGUNCj4gPiBkZXZpY2UgY2hhbm5lbHMuDQo+ID4gKw0K
PiA+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgICByZWc6DQo+ID4gKyAgICAg
ICAgICAgIG1pbmltdW06IDINCj4gPiArDQo+ID4gKyAgICAgICAgICBhZGksc2Vuc29yLXR5cGU6
DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiBJZGVudGlmaWVzIHRoZSB0eXBlIG9mIFJU
RCBjb25uZWN0ZWQgdG8NCj4gPiB0aGUgZGV2aWNlLg0KPiA+ICsgICAgICAgICAgICBhbGxPZjoN
Cj4gPiArICAgICAgICAgICAgICAtICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMg0KPiA+ICsgICAgICAgICAgICAgIC0gbWluaW11bTogMTANCj4gPiArICAgICAg
ICAgICAgICAtIG1heGltdW06IDE3DQo+ID4gKw0KPiA+ICsgICAgICAgICAgYWRpLHJzZW5zZS1o
YW5kbGU6DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgICAgICAg
ICAgUGhhbmRsZSBwb2ludGluZyB0byBhIHJzZW5zZSBvYmplY3QgYXNzb2NpYXRlZCB3aXRoDQo+
ID4gdGhpcyBSVEQuDQo+ID4gKyAgICAgICAgICAgICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy9waGFuZGxlIg0KPiA+ICsNCj4gPiArICAgICAgICAgIGFkaSxzZW5zb3It
Y29uZmlnOg0KPiA+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAg
ICAgIFJhdyB2YWx1ZSB3aGljaCBzZXQncyB0aGUgc2Vuc29yIGNvbmZpZ3VyYXRpb24uIExvb2sN
Cj4gPiBhdCB0YWJsZSAyOA0KPiA+ICsgICAgICAgICAgICAgIG9mIHRoZSBkYXRhc2hlZXQgZm9y
IGhvdyB0byBzZXQgdGhpcyB2YWx1ZSBmb3INCj4gPiBSVEQncy4NCj4gPiArICAgICAgICAgICAg
YWxsT2Y6DQo+ID4gKyAgICAgICAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgICAgICAgICAgICAtIGVudW06IFswLCAxLCA0LCA1
LCA4LCA5LCAxMCwgMTIsIDEzLCAxNF0NCj4gDQo+IEFub3RoZXIgb25lIHRvIGJyZWFrIHVwIGlu
dG8gaXQncyBwYXJ0cywgd2hpY2ggd291bGQgYWxzbyBnZXQgcmlkIG9mDQo+IHRoZQ0KPiBlbnVt
IHdpdGggZ2FwcyBlbGVtZW50Lg0KDQpXaWxsIGRvIHRoYXQuDQoNCj4gDQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgYWRpLGV4Y2l0YXRpb24tY3VycmVudC1taWNyb2FtcDoNCj4gPiArICAgICAgICAg
ICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgICAgICBUaGlzIHByb3BlcnR5IGNvbnRy
b2xzIHRoZSBtYWduaXR1ZGUgb2YgdGhlDQo+ID4gZXhjaXRhdGlvbiBjdXJyZW50DQo+ID4gKyAg
ICAgICAgICAgICAgYXBwbGllZCB0byB0aGUgUlRELg0KPiA+ICsgICAgICAgICAgICBhbGxPZjoN
Cj4gPiArICAgICAgICAgICAgICAtICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMg0KPiA+ICsgICAgICAgICAgICAgIC0gZW51bTogWzUsIDEwLCAyNSwgNTAsIDEw
MCwgMjUwLCA1MDAsIDEwMDBdDQo+ID4gKw0KPiA+ICsgICAgICAgICAgYWRpLHJ0ZC1jdXJ2ZToN
Cj4gPiArICAgICAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgICAgICBUaGlz
IHByb3BlcnR5IHNldCB0aGUgUlREIGN1cnZlIHVzZWQgYW5kIHRoZQ0KPiA+IGNvcnJlc3BvbmRp
bmcNCj4gPiArICAgICAgICAgICAgICBDYWxsZW5kYXItVmFuRHVzZW4gY29uc3RhbnRzLiBMb29r
IGF0IHRhYmxlIDMwIG9mDQo+ID4gdGhlIGRhdGFzaGVldC4NCj4gPiArICAgICAgICAgICAgYWxs
T2Y6DQo+ID4gKyAgICAgICAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy91aW50MzINCj4gPiArICAgICAgICAgICAgICAtIG1pbmltdW06IDANCj4gPiArICAg
ICAgICAgICAgICAtIG1heGltdW06IDMNCj4gPiArDQo+ID4gKyAgICAgICAgICBhZGksY3VzdG9t
LXNlbnNvcjoNCj4gPiArICAgICAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAg
ICAgICBUaGlzIGlzIGEgdGFibGUsIHdoZXJlIGVhY2ggZW50cnkgc2hvdWxkIGJlIGEgcGFpcg0K
PiA+IG9mDQo+ID4gKyAgICAgICAgICAgICAgcmVzaXN0YW5jZShvaG0pLXRlbXBlcmF0dXJlKEsp
LiBUaGUgZW50cmllcyBhZGRlZA0KPiA+IGhlcmUgYXJlIGluIHVvaG0NCj4gPiArICAgICAgICAg
ICAgICBhbmQgdUsuIEZvciBtb3JlIGRldGFpbHMgdmFsdWVzIGxvb2sgYXQgdGFibGUgNzQgYW5k
DQo+ID4gNzUuDQo+ID4gKyAgICAgICAgICAgIGFsbE9mOg0KPiA+ICsgICAgICAgICAgICAgIC0g
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDY0LQ0KPiA+IGFycmF5
DQo+ID4gKyAgICAgICAgICAgICAgLSBtaW5JdGVtczogNg0KPiA+ICsgICAgICAgICAgICAgIC0g
bWF4SXRlbXM6IDEyOA0KPiA+ICsNCj4gPiArICAgICAgICByZXF1aXJlZDoNCj4gPiArICAgICAg
ICAgIC0gYWRpLHNlbnNvci10eXBlDQo+ID4gKyAgICAgICAgICAtIGFkaSxyc2Vuc2UtaGFuZGxl
DQo+ID4gKw0KPiA+ICsgICAgICAiXnRoZXJtaXN0b3JALioiOg0KPiA+ICsgICAgICAgIHR5cGU6
IG9iamVjdA0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgICAgICBSZXBy
ZXNlbnRzIGEgdGhlcm1pc3RvciBzZW5zb3Igd2hpY2ggaXMgY29ubmVjdGVkIHRvIG9uZQ0KPiA+
IG9mIHRoZSBkZXZpY2UNCj4gPiArICAgICAgICAgIGNoYW5uZWxzLg0KPiA+ICsNCj4gPiArICAg
ICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICAgYWRpLHNlbnNvci10eXBlOg0KPiA+ICsg
ICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgICAgIElkZW50aWZpZXMg
dGhlIHR5cGUgb2YgdGhlcm1pc3RvciBjb25uZWN0ZWQgdG8gdGhlDQo+ID4gKyAgICAgICAgICAg
ICAgZGV2aWNlLg0KPiA+ICsgICAgICAgICAgICBhbGxPZjoNCj4gPiArICAgICAgICAgICAgICAt
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAg
ICAgICAgICAgIC0gbWluaW11bTogMTkNCj4gPiArICAgICAgICAgICAgICAtIG1heGltdW06IDI1
DQo+ID4gKw0KPiA+ICsgICAgICAgICAgYWRpLHJzZW5zZS1oYW5kbGU6DQo+ID4gKyAgICAgICAg
ICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgICAgICAgICAgUGhhbmRsZSBwb2ludGluZyB0
byBhIHJzZW5zZSBvYmplY3QgYXNzb2NpYXRlZCB3aXRoDQo+ID4gdGhpcw0KPiA+ICsgICAgICAg
ICAgICAgIHRoZXJtaXN0b3IuDQo+ID4gKyAgICAgICAgICAgICRyZWY6ICIvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlIg0KPiA+ICsNCj4gPiArICAgICAgICAgIGFkaSxz
ZW5zb3ItY29uZmlnOg0KPiA+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAg
ICAgICAgICAgIFJhdyB2YWx1ZSB3aGljaCBzZXQncyB0aGUgc2Vuc29yIGNvbmZpZ3VyYXRpb24u
IExvb2sNCj4gPiBhdCB0YWJsZSA1Mg0KPiA+ICsgICAgICAgICAgICAgIG9mIHRoZSBkYXRhc2hl
ZXQgZm9yIGhvdyB0byBzZXQgdGhpcyB2YWx1ZSBmb3INCj4gPiB0aGVybWlzdG9ycy4NCj4gPiAr
ICAgICAgICAgICAgYWxsT2Y6DQo+ID4gKyAgICAgICAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy90
eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgICAgICAgICAgICAtIG1pbmlt
dW06IDANCj4gPiArICAgICAgICAgICAgICAtIG1heGltdW06IDQNCj4gTmFzdHkgYXMgdmFsdWUg
MyBpcyByZXNlcnZlZC4gIFNvIGJyZWFrIHRoaXMgb25lIHVwIGludG8gaXQncyBwYXJ0cw0KPiBh
cyB3ZWxsLg0KDQpBcmdoaCwgdGhhdCBpcyBvYnZpb3VzbHkgYSBwcm9ibGVtLiBXaWxsIGRvIHRo
YXQuDQoNCj4gPiArDQo+ID4gKyAgICAgICAgICBhZGksZXhjaXRhdGlvbi1jdXJyZW50LW5hbm9h
bXA6DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgICAgICAgICAg
VGhpcyBwcm9wZXJ0eSBjb250cm9scyB0aGUgbWFnbml0dWRlIG9mIHRoZQ0KPiA+IGV4Y2l0YXRp
b24gY3VycmVudA0KPiA+ICsgICAgICAgICAgICAgIGFwcGxpZWQgdG8gdGhlIHRoZXJtaXN0b3Iu
IFZhbHVlIDAgc2V0J3MgdGhlIHNlbnNvcg0KPiA+IGluIGF1dG8tcmFuZ2UNCj4gPiArICAgICAg
ICAgICAgICBtb2RlLg0KPiA+ICsgICAgICAgICAgICBhbGxPZjoNCj4gPiArICAgICAgICAgICAg
ICAtICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsg
ICAgICAgICAgICAgIC0gZW51bTogWzAsIDI1MCwgNTAwLCAxMDAwLCA1MDAwLCAxMDAwMCwgMjUw
MDAsDQo+ID4gNTAwMDAsIDEwMDAwMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAyNTAw
MDAsIDUwMDAwMCwgMTAwMDAwMF0NCj4gPiArDQo+ID4gKyAgICAgICAgICBhZGksY3VzdG9tLXNl
bnNvcjoNCj4gPiArICAgICAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgICAg
ICBUaGlzIGlzIGEgdGFibGUsIHdoZXJlIGVhY2ggZW50cnkgc2hvdWxkIGJlIGEgcGFpcg0KPiA+
IG9mDQo+ID4gKyAgICAgICAgICAgICAgcmVzaXN0YW5jZShvaG0pLXRlbXBlcmF0dXJlKEspLiBU
aGUgZW50cmllcyBhZGRlZA0KPiA+IGhlcmUgYXJlIGluIHVvaG0NCj4gPiArICAgICAgICAgICAg
ICBhbmQgdUsgb25seSBmb3IgY3VzdG9tIHRoZXJtaXN0b3JzLiBGb3IgbW9yZSBkZXRhaWxzDQo+
ID4gbG9vayBhdCB0YWJsZQ0KPiA+ICsgICAgICAgICAgICAgIDc4IGFuZCA3OS4gU3RlaW5oYXJ0
LUhhcnQgY29lZmZpY2llbnRzIGFyZSBhbHNvDQo+ID4gc3VwcG9ydGVkIGFuZCBjYW4NCj4gPiAr
ICAgICAgICAgICAgICBiZSBwcm9ncmFtbWVkIGludG8gdGhlIGRldmljZSBtZW1vcnkgdXNpbmcg
dGhpcw0KPiA+IHByb3BlcnR5LiBGb3INCj4gPiArICAgICAgICAgICAgICBTdGVpbmhhcnQgc2Vu
c29ycywgdGhpcyB0YWJsZSBoYXMgYSBjb25zdGFudCBzaXplIG9mDQo+ID4gNiBlbnRyaWVzDQo+
ID4gKyAgICAgICAgICAgICAgKGRlZmluaW5nIHRoZSBjb2VmZmljaWVudHMpIGFuZCB0aGUgdmFs
dWVzIGFyZSBnaXZlbg0KPiA+IGluIHRoZSByYXcNCj4gPiArICAgICAgICAgICAgICBmb3JtYXQu
IExvb2sgYXQgdGFibGUgODIgZm9yIG1vcmUgaW5mb3JtYXRpb24uDQo+ID4gKyAgICAgICAgICAg
IGFsbE9mOg0KPiA+ICsgICAgICAgICAgICAgIC0gJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvdWludDY0LQ0KPiA+IGFycmF5DQo+ID4gKyAgICAgICAgICAgICAgLSBtaW5J
dGVtczogNg0KPiA+ICsgICAgICAgICAgICAgIC0gbWF4SXRlbXM6IDEyOA0KPiA+ICsNCj4gPiAr
ICAgICAgICByZXF1aXJlZDoNCj4gPiArICAgICAgICAgIC0gYWRpLHNlbnNvci10eXBlDQo+ID4g
KyAgICAgICAgICAtIGFkaSxyc2Vuc2UtaGFuZGxlDQo+ID4gKw0KPiA+ICsgICAgICAiXmFkY0Au
KiI6DQo+ID4gKyAgICAgICAgdHlwZTogb2JqZWN0DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246
IFJlcHJlc2VudHMgYSBjaGFubmVsIHdoaWNoIGlzIGJlaW5nIHVzZWQgYXMgYQ0KPiA+IGRpcmVj
dCBhZGMuDQo+ID4gKw0KPiA+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgICBh
ZGksc2Vuc29yLXR5cGU6DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiBJZGVudGlmaWVz
IHRoZSBzZW5zb3IgYXMgYSBkaXJlY3QgYWRjLg0KPiA+ICsgICAgICAgICAgICBjb25zdDogMzAN
Cj4gPiArDQo+ID4gKyAgICAgICAgICBhZGksc2luZ2xlLWVuZGVkOg0KPiA+ICsgICAgICAgICAg
ICBkZXNjcmlwdGlvbjogQm9vbGVhbiBwcm9wZXJ0eSB3aGljaCBzZXQncyB0aGUgYWRjIGFzDQo+
ID4gc2luZ2xlLWVuZGVkLg0KPiA+ICsgICAgICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4gKw0K
PiA+ICsgICAgICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAgICAgLSBhZGksc2Vuc29yLXR5cGUN
Cj4gPiArDQo+ID4gKyAgICAgICJecnNlbnNlQC4qIjoNCj4gPiArICAgICAgICB0eXBlOiBvYmpl
Y3QNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgUmVwcmVzZW50
cyBhIHJzZW5zZSB3aGljaCBpcyBjb25uZWN0ZWQgdG8gb25lIG9mIHRoZQ0KPiA+IGRldmljZSBj
aGFubmVscy4NCj4gPiArICAgICAgICAgIFJzZW5zZSBhcmUgdXNlZCBieSB0aGVybWlzdG9ycyBh
bmQgUlREJ3MuDQo+ID4gKw0KPiA+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAg
ICByZWc6DQo+ID4gKyAgICAgICAgICAgIG1pbmltdW06IDINCj4gPiArDQo+ID4gKyAgICAgICAg
ICBhZGksc2Vuc29yLXR5cGU6DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiBJZGVudGlm
aWVzIHRoZSBzZW5zb3IgYXMgYSByc2Vuc2UuDQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiAyOQ0K
PiA+ICsNCj4gPiArICAgICAgICAgIGFkaSxyc2Vuc2UtdmFsLW1pY3JvLW9obXM6DQo+ID4gKyAg
ICAgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgICAgICAgICAgU2V0cyB0aGUgdmFs
dWUgb2YgdGhlIHNlbnNlIHJlc2lzdG9yLiBMb29rIGF0IHRhYmxlDQo+ID4gMjAgb2YgdGhlDQo+
ID4gKyAgICAgICAgICAgICAgZGF0YXNoZWV0IGZvciBpbmZvcm1hdGlvbi4NCj4gPiArICAgICAg
ICAgICAgYWxsT2Y6DQo+ID4gKyAgICAgICAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy91aW50NjQNCj4gPiArDQo+ID4gKyAgICAgICAgcmVxdWlyZWQ6DQo+
ID4gKyAgICAgICAgICAtIGFkaSxzZW5zb3ItdHlwZQ0KPiA+ICsgICAgICAgICAgLSBhZGksIHJz
ZW5zZS12YWwNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+
ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4g
PiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9pcnEuaD4NCj4gPiArICAgIHNwaTAgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArICAg
ICAgICBzZW5zb3JfbHRjMjk4MzogbHRjMjk4M0AwIHsNCj4gPiArICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiYWRpLGx0YzI5ODMiOw0KPiA+ICsgICAgICAgICAgICAgICAgcmVnID0gPDA+
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICAgYWRpLHRlbXBlcmF0dXJlLWNlbGNpdXM7DQo+ID4gKyAgICAgICAgICAgICAgICBp
bnRlcnJ1cHRzID0gPDIwIElSUV9UWVBFX0VER0VfUklTSU5HPjsNCj4gPiArICAgICAgICAgICAg
ICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8+Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAg
ICAgIHRoZXJtb2NvdXBsZUAxOCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9
IDwxOD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGFkaSxzZW5zb3ItdHlwZSA9IDw4
PjsgLy9UeXBlIEINCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgYWRpLHNlbnNvci1jb25m
aWcgPSA8MT47IC8vRGlmZmVyZW50aWFsLA0KPiA+IG9wZW4tY2lyY3VpdCBjdXJyZW50DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgIGFkaSxjb2xkLWp1bmN0aW9uLWhhbmRsZSA9IDwmZGlv
ZGU1PjsNCj4gPiArICAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAg
ICAgZGlvZGU1OiBkaW9kZUA1IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0g
PDU+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBhZGksc2Vuc29yLXR5cGUgPSA8Mjg+
Ow0KPiA+ICsgICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICBy
c2Vuc2UyOiByc2Vuc2VAMiB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwy
PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgYWRpLHNlbnNvci10eXBlID0gPDI5PjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgYWRpLHJzZW5zZS12YWwtbWljcm8tb2htcyA9
IC9iaXRzLyA2NA0KPiA+IDwxMjAwMDAwMDAwPjsgLy8xLjJLb2htcw0KPiA+ICsgICAgICAgICAg
ICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICBydGRAMTQgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICByZWcgPSA8MTQ+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICBhZGksc2Vuc29yLXR5cGUgPSA8MTU+OyAvL1BUMTAwMA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAvKjItd2lyZSwgaW50ZXJuYWwgZ25kLCBubyBjdXJyZW50DQo+ID4gcm90YXRp
b24qLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBhZGksc2Vuc29yLWNvbmZpZyA9IDwx
PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgYWRpLGV4Y2l0YXRpb24tY3VycmVudCA9
IDw3PjsgLy81MDB1QQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBhZGkscnNlbnNlLWhh
bmRsZSA9IDwmcnNlbnNlMj47DQo+ID4gKyAgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiAr
ICAgICAgICAgICAgICAgIGFkY0AxMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIHJl
ZyA9IDwxMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGFkaSxzZW5zb3ItdHlwZSA9
IDwzMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGFkaSxzaW5nbGUtZW5kZWQ7DQo+
ID4gKyAgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgIHRoZXJt
aXN0b3JAMTIgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MTI+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICBhZGksc2Vuc29yLXR5cGUgPSA8MjY+OyAvL1N0ZWlu
aGFydA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBhZGkscnNlbnNlLWhhbmRsZSA9IDwm
cnNlbnNlMj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGFkaSxjdXN0b20tc2Vuc29y
ID0gL2JpdHMvIDY0IDwweDAwRjM3MUVDDQo+ID4gMHgxMjM0NTY3OA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgyQzBGODczMyAweDEwMDE4QzY2DQo+ID4g
MHhBMEZFQUNDRA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MHg5MDAyMUQ5OT47IC8vNiBlbnRyaWVzDQo+ID4gKyAgICAgICAgICAgICAgICB9Ow0KPiA+ICsN
Cj4gPiArICAgICAgICAgICAgICAgIHRoZXJtb2NvdXBsZUAyMCB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgIHJlZyA9IDwyMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGFk
aSxzZW5zb3ItdHlwZSA9IDw5PjsgLy9jdXN0b20NCj4gPiB0aGVybW9jb3VwbGUNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgYWRpLHNlbnNvci1jb25maWcgPSA8OD47IC8vc2luZ2xlLWVu
ZGVkDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGFkaSxjdXN0b20tc2Vuc29yID0gL2Jp
dHMvIDY0DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwoLTUwMjIwMDAw
KSAwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoLTMwMjAwMDAwKSA5
OTEwMDAwMA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKC01MzAwMDAw
KSAxMzU0MDAwMDANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAgMjcz
MTUwMDAwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA0MDIwMDAwMCAz
NjEyMDAwMDANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU1MzAwMDAw
IDUyMjEwMDAwMA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgODgzMDAw
MDAgNzIwMzAwMDAwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMzIy
MDAwMDAgODExMjAwMDAwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAx
ODg3MDAwMDAgOTIyNTAwMDAwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA0NjA0MDAwMDAgMTAwMDAwMDAwMD47IC8vMTANCj4gPiBwYWlycw0KPiA+ICsgICAgICAgICAg
ICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsgICAgfTsNCj4gPiArLi4uDQo+
ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gPiBpbmRleCAxNGEy
NTZlNzg1Y2EuLmY3NDdhOWRjMjdmNSAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+
ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTk0OTcsNiArOTQ5Nyw3IEBAIFc6CQ0KPiA+IGh0
dHA6Ly9lei5hbmFsb2cuY29tL2NvbW11bml0eS9saW51eC1kZXZpY2UtZHJpdmVycw0KPiA+ICBM
OglsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4gIFM6CVN1cHBvcnRlZA0KPiA+ICBGOglk
cml2ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4gPiArRjoJRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4My55DQo+ID4gYW1s
DQo+ID4gIA0KPiA+ICBMVEM0MjYxIEhBUkRXQVJFIE1PTklUT1IgRFJJVkVSDQo+ID4gIE06CUd1
ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4NCg0K
