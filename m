Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2D1E3786
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 06:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgE0EvN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 00:51:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25390 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbgE0EvL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 00:51:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R4nJOY025065;
        Wed, 27 May 2020 00:50:49 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp83x2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 00:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEB5Qa+dAMxcXcp9WhvBUzG3tvjkl5EuATeBopOH+Z0rtZ14ctMVY8p4+jcUTMoRRIuPMKgZeJwoQXG8OYxPzKRDvUsHhLYPjr1PtI0UGMTQFRwYQ7VgMfYKkBIaVIsEVzofk1aNtjiE32guLrD8BBkqTaGOCcmjk++O0eYPqrHlQxiE0C0hsnER2BtZ6hDbEuu+PhNUPJGtRrGH/Dn+BZ7ne0trnDB956DtrYZY1D46fGbYGhLV0UM4wpJ58F919fq24qDIDbTqE8h/eq8oZVEbimCvBMIBGfjZG/MphsXQHJuJaCNU8rONdBWE3JmjWo/cxM3SbM6sw8yjbz0gLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/8ctwZ22mXMJOfgOe5LnbEVdleYVLR2Z67qLmI1il8=;
 b=C94v8uR62aabo8rTgbBAFtrK00z2dIjxnuqvAVUb1pH/s9LTlm8nSfGanZUonH0bKCaBzakTTPFXL55Kvcu49UOlDNq6pOS9go9saeYCtLgrvsrJGD4oAuXy+D36Jz4OAyyzS/fGGftlOAWn5fzJsiYEr0+niFQVPVkjQzssQcEVI4CwUc5dWY5KVYthXcE+T9wEJj1VwdRyMqGRstUWN8GF8k9sAIo+me3Q1odWnacnXKhnrVIFbzxTyLGshFUMU79HyX6G5VOjVFSumvuZo/dVeYA9xtNPHg+IJKTX5pz1BUjBLA6to/QLTeS4i/M30lJ0CRBi/R2sZW6t7fzvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/8ctwZ22mXMJOfgOe5LnbEVdleYVLR2Z67qLmI1il8=;
 b=2tZ+eKY8Zj4WbNCaTM4pDZR5kAYbTlAmee+1aLpsgitt6/iqLHR522T4P7KY8o9Qbf6QXKkH/RQt1CCkMv8eyaLosdt3xEo8/SiFO3J6zQcuh9aMq9u8VxeBdVuGhR+oVZ99PUw8QPhLJoL7iq+ESR2G5HOchAVAS278bf43ZBA=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3739.namprd03.prod.outlook.com (2603:10b6:5:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 04:50:47 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 04:50:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: dac: ad5686: Constify static struct
 iio_chan_spec
Thread-Topic: [PATCH 4/6] iio: dac: ad5686: Constify static struct
 iio_chan_spec
Thread-Index: AQHWM6ESg9sPwd1MM0+GtgRrZEjArai7XYGA
Date:   Wed, 27 May 2020 04:50:46 +0000
Message-ID: <d822bd34435902f096cdeb27ae0dc029d29bfb2c.camel@analog.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
         <20200526210223.1672-5-rikard.falkeborn@gmail.com>
In-Reply-To: <20200526210223.1672-5-rikard.falkeborn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 177431e4-4bcf-4a28-38f4-08d801f98575
x-ms-traffictypediagnostic: DM6PR03MB3739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB373964812D2DD2B9850CF0EDF9B10@DM6PR03MB3739.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3gPemSJUVKJNvWAkkqo14vpAGWUGDvLMDaZHJsbd69xjpyvO0Hpg/tDqDgGVygF6nO2A23+UIJjr/wJ13biB1aOT7Ajk1zQ+DWfHvKQ7uJTKK+sgIQrQ5JYjo6FFAnkdRTVwydPwcgCy3gnONGnqr89sXxxktSFvdaKiiRNht8ntmKtprGwNav6EV6xMhScnt5peUkgLDpxXTEryAbexu/t/tHrITrRTzxFJpsTTVviI2JlHORpzCTMDkdAZnCjpWCYpOHP96R4rMBr5yngtLMVypHat7Px6MWRvQ6Nvtt0C2b1CcRs0eo2mt7aK/pQy81rrryZVThgTMztqY+A1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39850400004)(396003)(366004)(2906002)(4326008)(86362001)(478600001)(6506007)(71200400001)(110136005)(54906003)(316002)(6512007)(186003)(6486002)(8676002)(66946007)(2616005)(5660300002)(26005)(66476007)(66446008)(66556008)(36756003)(64756008)(8936002)(76116006)(83380400001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RCiQtyiHR9jrrZMcBqmJTRlGCbdG6sVUWDTupbfm0z/4rTK7Z17nf8X4AuTdP1vkxJnQPddgj2CyJFfpOlLVkaGC/cY8p1Wztf4Pz5CrCRJNLBbuqk9sBbwSum8/luO9aCaasA3OmGcUhj7B7DA4Wkgsnu2S4rIDH/zVJ1IO+y3rd3PP1sfhrVvoYEbzMmoXELGW/lndG5wpClXFhfWc5LV1BBQi7cpfhGavp1mTmWfGTXkFl6MmsXbR8+sxWOp7YlCCuP18gWG+yIvzKINML9Iqca54jLWIfOLQZHaQXCsfIIdq8soKNw29Cw/5DaVTeyNJmU4VY6lRU6+TMX26m5tCsa20tKiFDsTeZrxRfR5UsgNZBc4E0XN507Mf+1jCltNlHgbcffZkdDuvOqMMr0AbzTb3Dja93AWwRiMkbML2uQK1fP4/TKrD+uDrSaV9HCulbwxqDlsswZGh8rXtbGxRpQplBM6OrLkpDPCfXHz3m6yDsShUAzouhukEeO5i
Content-Type: text/plain; charset="utf-8"
Content-ID: <F35C70B59D531948AB9934CF5DCD190A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177431e4-4bcf-4a28-38f4-08d801f98575
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 04:50:46.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wLlYr+Kc++QVf9A1T1xHqxj5akbezvUUuPZaxuSPy5pkKK94xdb0ObLXcSQatqzFJ21dlem0jXQs6vlKhd7OqrqW6EPhkgzfAgxLeY6HV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3739
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_01:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=974 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTI2IGF0IDIzOjAyICswMjAwLCBSaWthcmQgRmFsa2Vib3JuIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBUaGVzZSBhcmUgbmV2ZXIgbW9kaWZpZWQgYW5kIGNhbiBi
ZSBtYWRlIGNvbnN0IHRvIGFsbG93IHRoZSBjb21waWxlciB0bw0KPiBwdXQgaXQgaW4gcmVhZC1v
bmx5IG1lbW9yeS4NCj4gDQo+IEJlZm9yZToNCj4gICAgdGV4dCAgICBkYXRhICAgICBic3MgICAg
IGRlYyAgICAgaGV4IGZpbGVuYW1lDQo+ICAgIDY2NDIgICAxMjYwOCAgICAgIDY0ICAgMTkzMTQg
ICAgNGI3MiBkcml2ZXJzL2lpby9kYWMvYWQ1Njg2Lm8NCj4gDQo+IEFmdGVyOg0KPiAgICB0ZXh0
ICAgIGRhdGEgICAgIGJzcyAgICAgZGVjICAgICBoZXggZmlsZW5hbWUNCj4gICAxNjk0NiAgICAy
MzA0ICAgICAgNjQgICAxOTMxNCAgICA0YjcyIGRyaXZlcnMvaWlvL2RhYy9hZDU2ODYubw0KPiAN
Cg0KQWNrZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxv
Zy5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogUmlrYXJkIEZhbGtlYm9ybiA8cmlrYXJkLmZhbGtl
Ym9ybkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5jIHwgOCAr
KysrLS0tLQ0KPiAgZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5oIHwgMiArLQ0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5jIGIvZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5jDQo+
IGluZGV4IDhkZDY3ZGEwYTdkYS4uNmRlNDhmNjE4Yzk1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2lpby9kYWMvYWQ1Njg2LmMNCj4gKysrIGIvZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5jDQo+IEBA
IC0yMDYsMTIgKzIwNiwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWNfZXh0
X2luZm8NCj4gYWQ1Njg2X2V4dF9pbmZvW10gPSB7DQo+ICB9DQo+ICANCj4gICNkZWZpbmUgREVD
TEFSRV9BRDU2OTNfQ0hBTk5FTFMobmFtZSwgYml0cywgX3NoaWZ0KQkJXA0KPiAtc3RhdGljIHN0
cnVjdCBpaW9fY2hhbl9zcGVjIG5hbWVbXSA9IHsJCQkJXA0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBpaW9fY2hhbl9zcGVjIG5hbWVbXSA9IHsJCQlcDQo+ICAJCUFENTg2OF9DSEFOTkVMKDAsIDAs
IGJpdHMsIF9zaGlmdCksCQlcDQo+ICB9DQo+ICANCj4gICNkZWZpbmUgREVDTEFSRV9BRDU2ODZf
Q0hBTk5FTFMobmFtZSwgYml0cywgX3NoaWZ0KQkJXA0KPiAtc3RhdGljIHN0cnVjdCBpaW9fY2hh
bl9zcGVjIG5hbWVbXSA9IHsJCQkJXA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9z
cGVjIG5hbWVbXSA9IHsJCQlcDQo+ICAJCUFENTg2OF9DSEFOTkVMKDAsIDEsIGJpdHMsIF9zaGlm
dCksCQlcDQo+ICAJCUFENTg2OF9DSEFOTkVMKDEsIDIsIGJpdHMsIF9zaGlmdCksCQlcDQo+ICAJ
CUFENTg2OF9DSEFOTkVMKDIsIDQsIGJpdHMsIF9zaGlmdCksCQlcDQo+IEBAIC0yMTksNyArMjE5
LDcgQEAgc3RhdGljIHN0cnVjdCBpaW9fY2hhbl9zcGVjIG5hbWVbXSA9IHsJCQkNCj4gCVwNCj4g
IH0NCj4gIA0KPiAgI2RlZmluZSBERUNMQVJFX0FENTY3Nl9DSEFOTkVMUyhuYW1lLCBiaXRzLCBf
c2hpZnQpCQlcDQo+IC1zdGF0aWMgc3RydWN0IGlpb19jaGFuX3NwZWMgbmFtZVtdID0gewkJCQlc
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgbmFtZVtdID0gewkJCVwNCj4g
IAkJQUQ1ODY4X0NIQU5ORUwoMCwgMCwgYml0cywgX3NoaWZ0KSwJCVwNCj4gIAkJQUQ1ODY4X0NI
QU5ORUwoMSwgMSwgYml0cywgX3NoaWZ0KSwJCVwNCj4gIAkJQUQ1ODY4X0NIQU5ORUwoMiwgMiwg
Yml0cywgX3NoaWZ0KSwJCVwNCj4gQEAgLTIzMSw3ICsyMzEsNyBAQCBzdGF0aWMgc3RydWN0IGlp
b19jaGFuX3NwZWMgbmFtZVtdID0gewkJCQ0KPiAJXA0KPiAgfQ0KPiAgDQo+ICAjZGVmaW5lIERF
Q0xBUkVfQUQ1Njc5X0NIQU5ORUxTKG5hbWUsIGJpdHMsIF9zaGlmdCkJCVwNCj4gLXN0YXRpYyBz
dHJ1Y3QgaWlvX2NoYW5fc3BlYyBuYW1lW10gPSB7CQkJCVwNCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgaWlvX2NoYW5fc3BlYyBuYW1lW10gPSB7CQkJXA0KPiAgCQlBRDU4NjhfQ0hBTk5FTCgwLCAw
LCBiaXRzLCBfc2hpZnQpLAkJXA0KPiAgCQlBRDU4NjhfQ0hBTk5FTCgxLCAxLCBiaXRzLCBfc2hp
ZnQpLAkJXA0KPiAgCQlBRDU4NjhfQ0hBTk5FTCgyLCAyLCBiaXRzLCBfc2hpZnQpLAkJXA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5oIGIvZHJpdmVycy9paW8vZGFjL2Fk
NTY4Ni5oDQo+IGluZGV4IDUyMDA5YjVlZWY4OC4uYTE1ZjI5NzA1NzdlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2lpby9kYWMvYWQ1Njg2LmgNCj4gKysrIGIvZHJpdmVycy9paW8vZGFjL2FkNTY4
Ni5oDQo+IEBAIC0xMDQsNyArMTA0LDcgQEAgdHlwZWRlZiBpbnQgKCphZDU2ODZfcmVhZF9mdW5j
KShzdHJ1Y3QgYWQ1Njg2X3N0YXRlDQo+ICpzdCwgdTggYWRkcik7DQo+ICBzdHJ1Y3QgYWQ1Njg2
X2NoaXBfaW5mbyB7DQo+ICAJdTE2CQkJCWludF92cmVmX212Ow0KPiAgCXVuc2lnbmVkIGludAkJ
CW51bV9jaGFubmVsczsNCj4gLQlzdHJ1Y3QgaWlvX2NoYW5fc3BlYwkJKmNoYW5uZWxzOw0KPiAr
CWNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjCSpjaGFubmVsczsNCj4gIAllbnVtIGFkNTY4Nl9y
ZWdtYXBfdHlwZQkJcmVnbWFwX3R5cGU7DQo+ICB9Ow0KPiAgDQo=
