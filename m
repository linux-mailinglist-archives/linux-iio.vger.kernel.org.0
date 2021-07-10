Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839883C360C
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhGJSUK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhGJSUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jul 2021 14:20:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC4C0613DD;
        Sat, 10 Jul 2021 11:17:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z25so7508515qto.12;
        Sat, 10 Jul 2021 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=NCUU5JuXWaoTBn7XNb1OVj/949g2YlQ7jTkVqCc7yQo=;
        b=K9aXtxijKGMatgEuxOS9p1dO2+OnXbp2bNTci1vUfKh4NYQABKcF701cCK3HDDmayz
         WDPF0UrVk5nTQEpvD0e3F6e3QYRyvZhBqpvPYlRSMX5JsVByFdNJy9cHmRCox9E6szie
         0RTB/1FKxQfXae1rsTw0yG7/pAVViE/CQBCP2Kj187jsvfU3ruPo98+pZfL/m+PWK77K
         7A6iypmXJyZaLPqKnjp+geyrPNktBr5/zMSRWEhxutitgLqVPZ5G3AdYcWwcDdKptpjY
         wKsEbL3VPi+/IK08Rja1RyqbhiuzAzRLh/EKeuaFiBecV+q40WhPpHJc+X6yne23BwD2
         HDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=NCUU5JuXWaoTBn7XNb1OVj/949g2YlQ7jTkVqCc7yQo=;
        b=j0HXtMa2QC7OwIftu6cFB5L3Y3o6Aw2sCSslOYkZ3UX58jtgWKzydHyhdyl9e5NVrV
         ppG/4Vd4nMwL2o9MPUtelUkQZ1EH1iRI/cAQ9U/bb+sO8ZtjKe+SJZ0BS7Y43vcoLT4f
         zPPw0Eb6DoBOKG+XPW/0RGWOfpuTnFvDk9xEc/vGJxQ3VIpXh0a0VKmws2WKYB+mr2tQ
         Es0lDLZGI+P8LewwIKwJQrb9tGaDKp71e79VhANuSVrt3mC414BFJlYZvlzSYpiG7nAM
         cqvDgrU3Y6kjm7SA4CsKHoP0gceGxk8/2tWplVzE/h8C+W2JTcwKYJVwP2YKjBUrh+WS
         c2pA==
X-Gm-Message-State: AOAM532dMQ+d9h6VP+9Dy9/AQ+GmtOexJfxXXz+owQbXxGENOl5SxZcq
        gfM/NSM/f1uPDiupAN60N7I=
X-Google-Smtp-Source: ABdhPJy77ebmU3YbXKzAIIqUP81l+O4tk1wiaTzXqqEJuG3bP6v+xyKfOBEumhoyvWP7IfP249bwwQ==
X-Received: by 2002:ac8:1106:: with SMTP id c6mr40283019qtj.20.1625941043572;
        Sat, 10 Jul 2021 11:17:23 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j141sm4179192qke.33.2021.07.10.11.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 11:17:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 10 Jul 2021 14:17:22 -0400
Message-Id: <CCPNZV2YBJBG.3VSIFN36ZOD4W@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7949: define and use bitfield names
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
 <20210709155856.1732245-2-liambeguin@gmail.com>
 <20210710170837.263d6b1a@jic23-huawei>
In-Reply-To: <20210710170837.263d6b1a@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat Jul 10, 2021 at 12:08 PM EDT, Jonathan Cameron wrote:
> On Fri, 9 Jul 2021 11:58:53 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Replace raw configuration register values by using FIELD_PREP and
> > defines to improve readability.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>

Hi Jonathan,

>
> Ideally fixes should come before any refactors / cleanups like this one.
> That reduces the burden if people want to backport them.
>
> In this particular case I'm guessing no one ran into the issues the
> following patches deal with so we can just take these in the order
> you have here.
>

Understood, I will follow that guideline next time.

