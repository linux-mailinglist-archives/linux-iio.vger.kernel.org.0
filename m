Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534BF583C7
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfF0Npg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 09:45:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47594 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbfF0Npf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jun 2019 09:45:35 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RDjBBc028961;
        Thu, 27 Jun 2019 09:45:26 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tcut7gm0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 09:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB2pmflkPtQ1EjSA4XsHPo2dgK2nVAet6jv3WkxWQu4=;
 b=0vXFuuXiQJ8xqnRR5ubeHd5GGogrFwa+fejHrB3Dv9HYRnAP60MPoIUuIJT45VAmayw/1d6uIvvmdZ0T4h+SUOHZS2TQ6aQ873B4St2CtwVwx4UWbOHeU7IAKKlt2z3E/t3YrArMDaXT2TaUnWLyuUE2KOOHvgEWc6+JaRITShs=
Received: from BN6PR03CA0019.namprd03.prod.outlook.com (2603:10b6:404:23::29)
 by CY1PR03MB2267.namprd03.prod.outlook.com (2a01:111:e400:c612::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Thu, 27 Jun
 2019 13:44:26 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR03CA0019.outlook.office365.com
 (2603:10b6:404:23::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.17 via Frontend
 Transport; Thu, 27 Jun 2019 13:44:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Thu, 27 Jun 2019 13:44:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5RDiOli025442
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Jun 2019 06:44:24 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 27 Jun 2019 09:44:24 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH 4/5] iio: imu: Add support for the ADIS16460 IMU
Thread-Topic: [PATCH 4/5] iio: imu: Add support for the ADIS16460 IMU
Thread-Index: AQHVK1fUAfYTq4GwV0aybv+Xy6jm8Kaui3KAgAE9wIA=
Date:   Thu, 27 Jun 2019 13:44:24 +0000
Message-ID: <542590faac2097cf8fa6d93f5e157bb2c4eb911e.camel@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
         <20190625131328.11883-4-alexandru.ardelean@analog.com>
         <20190626194701.060a50f9@archlinux>
In-Reply-To: <20190626194701.060a50f9@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECA95A8B0B62CF439CE7C0B46CC99FD0@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(8676002)(14444005)(316002)(86362001)(3846002)(102836004)(426003)(486006)(47776003)(6916009)(4326008)(2501003)(7696005)(106002)(54906003)(6116002)(23676004)(2486003)(229853002)(76176011)(30864003)(5660300002)(5640700003)(118296001)(8936002)(6306002)(2906002)(7736002)(70586007)(246002)(446003)(476003)(70206006)(305945005)(2616005)(7636002)(126002)(36756003)(107886003)(6246003)(436003)(14454004)(356004)(50466002)(478600001)(966005)(2351001)(26005)(336012)(186003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2267;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2681a0bf-f264-4fd1-8b6e-08d6fb05918f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY1PR03MB2267;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2267:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <CY1PR03MB2267B92ADD333713736C2543F9FD0@CY1PR03MB2267.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 008184426E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Hwz+z3/mOUwbQyKLAVqHxhbhlu95aoVckDQRZsD8miU9RrLi3FemrbS6jRS8Ul0EELYeDpQFKgOYgN/OIwSZmiy0S6UNL9vFLyThLf9rArLw64gdilv+pWjLHGp+WyIZCY4MXL61ypiiwqUhxOSh1kxxGEfTVW2GJPARLXimj/vLEaexXtFEDoGF4I0LQhSSsstXq7YkO3kQJvHAz5H2wDRDQIBwnXqMVmPSeAFmC3MJ5HnSNegMCiuV5o6SWxqWaCkgrxbRrAbsDo+8QBsFp+lHS6GdqleL8cYszUa9d2DRkpRrWHX5SohzRSySo7Cdg6nDt1+3CiSuF0O+/GQQCMg4MWFG8hLCaCENO7C7V092JjL/toz2uOfr8RAFKW2NanoWfL3NtK6Z8inewCYtJkL5QEMzWQf/8kBi1bcMVKg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2019 13:44:25.3454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2681a0bf-f264-4fd1-8b6e-08d6fb05918f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2267
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270160
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTI2IGF0IDE5OjQ3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDI1IEp1biAyMDE5IDE2OjEzOjI3ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGUgQURJUzE2NDYwIGRldmljZSBpcyBhIGNvbXBsZXRlIGluZXJ0aWFs
IHN5c3RlbSB0aGF0IGluY2x1ZGVzIGEgdHJpYXhpYWwNCj4gPiBneXJvc2NvcGUgYW5kIGEgdHJp
YXhpYWwgYWNjZWxlcm9tZXRlci4gSXQncyBtb3JlIHNpbXBsaWZpZWQgZGVzaWduIHRoYW4NCj4g
PiB0aGF0IG9mIHRoZSBBRElTMTY0ODAsIGFuZCBkb2VzIG5vdCBvZmZlciB0aGUgdHJpYXhpYWwg
bWFnbmV0b21ldGVycyAmDQo+ID4gcHJlc3N1cmUgc2Vuc29ycy4gSXQgZG9lcyBhbHNvIGhhdmUg
YSB0ZW1wZXJhdHVyZSBzZW5zb3IgKGxpa2UgdGhlDQo+ID4gQURJUzE2NDgwKS4NCj4gPiBTaW5j
ZSBpdCBpcyBwYXJ0IG9mIHRoZSBBRElTMTZYWFggZmFtaWx5LCBpdCByZS11c2VzIHBhcnRzIG9m
IHRoZSBBRElTDQo+ID4gbGlicmFyeS4NCj4gPiANCj4gPiBOYXR1cmFsbHksIHRoZSByZWdpc3Rl
ciBtYXAgaXMgZGlmZmVyZW50IGFuZCBtdWNoIG1vcmUgc2ltcGxpZmllZCB0aGFuIHRoZQ0KPiA+
IEFESVMxNjQ4MCBzdWJmYW1pbHksIHNvIGl0IGNhbm5vdCBiZSBpbnRlZ3JhdGVkIGludG8gdGhh
dCBkcml2ZXIuIEEgbWFqb3INCj4gPiBkaWZmZXJlbmNlIGlzIHRoYXQgdGhlIHJlZ2lzdGVycyBh
cmUgbm90IHBhZ2VkLg0KPiA+IA0KPiA+IE9uZSB0aGluZyB0aGF0IGlzIHBhcnRpY3VsYXJseSBz
cGVjaWFsIGFib3V0IGl0LCBpcyB0aGF0IGl0IHJlcXVpcmVzIGENCj4gPiBoaWdoZXIgQ1Mgc3Rh
bGwgZGVsYXkgYmV0d2VlbiBkYXRhIChhcm91bmQgMTYgdVMgdnMgb3RoZXIgY2hpcHMgZnJvbSB0
aGUNCj4gPiBmYW1pbHkgcmVxdWlyaW5nIGFyb3VuZCAyIHVTKS4NCj4gPiANCj4gPiBEYXRhc2hl
ZXQ6DQo+ID4gICBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1
bWVudGF0aW9uL2RhdGEtc2hlZXRzL2FkaXMxNjQ2MC5wZGYNCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEcmFnb3MgQm9nZGFuIDxkcmFnb3MuYm9nZGFuQGFuYWxvZy5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4NCj4gDQo+IEEgZmV3IGNvbW1lbnRzIGlubGluZSwgYnV0IG9ubHkgb25l
IHRoYXQgbWF0dGVycy4gTGljZW5zZXMgZGlzYWdyZWUNCj4gKHlvdSB3b3VsZCBhbG1vc3QgaGF2
ZSB0aG91Z2h0IEknZCBqdXN0IGZpeGVkIGEgbG9hZCBvZiB0aGVzZSBhbmQNCj4gaGF2ZSBpdCBm
cmVzaCBpbiBteSBtaW5kISkNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+
IC0tLQ0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+ICBkcml2
ZXJzL2lpby9pbXUvS2NvbmZpZyAgICAgfCAgIDkgKw0KPiA+ICBkcml2ZXJzL2lpby9pbXUvTWFr
ZWZpbGUgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDYwLmMgfCA0OTAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdl
ZCwgNTA3IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaWlv
L2ltdS9hZGlzMTY0NjAuYw0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTDQo+ID4gaW5kZXggNTQ0ZTIzNzUzZTk2Li5lZjJlMmNlZTMyZTEgMTAwNjQ0DQo+
ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC05Mzcs
NiArOTM3LDEzIEBAIEw6CWxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiAgRjoJaW5jbHVk
ZS9saW51eC9paW8vaW11L2FkaXMuaA0KPiA+ICBGOglkcml2ZXJzL2lpby9pbXUvYWRpcy5jDQo+
ID4gIA0KPiA+ICtBTkFMT0cgREVWSUNFUyBJTkMgQURJUzE2NDYwIERSSVZFUg0KPiA+ICtNOglE
cmFnb3MgQm9nZGFuIDxkcmFnb3MuYm9nZGFuQGFuYWxvZy5jb20+DQo+ID4gK1M6CVN1cHBvcnRl
ZA0KPiA+ICtMOglsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4gK1c6CWh0dHA6Ly9lei5h
bmFsb2cuY29tL2NvbW11bml0eS9saW51eC1kZXZpY2UtZHJpdmVycw0KPiA+ICtGOglkcml2ZXJz
L2lpby9pbXUvYWRpczE2NDYwLmMNCj4gPiArDQo+ID4gIEFOQUxPRyBERVZJQ0VTIElOQyBBRFA1
MDYxIERSSVZFUg0KPiA+ICBNOglTdGVmYW4gUG9wYSA8c3RlZmFuLnBvcGFAYW5hbG9nLmNvbT4N
Cj4gPiAgTDoJbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL2ltdS9LY29uZmlnIGIvZHJpdmVycy9paW8vaW11L0tjb25maWcNCj4gPiBpbmRleCAx
NTY2MzBhMjE2OTYuLmEyOWE0ODFjMjBkMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9p
bXUvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9LY29uZmlnDQo+ID4gQEAgLTE2
LDYgKzE2LDE1IEBAIGNvbmZpZyBBRElTMTY0MDANCj4gPiAgCSAgYWRpczE2MzY1LCBhZGlzMTY0
MDAgYW5kIGFkaXMxNjQwNSB0cmlheGlhbCBpbmVydGlhbCBzZW5zb3JzDQo+ID4gIAkgIChhZGlz
MTY0MDAgc2VyaWVzIGFsc28gaGF2ZSBtYWduZXRvbWV0ZXJzKS4NCj4gPiAgDQo+ID4gK2NvbmZp
ZyBBRElTMTY0NjANCj4gPiArCXRyaXN0YXRlICJBbmFsb2cgRGV2aWNlcyBBRElTMTY0NjAgYW5k
IHNpbWlsYXIgSU1VIGRyaXZlciINCj4gPiArCWRlcGVuZHMgb24gU1BJDQo+ID4gKwlzZWxlY3Qg
SUlPX0FESVNfTElCDQo+ID4gKwlzZWxlY3QgSUlPX0FESVNfTElCX0JVRkZFUiBpZiBJSU9fQlVG
RkVSDQo+ID4gKwloZWxwDQo+ID4gKwkgIFNheSB5ZXMgaGVyZSB0byBidWlsZCBzdXBwb3J0IGZv
ciBBbmFsb2cgRGV2aWNlcyBBRElTMTY0NjAgaW5lcnRpYWwNCj4gPiArCSAgc2Vuc29yLg0KPiBJ
IGhhdmUgYSBuYXN0eSBmZWVsaW5nIHRoaXMgaXMgc2hvcnQgZW5vdWdoIHRoYXQgb25lIG9mIHRo
ZSBzdGF0aWMNCj4gYW5hbHlzaXMgdG9vbHMgd2lsbCBtb2FuIGFuZCB3ZSdsbCBnZXQgYSBwYXRj
aCBhZGRpbmcgdGhlIG5hbWUgb2YgdGhlIG1vZHVsZQ0KPiBvciBzb21ldGhpbmcgbGlrZSB0aGF0
LCBtb3N0bHkgdG8gc2h1dCB1cCB0aGUgd2FybmluZy4NCg0KYWNrDQoNCj4gDQo+ID4gKw0KPiA+
ICBjb25maWcgQURJUzE2NDgwDQo+ID4gIAl0cmlzdGF0ZSAiQW5hbG9nIERldmljZXMgQURJUzE2
NDgwIGFuZCBzaW1pbGFyIElNVSBkcml2ZXIiDQo+ID4gIAlkZXBlbmRzIG9uIFNQSQ0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvTWFrZWZpbGUgYi9kcml2ZXJzL2lpby9pbXUvTWFr
ZWZpbGUNCj4gPiBpbmRleCA5ZTQ1MmZjZTFhYWYuLjRhNjk1ODg2NTUwNCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2lpby9pbXUvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL2lpby9pbXUv
TWFrZWZpbGUNCj4gPiBAQCAtNSw2ICs1LDcgQEANCj4gPiAgDQo+ID4gICMgV2hlbiBhZGRpbmcg
bmV3IGVudHJpZXMga2VlcCB0aGUgbGlzdCBpbiBhbHBoYWJldGljYWwgb3JkZXINCj4gPiAgb2Jq
LSQoQ09ORklHX0FESVMxNjQwMCkgKz0gYWRpczE2NDAwLm8NCj4gPiArb2JqLSQoQ09ORklHX0FE
SVMxNjQ2MCkgKz0gYWRpczE2NDYwLm8NCj4gPiAgb2JqLSQoQ09ORklHX0FESVMxNjQ4MCkgKz0g
YWRpczE2NDgwLm8NCj4gPiAgDQo+ID4gIGFkaXNfbGliLXkgKz0gYWRpcy5vDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NjAuYyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlz
MTY0NjAuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAw
Li42Yzg2YWYwNmI1ZDENCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9paW8v
aW11L2FkaXMxNjQ2MC5jDQo+ID4gQEAgLTAsMCArMSw0OTAgQEANCj4gPiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gDQo+IE1PRFVMRV9MSUNFTlNFKEdQTCkgbWVhbnMg
R1BMLTIuMCsgSUlSQyBzbyBmaXggb25lIG9yIHRoZSBvdGhlci4NCg0KYWNrDQpJJ2xsIHVwZGF0
ZSB0aGlzDQoNCj4gDQo+ID4gKy8qDQo+ID4gKyAqIEFESVMxNjQ2MCBJTVUgZHJpdmVyDQo+ID4g
KyAqDQo+ID4gKyAqIENvcHlyaWdodCAyMDE5IEFuYWxvZyBEZXZpY2VzIEluYy4NCj4gPiArICoN
Cj4gTml0cGljaywgVGhpcyBibGFuayBsaW5lIGRvZXNuJ3QgYWRkIGFueXRoaW5nLg0KDQphY2sN
Cg0KPiANCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc3BpL3Nw
aS5oPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L2lpby9pbXUvYWRpcy5oPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Rl
YnVnZnMuaD4NCj4gPiArDQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX1JFR19GTEFTSF9DTlQJCTB4
MDANCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX0RJQUdfU1RBVAkJMHgwMg0KPiA+ICsjZGVm
aW5lIEFESVMxNjQ2MF9SRUdfWF9HWVJPX0xPVwkweDA0DQo+ID4gKyNkZWZpbmUgQURJUzE2NDYw
X1JFR19YX0dZUk9fT1VUCTB4MDYNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1lfR1lST19M
T1cJMHgwOA0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfWV9HWVJPX09VVAkweDBBDQo+ID4g
KyNkZWZpbmUgQURJUzE2NDYwX1JFR19aX0dZUk9fTE9XCTB4MEMNCj4gPiArI2RlZmluZSBBRElT
MTY0NjBfUkVHX1pfR1lST19PVVQJMHgwRQ0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfWF9B
Q0NMX0xPVwkweDEwDQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX1JFR19YX0FDQ0xfT1VUCTB4MTIN
Cj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1lfQUNDTF9MT1cJMHgxNA0KPiA+ICsjZGVmaW5l
IEFESVMxNjQ2MF9SRUdfWV9BQ0NMX09VVAkweDE2DQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX1JF
R19aX0FDQ0xfTE9XCTB4MTgNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1pfQUNDTF9PVVQJ
MHgxQQ0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfU01QTF9DTlRSCQkweDFDDQo+ID4gKyNk
ZWZpbmUgQURJUzE2NDYwX1JFR19URU1QX09VVAkJMHgxRQ0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2
MF9SRUdfWF9ERUxUX0FORwkweDI0DQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX1JFR19ZX0RFTFRf
QU5HCTB4MjYNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1pfREVMVF9BTkcJMHgyOA0KPiA+
ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfWF9ERUxUX1ZFTAkweDJBDQo+ID4gKyNkZWZpbmUgQURJ
UzE2NDYwX1JFR19ZX0RFTFRfVkVMCTB4MkMNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1pf
REVMVF9WRUwJMHgyRQ0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfTVNDX0NUUkwJCTB4MzIN
Cj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1NZTkNfU0NBTAkJMHgzNA0KPiA+ICsjZGVmaW5l
IEFESVMxNjQ2MF9SRUdfREVDX1JBVEUJCTB4MzYNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVH
X0ZMVFJfQ1RSTAkJMHgzOA0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfR0xPQl9DTUQJCTB4
M0UNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1hfR1lST19PRkYJMHg0MA0KPiA+ICsjZGVm
aW5lIEFESVMxNjQ2MF9SRUdfWV9HWVJPX09GRgkweDQyDQo+ID4gKyNkZWZpbmUgQURJUzE2NDYw
X1JFR19aX0dZUk9fT0ZGCTB4NDQNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfUkVHX1hfQUNDTF9P
RkYJMHg0Ng0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfWV9BQ0NMX09GRgkweDQ4DQo+ID4g
KyNkZWZpbmUgQURJUzE2NDYwX1JFR19aX0FDQ0xfT0ZGCTB4NEENCj4gPiArI2RlZmluZSBBRElT
MTY0NjBfUkVHX0xPVF9JRDEgUgkJMHg1Mg0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfTE9U
X0lEMiBSCQkweDU0DQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX1JFR19QUk9EX0lECQkweDU2DQo+
ID4gKyNkZWZpbmUgQURJUzE2NDYwX1JFR19TRVJJQUxfTlVNCTB4NTgNCj4gPiArI2RlZmluZSBB
RElTMTY0NjBfUkVHX0NBTF9TR05UUgkJMHg2MA0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdf
Q0FMX0NSQwkJMHg2Mg0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9SRUdfQ09ERV9TR05UUgkweDY0
DQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX1JFR19DT0RFX0NSQwkJMHg2Ng0KPiA+ICsNCj4gPiAr
c3RydWN0IGFkaXMxNjQ2MF9jaGlwX2luZm8gew0KPiANCj4gRnV0dXJlIHByb29maW5nLCBvciBh
bm90aGVyIHBhcnQgZ29pbmcgdG8gYmUgYWRkZWQgc2hvcnRseT8NCj4gR2l2ZW4gdGhlIGhpc3Rv
cnkgb2YgdGhlc2UgZHJpdmVycyBhbmQgdGhlIGxhcmdlIG51bWJlciBvZiBwYXJ0cw0KPiB0aGF0
IGhhdmUgc2hvd24gdXAsIEknbGwgZ2l2ZSB0aGlzIG9uZSB0aGUgYmVuZWZpdCBvZiB0aGUgZG91
YnQhDQoNCkZ1dHVyZSBwcm9vZmluZy4NCltJbiB0aGUgc2hvcnQtdGVybV0gTm8gbmV3IHBhcnRz
IHdpbGwgYmUgYWRkZWQgdG8gdGhpcyBkcml2ZXIuDQpCdXQgd2Ugd2lsbCBzZWUgbGF0ZXIsIGlm
IHdlIGdldCBhbiBpbnRlcm5hbCByZXF1ZXN0IGZvciBzb21ldGhpbmcgdGhhdCBmaXRzIGhlcmUu
DQoNCkZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0aGlzIGRyaXZlciB3YXMgYWRhcHRlZCBmcm9tIGVp
dGhlciB0aGUgYWRpczE2NDAwIG9yIGFkaXMxNjQ4MCBkcml2ZXIocykuDQpVc3VhbGx5IHRoZSBt
YXJrZXQgZHJpdmVyIGZvciB0aGVzZSBzZWVtcyB0byBiZSB0aGUgYXV0b21vdGl2ZSBpbmR1c3Ry
eSwgYnV0IHRoZSBjdXJyZW50IGRyaXZlciBmb3IgdGhpcyBwYXJ0aWN1bGFyIG9uZQ0KaXMgb25l
IG9mIG91ciByZWZlcmVuY2UgZGVzaWduczoNCmh0dHBzOi8vd2lraS5hbmFsb2cuY29tL3Jlc291
cmNlcy9ldmFsL3VzZXItZ3VpZGVzL3B6c2RyL2NhcnJpZXJzL3BhY2tyZg0KaHR0cHM6Ly93aWtp
LmFuYWxvZy5jb20vcmVzb3VyY2VzL2V2YWwvdXNlci1ndWlkZXMvcHpzZHIvY2FycmllcnMvcGFj
a3JmL2hhcmR3YXJlDQoNClNvbWV3aGVyZSBpbiB0aGUgc2NoZW1hdGljcywgdGhlcmUncyBhIG1l
bnRpb24gdGhhdCB0aGlzIElNVSBpcyB1c2VkLg0KDQo+IA0KPiA+ICsJdW5zaWduZWQgaW50IG51
bV9jaGFubmVsczsNCj4gPiArCWNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFubmVsczsN
Cj4gPiArCXVuc2lnbmVkIGludCBneXJvX21heF92YWw7DQo+ID4gKwl1bnNpZ25lZCBpbnQgZ3ly
b19tYXhfc2NhbGU7DQo+ID4gKwl1bnNpZ25lZCBpbnQgYWNjZWxfbWF4X3ZhbDsNCj4gPiArCXVu
c2lnbmVkIGludCBhY2NlbF9tYXhfc2NhbGU7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3Qg
YWRpczE2NDYwIHsNCj4gPiArCWNvbnN0IHN0cnVjdCBhZGlzMTY0NjBfY2hpcF9pbmZvICpjaGlw
X2luZm87DQo+ID4gKwlzdHJ1Y3QgYWRpcyBhZGlzOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArI2lm
ZGVmIENPTkZJR19ERUJVR19GUw0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZGlzMTY0NjBfc2hv
d19zZXJpYWxfbnVtYmVyKHZvaWQgKmFyZywgdTY0ICp2YWwpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBhZGlzMTY0NjAgKmFkaXMxNjQ2MCA9IGFyZzsNCj4gPiArCXUxNiBzZXJpYWw7DQo+ID4gKwlp
bnQgcmV0Ow0KPiA+ICsNCj4gPiArCXJldCA9IGFkaXNfcmVhZF9yZWdfMTYoJmFkaXMxNjQ2MC0+
YWRpcywgQURJUzE2NDYwX1JFR19TRVJJQUxfTlVNLA0KPiA+ICsJCSZzZXJpYWwpOw0KPiA+ICsJ
aWYgKHJldCA8IDApDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkqdmFsID0gc2Vy
aWFsOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gK0RFRklORV9TSU1QTEVf
QVRUUklCVVRFKGFkaXMxNjQ2MF9zZXJpYWxfbnVtYmVyX2ZvcHMsDQo+ID4gKwlhZGlzMTY0NjBf
c2hvd19zZXJpYWxfbnVtYmVyLCBOVUxMLCAiMHglLjRsbHhcbiIpOw0KPiA+ICsNCj4gPiArc3Rh
dGljIGludCBhZGlzMTY0NjBfc2hvd19wcm9kdWN0X2lkKHZvaWQgKmFyZywgdTY0ICp2YWwpDQo+
ID4gK3sNCj4gPiArCXN0cnVjdCBhZGlzMTY0NjAgKmFkaXMxNjQ2MCA9IGFyZzsNCj4gPiArCXUx
NiBwcm9kX2lkOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBhZGlzX3JlYWRf
cmVnXzE2KCZhZGlzMTY0NjAtPmFkaXMsIEFESVMxNjQ2MF9SRUdfUFJPRF9JRCwNCj4gPiArCQkm
cHJvZF9pZCk7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArCSp2YWwgPSBwcm9kX2lkOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+
ID4gK0RFRklORV9TSU1QTEVfQVRUUklCVVRFKGFkaXMxNjQ2MF9wcm9kdWN0X2lkX2ZvcHMsDQo+
ID4gKwlhZGlzMTY0NjBfc2hvd19wcm9kdWN0X2lkLCBOVUxMLCAiJWxsdVxuIik7DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IGFkaXMxNjQ2MF9zaG93X2ZsYXNoX2NvdW50KHZvaWQgKmFyZywgdTY0
ICp2YWwpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhZGlzMTY0NjAgKmFkaXMxNjQ2MCA9IGFyZzsN
Cj4gPiArCXUzMiBmbGFzaF9jb3VudDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gYWRpc19yZWFkX3JlZ18zMigmYWRpczE2NDYwLT5hZGlzLCBBRElTMTY0NjBfUkVHX0ZMQVNI
X0NOVCwNCj4gPiArCQkmZmxhc2hfY291bnQpOw0KPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gKwkJ
cmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkqdmFsID0gZmxhc2hfY291bnQ7DQo+ID4gKw0KPiA+
ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArREVGSU5FX1NJTVBMRV9BVFRSSUJVVEUoYWRpczE2
NDYwX2ZsYXNoX2NvdW50X2ZvcHMsDQo+ID4gKwlhZGlzMTY0NjBfc2hvd19mbGFzaF9jb3VudCwg
TlVMTCwgIiVsbGRcbiIpOw0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZGlzMTY0NjBfZGVidWdm
c19pbml0KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBh
ZGlzMTY0NjAgKmFkaXMxNjQ2MCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKw0KPiA+ICsJ
ZGVidWdmc19jcmVhdGVfZmlsZSgic2VyaWFsX251bWJlciIsIDA0MDAsIGluZGlvX2Rldi0+ZGVi
dWdmc19kZW50cnksDQo+ID4gKwkJYWRpczE2NDYwLCAmYWRpczE2NDYwX3NlcmlhbF9udW1iZXJf
Zm9wcyk7DQo+ID4gKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJwcm9kdWN0X2lkIiwgMDQwMCwgaW5k
aW9fZGV2LT5kZWJ1Z2ZzX2RlbnRyeSwNCj4gPiArCQlhZGlzMTY0NjAsICZhZGlzMTY0NjBfcHJv
ZHVjdF9pZF9mb3BzKTsNCj4gPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGUoImZsYXNoX2NvdW50Iiwg
MDQwMCwgaW5kaW9fZGV2LT5kZWJ1Z2ZzX2RlbnRyeSwNCj4gPiArCQlhZGlzMTY0NjAsICZhZGlz
MTY0NjBfZmxhc2hfY291bnRfZm9wcyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30N
Cj4gPiArDQo+ID4gKyNlbHNlDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkaXMxNjQ2MF9kZWJ1
Z2ZzX2luaXQoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiArew0KPiA+ICsJcmV0dXJu
IDA7DQo+ID4gK30NCj4gPiArDQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiArc3RhdGljIGludCBh
ZGlzMTY0NjBfc2V0X2ZyZXEoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwgaW50IHZhbCwgaW50
IHZhbDIpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhZGlzMTY0NjAgKnN0ID0gaWlvX3ByaXYoaW5k
aW9fZGV2KTsNCj4gPiArCXVuc2lnbmVkIGludCB0Ow0KPiA+ICsNCj4gPiArCXQgPSAgdmFsICog
MTAwMCArIHZhbDIgLyAxMDAwOw0KPiA+ICsJaWYgKHQgPD0gMCkNCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiArDQo+ID4gKwl0ID0gMjA0ODAwMCAvIHQ7DQo+ID4gKwlpZiAodCA+IDIwNDgp
DQo+ID4gKwkJdCA9IDIwNDg7DQo+ID4gKw0KPiA+ICsJaWYgKHQgIT0gMCkNCj4gPiArCQl0LS07
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGFkaXNfd3JpdGVfcmVnXzE2KCZzdC0+YWRpcywgQURJUzE2
NDYwX1JFR19ERUNfUkFURSwgdCk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYWRp
czE2NDYwX2dldF9mcmVxKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIGludCAqdmFsLCBpbnQg
KnZhbDIpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhZGlzMTY0NjAgKnN0ID0gaWlvX3ByaXYoaW5k
aW9fZGV2KTsNCj4gPiArCXVpbnQxNl90IHQ7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJdW5zaWdu
ZWQgZnJlcTsNCj4gPiArDQo+ID4gKwlyZXQgPSBhZGlzX3JlYWRfcmVnXzE2KCZzdC0+YWRpcywg
QURJUzE2NDYwX1JFR19ERUNfUkFURSwgJnQpOw0KPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gKwkJ
cmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlmcmVxID0gMjA0ODAwMCAvICh0ICsgMSk7DQo+ID4g
KwkqdmFsID0gZnJlcSAvIDEwMDA7DQo+ID4gKwkqdmFsMiA9IChmcmVxICUgMTAwMCkgKiAxMDAw
Ow0KPiA+ICsNCj4gPiArCXJldHVybiBJSU9fVkFMX0lOVF9QTFVTX01JQ1JPOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkaXMxNjQ2MF9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2LA0KPiA+ICsJY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW4sIGludCAq
dmFsLCBpbnQgKnZhbDIsIGxvbmcgaW5mbykNCj4gPiArew0KPiA+ICsJc3RydWN0IGFkaXMxNjQ2
MCAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICsNCj4gPiArCXN3aXRjaCAoaW5mbykg
ew0KPiA+ICsJY2FzZSBJSU9fQ0hBTl9JTkZPX1JBVzoNCj4gPiArCQlyZXR1cm4gYWRpc19zaW5n
bGVfY29udmVyc2lvbihpbmRpb19kZXYsIGNoYW4sIDAsIHZhbCk7DQo+ID4gKwljYXNlIElJT19D
SEFOX0lORk9fU0NBTEU6DQo+ID4gKwkJc3dpdGNoIChjaGFuLT50eXBlKSB7DQo+ID4gKwkJY2Fz
ZSBJSU9fQU5HTF9WRUw6DQo+ID4gKwkJCSp2YWwgPSBzdC0+Y2hpcF9pbmZvLT5neXJvX21heF9z
Y2FsZTsNCj4gPiArCQkJKnZhbDIgPSBzdC0+Y2hpcF9pbmZvLT5neXJvX21heF92YWw7DQo+ID4g
KwkJCXJldHVybiBJSU9fVkFMX0ZSQUNUSU9OQUw7DQo+ID4gKwkJY2FzZSBJSU9fQUNDRUw6DQo+
ID4gKwkJCSp2YWwgPSBzdC0+Y2hpcF9pbmZvLT5hY2NlbF9tYXhfc2NhbGU7DQo+ID4gKwkJCSp2
YWwyID0gc3QtPmNoaXBfaW5mby0+YWNjZWxfbWF4X3ZhbDsNCj4gPiArCQkJcmV0dXJuIElJT19W
QUxfRlJBQ1RJT05BTDsNCj4gPiArCQljYXNlIElJT19URU1QOg0KPiA+ICsJCQkqdmFsID0gNTA7
IC8qIDUwIG1pbGxpIGRlZ3JlZXMgQ2Vsc2l1cy9MU0IgKi8NCj4gPiArCQkJcmV0dXJuIElJT19W
QUxfSU5UOw0KPiA+ICsJCWRlZmF1bHQ6DQo+ID4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJ
CX0NCj4gPiArCWNhc2UgSUlPX0NIQU5fSU5GT19PRkZTRVQ6DQo+ID4gKwkJKnZhbCA9IDUwMDsg
LyogMjUgZGVncmVlcyBDZWxzaXVzID0gMHgwMDAwICovDQo+ID4gKwkJcmV0dXJuIElJT19WQUxf
SU5UOw0KPiA+ICsJY2FzZSBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUToNCj4gPiArCQlyZXR1cm4g
YWRpczE2NDYwX2dldF9mcmVxKGluZGlvX2RldiwgdmFsLCB2YWwyKTsNCj4gPiArCWRlZmF1bHQ6
DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyBpbnQgYWRpczE2NDYwX3dyaXRlX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0K
PiA+ICsJY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW4sIGludCB2YWwsIGludCB2YWwy
LCBsb25nIGluZm8pDQo+ID4gK3sNCj4gPiArCXN3aXRjaCAoaW5mbykgew0KPiA+ICsJY2FzZSBJ
SU9fQ0hBTl9JTkZPX1NBTVBfRlJFUToNCj4gPiArCQlyZXR1cm4gYWRpczE2NDYwX3NldF9mcmVx
KGluZGlvX2RldiwgdmFsLCB2YWwyKTsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gK2VudW0gew0KPiA+ICsJQURJUzE2
NDYwX1NDQU5fR1lST19YLA0KPiA+ICsJQURJUzE2NDYwX1NDQU5fR1lST19ZLA0KPiA+ICsJQURJ
UzE2NDYwX1NDQU5fR1lST19aLA0KPiA+ICsJQURJUzE2NDYwX1NDQU5fQUNDRUxfWCwNCj4gPiAr
CUFESVMxNjQ2MF9TQ0FOX0FDQ0VMX1ksDQo+ID4gKwlBRElTMTY0NjBfU0NBTl9BQ0NFTF9aLA0K
PiA+ICsJQURJUzE2NDYwX1NDQU5fVEVNUCwNCj4gPiArfTsNCj4gPiArDQo+ID4gKyNkZWZpbmUg
QURJUzE2NDYwX01PRF9DSEFOTkVMKF90eXBlLCBfbW9kLCBfYWRkcmVzcywgX3NpLCBfYml0cykg
XA0KPiA+ICsJeyBcDQo+ID4gKwkJLnR5cGUgPSAoX3R5cGUpLCBcDQo+ID4gKwkJLm1vZGlmaWVk
ID0gMSwgXA0KPiA+ICsJCS5jaGFubmVsMiA9IChfbW9kKSwgXA0KPiA+ICsJCS5pbmZvX21hc2tf
c2VwYXJhdGUgPSBCSVQoSUlPX0NIQU5fSU5GT19SQVcpLCBcDQo+ID4gKwkJLmluZm9fbWFza19z
aGFyZWRfYnlfdHlwZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1NDQUxFKSwgXA0KPiA+ICsJCS5pbmZv
X21hc2tfc2hhcmVkX2J5X2FsbCA9IEJJVChJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUSksIFwNCj4g
PiArCQkuYWRkcmVzcyA9IChfYWRkcmVzcyksIFwNCj4gPiArCQkuc2Nhbl9pbmRleCA9IChfc2kp
LCBcDQo+ID4gKwkJLnNjYW5fdHlwZSA9IHsgXA0KPiA+ICsJCQkuc2lnbiA9ICdzJywgXA0KPiA+
ICsJCQkucmVhbGJpdHMgPSAoX2JpdHMpLCBcDQo+ID4gKwkJCS5zdG9yYWdlYml0cyA9IChfYml0
cyksIFwNCj4gPiArCQkJLmVuZGlhbm5lc3MgPSBJSU9fQkUsIFwNCj4gPiArCQl9LCBcDQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9HWVJPX0NIQU5ORUwoX21vZCkgXA0K
PiA+ICsJQURJUzE2NDYwX01PRF9DSEFOTkVMKElJT19BTkdMX1ZFTCwgSUlPX01PRF8gIyMgX21v
ZCwgXA0KPiA+ICsJQURJUzE2NDYwX1JFR18gIyMgX21vZCAjIyBfR1lST19MT1csIEFESVMxNjQ2
MF9TQ0FOX0dZUk9fICMjIF9tb2QsIFwNCj4gPiArCTMyKQ0KPiA+ICsNCj4gPiArI2RlZmluZSBB
RElTMTY0NjBfQUNDRUxfQ0hBTk5FTChfbW9kKSBcDQo+ID4gKwlBRElTMTY0NjBfTU9EX0NIQU5O
RUwoSUlPX0FDQ0VMLCBJSU9fTU9EXyAjIyBfbW9kLCBcDQo+ID4gKwlBRElTMTY0NjBfUkVHXyAj
IyBfbW9kICMjIF9BQ0NMX0xPVywgQURJUzE2NDYwX1NDQU5fQUNDRUxfICMjIF9tb2QsIFwNCj4g
PiArCTMyKQ0KPiA+ICsNCj4gPiArI2RlZmluZSBBRElTMTY0NjBfVEVNUF9DSEFOTkVMKCkgeyBc
DQo+ID4gKwkJLnR5cGUgPSBJSU9fVEVNUCwgXA0KPiA+ICsJCS5pbmRleGVkID0gMSwgXA0KPiA+
ICsJCS5jaGFubmVsID0gMCwgXA0KPiA+ICsJCS5pbmZvX21hc2tfc2VwYXJhdGUgPSBCSVQoSUlP
X0NIQU5fSU5GT19SQVcpIHwgXA0KPiA+ICsJCQlCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSkgfCBc
DQo+ID4gKwkJCUJJVChJSU9fQ0hBTl9JTkZPX09GRlNFVCksIFwNCj4gPiArCQkuaW5mb19tYXNr
X3NoYXJlZF9ieV9hbGwgPSBCSVQoSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEpLCBcDQo+ID4gKwkJ
LmFkZHJlc3MgPSBBRElTMTY0NjBfUkVHX1RFTVBfT1VULCBcDQo+ID4gKwkJLnNjYW5faW5kZXgg
PSBBRElTMTY0NjBfU0NBTl9URU1QLCBcDQo+ID4gKwkJLnNjYW5fdHlwZSA9IHsgXA0KPiA+ICsJ
CQkuc2lnbiA9ICdzJywgXA0KPiA+ICsJCQkucmVhbGJpdHMgPSAxNiwgXA0KPiA+ICsJCQkuc3Rv
cmFnZWJpdHMgPSAxNiwgXA0KPiA+ICsJCQkuZW5kaWFubmVzcyA9IElJT19CRSwgXA0KPiA+ICsJ
CX0sIFwNCj4gPiArCX0NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5f
c3BlYyBhZGlzMTY0NjBfY2hhbm5lbHNbXSA9IHsNCj4gPiArCUFESVMxNjQ2MF9HWVJPX0NIQU5O
RUwoWCksDQo+ID4gKwlBRElTMTY0NjBfR1lST19DSEFOTkVMKFkpLA0KPiA+ICsJQURJUzE2NDYw
X0dZUk9fQ0hBTk5FTChaKSwNCj4gPiArCUFESVMxNjQ2MF9BQ0NFTF9DSEFOTkVMKFgpLA0KPiA+
ICsJQURJUzE2NDYwX0FDQ0VMX0NIQU5ORUwoWSksDQo+ID4gKwlBRElTMTY0NjBfQUNDRUxfQ0hB
Tk5FTChaKSwNCj4gPiArCUFESVMxNjQ2MF9URU1QX0NIQU5ORUwoKSwNCj4gPiArCUlJT19DSEFO
X1NPRlRfVElNRVNUQU1QKDcpDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGFkaXMxNjQ2MF9jaGlwX2luZm8gYWRpczE2NDYwX2NoaXBfaW5mbyA9IHsNCj4gPiArCS5j
aGFubmVscyA9IGFkaXMxNjQ2MF9jaGFubmVscywNCj4gPiArCS5udW1fY2hhbm5lbHMgPSBBUlJB
WV9TSVpFKGFkaXMxNjQ2MF9jaGFubmVscyksDQo+ID4gKwkvKg0KPiA+ICsJICogc3RvcmluZyB0
aGUgdmFsdWUgaW4gcmFkL2RlZ3JlZSBhbmQgdGhlIHNjYWxlIGluIGRlZ3JlZQ0KPiA+ICsJICog
Z2l2ZXMgdXMgdGhlIHJlc3VsdCBpbiByYWQgYW5kIGJldHRlciBwcmVjZXNzaW9uIHRoYW4NCj4g
PiArCSAqIHN0b3JpbmcgdGhlIHNjYWxlIGRpcmVjdGx5IGluIHJhZC4NCj4gPiArCSAqLw0KPiA+
ICsJLmd5cm9fbWF4X3ZhbCA9IElJT19SQURfVE9fREVHUkVFKDIwMCA8PCAxNiksDQo+ID4gKwku
Z3lyb19tYXhfc2NhbGUgPSAxLA0KPiA+ICsJLmFjY2VsX21heF92YWwgPSBJSU9fTV9TXzJfVE9f
RygyMDAwMCA8PCAxNiksDQo+ID4gKwkuYWNjZWxfbWF4X3NjYWxlID0gNSwNCj4gPiArfTsNCj4g
PiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gYWRpczE2NDYwX2luZm8gPSB7
DQo+ID4gKwkucmVhZF9yYXcgPSAmYWRpczE2NDYwX3JlYWRfcmF3LA0KPiA+ICsJLndyaXRlX3Jh
dyA9ICZhZGlzMTY0NjBfd3JpdGVfcmF3LA0KPiA+ICsJLnVwZGF0ZV9zY2FuX21vZGUgPSBhZGlz
X3VwZGF0ZV9zY2FuX21vZGUsDQo+ID4gKwkuZGVidWdmc19yZWdfYWNjZXNzID0gYWRpc19kZWJ1
Z2ZzX3JlZ19hY2Nlc3MsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkaXMxNjQ2
MF9lbmFibGVfaXJxKHN0cnVjdCBhZGlzICphZGlzLCBib29sIGVuYWJsZSkNCj4gPiArew0KPiA+
ICsJLyoNCj4gPiArCSAqIFRoZXJlIGlzIG5vIHdheSB0byBnYXRlIHRoZSBkYXRhLXJlYWR5IHNp
Z25hbCBpbnRlcm5hbGx5IGluc2lkZSB0aGUNCj4gPiArCSAqIEFESVMxNjQ2MCA6KA0KPiANCj4g
WXVrLiBUaGF0J3Mgbm90IGEgbmljZSB0aGluZyB0byBkcm9wIGluIGEgc2ltcGxpZmllZCBkZXNp
Z24hDQo+IG9oIHdlbGwsIGl0J3MgZmFyIGZyb20gdGhlIGZpcnN0IHRpbWUuDQo+IA0KPiA+ICsJ
ICovDQo+ID4gKwlpZiAoZW5hYmxlKQ0KPiA+ICsJCWVuYWJsZV9pcnEoYWRpcy0+c3BpLT5pcnEp
Ow0KPiA+ICsJZWxzZQ0KPiA+ICsJCWRpc2FibGVfaXJxKGFkaXMtPnNwaS0+aXJxKTsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZGlzMTY0
NjBfaW5pdGlhbF9zZXR1cChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgYWRpczE2NDYwICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKwl1aW50
MTZfdCBwcm9kX2lkOw0KPiA+ICsJdW5zaWduZWQgaW50IGRldmljZV9pZDsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsJYWRpc19yZXNldCgmc3QtPmFkaXMpOw0KPiA+ICsJbXNsZWVwKDIy
Mik7DQo+ID4gKw0KPiA+ICsJcmV0ID0gYWRpc193cml0ZV9yZWdfMTYoJnN0LT5hZGlzLCBBRElT
MTY0NjBfUkVHX0dMT0JfQ01ELCBCSVQoMSkpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsJbXNsZWVwKDc1KTsNCj4gPiArDQo+ID4gKwlyZXQgPSBhZGlzX2NoZWNr
X3N0YXR1cygmc3QtPmFkaXMpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0K
PiA+ICsNCj4gPiArCXJldCA9IGFkaXNfcmVhZF9yZWdfMTYoJnN0LT5hZGlzLCBBRElTMTY0NjBf
UkVHX1BST0RfSUQsICZwcm9kX2lkKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJl
dDsNCj4gPiArDQo+ID4gKwlyZXQgPSBzc2NhbmYoaW5kaW9fZGV2LT5uYW1lLCAiYWRpcyV1XG4i
LCAmZGV2aWNlX2lkKTsNCj4gPiArCWlmIChyZXQgIT0gMSkNCj4gPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiArDQo+ID4gKwlpZiAocHJvZF9pZCAhPSBkZXZpY2VfaWQpDQo+ID4gKwkJZGV2X3dh
cm4oJmluZGlvX2Rldi0+ZGV2LCAiRGV2aWNlIElEKCV1KSBhbmQgcHJvZHVjdCBJRCgldSkgZG8g
bm90IG1hdGNoLiIsDQo+ID4gKwkJCQlkZXZpY2VfaWQsIHByb2RfaWQpOw0KPiA+ICsNCj4gPiAr
CXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9ESUFHX1NU
QVRfSU5fQ0xLX09PUwk3DQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX0RJQUdfU1RBVF9GTEFTSF9N
RU0JNg0KPiA+ICsjZGVmaW5lIEFESVMxNjQ2MF9ESUFHX1NUQVRfU0VMRl9URVNUCTUNCj4gPiAr
I2RlZmluZSBBRElTMTY0NjBfRElBR19TVEFUX09WRVJSQU5HRQk0DQo+ID4gKyNkZWZpbmUgQURJ
UzE2NDYwX0RJQUdfU1RBVF9TUElfQ09NTQkzDQo+ID4gKyNkZWZpbmUgQURJUzE2NDYwX0RJQUdf
U1RBVF9GTEFTSF9VUFQJMg0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBh
ZGlzMTY0NjBfc3RhdHVzX2Vycm9yX21zZ3NbXSA9IHsNCj4gPiArCVtBRElTMTY0NjBfRElBR19T
VEFUX0lOX0NMS19PT1NdID0gIklucHV0IGNsb2NrIG91dCBvZiBzeW5jIiwNCj4gPiArCVtBRElT
MTY0NjBfRElBR19TVEFUX0ZMQVNIX01FTV0gPSAiRmxhc2ggbWVtb3J5IGZhaWx1cmUiLA0KPiA+
ICsJW0FESVMxNjQ2MF9ESUFHX1NUQVRfU0VMRl9URVNUXSA9ICJTZWxmIHRlc3QgZGlhZ25vc3Rp
YyBmYWlsdXJlIiwNCj4gPiArCVtBRElTMTY0NjBfRElBR19TVEFUX09WRVJSQU5HRV0gPSAiU2Vu
c29yIG92ZXJyYW5nZSIsDQo+ID4gKwlbQURJUzE2NDYwX0RJQUdfU1RBVF9TUElfQ09NTV0gPSAi
U1BJIGNvbW11bmljYXRpb24gZmFpbHVyZSIsDQo+ID4gKwlbQURJUzE2NDYwX0RJQUdfU1RBVF9G
TEFTSF9VUFRdID0gIkZsYXNoIHVwZGF0ZSBmYWlsdXJlIiwNCj4gPiArfTsNCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgYWRpc19kYXRhIGFkaXMxNjQ2MF9kYXRhID0gew0KPiA+ICsJ
LmRpYWdfc3RhdF9yZWcgPSBBRElTMTY0NjBfUkVHX0RJQUdfU1RBVCwNCj4gPiArCS5nbG9iX2Nt
ZF9yZWcgPSBBRElTMTY0NjBfUkVHX0dMT0JfQ01ELA0KPiA+ICsJLmhhc19wYWdpbmcgPSBmYWxz
ZSwNCj4gPiArCS5yZWFkX2RlbGF5ID0gNSwNCj4gPiArCS53cml0ZV9kZWxheSA9IDUsDQo+ID4g
KwkuY3Nfc3RhbGxfZGVsYXkgPSAxNiwNCj4gPiArCS5zdGF0dXNfZXJyb3JfbXNncyA9IGFkaXMx
NjQ2MF9zdGF0dXNfZXJyb3JfbXNncywNCj4gPiArCS5zdGF0dXNfZXJyb3JfbWFzayA9IEJJVChB
RElTMTY0NjBfRElBR19TVEFUX0lOX0NMS19PT1MpIHwNCj4gPiArCQlCSVQoQURJUzE2NDYwX0RJ
QUdfU1RBVF9GTEFTSF9NRU0pIHwNCj4gPiArCQlCSVQoQURJUzE2NDYwX0RJQUdfU1RBVF9TRUxG
X1RFU1QpIHwNCj4gPiArCQlCSVQoQURJUzE2NDYwX0RJQUdfU1RBVF9PVkVSUkFOR0UpIHwNCj4g
PiArCQlCSVQoQURJUzE2NDYwX0RJQUdfU1RBVF9TUElfQ09NTSkgfA0KPiA+ICsJCUJJVChBRElT
MTY0NjBfRElBR19TVEFUX0ZMQVNIX1VQVCksDQo+ID4gKwkuZW5hYmxlX2lycSA9IGFkaXMxNjQ2
MF9lbmFibGVfaXJxLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZGlzMTY0NjBf
cHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGlpb19k
ZXYgKmluZGlvX2RldjsNCj4gPiArCXN0cnVjdCBhZGlzMTY0NjAgKnN0Ow0KPiA+ICsJaW50IHJl
dDsNCj4gPiArDQo+ID4gKwlpbmRpb19kZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoJnNwaS0+
ZGV2LCBzaXplb2YoKnN0KSk7DQo+ID4gKwlpZiAoaW5kaW9fZGV2ID09IE5VTEwpDQo+ID4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJc3BpX3NldF9kcnZkYXRhKHNwaSwgaW5kaW9f
ZGV2KTsNCj4gPiArDQo+ID4gKwlzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKw0KPiA+
ICsJc3QtPmNoaXBfaW5mbyA9ICZhZGlzMTY0NjBfY2hpcF9pbmZvOw0KPiA+ICsJaW5kaW9fZGV2
LT5kZXYucGFyZW50ID0gJnNwaS0+ZGV2Ow0KPiA+ICsJaW5kaW9fZGV2LT5uYW1lID0gc3BpX2dl
dF9kZXZpY2VfaWQoc3BpKS0+bmFtZTsNCj4gPiArCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBzdC0+
Y2hpcF9pbmZvLT5jaGFubmVsczsNCj4gPiArCWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gc3Qt
PmNoaXBfaW5mby0+bnVtX2NoYW5uZWxzOw0KPiA+ICsJaW5kaW9fZGV2LT5pbmZvID0gJmFkaXMx
NjQ2MF9pbmZvOw0KPiA+ICsJaW5kaW9fZGV2LT5tb2RlcyA9IElORElPX0RJUkVDVF9NT0RFOw0K
PiA+ICsNCj4gPiArCXJldCA9IGFkaXNfaW5pdCgmc3QtPmFkaXMsIGluZGlvX2Rldiwgc3BpLCAm
YWRpczE2NDYwX2RhdGEpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+
ICsNCj4gPiArCXJldCA9IGFkaXNfc2V0dXBfYnVmZmVyX2FuZF90cmlnZ2VyKCZzdC0+YWRpcywg
aW5kaW9fZGV2LCBOVUxMKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4g
PiArDQo+ID4gKwlhZGlzMTY0NjBfZW5hYmxlX2lycSgmc3QtPmFkaXMsIDApOw0KPiA+ICsNCj4g
PiArCXJldCA9IGFkaXMxNjQ2MF9pbml0aWFsX3NldHVwKGluZGlvX2Rldik7DQo+ID4gKwlpZiAo
cmV0KQ0KPiA+ICsJCWdvdG8gZXJyb3JfY2xlYW51cF9idWZmZXI7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gaWlvX2RldmljZV9yZWdpc3RlcihpbmRpb19kZXYpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiAr
CQlnb3RvIGVycm9yX2NsZWFudXBfYnVmZmVyOw0KPiA+ICsNCj4gPiArCWFkaXMxNjQ2MF9kZWJ1
Z2ZzX2luaXQoaW5kaW9fZGV2KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArDQo+ID4g
K2Vycm9yX2NsZWFudXBfYnVmZmVyOg0KPiA+ICsJYWRpc19jbGVhbnVwX2J1ZmZlcl9hbmRfdHJp
Z2dlcigmc3QtPmFkaXMsIGluZGlvX2Rldik7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkaXMxNjQ2MF9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHNwaV9nZXRf
ZHJ2ZGF0YShzcGkpOw0KPiA+ICsJc3RydWN0IGFkaXMxNjQ2MCAqc3QgPSBpaW9fcHJpdihpbmRp
b19kZXYpOw0KPiA+ICsNCj4gPiArCWlpb19kZXZpY2VfdW5yZWdpc3RlcihpbmRpb19kZXYpOw0K
PiA+ICsNCj4gPiArCWFkaXNfY2xlYW51cF9idWZmZXJfYW5kX3RyaWdnZXIoJnN0LT5hZGlzLCBp
bmRpb19kZXYpOw0KPiBJdCBtaWdodCBiZSB3b3J0aCB0aGlua2luZyBhYm91dCBhIGRldm1fIHZh
cmlhdGlvbiBvZiB0aGUNCj4gZnVuY3Rpb24gdGhhdCBwYWlycyB3aXRoIHRoaXMgc28gYXMgdG8g
dGlkeSB1cCAoZ2V0IHJpZCBvZiEpIHRoaXMNCj4gcmF0aGVyIG1pbmltYWwgcmVtb3ZlLi4uDQoN
CkkgYWdyZWUuDQpJJ2xsIG1ha2UgYSBub3RlIG9mIGl0Lg0KDQpJIHdhcyBsb29raW5nIHRocm91
Z2ggdGhlIEFESVMgbGliICh3aGVuIHByZXBhcmluZyB0aGlzIGRyaXZlcikgYW5kIGl0IHNlZW1z
IHRoYXQgc29tZSBtb3JlIGNsZWFudXAgY291bGQgYmUgYWRkZWQgaW4NCnRoZXJlLg0KDQo+IA0K
PiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHNwaV9kZXZpY2VfaWQgYWRpczE2NDYwX2lkc1tdID0gew0KPiA+ICsJeyAiYWRpczE2
NDYwIiwgMCB9LA0KPiA+ICsJe30NCj4gPiArfTsNCj4gPiArTU9EVUxFX0RFVklDRV9UQUJMRShz
cGksIGFkaXMxNjQ2MF9pZCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBhZGlzMTY0NjBfb2ZfbWF0Y2hbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAi
YWRpLGFkaXMxNjQ2MCIgfSwNCj4gPiArCXt9DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0Vf
VEFCTEUob2YsIGFkaXMxNjQ2MF9vZl9tYXRjaCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0
IHNwaV9kcml2ZXIgYWRpczE2NDYwX2RyaXZlciA9IHsNCj4gPiArCS5kcml2ZXIgPSB7DQo+ID4g
KwkJLm5hbWUgPSAiYWRpczE2NDYwIiwNCj4gPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBhZGlzMTY0
NjBfb2ZfbWF0Y2gsDQo+ID4gKwl9LA0KPiA+ICsJLmlkX3RhYmxlID0gYWRpczE2NDYwX2lkcywN
Cj4gPiArCS5wcm9iZSA9IGFkaXMxNjQ2MF9wcm9iZSwNCj4gPiArCS5yZW1vdmUgPSBhZGlzMTY0
NjBfcmVtb3ZlLA0KPiA+ICt9Ow0KPiA+ICttb2R1bGVfc3BpX2RyaXZlcihhZGlzMTY0NjBfZHJp
dmVyKTsNCj4gPiArDQo+ID4gK01PRFVMRV9BVVRIT1IoIkRyYWdvcyBCb2dkYW4gPGRyYWdvcy5i
b2dkYW5AYW5hbG9nLmNvbT4iKTsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJBbmFsb2cgRGV2
aWNlcyBBRElTMTY0NjAgSU1VIGRyaXZlciIpOw0KPiA+ICtNT0RVTEVfTElDRU5TRSgiR1BMIik7
DQo=
