Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69273D823E
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 00:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhG0WFB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhG0WFB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 18:05:01 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A38C061757;
        Tue, 27 Jul 2021 15:05:00 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k7so273510qki.11;
        Tue, 27 Jul 2021 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=ia2hRHAtxzc2Mv29NRcAy1FNG6RZ+8sTS8CBnd5aTm0=;
        b=BCUe65SC8GpBl3WUfWNUk1nKIFt9Y9z7fwUO0qSWYx6/+pyPQ/9ZwSasgJ/tk0U4sv
         yduPPj85jly1id1tAm0Io86ut99sbiO84ecfL1rt4xyhVh69ziG1QiyeK4D5NwXb8Ugw
         LipIS4VR4ZxuQJgkDxHyhgY9hRzbabV1XYNygF8q62VbKQdtqN8Lp2mztcFGdNYk9iBa
         jIj2lKUKYWwdC9ONqBYXG2L5q023+CdYVHU2+GfJuTmEYgd8VCMu6hVchsPWTWuxYLkv
         ELzMY7B3DdqfQBs2k+4BZi0tlUE+KLVK8at+UOlKFaNZwQ239yRgLtMVfazHB1WeBDc2
         eUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=ia2hRHAtxzc2Mv29NRcAy1FNG6RZ+8sTS8CBnd5aTm0=;
        b=L/ZUVHvkDbGNBiB4l8iju3ZymBzn4z+W9gJk621xHTtkpezgbRNYgOs0wrWc6kbQm1
         Yzy9tsXvjXLLvyHJYLq5FelxW7XTQv83e1wcPEHRFETidWmvSC591DDAJCfTmDIAb0Qu
         x8mF/qh9w4Ul0DdfWaavlwVXRzHhgAqz3cdZi6aTtoFHx3uRiyy7gvG5Imjnbhv3Afny
         i/ZKH8U4xSMxQnPdLh+Py6l5dFKhqus2kbFQ1m10YWn5zXFcB5llKl7mj+MW0Wl5e0al
         VkjT6PxKTRiKNKWRE3hbfv65EXiM/oVpAk4fsfgtKQIsLwBUecdmSz0qRz7ukwJgPfcq
         JS1Q==
X-Gm-Message-State: AOAM530cSJH9HrODg3rVLJbAcniLe52gLZFhM6iXGydqa2IRfhLpRPor
        mr5Blgse3v6oP8vmv9A3xns=
X-Google-Smtp-Source: ABdhPJzXuRHcvnmJuZOIhs1laEcBS/lL3tkGv3brozKiN3yVAp9T1X+qefdOo7g4JYj0oSOBhEt5yw==
X-Received: by 2002:a37:6154:: with SMTP id v81mr25449203qkb.38.1627423499608;
        Tue, 27 Jul 2021 15:04:59 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h10sm2054136qta.74.2021.07.27.15.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 15:04:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Jul 2021 18:04:58 -0400
Message-Id: <CD49HDWV8X1Y.1QC2FTTVBPH9Z@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/4] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
 <20210713043425.3321230-3-liambeguin@gmail.com>
 <20210717182326.487709af@jic23-huawei>
