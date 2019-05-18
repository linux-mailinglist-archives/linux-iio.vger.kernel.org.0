Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B302233A
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfERKeD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERKeD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 06:34:03 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D19320B7C;
        Sat, 18 May 2019 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558175642;
        bh=VMARFvnnTUIC5vZdI9kptGm1fgzrLnWcRpVCTr+Ikfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HB7JOOfXrSeQLf12FFYxdrQT7XLZDS2E6ebKyEbzH01r31WKlEby4x5AxHDqRlfpY
         kzl0kD5h0eIZGyIJB/ptMxdZ26lE9PuvWmQbZf22d/XbZlc0elxdxcoRJW+o4XiXYF
         o2oiVwDN8XRjAwd85HGOcilfWsXQZB+wT3RwSJj0=
Date:   Sat, 18 May 2019 11:33:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
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
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: mediatek: Add document for
 mt6765
Message-ID: <20190518113356.1cf99a31@archlinux>
In-Reply-To: <1557994247-16739-2-git-send-email-chun-hung.wu@mediatek.com>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
        <1557994247-16739-2-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 May 2019 16:10:44 +0800
Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:

> Add compatible node for mt6765 auxadc
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
Applied, but in numeric order.  There was also another clashing patch
that caused some fuzz.

thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> index 0df9bef..ab7efab 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> @@ -15,6 +15,7 @@ Required properties:
>      - "mediatek,mt2712-auxadc": For MT2712 family of SoCs
>      - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
>      - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
> +    - "mediatek,mt6765-auxadc": For MT6765 family of SoCs
>    - reg: Address range of the AUXADC unit.
>    - clocks: Should contain a clock specifier for each entry in clock-names
>    - clock-names: Should contain "main".

