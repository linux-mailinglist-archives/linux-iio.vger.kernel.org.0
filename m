Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3C28A37B
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 01:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgJJW5B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731123AbgJJTCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:02:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112712242B;
        Sat, 10 Oct 2020 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602349041;
        bh=tvRSA9R+WFrxxVwgdjd4mNTVYdF+H8JAqH74nfC64co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZgbF8bwi2UcwgQkisyGyNYTjjBlwqldV4vgAnD3Jv5bGIF2p9LtXEWQc1F+78JT0D
         xY4+fZfeFRbH0/40ELyQHlLcLjTNDdVRKOYQhEiTuNQ+liidwbYO0y4f7u9DpGQ5lN
         EVgZQalZesICskJ4Xb2cFQ0mX0R9DnjdXxYF+l3c=
Date:   Sat, 10 Oct 2020 17:57:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v6 0/3] iio: adc: mt6360: Add ADC driver for MT6360
Message-ID: <20201010175714.0fb968ab@archlinux>
In-Reply-To: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Oct 2020 16:54:05 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> This patch series add MT6360 ADC support contains driver, testing document
> and binding document
> 
> Gene Chen (2)
>   dt-bindings: iio: adc: add bindings doc for MT6360 ADC
>   Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
>   iio: adc: mt6360: Add ADC driver for MT6360

Hi Gene

This looks good to me.  I'm just waiting now on some final
reviews for the patch that adds the label attribute support.
Once those are in I'll pick your driver up as well.

If I seem to have lost it, feel free to poke me!

Thanks,

Jonathan

> 
>  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360                 |   78 ++
>  Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml |   34 
>  drivers/iio/adc/Kconfig                                            |   11 
>  drivers/iio/adc/Makefile                                           |    1 
>  drivers/iio/adc/mt6360-adc.c                                       |  362 ++++++++++
>  5 files changed, 486 insertions(+)
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

