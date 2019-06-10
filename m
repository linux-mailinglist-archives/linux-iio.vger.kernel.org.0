Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE053B0BC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 10:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfFJI3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 04:29:50 -0400
Received: from mail-eopbgr810081.outbound.protection.outlook.com ([40.107.81.81]:3520
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387702AbfFJI3u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Jun 2019 04:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iexDgiBQtgV0out2FIndIhsdsxOQBkIUqCVkDnLx264=;
 b=QhAWqPJtykZ7S4acH2cnvljF7aG2cU2Bfi6deWtUG94gzOvDfDlNDkWpw7Bkz74vshdAtYoULpIODKanJPrLOh/kAjlM37XLbDx2Xcd96E9lJ9C5GH1i8em3d4Dt07oaioXUd3g2mBoTkQyAnXkwTuPrGTCKB3Rra8rtCd7VzLs=
Received: from BN3PR03CA0103.namprd03.prod.outlook.com (2603:10b6:400:4::21)
 by CO2PR03MB2262.namprd03.prod.outlook.com (2603:10b6:102:e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Mon, 10 Jun
 2019 08:29:47 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN3PR03CA0103.outlook.office365.com
 (2603:10b6:400:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.14 via Frontend
 Transport; Mon, 10 Jun 2019 08:29:46 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Mon, 10 Jun 2019 08:29:46 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5A8TjsM003420
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Jun 2019 01:29:45 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 10 Jun 2019 04:29:45 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: allocate data dynamically for
 samples
Thread-Topic: [PATCH] iio: ad_sigma_delta: allocate data dynamically for
 samples
Thread-Index: AQHVFr2TjwrHzrOhlEGdsm3BGj8fc6aSIF0AgALChIA=
Date:   Mon, 10 Jun 2019 08:29:44 +0000
Message-ID: <7f0d79ad3676ad01e595c40335d0c1cb1d38d537.camel@analog.com>
References: <20190530075911.6032-1-alexandru.ardelean@analog.com>
         <20190608152100.72f004d7@archlinux>
In-Reply-To: <20190608152100.72f004d7@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0057870A6DC95C4793973B4756D86CE1@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(189003)(199004)(6116002)(3846002)(426003)(6916009)(106002)(126002)(476003)(2616005)(11346002)(446003)(486006)(436003)(336012)(2906002)(70586007)(70206006)(186003)(86362001)(246002)(7636002)(305945005)(118296001)(2351001)(7736002)(47776003)(8676002)(8936002)(36756003)(102836004)(6246003)(7696005)(76176011)(50466002)(5640700003)(5660300002)(14454004)(14444005)(316002)(26005)(229853002)(2501003)(356004)(478600001)(2486003)(23676004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2262;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f7b8693-3878-4e78-311d-08d6ed7dcbdb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CO2PR03MB2262;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2262:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2262D39B488C8CAE3BD03724F9130@CO2PR03MB2262.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0064B3273C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TThi/MPTIgosTM3tngz9YKwB/T3ZvFJawtvuerwnZUZXhDrEYNledgtpGOGW2VC2W3XkQaJAsTkpcCmJ52jKHPqQMJzX6Tuf3dpVA79gemBrXQT4RGsToGm+7luXJIpsU9TMxCXCi2Db8lUwDADG2+zdc3e3Dc0+PRACygZJDQ4SXA5y/2cv1K/fSKRQ4GAS5yIGTBSgblcqT0b8BiTmgOfo//mmdl14T7AEF+4jpiPlWw0qdijKbnDkr8w9BDvnhl7Jq7HdZGvcZJ2+15Xe7yj7X+JuVFPa36c/4usCL/vfmnB7eafqWyP+kaa+wCCp2+ZgG8q6pRRJDGACYoyTy1Et1rSz7TiAKOJSjbJietj61m9VKyNJIX/RVj24L4g9YrNWdIGroqw9yMGMtD5hg7LKK9wg79MeVsg9cJPcgCA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2019 08:29:46.4116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7b8693-3878-4e78-311d-08d6ed7dcbdb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2262
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA2LTA4IGF0IDE1OjIxICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gVGh1LCAzMCBNYXkgMjAxOSAxMDo1OToxMSAr
MDMwMA0KPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4gDQo+ID4gVGhpcyBjaGFuZ2UgaGFzIGEgZmV3IHBhcnRzOg0KPiA+IDEuIFJl
bW92ZSB0aGUgYnVmZmVyIGZyb20gdGhlIHRyaWdnZXIgaGFuZGxlcidzIHN0YWNrDQo+ID4gMi4g
SGF2aW5nIGl0IGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBtZWFucyBpdCBzaG91bGQgYmUgY2FjaGUt
YWxpZ25lZA0KPiA+IDMuIFRoZSBidWZmZXIgd291bGQgbm93IGFkYXB0IHRvIHRoZSBhY3R1YWwg
bnVtYmVyIG9mIGJ5dGVzIG5lZWRlZCwNCj4gPiAgICB3aGV0aGVyIGl0J3MgbW9yZSB0aGFuIDE2
IGJ5dGVzLCBvciBsZXNzDQo+ID4gNC4gSGF2aW5nIGl0IGluIHRoZSBoZWFwIHNvbWV3aGVyZSwg
YWxsb3dzIGl0IHRvIHdvcmsgd2l0aCBETUENCj4gPiANCj4gPiBUaGlzIGlzIGEgZml4ICsgZW5o
YW5jZW1lbnQgaW4gb25lLg0KPiA+IA0KPiA+IEZpeGVzOiBhZjMwMDg0ODVlYTAzICgiaWlvOiBh
ZF9zaWdtYV9kZWx0YTogYWxsb2NhdGUgZGF0YSBkeW5hbWljYWxseSBmb3Igc2FtcGxlcyIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5A
YW5hbG9nLmNvbT4NCj4gDQo+IENvbW1lbnQgaW5saW5lLiAgVGhpcyBpcyB1c2luZyBhbiBlbGVt
ZW50IG9mIGlpb19kZXYgdGhhdCBpcyBtYXJrZWQNCj4gSU5URVJOIGluIHRoZSBoZWFkZXIuLi4N
Cj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jICAgICAg
IHwgMTIgKysrKysrKysrKy0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL2FkYy9hZF9zaWdtYV9k
ZWx0YS5oIHwgIDIgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYWRf
c2lnbWFfZGVsdGEuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+ID4gaW5k
ZXggZWMwZTM4NTY2ZWNlLi45MWQ1ZGRhNTNkMjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9p
aW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWRfc2ln
bWFfZGVsdGEuYw0KPiA+IEBAIC0zNjAsNiArMzYwLDExIEBAIHN0YXRpYyBpbnQgYWRfc2RfYnVm
ZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiAgICAgICBpZiAo
cmV0KQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiANCj4gPiArICAgICBrZnJl
ZShzaWdtYV9kZWx0YS0+YnVmX2RhdGEpOw0KPiA+ICsgICAgIHNpZ21hX2RlbHRhLT5idWZfZGF0
YSA9IGt6YWxsb2MoaW5kaW9fZGV2LT5zY2FuX2J5dGVzLCBHRlBfS0VSTkVMKTsNCj4gSG1tLiBB
bm90aGVyIHRoaW5nIHRoYXQgSSdtIHRyeWluZyB0byBzdG9wIGRyaXZlcnMgZG9pbmcgaXMgYWNj
ZXNzaW5nIGVsZW1lbnRzDQo+IG9mIHRoZSBzdHJ1Y3QgaWlvX2RldiB0aGF0IGhhdmUgYmVlbiBt
YXJrZWQgaW4gdGhlIGhlYWRlciBhcyBJTlRFUk4uDQo+IA0KPiBUaGF0IHJlYWxseSByZXN0cmlj
dHMgdGhlIGFiaWxpdHkgdG8gcmVmYWN0b3IgdGhhdCBjb2RlLg0KPiANCj4gVGhlIGFyZ3VtZW50
IGhhcyBhbHdheXMgYmVlbiB0aGF0IGEgZHJpdmVyIG91Z2h0IHRvIGJlIGFibGUgdG8gJ3RlbGwn
IGhvdw0KPiBsYXJnZSBhIGJ1ZmZlciBpdCBjYW4gY29uY2VpdmFibHkgbmVlZCBhbmQgb2Z0ZW4g
aXQgd2lsbCBhY3R1YWxseSB1c2UNCj4gYSAnc3VwZXJzZXQnIG9mIHRoYXQgdG8gYXZvaWQgdGhl
IG5lZWQgdG8gZG8gYWRkaXRpb25hbCBhbGxvY2F0aW9ucy4NCj4gDQo+IEl0J3MgYSBpdCB0cmlj
a2llciB3aGVuIHRoZXJlIGlzIGEgZ2VuZXJpYyBsYXllciBpbmJldHdlZW4gdGhlIGRyaXZlciBh
bmQNCj4gdGhlIGNvcmUgbGlrZSB3ZSBoYXZlIGhlcmUuDQo+IA0KPiBJZiB0aGUgYmVsb3cgMTYg
aXMgY29ycmVjdCwgeW91IGFyZSBhbG1vc3QgY2VydGFpbiB0byBub3QgYWN0dWFsbHkgc2VlIGFu
eQ0KPiBhZHZhbnRhZ2UgaW4gYSBzZXBhcmF0ZSBhbGxvY2F0aW9uLiAgU28gdHdvIG9wdGlvbnMg
Y29tZSB0byBtaW5kLg0KPiANCj4gMSkgRW5zdXJlIGFkX3NpZ21hX2RlbHRhIGlzIGFwcHJvcHJp
YXRlbHkgYWxpZ25lZCBpbiB0aGUgcHJpdiBkYXRhDQo+IG9mIGVhY2ggZHJpdmVyLCB0aGVuIHVz
ZSBfX19jYWNoZWxpbmVfYWxpZ25lZCBvbiBhIGZpeGVkIDE2IGJ5dGUgYnVmZmVyDQo+IGluIGFk
X3NpZ21hX2RlbHRhLg0KPiAyKSBEbyB0aGUgc2VwYXJhdGUgYWxsb2NhdGlvbiwgYnV0IHN0aWNr
IHRvIDE2IGJ5dGVzICh5b3Ugd2lsbCBhbHdheXMNCj4gZ2V0IG1vcmUgdGhhbiB0aGF0IGFueXdh
eSBhcyBhbHdheXMgYXQgbGVhc3QgYSBjYWNoZWxpbmUgLSBvdGhlcndpc2UNCj4gc2FtZSBETUEg
aXNzdWUgbWlnaHQgb2NjdXIpLg0KDQpIbW1tLg0KSSB0aGluayBJIGdvdCB0aGUgZ2lzdCBvZiBp
dC4NCg0KSSdsbCB0YWtlIGEgbG9vayBhbmQgY29tZSBiYWNrLg0KDQpUaGFua3MNCkFsZXgNCg0K
PiANCj4gPiArICAgICBpZiAoIXNpZ21hX2RlbHRhLT5idWZfZGF0YSkNCj4gPiArICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiAgICAgICBzcGlfYnVzX2xvY2soc2lnbWFf
ZGVsdGEtPnNwaS0+bWFzdGVyKTsNCj4gPiAgICAgICBzaWdtYV9kZWx0YS0+YnVzX2xvY2tlZCA9
IHRydWU7DQo+ID4gICAgICAgc2lnbWFfZGVsdGEtPmtlZXBfY3NfYXNzZXJ0ZWQgPSB0cnVlOw0K
PiA+IEBAIC00MDMsMTIgKzQwOCwxMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYWRfc2RfdHJpZ2dl
cl9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnApDQo+ID4gICAgICAgc3RydWN0IGlpb19wb2xsX2Z1
bmMgKnBmID0gcDsNCj4gPiAgICAgICBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gcGYtPmlu
ZGlvX2RldjsNCj4gPiAgICAgICBzdHJ1Y3QgYWRfc2lnbWFfZGVsdGEgKnNpZ21hX2RlbHRhID0g
aWlvX2RldmljZV9nZXRfZHJ2ZGF0YShpbmRpb19kZXYpOw0KPiA+ICsgICAgIHVpbnQ4X3QgKmRh
dGEgPSBzaWdtYV9kZWx0YS0+YnVmX2RhdGE7DQo+ID4gICAgICAgdW5zaWduZWQgaW50IHJlZ19z
aXplOw0KPiA+ICAgICAgIHVuc2lnbmVkIGludCBkYXRhX3JlZzsNCj4gPiAtICAgICB1aW50OF90
IGRhdGFbMTZdOw0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4gDQo+ID4gLSAgICAgbWVtc2V0KGRh
dGEsIDB4MDAsIDE2KTsNCj4gPiArICAgICBtZW1zZXQoZGF0YSwgMHgwMCwgaW5kaW9fZGV2LT5z
Y2FuX2J5dGVzKTsNCj4gPiANCj4gPiAgICAgICByZWdfc2l6ZSA9IGluZGlvX2Rldi0+Y2hhbm5l
bHNbMF0uc2Nhbl90eXBlLnJlYWxiaXRzICsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgaW5k
aW9fZGV2LT5jaGFubmVsc1swXS5zY2FuX3R5cGUuc2hpZnQ7DQo+ID4gQEAgLTU2OCw2ICs1NzMs
OSBAQCBFWFBPUlRfU1lNQk9MX0dQTChhZF9zZF9zZXR1cF9idWZmZXJfYW5kX3RyaWdnZXIpOw0K
PiA+ICAgKi8NCj4gPiAgdm9pZCBhZF9zZF9jbGVhbnVwX2J1ZmZlcl9hbmRfdHJpZ2dlcihzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICB7DQo+ID4gKyAgICAgc3RydWN0IGFkX3NpZ21h
X2RlbHRhICpzaWdtYV9kZWx0YSA9IGlpb19kZXZpY2VfZ2V0X2RydmRhdGEoaW5kaW9fZGV2KTsN
Cj4gPiArDQo+ID4gKyAgICAga2ZyZWUoc2lnbWFfZGVsdGEtPmJ1Zl9kYXRhKTsNCj4gPiAgICAg
ICBhZF9zZF9yZW1vdmVfdHJpZ2dlcihpbmRpb19kZXYpOw0KPiA+ICAgICAgIGlpb190cmlnZ2Vy
ZWRfYnVmZmVyX2NsZWFudXAoaW5kaW9fZGV2KTsNCj4gPiAgfQ0KPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaCBiL2luY2x1ZGUvbGludXgvaWlv
L2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+ID4gaW5kZXggNmU5ZmIxOTMyZGRlLi4zNmRjNDliOGRm
ZDUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRh
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaA0KPiA+
IEBAIC03NSw2ICs3NSw4IEBAIHN0cnVjdCBhZF9zaWdtYV9kZWx0YSB7DQo+ID4gDQo+ID4gICAg
ICAgY29uc3Qgc3RydWN0IGFkX3NpZ21hX2RlbHRhX2luZm8gKmluZm87DQo+ID4gDQo+ID4gKyAg
ICAgdWludDhfdCAgICAgICAgICAgICAgICAgKmJ1Zl9kYXRhOw0KPiA+ICsNCj4gPiAgICAgICAv
Kg0KPiA+ICAgICAgICAqIERNQSAodGh1cyBjYWNoZSBjb2hlcmVuY3kgbWFpbnRlbmFuY2UpIHJl
cXVpcmVzIHRoZQ0KPiA+ICAgICAgICAqIHRyYW5zZmVyIGJ1ZmZlcnMgdG8gbGl2ZSBpbiB0aGVp
ciBvd24gY2FjaGUgbGluZXMuDQo=
