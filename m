Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB85717C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFZTWk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFZTWk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:22:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0AB20663;
        Wed, 26 Jun 2019 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561576959;
        bh=VtNAJvPAlN7MdrrgP7iDPLLlHySWmZPh02eLT8C8OTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x8YmlYDE47jCCCq0hOxKbUZmUuPD58o4abgh3o9iA4aP25U9NrIjpFUKom/d5om8I
         FXOrzZZtoucm5hyJF86iFs4b/vcijipZYFkM34wLkQEoBgj9rD31MKgOH6tC1tvX9z
         nkKAzDyAE7kFAeZD5XpTLPIXeSPqOdgp89H/ZtEc=
Date:   Wed, 26 Jun 2019 20:22:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V4 1/5] iio: adc: ad7124: Remove input number limitation
Message-ID: <20190626202234.7c4cd0da@archlinux>
In-Reply-To: <20190625081128.22190-1-mircea.caprioru@analog.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 11:11:24 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> The driver limits the user to use only 4/8 differential inputs, but this
> device has the option to use pseudo-differential channels. This will
> increase the number of channels to be equal with the number of inputs so 8
> channels for ad7124-4 and 16 for ad7124-8.
> 
> This patch removes the check between channel nodes and num_inputs value.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changelog v2:
> - nothing changed here
> 
> Changelog v3:
> - nothing changed here
> 
> Changelog v4:
> - nothing changed here
> 
>  drivers/iio/adc/ad7124.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 659ef37d5fe8..810234db9c0d 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -462,13 +462,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			goto err;
>  
> -		if (ain[0] >= st->chip_info->num_inputs ||
> -		    ain[1] >= st->chip_info->num_inputs) {
> -			dev_err(indio_dev->dev.parent,
> -				"Input pin number out of range.\n");
> -			ret = -EINVAL;
> -			goto err;
> -		}
>  		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
>  						  AD7124_CHANNEL_AINM(ain[1]);
>  		st->channel_config[channel].bipolar =

