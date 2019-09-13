Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7868FB1876
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 08:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfIMGqf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 02:46:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31186 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbfIMGqf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 02:46:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D6XE5C030719;
        Fri, 13 Sep 2019 02:46:09 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdks55c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 02:46:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJt5kcTRF71POlh/gD6128h84nrQ3X62tuqw8raKfcbqcX1I0ukMt0gHIKbp3dKn4LAhTT/mufsRjd2mWIJ0GoxlPJq3yPMBPOC/u5xLEgllv8cAxoEoWJpCCNZEIt7WaU5/xqGP8wxs4GcQVkzk3UWfUMWNnYp3dS/vQIhKC1FHxiovk04ELld3EZuB+aroLKjk9Iu3N9WCWkWyvgMylOmIOOhKFx/vao6d/vHzSl+jSLy8b+R0GiXgAV+mzpTwkANoxNxJLxTQN9aA16gOcM5A7PXPWeVCFtbUvWjkBTpqXJJXjpUt/0AaWK2aTfbtpgKrwyyNlPs5TRb3/6WuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmbOPFUWTfMbfmah5EyelVIFar0Xh8kBDhWDfs3a2+c=;
 b=dXR3yeMaf+RRhDq2+jWuHTBDFEzax93l+k4sweknV0KBcGtOTyCn4RYLNw9TdLUbrgvxR7zbatUSpPEpW3Zk2Ap6rAoCTljh7qgUknBiJvlvp7m4zefUWKLZaNCPFxkXhdUfP5VgNgRwVIqN/AzSCWuyZC7X8HsGF5WLbloLzdixD3TML/x0a3GwmWIS+litGVd/81seWOuAlGVhVmx16Ggw+Zpk9HCVZ9GodWz1r9NmpwLesdETeYpf3kNhg1djLwU7ETrHXE2mS0gdIcQKhGWjpMlsyQxru6gP7iv8ypFOWUapL+dcRQNtZOaejbcz2rzuQ4eeuJiMrxptg/onjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmbOPFUWTfMbfmah5EyelVIFar0Xh8kBDhWDfs3a2+c=;
 b=C8qOJr+ZkWIatH4zWZUUslq0lz7GyZbPRbHPPIkPvE0WKtsBBy5lVsDiJVLiEMw+O2W7W5mbrx6ymnWfKUIzNYNl3WG4X0/JEMonebIamddFJylKnMid5jRtgnveWATY5Zy6gxXJALHUUii3243XucRE4j1L3q6UneNnKWRA4Ts=