> Otherwise, good cleanup. A few minor comments inline, mostly as a result
> of some less than ideal name choices on the datasheet.
>
> > ---
> >  drivers/iio/adc/ad7949.c | 38 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 31 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 1b4b3203e428..93aacf4f680b 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -12,12 +12,27 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> > =20
> > -#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
> >  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
> > -#define AD7949_OFFSET_CHANNEL_SEL	7
> > -#define AD7949_CFG_READ_BACK		0x1
> >  #define AD7949_CFG_REG_SIZE_BITS	14
> > =20
> > +#define AD7949_CFG_BIT_CFG		BIT(13)
>
> Even though that's the name on the datasheet it is silly!

Agreed, datasheet register and bitfield names aren't always great :-/

>
> I would have just one define called
> AD7949_CFG_VAL_OVERWRITE BIT(13)
>
> It's common to do that for single flags where
> FIELD_PREP(AD7949_CFG_VAL_OVERWRITE, 1) for example has an
> obvious meaning for the 1.
>

Sounds good, I'll fix these with your recommendation.

> > +#define AD7949_CFG_VAL_CFG_OVERWRITE		1
> > +#define AD7949_CFG_VAL_CFG_KEEP			0
> > +#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)
> > +#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
> > +#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
> > +#define AD7949_CFG_VAL_INCC_UNIPOLAR_DIFF	4
> > +#define AD7949_CFG_VAL_INCC_TEMP		3
> > +#define AD7949_CFG_VAL_INCC_BIPOLAR		2
> > +#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
> > +#define AD7949_CFG_BIT_INX		GENMASK(9, 7)
>
> This is rather non obvious abbreviation. _INx would be clearer
> perhaps, but then we'd get someone fixing the camel case...
> Given it would be good to match the datasheet, keep the name
> but add a comment to say this is the input channel select.
>

I agree! While I'm at it, I might as well add comments for INCC and
others that aren't so abvious.

Thanks,
Liam

> > +#define AD7949_CFG_BIT_BW		BIT(6)
>
> As above, I'd suggest just defining AD7949_CFG_VAL_BW_FULL BIT(6)
> then it's either full or not depending on a 0 or 1 write.
>
> > +#define AD7949_CFG_VAL_BW_FULL			1
> > +#define AD7949_CFG_VAL_BW_QUARTER		0
> > +#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> > +#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> > +#define AD7949_CFG_BIT_RBN		BIT(0)
> > +
> >  enum {
> >  	ID_AD7949 =3D 0,
> >  	ID_AD7682,
> > @@ -109,8 +124,8 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
> >  	 */
> >  	for (i =3D 0; i < 2; i++) {
> >  		ret =3D ad7949_spi_write_cfg(ad7949_adc,
> > -					   channel << AD7949_OFFSET_CHANNEL_SEL,
> > -					   AD7949_MASK_CHANNEL_SEL);
> > +					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
> > +					   AD7949_CFG_BIT_INX);
> >  		if (ret)
> >  			return ret;
> >  		if (channel =3D=3D ad7949_adc->current_channel)
> > @@ -214,10 +229,19 @@ static int ad7949_spi_init(struct ad7949_adc_chip=
 *ad7949_adc)
> >  {
> >  	int ret;
> >  	int val;
> > +	u16 cfg;
> > =20
> > -	/* Sequencer disabled, CFG readback disabled, IN0 as default channel =
*/
> >  	ad7949_adc->current_channel =3D 0;
> > -	ret =3D ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
> > +
> > +	cfg =3D FIELD_PREP(AD7949_CFG_BIT_CFG, AD7949_CFG_VAL_CFG_OVERWRITE) =
|
> > +		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
> > +		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
> > +		FIELD_PREP(AD7949_CFG_BIT_BW, AD7949_CFG_VAL_BW_FULL) |
> > +		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_REF_EXT_BUF) |
> > +		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
> > +		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
> > +
> > +	ret =3D ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_MASK_TOTAL);
> > =20
> >  	/*
> >  	 * Do two dummy conversions to apply the first configuration setting.

