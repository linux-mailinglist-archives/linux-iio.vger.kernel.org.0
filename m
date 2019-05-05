Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64A514074
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEEPGR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 11:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfEEPGR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 11:06:17 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2644206DF;
        Sun,  5 May 2019 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557068775;
        bh=Yilr+L2nikrV6Cji7VPMZzQMDcS99srKqvKnAeM1gIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OU6N4MEf3lpoyztaKEc9yYCQ38PQcLmCSAHRd39Fa8Lj72S5nl65xvZQi6qd2gOq5
         l4+fyYaybJNZveLTvfSGdHxbrSF0C+NyYTM2m/UCrFRdh5ocZ3dmbAWZZ+tZ/BmnPQ
         vqtYKBATR5TH1zbWGe+UB/xHWWivNDOjpNFynKNw=
Date:   Sun, 5 May 2019 16:06:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com
Subject: Re: [PATCH v2 5/6] iio: ad7949: Fix SPI interfacing for 14-bit
 messages
Message-ID: <20190505160609.2146f801@archlinux>
In-Reply-To: <1556813672-49861-5-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
        <1556813672-49861-5-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 May 2019 11:14:31 -0500
Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:

> The AD7949 (but not the other two models supported by this driver) uses
> samples 14 bits wide. When attempting to communicate through certain SPI
> controllers that require power-of-2 word widths, this fails. Adding
> logic to pack the 14-bit messages into the most-significant bits of a
> 16-bit message for communicating over byte-based SPI bus.

So this does penalise controllers that do support 14 bits. Can we query
that and perhaps look at only padding if necessary?

>=20
> Only able to test with AD7949 part, but should support the 16-bit
> samples of the AD7682 and AD7689, as well.
>=20
> Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
This has ended up more complex that I expected.  I 'think' the
result is just to shift the data up two bits if needed to pad?

There are some endian issues introduced as well by this patch.

Jonathan


