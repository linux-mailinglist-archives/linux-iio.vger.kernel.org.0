Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF526E395
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIQSae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIQSae (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 14:30:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA474221EE;
        Thu, 17 Sep 2020 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600367429;
        bh=JZVoYCj9TVsqgcGVk0M6zcrr/208nx/00klNnUVjI/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yrXu9K0a3PXwKp73G1fLdEMQbfky9bykOb0c6vVUaeUAa7BMjDNwKnS8dlU6C+9mr
         DN38vPLQvlt0CuFpOfy6tDLxCiMm3X1iwnNmfnSO64O7XMVJOkenPk/0KjPduRU8wo
         ilu+S02Y9sAvSduAcPKQCH9BSTTfYpGanucvU8jA=
Date:   Thu, 17 Sep 2020 19:30:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 30/30] iio: dac: ad7303: Complete 'struct ad7303_state'
 doc and reorder compiler attribute
Message-ID: <20200917193024.73fa1108@archlinux>
In-Reply-To: <20200716135928.1456727-31-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-31-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:28 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc gets confused if the variable does not follow the
> type/attribute definitions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad7303.c:49: warning: Function parameter or member 'vdd_reg' not described in 'ad7303_state'
>  drivers/iio/dac/ad7303.c:49: warning: Function parameter or member 'vref_reg' not described in 'ad7303_state'
>  drivers/iio/dac/ad7303.c:49: warning: Function parameter or member 'lock' not described in 'ad7303_state'
>  drivers/iio/dac/ad7303.c:49: warning: Function parameter or member '____cacheline_aligned' not described in 'ad7303_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied with ___cacheline_aligned bit dropped as now kernel-doc will ignore
that.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad7303.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 15af8a1cce3eb..05d8dc88d4fad 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -29,6 +29,9 @@
>   * @spi:		the device for this driver instance
>   * @config:		cached config register value
>   * @dac_cache:		current DAC raw value (chip does not support readback)
> + * @vdd_reg:		reference to VDD regulator
> + * @vref_reg:		reference to VREF regulator
> + * @lock:		protect writes and cache updates
>   * @data:		spi transfer buffer
>   */
>  
> @@ -45,7 +48,7 @@ struct ad7303_state {
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	__be16 data ____cacheline_aligned;
> +	__be16 ____cacheline_aligned data;
>  };
>  
>  static int ad7303_write(struct ad7303_state *st, unsigned int chan,

