Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039CC2A1F2F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgKAPk0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgKAPk0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:40:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86DD22246;
        Sun,  1 Nov 2020 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604245225;
        bh=wQmipAoDhEbdujXSTlXDShPDCg7E6gH2wo7ek0okswY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F6mj5mGLGhVITvzq0x+G7O94aulBjPSZ6sbGvqxuWSQg002gGXZvPv734jui+jdxN
         ZE+dvg8m5UnfsqgwbgJXaDCbbvp41qOjtyrBPCji59FGE/wyi3XfEfbu5RbkE4Zgdq
         UyL3XdGeM+OOynqLzJPJM/D7GRpLQjub9pHZbDWo=
Date:   Sun, 1 Nov 2020 15:40:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v7 0/3] iio: adc: mt6360: Add ADC driver for MT6360
Message-ID: <20201101154019.39932a2e@archlinux>
In-Reply-To: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Oct 2020 16:07:44 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> In-Reply-To: 
> 
> This patch series add MT6360 ADC support contains driver, testing document
> and binding document
> 
Hi Gene,

Other than that small edit needed in the dt binding this is stalled on
the label code getting upstreamed into the core.

I've asked Cristian to repost that so hopefully we can resolve that dependency
and get this merged fairly soon.

For the dt thing I can just drop the description entirely, but would prefer
if you sent a v8 fixing the tags issue Rob pointed out and also fixing that
description.

Thanks,

Jonathan

> Gene Chen (2)
>   dt-bindings: iio: adc: add bindings doc for MT6360 ADC
>   Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
>   iio: adc: mt6360: Add ADC driver for MT6360
> 
>  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360                 |   78 ++
>  Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml |   34 
>  drivers/iio/adc/Kconfig                                            |   11 
>  drivers/iio/adc/Makefile                                           |    1 
>  drivers/iio/adc/mt6360-adc.c                                       |  372 ++++++++++
>  5 files changed, 496 insertions(+)
> 
> changelogs between v1 & v2
>  - adc: use IIO_CHAN_INFO_PROCESSED only
>  - adc: use devm_iio_triggered_buffer_setup
>  - adc: use use s64 to record timestamp
> 
> changelogs between v2 & v3
>  - Rearrange include file order by alphabet
>  - Set line length constraint below 100
>  - Add Document for testing adc sysfs node guideline
>  - Set compiler 64 bit aligned when handle iio timestamp
> 
> changelogs between v3 & v4
>  - Fix sysfs guideline description
>  - Replace iio channel processed by raw/scale/offset
>  - Add comment of read adc flow for special HW design
> 
> changelogs between v4 & v5
>  - Rename dt-bindings aligned to file name
>  - Aligned sysfs node name with driver and add VBUSDIVX description
>  - Add ADC channel sysfs node "*_labels"
> 
> changelogs between v5 & v6
>  - Memset aligned adc data
>  - Remove strong casting void pointer
> 
> changelogs between v6 & v7
>  - Avoid adc polling infinite loop
> 

