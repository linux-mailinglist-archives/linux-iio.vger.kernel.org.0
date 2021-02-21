Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772EA320B9D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBUQCZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:02:25 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBUQCY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2021 11:02:24 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1EC029E008E;
        Sun, 21 Feb 2021 16:01:41 +0000 (GMT)
Date:   Sun, 21 Feb 2021 16:01:35 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stable@vger.kernel.org
Subject: Re: [PATCH] iio:adc:stm32-adc: Add HAS_IOMEM dependency
Message-ID: <20210221160135.5437e083@archlinux>
In-Reply-To: <20210124195034.22576-1-jic23@kernel.org>
References: <20210124195034.22576-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Jan 2021 19:50:34 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Seems that there are config combinations in which this driver gets enabled
> and hence selects the MFD, but with out HAS_IOMEM getting pulled in
> via some other route.  MFD is entirely contained in an
> if HAS_IOMEM block, leading to the build issue in this bugzilla.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=209889
> 
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the fixes-togreg branch of iio.git.

Thanks

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index bf7d22fa4be2..6605c263949c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -923,6 +923,7 @@ config STM32_ADC_CORE
>  	depends on ARCH_STM32 || COMPILE_TEST
>  	depends on OF
>  	depends on REGULATOR
> +	depends on HAS_IOMEM
>  	select IIO_BUFFER
>  	select MFD_STM32_TIMERS
>  	select IIO_STM32_TIMER_TRIGGER

