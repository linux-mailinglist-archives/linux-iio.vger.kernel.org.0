Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7101796A4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgCDRZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 12:25:54 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24930 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgCDRZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 12:25:54 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024HKT7N018397;
        Wed, 4 Mar 2020 12:25:29 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52c2yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 12:25:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYiCpUkCIPT3dJQuBvKTlNG1QUynJs0sNnlZ5kSEgNHVTvkNi37JC8tH1fRigIbaKU3e4dNz8k1eFLPIZRbQJ18PVPl/mMW17DieKW+Akes7d6/fkg7/uhsAQDdmkZ8LzSI1efZnMgevU1g1zxT3UyiRzROOhRSb0b8Oej4d11NsPdEXYStj6ToYMB8RuWhwAUnXTypL9xAmnOS7wWdoUsC4SV7szq5WmDZpir30tfMMv6csBi8p2CjMHfc4RMsGFzdv7V2pgMgDwSqbyrXhh9/fZ06PQP1t2CaQFmShau9Fhf50XR9HXTuR3pstnqiq7gM1JearjF+lDf7xPebpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onVcGvHg6elSVPkx48rp4ab7+yJ1+RuZyt1/OShjcyA=;
 b=AWVjSJDYBEE4lZEM/DDqvBWcHWfgThttz6w+zietcvTleK/C23NHxWBiZqAWJhsjqZ0qBlPmrsgKgV0SBiYt6ySs+SICgvWf5l5Vqp30rPYjMm15iWzeOmFQ/LfBMyYdT9fIgrfsT0HK3u2h6r5R/HVv8KeyX6glau7FUKh2Ub4TKXcRn0uYkZaKVfvHMlFYQiCfzQDtGRdt/pPqwZ8iQIZqWbU2y5ljRgN+cjuQKR1Yi91zlelGSmWc7vKeWMSx0dAIIs/aCVwyKolyI90lXSVG/FBbPwEHjtY6c7fpGrnVro3LVhhZbUtf++MzWyZgglzpOzPTzNncRPlg+Rnf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onVcGvHg6elSVPkx48rp4ab7+yJ1+RuZyt1/OShjcyA=;
 b=tAar3/s1nntEDwiBdq9m6pHq0tao3W6qwba9232WKOUKNm4n7+54fK2eBhowvV/IdsBDgS+C6k9Sd7waZgECL/IHsmpoecYVZGq0X9KA6cGf5XNpV+Z/F1cgHVzqWkbPs/aG+XcUGCywhSx8ridKEhIpiozq16Z0xxDEnt0pGEU=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2787.namprd03.prod.outlook.com (2603:10b6:404:5b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 17:25:27 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 17:25:27 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Topic: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Index: AQHV69jpKCRYfnfL+0eh49A+u9WwfKg16ooAgAC+fACAAARgAIAAbhSAgAGg4YA=
Date:   Wed, 4 Mar 2020 17:25:27 +0000
Message-ID: <cd9be5e5cd96499e5e1feeb625095e9eb541290c.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-6-nuno.sa@analog.com> <20200302222254.GA27619@bogus>
         <1054e87af61518d73dfcb0995e7aab7484e81630.camel@analog.com>
         <5661b3f80a7fd041989b30d2f9ca76bfa762499d.camel@analog.com>
         <CAL_JsqJU_C6OU+x1LxSX=rBjLtiaOcmdwR+_8LyKd094XMJ08A@mail.gmail.com>
In-Reply-To: <CAL_JsqJU_C6OU+x1LxSX=rBjLtiaOcmdwR+_8LyKd094XMJ08A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f252f470-a892-441f-f4f2-08d7c06107f0
x-ms-traffictypediagnostic: BN6PR03MB2787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB27874FBA8A6309979ECC88E099E50@BN6PR03MB2787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(86362001)(71200400001)(6916009)(498600001)(54906003)(2906002)(36756003)(966005)(6512007)(6486002)(26005)(66556008)(66446008)(64756008)(66946007)(76116006)(66476007)(2616005)(8936002)(6506007)(8676002)(186003)(81166006)(53546011)(81156014)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2787;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Or2oh6f1ch9iaco5Bi8tFBcGFRWb6UNQsuShwgNmUmm6oQ4baM+4BAzoyHlYKujWFiisDn6nYVUrH4Ik/iSdhZz/WH8wd2yFXIZczYnZkWBIA1sDl+5Qo8vTo+Zx66Cq8I3EQJ5qJqfzHPBHl3McmQulVNxqAtvfmAiu11QWvj+rBFKI9WsUcgV8Rmoma2C+z7XB1rDib/PK0l8DswuXzmYe7FkqT7d+ErF5bRHMD584nToOHDMPdB3jlvavna2CwRQ1vx7yIE/QSaFUOxSgrZ5b4bIiTgKBWwyEXbBvRCaCQFG4EsXGkqPh6Vtp5/kmw7WoyRKTqdguoKyfeKWx/XlrtzCBXgMHz/z8npMLDKH3WK6i/ThKw5FieEP15jrQ28l+fcxoaiaG+4EHYsGC+568UCTCbQak8FGNeITK9DfGr2e+6UkxIRWkKXGr6zvgcdMfCzd3NYRev/xLald3sGyqvqzvA3tPciwI7xU+x1HWVXEele9qD+OAZ6YnsMBD
x-ms-exchange-antispam-messagedata: QMTjK3dMiO5acV1c0LK6uC0dxqHHBQ4pgX58k1VDDX6tWs63Hp1rp4pk1/g52Q8e5DgQvzH+8C1CDwlDAPkgeIN9mUIiOjO1ndG+cJF00Gnl5mfz/Vfh0W/pMYvXPSuhMNFqSjANYKF2EcK1gvZoOA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B8870963AF3E40B4D37BC8484065C8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f252f470-a892-441f-f4f2-08d7c06107f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 17:25:27.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQzMRACkZ2NxR+r5/TNuKJxIJ4Sy0EnBp0vgmMNvXuT1M9ntYfRIeftqaAUUUsw4G3epmBLx80V16jSmX28Ciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDEwOjM0IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBNYXIgMywgMjAyMCBhdCAzOjU5IEFNIFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5j
b20+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0wMy0wMyBhdCAwOTo0MyArMDAwMCwgU2EsIE51
bm8gd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiA+IE9uIE1vbiwgMjAyMC0w
My0wMiBhdCAxNjoyMiAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwg
RmViIDI1LCAyMDIwIGF0IDAxOjQxOjUyUE0gKzAxMDAsIE51bm8gU8OhIHdyb3RlOg0KPiA+ID4g
PiA+IERvY3VtZW50IHRoZSBBRElTMTY0NzUgZGV2aWNlIGRldmljZXRyZWUgYmluZGluZ3MuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5h
bG9nLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgLi4uL2JpbmRpbmdzL2lpby9pbXUv
YWRpLGFkaXMxNjQ3NS55YW1sICAgICAgIHwgMTMwDQo+ID4gPiA+ID4gKysrKysrKysrKysrKysr
KysrDQo+ID4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTMxIGluc2VydGlvbnMo
KykNCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+ID4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW0NCj4gPiA+ID4gPiBsDQo+
ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9hZGks
YWRpczE2NDc1LnlhbQ0KPiA+ID4gPiA+IGwNCj4gPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiA+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzBmMjE0NmUwMDBjDQo+ID4gPiA+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ID4gPiA+ICsrKw0KPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW0NCj4gPiA+ID4gPiBs
DQo+ID4gPiA+ID4gQEAgLTAsMCArMSwxMzAgQEANCj4gPiA+ID4gPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gPiA+ID4gKyVZ
QU1MIDEuMg0KPiA+ID4gPiA+ICstLS0NCj4gPiA+ID4gPiArJGlkOiANCj4gPiA+ID4gPiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbCMNCj4g
PiA+ID4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwjDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICt0aXRsZTogQW5hbG9nIERldmljZXMgQURJ
UzE2NDc1IGFuZCBzaW1pbGFyIElNVXMNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK21haW50YWlu
ZXJzOg0KPiA+ID4gPiA+ICsgIC0gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gPiA+ID4gKyAgQW5hbG9nIERl
dmljZXMgQURJUzE2NDc1IGFuZCBzaW1pbGFyIElNVXMNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
aHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9k
YXRhLXNoZWV0cy9BRElTMTY0NzUucGRmDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtwcm9wZXJ0
aWVzOg0KPiA+ID4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiA+ID4gKyAgICBlbnVtOg0KPiA+
ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NzUtMQ0KPiA+ID4gPiA+ICsgICAgICAtIGFkaSxh
ZGlzMTY0NzUtMg0KPiA+ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NzUtMw0KPiA+ID4gPiA+
ICsgICAgICAtIGFkaSxhZGlzMTY0NzctMQ0KPiA+ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0
NzctMg0KPiA+ID4gPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NzctMw0KPiA+ID4gPiA+ICsgICAg
ICAtIGFkaSxhZGlzMTY0NzANCj4gPiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2NDY1LTENCj4g
PiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2NDY1LTINCj4gPiA+ID4gPiArICAgICAgLSBhZGks
YWRpczE2NDY1LTMNCj4gPiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2NDY3LTENCj4gPiA+ID4g
PiArICAgICAgLSBhZGksYWRpczE2NDY3LTINCj4gPiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2
NDY3LTMNCj4gPiA+ID4gPiArICAgICAgLSBhZGksYWRpczE2NTAwDQo+ID4gPiA+ID4gKyAgICAg
IC0gYWRpLGFkaXMxNjUwNS0xDQo+ID4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwNS0yDQo+
ID4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwNS0zDQo+ID4gPiA+ID4gKyAgICAgIC0gYWRp
LGFkaXMxNjUwNy0xDQo+ID4gPiA+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwNy0yDQo+ID4gPiA+
ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwNy0zDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgIHJl
ZzoNCj4gPiA+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsg
IHNwaS1jcGhhOiB0cnVlDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgIHNwaS1jcG9sOiB0cnVl
DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgIHNwaS1tYXgtZnJlcXVlbmN5Og0KPiA+ID4gPiA+
ICsgICAgbWF4aW11bTogMjAwMDAwMA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICBpbnRlcnJ1
cHRzOg0KPiA+ID4gPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
KyAgY2xvY2tzOg0KPiA+ID4gPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gPiA+ID4gKyAgICBvbmVPZjoNCj4gPiA+ID4gPiAr
ICAgICAgLSBjb25zdDogc3luYw0KPiA+ID4gPiA+ICsgICAgICAtIGNvbnN0OiBkaXJlY3Qtc3lu
Yw0KPiA+ID4gPiA+ICsgICAgICAtIGNvbnN0OiBwdWxzZS1zeW5jDQo+ID4gPiA+ID4gKyAgICAg
IC0gY29uc3Q6IHNjYWxlZC1zeW5jDQo+ID4gPiA+IA0KPiA+ID4gPiBBY2NvcmRpbmcgdG8gdGhl
IGRhdGFzaGVldCBJIGxvb2tlZCBhdCwgdGhlIGlucHV0IGlzIGNhbGxlZA0KPiA+ID4gPiAnc3lu
YycuDQo+ID4gPiA+IEl0DQo+ID4gPiA+IGxvb2tzIGxpa2UgeW91IGFyZSBtaXhpbmcgb3BlcmF0
aW5nIG1vZGUgYW5kIGNsb2NrIGNvbm5lY3Rpb24uDQo+ID4gPiANCj4gPiA+IFRoZSBzeW5jIHBp
biBpcyB3aGVyZSB0aGUgZXh0ZXJuYWwgY2xvY2sgc2hvdWxkIGJlIGNvbm5lY3RlZA0KPiA+ID4g
KHdoZW4NCj4gPiA+IGF2YWlsYWJsZSkuIEknbSBraW5kYSBvZiB1c2luZyB0aGUgY2xvY2stbmFt
ZSBwcm9wZXJ0eSBhcyBhIHdheQ0KPiA+ID4gb2YNCj4gPiA+IHNlbGVjdGluZyB0aGUgbW9kZSB0
aGUgdXNlciB3YW50cyB0byB1c2UgYXMgZG9uZSBpbiBvdGhlciBkZXZpY2VzDQo+ID4gPiAoDQo+
ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlv
L2ltdS9hZGksYWRpczE2NDgwLnR4dA0KPiA+ID4gKS4gSW4gdGhlIGVuZCwgd2hhdCB3ZSBzaG91
bGQgaGF2ZSBpbiB0aGUgc3luYyBwaW4gaXMgYW4gZXh0ZXJuYWwNCj4gPiA+IGNsb2NrDQo+ID4g
PiB3aXRoIHRoZSBleGNlcHRpb24gb2YgdGhlIGBzeW5jYCBtb2RlLiBJIGd1ZXNzIHRoaXMgb25l
IGNvdWxkIGJlDQo+ID4gPiBjYWxsZWQNCj4gPiA+IG91dHB1dC1zeW5jIGFuZCwgaW4gdGhpcyBj
YXNlLCB0aGUgc3luYyBwaW4gaXMgYWN0dWFsbHkgYW4gb3V0cHV0DQo+ID4gPiBwaW4NCj4gPiA+
IHB1bHNpbmcgd2hlbiB0aGUgaW50ZXJuYWwgcHJvY2Vzc29yIGNvbGxlY3RzIGRhdGEuDQo+ID4g
PiANCj4gPiA+IEknbSBvayBpbiBjaGFuZ2luZyBpdCBpZiB0aGVyZSdzIGEgYmV0dGVyIHdheSBv
ZiBkb2luZyBpdC4uLiBEbw0KPiA+ID4geW91DQo+ID4gPiBoYXZlIGFueSBzdWdnZXN0aW9uPw0K
PiA+ID4gDQo+ID4gPiAtTnVubyBTw6ENCj4gPiANCj4gPiBTbywgeW91IG1lYW4gaGF2aW5nIHRo
ZSBjbG9jay1uYW1lIG9ubHkgYXMgInN5bmMiIChvciBtYXliZSBldmVuDQo+ID4gcmVtb3Zpbmcg
aXQ/KSBhbmQgaGF2aW5nIGEgZGVkaWNhdGVkIHByb3BlcnR5IGxpa2UgY2xvY2stbW9kZT8NCj4g
DQo+IFllcy4gVGhvdWdoIGl0IG5lZWRzIGEgdmVuZG9yIHByZWZpeDogYWRpLGNsb2NrLW1vZGUu
IE9yIHBlcmhhcHMNCj4gYWRpLHN5bmMtbW9kZT8NCg0KSSdtIHRlbXB0ZWQgdG8gZ28gd2l0aCBh
ZGksc3luYy1tb2RlIHRvIHJlc3BlY3QgdGhlIGRhdGFzaGVldA0KdGVybWlub2xvZ3kuIE1vcmVv
dmVyLCB3aGVuIHVzaW5nIG91dHB1dC1zeW5jIG1vZGUsIHRoZSBzeW5jIHBpbiBpcyBhbg0Kb3V0
cHV0IHBpbiBhbmQgdGhlcmUncyBubyBleHRlcm5hbCBjbG9jay4gSGVuY2UsIGluIHRoaXMgbW9k
ZSwgaXQNCmFjdHVhbGx5IGRvZXMgbm90IG1ha2UgYW55IHNlbnNlIGluIGdpdmluZyBhIGNsb2Nr
IHByb3BlcnR5LiBUaGlzIG11c3QNCmFsc28gYmUgZml4ZWQgaW4gdGhlIGRyaXZlci4NCg0KLSBO
dW5vIFPDoQ0KPiBSb2INCg0K
