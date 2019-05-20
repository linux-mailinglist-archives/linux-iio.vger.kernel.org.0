Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745A423133
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfETKVD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 06:21:03 -0400
Received: from mail-eopbgr800059.outbound.protection.outlook.com ([40.107.80.59]:57216
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730632AbfETKVD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 May 2019 06:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ewCb7tjHvyKPBhGcPVdPSlFA2nKWsc52cMf1qoEf4w=;
 b=Pqj835R/LdV8YojAQbi/71mjHeqDPeCm/qiAdXplk6Lx5xSzS2p54gh56w4nzD0btruDudW1NeaQDceAOlcx1iPlHHRPyCAuqz6+XPg1YHbAb8MuoZnqsI4zxJjX79Sus/VDzEk2BAbwLd/FcEin15yuffJZUA1C6uE7jiHX/YU=
Received: from BN6PR03CA0111.namprd03.prod.outlook.com (10.168.221.25) by
 BL2PR03MB547.namprd03.prod.outlook.com (10.141.90.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 20 May 2019 10:21:00 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR03CA0111.outlook.office365.com
 (2603:10b6:404:10::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Mon, 20 May 2019 10:21:00 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; spoonm.org; dkim=none (message not signed)
 header.d=none;spoonm.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Mon, 20 May 2019 10:20:59 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4KAKxxI010260
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 20 May 2019 03:20:59 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Mon, 20 May 2019 06:20:59 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "barbara.fernandes@usp.br" <barbara.fernandes@usp.br>
CC:     "melissa.srw@gmail.com" <melissa.srw@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "spoonm@spoonm.org" <spoonm@spoonm.org>
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7150: create of_device_id array
Thread-Topic: [PATCH 1/2] staging: iio: cdc: ad7150: create of_device_id
 array
Thread-Index: AQHVDuma4B9dP2XucUqNJctRBbL656Z0EKkA
Date:   Mon, 20 May 2019 10:20:58 +0000
Message-ID: <28948637968846e814ac507a34c1886668d87ed7.camel@analog.com>
References: <20190518213511.23253-1-barbara.fernandes@usp.br>
         <20190518213511.23253-2-barbara.fernandes@usp.br>
         <CA+U=DsoaujpbnMGb8TB=hQoV1rnEpKwmwxcyNKVnw2Z=oCHq4Q@mail.gmail.com>
In-Reply-To: <CA+U=DsoaujpbnMGb8TB=hQoV1rnEpKwmwxcyNKVnw2Z=oCHq4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AABF5204D76D4646AA8F02D6533E82A4@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(189003)(199004)(2906002)(102836004)(14444005)(36756003)(2486003)(23676004)(53546011)(478600001)(14454004)(4326008)(106002)(118296001)(26005)(7696005)(5660300002)(126002)(6116002)(446003)(2616005)(486006)(3846002)(11346002)(305945005)(7636002)(7736002)(476003)(316002)(186003)(2501003)(336012)(76176011)(436003)(426003)(8936002)(54906003)(110136005)(6246003)(66574012)(8676002)(246002)(70586007)(47776003)(356004)(229853002)(70206006)(50466002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB547;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb8a6bac-c31d-4fea-e9a2-08d6dd0cdad2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BL2PR03MB547;
X-MS-TrafficTypeDiagnostic: BL2PR03MB547:
X-Microsoft-Antispam-PRVS: <BL2PR03MB547908A35CE817F8435D3F5F9060@BL2PR03MB547.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 004395A01C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MH+yiD8hV9cUhrSr3jzpoSJcyH1e+RN2ovOL7loCTT9kJDRwrzeMP6VpVLbUiZy5CfHmWeQkqqgbVgF19Y4ZbJ0mg5LNZwWKnRRC4A/ur7OnZnXBBWKs23wKKU8n5rDCRBdtJUH7ofqmHss1QbT4MieN8onhIN57ZPB1eJ7XECVoHia2DHp3Dr8kQtz4MmldqKFsNBQ4IdaJx9DnEomFpNSNmwo33C8+akJXw9fVfIvKdnuIOt9vIkVBaMg202hZm92CjmW+ttZBHtJourPN0nOdzsKtg/2e4jNcCgThWiuoH1UegDqWEPtK3fcaGVZxq+ZNr8I5f5AI4mLH8edwTDL1vgNDdS5wVCfv8LiHGMPeZKEl6+Y00GGTqhdzxZDyzlA+Gc/VepGQk+5fSq7eUBmQeoRFv7hi3MyWmV6bH7Q=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2019 10:20:59.9114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a6bac-c31d-4fea-e9a2-08d6dd0cdad2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB547
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTIwIGF0IDExOjUzICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBTdW4sIE1heSAxOSwgMjAxOSBhdCAxMjoz
NSBBTSBCw6FyYmFyYSBGZXJuYW5kZXMNCj4gPGJhcmJhcmEuZmVybmFuZGVzQHVzcC5icj4gd3Jv
dGU6DQo+ID4gDQo+ID4gQ3JlYXRlIHN0cnVjdHVyZSBvZiB0eXBlIG9mX2RldmljZV9pZCBpbiBv
cmRlciB0byByZWdpc3RlciBhbGwgZGV2aWNlcw0KPiA+IHRoZSBkcml2ZXIgaXMgYWJsZSB0byBt
YW5hZ2UuDQo+ID4gDQo+IA0KPiBIZXksDQo+IA0KPiBDQy1pbmcgbXkgd29yay1lbWFpbA0KPiBU
aGVyZSBhcmUgc29tZSBpc3N1ZXMgd2l0aCBpdCBhbmQgbWFpbGluZyBsaXN0czsgSSdsbCBob3Bl
ZnVsbHkgc29ydA0KPiB0aGVtIG91dCBpbiB0aGUgbmV4dCB3ZWVrcy4NCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogQsOhcmJhcmEgRmVybmFuZGVzIDxiYXJiYXJhLmZlcm5hbmRlc0B1c3AuYnI+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTWVsaXNzYSBXZW4gPG1lbGlzc2Euc3J3QGdtYWlsLmNvbT4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IE1lbGlzc2EgV2VuIDxtZWxpc3NhLnNyd0BnbWFpbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogV2lsc29uIFNhbGVzIDxzcG9vbm1Ac3Bvb25tLm9yZz4NCj4gPiBD
by1kZXZlbG9wZWQtYnk6IFdpbHNvbiBTYWxlcyA8c3Bvb25tQHNwb29ubS5vcmc+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvc3RhZ2luZy9paW8vY2RjL2FkNzE1MC5jIHwgMTAgKysrKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2NkYy9hZDcxNTAuYw0KPiA+IGIvZHJpdmVycy9zdGFn
aW5nL2lpby9jZGMvYWQ3MTUwLmMNCj4gPiBpbmRleCA0YjFjOTBlMWIwZWEuLjA3MjA5NDIyN2Ux
YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2NkYy9hZDcxNTAuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vY2RjL2FkNzE1MC5jDQo+ID4gQEAgLTY1NSwxMSAr
NjU1LDIxIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBhZDcxNTBfaWRbXSA9
IHsNCj4gPiAgICAgICAgIHt9DQo+ID4gIH07DQo+ID4gDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIGFkNzE1MF9vZl9pMmNfbWF0Y2hbXSA9IHsNCj4gPiArICAgICAgIHsg
LmNvbXBhdGlibGUgPSAiYWRpLGFkNzE1MCIgfSwNCj4gPiArICAgICAgIHsgLmNvbXBhdGlibGUg
PSAiYWRpLGFkNzE1MSIgfSwNCj4gPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzE1
NiIgfSwNCj4gPiArICAgICAgIHt9DQo+ID4gK307DQo+ID4gKw0KPiA+ICtNT0RVTEVfREVWSUNF
X1RBQkxFKG9mLCBhZDcxNTBfb2ZfaTJjX21hdGNoKTsNCj4gDQo+IG5pdHBpY2s6IHlvdSBkb24n
dCBuZWVkIHRvIGFkZCBpMmMgaW4gdGhlIG5hbWUNCj4gc28sIHRoaXMgY291bGQgYmUganVzdA0K
PiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhZDcxNTBfb2ZfbWF0Y2gpOw0KPiANCj4gYnV0IGl0
J3Mgbm90IGEgYmxvY2tlciBmb3IgdGhpczsNCg0KQWN0dWFsbHksIGRpc3JlZ2FyZCB0aGUgYWJv
dmUgY29tbWVudC4NCkkganVzdCB0aG91Z2h0IG9mIHNvbWUgY2FzZXMgd2hlcmUgaXQgbWFrZXMg
c2Vuc2UgdG8gaGF2ZSB0aGUgaTJjIGluIHRoZQ0KbmFtZS4gU28sIGFkNzE1MF9vZl9pMmNfbWF0
Y2ggaXMgZmluZS4NCg0KDQo+IA0KPiBTbywNCj4gDQo+IEFja2VkLWJ5OiBBbGV4YW5kcnUgQXJk
ZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiANCj4gPiArDQo+ID4gIE1P
RFVMRV9ERVZJQ0VfVEFCTEUoaTJjLCBhZDcxNTBfaWQpOw0KPiA+IA0KPiA+ICBzdGF0aWMgc3Ry
dWN0IGkyY19kcml2ZXIgYWQ3MTUwX2RyaXZlciA9IHsNCj4gPiAgICAgICAgIC5kcml2ZXIgPSB7
DQo+ID4gICAgICAgICAgICAgICAgIC5uYW1lID0gImFkNzE1MCIsDQo+ID4gKyAgICAgICAgICAg
ICAgIC5vZl9tYXRjaF90YWJsZSA9IGFkNzE1MF9vZl9pMmNfbWF0Y2gNCj4gPiAgICAgICAgIH0s
DQo+ID4gICAgICAgICAucHJvYmUgPSBhZDcxNTBfcHJvYmUsDQo+ID4gICAgICAgICAuaWRfdGFi
bGUgPSBhZDcxNTBfaWQsDQo+ID4gLS0NCj4gPiAyLjIyLjAucmMwLjEuZzMzN2JiOTkxOTUuZGly
dHkNCj4gPiANCg==
