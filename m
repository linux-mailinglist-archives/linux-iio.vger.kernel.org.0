Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35683C3EEB
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhGKUBS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 16:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKUBR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jul 2021 16:01:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F1C0613DD;
        Sun, 11 Jul 2021 12:58:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z9so1762807qkg.5;
        Sun, 11 Jul 2021 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=o63e5uLzQ3XRQXbyWYElVkYc2hnM+AZGWyQYyvpfVzo=;
        b=QwPuANSHO/noElZSrwF28yagZA1ldrNrJUITzaiPHAXcYr+Lz0JX53qLQwYFyPPJxl
         HaNe6zin6DSEWn5emmPX1iFhYtC0xcNps+gzQ6x93a28KK+rQo6Qy6YDMZU2rMyTEdl5
         SJZGg56tMH78ejELdOEmasIov0sYXUoTcA3M/yUd1UXobvYjO3rrCmDlAxsH6ddv4cLJ
         ZbuRZSZhMSg4N0rprEKDDHLF65hxLnmYeO1zsSKUA52LFh/ZYsi+Hvs4aTBHTSehLMgL
         Z79BYUvlAhVx6K6PZbvNrLMZwNbtm3OR3ud24K2aIW6zIIfGJ+9XlR80hCgDoJvnwEFC
         45FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=o63e5uLzQ3XRQXbyWYElVkYc2hnM+AZGWyQYyvpfVzo=;
        b=E36Ro1RZ2lDpZPLl8wO1UwSxcwixklbZOrPwlcoPYUX+kXl5puv6O5O8lcqcTLZcwM
         Cv1qPstbvBvSYk3PqKKJkdKkIG6MFc6kK59HGwVgJ9gGSf7bRSe4yQMmHnIf8//hIwLr
         a33gcQ7nI2PT8Rgh9KNWfQXMqoNz59WGJWy/wwI5UnOsAVN/GH4cWI4MsR3DL454nYR/
         vzwJls+OhdwCkNqRxSD3zQfWzC5rshaQoiiWVDmfmfuUgWAA92PBmNeQm6SCa2jhPMmL
         H9hlJOhFLu/Q8Z1f1vlw74S5ZqbzE/Sh/Qe3n3KLLyCV8H/8Tc2GIGWVHwnZmGMHV7cd
         ef1A==
X-Gm-Message-State: AOAM530cZkRGt87mESvTnLzxwGThUWwk9czwyRn0On16TFln3xefGMIn
        NChpzy86KFHB7lYgcmGLYck=
X-Google-Smtp-Source: ABdhPJyvJiTYFOoPbVRhxCqbvl1k4qviXshYTY31+p/wppTSr5VuogK1X8jte3ImwPHKJuNr3DWzJQ==
X-Received: by 2002:a37:b942:: with SMTP id j63mr49190790qkf.430.1626033509429;
        Sun, 11 Jul 2021 12:58:29 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u184sm5517180qkd.53.2021.07.11.12.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 12:58:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Jul 2021 15:58:27 -0400
Message-Id: <CCQKRT3BAWMZ.808X3PQPIH4R@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
 <20210709155856.1732245-3-liambeguin@gmail.com>
 <20210710173940.60764398@jic23-huawei>
