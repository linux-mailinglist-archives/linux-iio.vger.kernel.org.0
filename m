Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3418636
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEIHbe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 03:31:34 -0400
Received: from mail-eopbgr810052.outbound.protection.outlook.com ([40.107.81.52]:54271
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfEIHbe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 May 2019 03:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7CFroJe1r+cPipzwnXEfpNcGv+uKNPfMUrW6mwLWYA=;
 b=g0paTyjpwYXbCRQ+5kHYPbrDhOFXF3zxYX9uMztCP3Ie8YwD+ItlA7wpuen2EK6SUp9I+YAtK2om0JiuvcaOGyHdImfhBBJ4tS/GSV2jCnzro7yjHtO03X/qh+ANxD7e6pevDTyhBzuTk3q1KkF+wmLD/Ti5O/3Vb8aGdN9pzAA=
Received: from CY4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:903:33::33)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Thu, 9 May
 2019 07:31:30 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by CY4PR03CA0023.outlook.office365.com
 (2603:10b6:903:33::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Thu, 9 May 2019 07:31:30 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Thu, 9 May 2019 07:31:29 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x497VSvl024076
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 9 May 2019 00:31:28 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Thu, 9 May 2019 03:31:28 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH 3/3][V3] iio: Handle enumerated properties with gaps
Thread-Topic: [PATCH 3/3][V3] iio: Handle enumerated properties with gaps
Thread-Index: AQHVBY/z/hY+5eHS1kGQU0cKESrq0qZheMuAgAExjgA=
Date:   Thu, 9 May 2019 07:31:27 +0000
Message-ID: <780a4bcbf2e8a2d816efe2ed9613ac2b1594282e.camel@analog.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
         <20190508111913.7276-3-alexandru.ardelean@analog.com>
         <20190508131749.GM9224@smile.fi.intel.com>
