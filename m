Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F933FD82
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 03:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCRC62 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 22:58:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40205 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231237AbhCRC6J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 22:58:09 -0400
X-UUID: 77cebba874544ab38d926bb6f2295ee1-20210318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=trBmT3K9uMqa0TyHE++0eL6k5R6NG7WOy/KaPCrY2mI=;
        b=b852oreT+zzc8c3lpDWLmUcL3HZKGxAdVMtgslnqtAGaCUnSDjOdF2UgP7Ep1hCQfKpAMVWuWQA6WJeCoJD66CChnJDVw7Lf0I9EhJo/KwznOU/EoemSuqDIA6Sv5SYF3C/ou+7ufmGeNqxTOOKuIDPrgJOKLChkinjUy6quy+E=;
X-UUID: 77cebba874544ab38d926bb6f2295ee1-20210318
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 426622439; Thu, 18 Mar 2021 10:58:05 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Mar
 2021 10:57:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 10:57:57 +0800
Message-ID: <1616036277.25733.33.camel@mhfsdcap03>
Subject: Re: [PATCH 10/10] arm64: dts: Add Mediatek SoC MT8195 and
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
Date:   Thu, 18 Mar 2021 10:57:57 +0800
In-Reply-To: <20210316111443.3332-11-seiya.wang@mediatek.com>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
         <20210316111443.3332-11-seiya.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F0FF613E1DA030AFDD59B79CB90B1D19E249B87A5555275099D7182BD657D4D52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTE2IGF0IDE5OjE0ICswODAwLCBTZWl5YSBXYW5nIHdyb3RlOg0KPiBB
