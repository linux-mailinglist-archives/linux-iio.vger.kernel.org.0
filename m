Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203A912260B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 08:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLQH7l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 02:59:41 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:48474 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLQH7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 02:59:41 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cyMCWzrN6h2l6bDxjeHh/cByJ3EWmOy/j+coNbeXZ8Kd/kZWcQumwNRDLc7vds1KaRZs/X8JBf
 ZenltYZFh4IJvCp9wHgX/JRthUBEF2MbM+Btd/iYHGh95tD80EGR2Zg4qDK4nusNL3neE902qh
 zjA/eNkWumZ+KX1mG8xA16fv48ZfdMks7q1k1NbOZyBIc4xhNHgOVhVWDuOoYtyRCwvOqasNZE
 bKlUJ0YxcqXbXcxGEFbqJrVuuYTsnGDU+UUn16ptI2dhaZ70FLzmuGwqZhJT9edqjQraSyeSaQ
 I3A=
X-IronPort-AV: E=Sophos;i="5.69,324,1571727600"; 
   d="scan'208";a="59239123"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2019 00:59:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Dec 2019 00:59:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Dec 2019 00:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUl751Zgh5RhWX5CXiZb+k1d6d4PCpqE5t57MkOZuP9jUhsn1M9ikZxeLsg8JZ4kEI2JTDrf9qHf7B/yJLM5hoAgiviHq3x45+WEn52ean2AHh9QDuqoDz2cytMp+mzr1w5Uy2DZ9A9kwiORsZl0bPQkVYDQBjVHSISUVblRy2Ui6YbmgPxPeEA4G8zWZBu631u5sHoexeLg3mmnu/DsN5gTCTlj7SP+Ojd1a19Uh7eATXSYv2PTse8aj6suM+s49I6Tu/GrTRDHPDBWjEx/XpnYcM4i8bs24GJn38ElEdP26PCqSsiH/xJuxoez2tma3mA/mGkLaPdHIwBOkYYxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BltOCjsnQ+CYpVZ1XekLJqThIT44rFTQB2ZX/wHBjoY=;
 b=cAsoBu6fO+GNZpZR6wVtOwU7GUUWJJHJos1jBMdeKLLGjyJpR6L94MQrEo3qE/L+GZkeUseS0O2AsE9m7mwNBjrfuGYwNDPXKhLA9yzdoz2PE2nBN8TKlx7LR14/MNSC1uDEp+GeMM+hTzYElZZM7SnIJrWhD/UzmN846VebC8bTQTtPiFtFZGMUPRDia5XXpjoT6yWkBfCnht6RVo2Zl0Q3WHG9mS0bMBjSBftWr/C/j6568mQb25mNkWyT5mrGf87U531UrhHe2Bcp/5ScXcQHRTPGAtK9+6GXbbHZkOhZgQnW9vrJ6S/tHlxSf2VkhepZ3nAvLXAZig8M1cLPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BltOCjsnQ+CYpVZ1XekLJqThIT44rFTQB2ZX/wHBjoY=;
 b=HcfQwS/gvXSR9YLSoLzb9+o+Nt2i8G9ZmRnYlxokeLdgGIf9b65QcSQSq/OI5ABSY+W7DI58XTXVhWJC7MxKHDFayxz28+rLiEGz3cYb+T9Z3kpcrkOijbmht1pRBYK1cOwUvRG2BDxQATw6f1T6+tWvzl+lkSdFYQIXQ5Gvk5c=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1993.namprd11.prod.outlook.com (10.168.107.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Tue, 17 Dec 2019 07:59:35 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2538.019; Tue, 17 Dec
 2019 07:59:34 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <peter.ujfalusi@ti.com>, <jic23@kernel.org>
CC:     <vkoul@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91: Use dma_request_chan() instead
 dma_request_slave_channel()
Thread-Topic: [PATCH] iio: adc: at91: Use dma_request_chan() instead
 dma_request_slave_channel()
Thread-Index: AQHVtK62ARE9EHW0SkuabQ9x+H8R5Ke99mWA
Date:   Tue, 17 Dec 2019 07:59:34 +0000
Message-ID: <102e71da-8b9c-8528-3bec-b4a22895fb44@microchip.com>
References: <20191217075043.23539-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191217075043.23539-1-peter.ujfalusi@ti.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20bab96c-8d2c-4511-1abe-08d782c70e86
x-ms-traffictypediagnostic: DM5PR11MB1993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB19930214EE9715101DB2DC69E8500@DM5PR11MB1993.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(66446008)(64756008)(66946007)(66556008)(66476007)(36756003)(76116006)(316002)(54906003)(26005)(110136005)(71200400001)(81166006)(2906002)(6512007)(86362001)(6506007)(2616005)(53546011)(31696002)(5660300002)(478600001)(31686004)(186003)(8936002)(91956017)(8676002)(81156014)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1993;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlqCXOo33f6YZlH18pxM005qbLsOmxdEQbbAQ3Mv6IrmhCOBhJ57yb3ttfUUJka6d8MUgyduv0lnRE1K0svHOIKSRyGncBMBCpYaoOxTMnvcyCqAaQb0puO2kL1B1kyWKsZ1wpIV8g+ACfLrcrUTl7i+R1u7IASLfxIgLvLOfyJL3ufKSgBoBkK/ks2CNzB/kkZuH1+sbAIMh5U9av4p/zCxN9qqpOtOI2kSwY2W4KLYv7k9Ge4iB1qRDa4e6aJkjNeDsr/l/8ENvj95C+bOGoLKU/4fdY6tpnUIokTHwiQQp32CQ+GugsNTTuSKbEt3dXb4cvHui4pAPmnOEC50t9eJmwL3/JXRdGjkR7uOJNIGcDzObPCcruivYaiSxbpUEFKv/vqfHcvRWoycTdZd5ijiL8fwZvSiKlAcC1cXWK+F/vwqcVxi3FUBhQ1U6u0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2D76EEC08250F4591517B12BACDF2B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bab96c-8d2c-4511-1abe-08d782c70e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 07:59:34.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wryc3MqQY86XP5M3g3avWNnG72BjcoOLPqDf9kGkLHtnKj0ApRefMCDv0pGyCLtb5SemxOOtDH7cdG0e5AqTyc02k+3p+GlrwDMUEqSMxAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1993
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDE3LjEyLjIwMTkgMDk6NTAsIFBldGVyIFVqZmFsdXNpIHdyb3RlOg0KDQo+IGRtYV9y
ZXF1ZXN0X3NsYXZlX2NoYW5uZWwoKSBpcyBhIHdyYXBwZXIgb24gdG9wIG9mIGRtYV9yZXF1ZXN0
X2NoYW4oKQ0KPiBlYXRpbmcgdXAgdGhlIGVycm9yIGNvZGUuDQo+IA0KPiBCeSB1c2luZyBkbWFf
cmVxdWVzdF9jaGFuKCkgZGlyZWN0bHkgdGhlIGRyaXZlciBjYW4gc3VwcG9ydCBkZWZlcnJlZA0K
PiBwcm9iaW5nIGFnYWluc3QgRE1BLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgVWpmYWx1
c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9paW8vYWRjL2F0
OTEtc2FtYTVkMl9hZGMuYyB8IDYgKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KSGkgUGV0ZXIsDQoNClRoYW5rIHlvdSBmb3IgdGhl
IHBhdGNoLg0KTml0cGljayA6IGF0OTEgaXMgYW5vdGhlciBkcml2ZXIgKG9sZCBvbmUgZm9yIGRp
ZmZlcmVudCBwbGF0Zm9ybXMpLCBzbyANCmNhbiB5b3UgcGxlYXNlIGNoYW5nZSB0aGUgY29tbWl0
IG9uZWxpbmUgdG8gaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IA0KdG8gbm90IGJlIGNvbmZ1
c2VkIGFib3V0IHdoaWNoIGRyaXZlciBpcyBhZmZlY3RlZC4NCg0KVGhhbmtzICENCkV1Z2VuDQoN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIv
ZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPiBpbmRleCBlMTg1MGYzZDVjZjMu
LmE1Yzc3NzEyMjdkNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVk
Ml9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+IEBA
IC0xNDQ0LDEwICsxNDQ0LDEwIEBAIHN0YXRpYyB2b2lkIGF0OTFfYWRjX2RtYV9pbml0KHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgIGlmIChzdC0+ZG1hX3N0LmRtYV9j
aGFuKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IC0gICAgICAgc3QtPmRtYV9z
dC5kbWFfY2hhbiA9IGRtYV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWwoJnBkZXYtPmRldiwgInJ4Iik7
DQo+IC0NCj4gLSAgICAgICBpZiAoIXN0LT5kbWFfc3QuZG1hX2NoYW4pICB7DQo+ICsgICAgICAg
c3QtPmRtYV9zdC5kbWFfY2hhbiA9IGRtYV9yZXF1ZXN0X2NoYW4oJnBkZXYtPmRldiwgInJ4Iik7
DQo+ICsgICAgICAgaWYgKElTX0VSUihzdC0+ZG1hX3N0LmRtYV9jaGFuKSkgIHsNCj4gICAgICAg
ICAgICAgICAgICBkZXZfaW5mbygmcGRldi0+ZGV2LCAiY2FuJ3QgZ2V0IERNQSBjaGFubmVsXG4i
KTsNCj4gKyAgICAgICAgICAgICAgIHN0LT5kbWFfc3QuZG1hX2NoYW4gPSBOVUxMOw0KPiAgICAg
ICAgICAgICAgICAgIGdvdG8gZG1hX2V4aXQ7DQo+ICAgICAgICAgIH0NCj4gDQo+IC0tDQo+IFBl
dGVyDQo+IA0KPiBUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIy
LCAwMDE4MCBIZWxzaW5raS4NCj4gWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290
aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kNCj4gDQo+IA==
