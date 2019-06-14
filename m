Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B645A87
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFNKib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 06:38:31 -0400
Received: from mail-eopbgr740059.outbound.protection.outlook.com ([40.107.74.59]:41575
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbfFNKib (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 06:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rJDa0oEafTtgH7cvmFU2pGDgnls3Hj4FGJVMQKDWp8=;
 b=k7AQyFIRB+mVu5432+r50d+5m16fAzsIqd/97rqs1SC9BbJTtNSsy9G6+Lr68TV4padH/se5XlzXtvo/WRxGJvnKInTQj6Md5demAUgOUQ5kp9GrH38Osl/Vhc60Dftc8W3mruzKUQn7rX/r9GBX5VtZ7yMb/07aqSB4Bw56lDA=
Received: from BN6PR03CA0113.namprd03.prod.outlook.com (2603:10b6:404:10::27)
 by CO2PR03MB2261.namprd03.prod.outlook.com (2603:10b6:102:13::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13; Fri, 14 Jun
 2019 10:36:48 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN6PR03CA0113.outlook.office365.com
 (2603:10b6:404:10::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13 via Frontend
 Transport; Fri, 14 Jun 2019 10:36:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Fri, 14 Jun 2019 10:36:47 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5EAakV0028964
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 14 Jun 2019 03:36:46 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 14 Jun 2019 06:36:46 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH][V2] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Thread-Topic: [PATCH][V2] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Thread-Index: AQHVFial8IK4cndOI0C/s5asahgY7aaSHmUAgAOc+QCABZWBAA==
Date:   Fri, 14 Jun 2019 10:36:45 +0000
Message-ID: <b8535b3bfcf69c225013c820947a85b044ed1e10.camel@analog.com>
References: <20190529130121.30532-1-alexandru.ardelean@analog.com>
         <20190529135848.11964-1-alexandru.ardelean@analog.com>
         <20190608150944.5764158f@archlinux>
         <8501c7c92ca04a46a327681ad1384cc0@SFHDAG2NODE1.st.com>
In-Reply-To: <8501c7c92ca04a46a327681ad1384cc0@SFHDAG2NODE1.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E595091993EF548B9D1B38BA658C45F@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(54534003)(13464003)(199004)(189003)(76176011)(5024004)(7696005)(118296001)(14444005)(2486003)(23676004)(246002)(50466002)(486006)(47776003)(478600001)(70206006)(6116002)(3846002)(5660300002)(102836004)(229853002)(4326008)(53546011)(2501003)(6246003)(14454004)(54906003)(110136005)(106002)(11346002)(356004)(26005)(436003)(446003)(126002)(305945005)(8676002)(8936002)(7736002)(7636002)(186003)(426003)(336012)(476003)(86362001)(70586007)(2616005)(36756003)(316002)(2906002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2261;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3eab91-60af-4318-39b7-08d6f0b433c8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CO2PR03MB2261;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2261:
X-Microsoft-Antispam-PRVS: <CO2PR03MB22610E7C37D26D0F57559D4AF9EE0@CO2PR03MB2261.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0068C7E410
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +9iWTisSYNqPgCEqgeAAZMpsdTUyL614strqeekDboHNIqjn4zJEBsA1W2ncicYNZSDRKIA7j2DKTwooyxU9LISXcjY+Ja6+8c0MTLxVTDkgl9p/u9t/dvpWmPd/RWpMkArJSaRN8DIDPlfyIz5p99gl9D3GpQ3zW+Kyq/te1BddBad+KXJvZuSxuON8qhIZwAMQKPOfIpPKFP/zIGTotxt6tas/YHFajymfjEvm1SL6HNw4XeHWWx3mvGfZEj1/fd9/FsjzHTdDCVAc9iC+lNXQxhrpZ0ymIv3zZ0H65467jo89rAbxEpG6pIkzLfMtT31VBENrMrY2QEV1jCHaDJ20k79ZLpc72Qriocur7JqO14p4rMkdkCGlx5cispKlrnXD3GZttKHE8Ki+P9EPVuzdvz9urEl/nWa/69GfFoU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2019 10:36:47.2072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3eab91-60af-4318-39b7-08d6f0b433c8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2261
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTEwIGF0IDIxOjIwICswMDAwLCBEZW5pcyBDSU9DQ0Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBIaSBKb25hdGhhbiwgQWxleGFuZHJ1LA0KPiANCj4gSSBh
Z3JlZSB3aXRoIHlvdSBhYm91dCB0aGUgcHJlZGlzYWJsZSBidXQgSSBhbSBub3QgY29udmluY2Vk
IHJlZ2FyZGluZyB0aGUgcG9zdGVuYWJsZS4NCj4gRmV3IG1vZGlmaWNhdGlvbnMgaGF2ZSBiZWVu
IG1hZGUgb24gbWFnbiBkcml2ZXIgYW5kIG5ldmVyIHJlcGxpY2F0ZWQgb24gYWNjZWwuIEkgdGhp
bmsgc2hvdWxkIGJlIGRvbmUgaW4gdGhlIHNhbWUgd2F5DQo+IG1hZ24gaXMgaW1wbGVtZW50ZWQu
DQo+IER1cmluZyBwb3N0ZW5hYmxlIGttYWxsb2Mgc2hvdWxkIGJlIGNhbGxlZCBmaXJzdCBiZWNh
dXNlIGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUgZnVuY3Rpb24gaXQgZW5hYmxlcyBp
cnEgYW5kDQo+IGlmIGFuIGludGVycnVwdCBhcnJpdmVzIGJlZm9yZSB0aGUgbWVtb3J5IGlzIGFs
bG9jYXRlZCAod3JvbmcgaW50ZXJydXB0IG9yIGZhaWx1cmUgb2Ygc3dpdGNoaW5nIHNlbnNvciBv
ZmYgZnJvbQ0KPiBwcmV2aW91cyBkaXNhYmxlKSBpdCBjb3VsZCBnZW5lcmF0ZSBhIG51bGwgcG9p
bnRlciBleGNlcHRpb24uIE1ha2Ugc2Vuc2UgdG8geW91Pw0KDQpJIGdvdCB0aGUgZ2lzdCBvZiBp
dC4NCkFuZCBpdCBtYWtlcyBzZW5zZS4NCkknbGwgdXBkYXRlIHRoZSBwYXRjaC4NCg0KW29uIGEg
cmVsYXRlZCB0b3BpY10NCk9uZSBjdXJpb3VzL3F1ZXN0aW9uOiB3b3VsZCBpdCBtYWtlIHNlbnNl
IHRvIG1vdmUgdGhlIGFsbG9jYXRpb24gb2YgYGJ1ZmZlcl9kYXRhYCBzb21ld2hlcmUgaW4NCmBk
cml2ZXJzL2lpby9jb21tb24vc3Rfc2Vuc29yL3N0X3NlbnNvcnNfYnVmZmVyLmNgID8NCkkgd2Fz
IGxvb2tpbmcgZm9yIGBidWZmZXJfZGF0YWAgW2FuZCBob3cgaXQncyB1c2VkXSwgYW5kIG5vdGlj
ZSB0aGlzLg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gVGhhbmtzICYgQnIsDQo+IERlbmlzDQo+
IA0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvbmF0aGFu
IENhbWVyb24gPGppYzIzQGppYzIzLnJldHJvc251Yi5jby51az4NCj4gU2VudDogU2F0dXJkYXks
IEp1bmUgOCwgMjAxOSA3OjEwIEFNDQo+IFRvOiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRy
dS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsg
RGVuaXMgQ0lPQ0NBIDxkZW5pcy5jaW9jY2FAc3QuY29tPjsgTG9yZW56byBCaWFuY29uaSA8bG9y
ZW56by5iaWFuY29uaTgzQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF1bVjJdIGlp
bzogc3RfYWNjZWw6IGZpeCBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl97cHJlLHBvc3R9ZW5hYmxlIHBv
c2l0aW9ucw0KPiANCj4gT24gV2VkLCAyOSBNYXkgMjAxOSAxNjo1ODo0OCArMDMwMA0KPiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4g
DQo+ID4gVGhlIGlpb190cmlnZ2VyZWRfYnVmZmVyX3twcmVkaXNhYmxlLHBvc3RlbmFibGV9IGZ1
bmN0aW9ucw0KPiA+IGF0dGFjaC9kZXRhY2ggdGhlIHBvbGwgZnVuY3Rpb25zLg0KPiA+IA0KPiA+
IEZvciB0aGUgcHJlZGlzYWJsZSBob29rLCB0aGUgZGlzYWJsZSBjb2RlIHNob3VsZCBvY2N1ciBi
ZWZvcmUNCj4gPiBkZXRhY2hpbmcgdGhlIHBvbGwgZnVuYywgYW5kIGZvciB0aGUgcG9zdGVuYWJs
ZSBob29rLCB0aGUgcG9sbCBmdW5jDQo+ID4gc2hvdWxkIGJlIGF0dGFjaGVkIGJlZm9yZSB0aGUg
ZW5hYmxlIGNvZGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFu
IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gSSB0aGluayB0aGlzIGlzIGZpbmUs
IGJ1dCBJJ2QgbGlrZSBhbiBhY2sgZnJvbSBMb3JlbnpvIC8gRGVuaXMuDQo+IA0KPiBOb3RlIHRv
IHRob3NlIHdobyBoYXZlIG1pc3NlZCB0aGUgYmFja2dyb3VuZCBvbiB0aGlzLCB0aGUgYWltIGlz
IHRvIGJvdGggdGlkeSB1cCBkcml2ZXJzLCBidXQgbG9uZyB0ZXJtIHRvIGFsbG93IGZvcg0KPiBz
aW1wbGVyIHJld29ya2luZyBvZiB0aGUgY29yZSBieSBlbnN1cmluZyBjb25zaXN0ZW5jeSBvZiBv
cmRlcmluZyBhbmQgd2hhdCBpcyBkb25lIGluIGVhY2ggb2YgdGhlc2UgaG9va3MuDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2Vsb2cgdjEgLT4g
djI6DQo+ID4gKiByZWNvcmQgdGhlIGZpcnN0IGVycm9yIGluIHN0X2FjY2VsX2J1ZmZlcl9wcmVk
aXNhYmxlKCkgYW5kIHJldHVybg0KPiA+IHRoYXQNCj4gPiANCj4gPiAgZHJpdmVycy9paW8vYWNj
ZWwvc3RfYWNjZWxfYnVmZmVyLmMgfCAyMSArKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FjY2VsL3N0X2FjY2VsX2J1ZmZlci5jDQo+ID4gYi9k
cml2ZXJzL2lpby9hY2NlbC9zdF9hY2NlbF9idWZmZXIuYw0KPiA+IGluZGV4IDdmZGRjMTM3ZTkx
ZS4uNzExZWNkOWJjODk4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FjY2VsL3N0X2Fj
Y2VsX2J1ZmZlci5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWNjZWwvc3RfYWNjZWxfYnVmZmVy
LmMNCj4gPiBAQCAtNDAsNiArNDAsMTAgQEAgc3RhdGljIGludCBzdF9hY2NlbF9idWZmZXJfcG9z
dGVuYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICAgICAgIGludCBlcnI7DQo+
ID4gICAgICAgc3RydWN0IHN0X3NlbnNvcl9kYXRhICphZGF0YSA9IGlpb19wcml2KGluZGlvX2Rl
dik7DQo+ID4gDQo+ID4gKyAgICAgZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJs
ZShpbmRpb19kZXYpOw0KPiA+ICsgICAgIGlmIChlcnIgPCAwKQ0KPiA+ICsgICAgICAgICAgICAg
cmV0dXJuIGVycjsNCj4gPiArDQo+ID4gICAgICAgYWRhdGEtPmJ1ZmZlcl9kYXRhID0ga21hbGxv
YyhpbmRpb19kZXYtPnNjYW5fYnl0ZXMsIEdGUF9LRVJORUwpOw0KPiA+ICAgICAgIGlmIChhZGF0
YS0+YnVmZmVyX2RhdGEgPT0gTlVMTCkgew0KPiA+ICAgICAgICAgICAgICAgZXJyID0gLUVOT01F
TTsNCj4gPiBAQCAtNTEsMzQgKzU1LDMzIEBAIHN0YXRpYyBpbnQgc3RfYWNjZWxfYnVmZmVyX3Bv
c3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiAgICAgICBpZiAoZXJyIDwg
MCkNCj4gPiAgICAgICAgICAgICAgIGdvdG8gc3RfYWNjZWxfYnVmZmVyX3Bvc3RlbmFibGVfZXJy
b3I7DQo+ID4gDQo+ID4gLSAgICAgZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJs
ZShpbmRpb19kZXYpOw0KPiA+IC0gICAgIGlmIChlcnIgPCAwKQ0KPiA+IC0gICAgICAgICAgICAg
Z290byBzdF9hY2NlbF9idWZmZXJfcG9zdGVuYWJsZV9lcnJvcjsNCj4gPiAtDQo+ID4gICAgICAg
cmV0dXJuIGVycjsNCj4gPiANCj4gPiAgc3RfYWNjZWxfYnVmZmVyX3Bvc3RlbmFibGVfZXJyb3I6
DQo+ID4gICAgICAga2ZyZWUoYWRhdGEtPmJ1ZmZlcl9kYXRhKTsNCj4gPiAgYWxsb2NhdGVfbWVt
b3J5X2Vycm9yOg0KPiA+ICsgICAgIGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoaW5k
aW9fZGV2KTsNCj4gPiAgICAgICByZXR1cm4gZXJyOw0KPiA+ICB9DQo+ID4gDQo+ID4gIHN0YXRp
YyBpbnQgc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
dikgIHsNCj4gPiAtICAgICBpbnQgZXJyOw0KPiA+ICsgICAgIGludCBlcnIsIGVycjI7DQo+ID4g
ICAgICAgc3RydWN0IHN0X3NlbnNvcl9kYXRhICphZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7
DQo+ID4gDQo+ID4gLSAgICAgZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShp
bmRpb19kZXYpOw0KPiA+IC0gICAgIGlmIChlcnIgPCAwKQ0KPiA+IC0gICAgICAgICAgICAgZ290
byBzdF9hY2NlbF9idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjsNCj4gPiAtDQo+ID4gICAgICAgZXJy
ID0gc3Rfc2Vuc29yc19zZXRfYXhpc19lbmFibGUoaW5kaW9fZGV2LCBTVF9TRU5TT1JTX0VOQUJM
RV9BTExfQVhJUyk7DQo+ID4gICAgICAgaWYgKGVyciA8IDApDQo+ID4gICAgICAgICAgICAgICBn
b3RvIHN0X2FjY2VsX2J1ZmZlcl9wcmVkaXNhYmxlX2Vycm9yOw0KPiA+IA0KPiA+ICAgICAgIGVy
ciA9IHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIGZhbHNlKTsNCj4gPiArICAgICBp
ZiAoZXJyIDwgMCkNCj4gPiArICAgICAgICAgICAgIGdvdG8gc3RfYWNjZWxfYnVmZmVyX3ByZWRp
c2FibGVfZXJyb3I7DQo+ID4gDQo+ID4gIHN0X2FjY2VsX2J1ZmZlcl9wcmVkaXNhYmxlX2Vycm9y
Og0KPiA+ICsgICAgIGVycjIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlv
X2Rldik7DQo+ID4gKyAgICAgaWYgKCFlcnIpDQo+ID4gKyAgICAgICAgICAgICBlcnIgPSBlcnIy
Ow0KPiA+ICsNCj4gPiAgICAgICBrZnJlZShhZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiA+ICAgICAg
IHJldHVybiBlcnI7DQo+ID4gIH0NCg==
