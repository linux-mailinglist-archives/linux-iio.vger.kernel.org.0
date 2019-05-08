Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5042D17859
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfEHLev (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 07:34:51 -0400
Received: from mail-eopbgr790079.outbound.protection.outlook.com ([40.107.79.79]:40451
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbfEHLer (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 May 2019 07:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBI3LJzd0wTZgbaBfQu+e5vOpAmqx52IAnXeQd3PKfQ=;
 b=nVnn+I+00EbnewPry4jZRIt5VlN2LZ8rKo0ThjONZt+7uYrtbk+pD/CYwiNzWK0wwq7uOaNBBsoVpSPLPxO3RCgr5UeeQQYFecB4qIxKVOTv4mcxwJogiM8aq0iDNlbm73rFo4ymM81ew5uoQmqja2AXmMyEFk/sJoQMUTswW30=
Received: from BN6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:405:6f::25)
 by MWHPR03MB3133.namprd03.prod.outlook.com (2603:10b6:301:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Wed, 8 May
 2019 11:34:45 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR03CA0087.outlook.office365.com
 (2603:10b6:405:6f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.20 via Frontend
 Transport; Wed, 8 May 2019 11:34:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 11:34:44 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x48BYi3X025041
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 8 May 2019 04:34:44 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Wed, 8 May 2019 07:34:44 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Thread-Topic: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Thread-Index: AQHU+OX/0R8yezHYP0WMOZzYo8YTnKZI76qAgACf+gCAAfXbgIACCG4AgADoV4CAAFN2AIAPq4eAgAAQ8ACAAu8fAA==
Date:   Wed, 8 May 2019 11:34:42 +0000
Message-ID: <904d4156a45a6f74ffdb4ef260498d91671b351c.camel@analog.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
         <20190422210606.GA8805@kroah.com>
         <86ea407aaa891e50a3bdaf2c3653636a365076ee.camel@analog.com>
         <20190424133455.00002909@huawei.com> <20190425193736.GA11458@kroah.com>
         <CA+U=DsoyPQyNDX6CDx=xE73H9A=66BGKhTseEvZcZZPnpPAfQw@mail.gmail.com>
         <20190426142754.GU9224@smile.fi.intel.com>
         <CA+U=DspC2gbcWgEoCfTs-K0UaGt9DBLkXoyFufShUXD61uAAbQ@mail.gmail.com>
         <20190506144620.GM9224@smile.fi.intel.com>
In-Reply-To: <20190506144620.GM9224@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E31F0C5D37C6740ADB20856E07F9D6C@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(51444003)(189003)(199004)(316002)(7696005)(2486003)(23676004)(53546011)(102836004)(246002)(76176011)(426003)(436003)(3846002)(11346002)(446003)(6116002)(106002)(336012)(118296001)(110136005)(36756003)(478600001)(54906003)(8936002)(26005)(186003)(2616005)(356004)(2501003)(305945005)(126002)(7736002)(476003)(486006)(7636002)(14454004)(6246003)(4326008)(47776003)(86362001)(70206006)(70586007)(229853002)(50466002)(2906002)(5660300002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3133;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b7be5b4-a440-415f-b94d-08d6d3a92b51
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:MWHPR03MB3133;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3133:
X-Microsoft-Antispam-PRVS: <MWHPR03MB313374A0F8936FE1332EC8CBF9320@MWHPR03MB3133.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Vm9Oc3y0PGFyGZtkRDrtJrIejwrTFBZVhKnIioVbJ6qqhytiqwrLFM4Jx3VyRXOlHvqC+qh4p4I9aoS0RKFWvABiqn4BdZfZRXn/w22WIAvl3nZNkQvoi5gGSFTfuB3tKV8wij3qChv2KH2h+WQwuUxwKf2uk2WF7ZT6BuLbsSqZ3KHqIhdkaqYPTdHucX7L8xYkBpovpE551qr5pwaARtuzckIODRH14KEDMVW/f2lHimY0pUVrpTuEaUY/bfANjVDHiIfTdJNbpTjzERImAQfaq7TNFE0FrAU/ceNMI++e1wRxEtKqFvtIDI0e2q7xKwBw4UUkwmWv4wc9MFTALeUX13nwrbkMYNiDtjx+tat8NiMhW/uRdhbzeJugs80Jclhj7RTGmB/YOX0Pw9BH9cUNouIKjus6TTVxHouOeYI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 11:34:44.8212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7be5b4-a440-415f-b94d-08d6d3a92b51
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTA2IGF0IDE3OjQ2ICswMzAwLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20gd3JvdGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBNb24sIE1heSAw
NiwgMjAxOSBhdCAwNDo0NTo0M1BNICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+
ID4gT24gRnJpLCBBcHIgMjYsIDIwMTkgYXQgNToyNyBQTSBhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20NCj4gPiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gT24gRnJpLCBBcHIgMjYsIDIwMTkgYXQgMTI6Mjk6MTFQTSArMDMw
MCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEhtbSwgSSBhY3R1
YWxseSBkaWQgbm90IGdpdmUgbXVjaCB0aG91Z2h0IHRvIHRoYXQgLTEuDQo+ID4gPiA+IEknbGwg
Y2hlY2sgaW50byB0aGlzIGFuZCBzZWUgYWJvdXQgYSBWMy4NCj4gPiA+ID4gSXQgbWF5IG1ha2Ug
bW9yZSBzZW5zZSB0byBqdXN0IGZpeCB0aGUgb3JpZ2luYWwNCj4gPiA+ID4gYF9fc3lzZnNfbWF0
Y2hfc3RyaW5nKClgLCBidXQgSSdsbCBuZWVkIHRvIGdvIHRocm91Z2ggdGhlIHVzZXJzIG9mDQo+
ID4gPiA+IHRoaXMgZnVuY3Rpb24gYW5kIHNlZS4NCj4gPiA+IA0KPiA+ID4gSSB3YXMgdGhpbmtp
bmcgYWJvdXQgZXhpc3RpbmcgdXNlcnMgb2Ygc3VjaCAod2l0aCAiZ2FwcyIpIGNhc2VzLg0KPiA+
ID4gTm90IGFsbCBvZiB0aGVtIGhhdmUgTlVMTCB0aGVyZSBhbmQgd291bGQgbGlrZSB0byBhdm9p
ZCBzb21lIG1lbWJlcnMuDQo+ID4gPiBUaG91Z2gsIEkgdGhpbmsgdGhhdCB3ZSBtYXkgaWdub3Jl
IE5VTEwgaXRlbXMgaWYgLTEgaXMgc3VwcGxpZWQuDQo+ID4gPiANCj4gPiA+IFRoaW5rIGFzIHdl
bGwgYWJvdXQgQVJSQVlfU0laRSgpIGFzIGdpdmVuIHRvIHRoYXQuDQo+ID4gPiANCj4gPiANCj4g
PiBJIGFtIGEgYml0IHZhZ3VlIG9uIHdoYXQgeW91IGFyZSBwcm9wb3NpbmcuDQo+ID4gSXMgaXQ6
DQo+ID4gDQo+ID4gYSkgTGVhdmUgX19zeXNmc19tYXRjaF9zdHJpbmcoKSBhcy1pcyBhbmQgaW50
cm9kdWNlIGEgbmV3DQo+ID4gYF9fc3lzZnNfbWF0Y2hfc3RyaW5nX3dpdGhfZ2FwcygpYCBoZWxw
ZXIvdmFyaWFudCA/DQo+ID4gYikgRml4IF9fc3lzZnNfbWF0Y2hfc3RyaW5nKCkgdG8gYnJlYWsv
ZXhpdCBvbiB0aGUgZmlyc3QgTlVMTCwgb25seSBpZg0KPiA+IC0xIGlzIHByb3ZpZGVkID8NCj4g
PiANCj4gPiBFaXRoZXIgaXMgZmluZSwgYnV0IEkgd2FudGVkIHRvIGNsYXJpZnkuDQo+IA0KPiBU
aGUgY3VycmVudCBsb2dpYyBzb21ldGhpbmcgbGlrZSAiLTEgdG8gZ28gdGlsbCBmaXJzdCBOVUxM
IiBhbmQNCj4gQVJSQVlfU0laRSgpIGluDQo+ICpzb21lKiBjYXNlcyBpcyBiYXNpY2FsbHkgdGhl
IHN5bm9ueW0gdG8gYWJvdmUuDQo+IA0KPiBXaGF0IEkgbWVhbnQgaXMgdG8gY2hlY2sgaWYgdGhl
cmUgaXMgKmFueSogY2FzZSB3aGVyZSBBUlJBWV9TSVpFKCkNCj4gYmVoYXZlcyBpbg0KPiB0aGUg
c2FtZSB3YXkgYXMgLTEuIFRob3NlIGNhc2VzIHNob3VsZCBiZSBmaXhlZCBhY2NvcmRpbmdseS4N
Cj4gDQo+IE90aGVyd2lzZSwgdGhlIGIpIGlzIHdoYXQgd291bGQgYmUgcHJlZmVycmVkIGFjY29y
ZGluZyB0byB0aGUgZGlzY3Vzc2lvbi4NCj4gDQoNCkFjay4NCg0KSSBzZW50IGEgc2VyaWVzLg0K
SSBndWVzcyB0aGlzIGlzIHRoZSBub2lzaWVzdCBJJ3ZlIGV2ZXIgYmVlbi4NCkFuZCBJIGZlZWwg
YSBiaXQgYmFkL2d1aWx0eSBbZm9yIGdlbmVyYXRpbmcgdGhhdCBtdWNoIG5vaXNlXSwgYnV0IEkn
bGwNCnByb2JhYmx5IGdyYWIgYSBiZWVyIGxhdGVyIHRvIHRyZWF0IGl0Lg0KDQpJJ2xsIHByb2Jh
Ymx5IGxlYXJuIHNvbWV0aGluZyBmcm9tIHRoaXMuDQpHdWlsdC10cmlwcGVkIGV4cGVyaWVuY2Vz
IGFyZSBwcmV0dHkgbGVhcm5mdWwuDQoNClRoYW5rcw0KQWxleA0KDQo+ID4gPiBBbmQgY29uc2lk
ZXIgdG8gZml4IG1hdGNoX3N0cmluZygpIGFjY29yZGluZ2x5Lg0KPiANCj4gLS0NCj4gV2l0aCBC
ZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQo=
