Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF4224CA5
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPsV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPsV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:48:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C2920734;
        Sat, 18 Jul 2020 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087301;
        bh=huLjEPSvdikKTAJ/jeRu5OJpZptfkQBvmJfCRLnUACY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s3bRqekHO7ckf27VyRtXLqJL2cEwk6kphuCRDAPM0dEV1ikLg5gE3Zqqm1eqpsNcS
         V3yhDJ+irFegRVd0O+AtHT57WkaGZTIwq9FG9sxRhO8P8ONZCUKzG5ffvpUexwGthX
         hAlteOtIajofTE+qWpDrkuWcJLQpvRzhR9ivNnsQ=
Date:   Sat, 18 Jul 2020 16:48:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 12/30] iio: dac: ad5504: Fix formatting errors and
 demote non-compliant kerneldoc
Message-ID: <20200718164817.38a61ccd@archlinux>
In-Reply-To: <20200717165538.3275050-13-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-13-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:20 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5504.c:58: warning: Function parameter or member 'pwr_down_mask' not described in 'ad5504_state'
>  drivers/iio/dac/ad5504.c:58: warning: Function parameter or member 'pwr_down_mode' not described in 'ad5504_state'
>  drivers/iio/dac/ad5504.c:64: warning: cannot understand function prototype: 'enum ad5504_supported_device_ids '
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5504.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index c64e6898ff20a..7e4e422ddfefc 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -43,8 +43,8 @@
>   * @spi:			spi_device
>   * @reg:		supply regulator
>   * @vref_mv:		actual reference voltage used
> - * @pwr_down_mask	power down mask
> - * @pwr_down_mode	current power down mode
> + * @pwr_down_mask:	power down mask
> + * @pwr_down_mode:	current power down mode
>   * @data:		transfer buffer
>   */
>  struct ad5504_state {
> @@ -57,10 +57,9 @@ struct ad5504_state {
>  	__be16				data[2] ____cacheline_aligned;
>  };
>  
> -/**
> +/*
>   * ad5504_supported_device_ids:
>   */
> -
>  enum ad5504_supported_device_ids {
>  	ID_AD5504,
>  	ID_AD5501,

