Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8218D3DCD94
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhHAULN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 16:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhHAULM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 16:11:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6B7C06175F;
        Sun,  1 Aug 2021 13:11:04 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 184so14817505qkh.1;
        Sun, 01 Aug 2021 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=mnpTQOh73vq6DtXpVHwiPk+Fj3l7/WyOJGm0/gTGsLI=;
        b=U8MI2y4eFw7qa6QYbdViBYlCqYzz+7WsJ5KZITaAxWr8HC2zd5lP8uoSuuVC5M0FwH
         zlUPAvIrSGazyrte6D83kmQedExoU8B43zmmaYl4X8XJicdIlm0CrS7YY6xFg3ssSXIT
         NjfDb+NM5uMdxdVToSP17ZONCPuGNTmYBm33nsLCMO3eN7893LwXzNJsz67mMrYD6lXE
         7KONUL1DGQA+B1JauV+a+K9+0oPDRR1k0x/EhLo9c8tiQ8Jl0MypXZW6s164pAsIpGxD
         +l1E9Hrk54BqAFw2H+Ly6cc0wh4g/O3aLDVxGojnFCsigdZM5SbBMUr44V0q9waqIgDV
         jQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=mnpTQOh73vq6DtXpVHwiPk+Fj3l7/WyOJGm0/gTGsLI=;
        b=tQC+N7LyUrqR5VBBQe8K3Ll+YoPHBSfD8rKC+EpfgnDTO1IxuDF7DIi/KAsrzcDqKr
         IdSu6gnEKHUbDASIv8SLB9vVAvHs7gszkDXXkrHadFtOlxRY7K4fRPZMp0AqNrOn7nO8
         VXD9IB/qjpOAkuSuzQepnSky4/9j9Vc/AuUM+nXksrvEuujV2tOfnrtgfuNkWUgqgbqO
         9IqtPxqe0ifkRQxmM6UyQtZYjUQufTTOMnkWTZEar+Ts8oM3qBD2DMxaAgWMvI/CGBMH
         kFKAnA7xBT7orVu+myfC4QqZKB7Sd66cvpvrgk38lqP0hKCwNdlJ7jopWF8SLFxYK/+L
         2aNA==
X-Gm-Message-State: AOAM530ScfU309O6mvJ36Ph2eHzfmGLsUlYXHRsc/4YVshL9huVK5XbA
        ei68a3KX4mhZOsnm7J9QooM=
X-Google-Smtp-Source: ABdhPJwEI5vPy8HQCTFouvTYVW2D0JqZ4iFzV8GhxRVf++LhlDw7kcMoIeRW3PQ9zZmPWL/z6TWWfg==
X-Received: by 2002:a05:620a:204c:: with SMTP id d12mr12546434qka.417.1627848663405;
        Sun, 01 Aug 2021 13:11:03 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u36sm3634231qtc.71.2021.08.01.13.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 13:11:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 01 Aug 2021 16:11:01 -0400
Message-Id: <CD8G6VGMUEZS.1XZMKLFSD4MA9@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/5] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210727232906.980769-1-liambeguin@gmail.com>
 <20210727232906.980769-3-liambeguin@gmail.com>
 <20210731152921.2fcb53ab@jic23-huawei>
In-Reply-To: <20210731152921.2fcb53ab@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat Jul 31, 2021 at 10:29 AM EDT, Jonathan Cameron wrote:
> On Tue, 27 Jul 2021 19:29:03 -0400
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
> > ---
> >  drivers/iio/adc/ad7949.c | 62 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 54 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 0b549b8bd7a9..f1702c54c8be 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -67,6 +67,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[]=
 =3D {
> >   * @indio_dev: reference to iio structure
> >   * @spi: reference to spi structure
> >   * @resolution: resolution of the chip
> > + * @bits_per_word: number of bits per SPI word
> >   * @cfg: copy of the configuration register
> >   * @current_channel: current channel in use
> >   * @buffer: buffer to send / receive data to / from device
> > @@ -77,6 +78,7 @@ struct ad7949_adc_chip {
> >  	struct iio_dev *indio_dev;
> >  	struct spi_device *spi;
> >  	u8 resolution;
> > +	u8 bits_per_word;
> >  	u16 cfg;
> >  	unsigned int current_channel;
> >  	u16 buffer ____cacheline_aligned;
> > @@ -86,19 +88,34 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_c=
hip *ad7949_adc, u16 val,
> >  				u16 mask)
> >  {
> >  	int ret;
> > -	int bits_per_word =3D ad7949_adc->resolution;
> > -	int shift =3D bits_per_word - AD7949_CFG_REG_SIZE_BITS;

Hi Jonathan,

>
> The define for this was removed in patch 1. I'll fix that up whilst
> applying by
> keeping it until this patch. Please check build passes on intermediate
> points
> during a patch series as otherwise we may break bisectability and that's
> really
> annoying if you are bisecting!

Apologies for that. I'll make sure to add at least a `git rebase -x` to
my checks.
I'll fix it before sending the next version of this series.

Thanks,
Liam

>
> Jonathan
>
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
> > +		/* Here, type is big endian as it must be sent in two transfers */
> > +		ad7949_adc->buffer =3D (u16)cpu_to_be16(ad7949_adc->cfg << 2);
> > +		break;
> > +	default:
> > +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	spi_message_init_with_transfers(&msg, tx, 1);
> >  	ret =3D spi_sync(ad7949_adc->spi, &msg);
> > =20
> > @@ -115,14 +132,12 @@ static int ad7949_spi_read_channel(struct ad7949_=
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
> > @@ -157,7 +172,25 @@ static int ad7949_spi_read_channel(struct ad7949_a=
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
> > +		/* Here, type is big endian as data was sent in two transfers */
> > +		*val =3D be16_to_cpu(ad7949_adc->buffer);
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
> > @@ -265,6 +298,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *=
ad7949_adc)
> > =20
> >  static int ad7949_spi_probe(struct spi_device *spi)
> >  {
> > +	u32 spi_ctrl_mask =3D spi->controller->bits_per_word_mask;
> >  	struct device *dev =3D &spi->dev;
> >  	const struct ad7949_adc_spec *spec;
> >  	struct ad7949_adc_chip *ad7949_adc;
> > @@ -291,6 +325,18 @@ static int ad7949_spi_probe(struct spi_device *spi=
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