In-Reply-To: <20210710173940.60764398@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat Jul 10, 2021 at 12:39 PM EDT, Jonathan Cameron wrote:
> On Fri, 9 Jul 2021 11:58:54 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > This driver supports devices with 14-bit and 16-bit sample sizes.
> > This is not always handled properly by spi controllers and can fail. To
> > work around this limitation, pad samples to 16-bit and split the sample
> > into two 8-bit messages in the event that only 8-bit messages are
> > supported by the controller.
>
> Hmm. I assumed spi controllers would all support 16 bits, but a quick
> grep confirms otherwise... ah well!
>
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/adc/ad7949.c | 69 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 60 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 93aacf4f680b..770112ac820f 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/module.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> > +#include <linux/bitfield.h>
> > =20
> >  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
> >  #define AD7949_CFG_REG_SIZE_BITS	14
> > @@ -57,6 +58,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[]=
 =3D {
> >   * @indio_dev: reference to iio structure
> >   * @spi: reference to spi structure
> >   * @resolution: resolution of the chip
> > + * @bits_per_word: number of bits per SPI word
> >   * @cfg: copy of the configuration register
> >   * @current_channel: current channel in use
> >   * @buffer: buffer to send / receive data to / from device
> > @@ -67,28 +69,60 @@ struct ad7949_adc_chip {
> >  	struct iio_dev *indio_dev;
> >  	struct spi_device *spi;
> >  	u8 resolution;
> > +	u8 bits_per_word;
> >  	u16 cfg;
> >  	unsigned int current_channel;
> > -	u16 buffer ____cacheline_aligned;
> > +	union {
> > +		__be16 buffer;
> > +		u8 buf8[2];
> > +	} ____cacheline_aligned;

Hi Jonathan,

>
> This union made me a little nervous given issues with them under c spec,
> but
> seems that you only use buffer or buf8, there is no mixing. I think I'd
> rather you didn't have the union though as it makes it look like there
> might be.

I don't particularly like unions either..
If I'm not mistaken, the only place where the union is useful is
in the spi_transfer struct definitions. I'll use a local buf8 there
instead.

>
> Given we are doing cacheline spacing anyway for dma safety it take no
> more
> real space to just have
>
> __be16 buffer ____cacheline_aligned;
> buf8[2];
>
>
>
> >  };
> > =20
> > +static void ad7949_set_bits_per_word(struct ad7949_adc_chip *ad7949_ad=
c)
> > +{
> > +	u32 adc_mask =3D SPI_BPW_MASK(ad7949_adc->resolution);
> > +	u32 bpw =3D adc_mask & ad7949_adc->spi->controller->bits_per_word_mas=
k;
> > +
> > +	if (bpw =3D=3D adc_mask)
>
> if (bpw) is sufficient I think.
>
> > +		ad7949_adc->bits_per_word =3D ad7949_adc->resolution;
> > +	else if (bpw =3D=3D SPI_BPW_MASK(16))
>
> I'm missing something here... If the resolution is 14, but the SPI
> controller
> supports 8 and 16 I'd expect us to hit here . adc_mask will not have the
> 16bit
> bit set though so bpw =3D=3D 0..
>
> else if (ad7949_adc->spi->controller_bits_per_word_mask &
> SPI_BPW_MASK(16))
>
> should do the right thing.
>
> > +		ad7949_adc->bits_per_word =3D 16;
> > +	else
> > +		ad7949_adc->bits_per_word =3D 8;
>
> I'd like a comment here on why this is the right default. Took me a
> while
> to think through it.
>

I'll rework this function based on your comments and fail early on
unsupported cases.

> > +}
> > +
> >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u1=
6 val,
> >  				u16 mask)
> >  {
> >  	int ret;
> > -	int bits_per_word =3D ad7949_adc->resolution;
> > -	int shift =3D bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> >  	struct spi_message msg;
> >  	struct spi_transfer tx[] =3D {
> >  		{
> >  			.tx_buf =3D &ad7949_adc->buffer,
> >  			.len =3D 2,
> > -			.bits_per_word =3D bits_per_word,
> > +			.bits_per_word =3D ad7949_adc->bits_per_word,
> >  		},
> >  	};
> > =20
> > +	ad7949_adc->buffer =3D 0;
> >  	ad7949_adc->cfg =3D (val & mask) | (ad7949_adc->cfg & ~mask);
> > -	ad7949_adc->buffer =3D ad7949_adc->cfg << shift;
> > +
> > +	switch (ad7949_adc->bits_per_word) {
> > +	case 16:
> > +		ad7949_adc->buffer =3D ad7949_adc->cfg << 2;
> > +		break;
> > +	case 14:
> > +		ad7949_adc->buffer =3D ad7949_adc->cfg;
> > +		break;
> > +	case 8:
> > +	default:
>
> Default here should be an error. Imagine a 12 bit device is added. Then
> the above set_bits_per_word() might return either 12 or 8. If it returns
> 12 then this is not the right thing to do. I'd argue we want to know
> about
> that rather than papering over it. Possibly we want to not let anything
> other
> than 14 bits through in set_bits_per_word() so we print an error
> early...
>

Sorry about that, I added that default case maybe a little too quickly.
I'll fix that.

> > +		/* Pack 14-bit value into 2 bytes, MSB first */
> > +		ad7949_adc->buf8[0] =3D FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
> > +		ad7949_adc->buf8[1] =3D FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
> > +		ad7949_adc->buf8[1] =3D ad7949_adc->buf8[1] << 2;
> > +		break;
> > +	}
> > +
> >  	spi_message_init_with_transfers(&msg, tx, 1);
> >  	ret =3D spi_sync(ad7949_adc->spi, &msg);
> > =20
> > @@ -105,14 +139,12 @@ static int ad7949_spi_read_channel(struct ad7949_=
adc_chip *ad7949_adc, int *val,
> >  {
> >  	int ret;
> >  	int i;
> > -	int bits_per_word =3D ad7949_adc->resolution;
> > -	int mask =3D GENMASK(ad7949_adc->resolution - 1, 0);
> >  	struct spi_message msg;
> >  	struct spi_transfer tx[] =3D {
> >  		{
> >  			.rx_buf =3D &ad7949_adc->buffer,
> >  			.len =3D 2,
> > -			.bits_per_word =3D bits_per_word,
> > +			.bits_per_word =3D ad7949_adc->bits_per_word,
> >  		},
> >  	};
> > =20
> > @@ -147,7 +179,25 @@ static int ad7949_spi_read_channel(struct ad7949_a=
dc_chip *ad7949_adc, int *val,
> > =20
> >  	ad7949_adc->current_channel =3D channel;
> > =20
> > -	*val =3D ad7949_adc->buffer & mask;
> > +	switch (ad7949_adc->bits_per_word) {
> > +	case 16:
> > +		*val =3D ad7949_adc->buffer;
>
> buffer is __be16 and *val is an int so this isn't valid.
>
> Now curious bit is I'm assuming original code worked... Given big endian
> platforms are rare, that makes me suspect something odd is going on.
> =20

Hum... that's probably my fault. I changed the type of buffer from u16
to _be16.
I'll add calls to be16_to_cpu() around this and the 14 bit case.

> > +		/* Shift-out padding bits */
> > +		if (ad7949_adc->resolution =3D=3D 14)
> > +			*val =3D *val >> 2;
>
> *val >>=3D 16 - ad7949_adc->resolution;
>
> No one likes conditionals if we don't need them!

Will do.

>
>
> > +		break;
> > +	case 14:
> > +		*val =3D ad7949_adc->buffer & GENMASK(13, 0);
> > +		break;
> > +	case 8:
> > +	default:
> > +		/* Convert byte array to u16, MSB first */
> > +		*val =3D (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];
>
> Use unaligned_get_be16()
>
> > +		/* Shift-out padding bits */
> > +		if (ad7949_adc->resolution =3D=3D 14)
> > +			*val =3D *val >> 2;
>
> As above make this unconditional.
>

Thanks,
Liam

> > +		break;
> > +	}
> > =20
> >  	return 0;
> >  }
> > @@ -280,6 +330,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
> >  	spec =3D &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
> >  	indio_dev->num_channels =3D spec->num_channels;
> >  	ad7949_adc->resolution =3D spec->resolution;
> > +	ad7949_set_bits_per_word(ad7949_adc);
> > =20
> >  	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> >  	if (IS_ERR(ad7949_adc->vref)) {

