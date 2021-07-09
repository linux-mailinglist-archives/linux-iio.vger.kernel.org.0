Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE53C25DE
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhGIO15 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGIO14 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 10:27:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38EC0613DD;
        Fri,  9 Jul 2021 07:25:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e14so9432499qkl.9;
        Fri, 09 Jul 2021 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=5EvyeeVq0zGR1aiMOlBfdhyawQhaQMkOJwagvR7vLi4=;
        b=UqB4Y7FY0RcOFp5ceYvATO1c3w4ALAH7x1oc2xb1cDPg6n91Rap1XlYRVPgX353+lc
         AQT1QCRR+FVfvxmjuWmntcAvphQUIE8xGgm7pk8Z3hpE7s3MdTybquyB9xF9gD7NhIm1
         TyeI+hkglyNObRCnwsBkXimDFxSWrQ3LHumKz+HGmFMz5AdMFChDq9XXO2qfsA61hLsb
         bxHqc1Rf/7LWs19zcZBkDAy/tptiqfRNoKHzRKwNuGkXoj8rzPfZJ1OcKiXfNjQlVnRD
         sQR/xbfsq/Q2eKbaJkswFhcdbrY+/pUvkx/PAEU5IlgG5gBfb/k8Mc14KFt047VWWjGE
         FqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=5EvyeeVq0zGR1aiMOlBfdhyawQhaQMkOJwagvR7vLi4=;
        b=VIloLmaEQNyTe/zt1VV7/Ax8GZWIousYXLbS5y79+zNZ+UTAvQf2BZUH0TrQvsD9LP
         Vgu3hOVkI49mpdKuTGSC5Zj11FzmVeRUt0QyNVLoGSb/GH0YXNti7usXcSjmNLRPpNkL
         Dc7/Qu4sf/O4SX/d/8OVTi3EC3CQuM+JUWWcjY1TNC9jVLotJGoWJ3Y3C4R5RQKhITm1
         zsxl2TSnGiH9qB34HE7GLgPp4obk8dPdphDOpMVGgYaPDhhQfTCoIV6vSbSHcQVVFTwU
         sFXQc9347QUjwjvoEeR8NsxBb312+SYi8twb5F2Wy7UQzUWfTirKy75ltj57RAx7Z+AQ
         9PYA==
X-Gm-Message-State: AOAM530cBDdhXFPNvsPwNhneOBlo8SzMFXbqbI0qAj3XAHXbzXxhKDWw
        cYSym5Y40/xGZT728YoyUIk=
X-Google-Smtp-Source: ABdhPJx/Gy9Y9EOWESFDn/wtfiSJV1uiuhFQ89Wg2b8GNjz7upNSEavaqyBjyTTAeYhc1OqitrTPAw==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr37921760qkf.270.1625840712634;
        Fri, 09 Jul 2021 07:25:12 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id w2sm2521850qkm.65.2021.07.09.07.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:25:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jul 2021 10:25:11 -0400
Message-Id: <CCOOFJOC6MQV.2KZR4J2HPE7KP@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v1 2/4] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
References: <20210708235618.1541335-1-liambeguin@gmail.com>
 <20210708235618.1541335-3-liambeguin@gmail.com>
 <PH0PR03MB63662890FF4545AAF45E026199189@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB63662890FF4545AAF45E026199189@PH0PR03MB6366.namprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 9, 2021 at 4:19 AM EDT, Sa, Nuno wrote:
