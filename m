Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 666D622EF2
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfETIcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 04:32:48 -0400
Received: from mail-eopbgr730085.outbound.protection.outlook.com ([40.107.73.85]:64810
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728819AbfETIcs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 May 2019 04:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SltFkiEmWMyofTKjjBwrqz0lYSxMjQAm+yK8/VwcAzY=;
 b=CeIQfsyw77vkM//cgP80oL/UdNbTKD3oDFGdmkjoN6TW1Y+EgXD8kZyfLamq2p4nl09ZiC6/cxLmK+KQ+mI4SbTsZ6U2yPGAhr4kGkfTplUag8GlQxek049Wl//lbMaKinB/pbKoofSa2uuyD4YKTpc9GzgXV5wCQ8f+JKGY+tI=
Received: from CY4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:903:33::34)
 by SN2PR03MB2271.namprd03.prod.outlook.com (2603:10b6:804:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Mon, 20 May
 2019 08:32:39 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by CY4PR03CA0024.outlook.office365.com
 (2603:10b6:903:33::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.18 via Frontend
 Transport; Mon, 20 May 2019 08:32:39 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Mon, 20 May 2019 08:32:38 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4K8Wawm015432
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 20 May 2019 01:32:36 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 20 May 2019 04:32:36 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Thread-Topic: [PATCH] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Thread-Index: AQHVDcrSZKi34xwBdkOXGhwXr4r5gKZylHQAgAFgCAA=
Date:   Mon, 20 May 2019 08:32:36 +0000
Message-ID: <5d7ad2935d1e357f1c0885badc5ce3c351c8ed89.camel@analog.com>
References: <9992a318aec777b9b7788bb40d976aa89e5963fe.1558219042.git.renatogeh@gmail.com>
         <20190519123208.26c864ce@archlinux>
In-Reply-To: <20190519123208.26c864ce@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <94BFAD9BDF5AC84E86370057D67D2A39@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(7736002)(70586007)(7636002)(8936002)(106002)(7416002)(86362001)(2486003)(305945005)(7696005)(6116002)(3846002)(8676002)(76176011)(50466002)(70206006)(23676004)(102836004)(356004)(2501003)(246002)(446003)(6246003)(4326008)(110136005)(26005)(54906003)(53376002)(436003)(11346002)(426003)(118296001)(5660300002)(36756003)(186003)(47776003)(316002)(14454004)(2616005)(336012)(478600001)(6306002)(229853002)(486006)(476003)(14444005)(126002)(966005)(2906002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2271;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33c60071-0dae-4f12-234f-08d6dcfdb820
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:SN2PR03MB2271;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2271:
X-MS-Exchange-PUrlCount: 7
X-Microsoft-Antispam-PRVS: <SN2PR03MB22712271EA90A39627175D80F9060@SN2PR03MB2271.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 004395A01C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: r9mBznTUEDhkjI49NK8RZSe6PP0+GtrErKv0OmhORJ9GhRyngqfau17vmBflVp/IANE16zoSFS9xpR6bFZmWJn3eXn136xx5VgM4Gbrl9i3OGGvOOKB3rfwhbbz4zZwIOFh1KPGCspzxBLY97vk7bbtOkq24ileCTK26qCQiNdyEjaJdfz4diXjOPTSFEa6BDeVKJNQRb5/+3PrcRom8EkiIsHizi2/3i8rSm64Z9A8ghC0mLbcIXGYp0hfYLWlnP5PgxhAfrjofJAD/Bkx3305u2RPYx3fzZsTgj/55sRvgIt7FtUhFCetIbg7DkLWUvzAzBFC1v6qiw8gWJ+zqRwG8mvFztWqvKsLjHE/JHmTGop3BLN6rcQ7yswBG8PtsVHrqaMf0VCyHnxAWPUoN5C+83o3A8twB9D6jZ/EUn7g=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2019 08:32:38.5147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c60071-0dae-4f12-234f-08d6dcfdb820
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2271
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTA1LTE5IGF0IDEyOjMyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gU2F0LCAxOCBNYXkgMjAxOSAxOTo0MToxMiAt
MDMwMA0KPiBSZW5hdG8gTHVpIEdlaCA8cmVuYXRvZ2VoQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IFRoaXMgcGF0Y2ggYWRkcyBhIFlBTUwgYmluZGluZyBmb3IgdGhlIEFuYWxvZyBEZXZpY2Vz
IEFENzc4MC8xIGFuZA0KPiA+IEFENzE3MC8xIGFuYWxvZy10by1kaWdpdGFsIGNvbnZlcnRlcnMu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFp
bC5jb20+DQo+IA0KPiBPbmUgY29tbWVudCBpbmxpbmUuICBJJ2xsIGFsc28gYmUgbmVlZGluZyBh
biBhY2sgZnJvbSBBbmFsb2cgb24gdGhpcywNCj4gcHJlZmVyYWJseSBNaWNoYWVsJ3MuDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvaWlv
L2FkYy9hZGksYWQ3NzgwLnR4dCAgICAgICAgICAgfCA0OCAtLS0tLS0tLS0tLQ0KPiA+ICAuLi4v
YmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3NzgwLnlhbWwgICAgICAgICAgfCA4NSArKysrKysrKysr
KysrKysrKysrDQoNCllvdSBzaG91bGQgYWxzbyB1cGRhdGUgdGhlIE1BSU5UQUlORVJTIGZpbGUu
DQpNYXliZSBpbiBhIGZvbGxvd2luZyBwYXRjaC4NCkl0IGxvb2tzIGxpa2UgdGhlcmUgaXMgbm90
IGVudHJ5IGluIHRoZXJlLCBzbyBtYXliZSB5b3UgbmVlZCB0byBhZGQgYSBuZXcNCm9uZS4NCg0K
U29tZXRoaW5nIGxpa2U6DQoNCg0KQU5BTE9HIERFVklDRVMgSU5DIEFENzc4MCBEUklWRVINCk06
ICAgICAgTWljaGFlbCBIZW5uZXJpY2ggPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+DQpN
OiAgICAgIFJlbmF0byBMdWkgR2VoIDxyZW5hdG9nZWhAZ21haWwuY29tPg0KTDogICAgICBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnDQpXOiAgICAgIGh0dHA6Ly9lei5hbmFsb2cuY29tL2NvbW11
bml0eS9saW51eC1kZXZpY2UtZHJpdmVycw0KUzogICAgICBTdXBwb3J0ZWQNCkY6ICAgICAgZHJp
dmVycy9paW8vYWRjL2FkNzc4MC5jDQpGOiAgICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9paW8vYWRjL2FkaSxhZDc3ODAueWFtbA0KDQpUaGlzIHNob3VsZCBiZSBhZnRlciB0
aGlzIGJsb2NrDQpBTkFMT0cgREVWSUNFUyBJTkMgQUQ3NzY4LTEgRFJJVkVSDQoNCk5vdGUgdGhh
dCBJIGFkZGVkIHlvdSBhcyBhIGNvLW1haW50YWluZXIuDQpJZiB5b3Ugd2FudCwgeW91IGRvIG5v
dCBuZWVkIHRvIGFkZCB0aGF0IGxpbmUuDQoNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4NSBpbnNl
cnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0DQo+ID4g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGFkNzc4MC50eHQN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hZGMvYWRpLGFkNzc4MC55YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc3ODAudHh0DQo+
ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3Nzgw
LnR4dA0KPiA+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDQ0MGU1MjU1NTM0
OS4uMDAwMDAwMDAwMDAwDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2lpby9hZGMvYWRpLGFkNzc4MC50eHQNCj4gPiArKysgL2Rldi9udWxsDQo+ID4gQEAgLTEs
NDggKzAsMCBAQA0KPiA+IC0qIEFuYWxvZyBEZXZpY2VzIEFENzE3MC9BRDcxNzEvQUQ3NzgwL0FE
Nzc4MQ0KPiA+IC0NCj4gPiAtRGF0YSBzaGVldHM6DQo+ID4gLQ0KPiA+IC0tIEFENzE3MDoNCj4g
PiAtICAgICAqIA0KPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2Fs
LWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvQUQ3MTcwLnBkZg0KPiA+IC0tIEFENzE3MToNCj4g
PiAtICAgICAqIA0KPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2Fs
LWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvQUQ3MTcxLnBkZg0KPiA+IC0tIEFENzc4MDoNCj4g
PiAtICAgICAqIA0KPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2Fs
LWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvYWQ3NzgwLnBkZg0KPiA+IC0tIEFENzc4MToNCj4g
PiAtICAgICAqIA0KPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2Fs
LWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvQUQ3NzgxLnBkZg0KPiA+IC0NCj4gPiAtUmVxdWly
ZWQgcHJvcGVydGllczoNCj4gPiAtDQo+ID4gLS0gY29tcGF0aWJsZTogc2hvdWxkIGJlIG9uZSBv
Zg0KPiA+IC0gICAgICogImFkaSxhZDcxNzAiDQo+ID4gLSAgICAgKiAiYWRpLGFkNzE3MSINCj4g
PiAtICAgICAqICJhZGksYWQ3NzgwIg0KPiA+IC0gICAgICogImFkaSxhZDc3ODEiDQo+ID4gLS0g
cmVnOiBzcGkgY2hpcCBzZWxlY3QgbnVtYmVyIGZvciB0aGUgZGV2aWNlDQo+ID4gLS0gdnJlZi1z
dXBwbHk6IHRoZSByZWd1bGF0b3Igc3VwcGx5IGZvciB0aGUgQURDIHJlZmVyZW5jZSB2b2x0YWdl
DQo+ID4gLQ0KPiA+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+IC0NCj4gPiAtLSBwb3dlcmRv
d24tZ3Bpb3M6ICBtdXN0IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBQRFJT
VA0KPiA+IHBpbi4gSWYNCj4gPiAtICAgICAgICAgICAgICAgICBzcGVjaWZpZWQsIGl0IHdpbGwg
YmUgYXNzZXJ0ZWQgZHVyaW5nIGRyaXZlciBwcm9iZS4NCj4gPiBBcyB0aGUNCj4gPiAtICAgICAg
ICAgICAgICAgICBsaW5lIGlzIGFjdGl2ZSBoaWdoLCBpdCBzaG91bGQgYmUgbWFya2VkDQo+ID4g
R1BJT19BQ1RJVkVfSElHSC4NCj4gPiAtLSBhZGksZ2Fpbi1ncGlvczogICBtdXN0IGJlIHRoZSBk
ZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBHQUlODQo+ID4gcGluLiBPbmx5IGZvcg0KPiA+
IC0gICAgICAgICAgICAgICAgIHRoZSBhZDc3OHggY2hpcHMuIElmIHNwZWNpZmllZCwgaXQgd2ls
bCBiZSBhc3NlcnRlZA0KPiA+IGR1cmluZw0KPiA+IC0gICAgICAgICAgICAgICAgIGRyaXZlciBw
cm9iZS4gQXMgdGhlIGxpbmUgaXMgYWN0aXZlIGxvdywgaXQgc2hvdWxkIGJlDQo+ID4gbWFya2Vk
DQo+ID4gLSAgICAgICAgICAgICAgICAgR1BJT19BQ1RJVkVfTE9XLg0KPiA+IC0tIGFkaSxmaWx0
ZXItZ3Bpb3M6IG11c3QgYmUgdGhlIGRldmljZSB0cmVlIGlkZW50aWZpZXIgb2YgdGhlIEZJTFRF
Ug0KPiA+IHBpbi4gT25seQ0KPiA+IC0gICAgICAgICAgICAgICAgIGZvciB0aGUgYWQ3Nzh4IGNo
aXBzLiBJZiBzcGVjaWZpZWQsIGl0IHdpbGwgYmUNCj4gPiBhc3NlcnRlZA0KPiA+IC0gICAgICAg
ICAgICAgICAgIGR1cmluZyBkcml2ZXIgcHJvYmUuIEFzIHRoZSBsaW5lIGlzIGFjdGl2ZSBsb3cs
IGl0DQo+ID4gc2hvdWxkIGJlDQo+ID4gLSAgICAgICAgICAgICAgICAgbWFya2VkIEdQSU9fQUNU
SVZFX0xPVy4NCj4gPiAtDQo+ID4gLUV4YW1wbGU6DQo+ID4gLQ0KPiA+IC1hZGNAMCB7DQo+ID4g
LSAgICAgY29tcGF0aWJsZSA9ICAiYWRpLGFkNzc4MCI7DQo+ID4gLSAgICAgcmVnID0gICAgICAg
ICA8MD47DQo+ID4gLSAgICAgdnJlZi1zdXBwbHkgPSA8JnZkZF9zdXBwbHk+DQo+ID4gLQ0KPiA+
IC0gICAgIHBvd2VyZG93bi1ncGlvcyAgPSA8JmdwaW8gMTIgR1BJT19BQ1RJVkVfSElHSD47DQo+
ID4gLSAgICAgYWRpLGdhaW4tZ3Bpb3MgICA9IDwmZ3BpbyAgNSBHUElPX0FDVElWRV9MT1c+Ow0K
PiA+IC0gICAgIGFkaSxmaWx0ZXItZ3Bpb3MgPSA8JmdwaW8gMTUgR1BJT19BQ1RJVkVfTE9XPjsN
Cj4gPiAtfTsNCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2lpby9hZGMvYWRpLGFkNzc4MC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3NzgwLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTMxYmM0ZjhlYzA0DQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRj
L2FkaSxhZDc3ODAueWFtbA0KPiA+IEBAIC0wLDAgKzEsODUgQEANCj4gPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaWlvL2FkYy9hZGksYWQ3NzgwLnlhbWwj
DQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IEFuYWxvZyBEZXZpY2VzIEFENzE3MC9BRDcxNzEvQUQ3
NzgwL0FENzc4MSBhbmFsb2cgdG8gZGlnaXRhbA0KPiA+IGNvbnZlcnRlcnMNCj4gPiArDQo+ID4g
K21haW50YWluZXJzOg0KPiA+ICsgIC0gTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVy
aWNoQGFuYWxvZy5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIFRoZSBh
ZDc3ODAgaXMgYSBzaWdtYS1kZWx0YSBhbmFsb2cgdG8gZGlnaXRhbCBjb252ZXJ0ZXIuIFRoaXMg
ZHJpdmVyDQo+ID4gcHJvdmlkZXMNCj4gPiArICByZWFkaW5nIHZvbHRhZ2UgdmFsdWVzIGFuZCBz
dGF0dXMgYml0cyBmcm9tIGJvdGggdGhlIGFkNzc4eCBhbmQNCj4gPiBhZDcxN3ggc2VyaWVzLg0K
PiA+ICsgIEl0cyBpbnRlcmZhY2UgYWxzbyBhbGxvd3Mgd3JpdGluZyBvbiB0aGUgRklMVEVSIGFu
ZCBHQUlOIEdQSU8gcGlucw0KPiA+IG9uIHRoZQ0KPiA+ICsgIGFkNzc4eC4NCj4gPiArDQo+ID4g
KyAgU3BlY2lmaWNhdGlvbnMgb24gdGhlIGNvbnZlcnRlcnMgY2FuIGJlIGZvdW5kIGF0Og0KPiA+
ICsgICAgQUQ3MTcwOg0KPiA+ICsgICAgICANCj4gPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21l
ZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzL0FENzE3MC5wZGYNCj4g
PiArICAgIEFENzE3MToNCj4gPiArICAgICAgDQo+ID4gaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9t
ZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRhLXNoZWV0cy9BRDcxNzEucGRmDQo+
ID4gKyAgICBBRDc3ODA6DQo+ID4gKyAgICAgIA0KPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20v
bWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvYWQ3NzgwLnBkZg0K
PiA+ICsgICAgQUQ3NzgxOg0KPiA+ICsgICAgICANCj4gPiBodHRwczovL3d3dy5hbmFsb2cuY29t
L21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzL0FENzc4MS5wZGYN
Cj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVu
dW06DQo+ID4gKyAgICAgIC0gYWRpLGFkNzE3MA0KPiA+ICsgICAgICAtIGFkaSxhZDcxNzENCj4g
PiArICAgICAgLSBhZGksYWQ3NzgwDQo+ID4gKyAgICAgIC0gYWRpLGFkNzc4MQ0KPiA+ICsNCj4g
PiArICByZWc6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgQ2hpcCBzZWxlY3Qg
bnVtYmVyIGZvciB0aGUgZGV2aWNlDQoNCk5vIG5lZWQgdG8gYWRkIGEgZGVzY3JpcHRpb24uDQpU
aGlzIGlzIHByZXR0eSBzdGFuZGFyZC4NCg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+
ID4gKyAgdnJlZi1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhl
IHJlZ3VsYXRvciBzdXBwbHkgZm9yIHRoZSBBREMgcmVmZXJlbmNlIHZvbHRhZ2UNCj4gPiArICAg
IG1heEl0ZW1zOiAxDQo+ID4gKw0KDQpBcyBJIHNlZSBpbiB0aGUgZHJpdmVyLCBpdCdzIG5vdCB2
cmVmLXN1cHBseSwgaXQncyBhdmRkLXN1cHBseS4NCg0KPiA+ICsgIHBvd2VyZG93bi1ncGlvczoN
Cj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBNdXN0IGJlIHRoZSBkZXZpY2UgdHJl
ZSBpZGVudGlmaWVyIG9mIHRoZSBQRFJTVCBwaW4uIElmDQo+ID4gKyAgICAgIHNwZWNpZmllZCwg
aXQgd2lsbCBiZSBhc3NlcnRlZCBkdXJpbmcgZHJpdmVyIHByb2JlLiBBcyB0aGUNCj4gPiArICAg
ICAgbGluZSBpcyBhY3RpdmUgaGlnaCwgaXQgc2hvdWxkIGJlIG1hcmtlZCBHUElPX0FDVElWRV9I
SUdILg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgYWRpLGdhaW4tZ3Bpb3M6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgTXVzdCBiZSB0aGUgZGV2aWNlIHRy
ZWUgaWRlbnRpZmllciBvZiB0aGUgR0FJTiBwaW4uIE9ubHkgZm9yDQo+ID4gKyAgICAgIHRoZSBh
ZDc3OHggY2hpcHMuIElmIHNwZWNpZmllZCwgaXQgd2lsbCBiZSBhc3NlcnRlZCBkdXJpbmcNCj4g
PiArICAgICAgZHJpdmVyIHByb2JlLiBBcyB0aGUgbGluZSBpcyBhY3RpdmUgbG93LCBpdCBzaG91
bGQgYmUgbWFya2VkDQo+ID4gKyAgICAgIEdQSU9fQUNUSVZFX0xPVy4NCj4gPiArICAgIG1heEl0
ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGFkaSxmaWx0ZXItZ3Bpb3M6DQo+ID4gKyAgICBkZXNjcmlw
dGlvbjoNCj4gPiArICAgICAgTXVzdCBiZSB0aGUgZGV2aWNlIHRyZWUgaWRlbnRpZmllciBvZiB0
aGUgRklMVEVSIHBpbi4gT25seQ0KPiA+ICsgICAgICBmb3IgdGhlIGFkNzc4eCBjaGlwcy4gSWYg
c3BlY2lmaWVkLCBpdCB3aWxsIGJlIGFzc2VydGVkDQo+ID4gKyAgICAgIGR1cmluZyBkcml2ZXIg
cHJvYmUuIEFzIHRoZSBsaW5lIGlzIGFjdGl2ZSBsb3csIGl0IHNob3VsZCBiZQ0KPiA+ICsgICAg
ICBtYXJrZWQgR1BJT19BQ1RJVkVfTE9XLg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+
ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAg
LSB2cmVmLXN1cHBseQ0KPiANCj4gSXMgdGhhdCBhY3R1YWxseSB0cnVlPyAgSSdkIGltYWdpbmUg
aXQnbGwgdXNlIGEgc3R1YiByZWd1bGF0b3IgaWYNCj4gaXQgaXNuJ3Qgc3VwcGxpZWQuDQoNCkht
bSwgSSBhbHNvIHRoaW5rIHRoaXMgY2FuIGJlIG9taXR0ZWQgYXMgcmVxdWlyZWQuDQpkZXZtX3Jl
Z3VsYXRvcl9nZXQoKSBpcyB1c2VkLg0KZGV2bV9yZWd1bGF0b3JfZ2V0X2V4Y2x1c2l2ZSgpIHdv
dWxkIGJlIG5lZWRlZCB0byBtYWtlIHRoaXMgcmVxdWlyZWQuDQoNCj4gDQo+ID4gKw0KPiA+ICtl
eGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlv
L2dwaW8uaD4NCj4gPiArICAgIGFkY0AwIHsNCg0KVGhlIGFkY0AwIGJsb2NrIHNob3VsZCBiZSBp
bmNsdWRlZCBpbiBhIHNwaSBibG9jay4NCg0KU28sIHNvbWV0aGluZyBsaWtlDQoNCnNwaTAgew0K
ICAgICBhZGNAMCB7DQogICAgICAgICAgICBjb21wYXRpYmxlID0gICJhZGksYWQ3NzgwIjsNCiAg
ICAgICAgICAgIHJlZyA9ICAgICAgICAgPDA+Ow0KICAgICAgICAgICAgYXZkZC1zdXBwbHkgPSA8
JnZkZF9zdXBwbHk+DQoNCiAgICAgICAgICAgIHBvd2VyZG93bi1ncGlvcyAgPSA8JmdwaW8gMTIg
R1BJT19BQ1RJVkVfSElHSD47DQogICAgICAgICAgICBhZGksZ2Fpbi1ncGlvcyAgID0gPCZncGlv
ICA1IEdQSU9fQUNUSVZFX0xPVz47DQogICAgICAgICAgICBhZGksZmlsdGVyLWdwaW9zID0gPCZn
cGlvIDE1IEdQSU9fQUNUSVZFX0xPVz47DQogICAgIH07DQp9Ow0KDQpJIGtub3cgdGhpcyB3YXNu
J3QgdGhlIGNhc2UgYmVmb3JlLCBidXQgaXQgc2hvdWxkIGJlIChmcm9tIHdoYXQgSSByZWNhbGwp
Lg0KDQo+ID4gKyAgICAgIGNvbXBhdGlibGUgPSAgImFkaSxhZDc3ODAiOw0KPiA+ICsgICAgICBy
ZWcgPSA8MD47DQo+ID4gKyAgICAgIHZyZWYtc3VwcGx5ID0gPCZ2ZGRfc3VwcGx5PjsNCj4gPiAr
DQo+ID4gKyAgICAgIHBvd2VyZG93bi1ncGlvcyAgPSA8JmdwaW8wIDEyIEdQSU9fQUNUSVZFX0hJ
R0g+Ow0KPiA+ICsgICAgICBhZGksZ2Fpbi1ncGlvcyAgID0gPCZncGlvMSAgNSBHUElPX0FDVElW
RV9MT1c+Ow0KPiA+ICsgICAgICBhZGksZmlsdGVyLWdwaW9zID0gPCZncGlvMiAxNSBHUElPX0FD
VElWRV9MT1c+Ow0KDQpSZXN0IGxvb2tzIGdvb2QuDQoNClRoYW5rcw0KQWxleA0KDQo+ID4gKyAg
ICB9Ow0KPiANCj4gDQo=
