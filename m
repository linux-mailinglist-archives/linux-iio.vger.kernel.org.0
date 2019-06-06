Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6936F14
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfFFIuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 04:50:03 -0400
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:39118
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfFFIuD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jun 2019 04:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud6Z4zH8z4f1KIOgPdi/M2bK9mvFa4REYSYbS6XKVao=;
 b=D9aoqO2PeIlup2MQuxblkq8k0TBNmA+r0eDZTnpWUDCuMKeQnI5U2uIrIw3cxiq7VweqMjt695s7EbpqfrytS1PAKqAs/sEmc7qLNLZ6BcC0gdiW9hT94H2Q7GpkTbiDKksbUr8swRTe6mRuOTso6OYqpuIkmgPgUHnEnF8oMhE=
Received: from BN6PR03CA0112.namprd03.prod.outlook.com (2603:10b6:404:10::26)
 by BN3PR03MB2258.namprd03.prod.outlook.com (2a01:111:e400:7bbf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.13; Thu, 6 Jun
 2019 08:49:56 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR03CA0112.outlook.office365.com
 (2603:10b6:404:10::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Thu, 6 Jun 2019 08:49:56 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 08:49:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x568ns7x024963
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Jun 2019 01:49:54 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 6 Jun 2019 04:49:54 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lucasseikioshiro@gmail.com" <lucasseikioshiro@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>
CC:     "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: accel: adxl372: switch to YAML
 bindings
Thread-Topic: [PATCH v2] dt-bindings: iio: accel: adxl372: switch to YAML
 bindings
Thread-Index: AQHVF+0Rbwdtu/e84kO5fYjIxGVSPqaOnNAA
Date:   Thu, 6 Jun 2019 08:49:53 +0000
Message-ID: <e30a3c629f0d355c5131420437c031a522caea01.camel@analog.com>
References: <20190531201114.2973-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20190531201114.2973-1-lucasseikioshiro@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <89E64C3058AAC94A86F4072B5749E708@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(2486003)(76176011)(7696005)(47776003)(229853002)(8676002)(8936002)(14454004)(3846002)(6306002)(50466002)(23676004)(6116002)(7636002)(36756003)(7736002)(316002)(110136005)(305945005)(2906002)(70206006)(54906003)(106002)(336012)(478600001)(246002)(446003)(4326008)(126002)(118296001)(5660300002)(2501003)(476003)(11346002)(2201001)(7416002)(86362001)(102836004)(356004)(426003)(436003)(26005)(966005)(486006)(53376002)(186003)(70586007)(2616005)(6246003)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e154112b-ef53-436a-fb08-08d6ea5bf314
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <BN3PR03MB2258601B2FDDD75700743BF6F9170@BN3PR03MB2258.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /B5Ox/fMeeE1gsvBLKe9mhfs8vJDGvcVw/GIJlIZyWSy0Gih0Xktnjpf39Hn6sRlgH0s/+MJuwPm3Dh2o4tKSHYDy5RL5xOwKRqbjJJi6Upxs6/uAnHzgTNld3lgweITLySCBpx+PE8XcIB2tA6bZzIWoFRa0fAvcMImhKRnrfJ1PySIEF8oHeMHuQAcTjjvb3ygeAN4qZLQH5xd9TW8AEpAuJkJ2urrpifxh76w7mMakdBTNqikRFPhO2qcVZB4L2cNWoDEgr/5bcr23f9m0Cv+YxRjtB3ddwUQVuA8zpdxyF+XcSzlbjQT3qB5wHR5qV4Ujg/e92VuqBPFVYyKS2ToMVTd/4+1JQLfJPkduAE68AU2asSXhPkeOveNLTzSFah/VSVoolSSRzf+FlzNZpHg7WY6asQX4PvPjErdi1s=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 08:49:55.2106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e154112b-ef53-436a-fb08-08d6ea5bf314
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA1LTMxIGF0IDE3OjExIC0wMzAwLCBMdWNhcyBPc2hpcm8gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBDb252ZXJ0IHRoZSBvbGQgZGV2aWNlIHRyZWUgZG9jdW1l
bnRhdGlvbiB0byB5YW1sIGZvcm1hdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIE9zaGly
byA8bHVjYXNzZWlraW9zaGlyb0BnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJvZHJpZ28g
UmliZWlybyA8cm9kcmlnb3JzZGNAZ21haWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IFJvZHJp
Z28gUmliZWlybyA8cm9kcmlnb3JzZGNAZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogTWF0aGV1
cyBUYXZhcmVzIDxtYXRoZXVzLmJlcm5hcmRpbm9AdXNwLmJyPg0KPiBSZXZpZXdlZC1ieTogTWFy
Y2VsbyBTY2htaXR0IDxtYXJjZWxvLnNjaG1pdHQxQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4g
LS0tDQo+IFYyOg0KPiAgICAgLSBVcGRhdGUgTUFJTlRBSU5FUlMgZmlsZQ0KPiAgICAgLSBSZW1v
dmUgZGVzY3JpcHRpb24gZmllbGQgZm9yIHJlZyBhbmQgaW50ZXJydXB0cyBwcm9wZXJ0aWVzDQo+
ICAgICAtIEFkZCBpbnRlcnJ1cHRzIGFzIGEgcmVxdWlyZWQgcHJvcGVydHkNCj4gDQo+ICAuLi4v
YmluZGluZ3MvaWlvL2FjY2VsL2FkaSxhZHhsMzcyLnlhbWwgICAgICAgfCA2MyArKysrKysrKysr
KysrKysrKysrDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWR4bDM3Mi50
eHQgfCAzMyAtLS0tLS0tLS0tDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMiArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCsp
LCAzNCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaWlvL2FjY2VsL2FkaSxhZHhsMzcyLnlhbWwNCj4gIGRlbGV0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FjY2VsL2Fk
eGwzNzIudHh0DQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hY2NlbC9hZGksYWR4bDM3Mi55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9hY2NlbC9hZGksYWR4bDM3Mi55YW1sDQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uYTdmYWZiOWJmNWM2DQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hY2Nl
bC9hZGksYWR4bDM3Mi55YW1sDQo+IEBAIC0wLDAgKzEsNjMgQEANCj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9hY2NlbGVyb21ldGVycy9hZGksYWR4bDM3Mi55
YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBBRFhMMzcyIDMtQXhpcywgKy8t
KDIwMGcpIERpZ2l0YWwgQWNjZWxlcm9tZXRlcg0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAg
LSBTdGVmYW4gUG9wYSA8c3RlZmFuLnBvcGFAYW5hbG9nLmNvbT4NCj4gKw0KPiArZGVzY3JpcHRp
b246IHwNCj4gKyAgQW5hbG9nIERldmljZXMgQURYTDM3MiAzLUF4aXMsICsvLSgyMDBnKSBEaWdp
dGFsIEFjY2VsZXJvbWV0ZXIgdGhhdCBzdXBwb3J0cw0KPiArICBib3RoIEkyQyAmIFNQSSBpbnRl
cmZhY2VzDQo+ICsgICAgaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9lbi9wcm9kdWN0cy9hZHhsMzcy
Lmh0bWwNCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBlbnVt
Og0KPiArICAgICAgLSBhZGksYWR4bDM3Mg0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVt
czogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiAr
cmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGludGVycnVw
dHMNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ICsgICAgICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gKyAgICAgICAgaTJjMCB7DQo+ICsgICAgICAg
ICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsgICAgICAgICAgICAgICAgI3NpemUt
Y2VsbHMgPSA8MD47DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAvKiBFeGFtcGxlIGZvciBhIEky
QyBkZXZpY2Ugbm9kZSAqLw0KPiArICAgICAgICAgICAgICAgIGFjY2VsZXJvbWV0ZXJANTMgew0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWR4bDM3MiI7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHg1Mz47DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvPjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIGludGVycnVwdHMgPSA8MjUgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gKyAg
ICAgICAgICAgICAgICB9Ow0KPiArICAgICAgICB9Ow0KPiArICAtIHwNCj4gKyAgICAgICAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiArICAgICAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ICsgICAgICAgIHNwaTAgew0K
PiArICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAgICAg
ICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAgYWNjZWxlcm9t
ZXRlckAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFk
eGwzNzIiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMD47DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvPjsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MjUgSVJRX1RZUEVfRURHRV9GQUxMSU5H
PjsNCj4gKyAgICAgICAgICAgICAgICB9Ow0KPiArICAgICAgICB9Ow0KPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hY2NlbC9hZHhsMzcyLnR4dA0K
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWR4bDM3Mi50
eHQNCj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IGEyODk5NjQ3NTZhNy4uMDAw
MDAwMDAwMDAwDQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
YWNjZWwvYWR4bDM3Mi50eHQNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSwzMyArMCwwIEBADQo+
IC1BbmFsb2cgRGV2aWNlcyBBRFhMMzcyIDMtQXhpcywgKy8tKDIwMGcpIERpZ2l0YWwgQWNjZWxl
cm9tZXRlcg0KPiAtDQo+IC1odHRwOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2Fs
LWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvYWR4bDM3Mi5wZGYNCj4gLQ0KPiAtUmVxdWlyZWQg
cHJvcGVydGllczoNCj4gLSAtIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgImFkaSxhZHhsMzcyIg0K
PiAtIC0gcmVnOiB0aGUgSTJDIGFkZHJlc3Mgb3IgU1BJIGNoaXAgc2VsZWN0IG51bWJlciBmb3Ig
dGhlIGRldmljZQ0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBTUEkgYnVzIHVzYWdl
Og0KPiAtIC0gc3BpLW1heC1mcmVxdWVuY3k6IE1heCBTUEkgZnJlcXVlbmN5IHRvIHVzZQ0KPiAt
DQo+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiAtIC0gaW50ZXJydXB0czogaW50ZXJydXB0IG1h
cHBpbmcgZm9yIElSUSBhcyBkb2N1bWVudGVkIGluDQo+IC0gICBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaW50ZXJydXB0cy50eHQNCj4gLQ0K
PiAtRXhhbXBsZSBmb3IgYSBJMkMgZGV2aWNlIG5vZGU6DQo+IC0NCj4gLSAgICAgICBhY2NlbGVy
b21ldGVyQDUzIHsNCj4gLSAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFkeGwzNzIi
Ow0KPiAtICAgICAgICAgICAgICAgcmVnID0gPDB4NTM+Ow0KPiAtICAgICAgICAgICAgICAgaW50
ZXJydXB0LXBhcmVudCA9IDwmZ3Bpbz47DQo+IC0gICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0g
PDI1IElSUV9UWVBFX0VER0VfRkFMTElORz47DQo+IC0gICAgICAgfTsNCj4gLQ0KPiAtRXhhbXBs
ZSBmb3IgYSBTUEkgZGV2aWNlIG5vZGU6DQo+IC0NCj4gLSAgICAgICBhY2NlbGVyb21ldGVyQDAg
ew0KPiAtICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWR4bDM3MiI7DQo+IC0gICAg
ICAgICAgICAgICByZWcgPSA8MD47DQo+IC0gICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5j
eSA9IDwxMDAwMDAwPjsNCj4gLSAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8Jmdw
aW8+Ow0KPiAtICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwyNSBJUlFfVFlQRV9FREdFX0ZB
TExJTkc+Ow0KPiAtICAgICAgIH07DQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5U
QUlORVJTDQo+IGluZGV4IDQzYTljZWJiMmMxOS4uMDZjY2E3Y2Q5NjI3IDEwMDY0NA0KPiAtLS0g
YS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtNTU5LDcgKzU1OSw3IEBA
IFM6ICBTdXBwb3J0ZWQNCj4gIEY6ICAgICBkcml2ZXJzL2lpby9hY2NlbC9hZHhsMzcyLmMNCj4g
IEY6ICAgICBkcml2ZXJzL2lpby9hY2NlbC9hZHhsMzcyX3NwaS5jDQo+ICBGOiAgICAgZHJpdmVy
cy9paW8vYWNjZWwvYWR4bDM3Ml9pMmMuYw0KPiAtRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWR4bDM3Mi50eHQNCj4gK0Y6ICAgICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FjY2VsL2FkaSxhZHhsMzcyLnlhbWwNCj4gDQo+
ICBBRjkwMTMgTUVESUEgRFJJVkVSDQo+ICBNOiAgICAgQW50dGkgUGFsb3NhYXJpIDxjcm9wZUBp
a2kuZmk+DQo+IC0tDQo+IDIuMjEuMA0KPiANCg==
