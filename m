Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9963BADD1
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGDQgy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 12:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDQgy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 12:36:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE96261246;
        Sun,  4 Jul 2021 16:34:15 +0000 (UTC)
Date:   Sun, 4 Jul 2021 17:36:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 04/10] iio: afe: rescale: reduce risk of integer
 overflow
Message-ID: <20210704173639.622371bf@jic23-huawei>
In-Reply-To: <20210701010034.303088-5-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
        <20210701010034.303088-5-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 21:00:28 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Reduce the risk of integer overflow by doing the scale calculation with
> 64bit integers and looking for a Greatest Common Divider for both parts
> of the fractional value.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 774eb3044edd..98bcb5d418d6 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct rescale *rescale = iio_priv(indio_dev);
> -	unsigned long long tmp;
> +	s64 tmp, tmp2;
> +	u32 factor;
>  	int ret;
>  
>  	switch (mask) {
> @@ -67,8 +68,11 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  		}
>  		switch (ret) {
>  		case IIO_VAL_FRACTIONAL:
> -			*val *= rescale->numerator;
> -			*val2 *= rescale->denominator;
> +			tmp = (s64)*val * rescale->numerator;
> +			tmp2 = (s64)*val2 * rescale->denominator;
> +			factor = gcd(tmp, tmp2);

Hmm. I wonder if there are cases where this doesn't work and we end up
truncating because the gcd is say 1.  If all of val, val2, rescale->numerator,
rescale->denominator are primes and the rescale values are moderately large
then that might happen.  We probably need a fallback position.  Perhaps 
check tmp / factor and temp2/factor will fit in an int. If not, shift them until
they do even if we have to dump some precision to do so.

This stuff is getting fiddly enough we might want to figure out some self tests
that exercise the various cases.

> +			*val = tmp / factor;
> +			*val2 = tmp2 / factor;

This is doing 64 bit numbers divided by 32 bit ones. Doesn't that require
use of do_div() etc on 32 bit platforms?

>  			return ret;
>  		case IIO_VAL_INT:
>  			*val *= rescale->numerator;

