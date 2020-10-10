Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB928A36E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 01:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbgJJW5G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731820AbgJJTh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:37:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BC822228;
        Sat, 10 Oct 2020 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602349445;
        bh=s083QnhbFPBYesVOpB+LThFjG2NY4u/5rmNI7PXW9MY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O9hA6G3nCtxHz/jKYKu9PGVC9m4pvcLZCbb7lTdJgOJAgA7ntjd98+TlSxODIrSgX
         veE4QHsJRTm3cqlmwrPAo1r41Wr+Pii4gz/85aaDC+gsuZpqqaJCF1a/ELDKomW4M7
         0Qyzh8NFsFAzNssfMqtsLv0hL2MYnAM9hdpMKKgo=
Date:   Sat, 10 Oct 2020 18:04:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad7303: remove platform data header
Message-ID: <20201010180400.09658b3c@archlinux>
In-Reply-To: <20201001141004.53846-1-alexandru.ardelean@analog.com>
References: <20201001141004.53846-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Oct 2020 17:10:04 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The information in the ad7303 platform_data header is unused, so it's dead
> code.
> This change removes it and it's inclusion from the driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/dac/ad7303.c             |  2 --
>  include/linux/platform_data/ad7303.h | 20 --------------------
>  2 files changed, 22 deletions(-)
>  delete mode 100644 include/linux/platform_data/ad7303.h
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 2e46def9d8ee..dbb4645ab6b1 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -17,8 +17,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include <linux/platform_data/ad7303.h>
> -
>  #define AD7303_CFG_EXTERNAL_VREF BIT(15)
>  #define AD7303_CFG_POWER_DOWN(ch) BIT(11 + (ch))
>  #define AD7303_CFG_ADDR_OFFSET	10
> diff --git a/include/linux/platform_data/ad7303.h b/include/linux/platform_data/ad7303.h
> deleted file mode 100644
> index c2bd0a13bea1..000000000000
> --- a/include/linux/platform_data/ad7303.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Analog Devices AD7303 DAC driver
> - *
> - * Copyright 2013 Analog Devices Inc.
> - */
> -
> -#ifndef __IIO_ADC_AD7303_H__
> -#define __IIO_ADC_AD7303_H__
> -
> -/**
> - * struct ad7303_platform_data - AD7303 platform data
> - * @use_external_ref: If set to true use an external voltage reference connected
> - * to the REF pin, otherwise use the internal reference derived from Vdd.
> - */
> -struct ad7303_platform_data {
> -	bool use_external_ref;
> -};
> -
> -#endif

