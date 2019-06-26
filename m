Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01A3571FE
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFZTs0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZTs0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:48:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEBA2085A;
        Wed, 26 Jun 2019 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561578505;
        bh=w+6pkAvq2MECwkcGMuTt03y9vRjBjnv+uuBkInPNv9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dFQ+8XKYILwRUeSDTfglUcfiQo5XEByMopzlINQFXZy70QpAAKyJMJDGu2ysj+cp+
         BouA/+h4SeKAGs1KwhqF4ePJAz40rAAqEz/naX2YXdYN9M0c2/+apv8L8UtBzIxvWo
         JS6hUaw8kR8Pkx56xEPOGIoOM4YO5dj1AUvXcLQo=
Date:   Wed, 26 Jun 2019 20:48:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: frequency: adf4371: Add support for output
 stage mute
Message-ID: <20190626204820.513fb866@archlinux>
In-Reply-To: <1561389236-26464-1-git-send-email-stefan.popa@analog.com>
References: <1561389236-26464-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Jun 2019 18:13:56 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Another feature of the ADF4371/ADF4372 is that the supply current to the
> RF8P and RF8N output stage can shut down until the ADF4371 achieves lock
> as measured by the digital lock detect circuitry. The mute to lock
> detect bit (MUTE_LD) in REG25 enables this function.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Bit of fuzz on this due to me ignoring patch 1 for now.

Rob probably missed the binding as it was buried inside a patch that wasn't
clearly labelled and it is unlike him to review part of the bindings in
a series.

I'll take the view it isn't complex enough to bother him and apply it.
(of course, should any DT people want to comment it would be welcome!)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/frequency/adf4371.yaml          |  6 ++++++
>  drivers/iio/frequency/adf4371.c                             | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index a268a9d..6db8742 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -32,6 +32,12 @@ properties:
>      items:
>        - clkin
>  
> +  adi,mute-till-lock-en:
> +    description:
> +      If this property is present, then the supply current to RF8P and RF8N
> +      output stage will shut down until the ADF4371/ADF4372 achieves lock as
> +      measured by the digital lock detect circuitry.
> +
>  required:
>    - compatible
>    - reg
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
> index f874219..e48f15c 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -45,6 +45,10 @@
>  #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
>  #define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
>  
> +/* ADF4371_REG25 */
> +#define ADF4371_MUTE_LD_MSK		BIT(7)
> +#define ADF4371_MUTE_LD(x)		FIELD_PREP(ADF4371_MUTE_LD_MSK, x)
> +
>  /* ADF4371_REG32 */
>  #define ADF4371_TIMEOUT_MSK		GENMASK(1, 0)
>  #define ADF4371_TIMEOUT(x)		FIELD_PREP(ADF4371_TIMEOUT_MSK, x)
> @@ -484,6 +488,15 @@ static int adf4371_setup(struct adf4371_state *st)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Mute to Lock Detect */
> +	if (device_property_read_bool(&st->spi->dev, "adi,mute-till-lock-en")) {
> +		ret = regmap_update_bits(st->regmap, ADF4371_REG(0x25),
> +					 ADF4371_MUTE_LD_MSK,
> +					 ADF4371_MUTE_LD(1));
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	/* Set address in ascending order, so the bulk_write() will work */
>  	ret = regmap_update_bits(st->regmap, ADF4371_REG(0x0),
>  				 ADF4371_ADDR_ASC_MSK | ADF4371_ADDR_ASC_R_MSK,

