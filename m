Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4B10C47F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 08:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfK1Hq6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 02:46:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54230 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbfK1Hq5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 02:46:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAS7hA4R019642;
        Thu, 28 Nov 2019 02:46:30 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2053.outbound.protection.outlook.com [104.47.41.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2whuyxa74p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 02:46:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebCB/ViTigmy1vW92zIzs5qikBIz8ax0EPMfGNI4VGyCcMRe3eSv47Nfj27HbBEprdjwvNmkVObLBoQzaSFyEsntrBvKJe2jDMfJkCwX3Xt9U9D4hGpVff+g9ZHZDzrrs4S7WUzNhNwmF9dnigiclJOgCfF02FLUVK+pJiLtamgDvm+VF6p9fJgjSvWLfYqBut49yjQJ4osnIwqktnciMdzbTtUC9Ec/hOMbPXEMH2Kt0cnn/J3JQjK22liyww8Rvh0BMtRni60AKjbZuk6kU9ddEyWOIUncfkyXVQaIUOtsMWpKlt6Jpr/2wc/RsrvLpv0MGPl31EmOCUMzw5M5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHeCmKgF9jZxrqejDHjR0/f5puP4Pe+biW/j5LlfFbo=;
 b=NP/RHAxnH2tIGo0vwrdYhZO5ifNTRD5res0lKgT5FF1yQ0Qk6/Pbay+nmWoXhsaPEkl/eYiEPKFWrhvfOyMPhiY+qFNVMdGd1PgQNC6/YZrhyMY6LIWZ/shFAYkplLfJn6dk8LFRPzhcSd2Uo55WLimizgVXIC7Lxst6QDPGQmcy8SLWgv2DMu5WluztOawIgVAbB6xUdGaLqmlLz4SKP8iJ2gVQ+z643fN7wtnA8+SA0DE1yjgD9zuwBCBTcOrYuL2k7rvg4VCH2y7GNWMvu5K8MSy8SGydvgRDjqB1tyPr+eFiEvvuZf/ZTSVLFl6GeuXMrdSAlL/8E4xHA5J4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHeCmKgF9jZxrqejDHjR0/f5puP4Pe+biW/j5LlfFbo=;
 b=pfwPRLfcLQ4A386k7d6kpr0bT/D1r/vEk+m6et2Kw/0iAMR8u4pirfhMxv6IX7ZHu95+6G4j0X1Kss82jqe0vpyyuM/TUwk4/ztWDdPFadGPFh7MNTMgrab48zA0mCER5XjBdnGXnCLxX9eK12bbBIwxtoWOujIOlzR24ETadnA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5253.namprd03.prod.outlook.com (20.180.14.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 07:46:27 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 07:46:27 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ad799x: add pm_ops to disable the device
 completely
Thread-Topic: [PATCH v2] iio: adc: ad799x: add pm_ops to disable the device
 completely
Thread-Index: AQHVpRiwjWjR3oMhG06aR7yydsBDn6egNgEA
Date:   Thu, 28 Nov 2019 07:46:27 +0000
Message-ID: <f54935dbda9df19f0301208f34132bf8a27aa55c.camel@analog.com>
References: <20191127114857.11862-1-m.felsch@pengutronix.de>
In-Reply-To: <20191127114857.11862-1-m.felsch@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d6262b9-3283-4919-86df-08d773d7132e
x-ms-traffictypediagnostic: CH2PR03MB5253:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB525380741C75BE3C021CCDADF9470@CH2PR03MB5253.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(966005)(76176011)(2906002)(71190400001)(71200400001)(2201001)(6116002)(3846002)(66946007)(76116006)(91956017)(66446008)(64756008)(66556008)(66476007)(36756003)(478600001)(6512007)(11346002)(2616005)(118296001)(446003)(99286004)(4326008)(5660300002)(86362001)(2501003)(6506007)(256004)(6306002)(54906003)(110136005)(8936002)(186003)(81156014)(25786009)(81166006)(66066001)(229853002)(316002)(6486002)(7736002)(102836004)(26005)(14444005)(6246003)(305945005)(4001150100001)(14454004)(6436002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5253;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: srJ3RdWt2E6UgTxp00cetFUBBiP/9dudgUE+hfLNjX+X16x9gN9W6dnQdf+prWcW685GyhK3uzvV8a1k4cSvh7PjahdRb+3CJZii9GvTBL4A46frbeg8yI4FVDNjfb+kG2GY7GypxS/nuIKCG0ptKUGthja6Suw4srJ5o1ZRBu6ozVKoGUedWW0u9JkZ2Zwz8o0rQO9DNgsE92hiErp3yOETDq/LeCDPoG/a20e59UI6WmJTQTtB9pGAlM19kB3ERDGC/0N558Pink7ER2QVycJNMCIVP8iMb4KMJLEuEaQB3PDCQK2h6ATevAeY35jtPYTrEk/pDFqPcpgeOGfhaw9lYH57ci2kD4/YnIxb7yHEouj4NUK4nSkrOuD4Vdn0PBh2JHzuTiLivKNlFyg0Bfs8ZCUiqCZQha3EPLANeoDXAHOqUZ3b8kdeuz9do6HNTNKF8eJt5Okl5vWrUsN9Ha5+2E7mLLB1R9zPI0nt86k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <704AFE7F2F1F8F4B850AB8FC53D8222A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6262b9-3283-4919-86df-08d773d7132e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 07:46:27.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mP8p219gwS5rpWqWCvj3UBRzfAWcX7KfM/VA7OyJmGswM8DeuOgVXfrsRf1c4KfvbyVRc5kaKtqVvqm6drZ6WdPFsAWn+V0T9jPlOVN76o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5253
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-27,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=892
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911280065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTI3IGF0IDEyOjQ4ICswMTAwLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+
IA0KPiBUaGUgZGV2aWNlIGlzIGFsd2F5cyBpbiBhIGxvdy1wb3dlciBzdGF0ZSBkdWUgdG8gdGhl
IGhhcmR3YXJlIGRlc2lnbi4gSXQNCj4gd2FrZXMgdXAgdXBvbiBhIGNvbnZlcnNpb24gcmVxdWVz
dCBhbmQgZ29lcyBiYWNrIGludG8gdGhlIGxvdy1wb3dlcg0KPiBzdGF0ZS4gVGhlIHBtIG9wcyBh
cmUgYWRkZWQgdG8gZGlzYWJsZSB0aGUgZGV2aWNlIGNvbXBsZXRlbHkgYW5kIHRvIGZyZWUNCj4g
dGhlIHJlZ3VsYXRvci4gRGlzYmFsaW5nIHRoZSBkZXZpY2UgY29tcGxldGVseSBzaG91bGQgYmUg
bm90IHRoYXQNCj4gbm90YWJsZSBidXQgZnJlZWluZyB0aGUgcmVndWxhdG9yIGlzIGltcG9ydGFu
dC4gQmVjYXVzZSBpZiBpdCBpcyBhIHNoYXJlZA0KPiBwb3dlci1yYWlsIHRoZSByZWd1bGF0b3Ig
d29uJ3QgYmUgZGlzYWJsZWQgZHVyaW5nIHN1c3BlbmQtdG8tcmFtL2Rpc2sNCj4gYW5kIHNvIGFs
bCBkZXZpY2VzIGNvbm5lY3RlZCB0byB0aGF0IHJhaWwga2VlcHMgb24uDQo+IA0KDQpIZXksDQoN
Ckp1c3Qgb25lIGNvbW1lbnQuDQpTb3JyeSBmb3Igbm90IGNhdGNoaW5nIHRoaXMgZWFybGllci4N
Ckkgc29tZXRpbWVzIG1pc3MgdGhpbmdzIG9uIHJldmlldy4NCg0KVGhhbmtzDQpBbGV4DQoNCj4g
U2lnbmVkLW9mZi1ieTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRyb25peC5kZT4NCj4g
LS0tDQo+IEhpLA0KPiANCj4gdGhpcyB2MiBjb250YWlucyB0aGUgY29tbWVudHMgbWFkZSBvbiBb
MV0uDQo+IA0KPiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTE0OTEx
OS8NCj4gDQo+IHYyOg0KPiAtIHNxdWFzaCBwYXRjaCAyICYgMw0KPiAtIGNhbGwgcmVndWxhdG9y
X2Rpc2FibGUoKSB1bmNvbmRpdGlvbmFsIGR1cmluZyBzdXNwZW5kKCkNCj4gLSBkcm9wIGRldl9l
cnIoKSBtZXNzYWdlcyBkdXJpbmcgc3VzcGVuZA0KPiAtIGZpeCBlcnJvciBwYXRoIHdpdGhpbiBy
ZXN1bWUoKQ0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9hZDc5OXguYyB8IDYwICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1NCBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2FkYy9hZDc5OXguYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5OXguYw0KPiBpbmRleCBmNjU4
MDEyYmFhZDguLjg5ZTY3MzQyM2U0NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2Fk
Nzk5eC5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5OXguYw0KPiBAQCAtMTY3LDYgKzE2
NywyMSBAQCBzdGF0aWMgaW50IGFkNzk5eF9yZWFkX2NvbmZpZyhzdHJ1Y3QgYWQ3OTl4X3N0YXRl
DQo+ICpzdCkNCj4gIAl9DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgYWQ3OTl4X3VwZGF0ZV9j
b25maWcoc3RydWN0IGFkNzk5eF9zdGF0ZSAqc3QsIHUxNiBjb25maWcpDQo+ICt7DQo+ICsJaW50
IHJldDsNCj4gKw0KPiArCXJldCA9IGFkNzk5eF93cml0ZV9jb25maWcoc3QsIGNvbmZpZyk7DQo+
ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsJcmV0ID0gYWQ3OTl4X3JlYWRf
Y29uZmlnKHN0KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwlzdC0+
Y29uZmlnID0gcmV0Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAg
ICogYWQ3OTl4X3RyaWdnZXJfaGFuZGxlcigpIGJoIG9mIHRyaWdnZXIgbGF1bmNoZWQgcG9sbGlu
ZyB0byByaW5nDQo+IGJ1ZmZlcg0KPiAgICoNCj4gQEAgLTgwOCwxMyArODIzLDkgQEAgc3RhdGlj
IGludCBhZDc5OXhfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gIAlpbmRpb19k
ZXYtPmNoYW5uZWxzID0gc3QtPmNoaXBfY29uZmlnLT5jaGFubmVsOw0KPiAgCWluZGlvX2Rldi0+
bnVtX2NoYW5uZWxzID0gY2hpcF9pbmZvLT5udW1fY2hhbm5lbHM7DQo+ICANCj4gLQlyZXQgPSBh
ZDc5OXhfd3JpdGVfY29uZmlnKHN0LCBzdC0+Y2hpcF9jb25maWctPmRlZmF1bHRfY29uZmlnKTsN
Cj4gLQlpZiAocmV0IDwgMCkNCj4gLQkJZ290byBlcnJvcl9kaXNhYmxlX3ZyZWY7DQo+IC0JcmV0
ID0gYWQ3OTl4X3JlYWRfY29uZmlnKHN0KTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gKwlyZXQgPSBh
ZDc5OXhfdXBkYXRlX2NvbmZpZyhzdCwgc3QtPmNoaXBfY29uZmlnLT5kZWZhdWx0X2NvbmZpZyk7
DQo+ICsJaWYgKHJldCkNCj4gIAkJZ290byBlcnJvcl9kaXNhYmxlX3ZyZWY7DQo+IC0Jc3QtPmNv
bmZpZyA9IHJldDsNCj4gIA0KPiAgCXJldCA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3NldHVwKGlu
ZGlvX2RldiwgTlVMTCwNCj4gIAkJJmFkNzk5eF90cmlnZ2VyX2hhbmRsZXIsIE5VTEwpOw0KPiBA
QCAtODY0LDYgKzg3NSw0MiBAQCBzdGF0aWMgaW50IGFkNzk5eF9yZW1vdmUoc3RydWN0IGkyY19j
bGllbnQgKmNsaWVudCkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBf
X21heWJlX3VudXNlZCBhZDc5OXhfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+
ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGkyY19nZXRfY2xpZW50ZGF0YSh0b19pMmNf
Y2xpZW50KGRldikpOw0KPiArCXN0cnVjdCBhZDc5OXhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5k
aW9fZGV2KTsNCj4gKw0KPiArCXJlZ3VsYXRvcl9kaXNhYmxlKHN0LT52cmVmKTsNCj4gKwlyZWd1
bGF0b3JfZGlzYWJsZShzdC0+cmVnKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+
ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGFkNzk5eF9yZXN1bWUoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiArew0KPiArCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBpMmNfZ2V0X2NsaWVu
dGRhdGEodG9faTJjX2NsaWVudChkZXYpKTsNCj4gKwlzdHJ1Y3QgYWQ3OTl4X3N0YXRlICpzdCA9
IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IHJlZ3Vs
YXRvcl9lbmFibGUoc3QtPnJlZyk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKGRldiwg
IlVuYWJsZSB0byBlbmFibGUgdmNjIHJlZ3VsYXRvclxuIik7DQo+ICsJCXJldHVybiByZXQ7DQo+
ICsJfQ0KPiArCXJldCA9IHJlZ3VsYXRvcl9lbmFibGUoc3QtPnZyZWYpOw0KPiArCWlmIChyZXQp
IHsNCj4gKwkJcmVndWxhdG9yX2Rpc2FibGUoc3QtPnJlZyk7DQo+ICsJCWRldl9lcnIoZGV2LCAi
VW5hYmxlIHRvIGVuYWJsZSB2cmVmIHJlZ3VsYXRvclxuIik7DQo+ICsJCXJldHVybiByZXQ7DQo+
ICsJfQ0KPiArCS8qIHJlc3luYyBjb25maWcgKi8NCj4gKwlhZDc5OXhfdXBkYXRlX2NvbmZpZyhz
dCwgc3QtPmNvbmZpZyk7DQo+ICsNCg0KW0FnYWluXSBTb3JyeSBmb3Igbm90IGNhdGNoaW5nIHRo
aXMgZWFybGllci4NCg0KSXMgaXQgd29ydGggZG9pbmcgYW4gZXJyb3IgY2hlY2sgaGVyZT8NCk1h
eWJlDQoNCnJldCA9IGFkNzk5eF91cGRhdGVfY29uZmlnKHN0LCBzdC0+Y29uZmlnKTsNCmlmIChy
ZXQgPCAwKSB7DQogICByZWd1bGF0b3JfZGlzYWJsZShzdC0+dnJlZik7DQogICByZWd1bGF0b3Jf
ZGlzYWJsZShzdC0+cmVnKTsNCiAgIHJldHVybiByZXQ7DQp9DQoNCg0KPiArCXJldHVybiAwOw0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgU0lNUExFX0RFVl9QTV9PUFMoYWQ3OTl4X3BtX29wcywgYWQ3
OTl4X3N1c3BlbmQsIGFkNzk5eF9yZXN1bWUpOw0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IGkyY19kZXZpY2VfaWQgYWQ3OTl4X2lkW10gPSB7DQo+ICAJeyAiYWQ3OTkxIiwgYWQ3OTkxIH0s
DQo+ICAJeyAiYWQ3OTk1IiwgYWQ3OTk1IH0sDQo+IEBAIC04ODEsNiArOTI4LDcgQEAgTU9EVUxF
X0RFVklDRV9UQUJMRShpMmMsIGFkNzk5eF9pZCk7DQo+ICBzdGF0aWMgc3RydWN0IGkyY19kcml2
ZXIgYWQ3OTl4X2RyaXZlciA9IHsNCj4gIAkuZHJpdmVyID0gew0KPiAgCQkubmFtZSA9ICJhZDc5
OXgiLA0KPiArCQkucG0gPSAmYWQ3OTl4X3BtX29wcywNCj4gIAl9LA0KPiAgCS5wcm9iZSA9IGFk
Nzk5eF9wcm9iZSwNCj4gIAkucmVtb3ZlID0gYWQ3OTl4X3JlbW92ZSwNCg==
