Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71067149F3
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEFMjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 08:39:12 -0400
Received: from mail-eopbgr730069.outbound.protection.outlook.com ([40.107.73.69]:43648
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfEFMjM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 May 2019 08:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey3TOmPEbh5M7Iop89AlGi+2Lm5NofI+vPOLMgtnKfw=;
 b=ghn4CM/HRiVcnjcKiRyDo+2vkYaJtv1L1dcmjbGakggqvWpb0orkLckzZL8cQo/k9wH0rQlr9lkcja0V+a3lyFcwq/4A/N47UJQ/6iJ0WAo6CNXy6Wbs8QWT/eSvpU1YMT10GoY/SQfnHkHFs0DtpWdWuhgJ9gWD/o9ucVa9EYY=
Received: from CY1PR03CA0015.namprd03.prod.outlook.com (2603:10b6:600::25) by
 BY2PR03MB556.namprd03.prod.outlook.com (2a01:111:e400:2c3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Mon, 6 May
 2019 12:39:09 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY1PR03CA0015.outlook.office365.com
 (2603:10b6:600::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Mon, 6 May 2019 12:39:09 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Mon, 6 May 2019 12:39:08 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x46Cd737028204
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 May 2019 05:39:07 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 6 May 2019 08:39:07 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RFC][PATCH] dt-bindings: iio: accel: add adi,adxl345.yaml
 binding
Thread-Topic: [RFC][PATCH] dt-bindings: iio: accel: add adi,adxl345.yaml
 binding
Thread-Index: AQHVBAFSe2DVRijSLECaFD7K1EKCAqZeTG4A
Date:   Mon, 6 May 2019 12:39:06 +0000
Message-ID: <10cb0df218036cfd779d2c5e2555959fb5bef242.camel@analog.com>
References: <20190506114610.28083-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190506114610.28083-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AB2B9E511C16340BEC08AFE68060765@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(50466002)(7736002)(7636002)(8936002)(476003)(426003)(436003)(8676002)(86362001)(6116002)(3846002)(102836004)(47776003)(26005)(305945005)(2486003)(23676004)(76176011)(36756003)(7696005)(2906002)(356004)(4326008)(6306002)(246002)(118296001)(186003)(2616005)(229853002)(11346002)(106002)(70586007)(70206006)(486006)(5660300002)(336012)(126002)(446003)(478600001)(316002)(14454004)(6246003)(2501003)(966005)(110136005)(53376002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB556;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0447a27-9775-4bab-97d1-08d6d21fd5a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BY2PR03MB556;
X-MS-TrafficTypeDiagnostic: BY2PR03MB556:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <BY2PR03MB556955D12BD7B49800948BDF9300@BY2PR03MB556.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0029F17A3F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gVUPz40SCqHYXSW7bp1BJ8oW1xrA7tZzKzjD7AHJZLQWyC81zCJVb/tBn7o1bUQQxN3LjKslunr4nm0UrjamDfSnxAo2QTA4D7xclREpjLnpqvFf9bfL89TTIGTMmOQDddOXdsfH4hWdpjgAYEpNQ36NHlV44I/xJB0dlspa+y3NOfdazx3/CdIsIae9FE/wEvs2oqXA+3qLjHF1cW2YwV/zYOBOpXeXRAUpLSuqgNNc28lGgpV0uNLo3py+4bggbofmlGwuj2EfnnX48wnou9iKQ9iujTXzmgPzngFZoVnWrkbY6UD1K6sL8rfwUrgD/PMNvDJRUwjHkDWPpR1/ihyb0gMufxnJzQSuUK0tjPd5LydjHELVdmcCUL/eghEz9UqGNp47mGi2jeOYQjjZPDrb6rK8YTB0CgE0q2ZbxM4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2019 12:39:08.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0447a27-9775-4bab-97d1-08d6d21fd5a7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB556
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTA2IGF0IDE0OjQ2ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyBhIFlBTUwgYmluZGluZyBmb3IgdGhlIEFuYWxvZyBEZXZp
Y2VzIEFEWEwzNDUgSTJDL1NQSQ0KPiBhY2NlbGVyb21ldGVyLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4g
LS0tDQo+IA0KPiBBbmQgbm93IGZvciB0aGUgUkZDIHBhcnQuDQo+IE5vcm1hbGx5LCBJIHdvdWxk
IGRpZyBpbnRvIHNvdXJjZS1jb2RlIHRvIHRyeSB0byBmaWd1cmUgdGhpcyBvdXQsIGJ1dCBhdA0K
PiB0aGlzIHBvaW50LWluLXRpbWUsIEkgYW0gbG93IG9uIHRpbWUvZW5lcmd5IHRvIGRvIHRoaXMu
DQo+IEFuZCBtYXliZSB0aGlzIGhlbHBzIHRyaWdnZXIgYSBkaXNjdXNzaW9uIGFib3V0IHRoaXMu
DQo+IA0KPiBBcG9sb2dpZXMgaWYgdGhpcyBoYXMgYmVlbiBjb3ZlcnRlZCBvbiB0aGUgZGV2aWNl
dHJlZSBtYWlsaW5nIGxpc3QsIGJ1dA0KPiBhdCBsZWFzdCB3ZSdkIGdldCBzb21lIGNvdmVyYWdl
IG9uIHRoZSBJSU8gbGlzdCAod2l0aCB0aGlzKS4NCj4gDQo+IFRoZSBBRFhMMzQ1IGRldmljZSAo
YXMgb3RoZXJzKSBzdXBwb3J0cyBib3RoIEkyQyAmIFNQSSBpbnRlcmZhY2VzLg0KPiANCj4gUXVl
c3Rpb24xOiBkbyB3ZSB3cml0ZSAyIFlBTUwgZmlsZXMsIG9yIDEgPyBJIHdhcyBsb29raW5nIGF0
IFplcGh5ciAoZm9yDQo+IHNvbWUgaWRlYXMvcmVmZXJlbmNlKSBidXQgaXQgc2VlbXMgdG8gbWUg
dGhhdCB0aGUgWUFNTCBEVCBiaW5kaW5nIGZvcm1hdA0KPiBpcw0KPiBkaWZmZXJlbnQgdGhhbiB0
aGlzIG9uZSA/IFRoZXkgd3JpdGUgMiBmaWxlcyBmb3IgQURYTDM3MiAoMSBmb3IgU1BJLCAxDQo+
IGZvcg0KPiBJMkMpLg0KPiANCj4gUXVlc3Rpb24xLWE6IG9uZSB0aGluZyBpcyB0aGF0IFNQSSBy
ZXF1aXJlcyBzb21lIHByb3BzIHRvIGJlIGByZXF1aXJlZGANCj4gdGhhdCB3b3VsZCBub3QgYmUg
cmVxdWlyZWQgZm9yIHRoZSBJMkMgYmluZGluZy4gVGhpcyBjb3VsZCBiZSBzb2x2ZWQgYnkNCj4g
ZG9pbmcgMiBmaWxlcywgYnV0IGlmIGRvaW5nIDEgWUFNTCBmaWxlLCBpcyB0aGVyZSBhIHdheSB0
byBkbyBjb25kaXRpb25hbA0KPiBgcmVxdWlyZWRgID8gaS5lLiBwcm9wZXJ0eSBpcyByZXF1aXJl
ZCBpZiBgU1BJYCA/IG5vdCBzdXJlIGhvdyB0byBjaGVjaw0KPiBmb3INCj4gU1BJIHZzIEkyQywg
aXQgd291bGQgYmUgaW50ZXJlc3RpbmcgKGF0IHNvbWUgcG9pbnQpIHRvIHNvbWVob3cgZW5mb3Jj
ZQ0KPiBTUEkvSTJDIGJpbmRpbmdzIGNvcnJlY3RuZXNzLg0KPiANCj4gUXVlc3Rpb24yOiBgbWFr
ZSBkdF9iaW5kaW5nX2NoZWNrYCBzZWVtcyB0byBnZW5lcmF0ZSBvbmx5IHRoZSBmaXJzdA0KPiBl
eGFtcGxlLiBJcyB0aGlzIGtub3duIGJlaGF2aW9yLCBvciBkbyBJIG5lZWQgdG8gdGFrZSBzb21l
dGhpbmcgZWxzZSBpbnRvDQo+IGNvbnNpZGVyYXRpb24gPw0KPiANCj4gUXVlc3Rpb24zOiBvbmUg
aWRlYSB0aGF0IHdhcyBuZWF0IGluIFplcGh5ciwgaXMgdGhhdCB0aGVyZSBpcyBhDQo+ICdpbmhl
cml0cycNCj4gKyBgIWluY2x1ZGVgIG1lY2hhbmlzbSBmb3IgaW5jbHVkaW5nIGNvbW1vbiBTUEkg
JiBJMkMgZGV2aWNlIHN0dWZmLiBJdA0KPiB3b3VsZCBiZSBuZWF0IHRvIGhhdmUgdGhpcy4gSXMg
dGhlcmUgYSB3YXkgdG8gZG8gdGhpcyBub3csIG9yIG1heWJlIHRoaXMNCj4gd291bGQgY29tZSBs
YXRlciA/IE1heWJlLCBqdXN0IGhhdmluZyBhIHdheSB0byBpbmNsdWRlIGEgWUFNTCBmaWxlIGlu
dG8NCj4gYW5vdGhlciB3b3VsZCBiZSBpbnRlcmVzdGluZy4NCj4gDQo+ICAuLi4vYmluZGluZ3Mv
aWlvL2FjY2VsL2FkaSxhZHhsMzQ1LnlhbWwgICAgICAgfCA2MyArKysrKysrKysrKysrKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWRpLGFk
eGwzNDUueWFtbA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9paW8vYWNjZWwvYWRpLGFkeGwzNDUueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWRpLGFkeGwzNDUueWFtbA0KPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjI0NmI5MGMwN2FhYQ0KPiAtLS0gL2Rl
di9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNj
ZWwvYWRpLGFkeGwzNDUueWFtbA0KPiBAQCAtMCwwICsxLDYzIEBADQo+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vYWNjZWxlcm9tZXRlcnMvYWRpLGFkeGwzNDUu
eWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPiArDQo+ICt0aXRsZTogQW5hbG9nIERldmljZXMgQURYTDM0NS9BRFhMMzc1IDMt
QXhpcyBEaWdpdGFsIEFjY2VsZXJvbWV0ZXJzDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAt
IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiArDQo+
ICtkZXNjcmlwdGlvbjogfA0KPiArICBEcml2ZXIgZm9yIEFuYWxvZyBEZXZpY2VzIEFEWEwzNDUv
QURYTDM3NSAzLUF4aXMgRGlnaXRhbA0KPiBBY2NlbGVyb21ldGVycw0KPiArICAgIGh0dHA6Ly93
d3cuYW5hbG9nLmNvbS9lbi9wcm9kdWN0cy9tZW1zL2FjY2VsZXJvbWV0ZXJzL2FkeGwzNDUuaHRt
bA0KPiArICAgIA0KPiBodHRwOi8vd3d3LmFuYWxvZy5jb20vZW4vcHJvZHVjdHMvc2Vuc29ycy1t
ZW1zL2FjY2VsZXJvbWV0ZXJzL2FkeGwzNzUuaHRtbA0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiAr
ICBjb21wYXRpYmxlOg0KPiArICAgIG9uZU9mOg0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAg
ICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gYWRpLGFkeGwzNDUNCj4gKyAgICAgICAg
ICAgICAgLSBhZGksYWR4bDM3NQ0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4gKyAgICAgIFRoZSBJMkMgYWRkcmVzcyBvciBTUEkgY2hpcCBzZWxlY3QgbnVtYmVyIG9mIHRo
ZSBzZW5zb3INCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIHNwaS1jcGhhOg0KPiArICAg
IGRlc2NyaXB0aW9uOg0KPiArICAgICAgU1BJIGNsb2NrIHBoYXNlIG11c3QgYmUgc2V0LCB0byBz
ZWxlY3QgU1BJIG1vZGUgMw0KPiArDQo+ICsgIHNwaS1jcG9sOg0KPiArICAgIGRlc2NyaXB0aW9u
Og0KPiArICAgICAgU1BJIGNsb2NrIHBvbGFyaXR5IG11c3QgYmUgc2V0LCB0byBzZWxlY3QgU1BJ
IG1vZGUgMw0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsg
ICAgICBBIHZhcmlhYmxlIG51bWJlciBvZiBpbnRlcnJ1cHRzIHdhcnJhbnRzIGEgZGVzY3JpcHRp
b24gb2Ygd2hhdA0KPiBjb25kaXRpb25zDQo+ICsgICAgICBhZmZlY3QgdGhlIG51bWJlciBvZiBp
bnRlcnJ1cHRzLiBPdGhlcndpc2UsIGRlc2NyaXB0aW9ucyBvbg0KPiBzdGFuZGFyZA0KPiArICAg
ICAgcHJvcGVydGllcyBhcmUgbm90IG5lY2Vzc2FyeS4NCj4gKw0KDQpvb3BzLA0Kc2luY2UgaSBs
ZWZ0IHRoaXMgdW4tY2hhbmdlZA0Kb2gsIHdlbGwsIGl0J3MgYW4gUkZDIGFueXdheSA6KQ0KaXQg
d291bGQgaGF2ZSByZWNlaXZlZCBhIFYyIGFueXdheQ0KDQo+ICtyZXF1aXJlZDoNCj4gKyAgLSBj
b21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAg
ICAvKiBFeGFtcGxlIGZvciBhIEkyQyBkZXZpY2Ugbm9kZSAqLw0KPiArICAgIGFjY2VsZXJvbWV0
ZXJAMmEgew0KPiArICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWR4bDM0NSI7DQo+ICsgICAg
ICAgICByZWcgPSA8MHg1Mz47DQo+ICsgICAgfTsNCj4gKyAgLSB8DQo+ICsgICAgLyogRXhhbXBs
ZSBmb3IgYSBTUEkgZGV2aWNlIG5vZGUgKi8NCj4gKyAgICBhY2NlbGVyb21ldGVyQDAgew0KPiAr
ICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWR4bDM0NSI7DQo+ICsgICAgICAgICByZWcgPSA8
MD47DQo+ICsgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDw1MDAwMDAwPjsNCj4gKyAgICAg
ICAgIHNwaS1jcG9sOw0KPiArICAgICAgICAgc3BpLWNwaGE7DQo+ICsgICAgfTsNCg==
