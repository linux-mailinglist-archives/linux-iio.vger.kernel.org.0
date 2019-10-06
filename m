Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB4CD03F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfJFKEa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 06:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfJFKEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 06:04:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832B92087E;
        Sun,  6 Oct 2019 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570356269;
        bh=lykmaPe+GxCheVaEJeVtQ0EuxqBdyMbbEJLKlsjZ0DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PS44RYF1Qq0oFLYbZKPHR3YV4dl+UQFsfyj7EPl1iT03fDL8pfufPLdqjJaUxGZdV
         ShXwljSnO43WCRTRhx5rDF98/VkQxwftIbbxMOrvgtaHSP9owfT3H/78XiFg4DDAzV
         ChyUQtwn/KHZbzloq3MC4FXLE074EqMd6xPsXnr8=
Date:   Sun, 6 Oct 2019 11:04:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/7] iio: adc: max1027: Add debugfs register read
 support
Message-ID: <20191006110424.7781d99d@archlinux>
In-Reply-To: <20191003173401.16343-2-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-2-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Oct 2019 19:33:55 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Until now, only write operations were supported. Force two bytes read
> operation when reading from this register (might be wrong when reading
> the temperature, but will work with any other value).

That's worrying as comments go.  Just return an error on the temperature
register if it's going to do the wrong thing.

Thanks,

Jonathan

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 214883458582..6cdfe9ef73fc 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -309,8 +309,11 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
>  	struct max1027_state *st = iio_priv(indio_dev);
>  	u8 *val = (u8 *)st->buffer;
>  
> -	if (readval != NULL)
> -		return -EINVAL;
> +	if (readval) {
> +		int ret = spi_read(st->spi, val, 2);
> +		*readval = be16_to_cpu(st->buffer[0]);
> +		return ret;
> +	}
>  
>  	*val = (u8)writeval;
>  	return spi_write(st->spi, val, 1);