In-Reply-To: <20190508131749.GM9224@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15E851FD6999254CAA0FC0D7B0F4C8D0@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(199004)(189003)(478600001)(7696005)(76176011)(2486003)(23676004)(316002)(26005)(246002)(2501003)(186003)(8676002)(2351001)(14454004)(6916009)(336012)(86362001)(436003)(426003)(5660300002)(446003)(11346002)(229853002)(8936002)(2906002)(70206006)(70586007)(476003)(102836004)(2616005)(486006)(126002)(4326008)(356004)(50466002)(118296001)(54906003)(6246003)(36756003)(47776003)(5640700003)(106002)(7736002)(7636002)(3846002)(6116002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93c8d5df-645f-4c83-7862-08d6d4505a83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BY2PR03MB553;
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Antispam-PRVS: <BY2PR03MB55351709CC9E0DAF16B5DDEF9330@BY2PR03MB553.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 003245E729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TEjhdMAS2/W1Yk9XWi0AG87eDJxsuLhPeGJCOyQyt1Z+FyyRQIqtpf9kptq4BiLSFf5Hin2t7qbimqxhmNhWhSuAAle7oXAdb8UPZZu/spwzAsajU6fHQATfQ3rKCE8pAs3gwRWmkt+mSvnRjczgxEYlKuQYziZMUb8pnFZhtmlNRxR54/bfKsORkbB3wZ76hmnRgK0/JahlTXirP4sn/s3tdw7S1s3N84FWKQTcTZeUK2kU+HAi2n6bAScER2MdkOAwVC7ZrPDAwwYJq/FFixkwq9GVwqS1ARSJjMOYpyHcAmoup3zyAceZt19XcwCEALRd50Iipz7nhq40+JUpPE/MlWFQgTWnoGGCZCbZmbXHf20Sr+ZpGpFYWEcpt8379UjpiS7NSqxT9s+QsrE/H3Ckw2q7B1PzU4n/TJOocCA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2019 07:31:29.5097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c8d5df-645f-4c83-7862-08d6d4505a83
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTA4IGF0IDE2OjE3ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBXZWQsIE1heSAwOCwgMjAxOSBhdCAwMjoxOTox
M1BNICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+ID4gRnJvbTogTGFycy1QZXRl
ciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gDQo+ID4gU29tZSBlbnVtcyBtaWdodCBo
YXZlIGdhcHMgb3IgcmVzZXJ2ZWQgdmFsdWVzIGluIHRoZSBtaWRkbGUgb2YgdGhlaXINCj4gPiB2
YWx1ZQ0KPiA+IHJhbmdlLiBFLmcuIGNvbnNpZGVyIGEgMi1iaXQgZW51bSB3aGVyZSB0aGUgdmFs
dWVzIDAsIDEgYW5kIDMgaGF2ZSBhDQo+ID4gbWVhbmluZywgYnV0IDIgaXMgYSByZXNlcnZlZCB2
YWx1ZSBhbmQgY2FuIG5vdCBiZSB1c2VkLg0KPiA+IA0KPiA+IEFkZCBzdXBwb3J0IGZvciBzdWNo
IGVudW1zIHRvIHRoZSBJSU8gZW51bSBoZWxwZXIgZnVuY3Rpb25zLiBBIHJlc2VydmVkDQo+ID4g
dmFsdWVzIGlzIG1hcmtlZCBieSBzZXR0aW5nIGl0cyBlbnRyeSBpbiB0aGUgaXRlbXMgYXJyYXkg
dG8gTlVMTCByYXRoZXINCj4gPiB0aGFuIHRoZSBub3JtYWwgZGVzY3JpcHRpdmUgc3RyaW5nIHZh
bHVlLg0KPiA+IA0KPiA+IEFsc28sIGBfX3N5c2ZzX21hdGNoX3N0cmluZygpYCBub3cgc3VwcG9y
dHMgTlVMTCBnYXBzLCBzbyB0aGF0IGRvZXNuJ3QNCj4gPiByZXF1aXJlIGFueSBjaGFuZ2VzLg0K
PiA+IC0gICAgIGZvciAoaSA9IDA7IGkgPCBlLT5udW1faXRlbXM7ICsraSkNCj4gPiArICAgICBm
b3IgKGkgPSAwOyBpIDwgZS0+bnVtX2l0ZW1zOyArK2kpIHsNCj4gPiArICAgICAgICAgICAgIGlm
ICghZS0+aXRlbXNbaV0pDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+
ICAgICAgICAgICAgICAgbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIFBBR0VfU0laRSAtIGxl
biwgIiVzICIsIGUtDQo+ID4gPml0ZW1zW2ldKTsNCj4gPiArICAgICB9DQo+IA0KPiBUaGUgcHJv
YmxlbSBoZXJlIHRoYXQgdGhlIHVzZXIgd2lsbCBoYXZlIG5vIGNsdWUgd2hlcmUgdGhlIGdhcCBp
cw0KPiBoYXBwZW5lZCwgdG8NCj4gc29sdmUgdGhpcyB3ZSBuZWVkIGVpdGhlciBiaXRtYXAgb2Yg
YXJyYXksIHdoZXJlIHNldCBiaXRzIHNob3dzIGRlZmluZWQNCj4gaXRlbXMsDQo+IG9yIHVzZSBj
b21tYS1zZXBhcmF0ZWQgbGlzdCBvZiB2YWx1ZXMuIFRoZSBsYXR0ZXIgd291bGQgbmVlZCBhbm90
aGVyIG5vZGUNCj4gc2luY2UNCj4gd2UgZG9uJ3QgYnJlYWsgdXNlciBzcGFjZS4NCg0KSG1tbS4N
CkkgYW0gd29uZGVyaW5nIGlmIHRoZXJlIGFyZSBjYXNlcyB3aGVyZSB1c2Vyc3BhY2Ugd291bGQg
Y2FyZSBhYm91dCByZXNlcnZlZA0KdmFsdWVzIGFuZC9vciBwb3NpdGlvbnMgb2YgcmVzZXJ2ZWQg
Yml0LWZpZWxkcy4NCk1heWJlIHlvdSBjb3VsZCBvZmZlciBleGFtcGxlcy91c2UtY2FzZXMgd2hl
cmUgdGhpcyBpcyBuZWVkZWQuDQoNClRvIHNvbWUgZXh0ZW50IHRoZSBrZXJuZWwgW2RyaXZlcnMg
JiBmcmFtZXdvcmtzXSBzaG91bGQgcHJvYmFibHkgbm90IG5lZWQNCnRvIGV4cG9zZSB0aGF0ICJz
dHJpbmctZW51bS1YIiAgPT0gYGJpdGZpZWxkXzJgIG1hdGNoaW5nOyBvdGhlcndpc2UgaXQNCmRv
ZXNuJ3QgcmVhbGx5IGFkZCBtdWNoIHZhbHVlIDsgdGhlIHdob2xlIHBvaW50IG9mIGZyYW1ld29y
a3MgW2luIGdlbmVyYWxdDQppcyB0byBvZmZlciBzb21lIGxldmVsIG9mIGFic3RyYWN0aW9uIHRv
IEhXLg0KDQpUaGUgb25seSBleGFtcGxlIEkgY2FuIHRoaW5rIG9mIFthdG1dLCBpcyB3aGVuIGEg
cmVzZXJ2ZWQgYml0LWZpZWxkIHdpbGwgYmUNCnVzZWQgaW4gdGhlIGZ1dHVyZS4gQnV0IHRoZW4s
IHRoZSBkcml2ZXIgc2hvdWxkIGNhcmUgYWJvdXQgdGhpcywgYW5kIG5vdA0KdGhlIGZyYW1ld29y
ay4gVGhlIGRyaXZlciBzaG91bGQgZGVjaWRlIHRoYXQgImJpdGZpZWxkXzIiIHdpbGwNCmVuYWJs
ZS9kaXNhYmxlIHNvbWV0aGluZyBbaW4gdGhlIGZ1dHVyZV0sIGFuZCBzaG91bGQgYmUgY29uc2lk
ZXJlZCBpbiBhDQpzdWNoIGEgd2F5ICh3aGVuIGJlaW5nIHdyaXR0ZW4pLiBJZiB0aGUgZHJpdmVy
IGNhbid0IG1ha2UgdGhpcyBwcmVkaWN0aW9uIFsNCmFib3V0ICJiaXRmaWVsZF8yIl0gdGhlbiBh
IG5ldyBkcml2ZXIgbXVzdCBiZSB3cml0dGVuIGFueXdheS4NCg0KQnV0IEkgd2lsbCBhZ3JlZSB0
aGF0IEkgbWF5IG5vdCBoYXZlIGFsbCBhcmd1bWVudHMgaW4gbWluZCB0byBiZSAxMDAlIHN1cmUN
Cm9mIGFsbCB0aGlzLg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJl
Z2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQo=
