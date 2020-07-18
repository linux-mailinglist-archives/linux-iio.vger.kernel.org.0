Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B7224C46
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgGRPJ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPJZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:09:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03812067D;
        Sat, 18 Jul 2020 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084965;
        bh=JEeQ6EAJdaIpOY15yE8+2poMV0kARRFf/ZiGMh4qNLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GyJDid9F+uZJehWRKqkaXT9HYU2HjP0UKPhiMKMhSoPyH3c9KsylM4JHI3iuZLaSb
         T37x3pyOcipBZq/4CrQeEtiKSu0z95XDtbI9AOFxoaeiLp0Ej0+s/rvUSqR994CzpQ
         7FOi5urFmmWq+38N+u2TEVLe78W8tDagTvjTHgtg=
Date:   Sat, 18 Jul 2020 16:09:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH 23/30] iio: dac: ad5758: Move and fix-up kerneldoc
 header and demote unworthy kerneldoc
Message-ID: <20200718160920.2f67428c@archlinux>
In-Reply-To: <20200716135928.1456727-24-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-24-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:21 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc headers need to come directly before the function/struct
> that they are documenting.  Also fix some missing descriptions and
> misspellings.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'reg' not described in 'ad5758_range'
>  drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'min' not described in 'ad5758_range'
>  drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'max' not described in 'ad5758_range'
>  drivers/iio/dac/ad5758.c:122: warning: Function parameter or member 'gpio_reset' not described in 'ad5758_state'
>  drivers/iio/dac/ad5758.c:122: warning: Function parameter or member 'd32' not described in 'ad5758_state'
>  drivers/iio/dac/ad5758.c:137: warning: cannot understand function prototype: 'enum ad5758_output_range '
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing.  Plenty
of time to add tags or changes if anyone else reviews.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5758.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> index 475646c82b40e..c34740d2c89a1 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -92,24 +92,24 @@
>  
>  #define AD5758_FULL_SCALE_MICRO	65535000000ULL
>  
> +struct ad5758_range {
> +	int reg;
> +	int min;
> +	int max;
> +};
> +
>  /**
>   * struct ad5758_state - driver instance specific data
>   * @spi:	spi_device
>   * @lock:	mutex lock
> + * @gpio_reset:	gpio descriptor for the reset line
>   * @out_range:	struct which stores the output range
>   * @dc_dc_mode:	variable which stores the mode of operation
>   * @dc_dc_ilim:	variable which stores the dc-to-dc converter current limit
>   * @slew_time:	variable which stores the target slew time
>   * @pwr_down:	variable which contains whether a channel is powered down or not
> - * @data:	spi transfer buffers
> + * @d32:	spi transfer buffers
>   */
> -
> -struct ad5758_range {
> -	int reg;
> -	int min;
> -	int max;
> -};
> -
>  struct ad5758_state {
>  	struct spi_device *spi;
>  	struct mutex lock;
> @@ -122,7 +122,7 @@ struct ad5758_state {
>  	__be32 d32[3];
>  };
>  
> -/**
> +/*
>   * Output ranges corresponding to bits [3:0] from DAC_CONFIG register
>   * 0000: 0 V to 5 V voltage range
>   * 0001: 0 V to 10 V voltage range

