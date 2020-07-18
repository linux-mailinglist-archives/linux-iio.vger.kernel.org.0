Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF39224C3D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgGRPHL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPHL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:07:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923AC2067D;
        Sat, 18 Jul 2020 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084831;
        bh=jS/YTU1E8oqW8NlV057QylGhukIF1sN2V6MqBKpcozI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hh/gaMw3+q9ujmoSOOPHO3Th7RhquY6NdOPtlJ/1AFX3aA14rtOJu3yZLclAixKQ5
         AH176oxpCB7nZ7XHJNz61mX0kpKwCEmeuIW7mZzuA/yT1RnTRV6S0KErheltgNLNa7
         0NnI3CINtL7BEcolPTZEmhrly2dbU22SDCq4hnPE=
Date:   Sat, 18 Jul 2020 16:07:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 21/30] iio: dac: ad5449: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718160706.11885e7f@archlinux>
In-Reply-To: <20200716135928.1456727-22-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-22-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:19 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5449.c:75: warning: Function parameter or member 'lock' not described in 'ad5449'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied

> ---
>  drivers/iio/dac/ad5449.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
> index d739b10e52362..e9530835479af 100644
> --- a/drivers/iio/dac/ad5449.c
> +++ b/drivers/iio/dac/ad5449.c
> @@ -56,7 +56,7 @@ struct ad5449_chip_info {
>   * @has_sdo:		whether the SDO line is connected
>   * @dac_cache:		Cache for the DAC values
>   * @data:		spi transfer buffers
> - * @lock		lock to protect the data buffer during SPI ops
> + * @lock:		lock to protect the data buffer during SPI ops
>   */
>  struct ad5449 {
>  	struct spi_device		*spi;

