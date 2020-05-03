Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156FF1C2BE0
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 13:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgECLmQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 07:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgECLmP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 07:42:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8FB205ED;
        Sun,  3 May 2020 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588506135;
        bh=cJV6+Ip85K8eZlfSHfw7Jg5xJtOOcTfm2AIj0IoaByo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NmRh3zxCTBSlXzH2Wve48cUWyleTnCms9h/zOVYJRbGeIOaH+UziEkUBrn9qZzBJW
         786adg9qmXPRSJpZWw2hsjJWSYSh8RwBdZS9IaQ5sdlG/N4nx9r3mrzKu5jIz5dwLU
         pHT7YO4/iclXvBuKXYMtC19wije0c4azj9FBaUlM=
Date:   Sun, 3 May 2020 12:42:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: ad7768-1: Fix channel endian spec
Message-ID: <20200503124211.41933e29@archlinux>
In-Reply-To: <20200429104535.82988-1-sergiu.cuciurean@analog.com>
References: <20200429104535.82988-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Apr 2020 13:45:35 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> This change removes the endian description from the iio channel spec.
> In this way, the default (IIO_CPU) endian will be used, matching the
> be32_to_cpu() conversion from ad7768_spi_reg_read().
> 
> Fixes: 8a15c73a9bcfe ("iio: adc: Add AD7768-1 ADC basic support")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Hi Sergiu,

The endian marking only applies to the push_to_buffers data.  That
is read from the hardware using spi_read, not the ad7768_spi_reg_read
function.  So logic above doesn't hold.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7768-1.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index a0027797a7fe..99da13c3511a 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -144,7 +144,6 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  			.realbits = 24,
>  			.storagebits = 32,
>  			.shift = 8,
> -			.endianness = IIO_BE,
>  		},
>  	},
>  };

