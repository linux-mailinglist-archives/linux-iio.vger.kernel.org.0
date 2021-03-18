Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60C33FD24
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 03:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCRCTk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 22:19:40 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:19283 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229472AbhCRCTP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 22:19:15 -0400
X-UUID: c905431e1f3f4a5299a5323149f077f1-20210318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fvS14rbiT2d22DFwCGoxXDf2m5IbaDkfUXz9j0R/ZyY=;
        b=utMmE0P5iSOuXkT/WqV2aM+LMzPjydIn9h3v2TxGWOcXfp6a+8cg0p55E3nikWxXHIh4GG9/EKQFk4K1u5T708S/NDTgK3MsS9GZgCBim/ynCedHTq8vEfZ+c082f4Km2ckWlPu4PPRrageCcASeB0Tde4/5fcMGI/H0vH0nOAg=;
X-UUID: c905431e1f3f4a5299a5323149f077f1-20210318
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1353121258; Thu, 18 Mar 2021 10:19:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Mar
 2021 10:19:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 10:19:05 +0800
Message-ID: <1616033945.25733.7.camel@mhfsdcap03>
Subject: Re: [PATCH 08/10] dt-bindings: phy: Add compatible for Mediatek
 MT8195
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
Date:   Thu, 18 Mar 2021 10:19:05 +0800
In-Reply-To: <20210316111443.3332-9-seiya.wang@mediatek.com>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
         <20210316111443.3332-9-seiya.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B58A0C7D8BC9BE44BF3BB2CCC0B6C0A769AC13E5E1AA726D14F7FBB3F75F4B022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTE2IGF0IDE5OjE0ICswODAwLCBTZWl5YSBXYW5nIHdyb3RlOg0KPiBU
aGlzIGNvbW1pdCBhZGRzIGR0LWJpbmRpbmcgZG9jdW1lbnRhdGlvbiBvZiBVRlMgTS1QaHkgZm9y
IE1lZGlhdGVrIE1UODE5NSBTb0MNCj4gUGxhdGZvcm0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
ZWl5YSBXYW5nIDxzZWl5YS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHVmcy1waHkueWFtbCB8IDEgKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx1ZnMtcGh5LnlhbWwg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHVmcy1waHku
eWFtbA0KPiBpbmRleCAzYTliZTgyZTdmMTMuLjUyMzViMWEwZDE4OCAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx1ZnMtcGh5Lnlh
bWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRl
ayx1ZnMtcGh5LnlhbWwNCj4gQEAgLTIyLDYgKzIyLDcgQEAgcHJvcGVydGllczoNCj4gICAgICBw
YXR0ZXJuOiAiXnVmcy1waHlAWzAtOWEtZl0rJCINCj4gIA0KPiAgICBjb21wYXRpYmxlOg0KPiAr
ICAgIGVudW06IG1lZGlhdGVrLG10ODE5NS11ZnNwaHkNCj4gICAgICBjb25zdDogbWVkaWF0ZWss
bXQ4MTgzLXVmc3BoeQ0KPiAgDQpUaGVyZSBpcyB3YXJuaW5nIHdoZW4gSSBtYWtlIGR0X2JpbmRp
bmdfY2hlY2ssIGlmIG10ODE5NSBpcyBjb21wYXRpYmxlDQp3aXRoIG10ODE4Mywgd2lsbCBhZGQg
aXQgYXMgZm9sbG93aW5nOg0KDQogICAgb25lT2Y6DQogICAgICAtIGl0ZW1zOg0KICAgICAgICAg
IC0gZW51bToNCiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtdWZzcGh5DQogICAgICAg
ICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTgzLXVmc3BoeQ0KICAgICAgLSBjb25zdDogbWVkaWF0
ZWssbXQ4MTgzLXVmc3BoeQ0KDQpEdWUgdG8gVmlub2QgYWxyZWFkeSBhcHBseSB0aGlzIHBhdGNo
LCBJJ2xsIHNlbmQgb3V0IGEgZml4IHBhdGNoIGxhdGVyDQoNClRoYW5rcw0KDQo+ICAgIHJlZzoN
Cg0K

