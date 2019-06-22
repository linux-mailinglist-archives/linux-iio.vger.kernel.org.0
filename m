Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99F4F46D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFVInc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 04:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfFVInc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 04:43:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2350206BA;
        Sat, 22 Jun 2019 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561193011;
        bh=Ne/FYC7qbqO1MBAcK+ToL5A3274Dk5lz7Tfcussjz8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NSf16nj2CHraiG3fFJ6KIYa9hEXZ16pSwtds4a2y/oXL6+dZhe24bN/BNHl5lbBbl
         uPBZsSM7IbdttFTYqDxrF0VGlBuM2c6YzX6okU/UbYmall1vwQDD8BUkqB9jFNB+H4
         QN7P4QWzmkmxSCBGYTPZMkyjKvJ/Fkz3qoKJ5M0Y=
Date:   Sat, 22 Jun 2019 09:43:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: sca3000: Potential endian bug in
 sca3000_read_event_value()
Message-ID: <20190622094326.742d3e7e@archlinux>
In-Reply-To: <20190621091828.GA1878@mwanda>
References: <20190621091828.GA1878@mwanda>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Jun 2019 12:18:28 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The problem is that "ret" is an int but we're casting it as
> "(unsigned long *)&ret" when we do the for_each_set_bit() loop.  This
> will not work on big endian 64 bit systems.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Hi Dan,

Great catch,  I've applied this to the togreg branch of iio.git (rather
than fixes) given the point in the cycle and limited chance anyone is
actually running this obsolete part on a be64 machine.  I would love
to be proved wrong though and would be happy to push this for stable
if we do get any reports!

Thanks,

Jonathan
> ---
>  drivers/iio/accel/sca3000.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4964561595f5..9e9f4347a325 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -872,8 +872,9 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
>  				    enum iio_event_info info,
>  				    int *val, int *val2)
>  {
> -	int ret, i;
>  	struct sca3000_state *st = iio_priv(indio_dev);
> +	long ret;
> +	int i;
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> @@ -885,11 +886,11 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
>  			return ret;
>  		*val = 0;
>  		if (chan->channel2 == IIO_MOD_Y)
> -			for_each_set_bit(i, (unsigned long *)&ret,
> +			for_each_set_bit(i, &ret,
>  					 ARRAY_SIZE(st->info->mot_det_mult_y))
>  				*val += st->info->mot_det_mult_y[i];
>  		else
> -			for_each_set_bit(i, (unsigned long *)&ret,
> +			for_each_set_bit(i, &ret,
>  					 ARRAY_SIZE(st->info->mot_det_mult_xz))
>  				*val += st->info->mot_det_mult_xz[i];
>  

