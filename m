Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD604320A1E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBUL6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 06:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUL6O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 06:58:14 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50E964E12;
        Sun, 21 Feb 2021 11:57:32 +0000 (UTC)
Date:   Sun, 21 Feb 2021 11:57:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: fix typo in doc-string
Message-ID: <20210221115732.7b29bf73@archlinux>
In-Reply-To: <20210219090134.48057-1-alexandru.ardelean@analog.com>
References: <20210219090134.48057-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Feb 2021 11:01:34 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The channels are of type iio_chan_spec, not axi_adc_chan_spec. They were in
> some earlier version, but forgot to rename in the doc-string.
> 
> Fixes: ef04070692a21 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to probably ignore,.

Thanks,

Jonathan

> ---
>  include/linux/iio/adc/adi-axi-adc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/adc/adi-axi-adc.h b/include/linux/iio/adc/adi-axi-adc.h
> index c5d48e1c2d36..52620e5b8052 100644
> --- a/include/linux/iio/adc/adi-axi-adc.h
> +++ b/include/linux/iio/adc/adi-axi-adc.h
> @@ -15,7 +15,7 @@ struct iio_chan_spec;
>   * struct adi_axi_adc_chip_info - Chip specific information
>   * @name		Chip name
>   * @id			Chip ID (usually product ID)
> - * @channels		Channel specifications of type @struct axi_adc_chan_spec
> + * @channels		Channel specifications of type @struct iio_chan_spec
>   * @num_channels	Number of @channels
>   * @scale_table		Supported scales by the chip; tuples of 2 ints
>   * @num_scales		Number of scales in the table

