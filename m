Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B533728C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfFFLOD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 07:14:03 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:54240
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbfFFLOD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jun 2019 07:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI74nD7KRye9xHaTcbOo+4UWxTporcUtYbjDdTHOiuE=;
 b=qg4ZEC7VG7Y/tnZPdccSV2DTxgN5xqSoihQv5+ohMOiDc/oVMrlwkZ9MnWMF1M8JVXKIWSkMv2Y7qfGMe0viFb1OkiFUPk3bSV9EdHisfns5HCiqKuSkj4o3TST/maU/VgyuRJbbFiYPLCnApiMvDueQpmwIjfn24ySB+T5wNmY=
Received: from BN6PR03CA0064.namprd03.prod.outlook.com (2603:10b6:404:4c::26)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Thu, 6 Jun
 2019 11:13:57 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR03CA0064.outlook.office365.com
 (2603:10b6:404:4c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14 via Frontend
 Transport; Thu, 6 Jun 2019 11:13:56 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 11:13:54 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x56BDr2L029599
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Jun 2019 04:13:53 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 6 Jun 2019 07:13:53 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml
 binding
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml
 binding
Thread-Index: AQHVEpjnzzdTbL78DUqRDpYuJzSJpqZ94POAgA/5dgCAAPVLAA==
Date:   Thu, 6 Jun 2019 11:13:52 +0000
Message-ID: <d70b1ffcc903495cd5eac04e17fd1600e67b9c53.camel@analog.com>
References: <cover.1558746978.git.renatogeh@gmail.com>
         <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
         <20190526173911.57ae3d11@archlinux>
         <20190605203554.podktlonhp527iqq@renatolg>
In-Reply-To: <20190605203554.podktlonhp527iqq@renatolg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC1375F4AEF94D4CB95D2D64378F66F1@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(50466002)(106002)(8676002)(8936002)(336012)(6116002)(6306002)(118296001)(436003)(5660300002)(476003)(26005)(3846002)(70206006)(14454004)(486006)(47776003)(426003)(7416002)(2501003)(23676004)(186003)(2486003)(478600001)(76176011)(7696005)(102836004)(229853002)(966005)(246002)(14444005)(126002)(53376002)(86362001)(110136005)(356004)(6246003)(316002)(70586007)(11346002)(7636002)(7736002)(2616005)(446003)(2906002)(305945005)(36756003)(4326008)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c735c048-131a-4aee-74dd-08d6ea7010b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-MS-Exchange-PUrlCount: 6
X-Microsoft-Antispam-PRVS: <BL2PR03MB545E46165CFF1A78F66A284F9170@BL2PR03MB545.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Q2/Xow+6YdWcPsdwbqXfco4H54AO5XUbXHSFJ06kpYQwO//PDk3n6nc8MsvZpwoiDOce12DEpaRQPeUKmMWUG9TrCdSRf3jqbexivWSaoKhW6PpUAQcK9BhliCK6ySabKIIGy1CFu/ZPl7lJxil9cu+Drvq2vESbRQqc2LSURH+rGff7wzqpkF8rndnBPCpGAohWy/VRF77f0zsjTyzXnwt8s+hMf9MyVwrRyIHlEsBtiEWnUCK3TGN6hlhrLfg3Rck1eEv4OJLgw2xAXrkjpAhEj7fAeFKatCrunvvf7IFx6j4ATi5IBRtVRFtr2CfYl7ic74yk/1blfHvZ4LxNkyHtpjnv+YExb6XaJN4PL1DzNJJ2LjeB9pUdBI8ADZoLOje1FEi/Zgf2uIEajBm7EKeQjTxzUplq6w0xnAO0xeM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 11:13:54.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c735c048-131a-4aee-74dd-08d6ea7010b5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTA1IGF0IDE3OjM1IC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gDQo+IE9uIDA1LzI2LCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiA+IE9uIEZyaSwgMjQgTWF5IDIwMTkgMjI6MjY6MzAgLTAzMDANCj4gPiBSZW5hdG8gTHVp
IEdlaCA8cmVuYXRvZ2VoQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBUaGlzIHBhdGNo
IGFkZHMgYSBZQU1MIGJpbmRpbmcgZm9yIHRoZSBBbmFsb2cgRGV2aWNlcyBBRDc3ODAvMSBhbmQN
Cj4gPiA+IEFENzE3MC8xIGFuYWxvZy10by1kaWdpdGFsIGNvbnZlcnRlcnMuDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFJlbmF0byBMdWkgR2VoIDxyZW5hdG9nZWhAZ21haWwuY29tPg0K
PiA+IExvb2tzIGdvb2QgdG8gbWUsIGJ1dCBJJ20gc3RpbGwgZmluZGluZyBteSBmZWV0IHdpdGgg
dGhlc2Ugc28gd2lsbA0KPiA+IGxlYXZlIGl0IGZvciBhIGZldyBkYXlzIGZvciBvdGhlcnMgdG8g
aGF2ZSB0aW1lIHRvIGNvbW1lbnQuDQo+ID4gDQo+ID4gTWljaGFlbCwgbG9va2luZyBmb3IgYSBx
dWljayByZXBseSBmcm9tIHlvdSB0byBzYXkgaWYgeW91IGFyZSBoYXBweQ0KPiA+IGJlaW5nIGV4
cGxpY2l0bHkgbGlzdGVkIGFzIG1haW50YWluZXIgZm9yIHRoaXMgb25lLCBvciBpZiB5b3UnZA0K
PiA+IHJhdGhlciBsYW5kIGl0IG9uIHNvbWVvbmUgZWxzZS4gIFNhbWUgYXBwbGllcyBmb3IgcGF0
Y2ggMi4NCj4gPiANCj4gPiBSZW5hdG8sIGlmIEkgc2VlbSB0byBoYXZlIGZvcmdvdHRlbiB0aGlz
IGluIGEgd2VlayBvciBzbywgZmVlbA0KPiA+IGZyZWUgdG8gZ2l2ZSBtZSBhIHBva2UuIEkndmUg
YmVlbiBrbm93biB0byBsb29zZSBwYXRjaGVzIGVudGlyZWx5IQ0KPiANCj4gSGkgSm9uYXRoYW4s
DQo+IA0KPiBKdXN0IGhlcmUgdG8gZ2l2ZSB5b3UgYSBwb2tlLiA6KQ0KPiANCj4gQnkgdGhlIHdh
eSwgaW4gdGhlc2UgY2FzZXMsIHdoaWNoIHdvdWxkIGJlIGVhc2llciBmb3IgeW91PyBUbyBzZW5k
IHlvdQ0KPiBhbiBlbWFpbCBsaWtlIEknbSBkb2luZyByaWdodCBub3cgb24gbGFzdCB3ZWVrJ3Mg
dGhyZWFkOyBvciB0byByZXNlbmQNCj4gdGhlIGVudGlyZSBwYXRjaChzZXQpPw0KPiANCg0KSSB0
aGluayBpbiB0aGlzIGNhc2UsIG1heWJlIGxldCdzIHdhaXQgYSBiaXQgbG9uZ2VyLg0KSm9uYXRo
YW4gaGFzIG5vdCBiZWVuIGFjdGl2ZSByZWNlbnRseS4NCg0KSSB0aGluayBhIFtSRVNFTkRdIHdv
dWxkIGJlIGEgZ29vZCBpZGVhIHdoZW4gaGUgZ2V0cyBiYWNrL2FjdGl2ZSBhbmQgbWlzc2VzIHlv
dXIgcGF0Y2hzZXQuDQoNClRoYW5rcw0KQWxleA0KDQo+IFRoYW5rcywNCj4gUmVuYXRvDQo+ID4g
VGhhbmtzLA0KPiA+IA0KPiA+IEpvbmF0aGFuDQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgaW4g
djI6DQo+ID4gPiAgLSB2cmVmLXN1cHBseSB0byBhdmRkLXN1cHBseQ0KPiA+ID4gIC0gcmVtb3Zl
IGF2ZGQtc3VwcGx5IGZyb20gcmVxdWlyZWQgbGlzdA0KPiA+ID4gIC0gaW5jbHVkZSBhZGMgYmxv
Y2sgaW4gYW4gc3BpIGJsb2NrDQo+ID4gPiANCj4gPiA+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9h
ZGksYWQ3NzgwLnR4dCAgICAgICAgICAgfCA0OCAtLS0tLS0tLS0tDQo+ID4gPiAgLi4uL2JpbmRp
bmdzL2lpby9hZGMvYWRpLGFkNzc4MC55YW1sICAgICAgICAgIHwgODcgKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRp
b25zKC0pDQo+ID4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc3ODAudHh0DQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc3ODAu
eWFtbA0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9hZGMvYWRpLGFkNzc4MC50eHQNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGFkNzc4MC50eHQNCj4gPiA+IGRlbGV0ZWQg
ZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggNDQwZTUyNTU1MzQ5Li4wMDAwMDAwMDAwMDAN
Cj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2Fk
aSxhZDc3ODAudHh0DQo+ID4gPiArKysgL2Rldi9udWxsDQo+ID4gPiBAQCAtMSw0OCArMCwwIEBA
DQo+ID4gPiAtKiBBbmFsb2cgRGV2aWNlcyBBRDcxNzAvQUQ3MTcxL0FENzc4MC9BRDc3ODENCj4g
PiA+IC0NCj4gPiA+IC1EYXRhIHNoZWV0czoNCj4gPiA+IC0NCj4gPiA+IC0tIEFENzE3MDoNCj4g
PiA+IC0gICAgKiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1
bWVudGF0aW9uL2RhdGEtc2hlZXRzL0FENzE3MC5wZGYNCj4gPiA+IC0tIEFENzE3MToNCj4gPiA+
IC0gICAgKiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVu
dGF0aW9uL2RhdGEtc2hlZXRzL0FENzE3MS5wZGYNCj4gPiA+IC0tIEFENzc4MDoNCj4gPiA+IC0g
ICAgKiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0
aW9uL2RhdGEtc2hlZXRzL2FkNzc4MC5wZGYNCj4gPiA+IC0tIEFENzc4MToNCj4gPiA+IC0gICAg
KiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9u
L2RhdGEtc2hlZXRzL0FENzc4MS5wZGYNCj4gPiA+IC0NCj4gPiA+IC1SZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPiA+ID4gLQ0KPiA+ID4gLS0gY29tcGF0aWJsZTogc2hvdWxkIGJlIG9uZSBvZg0KPiA+
ID4gLSAgICAqICJhZGksYWQ3MTcwIg0KPiA+ID4gLSAgICAqICJhZGksYWQ3MTcxIg0KPiA+ID4g
LSAgICAqICJhZGksYWQ3NzgwIg0KPiA+ID4gLSAgICAqICJhZGksYWQ3NzgxIg0KPiA+ID4gLS0g
cmVnOiBzcGkgY2hpcCBzZWxlY3QgbnVtYmVyIGZvciB0aGUgZGV2aWNlDQo+ID4gPiAtLSB2cmVm
LXN1cHBseTogdGhlIHJlZ3VsYXRvciBzdXBwbHkgZm9yIHRoZSBBREMgcmVmZXJlbmNlIHZvbHRh
Z2UNCj4gPiA+IC0NCj4gPiA+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ID4gLQ0KPiA+ID4g
LS0gcG93ZXJkb3duLWdwaW9zOiAgbXVzdCBiZSB0aGUgZGV2aWNlIHRyZWUgaWRlbnRpZmllciBv
ZiB0aGUgUERSU1QgcGluLiBJZg0KPiA+ID4gLSAgICAgICAgICAgICAgICBzcGVjaWZpZWQsIGl0
IHdpbGwgYmUgYXNzZXJ0ZWQgZHVyaW5nIGRyaXZlciBwcm9iZS4gQXMgdGhlDQo+ID4gPiAtICAg
ICAgICAgICAgICAgIGxpbmUgaXMgYWN0aXZlIGhpZ2gsIGl0IHNob3VsZCBiZSBtYXJrZWQgR1BJ
T19BQ1RJVkVfSElHSC4NCj4gPiA+IC0tIGFkaSxnYWluLWdwaW9zOiAgIG11c3QgYmUgdGhlIGRl
dmljZSB0cmVlIGlkZW50aWZpZXIgb2YgdGhlIEdBSU4gcGluLiBPbmx5IGZvcg0KPiA+ID4gLSAg
ICAgICAgICAgICAgICB0aGUgYWQ3Nzh4IGNoaXBzLiBJZiBzcGVjaWZpZWQsIGl0IHdpbGwgYmUg
YXNzZXJ0ZWQgZHVyaW5nDQo+ID4gPiAtICAgICAgICAgICAgICAgIGRyaXZlciBwcm9iZS4gQXMg
dGhlIGxpbmUgaXMgYWN0aXZlIGxvdywgaXQgc2hvdWxkIGJlIG1hcmtlZA0KPiA+ID4gLSAgICAg
ICAgICAgICAgICBHUElPX0FDVElWRV9MT1cuDQo+ID4gPiAtLSBhZGksZmlsdGVyLWdwaW9zOiBt
dXN0IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBGSUxURVIgcGluLiBPbmx5
DQo+ID4gPiAtICAgICAgICAgICAgICAgIGZvciB0aGUgYWQ3Nzh4IGNoaXBzLiBJZiBzcGVjaWZp
ZWQsIGl0IHdpbGwgYmUgYXNzZXJ0ZWQNCj4gPiA+IC0gICAgICAgICAgICAgICAgZHVyaW5nIGRy
aXZlciBwcm9iZS4gQXMgdGhlIGxpbmUgaXMgYWN0aXZlIGxvdywgaXQgc2hvdWxkIGJlDQo+ID4g
PiAtICAgICAgICAgICAgICAgIG1hcmtlZCBHUElPX0FDVElWRV9MT1cuDQo+ID4gPiAtDQo+ID4g
PiAtRXhhbXBsZToNCj4gPiA+IC0NCj4gPiA+IC1hZGNAMCB7DQo+ID4gPiAtICAgIGNvbXBhdGli
bGUgPSAgImFkaSxhZDc3ODAiOw0KPiA+ID4gLSAgICByZWcgPSAgICAgICAgIDwwPjsNCj4gPiA+
IC0gICAgdnJlZi1zdXBwbHkgPSA8JnZkZF9zdXBwbHk+DQo+ID4gPiAtDQo+ID4gPiAtICAgIHBv
d2VyZG93bi1ncGlvcyAgPSA8JmdwaW8gMTIgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4gPiAtICAg
IGFkaSxnYWluLWdwaW9zICAgPSA8JmdwaW8gIDUgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiA+IC0g
ICAgYWRpLGZpbHRlci1ncGlvcyA9IDwmZ3BpbyAxNSBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ID4g
LX07DQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9hZGMvYWRpLGFkNzc4MC55YW1sDQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc3ODAueWFtbA0KPiA+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDExMDk0MTY5NjNjDQo+ID4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aWlvL2FkYy9hZGksYWQ3NzgwLnlhbWwNCj4gPiA+IEBAIC0wLDAgKzEsODcgQEANCj4gPiA+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gPiArJVlBTUwgMS4yDQo+ID4g
PiArLS0tDQo+ID4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vYWRj
L2FkaSxhZDc3ODAueWFtbCMNCj4gPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiA+ICsNCj4gPiA+ICt0aXRsZTogQW5hbG9nIERl
dmljZXMgQUQ3MTcwL0FENzE3MS9BRDc3ODAvQUQ3NzgxIGFuYWxvZyB0byBkaWdpdGFsIGNvbnZl
cnRlcnMNCj4gPiA+ICsNCj4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+ICsgIC0gTWljaGFlbCBI
ZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gPiArDQo+ID4gPiAr
ZGVzY3JpcHRpb246IHwNCj4gPiA+ICsgIFRoZSBhZDc3ODAgaXMgYSBzaWdtYS1kZWx0YSBhbmFs
b2cgdG8gZGlnaXRhbCBjb252ZXJ0ZXIuIFRoaXMgZHJpdmVyIHByb3ZpZGVzDQo+ID4gPiArICBy
ZWFkaW5nIHZvbHRhZ2UgdmFsdWVzIGFuZCBzdGF0dXMgYml0cyBmcm9tIGJvdGggdGhlIGFkNzc4
eCBhbmQgYWQ3MTd4IHNlcmllcy4NCj4gPiA+ICsgIEl0cyBpbnRlcmZhY2UgYWxzbyBhbGxvd3Mg
d3JpdGluZyBvbiB0aGUgRklMVEVSIGFuZCBHQUlOIEdQSU8gcGlucyBvbiB0aGUNCj4gPiA+ICsg
IGFkNzc4eC4NCj4gPiA+ICsNCj4gPiA+ICsgIFNwZWNpZmljYXRpb25zIG9uIHRoZSBjb252ZXJ0
ZXJzIGNhbiBiZSBmb3VuZCBhdDoNCj4gPiA+ICsgICAgQUQ3MTcwOg0KPiA+ID4gKyAgICAgIGh0
dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vZGF0
YS1zaGVldHMvQUQ3MTcwLnBkZg0KPiA+ID4gKyAgICBBRDcxNzE6DQo+ID4gPiArICAgICAgaHR0
cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRh
LXNoZWV0cy9BRDcxNzEucGRmDQo+ID4gPiArICAgIEFENzc4MDoNCj4gPiA+ICsgICAgICBodHRw
czovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEt
c2hlZXRzL2FkNzc4MC5wZGYNCj4gPiA+ICsgICAgQUQ3NzgxOg0KPiA+ID4gKyAgICAgIGh0dHBz
Oi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vZGF0YS1z
aGVldHMvQUQ3NzgxLnBkZg0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBj
b21wYXRpYmxlOg0KPiA+ID4gKyAgICBlbnVtOg0KPiA+ID4gKyAgICAgIC0gYWRpLGFkNzE3MA0K
PiA+ID4gKyAgICAgIC0gYWRpLGFkNzE3MQ0KPiA+ID4gKyAgICAgIC0gYWRpLGFkNzc4MA0KPiA+
ID4gKyAgICAgIC0gYWRpLGFkNzc4MQ0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgYXZkZC1zdXBwbHk6DQo+ID4gPiArICAg
IGRlc2NyaXB0aW9uOg0KPiA+ID4gKyAgICAgIFRoZSByZWd1bGF0b3Igc3VwcGx5IGZvciB0aGUg
QURDIHJlZmVyZW5jZSB2b2x0YWdlLg0KPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0K
PiA+ID4gKyAgcG93ZXJkb3duLWdwaW9zOg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiA+
ICsgICAgICBNdXN0IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBQRFJTVCBw
aW4uIElmDQo+ID4gPiArICAgICAgc3BlY2lmaWVkLCBpdCB3aWxsIGJlIGFzc2VydGVkIGR1cmlu
ZyBkcml2ZXIgcHJvYmUuIEFzIHRoZQ0KPiA+ID4gKyAgICAgIGxpbmUgaXMgYWN0aXZlIGhpZ2gs
IGl0IHNob3VsZCBiZSBtYXJrZWQgR1BJT19BQ1RJVkVfSElHSC4NCj4gPiA+ICsgICAgbWF4SXRl
bXM6IDENCj4gPiA+ICsNCj4gPiA+ICsgIGFkaSxnYWluLWdwaW9zOg0KPiA+ID4gKyAgICBkZXNj
cmlwdGlvbjoNCj4gPiA+ICsgICAgICBNdXN0IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVy
IG9mIHRoZSBHQUlOIHBpbi4gT25seSBmb3INCj4gPiA+ICsgICAgICB0aGUgYWQ3Nzh4IGNoaXBz
LiBJZiBzcGVjaWZpZWQsIGl0IHdpbGwgYmUgYXNzZXJ0ZWQgZHVyaW5nDQo+ID4gPiArICAgICAg
ZHJpdmVyIHByb2JlLiBBcyB0aGUgbGluZSBpcyBhY3RpdmUgbG93LCBpdCBzaG91bGQgYmUgbWFy
a2VkDQo+ID4gPiArICAgICAgR1BJT19BQ1RJVkVfTE9XLg0KPiA+ID4gKyAgICBtYXhJdGVtczog
MQ0KPiA+ID4gKw0KPiA+ID4gKyAgYWRpLGZpbHRlci1ncGlvczoNCj4gPiA+ICsgICAgZGVzY3Jp
cHRpb246DQo+ID4gPiArICAgICAgTXVzdCBiZSB0aGUgZGV2aWNlIHRyZWUgaWRlbnRpZmllciBv
ZiB0aGUgRklMVEVSIHBpbi4gT25seQ0KPiA+ID4gKyAgICAgIGZvciB0aGUgYWQ3Nzh4IGNoaXBz
LiBJZiBzcGVjaWZpZWQsIGl0IHdpbGwgYmUgYXNzZXJ0ZWQNCj4gPiA+ICsgICAgICBkdXJpbmcg
ZHJpdmVyIHByb2JlLiBBcyB0aGUgbGluZSBpcyBhY3RpdmUgbG93LCBpdCBzaG91bGQgYmUNCj4g
PiA+ICsgICAgICBtYXJrZWQgR1BJT19BQ1RJVkVfTE9XLg0KPiA+ID4gKyAgICBtYXhJdGVtczog
MQ0KPiA+ID4gKw0KPiA+ID4gK3JlcXVpcmVkOg0KPiA+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4g
PiArICAtIHJlZw0KPiA+ID4gKw0KPiA+ID4gK2V4YW1wbGVzOg0KPiA+ID4gKyAgLSB8DQo+ID4g
PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4gPiA+ICsgICAgc3Bp
MCB7DQo+ID4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiA+ICsgICAgICAg
ICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgYWRjQDAgew0KPiA+
ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFkNzc4MCI7DQo+ID4gPiArICAgICAg
ICAgICAgcmVnID0gPDA+Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgIGF2ZGQtc3VwcGx5
ICAgICAgPSA8JnZkZF9zdXBwbHk+Ow0KPiA+ID4gKyAgICAgICAgICAgIHBvd2VyZG93bi1ncGlv
cyAgPSA8JmdwaW8wIDEyIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ID4gKyAgICAgICAgICAgIGFk
aSxnYWluLWdwaW9zICAgPSA8JmdwaW8xICA1IEdQSU9fQUNUSVZFX0xPVz47DQo+ID4gPiArICAg
ICAgICAgICAgYWRpLGZpbHRlci1ncGlvcyA9IDwmZ3BpbzIgMTUgR1BJT19BQ1RJVkVfTE9XPjsN
Cj4gPiA+ICsgICAgICAgIH07DQo+ID4gPiArICAgIH07DQo=
