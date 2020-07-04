Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C192147B7
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGDRYl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgGDRYl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:24:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209A020739;
        Sat,  4 Jul 2020 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883481;
        bh=OWx5WdkOERiAy5uzrHySj0am97sSaVVjcmlFVlO5gMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F6275aq7Wxb4YvCSurEF24ArCyJOpaw/fxrc9L7sgs21KZetBIHmfh/8WfSLNsMKo
         ajv0YeYMpf0lqzhghmoul4Tln+sCkBkQwArqRxW0nrzRnW3OqbpAVYnujaR0Dye/yM
         AF3R4TsXygZABOZvXSNMv0NvOwn1AvOQftdnMpoU=
Date:   Sat, 4 Jul 2020 18:24:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 14/23] iio:adc:sd_adc_modulator: Drop of_match_ptr and
 tweak includes
Message-ID: <20200704182437.2720a39a@archlinux>
In-Reply-To: <20200628123654.32830-15-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-15-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Dropping of_match_ptr allows this driver to be used with ACPI.
> The header includes are adjusted to include platform_device.h
> and mod_devicetable.h instead of OF specific header as nothing
> from that header itself is actually used.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Applied.

Thanks,

J
> ---
>  drivers/iio/adc/sd_adc_modulator.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
> index 1d6c246609c8..327cc2097f6c 100644
> --- a/drivers/iio/adc/sd_adc_modulator.c
> +++ b/drivers/iio/adc/sd_adc_modulator.c
> @@ -9,7 +9,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
>  
>  static const struct iio_info iio_sd_mod_iio_info;
>  
> @@ -54,7 +55,7 @@ MODULE_DEVICE_TABLE(of, sd_adc_of_match);
>  static struct platform_driver iio_sd_mod_adc = {
>  	.driver = {
>  		.name = "iio_sd_adc_mod",
> -		.of_match_table = of_match_ptr(sd_adc_of_match),
> +		.of_match_table = sd_adc_of_match,
>  	},
>  	.probe = iio_sd_mod_probe,
>  };

