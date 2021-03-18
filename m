Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4933FF32
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 07:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhCRGEj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 02:04:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:28003 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229624AbhCRGEj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 02:04:39 -0400
X-UUID: ab35a7e1bfa848d18c8931c06da7d1e1-20210318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OEFsZyvsUcsDp4NLQV01Fsmg/mqaIcF23ounLLTiW+k=;
        b=R/+PqgsxBMFOSrCKoomHNdsb3ZKaYmKiObgd49xmcLk0K7wikH34mCEt5Glw+/a5RcKYnt0nyzeeS4TUlyHWtXFDbkoECofVc3w86nzR+TFUA0PGUsdIKI+JFc3e0NuJQ/qvgONcYRl0rt9jKP3+pPmkhlTm0rL518aJ8bOv4OI=;
X-UUID: ab35a7e1bfa848d18c8931c06da7d1e1-20210318
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1014725055; Thu, 18 Mar 2021 14:04:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Mar 2021 14:04:27 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 14:04:27 +0800
Message-ID: <1616047467.29855.4.camel@mtksdccf07>
Subject: Re: [PATCH 08/10] dt-bindings: phy: Add compatible for Mediatek
 MT8195
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
Date:   Thu, 18 Mar 2021 14:04:27 +0800
In-Reply-To: <1616033945.25733.7.camel@mhfsdcap03>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
         <20210316111443.3332-9-seiya.wang@mediatek.com>
         <1616033945.25733.7.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FEA5D4ADAF4C0F5C88C06D981522F13AB43C7BC46D58BACB42096B1411175DE72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTE4IGF0IDEwOjE5ICswODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyMS0wMy0xNiBhdCAxOToxNCArMDgwMCwgU2VpeWEgV2FuZyB3cm90ZToNCj4g
PiBUaGlzIGNvbW1pdCBhZGRzIGR0LWJpbmRpbmcgZG9jdW1lbnRhdGlvbiBvZiBVRlMgTS1QaHkg
Zm9yIE1lZGlhdGVrIE1UODE5NSBTb0MNCj4gPiBQbGF0Zm9ybS4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTZWl5YSBXYW5nIDxzZWl5YS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx1ZnMtcGh5
LnlhbWwgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVk
aWF0ZWssdWZzLXBoeS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bo
eS9tZWRpYXRlayx1ZnMtcGh5LnlhbWwNCj4gPiBpbmRleCAzYTliZTgyZTdmMTMuLjUyMzViMWEw
ZDE4OCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGh5L21lZGlhdGVrLHVmcy1waHkueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55YW1sDQo+ID4gQEAgLTIyLDYgKzIy
LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIHBhdHRlcm46ICJedWZzLXBoeUBbMC05YS1mXSsk
Ig0KPiA+ICANCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgZW51bTogbWVkaWF0ZWssbXQ4
MTk1LXVmc3BoeQ0KPiA+ICAgICAgY29uc3Q6IG1lZGlhdGVrLG10ODE4My11ZnNwaHkNCj4gPiAg
DQo+IFRoZXJlIGlzIHdhcm5pbmcgd2hlbiBJIG1ha2UgZHRfYmluZGluZ19jaGVjaywgaWYgbXQ4
MTk1IGlzIGNvbXBhdGlibGUNCj4gd2l0aCBtdDgxODMsIHdpbGwgYWRkIGl0IGFzIGZvbGxvd2lu
ZzoNCj4gDQo+ICAgICBvbmVPZjoNCj4gICAgICAgLSBpdGVtczoNCj4gICAgICAgICAgIC0gZW51
bToNCj4gICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS11ZnNwaHkNCj4gICAgICAgICAg
IC0gY29uc3Q6IG1lZGlhdGVrLG10ODE4My11ZnNwaHkNCj4gICAgICAgLSBjb25zdDogbWVkaWF0
ZWssbXQ4MTgzLXVmc3BoeQ0KPiANCj4gRHVlIHRvIFZpbm9kIGFscmVhZHkgYXBwbHkgdGhpcyBw
YXRjaCwgSSdsbCBzZW5kIG91dCBhIGZpeCBwYXRjaCBsYXRlcg0KPiANCj4gVGhhbmtzDQoNCkkg
d2lsbCB1cGRhdGUgdGhlIHBhdGNoIGFmdGVyIGEgbmV3IGxpbnV4LW5leHQgdGFnIGF2YWlsYWJs
ZS4NClRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNCj4gPiAgICByZWc6DQo+IA0KPiANCg0K

