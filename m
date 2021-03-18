Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6912933FD41
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 03:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCRCeM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 22:34:12 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47059 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229702AbhCRCdt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 22:33:49 -0400
X-UUID: 0e89e7ee279b4ca1b108ed7c4659f836-20210318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ncyiACvRA/jFcclY/OBN/Yo/pl71fDIdCQA7DujzOC8=;
        b=c86IdfXdnSCP0m4LZwDXJ7zWdT0QROGKq1gaybf0iiGEVyyN+y1SJF1w64qMi25YxohPM6NAQUO5by4TgDJrjg+NwKlkBHPWdjOTleQ29UljMd1xHhgyouEi1XbhNjRRnJOAjz45bWWq1Q190co8MJCdZg6SOrkjUGGFd60CbO0=;
X-UUID: 0e89e7ee279b4ca1b108ed7c4659f836-20210318
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 8153724; Thu, 18 Mar 2021 10:33:45 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Mar
 2021 10:33:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 10:33:40 +0800
Message-ID: <1616034820.25733.15.camel@mhfsdcap03>
Subject: Re: [PATCH 08/10] dt-bindings: phy: Add compatible for Mediatek
 MT8195
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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
Date:   Thu, 18 Mar 2021 10:33:40 +0800
In-Reply-To: <YFGkQq1J0g4AKTNZ@vkoul-mobl.Dlink>
References: <20210316111443.3332-1-seiya.wang@mediatek.com>
         <20210316111443.3332-9-seiya.wang@mediatek.com>
         <YFGkQq1J0g4AKTNZ@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2A914A0A68FE97BF815737A03C347727B59FF0E01BB1CD724B858EB4526684EB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgVmlub2QsDQoNCk9uIFdlZCwgMjAyMS0wMy0xNyBhdCAxMjoxMCArMDUzMCwgVmlub2QgS291
bCB3cm90ZToNCj4gT24gMTYtMDMtMjEsIDE5OjE0LCBTZWl5YSBXYW5nIHdyb3RlOg0KPiA+IFRo
aXMgY29tbWl0IGFkZHMgZHQtYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIFVGUyBNLVBoeSBmb3Ig
TWVkaWF0ZWsgTVQ4MTk1IFNvQw0KPiA+IFBsYXRmb3JtLg0KPiANCj4gQXBwbGllZCwgdGhhbmtz
DQoNClVzdWFsbHksIHdlIGV4cGVjdCB0aGUgZHQtYmluZGluZyBwYXRjaCBpcyBhY2tlZCBvciBy
ZXZpZXdlZCBieSBSb2INCmJlZm9yZSBpdCdzIGFwcGxpZWQ/DQoNClRoYW5rcyBhIGxvdA0KDQo+
IA0KDQo=

