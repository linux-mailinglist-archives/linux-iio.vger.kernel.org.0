Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3441226C71D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgIPSSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgIPSSD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 14:18:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E45821655;
        Wed, 16 Sep 2020 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600280282;
        bh=RYA2LrqTsqrb7hEDg4AHEnfPPnO9ZBUXZ0TGxhqVARc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=weYbHppDCrwYigvxNzFvcXpvJJT9ohm168FMXhRF34I2B0QXIuLTU78BOBxx0ctSz
         0XPZ17WLiS/WQeeIr/AtQoMWi/n66lqxwbUmRR/xpOsJtp3llOJEqb8t/ufX2G/WgK
         t2hIYQEN6FC8J4NJYlB5rFylTFXC4VhFPv02H0FA=
Date:   Wed, 16 Sep 2020 19:17:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: Make the of_device_id array
 style consistent
Message-ID: <20200916191756.6f53853a@archlinux>
In-Reply-To: <20200915192621.13202-1-martin.blumenstingl@googlemail.com>
References: <20200915192621.13202-1-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 21:26:21 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Use only one line for the closing bracket of the last entry and the
> opening bracket for the next one to keep the style across the whole
> array consistent. Also add a "sentinel" comment to the last entry and
> remove the comma to ensure that there won't be any entry after it.
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 95bd187de1cb..e03988698755 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1150,16 +1150,13 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
>  	{
>  		.compatible = "amlogic,meson8-saradc",
>  		.data = &meson_sar_adc_meson8_data,
> -	},
> -	{
> +	}, {
>  		.compatible = "amlogic,meson8b-saradc",
>  		.data = &meson_sar_adc_meson8b_data,
> -	},
> -	{
> +	}, {
>  		.compatible = "amlogic,meson8m2-saradc",
>  		.data = &meson_sar_adc_meson8m2_data,
> -	},
> -	{
> +	}, {
>  		.compatible = "amlogic,meson-gxbb-saradc",
>  		.data = &meson_sar_adc_gxbb_data,
>  	}, {
> @@ -1175,7 +1172,7 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
>  		.compatible = "amlogic,meson-g12a-saradc",
>  		.data = &meson_sar_adc_g12a_data,
>  	},
> -	{},
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, meson_sar_adc_of_match);
>  