In-Reply-To: <20210717182326.487709af@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat Jul 17, 2021 at 1:23 PM EDT, Jonathan Cameron wrote:
> On Tue, 13 Jul 2021 00:34:23 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > This driver supports devices with 14-bit and 16-bit sample sizes.
> > This is not always handled properly by spi controllers and can fail. To
> > work around this limitation, pad samples to 16-bit and split the sample
> > into two 8-bit messages in the event that only 8-bit messages are
> > supported by the controller.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
>
> A small tidy up below that will make this even neater...
>
> > ---
> >  drivers/iio/adc/ad7949.c | 68 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 60 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 0b549b8bd7a9..65f78751225b 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/bitfield.h>
> > +#include <asm/unaligned.h>
> > =20
> >  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
> > =20
> > @@ -67,6 +68,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[]=
 =3D {
> >   * @indio_dev: reference to iio structure
> >   * @spi: reference to spi structure
> >   * @resolution: resolution of the chip
> > + * @bits_per_word: number of bits per SPI word
> >   * @cfg: copy of the configuration register
> >   * @current_channel: current channel in use
> >   * @buffer: buffer to send / receive data to / from device
> > @@ -77,6 +79,7 @@ struct ad7949_adc_chip {
> >  	struct iio_dev *indio_dev;
> >  	struct spi_device *spi;
> >  	u8 resolution;
> > +	u8 bits_per_word;
> >  	u16 cfg;
> >  	unsigned int current_channel;
> >  	u16 buffer ____cacheline_aligned;
> > @@ -86,19 +89,37 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_c=
hip *ad7949_adc, u16 val,
> >  				u16 mask)
> >  {
> >  	int ret;
> > -	int bits_per_word =3D ad7949_adc->resolution;
> > -	int shift =3D bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> > +	u8 buf8[2];
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
> > +		/* Pack 14-bit value into 2 bytes, MSB first */
> > +		buf8[0] =3D FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
> > +		buf8[1] =3D FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg) << 2;
> > +		memcpy(&ad7949_adc->buffer, buf8, 2);

Hi Jonathan,

Apologies for the delay on this.

>
> Can probably tidy this up given the form - all we actually need to do is
> ensure the
> value ends up big endian.
>
> /* Type is only big endian for this case as must be done as two
> transfers */
> ad7949_adc->buffer =3D (u16)cpu_to_be16(ad7959_adc->cfg << 2);

That's much nicer, I'll rework the patch using this.

Thanks,
Liam

>
> > +		break;
> > +	default:
> > +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	spi_message_init_with_transfers(&msg, tx, 1);
> >  	ret =3D spi_sync(ad7949_adc->spi, &msg);
> > =20
> > @@ -115,14 +136,13 @@ static int ad7949_spi_read_channel(struct ad7949_=
adc_chip *ad7949_adc, int *val,
> >  {
> >  	int ret;
> >  	int i;
> > -	int bits_per_word =3D ad7949_adc->resolution;
> > -	int mask =3D GENMASK(ad7949_adc->resolution - 1, 0);
> > +	u8 buf8[2];
>
> As below, not needed that I can see.
>
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
> > @@ -157,7 +177,26 @@ static int ad7949_spi_read_channel(struct ad7949_a=
dc_chip *ad7949_adc, int *val,
> > =20
> >  	ad7949_adc->current_channel =3D channel;
> > =20
> > -	*val =3D ad7949_adc->buffer & mask;
> > +	switch (ad7949_adc->bits_per_word) {
> > +	case 16:
> > +		*val =3D ad7949_adc->buffer;
> > +		/* Shift-out padding bits */
> > +		*val >>=3D 16 - ad7949_adc->resolution;
> > +		break;
> > +	case 14:
> > +		*val =3D ad7949_adc->buffer & GENMASK(13, 0);
> > +		break;
> > +	case 8:
> > +		memcpy(buf8, &ad7949_adc->buffer, 2);
> > +		/* Convert byte array to u16, MSB first */
> > +		*val =3D get_unaligned_be16(buf8);
>
> Why the local copy first?
>
> *val =3D get_unaligned_be16(ad7949_adc->buffer);
>
> should get what you want, it doesn't care about the type.
> Even better, that buffer is aligned, so we can do
> be16_to_cpu() safely I think...
>
> > +		/* Shift-out padding bits */
> > +		*val >>=3D 16 - ad7949_adc->resolution;
> > +		break;
> > +	default:
> > +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> > +		return -EINVAL;
> > +	}
> > =20
> >  	return 0;
> >  }
> > @@ -265,6 +304,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *=
ad7949_adc)
> > =20
> >  static int ad7949_spi_probe(struct spi_device *spi)
> >  {
> > +	u32 spi_ctrl_mask =3D spi->controller->bits_per_word_mask;
> >  	struct device *dev =3D &spi->dev;
> >  	const struct ad7949_adc_spec *spec;
> >  	struct ad7949_adc_chip *ad7949_adc;
> > @@ -291,6 +331,18 @@ static int ad7949_spi_probe(struct spi_device *spi=
)
> >  	indio_dev->num_channels =3D spec->num_channels;
> >  	ad7949_adc->resolution =3D spec->resolution;
> > =20
> > +	/* Set SPI bits per word */
> > +	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
> > +		ad7949_adc->bits_per_word =3D ad7949_adc->resolution;
> > +	} else if (spi_ctrl_mask =3D=3D SPI_BPW_MASK(16)) {
> > +		ad7949_adc->bits_per_word =3D 16;
> > +	} else if (spi_ctrl_mask =3D=3D SPI_BPW_MASK(8)) {
> > +		ad7949_adc->bits_per_word =3D 8;
> > +	} else {
> > +		dev_err(dev, "unable to find common BPW with spi controller\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> >  	if (IS_ERR(ad7949_adc->vref)) {
> >  		dev_err(dev, "fail to request regulator\n");

