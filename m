Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A579F33FF5B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 07:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCRGJL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 02:09:11 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:36832 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhCRGIw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 02:08:52 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 02:08:50 EDT
X-UUID: 56fea7607ad44cba8f66adb8f9978347-20210317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uQSiOMXDhmEHV9qxsBXHJ8UvwmwJKYtttU3s4BkgnZ4=;
        b=gjiMSnYRF3Rhp4H/KcVX1fzmTXstXSe2HRdTWAh/V5qHtsNZqBYEVel6ryNmpvIXdw3dn4x7gCDwV7o2ZkodOfbFy8yYMlZ1qtQxlvZ0WNKrlTUgyS1uWvRr6iAOc+801Huzz1sOaTQMw52rgUZtFFWNqW3ZSOagWRg35IzLOm4=;
X-UUID: 56fea7607ad44cba8f66adb8f9978347-20210317
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1799923838; Wed, 17 Mar 2021 22:03:46 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Mar 2021 23:03:44 -0700
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 14:03:43 +0800
Message-ID: <1616047423.29855.3.camel@mtksdccf07>
Subject: Re: [PATCH 10/10] arm64: dts: Add Mediatek SoC MT8195 and
 evaluation board dts and Makefile
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fabien Parent" <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Zhiyong Tao" <zhiyong.tao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        "Chuanhong Guo" <gch981213@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 18 Mar 2021 14:03:43 +0800
In-Reply-To: <1616036277.25733.33.camel@mhfsdcap03>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
         <20210316111443.3332-11-seiya.wang@mediatek.com>
         <1616036277.25733.33.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTE4IGF0IDEwOjU3ICswODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyMS0wMy0xNiBhdCAxOToxNCArMDgwMCwgU2VpeWEgV2FuZyB3cm90ZToNCj4g
