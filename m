Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598392BFFC
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2019 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfE1HSi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 May 2019 03:18:38 -0400
Received: from mail-eopbgr790072.outbound.protection.outlook.com ([40.107.79.72]:56224
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfE1HSh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 May 2019 03:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AB8b/qCSu2cMr7WoZ85wYjtkuzF3KKNeUprokIhRYw=;
 b=24qdmumjHolRET8Jz1Z4qfbTPgc/xmtmGldAolv2o3+11pKEIRdNvxVYVSiDLwlz88PErVoRSCKLxXyqPNC/VCoS7Tx7IZCUqShEK30m9vii9+YMVkZf97gJfUSEtO/DWQKv92vrsvfEBjbYger/26FMyX4n7GXpZqs5mIjvG34=
Received: from BN8PR03CA0005.namprd03.prod.outlook.com (2603:10b6:408:94::18)
 by BY2PR03MB555.namprd03.prod.outlook.com (2a01:111:e400:2c37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.20; Tue, 28 May
 2019 07:18:33 +0000
Received: from CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN8PR03CA0005.outlook.office365.com
 (2603:10b6:408:94::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Tue, 28 May 2019 07:18:33 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT026.mail.protection.outlook.com (10.152.75.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Tue, 28 May 2019 07:18:31 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4S7IU4o017954
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 28 May 2019 00:18:30 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Tue, 28 May 2019 03:18:30 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 1/3][V3] lib: fix __sysfs_match_string() helper when n
 != -1
Thread-Topic: [PATCH 1/3][V3] lib: fix __sysfs_match_string() helper when n
 != -1
Thread-Index: AQHVBY/wzk7diA7bF0G14nWBti7v/6aAgwaA
Date:   Tue, 28 May 2019 07:18:29 +0000
Message-ID: <42488b7ffb951ecd43f9c889eec1664cf2f57a8b.camel@analog.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190508111913.7276-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CDC7867EBCD204A89B22A6F63CBA720@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(54534003)(189003)(199004)(305945005)(86362001)(2906002)(446003)(47776003)(2616005)(476003)(7636002)(11346002)(356004)(336012)(106002)(478600001)(7736002)(8676002)(14454004)(6116002)(8936002)(118296001)(3846002)(436003)(426003)(70586007)(102836004)(70206006)(14444005)(7696005)(50466002)(76176011)(54906003)(246002)(2486003)(23676004)(229853002)(6246003)(110136005)(36756003)(316002)(4326008)(2501003)(486006)(126002)(2201001)(5660300002)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB555;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab321dbf-34de-4440-9661-08d6e33cb0e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BY2PR03MB555;
X-MS-TrafficTypeDiagnostic: BY2PR03MB555:
X-Microsoft-Antispam-PRVS: <BY2PR03MB5553AA8A5799E3A067A74E4F91E0@BY2PR03MB555.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 00514A2FE6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CHnpVGzREMVkFh0+yngaq5SarEbnsHyg8m3PvYsSiGX6lS23VvZYxaLWAzN65oT2JaMHNkSmx6Pa97BnEHeepyp8xu4To85PzFvlxCLnAGiJKtd0FRQ//uq9fHald/TxDu1OO4Wnh8agxxN3ngag2KRIVxySnTQxJlGGTO6zZ9hC1axM+c+/p+/LJNhw4xmP82TjT8hy700vM3jphpkltyGXewQWio5mYtAzOrufPUpPzzHKiUY5Q/eLjHSEQqvu9arrUi5pgkUjuwgvCDbOy3hYbfxMCTSKz0lUuY3Q9kjI/Fx84kNBl1jv4i/HMKN1GHwGa9LjdDAytfqY0LyWfB9xlBwkoAxThz0+UdZwD/q1jlW0X1XSnAvhlWYS6KyxyDy7k+yPSDn7MPN+3ct4hKFbEwd4z6xGoLooG+TZ+Qk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2019 07:18:31.9914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab321dbf-34de-4440-9661-08d6e33cb0e6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB555
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTA4IGF0IDE0OjE5ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBkb2N1bWVudGF0aW9uIHRoZSBgX19zeXNmc19tYXRjaF9zdHJpbmcoKWAgaGVs
cGVyIG1lbnRpb25zIHRoYXQgYG5gDQo+ICh0aGUgc2l6ZSBvZiB0aGUgZ2l2ZW4gYXJyYXkpIHNo
b3VsZCBiZToNCj4gICogQG46IG51bWJlciBvZiBzdHJpbmdzIGluIHRoZSBhcnJheSBvciAtMSBm
b3IgTlVMTCB0ZXJtaW5hdGVkIGFycmF5cw0KPiANCj4gVGhlIGJlaGF2aW9yIG9mIHRoZSBmdW5j
dGlvbiBpcyBkaWZmZXJlbnQsIGluIHRoZSBzZW5zZSB0aGF0IGl0IGV4aXRzIG9uDQo+IHRoZSBm
aXJzdCBOVUxMIGVsZW1lbnQgaW4gdGhlIGFycmF5Lg0KPiANCj4gVGhpcyBwYXRjaCBjaGFuZ2Vz
IHRoZSBiZWhhdmlvciwgdG8gZXhpdCB0aGUgbG9vcCB3aGVuIGEgTlVMTCBlbGVtZW50IGlzDQo+
IGZvdW5kLCBhbmQgdGhlIHNpemUgb2YgdGhlIGFycmF5IGlzIHByb3ZpZGVkIGFzIC0xLg0KPiAN
Cj4gQWxsIGN1cnJlbnQgdXNlcnMgb2YgX19zeXNmc19tYXRjaF9zdHJpbmcoKSAmIHN5c2ZzX21h
dGNoX3N0cmluZygpIHByb3ZpZGUNCj4gY29udGlndW91cyBhcnJheXMgb2Ygc3RyaW5ncywgc28g
dGhpcyBiZWhhdmlvciBjaGFuZ2UgZG9lc24ndCBpbmZsdWVuY2UNCj4gYW55dGhpbmcgKGF0IHRo
aXMgcG9pbnQgaW4gdGltZSkuDQo+IA0KPiBUaGlzIGJlaGF2aW9yIGNoYW5nZSBhbGxvd3MgZm9y
IGFuIGFycmF5IG9mIHN0cmluZ3MgdG8gaGF2ZSBOVUxMIGVsZW1lbnRzDQo+IHdpdGhpbiB0aGUg
YXJyYXksIHdoaWNoIHdpbGwgYmUgaWdub3JlZC4gVGhpcyBpcyBwYXJ0aWN1bGFybHkgdXNlZnVs
IHdoZW4NCj4gY3JlYXRpbmcgbWFwcGluZyBvZiBzdHJpbmdzIGFuZCBpbnRlZ2VycyAoYXMgYml0
ZmllbGRzIG9yIG90aGVyIEhXDQo+IGRlc2NyaXB0aW9uKS4NCj4gDQoNCkhleSwNCg0KSSBkaWQg
bm90IHNlZSBhbnkgcmVhY3Rpb24gb24gdGhpcy4NCkRvIEkgbmVlZCB0byBkbyBzb21ldGhpbmcg
b24gdGhpcyAocmUtc3BpbiwgYWRkIG90aGVyIHBlb3BsZSwgcmUtc2VuZCBhcyBzdGFuZGFsb25l
IHBhdGNoLCBldGMpID8NCg0KVGhhbmtzDQpBbGV4DQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiAtLS0NCj4g
DQo+IENoYW5nZWxvZyB2MiAtPiB2MzoNCj4gKiBmaXggX19zeXNmc19tYXRjaF9zdHJpbmcoKSB2
cyBhZGRpbmcgYSBuZXcNCj4gICBfX3N5c2ZzX21hdGNoX3N0cmluZ193aXRoX2dhcHMoKSBoZWxw
ZXINCj4gDQo+ICBsaWIvc3RyaW5nLmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL3N0cmlu
Zy5jIGIvbGliL3N0cmluZy5jDQo+IGluZGV4IDNhYjg2MWMxYTg1Ny4uNWJlYTNmOTg0NzhhIDEw
MDY0NA0KPiAtLS0gYS9saWIvc3RyaW5nLmMNCj4gKysrIGIvbGliL3N0cmluZy5jDQo+IEBAIC02
NzQsOCArNjc0LDExIEBAIGludCBfX3N5c2ZzX21hdGNoX3N0cmluZyhjb25zdCBjaGFyICogY29u
c3QgKmFycmF5LCBzaXplX3QgbiwgY29uc3QgY2hhciAqc3RyKQ0KPiAgDQo+ICAJZm9yIChpbmRl
eCA9IDA7IGluZGV4IDwgbjsgaW5kZXgrKykgew0KPiAgCQlpdGVtID0gYXJyYXlbaW5kZXhdOw0K
PiAtCQlpZiAoIWl0ZW0pDQo+ICsJCWlmICghaXRlbSkgew0KPiArCQkJaWYgKG4gIT0gKHNpemVf
dCktMSkNCj4gKwkJCQljb250aW51ZTsNCj4gIAkJCWJyZWFrOw0KPiArCQl9DQo+ICAJCWlmIChz
eXNmc19zdHJlcShpdGVtLCBzdHIpKQ0KPiAgCQkJcmV0dXJuIGluZGV4Ow0KPiAgCX0NCg==