>
>
> > -----Original Message-----
> > From: Liam Beguin <liambeguin@gmail.com>
> > Sent: Friday, July 9, 2021 1:56 AM
> > To: liambeguin@gmail.com; lars@metafoo.de; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; jic23@kernel.org; charles-
> > antoine.couret@essensium.com
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; robh+dt@kernel.org
> > Subject: [PATCH v1 2/4] iio: adc: ad7949: fix spi messages on non 14-bi=
t
> > controllers
> >=20
> > [External]
> >=20
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > This driver supports devices with 14-bit and 16-bit sample sizes.
> > This is not always handled properly by spi controllers and can fail. To
> > work around this limitation, pad samples to 16-bit and split the sample
> > into two 8-bit messages in the event that only 8-bit messages are
> > supported by the controller.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/adc/ad7949.c | 67
> > ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 58 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 93aacf4f680b..bbc6b56330a3 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/module.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> > +#include <linux/bitfield.h>
> >=20
> >  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
> >  #define AD7949_CFG_REG_SIZE_BITS	14
> > @@ -57,6 +58,7 @@ static const struct ad7949_adc_spec
> > ad7949_adc_spec[] =3D {
> >   * @indio_dev: reference to iio structure
> >   * @spi: reference to spi structure
> >   * @resolution: resolution of the chip
> > + * @bits_per_word: number of bits per SPI word
> >   * @cfg: copy of the configuration register
> >   * @current_channel: current channel in use
> >   * @buffer: buffer to send / receive data to / from device
> > @@ -67,28 +69,59 @@ struct ad7949_adc_chip {
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
> >  };
> >=20
> > +static void ad7949_set_bits_per_word(struct ad7949_adc_chip
> > *ad7949_adc)
> > +{
> > +	u32 adc_mask =3D SPI_BPW_MASK(ad7949_adc->resolution);
> > +	u32 bpw =3D adc_mask & ad7949_adc->spi->controller-
> > >bits_per_word_mask;
> > +
> > +	if (bpw =3D=3D adc_mask)
> > +		ad7949_adc->bits_per_word =3D ad7949_adc-
> > >resolution;
> > +	else if (bpw =3D=3D SPI_BPW_MASK(16))
> > +		ad7949_adc->bits_per_word =3D 16;
> > +	else
> > +		ad7949_adc->bits_per_word =3D 8;
> > +}
> > +
> >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc,
> > u16 val,
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
> >=20
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
> > +		ad7949_adc->buf8[0] =3D FIELD_GET(GENMASK(13, 6),
> > ad7949_adc->cfg);
> > +		ad7949_adc->buf8[1] =3D FIELD_GET(GENMASK(5, 0),
> > ad7949_adc->cfg);
> > +		ad7949_adc->buf8[1] =3D ad7949_adc->buf8[1] << 2;
> > +		break;
> > +	}
>
> Honestly I didn't went through the driver but just a question... Are we
> sure that 'ad7949_adc->resolution' will have something valid (8, 14,
> 16)?
> A default statement is always a nice to have :).
> =20

Thanks for pointing that out. You're right that based on this driver
there's no guaranty that `ad7949_adc->resolution` will have a valid
value. I'll add a default to 8-bit.

Thanks,
Liam

> >  	spi_message_init_with_transfers(&msg, tx, 1);
> >  	ret =3D spi_sync(ad7949_adc->spi, &msg);
> >=20
> > @@ -105,14 +138,12 @@ static int ad7949_spi_read_channel(struct
> > ad7949_adc_chip *ad7949_adc, int *val,
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
> >=20
> > @@ -147,7 +178,24 @@ static int ad7949_spi_read_channel(struct
> > ad7949_adc_chip *ad7949_adc, int *val,
> >=20
> >  	ad7949_adc->current_channel =3D channel;
> >=20
> > -	*val =3D ad7949_adc->buffer & mask;
> > +	switch (ad7949_adc->bits_per_word) {
> > +	case 16:
> > +		*val =3D ad7949_adc->buffer;
> > +		/* Shift-out padding bits */
> > +		if (ad7949_adc->resolution =3D=3D 14)
> > +			*val =3D *val >> 2;
> > +		break;
> > +	case 14:
> > +		*val =3D ad7949_adc->buffer & GENMASK(13, 0);
> > +		break;
> > +	case 8:
> > +		/* Convert byte array to u16, MSB first */
> > +		*val =3D (ad7949_adc->buf8[0] << 8) | ad7949_adc-
> > >buf8[1];
> > +		/* Shift-out padding bits */
> > +		if (ad7949_adc->resolution =3D=3D 14)
> > +			*val =3D *val >> 2;
> > +		break;
> > +	}
> >=20
> >  	return 0;
> >  }
> > @@ -280,6 +328,7 @@ static int ad7949_spi_probe(struct spi_device
> > *spi)
> >  	spec =3D &ad7949_adc_spec[spi_get_device_id(spi)-
> > >driver_data];
> >  	indio_dev->num_channels =3D spec->num_channels;
> >  	ad7949_adc->resolution =3D spec->resolution;
> > +	ad7949_set_bits_per_word(ad7949_adc);
> >=20
> >  	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> >  	if (IS_ERR(ad7949_adc->vref)) {
> > --
> > 2.30.1.489.g328c10930387

