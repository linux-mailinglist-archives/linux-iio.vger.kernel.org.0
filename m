Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B493455AB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 03:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWCqS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 22:46:18 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48848 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229760AbhCWCqN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 22:46:13 -0400
X-UUID: 9577ef8d0c2d4a02aae37aff09cc3d66-20210323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VpNJ4ysNUi4mHpSUcx9y6Y6iigzBeZb1dOMLDF46zqY=;
        b=KT1ecux2+wPuPFjbK8WvwMAQ58anUfS9Xk3FAVgp7b2K9Sh2CxmuU9tIoRG//XLubYxemLFLVOWKtTon8NZg8cLLWLUcVnJa0jLlQ+eenOVhvllSop/MfyuTfmcHDEi/5nhn9zeeyYONTvt3d/4lLAee7rf34AcUu7Zn/qfMONU=;
X-UUID: 9577ef8d0c2d4a02aae37aff09cc3d66-20210323
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 375086942; Tue, 23 Mar 2021 10:46:09 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Mar
 2021 10:46:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 10:46:02 +0800
Message-ID: <1616467562.11286.6.camel@mhfsdcap03>
Subject: Re: [PATCH v2 8/8] arm64: dts: Add Mediatek SoC MT8195 and
 evaluation board dts and Makefile
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Seiya Wang <seiya.wang@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        "Chaotian Jing" <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Tue, 23 Mar 2021 10:46:02 +0800
In-Reply-To: <20210319023427.16711-10-seiya.wang@mediatek.com>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
         <20210319023427.16711-10-seiya.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 28F8593833E94E19A1F4D91ECB4810AD8FDC1801FD7F0C0BF75ACA0B515B35272000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIxLTAzLTE5IGF0IDEwOjM0ICswODAwLCBTZWl5YSBXYW5nIHdyb3RlOg0KPiBB
