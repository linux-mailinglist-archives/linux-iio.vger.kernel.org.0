Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9022C41
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfETGrc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 02:47:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27037 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729657AbfETGrc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 02:47:32 -0400
X-UUID: 51613d8a8e634b58a4335f57e3397874-20190520
X-UUID: 51613d8a8e634b58a4335f57e3397874-20190520
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 101237753; Mon, 20 May 2019 14:47:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 14:47:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 14:47:24 +0800
Message-ID: <1558334844.13182.7.camel@mtkswgap22>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: mediatek: Add document for
 mt6765
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>
Date:   Mon, 20 May 2019 14:47:24 +0800
In-Reply-To: <20190518113356.1cf99a31@archlinux>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
         <1557994247-16739-2-git-send-email-chun-hung.wu@mediatek.com>
         <20190518113356.1cf99a31@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 136E65FE89BA7E502B30A204F640972BA020EFA250DD3943DEB1B7A03C25AD6D2000:8
X-MTK:  N
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, 2019-05-18 at 11:33 +0100, Jonathan Cameron wrote:
> On Thu, 16 May 2019 16:10:44 +0800
> Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
> 
> > Add compatible node for mt6765 auxadc
> > 
> > Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> Applied, but in numeric order.  There was also another clashing patch
> that caused some fuzz.
No problem, thanks!

regards,
Chun-Hung
> 
> thanks,
> 
> Jonathan
> 
> > ---
> >  Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> > index 0df9bef..ab7efab 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >      - "mediatek,mt2712-auxadc": For MT2712 family of SoCs
> >      - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
> >      - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
> > +    - "mediatek,mt6765-auxadc": For MT6765 family of SoCs
> >    - reg: Address range of the AUXADC unit.
> >    - clocks: Should contain a clock specifier for each entry in clock-names
> >    - clock-names: Should contain "main".
> 


