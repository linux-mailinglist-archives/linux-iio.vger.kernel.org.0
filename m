Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87450224C36
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGRPF6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPF6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:05:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C2D42067D;
        Sat, 18 Jul 2020 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084757;
        bh=jj/XrXFFLzYgXOaVzl2PD4A1ReBY9X+TER5hVC5F5YM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1EGHB5I8OT0s1qFhm6UBOZ8PU/T17FKt8BVTPiaIZSJeBqrRKxobdS6rLUIZPE8M
         N3nvHziwMlctkqUcF0ZluAWRMgcbmJ8FLR6NNtXqoj6kNWjaXcgqW1SRp/ev4ZRW6c
         LDWoE4ev7zw4qHnNYnTnjlJ35rAAhhouRo+Mec84=
Date:   Sat, 18 Jul 2020 16:05:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 20/30] iio: dac: ad5446: Complete 'struct ad5446_state'
 doc and demote unworthy kerneldocs
Message-ID: <20200718160553.7362307c@archlinux>
In-Reply-To: <20200716135928.1456727-21-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-21-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:18 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'dev' not described in 'ad5446_state'
>  drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'cached_val' not described in 'ad5446_state'
>  drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'pwr_down_mode' not described in 'ad5446_state'
>  drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'pwr_down' not described in 'ad5446_state'
>  drivers/iio/dac/ad5446.c:48: warning: Function parameter or member 'lock' not described in 'ad5446_state'
>  drivers/iio/dac/ad5446.c:323: warning: cannot understand function prototype: 'enum ad5446_supported_spi_device_ids '
>  drivers/iio/dac/ad5446.c:545: warning: cannot understand function prototype: 'enum ad5446_supported_i2c_device_ids '
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Seems simple so applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5446.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 8f8afc8999bc7..15c314f08a007 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -29,11 +29,14 @@
>  
>  /**
>   * struct ad5446_state - driver instance specific data
> - * @spi:		spi_device
> + * @dev:		this device
>   * @chip_info:		chip model specific constants, available modes etc
>   * @reg:		supply regulator
>   * @vref_mv:		actual reference voltage used
> - * @lock		lock to protect the data buffer during write ops
> + * @cached_val:		store/retrieve values during power down
> + * @pwr_down_mode:	power down mode (1k, 100k or tristate)
> + * @pwr_down:		true if the device is in power down
> + * @lock:		lock to protect the data buffer during write ops
>   */
>  
>  struct ad5446_state {
> @@ -313,7 +316,7 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
>  	return spi_write(spi, data, sizeof(data));
>  }
>  
> -/**
> +/*
>   * ad5446_supported_spi_device_ids:
>   * The AD5620/40/60 parts are available in different fixed internal reference
>   * voltage options. The actual part numbers may look differently
> @@ -535,7 +538,7 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
>  	return i2c_master_send(client, (char *)&data, sizeof(data));
>  }
>  
> -/**
> +/*
>   * ad5446_supported_i2c_device_ids:
>   * The AD5620/40/60 parts are available in different fixed internal reference
>   * voltage options. The actual part numbers may look differently

