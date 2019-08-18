Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A98BE9184D
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHRRS7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 13:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRRS7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 13:18:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A1120B7C;
        Sun, 18 Aug 2019 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566148738;
        bh=Y1EzBlOui6HjsCSc95QlXtRRfYfzIYsHD92t5s35Pfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rLrsAZFRV22AQuWV5RSAmcx0NbIspp++zpiuyQm0ANvyjDIsNYlgLQLhhVJ/6UqUN
         zN+iAhEO/cqDXNsaQZ9B2eMLCyRRowf3fRkiXMEMXmZa4vydBk+aj01YcrBBymJRxP
         9RoitzPYeBdMw+32XPo5R1jSZZJt/Coz0ekIYefY=
Date:   Sun, 18 Aug 2019 18:18:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: max5481: use devres for iio device registration
Message-ID: <20190818181853.106171a7@archlinux>
In-Reply-To: <20190814092144.10980-1-martin@kaiser.cx>
References: <20190814092144.10980-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Aug 2019 11:21:44 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Replace iio_device_register with the devres variant and drop the
> explicit function call to unregister the iio device.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
This changes the order of removal compared to probe as now we don't remove
the userspace interface before storing to non volatile memory.

Admittedly it's a pretty unlikely race to hit but I don't want to set
a precedent of judging just how unlikely a race is.

I'm also not keen to use dev_add_action_or_reset for this one as the
action in remove is not balanced to one in probe - I want to see it
clearly laid out in code, as it currently is.

So a no on this sort of change in this particular driver.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/max5481.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> index 732375b6d131..40b7212e68dc 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -162,7 +162,7 @@ static int max5481_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> -	return iio_device_register(indio_dev);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static int max5481_remove(struct spi_device *spi)
> @@ -170,8 +170,6 @@ static int max5481_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
>  	struct max5481_data *data = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	/* save wiper reg to NV reg */
>  	return max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
>  }

