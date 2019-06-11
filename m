Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB53C3E7
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 08:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391121AbfFKG2I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 02:28:08 -0400
Received: from mail-eopbgr750084.outbound.protection.outlook.com ([40.107.75.84]:7814
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390485AbfFKG2I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 02:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhFrMwATMHrV4R/vxZxsl69hYFrZHxuvfjdjvOO932M=;
 b=keioaEtddrKxT2g1MF50fJgmr3URjPcNJCuuYWKQFugqoXsCkPOQlDtYwMxR+ROgSEBIzdshnrO29lSgA2z/5sd2/o7gEQIHioqqAuQtEyI3nOk1Gjtr4wcbDpxnK9oh7vxi2j8NLaUFVl/yH6H/WIFcVrTWfBedrKdfoPHVHn8=
Received: from BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16)
 by CY1PR03MB2265.namprd03.prod.outlook.com (2603:10b6:600:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Tue, 11 Jun
 2019 06:28:05 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BYAPR03CA0003.outlook.office365.com
 (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12 via Frontend
 Transport; Tue, 11 Jun 2019 06:28:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Tue, 11 Jun 2019 06:28:04 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5B6S30R002139
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Jun 2019 23:28:03 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 11 Jun 2019 02:28:03 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hancock@sedsystems.ca" <hancock@sedsystems.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: xilinx: support all platforms
Thread-Topic: [PATCH] iio: adc: xilinx: support all platforms
Thread-Index: AQHVH6j1tuMWpYcb8UG29tfpB27xz6aWQV6A
Date:   Tue, 11 Jun 2019 06:28:02 +0000
Message-ID: <2c4116f4923ac710de15c2980e620f9d59f902b6.camel@analog.com>
References: <1560183824-19061-1-git-send-email-hancock@sedsystems.ca>
In-Reply-To: <1560183824-19061-1-git-send-email-hancock@sedsystems.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B334E5662118341AA37A81CDF9C5A5F@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(70206006)(356004)(478600001)(118296001)(50466002)(70586007)(36756003)(86362001)(4326008)(426003)(110136005)(316002)(305945005)(54906003)(3846002)(14444005)(6116002)(446003)(486006)(2486003)(14454004)(26005)(2616005)(476003)(229853002)(126002)(6246003)(102836004)(106002)(11346002)(23676004)(76176011)(7696005)(336012)(2906002)(8936002)(47776003)(5660300002)(2501003)(246002)(8676002)(436003)(186003)(7636002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2265;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd85ab00-bbbc-4ac1-210d-08d6ee35f601
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY1PR03MB2265;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2265:
X-Microsoft-Antispam-PRVS: <CY1PR03MB2265FDE00DDC3499F559BF95F9ED0@CY1PR03MB2265.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7Vgh3+HjI3AJNFiHIGDPVEuYBc9Xg6mMW87G3pVhAySumX1ts4ixKz3sT/PQgshItZGFL7RCy9nJ6Lu3BgA7wOOA6YvRJKKTvz5WPuMQvwF7RRGJFjVZfCHuz2exZJoHYq8tSXyflqnkhp+EMq4h9XGGucA+GFj5mhP4jYnHzufghQwEUg3wCCew2tBVs1+L3VgKxTm7i3cxTP2XeWfE1sbPyEEEpGJYVnJ4TZi2GIfeccxxIezBQsPIM9VLID9VcSIOfaB5wUHOxbDsijuYOlGwH/r7Ae0au5yIVwOqlg1QSbJpo5lFD13X3lsXy9dAJZMX/IRnb4G/gxuMFss+BFsw4rZ9eK4Hw5ytqRniZlIfXwQKNw7/XlV+3CLU+6YwHvgaPx45XCKD1TPtLPT9NPMwHVy+ich4ljC71JT6jB8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 06:28:04.3417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd85ab00-bbbc-4ac1-210d-08d6ee35f601
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2265
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTEwIGF0IDEwOjIzIC0wNjAwLCBSb2JlcnQgSGFuY29jayB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gDQo+IFNpbmNlIHRoZSBYQURDIGxvZ2ljIGNhbiBiZSB1c2Vk
IHdpdGggc3RhbmRhbG9uZSBYaWxpbnggRlBHQXMsIHRoaXMNCj4gZHJpdmVyIGNhbiBwb3RlbnRp
YWxseSBiZSB1c2VkIHdpdGggbWFueSBkaWZmZXJlbnQgcGxhdGZvcm1zLCBub3QganVzdA0KPiB0
aGUgWnlucSBhbmQgTWljcm9CbGF6ZSBwbGF0Zm9ybXMgdGhpcyBkcml2ZXIgd2FzIGFsbG93ZWQg
dG8gYmUgYnVpbHQNCj4gZm9yLiBUaGVyZSBzaG91bGQgYmUgbm8gcGxhdGZvcm0tc3BlY2lmaWMg
Y29kZSBpbiB0aGlzIGRyaXZlciwgc28ganVzdA0KPiBkZWxldGUgdGhlIHBsYXRmb3JtIGRlcGVu
ZGVuY3kuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgSGFuY29jayA8aGFuY29ja0BzZWRz
eXN0ZW1zLmNhPg0KPiAtLS0NCj4gDQo+IFRoaXMgaXMgYW4gdXBkYXRlZCB2ZXJzaW9uIG9mIGFu
IGVhcmxpZXIgcGF0Y2ggImlpbzogYWRjOiB4aWxpbng6IHN1cHBvcnQgYWxsDQo+IEFSTSBwbGF0
Zm9ybXMiLCBidXQgdGhpcyBvbmUganVzdCBkZWxldGVzIHRoZSBwbGF0Zm9ybSByZXN0cmljdGlv
biBlbnRpcmVseQ0KPiBhcyBpdCBzZWVtcyB1bm5lY2Vzc2FyeS4NCj4gDQo+ICBkcml2ZXJzL2lp
by9hZGMvS2NvbmZpZyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZyBiL2RyaXZlcnMvaWlvL2Fk
Yy9LY29uZmlnDQo+IGluZGV4IGY5NmE3NzAuLjdlMzI4NjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaWlvL2FkYy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9LY29uZmlnDQo+IEBA
IC0xMDg1LDcgKzEwODUsNiBAQCBjb25maWcgVklQRVJCT0FSRF9BREMNCj4gDQo+ICBjb25maWcg
WElMSU5YX1hBREMNCj4gICAgICAgICB0cmlzdGF0ZSAiWGlsaW54IFhBREMgZHJpdmVyIg0KPiAt
ICAgICAgIGRlcGVuZHMgb24gQVJDSF9aWU5RIHx8IE1JQ1JPQkxBWkUgfHwgQ09NUElMRV9URVNU
DQoNCkp1c3QgY3VyaW9zIGhlcmU6IGlzIGBkZXBlbmRzIENPTVBJTEVfVEVTVGAgbmVlZGVkIHNv
IHRoYXQgdGhpcyBnZXRzIGluY2x1ZGVkIGluIGEgY29tcGlsZS10ZXN0IGJ1aWxkID8NCkknbSBz
b21ld2hhdCB2YWd1ZSBvbiBMaW51eCdzIG1ha2VmaWxlIGxvZ2ljL3N0cnVjdHVyZS4NCg0KVGhh
bmtzDQpBbGV4DQoNCj4gICAgICAgICBkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiAgICAgICAgIHNl
bGVjdCBJSU9fQlVGRkVSDQo+ICAgICAgICAgc2VsZWN0IElJT19UUklHR0VSRURfQlVGRkVSDQo+
IC0tDQo+IDEuOC4zLjENCj4gDQo=