ZGQgYmFzaWMgY2hpcCBzdXBwb3J0IGZvciBNZWRpYXRlayBNVDgxOTUNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNlaXlhIFdhbmcgPHNlaXlhLndhbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgfCAgIDEgKw0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUtZXZiLmR0cyB8ICAyOSArKw0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSAgICB8IDQ3NyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUwNyBpbnNlcnRpb25zKCsp
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
Ow0KPiArI2luY2x1ZGUgIm10ODE5NS5kdHNpIg0KPiArDQo+ICsvIHsNCj4gKwltb2RlbCA9ICJN
ZWRpYVRlayBNVDgxOTUgZXZhbHVhdGlvbiBib2FyZCI7DQo+ICsJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTUtZXZiIiwgIm1lZGlhdGVrLG10ODE5NSI7DQo+ICsNCj4gKwlhbGlhc2VzIHsN
Cj4gKwkJc2VyaWFsMCA9ICZ1YXJ0MDsNCj4gKwl9Ow0KPiArDQo+ICsJY2hvc2VuIHsNCj4gKwkJ
c3Rkb3V0LXBhdGggPSAic2VyaWFsMDo5MjE2MDBuOCI7DQo+ICsJfTsNCj4gKw0KPiArCW1lbW9y
eUA0MDAwMDAwMCB7DQo+ICsJCWRldmljZV90eXBlID0gIm1lbW9yeSI7DQo+ICsJCXJlZyA9IDww
IDB4NDAwMDAwMDAgMCAweDgwMDAwMDAwPjsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KPiArJnVhcnQw
IHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTk1LmR0c2kNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAwLi4zNTY1ODNmZTRmMDMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpDQo+IEBAIC0wLDAgKzEsNDc3IEBADQo+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0KPiArLyoNCj4gKyAq
IENvcHlyaWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ICsgKiBBdXRob3I6IFNlaXlhIFdh
bmcgPHNlaXlhLndhbmdAbWVkaWF0ZWsuY29tPg0KPiArICovDQo+ICsNCj4gKy9kdHMtdjEvOw0K
PiArDQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdp
Yy5oPg0KPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5o
Pg0KPiArDQo+ICsvIHsNCj4gKwljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NSI7DQo+ICsJ
aW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4gKwkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4g
Kwkjc2l6ZS1jZWxscyA9IDwyPjsNCj4gKw0KPiArCWNsb2NrcyB7DQo+ICsJCWNsazI2bTogb3Nj
aWxsYXRvcjAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+ICsJCQkjY2xv
Y2stY2VsbHMgPSA8MD47DQo+ICsJCQljbG9jay1mcmVxdWVuY3kgPSA8MjYwMDAwMDA+Ow0KPiAr
CQkJY2xvY2stb3V0cHV0LW5hbWVzID0gImNsazI2bSI7DQo+ICsJCX07DQo+ICsNCj4gKwkJY2xr
MzJrOiBvc2NpbGxhdG9yMSB7DQo+ICsJCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4g
KwkJCSNjbG9jay1jZWxscyA9IDwwPjsNCj4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwzMjc2OD47
DQo+ICsJCQljbG9jay1vdXRwdXQtbmFtZXMgPSAiY2xrMzJrIjsNCj4gKwkJfTsNCj4gKwl9Ow0K
Wy4uLl0NCj4gKw0KPiArCQlub3JfZmxhc2g6IG5vckAxMTMyYzAwMCB7DQo+ICsJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE5NS1ub3IiLCAibWVkaWF0ZWssbXQ4MTczLW5vciI7DQo+ICsJ
CQlyZWcgPSA8MCAweDExMzJjMDAwIDAgMHgxMDAwPjsNCj4gKwkJCWludGVycnVwdHMgPSA8R0lD
X1NQSSA4MjUgSVJRX1RZUEVfTEVWRUxfSElHSCAwPjsNCj4gKwkJCWNsb2NrcyA9IDwmY2xrMjZt
PiwgPCZjbGsyNm0+Ow0KPiArCQkJY2xvY2stbmFtZXMgPSAic3BpIiwgInNmIjsNCj4gKwkJCSNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KPiArCQl9Ow0KPiArDQo+ICsJCXUzcGh5MjogdXNiLXBoeTJAMTFj
NDAwMDAgew0KdXNlIHQtcGh5IGluc3RlYWQgb2YgdXNiLXBoeTINCg0KSXQncyBiZXR0ZXIgdG8g
cnVuIGR0YnNfY2hlY2sgZm9yIHRoaXMgcGF0Y2gNCg0KPiArCQkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTUtdHBoeSIsICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KPiArCQkJY2xv
Y2tzID0gPCZjbGsyNm0+Ow0KPiArCQkJY2xvY2stbmFtZXMgPSAidTNwaHlhX3JlZiI7DQpObyBu
ZWVkIGNsb2NrcyBmb3IgdjINCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJI3Np
emUtY2VsbHMgPSA8MT47DQo+ICsJCQlyYW5nZXMgPSA8MCAwIDB4MTFjNDAwMDAgMHg3MDA+Ow0K
PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJdTJwb3J0MjogdXNiMi1waHky
QDAgew0KdXNlIHVzYi1waHkgaW5zdGVhZCBvZiB1c2IyLXBoeTINCg0KPiArCQkJCXJlZyA9IDww
eDAgMHg3MDA+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gKwkJCQljbG9jay1uYW1l
cyA9ICJyZWYiOw0KPiArCQkJCSNwaHktY2VsbHMgPSA8MT47DQo+ICsJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCkkgdGhpbmsgbm8gbmVlZCBkaXNhYmxlIGl0DQppdCdzIHBhcmVudCBub2RlIGlz
IGFscmVhZHkgZGlzYWJsZWQuIGlmIGVuYWJsZSBwYXJlbnQgbm9kZSwNCndlIGFsc28gd2FudCB0
byBlbmFibGUgYWxsIGNoaWxkcmVuIGF0IHRoZSBzYW1lIHRpbWUuDQoNCj4gKwkJCX07DQo+ICsJ
CX07DQo+ICsNCj4gKwkJdTNwaHkzOiB1c2ItcGh5M0AxMWM1MDAwMCB7DQp0LXBoeUAuLi4NCj4g
KwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXRwaHkiLCAibWVkaWF0ZWssZ2VuZXJp
Yy10cGh5LXYyIjsNCj4gKwkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gKwkJCWNsb2NrLW5hbWVz
ID0gInUzcGh5YV9yZWYiOw0KTm8gbmVlZCBjbG9ja3MNCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCQlyYW5nZXMgPSA8MCAwIDB4MTFj
NTAwMDAgMHg3MDA+Ow0KPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJdTJw
b3J0MzogdXNiMi1waHkzQDAgew0KdXNlIHVzYi1waHkNCj4gKwkJCQlyZWcgPSA8MHgwIDB4NzAw
PjsNCj4gKwkJCQljbG9ja3MgPSA8JmNsazI2bT47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAicmVm
IjsNCj4gKwkJCQkjcGh5LWNlbGxzID0gPDE+Ow0KPiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQpyZW1vdmUgc3RhdHVzDQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArDQo+ICsJCXUzcGh5MTogdXNi
LXBoeTFAMTFlMzAwMDAgew0KdC1waHkNCj4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk1LXRwaHkiLCAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCj4gKwkJCWNsb2NrcyA9IDwm
Y2xrMjZtPjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gInUzcGh5YV9yZWYiOw0KcmVtb3ZlIGNsb2Nr
cyoNCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJI3NpemUtY2VsbHMgPSA8MT47
DQo+ICsJCQlyYW5nZXMgPSA8MCAwIDB4MTFlMzAwMDAgMHhlMDA+Ow0KPiArCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gKw0KPiArCQkJdTJwb3J0MTogdXNiMi1waHkxQDAgew0KdXNiLXBoeQ0K
PiArCQkJCXJlZyA9IDwweDAgMHg3MDA+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4g
KwkJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiArCQkJCSNwaHktY2VsbHMgPSA8MT47DQo+ICsJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCnJlbW92ZSBzdGF0dXMNCj4gKwkJCX07DQo+ICsNCj4g
KwkJCXUzcG9ydDE6IHVzYjMtcGh5MUA3MDAgew0KdXNiLXBoeQ0KPiArCQkJCXJlZyA9IDwweDcw
MCAweDcwMD47DQo+ICsJCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KPiArCQkJCWNsb2NrLW5hbWVz
ID0gInJlZiI7DQo+ICsJCQkJI3BoeS1jZWxscyA9IDwxPjsNCj4gKwkJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KcmVtb3ZlIHN0YXR1cw0KPiArCQkJfTsNCj4gKwkJfTsNCj4gKw0KPiArCQl1M3Bo
eTA6IHVzYi1waHkwQDExZTQwMDAwIHsNCnQtcGh5DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE5NS10cGh5IiwgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiI7DQo+ICsJCQljbG9j
a3MgPSA8JmNsazI2bT47DQo+ICsJCQljbG9jay1uYW1lcyA9ICJ1M3BoeWFfcmVmIjsNCnJlbW92
ZSBjbG9ja3MqDQo+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJCSNzaXplLWNlbGxz
ID0gPDE+Ow0KPiArCQkJcmFuZ2VzID0gPDAgMCAweDExZTQwMDAwIDB4ZTAwPjsNCj4gKwkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCXUycG9ydDA6IHVzYjItcGh5MEAwIHsNCnVz
Yi1waHkNCj4gKwkJCQlyZWcgPSA8MHgwIDB4NzAwPjsNCj4gKwkJCQljbG9ja3MgPSA8JmNsazI2
bT47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCj4gKwkJCQkjcGh5LWNlbGxzID0gPDE+
Ow0KPiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQpyZW1vdmUgc3RhdHVzDQo+ICsJCQl9Ow0K
PiArDQo+ICsJCQl1M3BvcnQwOiB1c2IzLXBoeTBANzAwIHsNCnVzYi1waHkNCj4gKwkJCQlyZWcg
PSA8MHg3MDAgMHg3MDA+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gKwkJCQljbG9j
ay1uYW1lcyA9ICJyZWYiOw0KPiArCQkJCSNwaHktY2VsbHMgPSA8MT47DQo+ICsJCQkJc3RhdHVz
ID0gImRpc2FibGVkIjsNCnJlbW92ZSBzdGF0dXMNCj4gKwkJCX07DQo+ICsJCX07DQo+ICsNCj4g
KwkJdWZzcGh5OiBwaHlAMTFmYTAwMDAgew0KdXNmLXBoeSBpbnN0ZWFkIG9mIHBoeQ0KPiArCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtdWZzcGh5IiwgIm1lZGlhdGVrLG10ODE4My11
ZnNwaHkiOw0KPiArCQkJcmVnID0gPDAgMHgxMWZhMDAwMCAwIDB4YzAwMD47DQo+ICsJCQljbG9j
a3MgPSA8JmNsazI2bT4sIDwmY2xrMjZtPjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gInVuaXBybyIs
ICJtcCI7DQo+ICsJCQkjcGh5LWNlbGxzID0gPDA+Ow0KZGlzYWJsZWQ/DQoNClRoYW5rcyBhIGxv
dA0KDQo+ICsJCX07DQo+ICsJfTsNCj4gK307DQoNCg==

