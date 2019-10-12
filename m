Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71164D4F4C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfJLLe2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfJLLe2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:34:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C56A12089C;
        Sat, 12 Oct 2019 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880067;
        bh=P3Tij61XBPpQrF/fHtKD1G6EVze0k7Ta/jku+94+dsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hp1bxx5KTXVLndUuI3vBrTfCNBMItxJoMOqbGOH6udQegXjQwWroniPz4bMLgNZxh
         ju7292+08axbKa+J+NMtAzVNMCiSyOZPqpnfa6UnvOb1mp0pR2p4/aBs56LcN5zmLJ
         zaqwvmywRX/BDwnbd9CPi9nANxzma1+8OdyYxdUI=
Date:   Sat, 12 Oct 2019 12:28:10 +0100
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
Subject: Re: [PATCH v4 3/8] iio: adc: max1027: Reset the device at probe
 time
Message-ID: <20191012122810.5330fd7f@archlinux>
In-Reply-To: <20191011144347.19146-4-miquel.raynal@bootlin.com>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
        <20191011144347.19146-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 16:43:42 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> All the registers are configured by the driver, let's reset the chip
> at probe time, avoiding any conflict with a possible earlier
> configuration.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 823223b77a70..f9b473ee6711 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -466,6 +466,14 @@ static int max1027_probe(struct spi_device *spi)
>  		}
>  	}
>  
> +	/* Internal reset */
> +	st->reg = MAX1027_RST_REG;
> +	ret = spi_write(st->spi, &st->reg, 1);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Failed to reset the ADC\n");
> +		return ret;
> +	}
> +
>  	/* Disable averaging */
>  	st->reg = MAX1027_AVG_REG;
>  	ret = spi_write(st->spi, &st->reg, 1);

