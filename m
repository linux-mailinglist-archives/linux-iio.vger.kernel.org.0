Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050CE224C3B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgGRPGn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPGn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:06:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E672067D;
        Sat, 18 Jul 2020 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084803;
        bh=t0z2caHrsGxqx5zm/IpJscoZlnfLaHkqhTZ14zCOVNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TCS3/JdX2nhAHK5115ws2c874oDoWI3qwrZ61CDu5iIBvVnuMB0C0Q0MB04tRtVOn
         zXKoxtUZ0Z8bbxQpB3VVeoAnn+aFNorLJ2TxpUlGZQ+ClABu54CdiPywvUZcRfXSHf
         Gjn54yYb2GJWYw/v6jOpAtdQfwDDQWRD5mspmbiI=
Date:   Sat, 18 Jul 2020 16:06:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 21/30] iio: dac: ad5449: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718160639.12deb2cf@archlinux>
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

J

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