> ---
> 	V2: Add some defines to reduce use of magic numbers.
> ---
>  drivers/iio/adc/ad7949.c | 106 +++++++++++++++++++++++++++--------------=
------
>  1 file changed, 60 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 7820e1097787..cba152151908 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -33,6 +33,11 @@
>  #define AD7949_CFG_READBACK_DIS            1
>  #define AD7949_CFG_READBACK_MASK           GENMASK(0, 0)
> =20
> +#define AD7949_BUFFER_LEN 4
> +
> +#define AD7949_HI_RESOLUTION 16
> +#define AD7949_LO_RESOLUTION 14
> +
>  enum {
>  	ID_AD7949 =3D 0,
>  	ID_AD7682,
> @@ -57,9 +62,9 @@ struct ad7949_adc_spec {
>  };
> =20
>  static const struct ad7949_adc_spec ad7949_adc_spec[] =3D {
> -	[ID_AD7949] =3D { .num_channels =3D 8, .resolution =3D 14 },
> -	[ID_AD7682] =3D { .num_channels =3D 4, .resolution =3D 16 },
> -	[ID_AD7689] =3D { .num_channels =3D 8, .resolution =3D 16 },
> +	[ID_AD7949] =3D { .num_channels =3D 8, .resolution =3D AD7949_LO_RESOLU=
TION },
> +	[ID_AD7682] =3D { .num_channels =3D 4, .resolution =3D AD7949_HI_RESOLU=
TION },
> +	[ID_AD7689] =3D { .num_channels =3D 8, .resolution =3D AD7949_HI_RESOLU=
TION },
This obscures a 'non magic' number. It is better to just leave it as how
many bits it actually is.

>  };
> =20
>  /**
> @@ -85,7 +90,7 @@ struct ad7949_adc_chip {
>  	u8 resolution;
>  	u16 cfg;
>  	unsigned int current_channel;
> -	u32 buffer ____cacheline_aligned;
> +	u8 buffer[AD7949_BUFFER_LEN] ____cacheline_aligned;
Why this change?  Ah, not using bits_per_word any more..

>  };
> =20
>  static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_a=
dc)
> @@ -96,41 +101,51 @@ static bool ad7949_spi_cfg_is_read_back(struct ad794=
9_adc_chip *ad7949_adc)
>  	return false;
>  }
> =20
> -static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
> +static int ad7949_message_len(struct ad7949_adc_chip *ad7949_adc)
>  {
> -	int ret =3D ad7949_adc->resolution;
> +	int tx_len =3D 2;
> =20
>  	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> -		ret +=3D AD7949_CFG_REG_SIZE_BITS;
> +		tx_len +=3D 2;
> =20
> -	return ret;
> +	return tx_len;
>  }
> =20
>  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 =
val,
>  				u16 mask)
>  {
> -	int ret;
> -	int bits_per_word =3D ad7949_spi_bits_per_word(ad7949_adc);
> -	int shift =3D bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> +	int ret =3D 0;
>  	struct spi_message msg;
> -	struct spi_transfer tx[] =3D {
> -		{
> -			.tx_buf =3D &ad7949_adc->buffer,
> -			.len =3D 4,
> -			.bits_per_word =3D bits_per_word,
> -		},
> -	};
> -
> -	ad7949_adc->cfg =3D (val & mask) | (ad7949_adc->cfg & ~mask);
> -	ad7949_adc->buffer =3D (ad7949_adc->cfg & AD7949_CFG_MASK_TOTAL) << shi=
ft;
> -	spi_message_init_with_transfers(&msg, tx, 1);
> -	ret =3D spi_sync(ad7949_adc->spi, &msg);
> +	struct spi_transfer tx;
> +	u16 tmp_cfg =3D 0;
> +
> +	(void)memset(&tx, 0, sizeof(tx));
> +	(void)memset(ad7949_adc->buffer, 0, AD7949_BUFFER_LEN);
The void casts do nothing useful.

memset(ad7949_adc->spi, sizeof(ad7949_adc->spi)) is better.

however, I'm not clear why you can't use a similar c99 assignment to that
the driver previously did.
> +
> +	tmp_cfg =3D ((val & mask) | (ad7949_adc->cfg & ~mask)) &
> +		AD7949_CFG_MASK_TOTAL;
> +
> +	if (tmp_cfg !=3D ad7949_adc->cfg) {
Flip the logic here and return early if it hasn't changed.

> +		ad7949_adc->cfg =3D tmp_cfg;
> +
> +		/* Pack 14-bit value into 2 bytes, MSB first */
> +		ad7949_adc->buffer[0] =3D ((ad7949_adc->cfg & 0x7f00) >> 6) |
> +			((ad7949_adc->cfg & 0xc0) >> 6);
So this:
takes bits 13..8 and shifts them down to 7..2.
takes bits 7..6 and shifts them down to 1..0

Unless I'm missing something that's just 13..6 shifted down to 7..0
(ad7949_adc->cfg & GENMASK(13, 6)) >> 6 or something like that.

> +		ad7949_adc->buffer[1] =3D (ad7949_adc->cfg & 0x007f) << 2;

Use GENMASK here as well.

This looks like a shift up by 2 followed by a endian swap. Can we make
that explicit as it'll be more readable...

I'm a little worried that we have dropped the endian swap that was
effectively occuring due to the larger bits_per_word for a version
that always does it, whether or not we are on a big endian platform
or a little endian one.

=46rom the spi.h header

 * In-memory data values are always in native CPU byte order, translated
 * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
 * for example when bits_per_word is sixteen, buffers are 2N bytes long
 * (@len =3D 2N) and hold N sixteen bit words in CPU byte order.
 *

As you have it the bits_per_word is 8 and so there is no inbuilt assumption
of ordering and you need you need to swap as you are on a little endian
platform.

> +
> +		tx.tx_buf =3D ad7949_adc->buffer;
> +		tx.len =3D ad7949_message_len(ad7949_adc);
> +
> +		spi_message_init_with_transfers(&msg, &tx, 1);

spi_write?

> +		ret =3D spi_sync(ad7949_adc->spi, &msg);
> +
> +		/*
> +		 * This delay is to avoid a new request before the required
> +		 * time to send a new command to the device
> +		 */
> +		udelay(2);
> +	}
> =20
> -	/*
> -	 * This delay is to avoid a new request before the required time to
> -	 * send a new command to the device
> -	 */
> -	udelay(2);
>  	return ret;
>  }
> =20
> @@ -138,16 +153,10 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
>  				   unsigned int channel)
>  {
>  	int ret;
> -	int bits_per_word =3D ad7949_spi_bits_per_word(ad7949_adc);
> -	int mask =3D GENMASK(ad7949_adc->resolution, 0);
>  	struct spi_message msg;
> -	struct spi_transfer tx[] =3D {
> -		{
> -			.rx_buf =3D &ad7949_adc->buffer,
> -			.len =3D 4,
> -			.bits_per_word =3D bits_per_word,
> -		},
> -	};
> +	struct spi_transfer tx;
> +
> +	ad7949_adc->current_channel =3D channel;
> =20
>  	ret =3D ad7949_spi_write_cfg(ad7949_adc,
>  				   channel << AD7949_CFG_CHAN_SEL_SHIFT,
> @@ -155,24 +164,29 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
>  	if (ret)
>  		return ret;
> =20
> -	ad7949_adc->buffer =3D 0;
> -	spi_message_init_with_transfers(&msg, tx, 1);
> +	(void)memset(&tx, 0, sizeof(tx));

> +	(void)memset(ad7949_adc->buffer, 0, AD7949_BUFFER_LEN);
> +
> +	tx.rx_buf =3D ad7949_adc->buffer;
> +	tx.len =3D ad7949_message_len(ad7949_adc);
> +
> +	spi_message_init_with_transfers(&msg, &tx, 1);
spi_read?

>  	ret =3D spi_sync(ad7949_adc->spi, &msg);
>  	if (ret)
>  		return ret;
> =20
>  	/*
> -	 * This delay is to avoid a new request before the required time to
> -	 * send a new command to the device
> +	 * This delay is to avoid a new request before the required time
> +	 * to send a new command to the device.
>  	 */
>  	udelay(2);
> =20
> -	ad7949_adc->current_channel =3D channel;
> +	*val =3D (ad7949_adc->buffer[0] << 8) | ad7949_adc->buffer[1];
> =20
> -	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> -		*val =3D (ad7949_adc->buffer >> AD7949_CFG_REG_SIZE_BITS) & mask;
> -	else
> -		*val =3D ad7949_adc->buffer & mask;
> +	if (ad7949_adc->resolution =3D=3D AD7949_LO_RESOLUTION) {

14, much more readable as obvious what is happening.

> +		/* 14-bit value in 16-bit buffer */
> +		*val =3D *val >> 2;
> +	}
> =20
>  	return 0;
>  }

