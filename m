Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10EE15FFAB
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 19:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgBOScy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 13:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgBOScy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 13:32:54 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79CB9206D6;
        Sat, 15 Feb 2020 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581791573;
        bh=oWWck7KB0e4Af9mropzJLU6Ld44VOn2Nw7on6P3iCFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NTrCsKlPkxjw5JnVxHqeZFbM4XX8+0Nkhw4OwdFgwxpEvBgBFeS0qX8bQoi7qHxty
         V1pI15EWyqZrMX0jpwXhSZDh1F+lXFkIrlSoFv6gqTvXzIMGN9Y/pe1EHOQ0iUZLqz
         qoP6JSMa2KqjXkZSn2DtxUGdnZQGyayPtL6UYekk=
Date:   Sat, 15 Feb 2020 18:32:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Peter Rosin <peda@axentia.se>, od@zcrc.me,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: afe: rescale: Implement write_raw
Message-ID: <20200215183249.2100b6e9@archlinux>
In-Reply-To: <20200210225438.112660-2-paul@crapouillou.net>
References: <20200210225438.112660-1-paul@crapouillou.net>
        <20200210225438.112660-2-paul@crapouillou.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 19:54:38 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Implement write_raw by converting the value if writing the scale, or
> just calling the managed channel driver's write_raw otherwise.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 95802d9ee25e..a48f6af9316d 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -35,6 +35,27 @@ struct rescale {
>  	int *scale_data;
>  };
>  
> +static int rescale_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct rescale *rescale = iio_priv(indio_dev);
> +	unsigned long long tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		tmp = val * 1000000000LL;
> +		do_div(tmp, rescale->numerator);
> +		tmp *= rescale->denominator;
> +		do_div(tmp, 1000000000LL);
> +		return iio_write_channel_attribute(rescale->source, tmp, 0,
> +						   IIO_CHAN_INFO_SCALE);

Why is val2 always 0?  Won't that only work if the backend device
has integer scales?

> +	default:
> +		return iio_write_channel_attribute(rescale->source,
> +						   val, val2, mask);
> +	}
> +}
> +
>  static int rescale_convert(struct rescale *rescale, int type,
>  			   const int val, const int val2,
>  			   int *val_out, int *val2_out)
> @@ -110,6 +131,7 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info rescale_info = {
> +	.write_raw = rescale_write_raw,
>  	.read_raw = rescale_read_raw,
>  	.read_avail = rescale_read_avail,
>  };

