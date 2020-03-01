Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 597DA174E10
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCAPt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 10:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPt2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 10:49:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B07321D56;
        Sun,  1 Mar 2020 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583077767;
        bh=QXNouIfww46q+/aWNgIawm03vLObhK2nDx+I8UvrfbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cbSWpQDBj49teDJX1aBL8EMtwMeMMVD0+Q4B1b0uF8x/8badhDR9qiWCmfi5cNy4B
         bLUWMFAGD2D9C6HcLAKTonBlT4lhHksM1vPJm7vl8fi8lImxElCRe18aGsozOG4EiI
         1EdHlRX3ErfpMst9LAAbhWsWP04nWhHcUF8yCS9c=
Date:   Sun, 1 Mar 2020 15:49:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <tglx@linutronix.de>, <alexios.zavras@intel.com>,
        <allison@lohutok.net>, <kstewart@linuxfoundation.org>
Subject: Re: [PATCH] iio: adc: max1118: Use new structure for SPI transfer
 delays
Message-ID: <20200301154920.208b7b38@archlinux>
In-Reply-To: <20200227122515.16628-1-sergiu.cuciurean@analog.com>
References: <20200227122515.16628-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 14:25:15 +0200
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1118.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
> index 3b6f3b9a6c5b..0c5d7aaf6826 100644
> --- a/drivers/iio/adc/max1118.c
> +++ b/drivers/iio/adc/max1118.c
> @@ -71,7 +71,10 @@ static int max1118_read(struct spi_device *spi, int channel)
>  		 */
>  		{
>  			.len = 0,
> -			.delay_usecs = 1,	/* > CNVST Low Time 100 ns */
> +			.delay = {	/* > CNVST Low Time 100 ns */
> +				.value = 1,
> +				.unit = SPI_DELAY_UNIT_USECS
> +			},
>  			.cs_change = 1,
>  		},
>  		/*
> @@ -81,7 +84,10 @@ static int max1118_read(struct spi_device *spi, int channel)
>  		 */
>  		{
>  			.len = 0,
> -			.delay_usecs = 8,
> +			.delay = {
> +				.value = 8,
> +				.unit = SPI_DELAY_UNIT_USECS
> +			},
>  		},
>  		{
>  			.rx_buf = &adc->data,

