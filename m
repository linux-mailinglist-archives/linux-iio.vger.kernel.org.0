Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28F224C84
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGRPdV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgGRPdV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:33:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2E920734;
        Sat, 18 Jul 2020 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086400;
        bh=fgzI3qLM4aPdSKLycUITv5yItcQksA1tIB1bNjqV/Qo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qzirfRVSK0Z1Nb2VomqUf2IChB7xsQ26iWOmhMnNBpjLNDI8J6kqvWjtHdBnnCxAk
         6Btp5R4ikm/XBW7W6Ax5td9w2euQ9kMVi2nN0FQqWjZXpBFN1NHaatmTVIyw9AWRxQ
         /DJCR0qQujAzupNtHSdqdLpRP7Rb5SU+R0bj9YVo=
Date:   Sat, 18 Jul 2020 16:33:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, J Keerthy <j-keerthy@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>,
        Amit Kucheria <amit.kucheria@canonical.com>
Subject: Re: [PATCH 03/30] iio: adc: twl4030-madc: Fix misnamed struct
 attribute
Message-ID: <20200718163315.631513b0@archlinux>
In-Reply-To: <20200717165538.3275050-4-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-4-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:11 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/twl4030-madc.c:170: warning: Function parameter or member 'usb3v1' not described in 'twl4030_madc_data'
> 
> Cc: J Keerthy <j-keerthy@ti.com>
> Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
> Cc: Amit Kucheria <amit.kucheria@canonical.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied with a note that this also cleans up the duplicate docs for lock.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/twl4030-madc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 826d8295e9b3c..882a678b44690 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -153,7 +153,7 @@ enum sample_type {
>   * struct twl4030_madc_data - a container for madc info
>   * @dev:		Pointer to device structure for madc
>   * @lock:		Mutex protecting this data structure
> - * @regulator:		Pointer to bias regulator for madc
> + * @usb3v1:		Pointer to bias regulator for madc
>   * @requests:		Array of request struct corresponding to SW1, SW2 and RT
>   * @use_second_irq:	IRQ selection (main or co-processor)
>   * @imr:		Interrupt mask register of MADC
> @@ -161,7 +161,7 @@ enum sample_type {
>   */
>  struct twl4030_madc_data {
>  	struct device *dev;
> -	struct mutex lock;	/* mutex protecting this data structure */
> +	struct mutex lock;
>  	struct regulator *usb3v1;
>  	struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
>  	bool use_second_irq;