ZGQgYmFzaWMgY2hpcCBzdXBwb3J0IGZvciBNZWRpYXRlayBNVDgxOTUNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNlaXlhIFdhbmcgPHNlaXlhLndhbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgfCAgIDEgKw0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUtZXZiLmR0cyB8ICAyOSArKw0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSAgICB8IDQ2NCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ5NCBpbnNlcnRpb25zKCsp
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
OTUtZXZiLmR0cw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTk1LmR0c2kNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL01ha2VmaWxlIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmls
ZQ0KPiBpbmRleCBkZWJhMjdhYjc2NTcuLmFlZTRiOTcxNWQyZiAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZQ0KPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL01ha2VmaWxlDQo+IEBAIC0xNiw0ICsxNiw1IEBAIGR0Yi0kKENPTkZJ
R19BUkNIX01FRElBVEVLKSArPSBtdDgxODMtZXZiLmR0Yg0KPiAgZHRiLSQoQ09ORklHX0FSQ0hf
TUVESUFURUspICs9IG10ODE4My1rdWt1aS1rcmFuZS1za3UwLmR0Yg0KPiAgZHRiLSQoQ09ORklH
X0FSQ0hfTUVESUFURUspICs9IG10ODE4My1rdWt1aS1rcmFuZS1za3UxNzYuZHRiDQo+ICBkdGIt
JChDT05GSUdfQVJDSF9NRURJQVRFSykgKz0gbXQ4MTkyLWV2Yi5kdGINCj4gK2R0Yi0kKENPTkZJ
R19BUkNIX01FRElBVEVLKSArPSBtdDgxOTUtZXZiLmR0Yg0KPiAgZHRiLSQoQ09ORklHX0FSQ0hf
TUVESUFURUspICs9IG10ODUxNi1wdW1wa2luLmR0Yg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUtZXZiLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTk1LWV2Yi5kdHMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi44MmJiMTBlOWE1MzENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS1ldmIuZHRzDQo+IEBAIC0wLDAgKzEsMjkg
QEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBNSVQpDQo+ICsv
Kg0KPiArICogQ29weXJpZ2h0IChDKSAyMDIxIE1lZGlhVGVrIEluYy4NCj4gKyAqIEF1dGhvcjog
U2VpeWEgV2FuZyA8c2VpeWEud2FuZ0BtZWRpYXRlay5jb20+DQo+ICsgKi8NCj4gKy9kdHMtdjEv
Ow0KPiArI2luY2x1ZGUgIm10ODE5NS5kdHNpIg0KPiArDQpbLi4uXQ0KPiArCQlub3JfZmxhc2g6
IG5vckAxMTMyYzAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1ub3Ii
LCAibWVkaWF0ZWssbXQ4MTczLW5vciI7DQo+ICsJCQlyZWcgPSA8MCAweDExMzJjMDAwIDAgMHgx
MDAwPjsNCj4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4MjUgSVJRX1RZUEVfTEVWRUxfSElH
SCAwPjsNCj4gKwkJCWNsb2NrcyA9IDwmY2xrMjZtPiwgPCZjbGsyNm0+Ow0KPiArCQkJY2xvY2st
bmFtZXMgPSAic3BpIiwgInNmIjsNCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJ
I3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQl9Ow0K
PiArDQo+ICsJCXUzcGh5MjogdC1waHlAMTFjNDAwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTUtdHBoeSIsICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KPiArCQkJ
I2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gKwkJCXJh
bmdlcyA9IDwwIDAgMHgxMWM0MDAwMCAweDcwMD47DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiArDQo+ICsJCQl1MnBvcnQyOiB1c2ItcGh5QDAgew0KPiArCQkJCXJlZyA9IDwweDAgMHg3
MDA+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gKwkJCQljbG9jay1uYW1lcyA9ICJy
ZWYiOw0KPiArCQkJCSNwaHktY2VsbHMgPSA8MT47DQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArDQo+
ICsJCXUzcGh5MzogdC1waHlAMTFjNTAwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTUtdHBoeSIsICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KPiArCQkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gKwkJCXJhbmdlcyA9
IDwwIDAgMHgxMWM1MDAwMCAweDcwMD47DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAr
DQo+ICsJCQl1MnBvcnQzOiB1c2ItcGh5QDAgew0KPiArCQkJCXJlZyA9IDwweDAgMHg3MDA+Ow0K
PiArCQkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gKwkJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0K
PiArCQkJCSNwaHktY2VsbHMgPSA8MT47DQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArDQo+ICsJCXUz
cGh5MTogdC1waHlAMTFlMzAwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
OTUtdHBoeSIsICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KPiArCQkJI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gKwkJCXJhbmdlcyA9IDwwIDAg
MHgxMWUzMDAwMCAweGUwMD47DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsJ
CQl1MnBvcnQxOiB1c2ItcGh5QDAgew0KPiArCQkJCXJlZyA9IDwweDAgMHg3MDA+Ow0KPiArCQkJ
CWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gKwkJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiArCQkJ
CSNwaHktY2VsbHMgPSA8MT47DQo+ICsJCQl9Ow0KPiArDQo+ICsJCQl1M3BvcnQxOiB1c2ItcGh5
QDcwMCB7DQo+ICsJCQkJcmVnID0gPDB4NzAwIDB4NzAwPjsNCj4gKwkJCQljbG9ja3MgPSA8JmNs
azI2bT47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCj4gKwkJCQkjcGh5LWNlbGxzID0g
PDE+Ow0KPiArCQkJfTsNCj4gKwkJfTsNCj4gKw0KPiArCQl1M3BoeTA6IHQtcGh5QDExZTQwMDAw
IHsNCj4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXRwaHkiLCAibWVkaWF0ZWss
Z2VuZXJpYy10cGh5LXYyIjsNCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJI3Np
emUtY2VsbHMgPSA8MT47DQo+ICsJCQlyYW5nZXMgPSA8MCAwIDB4MTFlNDAwMDAgMHhlMDA+Ow0K
PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJdTJwb3J0MDogdXNiLXBoeUAw
IHsNCj4gKwkJCQlyZWcgPSA8MHgwIDB4NzAwPjsNCj4gKwkJCQljbG9ja3MgPSA8JmNsazI2bT47
DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCj4gKwkJCQkjcGh5LWNlbGxzID0gPDE+Ow0K
PiArCQkJfTsNCj4gKw0KPiArCQkJdTNwb3J0MDogdXNiLXBoeUA3MDAgew0KPiArCQkJCXJlZyA9
IDwweDcwMCAweDcwMD47DQo+ICsJCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KPiArCQkJCWNsb2Nr
LW5hbWVzID0gInJlZiI7DQo+ICsJCQkJI3BoeS1jZWxscyA9IDwxPjsNCj4gKwkJCX07DQo+ICsJ
CX07DQo+ICsNCj4gKwkJdWZzcGh5OiBwaHlAMTFmYTAwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxOTUtdWZzcGh5IiwgIm1lZGlhdGVrLG10ODE4My11ZnNwaHkiOw0KPiAr
CQkJcmVnID0gPDAgMHgxMWZhMDAwMCAwIDB4YzAwMD47DQo+ICsJCQljbG9ja3MgPSA8JmNsazI2
bT4sIDwmY2xrMjZtPjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gInVuaXBybyIsICJtcCI7DQo+ICsJ
CQkjcGh5LWNlbGxzID0gPDA+Ow0KPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJfTsN
Cj4gKwl9Ow0KPiArfTsNCnBoeSBwYXJ0Og0KDQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVuIDxj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFuayB5b3UNCg0KDQo=