PiBBZGQgYmFzaWMgY2hpcCBzdXBwb3J0IGZvciBNZWRpYXRlayBNVDgxOTUNCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTZWl5YSBXYW5nIDxzZWl5YS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICB8ICAg
MSArDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LWV2Yi5kdHMgfCAg
MjkgKysNCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSAgICB8
IDQ3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
NTA3IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LWV2Yi5kdHMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZSBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBpbmRleCBkZWJhMjdhYjc2NTcuLmFlZTRi
OTcxNWQyZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL01h
a2VmaWxlDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZQ0K
PiA+IEBAIC0xNiw0ICsxNiw1IEBAIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgx
ODMtZXZiLmR0Yg0KPiA+ICBkdGItJChDT05GSUdfQVJDSF9NRURJQVRFSykgKz0gbXQ4MTgzLWt1
a3VpLWtyYW5lLXNrdTAuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBt
dDgxODMta3VrdWkta3JhbmUtc2t1MTc2LmR0Yg0KPiA+ICBkdGItJChDT05GSUdfQVJDSF9NRURJ
QVRFSykgKz0gbXQ4MTkyLWV2Yi5kdGINCj4gPiArZHRiLSQoQ09ORklHX0FSQ0hfTUVESUFURUsp
ICs9IG10ODE5NS1ldmIuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBt
dDg1MTYtcHVtcGtpbi5kdGINCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxOTUtZXZiLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTk1LWV2Yi5kdHMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uODJiYjEwZTlhNTMxDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LWV2Yi5kdHMNCj4gPiBAQCAtMCwwICsxLDI5IEBA
DQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBNSVQpDQo+ID4g
Ky8qDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ID4gKyAqIEF1
dGhvcjogU2VpeWEgV2FuZyA8c2VpeWEud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gKyAqLw0KPiA+
ICsvZHRzLXYxLzsNCj4gPiArI2luY2x1ZGUgIm10ODE5NS5kdHNpIg0KPiA+ICsNCj4gPiArLyB7
DQo+ID4gKwltb2RlbCA9ICJNZWRpYVRlayBNVDgxOTUgZXZhbHVhdGlvbiBib2FyZCI7DQo+ID4g
Kwljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1ldmIiLCAibWVkaWF0ZWssbXQ4MTk1IjsN
Cj4gPiArDQo+ID4gKwlhbGlhc2VzIHsNCj4gPiArCQlzZXJpYWwwID0gJnVhcnQwOw0KPiA+ICsJ
fTsNCj4gPiArDQo+ID4gKwljaG9zZW4gew0KPiA+ICsJCXN0ZG91dC1wYXRoID0gInNlcmlhbDA6
OTIxNjAwbjgiOw0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwltZW1vcnlANDAwMDAwMDAgew0KPiA+
ICsJCWRldmljZV90eXBlID0gIm1lbW9yeSI7DQo+ID4gKwkJcmVnID0gPDAgMHg0MDAwMDAwMCAw
IDB4ODAwMDAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZ1YXJ0MCB7DQo+
ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE5NS5kdHNpDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjM1NjU4M2ZlNGYwMw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpDQo+ID4gQEAgLTAsMCArMSw0
NzcgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIE1JVCkN
Cj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIxIE1lZGlhVGVrIEluYy4NCj4gPiAr
ICogQXV0aG9yOiBTZWl5YSBXYW5nIDxzZWl5YS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiArICov
DQo+ID4gKw0KPiA+ICsvZHRzLXYxLzsNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiArDQo+ID4gKy8gew0KPiA+ICsJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUiOw0KPiA+ICsJaW50ZXJydXB0LXBhcmVudCA9
IDwmZ2ljPjsNCj4gPiArCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsJI3NpemUtY2VsbHMg
PSA8Mj47DQo+ID4gKw0KPiA+ICsJY2xvY2tzIHsNCj4gPiArCQljbGsyNm06IG9zY2lsbGF0b3Iw
IHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+ID4gKwkJCSNjbG9jay1j
ZWxscyA9IDwwPjsNCj4gPiArCQkJY2xvY2stZnJlcXVlbmN5ID0gPDI2MDAwMDAwPjsNCj4gPiAr
CQkJY2xvY2stb3V0cHV0LW5hbWVzID0gImNsazI2bSI7DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4g
KwkJY2xrMzJrOiBvc2NpbGxhdG9yMSB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xv
Y2siOw0KPiA+ICsJCQkjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4gKwkJCWNsb2NrLWZyZXF1ZW5j
eSA9IDwzMjc2OD47DQo+ID4gKwkJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJjbGszMmsiOw0KPiA+
ICsJCX07DQo+ID4gKwl9Ow0KPiBbLi4uXQ0KPiA+ICsNCj4gPiArCQlub3JfZmxhc2g6IG5vckAx
MTMyYzAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LW5vciIsICJt
ZWRpYXRlayxtdDgxNzMtbm9yIjsNCj4gPiArCQkJcmVnID0gPDAgMHgxMTMyYzAwMCAwIDB4MTAw
MD47DQo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4MjUgSVJRX1RZUEVfTEVWRUxfSElH
SCAwPjsNCj4gPiArCQkJY2xvY2tzID0gPCZjbGsyNm0+LCA8JmNsazI2bT47DQo+ID4gKwkJCWNs
b2NrLW5hbWVzID0gInNwaSIsICJzZiI7DQo+ID4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
PiA+ICsJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQl1M3BoeTI6IHVzYi1waHkyQDExYzQwMDAwIHsNCj4g
dXNlIHQtcGh5IGluc3RlYWQgb2YgdXNiLXBoeTINCj4gDQo+IEl0J3MgYmV0dGVyIHRvIHJ1biBk
dGJzX2NoZWNrIGZvciB0aGlzIHBhdGNoDQo+IA0KPiA+ICsJCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE5NS10cGh5IiwgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiI7DQo+ID4gKwkJCWNs
b2NrcyA9IDwmY2xrMjZtPjsNCj4gPiArCQkJY2xvY2stbmFtZXMgPSAidTNwaHlhX3JlZiI7DQo+
IE5vIG5lZWQgY2xvY2tzIGZvciB2Mg0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
PiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJCXJhbmdlcyA9IDwwIDAgMHgxMWM0MDAw
MCAweDcwMD47DQo+ID4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKw0KPiA+ICsJCQl1
MnBvcnQyOiB1c2IyLXBoeTJAMCB7DQo+IHVzZSB1c2ItcGh5IGluc3RlYWQgb2YgdXNiMi1waHky
DQo+IA0KPiA+ICsJCQkJcmVnID0gPDB4MCAweDcwMD47DQo+ID4gKwkJCQljbG9ja3MgPSA8JmNs
azI2bT47DQo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiA+ICsJCQkJI3BoeS1jZWxs
cyA9IDwxPjsNCj4gPiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IEkgdGhpbmsgbm8gbmVl
ZCBkaXNhYmxlIGl0DQo+IGl0J3MgcGFyZW50IG5vZGUgaXMgYWxyZWFkeSBkaXNhYmxlZC4gaWYg
ZW5hYmxlIHBhcmVudCBub2RlLA0KPiB3ZSBhbHNvIHdhbnQgdG8gZW5hYmxlIGFsbCBjaGlsZHJl
biBhdCB0aGUgc2FtZSB0aW1lLg0KPiANCj4gPiArCQkJfTsNCj4gPiArCQl9Ow0KPiA+ICsNCj4g
PiArCQl1M3BoeTM6IHVzYi1waHkzQDExYzUwMDAwIHsNCj4gdC1waHlALi4uDQo+ID4gKwkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXRwaHkiLCAibWVkaWF0ZWssZ2VuZXJpYy10cGh5
LXYyIjsNCj4gPiArCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KPiA+ICsJCQljbG9jay1uYW1lcyA9
ICJ1M3BoeWFfcmVmIjsNCj4gTm8gbmVlZCBjbG9ja3MNCj4gPiArCQkJI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ID4gKwkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQlyYW5nZXMgPSA8MCAw
IDB4MTFjNTAwMDAgMHg3MDA+Ow0KPiA+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsN
Cj4gPiArCQkJdTJwb3J0MzogdXNiMi1waHkzQDAgew0KPiB1c2UgdXNiLXBoeQ0KPiA+ICsJCQkJ
cmVnID0gPDB4MCAweDcwMD47DQo+ID4gKwkJCQljbG9ja3MgPSA8JmNsazI2bT47DQo+ID4gKwkJ
CQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiA+ICsJCQkJI3BoeS1jZWxscyA9IDwxPjsNCj4gPiAr
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IHJlbW92ZSBzdGF0dXMNCj4gPiArCQkJfTsNCj4g
PiArCQl9Ow0KPiA+ICsNCj4gPiArCQl1M3BoeTE6IHVzYi1waHkxQDExZTMwMDAwIHsNCj4gdC1w
aHkNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtdHBoeSIsICJtZWRpYXRl
ayxnZW5lcmljLXRwaHktdjIiOw0KPiA+ICsJCQljbG9ja3MgPSA8JmNsazI2bT47DQo+ID4gKwkJ
CWNsb2NrLW5hbWVzID0gInUzcGh5YV9yZWYiOw0KPiByZW1vdmUgY2xvY2tzKg0KPiA+ICsJCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJ
CXJhbmdlcyA9IDwwIDAgMHgxMWUzMDAwMCAweGUwMD47DQo+ID4gKwkJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ID4gKw0KPiA+ICsJCQl1MnBvcnQxOiB1c2IyLXBoeTFAMCB7DQo+IHVzYi1waHkN
Cj4gPiArCQkJCXJlZyA9IDwweDAgMHg3MDA+Ow0KPiA+ICsJCQkJY2xvY2tzID0gPCZjbGsyNm0+
Ow0KPiA+ICsJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCj4gPiArCQkJCSNwaHktY2VsbHMgPSA8
MT47DQo+ID4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiByZW1vdmUgc3RhdHVzDQo+ID4g
KwkJCX07DQo+ID4gKw0KPiA+ICsJCQl1M3BvcnQxOiB1c2IzLXBoeTFANzAwIHsNCj4gdXNiLXBo
eQ0KPiA+ICsJCQkJcmVnID0gPDB4NzAwIDB4NzAwPjsNCj4gPiArCQkJCWNsb2NrcyA9IDwmY2xr
MjZtPjsNCj4gPiArCQkJCWNsb2NrLW5hbWVzID0gInJlZiI7DQo+ID4gKwkJCQkjcGh5LWNlbGxz
ID0gPDE+Ow0KPiA+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gcmVtb3ZlIHN0YXR1cw0K
PiA+ICsJCQl9Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXUzcGh5MDogdXNiLXBoeTBAMTFl
NDAwMDAgew0KPiB0LXBoeQ0KPiA+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS10
cGh5IiwgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiI7DQo+ID4gKwkJCWNsb2NrcyA9IDwmY2xr
MjZtPjsNCj4gPiArCQkJY2xvY2stbmFtZXMgPSAidTNwaHlhX3JlZiI7DQo+IHJlbW92ZSBjbG9j
a3MqDQo+ID4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQkjc2l6ZS1jZWxscyA9
IDwxPjsNCj4gPiArCQkJcmFuZ2VzID0gPDAgMCAweDExZTQwMDAwIDB4ZTAwPjsNCj4gPiArCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArDQo+ID4gKwkJCXUycG9ydDA6IHVzYjItcGh5MEAw
IHsNCj4gdXNiLXBoeQ0KPiA+ICsJCQkJcmVnID0gPDB4MCAweDcwMD47DQo+ID4gKwkJCQljbG9j
a3MgPSA8JmNsazI2bT47DQo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiA+ICsJCQkJ
I3BoeS1jZWxscyA9IDwxPjsNCj4gPiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IHJlbW92
ZSBzdGF0dXMNCj4gPiArCQkJfTsNCj4gPiArDQo+ID4gKwkJCXUzcG9ydDA6IHVzYjMtcGh5MEA3
MDAgew0KPiB1c2ItcGh5DQo+ID4gKwkJCQlyZWcgPSA8MHg3MDAgMHg3MDA+Ow0KPiA+ICsJCQkJ
Y2xvY2tzID0gPCZjbGsyNm0+Ow0KPiA+ICsJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCj4gPiAr
CQkJCSNwaHktY2VsbHMgPSA8MT47DQo+ID4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiBy
ZW1vdmUgc3RhdHVzDQo+ID4gKwkJCX07DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJdWZzcGh5
OiBwaHlAMTFmYTAwMDAgew0KPiB1c2YtcGh5IGluc3RlYWQgb2YgcGh5DQo+ID4gKwkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXVmc3BoeSIsICJtZWRpYXRlayxtdDgxODMtdWZzcGh5
IjsNCj4gPiArCQkJcmVnID0gPDAgMHgxMWZhMDAwMCAwIDB4YzAwMD47DQo+ID4gKwkJCWNsb2Nr
cyA9IDwmY2xrMjZtPiwgPCZjbGsyNm0+Ow0KPiA+ICsJCQljbG9jay1uYW1lcyA9ICJ1bmlwcm8i
LCAibXAiOw0KPiA+ICsJCQkjcGh5LWNlbGxzID0gPDA+Ow0KPiBkaXNhYmxlZD8NCj4gDQo+IFRo
YW5rcyBhIGxvdA0KDQpJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBhZnRlciBhIG5ldyBsaW51eC1u
ZXh0IHRhZyBhdmFpbGFibGUuDQpUaGFuayB5b3UgdmVyeSBtdWNoLg0KDQo+ID4gKwkJfTsNCj4g
PiArCX07DQo+ID4gK307DQo+IA0KPiANCg0K

