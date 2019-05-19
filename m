Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB0227F6
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfESRrW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfESRrV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:47:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F14217D8;
        Sun, 19 May 2019 11:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558264334;
        bh=D7vV54mW1ZbMLbElOBW6ZJBZ/Fl6MX3yycwmL624yyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZkqwMO3FgTmFv69FrXPgZkjxdiur2yQ/jhav/Tq3PiVlcbsVj3ihIILET5UBX5LE1
         GFF375/cdaKeSeAf91sByvBZ1jo0zsYnZJ33zIxCp6ez505nuGBJyOcUeDqLBuIEnm
         kVLOYBNgqqJnL3JPG8z4w6m9ZmWl6B81VBzh309g=
Date:   Sun, 19 May 2019 12:12:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tallys Martins <tallysmartins@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.or, kernel-usp@googlegroups.com,
        Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
Subject: Re: [PATCH 1/2] staging: iio: ad2s1210: Destroy mutex at remove
Message-ID: <20190519121209.71524d18@archlinux>
In-Reply-To: <20190518221558.21799-1-tallysmartins@gmail.com>
References: <20190518221558.21799-1-tallysmartins@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 19:15:57 -0300
Tallys Martins <tallysmartins@gmail.com> wrote:

> Ensure the mutex will be destroyed on drive removal.
> Also adds mutex comment description.
> 
> Signed-off-by: Tallys Martins <tallysmartins@gmail.com>
> Signed-off-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
> Co-developed-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
Hi.

This particular 'issue' is never a simple one.

The destroy_mutex call is intended for lock debugging only,
which is why there is devm_init_mutex or similar to allow for
automatic unwinding. 

It simple cleanup paths like this, it provides very little value
and leads to a more complex unwind.

It is for this reason that the vast majority of drivers simply
don't bother.

Hence, unless there is a good reason I'm missing I won't be
introducing more of them.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index b6be0bc202f5..b91cf57c5e57 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -86,7 +86,7 @@ static const struct ad2s1210_gpio gpios[] = {
>  static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
>  
>  struct ad2s1210_state {
> -	struct mutex lock;
> +	struct mutex lock; /* lock to protect the state on r/w operations */
>  	struct spi_device *sdev;
>  	struct gpio_desc *gpios[5];
>  	unsigned int fclkin;
> @@ -689,8 +689,10 @@ static int ad2s1210_probe(struct spi_device *spi)
>  static int ad2s1210_remove(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ad2s1210_state *ad2s1210_ad = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	mutex_destroy(&ad2s1210_ad->lock);
>  
>  	return 0;
>  }

