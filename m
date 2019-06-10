Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0B3AFC4
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 09:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbfFJHfH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 03:35:07 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:19791
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387984AbfFJHfG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Jun 2019 03:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01nXxt0tZFLuHOCgDsBhkpxqSLOcnLLxnp90XWqJWzY=;
 b=1xhZUbYUkukDjGZBis6NeA8oW+oXcbeO8vJtkNM8qLkssGd8c4Xy/Nn3VPANc0ZQc/0N56oH+gVCMoebuQIH323D97g1zoMoL+GC8xLZwUWmAsm3VdAr1g83OBERxEH8lGz8bWfFDM1RAstcFcLTX7pacOX77roNWhLOvJkQYVM=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 SN2PR03MB2272.namprd03.prod.outlook.com (2603:10b6:804:e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Mon, 10 Jun 2019 07:35:02 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.13 via Frontend
 Transport; Mon, 10 Jun 2019 07:35:02 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Mon, 10 Jun 2019 07:35:01 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5A7Z00K013945
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Jun 2019 00:35:00 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 10 Jun 2019 03:35:00 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "hancock@sedsystems.ca" <hancock@sedsystems.ca>
CC:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: xilinx: support all ARM platforms
Thread-Topic: [PATCH] iio: adc: xilinx: support all ARM platforms
Thread-Index: AQHVG+Xlca5zDvFM6EOV+QckaK3pXaaOq0GAgABXHACAAQ6nAIAAxX6AgAAEJ4CAARQjgIAC2neA
Date:   Mon, 10 Jun 2019 07:34:58 +0000
Message-ID: <5d3044dcb42a421bc366f3d8367cd127968e99f8.camel@analog.com>
References: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
         <379a99c8405b4cfbaa61ac49f9b40d4c577eb2a8.camel@analog.com>
         <95be35ff-2e3d-bc00-8798-7c9f462a96a6@sedsystems.ca>
         <a96943b7-00f5-288f-fa27-a82f1d6aa8dd@xilinx.com>
         <CA+U=DsrBqfmqfxS_SaPJHHiet0ZuAsCK5Kdha_rH+Cbm4VRP4A@mail.gmail.com>
         <13a8eaf3-b5ee-151b-d959-80fb41e8a7f8@sedsystems.ca>
         <20190608130031.4a695baf@archlinux>
In-Reply-To: <20190608130031.4a695baf@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F96D4911E2C9684A92CD741CD9797C97@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(51914003)(199004)(189003)(336012)(7636002)(70206006)(86362001)(478600001)(7696005)(305945005)(110136005)(53546011)(7736002)(50466002)(14454004)(118296001)(6246003)(70586007)(102836004)(229853002)(3846002)(6116002)(36756003)(186003)(14444005)(486006)(47776003)(2906002)(76176011)(126002)(316002)(5660300002)(356004)(246002)(54906003)(446003)(2616005)(11346002)(106002)(26005)(4326008)(476003)(2501003)(8676002)(426003)(436003)(2486003)(23676004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2272;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eddd8bf7-14b7-45ee-c667-08d6ed7625f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:SN2PR03MB2272;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2272:
X-Microsoft-Antispam-PRVS: <SN2PR03MB227210FD7E2C7D04592471F6F9130@SN2PR03MB2272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0064B3273C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HzpZStVxn6WL/D5kpoZ29EJNB14c2SqTd+V+M6PuxwXh8jVaGJehKy8h3bRPLLJ3u1D0sFH8uwVRVudNxwKcSr6vUvZARhp+clPovBxvdpgm3VrnPp8EHbOmerHj9kiYxYZpSom2TYOdgRg1avTyOuuctAmitpT1gBu0xAsinwhoYpkm+V7jzk3+Znj7wBK49GjETAUPe8VVybMgHTNqj7f4P8WRh0HJ/8aoMbvXEJBnYQD/VeAxi+qS9BJSfDhaUM8B47iWUPZH1FOpQ2uj/nYI92GJfu4btXKUmE5dHv3MjzwKfNmGqo7xEY7JT2MTO5/5tIX5HilPxjZeD7zl7AoLL0B5vVIhR3/dzPp+BybVN2yD/sc5m/mImnPwO/bwmYrRuHM1/DVcRf71HcO+wEMe6dzqzHnJ5zuLkhdmpYM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2019 07:35:01.2255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddd8bf7-14b7-45ee-c667-08d6ed7625f3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2272
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA2LTA4IGF0IDEzOjAwICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gRnJpLCA3IEp1biAyMDE5IDEzOjMyOjExIC0w
NjAwDQo+IFJvYmVydCBIYW5jb2NrIDxoYW5jb2NrQHNlZHN5c3RlbXMuY2E+IHdyb3RlOg0KPiAN
Cj4gPiBPbiAyMDE5LTA2LTA3IDE6MTcgcC5tLiwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0K
PiA+ID4gT24gRnJpLCBKdW4gNywgMjAxOSBhdCAxMDozMyBBTSBNaWNoYWwgU2ltZWsgPG1pY2hh
bC5zaW1la0B4aWxpbnguY29tPiB3cm90ZToNCj4gPiA+ID4gT24gMDYuIDA2LiAxOSAxNzoyMSwg
Um9iZXJ0IEhhbmNvY2sgd3JvdGU6DQo+ID4gPiA+ID4gT24gMjAxOS0wNi0wNiA0OjA5IGEubS4s
IEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBXZWQsIDIwMTktMDYt
MDUgYXQgMTU6MDcgLTA2MDAsIFJvYmVydCBIYW5jb2NrIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBb
RXh0ZXJuYWxdDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
U2luY2UgdGhlIFhBREMgbG9naWMgY2FuIGJlIHVzZWQgd2l0aCBzdGFuZGFsb25lIFhpbGlueCBG
UEdBcywgdGhpcyBkcml2ZXINCj4gPiA+ID4gPiA+ID4gY2FuIHBvdGVudGlhbGx5IGJlIHVzZWQg
d2l0aCB2YXJpb3VzIEFSTSBwbGF0Zm9ybXMsIG5vdCBqdXN0IFp5bnEuDQo+ID4gPiA+ID4gPiA+
IENoYW5nZSB0aGUgWnlucSBkZXBlbmRlbmN5IHRvIEFSTSBpbiB0aGUgbGlzdCBvZiBzdXBwb3J0
ZWQgcGxhdGZvcm1zDQo+ID4gPiA+ID4gPiA+IGluIHRoZSBLY29uZmlnIGRlcGVuZGVuY2llcyBm
b3IgdGhpcyBkcml2ZXIuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRvIG15IGtub3dsZWRn
ZSwgdGhlcmUgYXJlIDMgRlBHQSBwbGF0Zm9ybXMgd2l0aCBBUk0gc3VwcG9ydGVkIGluIExpbnV4
Lg0KPiA+ID4gPiA+ID4gQW5kIHN5bWJvbHMgYXJlIEFSQ0hfWllOUSwgQVJDSF9aWU5RTVAgJiBB
UkNIX1NPQ0ZQR0EuDQo+ID4gPiA+ID4gPiBGb3IgdGhlc2UgQVJNICsgRlBHQSBTb0NzLCBpdCBp
cyB1c3VhbGx5IHByZWZlcnJlZCB0byBsaXN0IHRoZSBzdXBwb3J0ZWQvdGVzdGVkIEFSTSArIEZQ
R0EgcGxhdGZvcm1zIGluDQo+ID4gPiA+ID4gPiBLY29uZmlnLg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBJIGFtIGN1cmlvdXM6IGFyZSB5b3UgdXNpbmcgc29tZXRoaW5nIHRoYXQgaXNuJ3Qg
aW4gdGhlIGFib3ZlIGxpc3Q/DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gWWVzLCB3ZSBhcmUgdXNp
bmcgdGhlIFhBREMgb24gYSBLaW50ZXgtNyBGUEdBIHRocm91Z2ggYSBQQ0llIHRvIEFYSQ0KPiA+
ID4gPiA+IGJyaWRnZSB1c2luZyBhbiBpTVg2RCBwbGF0Zm9ybSAtIG5vdCBhbiBpbnRlZ3JhdGVk
IEFSTStGUEdBLg0KPiA+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJbiB0aGF0IGNhc2UsIGl0IHdv
dWxkIGJlIGEgYml0IG1vcmUgaW50ZXJlc3RpbmcgdG8gZG8gYSBkZXBlbmRzIG9uDQo+ID4gPiBQ
Q0lFX1hJTElOWCwgb3Igd2hpY2hldmVyIGlzIHRoZSBLY29uZmlnIHN5bWJvbCBmb3IgdGhlIFBD
SWUtdG8tQVhJDQo+ID4gPiBicmlkZ2UuDQo+ID4gPiANCj4gPiA+IEFuZCB0aGVyZSBhcmUgc29t
ZSBiZW5lZml0cyB0byB0aGF0LCB0aGUgbWFqb3IgYmVpbmcgdGhhdCB5b3UgY2FuIGFsc28NCj4g
PiA+IHN1cHBvcnQgb3RoZXIgQVJDSHMgYXMgd2VsbCAoeDg2LCBwcGMsIG1pcHMsIGV0YykuDQo+
ID4gDQo+ID4gVGhlcmUgaXNuJ3QgYSBrZXJuZWwgZHJpdmVyIGZvciB0aGF0IFBDSWUtQVhJIGJy
aWRnZSAtIGl0IGRvZXNuJ3QgcmVhbGx5DQo+ID4gZG8gbXVjaCB2ZXJ5IGludGVyZXN0aW5nIG9u
IGl0cyBvd24sIGl0IGp1c3QgYWN0cyBhcyBhIHJlZ3VsYXIgUENJZQ0KPiA+IGVuZHBvaW50IGFu
ZCBoYXMgYnVpbGQtdGltZSBzZXR0aW5ncyB0byBtYXAgQVhJIG1lbW9yeSB0byBQQ0llIEJBUnMg
YW5kDQo+ID4gaG9zdCBtZW1vcnkgaW50byBBWEkgbWVtb3J5IHNwYWNlLiBZb3UgaGF2ZSB0byBi
dWlsZCB5b3VyIG93biBsb2dpYyB0bw0KPiA+IGRvIHRoaW5ncyBsaWtlIG1hcCBpbnRlcnJ1cHRz
IGZyb20gdGhlIEFYSSBzaWRlIG9udG8gTVNJIGludGVycnVwdHMgZnJvbQ0KPiA+IHRoZSBicmlk
Z2UuDQo+ID4gDQo+ID4gSXQga2luZCBvZiBzZWVtcyBsaWtlIHRoZSBlYXNpZXN0IHNvbHV0aW9u
IHdvdWxkIGJlIHRvIGp1c3QgZGVsZXRlIHRoZQ0KPiA+IHBsYXRmb3JtIHJlc3RyaWN0aW9uIGVu
dGlyZWx5IGZvciB0aGlzIGRyaXZlciwgYXMgSSByZWFsbHkgZG9uJ3Qgc2VlDQo+ID4gYW55dGhp
bmcgcGxhdGZvcm0gc3BlY2lmaWMgaW4gdGhlcmUuIFdvdWxkIGFueW9uZSBvYmplY3QgdG8gdGhh
dD8NCj4gDQo+IFNvdW5kcyBnb29kIHRvIG1lLg0KDQpTb3VuZHMgZmluZSB0byBtZSBhcyB3ZWxs
Lg0KSSBndWVzcyB0aGUgaW5pdGlhbCBpbnRlbnQgKHdpdGggQVJDSF8gZGVwZW5kcykgd2FzIHRv
IGxpbWl0IHRvIHdoYXQgd2FzIHRlc3RlZCwgd2hlbiB0aGUgZHJpdmVyIHdhcyB3cml0dGVuIGlu
aXRpYWxseS4NCg0KSG93ZXZlciwgb3RoZXIgdXNlcnMgY2FuIHRyeSB0aGlzIG9uIHRoZWlyIG93
biB3aXRoIGRpZmZlcmVudCBjb21iaW5hdGlvbnMgKGxpa2UgdGhlIG9uZXMgbWVudGlvbmVkIGFi
b3ZlKS4NClRoYW5rcyBmb3IgdGhlIGluZm8gYnR3OiBpdCB3YXMgaW5mb3JtYXRpdmUgKEkgbGVh
cm5lZCBzb21ldGhpbmcpLg0KDQpUaGFua3MNCkFsZXgNCg0KDQo+IA0KPiBKb25hdGhhbg0KPiAN
Cj4gPiA+IE5hdHVyYWxseSwgaWYgdXNpbmcgYSBkaWZmZXJlbnQgUENJZS10by1BWEkgYnJpZGdl
IGNvbnRyb2xsZXIgKG90aGVyDQo+ID4gPiB0aGFuIFhpbGlueCdzKSwgaXQgd291bGQgYmUgYW4g
aWRlYSB0byB1c2UgdGhhdCBLY29uZmlnIHN5bWJvbC4NCj4gPiA+IA0KPiA+ID4gPiA+IFVzaW5n
IHN1Y2ggYW4gYXBwcm9hY2ggdGhpcyBkcml2ZXIgY291bGQgcG90ZW50aWFsbHkgYmUgdXNlZCBv
biBqdXN0DQo+ID4gPiA+ID4gYWJvdXQgYW55IHBsYXRmb3JtLCBidXQgSSBkaWRuJ3Qgd2FudCB0
byBvcGVuIGl0IHVwIHRvbyBtdWNoIGZvciBub3cgaW4NCj4gPiA+ID4gPiBjYXNlIG9mIHNvbWUg
Y29tcGlsZSBpc3N1ZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiAwZGF5IHN5c3RlbSBzaG91bGQgYW5z
d2VyIHRoaXMgZm9yIHlvdS4NCj4gPiA+ID4gDQo+ID4gPiA+IE0NCg==
