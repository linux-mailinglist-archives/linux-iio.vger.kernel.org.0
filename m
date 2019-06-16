Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6D47424
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfFPKPX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 06:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfFPKPW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 06:15:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50762084A;
        Sun, 16 Jun 2019 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560680122;
        bh=116gNnnNy/e29WMtBdj5C75Li/l8wNZzUynmTfBEW/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Je+DETy2uWBpOU5jANMAp8ZiIKDWT6Or26kBfzSkBvcVQxEXT1AKAuEv0Sg4GJ92U
         bSLcq6Gq2aYZJC3iq7xmeMVUYoeRkE8k3DuSzanaV882kjKhHiN3Utn7L8bJ+K9waL
         8X45AtbYgjqFGlcUqxrCW1r9OTiLHSvoUCaqC02Y=
Date:   Sun, 16 Jun 2019 11:15:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad7150: use ternary operating to ensure
 0/1 value
Message-ID: <20190616111516.1af0d41b@archlinux>
In-Reply-To: <20190614165059.7bifufvhxofy6ybu@smtp.gmail.com>
References: <20190614165059.7bifufvhxofy6ybu@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 13:50:59 -0300
Melissa Wen <melissa.srw@gmail.com> wrote:

> Remove idiom and use ternary operator for consistently trigger 0/1 value
> on variable declaration.
> 
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Hi Melissa,

In general I would consider this unnecessary churn as, whilst
it's no longer a favoured idiom, it is extremely common in the
kernel.  However, as this is a staging cleanup, fair enough to
make it as 'nice as possible'! 

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7150.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 8234da4b8c65..25598bf124fb 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -350,8 +350,8 @@ static ssize_t ad7150_show_timeout(struct device *dev,
>  
>  	/* use the event code for consistency reasons */
>  	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(this_attr->address);
> -	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
> -			== IIO_EV_DIR_RISING);
> +	int rising = (IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
> +		      == IIO_EV_DIR_RISING) ? 1 : 0;
>  
>  	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
>  	case IIO_EV_TYPE_MAG_ADAPTIVE:

