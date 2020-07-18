Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25810224C2F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgGRPDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPDU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:03:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC632065D;
        Sat, 18 Jul 2020 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084599;
        bh=cUkYggOnauCffTTOaCBMD+Umyy7fk+m3swMQxVSA0Mg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tytHDbm3fzPIsRCWGphtMFPCa5v9OlxaZxsVuxBcDBjNE5Eh3kuMblQYuh3NRCNv+
         CT4mvLB/OpkEXYmnFLkqddIXoYFz43Y23gmB//UnyCMmkRkwZfRL7GBYPDquExkm+f
         GkbWe6k3wAeQeRtFeGT0iLCb4aBGarmPJ5Fgttmg=
Date:   Sat, 18 Jul 2020 16:03:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: Re: [PATCH 17/30] iio: adc: ad7949: Fix misspelling issue and
 compiler attribute ordering
Message-ID: <20200718160314.69fc73dd@archlinux>
In-Reply-To: <20200716135928.1456727-18-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-18-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:15 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc gets confused if the variable does not follow the
> type/attribute definitions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/ad7949.c:58: warning: Function parameter or member 'indio_dev' not described in 'ad7949_adc_chip'
>  drivers/iio/adc/ad7949.c:58: warning: Function parameter or member '____cacheline_aligned' not described in 'ad7949_adc_chip'
Holding this one pending discussion of whether to add ___cacheline_aligned to
the stuff kernel-doc effectively skips when processing structures.

Jonathan

> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/iio/adc/ad7949.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 2c6f60edb7ced..a3fc42617feb9 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -39,7 +39,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
>   * struct ad7949_adc_chip - AD ADC chip
>   * @lock: protects write sequences
>   * @vref: regulator generating Vref
> - * @iio_dev: reference to iio structure
> + * @indio_dev: reference to iio structure
>   * @spi: reference to spi structure
>   * @resolution: resolution of the chip
>   * @cfg: copy of the configuration register
> @@ -54,7 +54,7 @@ struct ad7949_adc_chip {
>  	u8 resolution;
>  	u16 cfg;
>  	unsigned int current_channel;
> -	u16 buffer ____cacheline_aligned;
> +	u16 ____cacheline_aligned buffer;
>  };
>  
>  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,