Received: from MN2PR03MB5200.namprd03.prod.outlook.com (10.186.144.199) by
 MN2PR03MB4958.namprd03.prod.outlook.com (52.132.168.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 06:46:07 +0000
Received: from MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::e8d8:1709:332a:fed6]) by MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::e8d8:1709:332a:fed6%3]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 06:46:07 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Thread-Topic: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Thread-Index: AQHVaXh7nFtQMJGG0EuSl7ibaCkViqcpXS6A
Date:   Fri, 13 Sep 2019 06:46:07 +0000
Message-ID: <3fe869be01ce7c81fd463158c05e0a4a115bdd6a.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <20190912144310.7458-3-andrea.merello@gmail.com>
In-Reply-To: <20190912144310.7458-3-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed602b5e-83db-432b-a64a-08d738160e4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR03MB4958;
x-ms-traffictypediagnostic: MN2PR03MB4958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB4958B8757557F0CEF1A1F70DF9B30@MN2PR03MB4958.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(66556008)(66476007)(66446008)(6512007)(5660300002)(64756008)(66946007)(229853002)(71200400001)(91956017)(76116006)(71190400001)(561944003)(14454004)(25786009)(6116002)(3846002)(2501003)(4326008)(256004)(478600001)(110136005)(2201001)(2906002)(446003)(7736002)(316002)(305945005)(8936002)(66066001)(76176011)(86362001)(118296001)(102836004)(486006)(6506007)(6486002)(6436002)(8676002)(36756003)(476003)(81166006)(53936002)(26005)(81156014)(186003)(6246003)(99286004)(2616005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4958;H:MN2PR03MB5200.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JTI4cFPzZP3Oi5N7IIv8NNzq3ifDaSNVad2+VPrTQ978KU/FtQ9cFqyJzrOkRpA3yruruFyPOYzQIWwpER5nZIQfch9tJOfygA+kLHqeQouXalBkQU9/CY+ZjgevTAk3heBYpfrmHceiVWIcrvcACdOUhi7EEeJ+yuS8fNrXcloTu2hA4q5/3W5/gbaaqmbc6SHtfGUyRk/EKkDyMknNI9LL9JK5BnR/RqFZEkA+b4tP/TACvYDmdJYUhOsR5z0/MiUpJNo4nBHVWnGIutsxW7lECdWtMQ39TPxol7V+u15nzyQWEDL0/MXVcMMfw4Y4b98vR9JPfS0edd5Pn5dnzPtdH83q7GlrquM8vj27JC3py5gZ4YJlonMqTcgD7npu26EY0HDRuFGhZN3sB80Snyx5xuWbrfPk5moT1YITUO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71A3CE0681B33A48B6C1B7271BA6AB66@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed602b5e-83db-432b-a64a-08d738160e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 06:46:07.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvILh9Y4kVLz6fiwZTgiYxwranelFID7QscqJ7FQAQf1vlvKxn1Zd5tMBb0tm1jY6L75gBFDF8h9IyecRDmX+tEOD7vevdhkq5DBXDOop/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4958
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_04:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=825 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDE2OjQzICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gVGhpcyBkcml2ZXIgc3VwcG9ydHMgMTQtYml0cyBhbmQgMTYt
Yml0cyBkZXZpY2VzLiBBbGwgb2YgdGhlbSBoYXZlIGEgMTQtYml0DQo+IGNvbmZpZ3VyYXRpb24g
cmVnaXN0ZXJzLiBBbGwgU1BJIHRyYXNmZXJzLCBmb3IgcmVhZGluZyBBRCBjb252ZXJzaW9uDQo+
IHJlc3VsdHMgYW5kIGZvciB3cml0aW5nIHRoZSBjb25maWd1cmF0aW9uIHJlZ2lzdGVyLCBmaXQg
aW4gdHdvIGJ5dGVzLg0KPiANCj4gVGhlIGRyaXZlciBhbHdheXMgdXNlcyA0LWJ5dGVzIHhmZXJz
IHdoaWNoIHNlZW1zIGF0IGxlYXN0IHBvaW50bGVzcyAobWF5YmUNCj4gZXZlbiBoYXJtZnVsKS4g
VGhpcyBwYXRjaCB0cmltcyB0aGUgU1BJIHhmZXIgbGVuIGFuZCB0aGUgYnVmZmVyIHNpemUgdG8N
Cj4gdHdvIGJ5dGVzLg0KPiANCg0KVGhlIGxlbmd0aCByZWR1Y3Rpb24gcHJvcG9zYWwgaXMgZmlu
ZS4NCg0KQnV0LCB0aGlzIHBhdGNoIHJhaXNlcyBhIHF1ZXN0aW9uIGFib3V0IGVuZGlhbmVzcy4N
CkknbSBhY3R1YWxseSB3b25kZXJpbmcgaGVyZSBpZiB3ZSBuZWVkIHRvIHNlZSBhYm91dCBtYXli
ZSB1c2luZyBhIF9fYmUxNiB2cyB1MTYuDQoNCkknbSBub3QgdGhhdCBrZXJuZWwtc2F2eSB5ZXQg
YWJvdXQgc29tZSBvZiB0aGVzZSBsb3ctbGV2ZWwgdGhpbmdzIHRvIGJlIGNvbXBsZXRlbHkgc3Vy
ZSBoZXJlLg0KU28sIEknZCBsZXQgc29tZW9uZSBlbHNlIG1heWJlIGhhbmRsZSBpdC4NCg0KVGhh
bmtzDQpBbGV4IA0KDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBNZXJlbGxvIDxhbmRyZWEubWVy
ZWxsb0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jIHwgNiAr
KystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jIGIvZHJpdmVycy9p
aW8vYWRjL2FkNzk0OS5jDQo+IGluZGV4IDUxODA0NGMzMWE3My4uNWMyYjM0NDZmYTRhIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ3OTQ5LmMNCj4gKysrIGIvZHJpdmVycy9paW8v
YWRjL2FkNzk0OS5jDQo+IEBAIC01NCw3ICs1NCw3IEBAIHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAg
ew0KPiAgCXU4IHJlc29sdXRpb247DQo+ICAJdTE2IGNmZzsNCj4gIAl1bnNpZ25lZCBpbnQgY3Vy
cmVudF9jaGFubmVsOw0KPiAtCXUzMiBidWZmZXIgX19fX2NhY2hlbGluZV9hbGlnbmVkOw0KPiAr
CXUxNiBidWZmZXIgX19fX2NhY2hlbGluZV9hbGlnbmVkOw0KPiAgfTsNCj4gIA0KPiAgc3RhdGlj
IGludCBhZDc5NDlfc3BpX3dyaXRlX2NmZyhzdHJ1Y3QgYWQ3OTQ5X2FkY19jaGlwICphZDc5NDlf
YWRjLCB1MTYgdmFsLA0KPiBAQCAtNjcsNyArNjcsNyBAQCBzdGF0aWMgaW50IGFkNzk0OV9zcGlf
d3JpdGVfY2ZnKHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMsIHUxNiB2YWwsDQo+
ICAJc3RydWN0IHNwaV90cmFuc2ZlciB0eFtdID0gew0KPiAgCQl7DQo+ICAJCQkudHhfYnVmID0g
JmFkNzk0OV9hZGMtPmJ1ZmZlciwNCj4gLQkJCS5sZW4gPSA0LA0KPiArCQkJLmxlbiA9IDIsDQo+
ICAJCQkuYml0c19wZXJfd29yZCA9IGJpdHNfcGVyX3dvcmQsDQo+ICAJCX0sDQo+ICAJfTsNCj4g
QEAgLTk1LDcgKzk1LDcgQEAgc3RhdGljIGludCBhZDc5NDlfc3BpX3JlYWRfY2hhbm5lbChzdHJ1
Y3QgYWQ3OTQ5X2FkY19jaGlwICphZDc5NDlfYWRjLCBpbnQgKnZhbCwNCj4gIAlzdHJ1Y3Qgc3Bp
X3RyYW5zZmVyIHR4W10gPSB7DQo+ICAJCXsNCj4gIAkJCS5yeF9idWYgPSAmYWQ3OTQ5X2FkYy0+
YnVmZmVyLA0KPiAtCQkJLmxlbiA9IDQsDQo+ICsJCQkubGVuID0gMiwNCj4gIAkJCS5iaXRzX3Bl
cl93b3JkID0gYml0c19wZXJfd29yZCwNCj4gIAkJfSwNCj4gIAl9Ow0K
