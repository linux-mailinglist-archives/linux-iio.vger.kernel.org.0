Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E76B5DB1
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 08:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfIRG7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 02:59:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35532 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbfIRG7z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 02:59:55 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8I6xHJV018572;
        Wed, 18 Sep 2019 02:59:21 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2052.outbound.protection.outlook.com [104.47.41.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v37jx8x9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 02:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI5lKGiuNtkcQbVVmQf15pmHxQua0xjnnwYZ9SvMtJV6Hd/NDgYWsf0kLBakt4D+cYPfGdroF+jT9t28bCmWITap8kgy5GPYM7DIU8xTtEg2wjpfzypkBhMu2UUnuVJ2AX0r4FNMbFe7nKMtVQywo6G1PTCagujDokgfOUy/z5Uv2vym7JyPxrdhKQ8ycL0HIx3abTzKl5eX5krTJZaKVQeqKs0VX8GHOfBwe+vyjT9ujSi0epv86clXLvKHjMied7fZ/QC6CRSZ+oHeO2+LM5/Czyka0Zo/DnaEjRu3bS12r6fItEQf7JT8cipu/w8wTEweFxmb9D0ZSsnfCPp4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I8MI5by5ib7eE0gYHzRZQdsMjYPNkyXMzVRWqv9F8c=;
 b=MOOPOm0TomCI8iOmVkXy0GmI+uV/EwHKTSLPWGWISLddHhOtpz/Yu/tQCNFK9MGqWa0EAO4QRS77/YfoMROg+JlaWQZvUFKZxvsfFHBKS9989NTBSK4T4rBWDztXt/J2PViXv7J6y79cc0F+ewy4xhoMaZiWM43HiEqdR8uEIvVWRdGOLDV3QLQTRnHEdDQNG0HajPFURaj0YWevvbUE4s0dRknEr8QjHtKAIpc6HVdxvcZmQGMvVcuWEkkOBp14J3Hv4/4VynBNnFCdCH3lz1i3eXLdjQsuFNecE89gKnYcq+i5MZSfK9j25L/ggZbVMoQ/Mr/T4e3eE85nZYz5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I8MI5by5ib7eE0gYHzRZQdsMjYPNkyXMzVRWqv9F8c=;
 b=YrzKiCfXkDNsmIzfOdVZ1DxErSZsM2hV7NJzwrMG0HA5IT93y7B0pUOv1TPIvEWiBMgCxwn8vgp7Myfpfnb6T7YqLH+vAMmYIWSAKAZKonE1uNJ7aBbkbYr4jULaDXBYiaD5mwOD6SUv7aFezH39jKtkKudL9abjAsYNdcnUkGE=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5351.namprd03.prod.outlook.com (20.180.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 06:59:17 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 06:59:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: adc: ad799x: add pm_ops to disable the device
 completely
Thread-Topic: [PATCH 3/3] iio: adc: ad799x: add pm_ops to disable the device
 completely
Thread-Index: AQHVbXJi7/27zTD/hEu21xyuyAvjFacxNI8A
Date:   Wed, 18 Sep 2019 06:59:17 +0000
Message-ID: <b09de11deacc5486fefdab0e69b94d14596e541f.camel@analog.com>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
         <20190917160925.9791-4-m.felsch@pengutronix.de>
In-Reply-To: <20190917160925.9791-4-m.felsch@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 877435d1-87ee-49f5-2882-08d73c05b937
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5351;
x-ms-traffictypediagnostic: CH2PR03MB5351:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB535183E132F12DEB56EF5BFDF98E0@CH2PR03MB5351.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(54906003)(486006)(4326008)(186003)(71190400001)(71200400001)(102836004)(118296001)(66066001)(2201001)(26005)(76176011)(99286004)(25786009)(478600001)(14444005)(11346002)(110136005)(86362001)(316002)(14454004)(6506007)(5660300002)(256004)(476003)(446003)(2616005)(2906002)(305945005)(81156014)(8676002)(81166006)(64756008)(6116002)(66446008)(3846002)(8936002)(7736002)(6486002)(6436002)(229853002)(36756003)(6512007)(76116006)(66556008)(66946007)(2501003)(66476007)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5351;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X1alg9t7r2t566CpHeRetLFtp3Jxub77aFiFbyupPbLcfmQ7vQDB9J8k97UsIYOJfrIJG2xm5+5WwxsqwuEYgoIZBXcJ0hm2K9NRIwAnaX9iUQyoumwarToiNqT1K8lZVsFEjVjS42fxQJ+TSx8tMmOpaecYDfCgVIITtKWpYNpk+4cDwWoYSi/BxgAMLjKWLiOIXS6iGQkmf2aeSTGosJVVmbNpneGF6fLW4YYEDejVuGmJvBl506Q1n9Ds+z5THO0HSXM4v+ce62y3iK1Wnr+tqfLAzqkCZ1Xu95R5x+S9h3w24tGOqCL8Ghrr+OAMyfCEcJ2qm7GmK8tBaLxrdAEimWyPrxUEHI39T83A/tE1ZCXaNG9x01q5Oi44TNQxTbY4gvzus3da5xd5RJ59HIyVaD+n8lhLHI7sMcxYXeE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A7405DFE2F73F4796BA6F8186831DE7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877435d1-87ee-49f5-2882-08d73c05b937
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 06:59:17.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjvJzpbQbhA/gQjIUG5yXQGa6eOhgDiznGIhpH8gKZVpWLLkwutetPOVxKHH2K/fnrqt8isIO+4qGY/VECKav+Dd6kSN+sBaXEt3lnWh2kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5351
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_05:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909180074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE4OjA5ICswMjAwLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQoNCkNvbW1lbnRzIGlubGluZQ0KDQo+IFRoZSBkZXZpY2UgaXMgYWx3
YXlzIGluIGEgbG93LXBvd2VyIHN0YXRlIGR1ZSB0byB0aGUgaGFyZHdhcmUgZGVzaWduLiBJdA0K
PiB3YWtlcyB1cCB1cG9uIGEgY29udmVyc2lvbiByZXF1ZXN0IGFuZCBnb2VzIGJhY2sgaW50byB0
aGUgbG93LXBvd2VyDQo+IHN0YXRlLiBUaGUgcG0gb3BzIGFyZSBhZGRlZCB0byBkaXNhYmxlIHRo
ZSBkZXZpY2UgY29tcGxldGVseSBhbmQgdG8gZnJlZQ0KPiB0aGUgcmVndWxhdG9yLiBEaXNiYWxp
bmcgdGhlIGRldmljZSBjb21wbGV0ZWx5IHNob3VsZCBiZSBub3QgdGhhdA0KPiBub3RhYmxlIGJ1
dCBmcmVlaW5nIHRoZSByZWd1bGF0b3IgaXMgaW1wb3J0YW50LiBCZWNhdXNlIGlmIGl0IGlzIGEg
c2hhcmVkDQo+IHBvd2VyLXJhaWwgdGhlIHJlZ3VsYXRvciB3b24ndCBiZSBkaXNhYmxlZCBkdXJp
bmcgc3VzcGVuZC10by1yYW0vZGlzaw0KPiBhbmQgc28gYWxsIGRldmljZXMgY29ubmVjdGVkIHRv
IHRoYXQgcmFpbCBrZWVwcyBvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIEZlbHNjaCA8
bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzk5
eC5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9hZGMvYWQ3OTl4LmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ3OTl4LmMNCj4gaW5kZXggYWY1
YTJkZTljMjJmLi4zMmQyNDJlY2IxMmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9h
ZDc5OXguYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ3OTl4LmMNCj4gQEAgLTg3NSw2ICs4
NzUsNTAgQEAgc3RhdGljIGludCBhZDc5OXhfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVz
ZWQgYWQ3OTl4X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXYgPSBpMmNfZ2V0X2NsaWVudGRhdGEodG9faTJjX2NsaWVudChkZXYp
KTsNCj4gKwlzdHJ1Y3QgYWQ3OTl4X3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+
ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IHJlZ3VsYXRvcl9kaXNhYmxlKHN0LT52cmVmKTsN
Cj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiVW5hYmxlIHRvIGRpc2FibGUgdnJl
ZiByZWd1bGF0b3JcbiIpOw0KDQpFeGl0aW5nIGhlcmUgd2lsbCBsZWF2ZSBzdC0+cmVnIHVuZGlz
YWJsZWQuDQpJIGRvbid0IGtub3cgaWYgdGhpcyBzaG91bGQgZG8gbW9yZSB0aGF0IGp1c3QgZGlz
YWJsZSB0aGUgcmVndWxhdG9ycy4NCg0KSSBhbSBub3Qgc3VyZSBpZiB3ZSBzaG91bGQgcHJpbnQg
YW55dGhpbmcgaGVyZSBpZiByZWd1bGF0b3JfZGlzYWJsZSgpDQplcnJvcnMuIFVzdWFsbHkgKGlu
IHRoaXMgY2FzZSkgdGhlIHN5c3RlbSB3b3VsZCBnbyB0byBzbGVlcCwgYW5kIHRoYXQncyBpdC4N
CkVycm9ycyB3b3VsZCBiZSBtb3JlIGltcG9ydGFudCBpbiB0aGUgYWQ3OTl4X3Jlc3VtZSgpIGNh
c2UgKHRoYW4gaGVyZSkuDQoNCkJ1dCwgaWYgdGhlc2UgbWVzc2FnZXMgYXJlIGltcG9ydGFudCwg
eW91IGNvdWxkIG1heWJlIHByaW50IHdpdGgNCiJkZXZfd2FybigpIiBpbnN0ZWFkIG9mICJkZXZf
ZXJyKCkiLg0KSSBhbSBub3Qgc3VyZSBpZiBlcnJvcnMgd2hlbiBkaXNhYmxpbmcgcmVndWxhdG9y
cyAoaW4gdGhpcyBjYXNlIGhlcmUpDQpjbGFzc2lmeSBhcyBlcnJvcnMgKGluc3RlYWQgb2Ygd2Fy
bmluZ3MpLg0KDQoNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsJcmV0ID0gcmVndWxhdG9y
X2Rpc2FibGUoc3QtPnJlZyk7DQo+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAi
VW5hYmxlIHRvIGRpc2FibGUgdmNjIHJlZ3VsYXRvclxuIik7DQo+ICsJCXJldHVybiByZXQ7DQo+
ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19tYXli
ZV91bnVzZWQgYWQ3OTl4X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGkyY19nZXRfY2xpZW50ZGF0YSh0b19pMmNfY2xpZW50
KGRldikpOw0KPiArCXN0cnVjdCBhZDc5OXhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2
KTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gcmVndWxhdG9yX2VuYWJsZShzdC0+cmVn
KTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiVW5hYmxlIHRvIGVuYWJsZSB2
Y2MgcmVndWxhdG9yXG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsJcmV0ID0gcmVn
dWxhdG9yX2VuYWJsZShzdC0+dnJlZik7DQo+ICsJaWYgKHJldCkgew0KDQpTaG91bGQgdGhlcmUg
YmUgYSAicmVndWxhdG9yX2Rpc2FibGUoc3QtPnJlZyk7IiBjYWxsIGhlcmUgPw0KDQo+ICsJCWRl
dl9lcnIoZGV2LCAiVW5hYmxlIHRvIGVuYWJsZSB2cmVmIHJlZ3VsYXRvclxuIik7DQo+ICsJCXJl
dHVybiByZXQ7DQo+ICsJfQ0KPiArCS8qIHJlc3luYyBjb25maWcgKi8NCj4gKwlhZDc5OXhfdXBk
YXRlX2NvbmZpZyhzdCwgc3QtPmNvbmZpZyk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKGFkNzk5eF9wbV9vcHMsIGFkNzk5eF9zdXNw
ZW5kLCBhZDc5OXhfcmVzdW1lKTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2
aWNlX2lkIGFkNzk5eF9pZFtdID0gew0KPiAgCXsgImFkNzk5MSIsIGFkNzk5MSB9LA0KPiAgCXsg
ImFkNzk5NSIsIGFkNzk5NSB9LA0KPiBAQCAtODkyLDYgKzkzNiw3IEBAIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUoaTJjLCBhZDc5OXhfaWQpOw0KPiAgc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIGFkNzk5
eF9kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5hbWUgPSAiYWQ3OTl4IiwNCj4g
KwkJLnBtID0gJmFkNzk5eF9wbV9vcHMsDQo+ICAJfSwNCj4gIAkucHJvYmUgPSBhZDc5OXhfcHJv
YmUsDQo+ICAJLnJlbW92ZSA9IGFkNzk5eF9yZW1vdmUsDQo=
