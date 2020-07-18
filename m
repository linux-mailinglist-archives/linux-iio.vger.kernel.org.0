Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D81224C50
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgGRPMk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPMj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:12:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F329F2067D;
        Sat, 18 Jul 2020 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085159;
        bh=ZXDpzjGQTX/1ao0lxIcUm62D8ruThRSvhtkdngCE+30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L8FK0JVyFXFNzbiwCTyQmwcSVHeP1d67dVsMd5DpEY1WJBdYUQqkk+Ke4WHKDGIEX
         AHlSb4NBRTI2uRzvvz1eUW1kdCIGOv4s+8u5S2W1mh8JMueD3Ebfh+PBmyD9l5pSS0
         S9FtlyhnoOFzvQbbGo48ewFfKmAMrMZOjo24Hci0=
Date:   Sat, 18 Jul 2020 16:12:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 26/30] iio: dac: ad5791: Complete 'struct
 ad5791_chip_info' documentation
Message-ID: <20200718161234.70f19620@archlinux>
In-Reply-To: <20200716135928.1456727-27-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-27-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:24 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> ... and remove seemingly pointless comment.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'ctrl' not described in 'ad5791_state'
>  drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'pwr_down_mode' not described in 'ad5791_state'
>  drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'pwr_down' not described in 'ad5791_state'
>  drivers/iio/dac/ad5791.c:97: warning: Function parameter or member 'data' not described in 'ad5791_state'
>  drivers/iio/dac/ad5791.c:103: warning: cannot understand function prototype: 'enum ad5791_supported_device_ids '
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5791.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index 1d11f39ed0474..d8485004b1010 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -76,9 +76,11 @@ struct ad5791_chip_info {
>   * @chip_info:		chip model specific constants
>   * @vref_mv:		actual reference voltage used
>   * @vref_neg_mv:	voltage of the negative supply
> - * @pwr_down_mode	current power down mode
> + * @ctrl:		control regster cache
> + * @pwr_down_mode:	current power down mode
> + * @pwr_down:		true if device is powered down
> + * @data:		spi transfer buffers
>   */
> -
>  struct ad5791_state {
>  	struct spi_device		*spi;
>  	struct regulator		*reg_vdd;
> @@ -96,10 +98,6 @@ struct ad5791_state {
>  	} data[3] ____cacheline_aligned;
>  };
>  
> -/**
> - * ad5791_supported_device_ids:
> - */
> -
>  enum ad5791_supported_device_ids {
>  	ID_AD5760,
>  	ID_AD5780,

