Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155A6B5CE6
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 08:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfIRG3w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 02:29:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46010 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbfIRG3u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 02:29:50 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8I6MhiD014708;
        Wed, 18 Sep 2019 02:29:21 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2059.outbound.protection.outlook.com [104.47.50.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v37k80w2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 02:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKYtd/C0iIYdTqeRRqoV9LD35OtgR9gC+q/JXlXhyhSXMMRybEV/HTqlvmIuY+xTq+Ho87J76+0ZEQPh2ShVXCVZjS9Re7PrDJD7nfvHmpqv82m7b6wHRhQ24H6mUspkukiM5SGthXKsDW5NLtHn0E3Bm7nDlI63wpQ7lVDYcxBU8KUxoIbIrkS5ATb7heXTzUjuhy1qGubEIexVhcpnAkIh0WhW4BT48mklZULfNGDGJ+fz72rsE6GmCR8uoT6eQEsd5WujWdJZbEJsqN709Za5686S3AqojOuW6cWMP+9xpUKb5nH/65RL0JauoHEjY3N8eODOD6HUWyWjkDENZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98yrbAwDCI8ngDe4/Dvnnp578QE1OWK75KIoiYyUm1A=;
 b=ZRV+w7L12heAxVmvzYPpA2ISDXN/hXqrCBHMk1047qxSmEyHjd9rnSEGWbv35VzPzoPFGtoxQdYGqkKcUHOpWiMFeMPKjcNDhT+St3X45QFKoYN9aB1PI5r5zKrAwhPrmU4gBU6L4t/XtC/fywqnbDZPlrZmyFZCCiixfm4vuTN0POll/2m51/oDJnK3mjEaQQL0AEXGQprCar3yYxbHYIPieSuVEiQkamWfpk4Jl+0k9td+zWX6lW7edLttoDhkHZqVhuOM4RyPSH1Jyic0sd7VjgR6HJlkZffV9wiHSR967W9TEuiB0c4xU9s2UO+ce9KKE/WpBvtW44o+bgf0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98yrbAwDCI8ngDe4/Dvnnp578QE1OWK75KIoiYyUm1A=;
 b=lHp8MQKXBtWzNIWYUhIZXflFnQD9AXDs3LfvWugkTHIhYj71JY0sM9xHVZKanaJ2y9wuZd7pDjYXYjT0CE/K0ZnlrLnIP8WLKl+qmQPyxZmGb3MLZffGpnGH2bt2D7ChYZtcxBUDu0XKSDEN4EWUO+B+RqtsnBaCLGOCCJrFths=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5240.namprd03.prod.outlook.com (20.180.13.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Wed, 18 Sep 2019 06:29:19 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 06:29:19 +0000
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
Subject: Re: [PATCH 1/3] iio: adc: ad799x: fix probe error handling
Thread-Topic: [PATCH 1/3] iio: adc: ad799x: fix probe error handling
Thread-Index: AQHVbXJzvpQNnvkJYUy7NZHQqS16/6cxLDCA
Date:   Wed, 18 Sep 2019 06:29:19 +0000
Message-ID: <8405aec02752668bee7563e8c86c225c55f6705b.camel@analog.com>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
         <20190917160925.9791-2-m.felsch@pengutronix.de>
In-Reply-To: <20190917160925.9791-2-m.felsch@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18cd3fe6-1754-4262-4429-08d73c0189af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5240;
x-ms-traffictypediagnostic: CH2PR03MB5240:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB524067028CA7B32BB97F9764F98E0@CH2PR03MB5240.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:238;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(66066001)(71190400001)(71200400001)(76116006)(186003)(66946007)(66446008)(64756008)(66476007)(26005)(66556008)(102836004)(8676002)(486006)(5660300002)(81156014)(81166006)(2616005)(476003)(8936002)(11346002)(446003)(118296001)(6506007)(76176011)(305945005)(7736002)(256004)(99286004)(86362001)(2201001)(6436002)(6512007)(6246003)(3846002)(6116002)(2906002)(25786009)(2501003)(478600001)(316002)(4326008)(229853002)(36756003)(6486002)(14454004)(110136005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5240;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SbWbW4SedbUKSsIbMf6PzyBeA6vsnXysfnxas0jqjhWYw5qEnUkNsrzMsml8ZUjdwh0RlJRfk5ILvTdxhzM2RTOgYYqtqhYfRHMMbkvDcxGo/F2VisHNRWJLDBXrsrHD+lXqqwngevP0jZyKleo0lOY2ChO56/TZeGUGNrv/HPpAYarHEJsim/5urnhRyy0viKU3lLR5NSbOVjBz9knavGDB4HMsy2axuuYQF5N21yFm8Z+NBZ84/NIKP1T6Un7D0Kesu/eGmJKqtYqcoIIBcXVXkESK5293dLxTM87pforFwJGODj2CFngEYcr2c006vQqdXt57X2+QJMtRdriVlUS2nUo3rmu9as/cRWhS2PYmDL8+0M92GL4T4BseGAfX8LKHx0Yw/GHaKfo4VW8XDJnvOr/ewVfudnoHsUQWQnk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BBF26E5E4EF8540A1C20FB58124B4E4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cd3fe6-1754-4262-4429-08d73c0189af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 06:29:19.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qANqjR7p2uOL80h0biBLcN9S8KddQzk+IVDtsl4/TiqGUaiQZH66ivGki+QWTOcxU5w+k5RYJ3f5mGfCVQoJXEWOMBhhiUjHp4LbUPmhtBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5240
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_04:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE4OjA5ICswMjAwLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFNpbmNlIGNvbW1pdCAwZjdkZGNjMWJmZjEgKCJpaW86YWRjOmFk
Nzk5eDogV3JpdGUgZGVmYXVsdCBjb25maWcgb24gcHJvYmUNCj4gYW5kIHJlc2V0IGFsZXJ0IHN0
YXR1cyBvbiBwcm9iZSIpIHRoZSBlcnJvciBwYXRoIGlzIHdyb25nIHNpbmNlIGl0DQo+IGxlYXZl
cyB0aGUgdnJlZiByZWd1bGF0b3Igb24uIEZpeCB0aGlzIGJ5IGRpc2FibGluZyBib3RoIHJlZ3Vs
YXRvcnMuDQo+IA0KDQpHb29kIGNhdGNoLg0KTWFueSB0aGFua3MgOikNCg0KUmV2aWV3ZWQtYnk6
IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4g
Rml4ZXM6IDBmN2RkY2MxYmZmMSAoImlpbzphZGM6YWQ3OTl4OiBXcml0ZSBkZWZhdWx0IGNvbmZp
ZyBvbiBwcm9iZSBhbmQNCj4gcmVzZXQgYWxlcnQgc3RhdHVzIG9uIHByb2JlIikNCj4gU2lnbmVk
LW9mZi1ieTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2lpby9hZGMvYWQ3OTl4LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL2FkNzk5eC5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzk5eC5jDQo+IGluZGV4IDVh
M2NhNTkwNGRlZC4uZjY1ODAxMmJhYWQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMv
YWQ3OTl4LmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzk5eC5jDQo+IEBAIC04MTAsMTAg
KzgxMCwxMCBAQCBzdGF0aWMgaW50IGFkNzk5eF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xp
ZW50LA0KPiAgDQo+ICAJcmV0ID0gYWQ3OTl4X3dyaXRlX2NvbmZpZyhzdCwgc3QtPmNoaXBfY29u
ZmlnLT5kZWZhdWx0X2NvbmZpZyk7DQo+ICAJaWYgKHJldCA8IDApDQo+IC0JCWdvdG8gZXJyb3Jf
ZGlzYWJsZV9yZWc7DQo+ICsJCWdvdG8gZXJyb3JfZGlzYWJsZV92cmVmOw0KPiAgCXJldCA9IGFk
Nzk5eF9yZWFkX2NvbmZpZyhzdCk7DQo+ICAJaWYgKHJldCA8IDApDQo+IC0JCWdvdG8gZXJyb3Jf
ZGlzYWJsZV9yZWc7DQo+ICsJCWdvdG8gZXJyb3JfZGlzYWJsZV92cmVmOw0KPiAgCXN0LT5jb25m
aWcgPSByZXQ7DQo+ICANCj4gIAlyZXQgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9zZXR1cChpbmRp
b19kZXYsIE5VTEwsDQo=
