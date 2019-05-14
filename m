Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DE1C344
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2019 08:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfENG2v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 May 2019 02:28:51 -0400
Received: from mail-eopbgr770042.outbound.protection.outlook.com ([40.107.77.42]:12100
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfENG2v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 May 2019 02:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGt1SKT2R9tFfSv/LJO6A55fZ+WY6HphbbPbUCgok7Q=;
 b=TG2Ci6Nh89WoRwKuHL8k+X5N2pmo4XF6AeexYtWLeiWAoyo08ECOR3ab7RentKCUrt9+6CtDjeEzDiSGYd5LXjrvABb6U3AVX6rivlearsLujsGN+4Vdvnzkca9KMUA8uHv3kSzOy2KH5z2UgKkFeqX0qg0V7Locw7COxEfrrKQ=
Received: from BL0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:2d::35)
 by SN2PR03MB2269.namprd03.prod.outlook.com (2603:10b6:804:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.21; Tue, 14 May
 2019 06:28:46 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BL0PR03CA0022.outlook.office365.com
 (2603:10b6:208:2d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Tue, 14 May 2019 06:28:46 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Tue, 14 May 2019 06:28:46 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4E6SjfY006739
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 May 2019 23:28:45 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Tue, 14 May 2019 02:28:45 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH] dt-bindings: iio: accel: add adi,adxl345.yaml
 binding
Thread-Topic: [RFC][PATCH] dt-bindings: iio: accel: add adi,adxl345.yaml
 binding
Thread-Index: AQHVBAFSe2DVRijSLECaFD7K1EKCAqZeZ/CAgAADb4CACzFWgIAA2uSA
Date:   Tue, 14 May 2019 06:28:44 +0000
Message-ID: <31ba36096619cb2cf52c39f20fd23ebe13121877.camel@analog.com>
References: <20190506114610.28083-1-alexandru.ardelean@analog.com>
         <CAL_JsqL-jKM-qpawVoaLaqTpZhqNNFmgAOjv_azSwOU6zFS08g@mail.gmail.com>
         <fdf60ff605e040ef24ae10c1e0b3b522de6ef9ab.camel@analog.com>
         <20190513172517.GA1637@bogus>
In-Reply-To: <20190513172517.GA1637@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45565600189E494799400FDE228D88CE@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(199004)(189003)(54906003)(1730700003)(316002)(246002)(53546011)(8936002)(6116002)(8676002)(70586007)(70206006)(3846002)(336012)(7636002)(106002)(7736002)(102836004)(6916009)(186003)(26005)(5640700003)(2501003)(2351001)(76176011)(2906002)(7696005)(36756003)(23676004)(2486003)(118296001)(229853002)(356004)(5660300002)(50466002)(86362001)(47776003)(14444005)(14454004)(478600001)(6246003)(4326008)(446003)(126002)(11346002)(476003)(2616005)(426003)(436003)(486006)(305945005)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2269;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 070ba9e4-a2f5-4c2b-2487-08d6d8356b33
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:SN2PR03MB2269;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2269:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2269E7D17F4F028229B3933EF9080@SN2PR03MB2269.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0037FD6480
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vhgHEaJYl/uoCyPbpEFWt7WSQjNXE7kV2GKHbFLPnuspeqQVpJMxZQfKiTTAEOoOANVmLMGM6+fDO7GXjdh8Jkq5G/yWEhuAnqxpYqsCZW16b8e0XxuV/5MGeQ3HPKgvQmyRVJKrQkWMVNyp9ALceU4DcmivpB/j2T8zuMcVso52+k0dZlXVHSojtJZFyjA9b/9VcIDZaB2Nb5/NygH1DvTfxtEcTeG4dAzXzeBoBo1bfHjoXb0N+E5CZnEfGw53JfWRsoX5El6vwTuWALi0N7UmPHAadj1Q2POkYScVK0aWSVXis2MPgAoczllKEuC+q5ig3xQem71mAwJVClpf9FD+uDdhW0rcmKrB48mAkHt9bq951VVPnwpSKwi/47RSDkJoPKmOO3uEvLycw2aEOrXkdCHyi8m2EYd3Aof4ewc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2019 06:28:46.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ba9e4-a2f5-4c2b-2487-08d6d8356b33
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2269
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTEzIGF0IDEyOjI1IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCj4gDQo+IE9uIE1vbiwgTWF5IDA2LCAyMDE5IGF0IDAyOjI5OjU0UE0g
KzAwMDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDE5LTA1LTA2
IGF0IDA5OjE3IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+IFtFeHRlcm5hbF0NCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIE1heSA2LCAyMDE5IGF0IDY6NDYgQU0gQWxleGFu
ZHJ1IEFyZGVsZWFuDQo+ID4gPiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3Rl
Og0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIGEgWUFNTCBiaW5kaW5nIGZvciB0
aGUgQW5hbG9nIERldmljZXMgQURYTDM0NQ0KPiA+ID4gPiBJMkMvU1BJDQo+ID4gPiA+IGFjY2Vs
ZXJvbWV0ZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJk
ZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gDQo+ID4gPiA+IEFuZCBub3cgZm9yIHRoZSBSRkMgcGFydC4NCj4gPiA+ID4gTm9ybWFsbHks
IEkgd291bGQgZGlnIGludG8gc291cmNlLWNvZGUgdG8gdHJ5IHRvIGZpZ3VyZSB0aGlzIG91dCwN
Cj4gPiA+ID4gYnV0DQo+ID4gPiA+IGF0DQo+ID4gPiA+IHRoaXMgcG9pbnQtaW4tdGltZSwgSSBh
bSBsb3cgb24gdGltZS9lbmVyZ3kgdG8gZG8gdGhpcy4NCj4gPiA+ID4gQW5kIG1heWJlIHRoaXMg
aGVscHMgdHJpZ2dlciBhIGRpc2N1c3Npb24gYWJvdXQgdGhpcy4NCj4gPiA+ID4gDQo+ID4gPiA+
IEFwb2xvZ2llcyBpZiB0aGlzIGhhcyBiZWVuIGNvdmVydGVkIG9uIHRoZSBkZXZpY2V0cmVlIG1h
aWxpbmcgbGlzdCwNCj4gPiA+ID4gYnV0DQo+ID4gPiA+IGF0IGxlYXN0IHdlJ2QgZ2V0IHNvbWUg
Y292ZXJhZ2Ugb24gdGhlIElJTyBsaXN0ICh3aXRoIHRoaXMpLg0KPiA+ID4gPiANCj4gPiA+ID4g
VGhlIEFEWEwzNDUgZGV2aWNlIChhcyBvdGhlcnMpIHN1cHBvcnRzIGJvdGggSTJDICYgU1BJIGlu
dGVyZmFjZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBRdWVzdGlvbjE6IGRvIHdlIHdyaXRlIDIgWUFN
TCBmaWxlcywgb3IgMSA/IEkgd2FzIGxvb2tpbmcgYXQgWmVwaHlyDQo+ID4gPiA+IChmb3INCj4g
PiA+ID4gc29tZSBpZGVhcy9yZWZlcmVuY2UpIGJ1dCBpdCBzZWVtcyB0byBtZSB0aGF0IHRoZSBZ
QU1MIERUIGJpbmRpbmcNCj4gPiA+ID4gZm9ybWF0IGlzDQo+ID4gPiA+IGRpZmZlcmVudCB0aGFu
IHRoaXMgb25lID8gVGhleSB3cml0ZSAyIGZpbGVzIGZvciBBRFhMMzcyICgxIGZvcg0KPiA+ID4g
PiBTUEksIDENCj4gPiA+ID4gZm9yDQo+ID4gPiA+IEkyQykuDQo+ID4gPiA+IA0KPiA+ID4gPiBR
dWVzdGlvbjEtYTogb25lIHRoaW5nIGlzIHRoYXQgU1BJIHJlcXVpcmVzIHNvbWUgcHJvcHMgdG8g
YmUNCj4gPiA+ID4gYHJlcXVpcmVkYA0KPiA+ID4gPiB0aGF0IHdvdWxkIG5vdCBiZSByZXF1aXJl
ZCBmb3IgdGhlIEkyQyBiaW5kaW5nLiBUaGlzIGNvdWxkIGJlDQo+ID4gPiA+IHNvbHZlZCBieQ0K
PiA+ID4gPiBkb2luZyAyIGZpbGVzLCBidXQgaWYgZG9pbmcgMSBZQU1MIGZpbGUsIGlzIHRoZXJl
IGEgd2F5IHRvIGRvDQo+ID4gPiA+IGNvbmRpdGlvbmFsDQo+ID4gPiA+IGByZXF1aXJlZGAgPyBp
LmUuIHByb3BlcnR5IGlzIHJlcXVpcmVkIGlmIGBTUElgID8gbm90IHN1cmUgaG93IHRvDQo+ID4g
PiA+IGNoZWNrDQo+ID4gPiA+IGZvcg0KPiA+ID4gPiBTUEkgdnMgSTJDLCBpdCB3b3VsZCBiZSBp
bnRlcmVzdGluZyAoYXQgc29tZSBwb2ludCkgdG8gc29tZWhvdw0KPiA+ID4gPiBlbmZvcmNlDQo+
ID4gPiA+IFNQSS9JMkMgYmluZGluZ3MgY29ycmVjdG5lc3MuDQo+ID4gPiANCj4gPiA+IFRoZSBj
aGFsbGVuZ2UgaGVyZSBpcyB0aGVyZSdzIG5vdCByZWFsbHkgYW55IHdheSBmb3IgdGhlIHNjaGVt
YSB0bw0KPiA+ID4ga25vdyB3aGljaCBidXMgaXQgaXMuIFRoZSBvbmx5IHdheXMgdG8ga25vdyB0
aGlzIGFyZSBrbm93aW5nIGFsbA0KPiA+ID4gcG9zc2libGUgc3BpIG9yIGkyYyBjb250cm9sbGVy
IGNvbXBhdGlibGVzIG9yIHVzaW5nIHRoZSBwYXJlbnQgbm9kZQ0KPiA+ID4gbmFtZSAod2hpY2gg
aGFzbid0IGJlZW4gc3RyaWN0bHkgZW5mb3JjZWQpLiBJbiBvcmRlciB0byBnZXQgdGhpcw0KPiA+
ID4gaW5mb3JtYXRpb24gYXZhaWxhYmxlIHRvIHRoZSBzY2hlbWEsIHdlJ2QgbmVlZCB0byBhZGQg
dGhlIGluZm9ybWF0aW9uDQo+ID4gPiB0byB0aGUgbm9kZS4gV2UgZG8gdGhpcyB3aXRoICckbm9k
ZW5hbWUnLiBXZSBjb3VsZCBhZGQgYSAnJGJ1cycNCj4gPiA+IHByb3BlcnR5IGZvciBleGFtcGxl
LiBUaGUgdG9vbHMgd291bGQgaGF2ZSB0byB1bmRlcnN0YW5kIGRpZmZlcmVudA0KPiA+ID4gYnVz
ZXMgYW5kIHRoaW5ncyBsaWtlIEkyQyBtdXhlcyBjb21wbGljYXRlIGRvaW5nIHRoYXQuDQo+ID4g
PiANCj4gPiA+IE9uY2UgeW91IGhhdmUgc29tZXRoaW5nIGxpa2UgJGJ1cyBhdmFpbGFibGUsIHlv
dSBjb3VsZCBlaXRoZXIgaGF2ZSAyDQo+ID4gPiBmaWxlcyB3aXRoIGEgY3VzdG9tICdzZWxlY3Qn
IHRoYXQgY2hlY2tzIGNvbXBhdGlibGUgYW5kICRidXMgb3Igd2UNCj4gPiA+IGNvdWxkIGhhdmUg
MSBmaWxlIHVzaW5nIGlmL3RoZW4vZWxzZSBrZXl3b3Jkcy4gSG93ZXZlciwgd2UgZG9uJ3QgeWV0
DQo+ID4gPiBzdXBwb3J0IGlmL3RoZW4vZWxzZSBqc29uLXNjaGVtYSB0aGF0IHdhcyBhZGRlZCBp
biBkcmFmdDcsIGJ1dCB0aGF0J3MNCj4gPiA+IGJlaW5nIHdvcmtlZCBvbiBieSBNYXhpbWUgUmlw
YXJkLg0KPiA+ID4gDQo+ID4gPiBIb3dldmVyLCBmb3IgdGhpcyBjYXNlLCBJJ2QganVzdCBub3Qg
d29ycnkgYWJvdXQgdGhlIGlzc3VlLiBSZWFsbHksDQo+ID4gPiBzcGktY3BoYSBhbmQgc3BpLWNw
b2wgc2hvdWxkIG5vdCBiZSByZXF1aXJlZC4gSWYgb25seSAxIG1vZGUgaXMNCj4gPiA+IHN1cHBv
cnRlZCwgdGhlIGRyaXZlciBjYW4ga25vdyB0aGF0LiBJT1csIGl0IGlzIGltcGxpZWQgYnkgdGhl
DQo+ID4gPiBjb21wYXRpYmxlIHN0cmluZ3MuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiBRdWVz
dGlvbjI6IGBtYWtlIGR0X2JpbmRpbmdfY2hlY2tgIHNlZW1zIHRvIGdlbmVyYXRlIG9ubHkgdGhl
IGZpcnN0DQo+ID4gPiA+IGV4YW1wbGUuIElzIHRoaXMga25vd24gYmVoYXZpb3IsIG9yIGRvIEkg
bmVlZCB0byB0YWtlIHNvbWV0aGluZw0KPiA+ID4gPiBlbHNlDQo+ID4gPiA+IGludG8NCj4gPiA+
ID4gY29uc2lkZXJhdGlvbiA/DQo+ID4gPiANCj4gPiA+IFRoYXQncyBjb3JyZWN0LiBJIGhhdmVu
J3QgZmlndXJlZCBvdXQgaG93IHRvIGRvIGEgdmFyaWFibGUgbnVtYmVyIG9mDQo+ID4gPiBleGFt
cGxlcyBpbiBrYnVpbGQuDQo+ID4gDQo+ID4gVGhlbiwgd291bGQgaXQgYmUgZmluZSB0byBoYXZl
IG11bHRpcGxlIGV4YW1wbGVzLCBhbmQgd2FpdCBmb3IgdGhpcyB0bw0KPiA+IHBvcC0NCj4gPiBp
biB0aGUgWUFNTCBkdCBzdHVmZiBhdCBhIGxhdGVyIHBvaW50IGluIHRpbWUgPw0KPiA+IE9yLCBq
dXN0IDEgZXhhbXBsZSA/DQo+IA0KPiBJJ3ZlIG5vdyBmaXhlZCB0aGlzIGJ5IGV4dHJhY3Rpbmcg
ZWFjaCBleGFtcGxlIGludG8gYSBzdWItbm9kZSBpbiB0aGUNCj4gZ2VuZXJhdGVkIGR0cyBmaWxl
LCBzbyBtdWx0aXBsZSBleGFtcGxlcyBhcmUgZmluZSBub3cuIFRoZSBvbmx5DQo+IHJlc3RyaWN0
aW9uIGlzIGxhYmVscyBjYW4ndCBiZSByZXBlYXRlZC4NCg0KSGV5LA0KDQpNYW55IHRoYW5rcyA6
KQ0KDQpJJ2xsIHRha2UgYSBsb29rIHRoZSBuZXh0IGNvdXBsZSBvZiBkYXlzLg0KDQpBbGV4DQoN
Cj4gDQo+IFJvYg0K
