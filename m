Return-Path: <linux-iio+bounces-21172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B153AEEA7F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 00:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A408917A37B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 22:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1F243953;
	Mon, 30 Jun 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv1mSAXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C54502F;
	Mon, 30 Jun 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322816; cv=none; b=VR8aDgQogD8pLYGolt5zyMCXLpa8gXPZCbsT3Jo8ZhoU2RFHiPlC515pzdBEwjv9YZ8vDIRT31Iytpozs70WcLGw3KxOgVAtiZ95oGWOgDEW5GoYPG+aqqfi8k/0hcQDW/2Kp9LX3swbNz1or3xpnPAkoZdPpz+bSmmHXZOv+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322816; c=relaxed/simple;
	bh=OADl2soM9M+rvnb6BfXcKVp2fdupMqf0U6Td+mqHvCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXVFSmLPJN/ed8+Sy2vRUMc80NHszDNqfc25D2VhmX09KORLiVSDhMdWdPNtN4Is5nziIGzThT8EV10oTDuMPlcpMD/KpMS4DdCxn1sin8WZvEgOje/C3HVK+pzrAoKkpLBi8u6Pi4PDYWNdXbbQXqAI6AlPG1yvX4Sn/MiN1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv1mSAXK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7111f616c6bso5579647b3.1;
        Mon, 30 Jun 2025 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751322814; x=1751927614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCmXpBNj4pQXixPtaFxMndwyGBDxbGqsm6NfQl0j1Vo=;
        b=Cv1mSAXKV6xleFSuF4HI8kfEJ5+jib+uowVufWhcKdjIiL57Ac+aHRPokEIBFdANld
         ei0PujUmP3g8sWUbWlly4VMR/rzDvXGzzLyzMPwLsd/VkB8ffD/1v7yWBVo0W0jVPGZs
         or3kIqdGwuoo33XGRBXuhOyJChCrhwZh36eEuHyN98ytXDFJ2bXZZkuSuP2Yn3vM5bYJ
         sEo+DbL5yUrC4pWyptA1lAs72vZvEozuxM4wmrsHgjngja2BGpc9iLoVXk9VN3tsvWUW
         h43hj0TY07iguC3QiOIxJhYhGRHhypfXD1TLJsZlUr44Z0jYMiVaZRT48o3A9d3wKgTr
         hw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751322814; x=1751927614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCmXpBNj4pQXixPtaFxMndwyGBDxbGqsm6NfQl0j1Vo=;
        b=AOBaEKmMbASZdaS9Ais+V3+p3OvczCoKk+vc7ZOyRr7BoZl2gMzw59eSHvI6HXXhOs
         iJ1rB2zhbO5RuR6He1sOiDC0QxN3JlI3nnVxjLpg0JH9NHmlSiUDFpE4H+PJLMCotLmo
         yA3TOadcIuWJ7DPts2sFw3IifI2VQw0xbtB3ZrIr3nLMYgJ6DUuX1uIgsRfOZ7sidEa1
         B9PikeKLS+XyikeNJLBIqvdorYcbQILcLbTY3Cp07bRKy+wHTfRFnCv98F/IjWJo5ah8
         aPcBRlR+almtSf8PosyMrWbsMZVvizNRqrohCfMkbrgNq1xb24eQXVU2TYf2z/1pb5jw
         vsFw==
X-Forwarded-Encrypted: i=1; AJvYcCVeiyD2/9LE97L60q+OJCY4qEkEPccXmSVV5pHypR/nxPzvLNLnIqwgC8xyE1rasZUTdDeyYt8g53qY@vger.kernel.org, AJvYcCWH0iSWhl0Pyx3xvw+34ZNlTztsGtzBnDkfj7xjjDjR1tcQBH0Xrj6uMICU4Pmk/gb4yA5LoX4H44GNMDl0@vger.kernel.org, AJvYcCWJjqGMf+qpd86GXA4W2ljEoXmYa6zT5G67EP1MPip1o01ctJGyLuvidVtU4DKdl1OUJoASWED158U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CrnXtMUqwZeoAhvSq/GukPshDmPS8cbkIqeYssbKJLRytWsk
	Iz077Y6aOnC13tuAILClOg0O1zA/nFsRbe9t5zsz3CbWDfzdpHqH7w6oJlFmfJJbkHYaf4Vh7us
	MUYM4NvU1toA4cKqAMuWfNE5BezqESMI=
X-Gm-Gg: ASbGncvu5l8oNyYUirrW37+wpXEZEmUDpb6ud+HPYgLYV7jn6jOBp2/mrVoCsP/2TLJ
	3BdlKVP//iYfh9hxO30r96vT2H+KPc5H+Paoc41fBNrkhuxaEC3sES0f0rRcDXtYC32mVbc/MK+
	E84rII02sGM/KvkuZRnTNsDtnr9YJoruoOJTBoWDzAP+Q=
X-Google-Smtp-Source: AGHT+IHbkkWUdVf+O6zbt3r7Q8jhQXYmB2HzNJF1e4iVs+GsCG+laa97RKFm7JPAMmPMTild9bAOK/UN7QwoZ3cCzXg=
X-Received: by 2002:a05:690c:6605:b0:712:c55c:4e61 with SMTP id
 00721157ae682-7163f79f5e8mr6697807b3.5.1751322813831; Mon, 30 Jun 2025
 15:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622122937.156930-1-l.rubusch@gmail.com> <20250622122937.156930-5-l.rubusch@gmail.com>
 <20250628182706.2af83c1c@jic23-huawei>
In-Reply-To: <20250628182706.2af83c1c@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 1 Jul 2025 00:32:57 +0200
X-Gm-Features: Ac12FXz8kUDlCOb55lLy8I0PbFN3nkrU_WAb3nA5v345EGO2lIihKeqf5oxKMoE
Message-ID: <CAFXKEHaYdwvi64+yBEiYuv62Vaa8exYFji2gBXQciJ=CWdhbsw@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] iio: accel: adxl313: add activity sensing
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 7:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 22 Jun 2025 12:29:33 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add support for configuring an activity detection threshold. Extend the
> > interrupt handler to process activity-related interrupts, and provide
> > functions to set the threshold as well as to enable or disable activity
> > sensing. Additionally, introduce a virtual channel that represents the
> > logical AND of the x, y, and z axes in the IIO channel.
> >
> > This patch serves as a preparatory step; some definitions and functions
> > introduced here are intended to be extended later to support inactivity
> > detection.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar.
>
> I think this is suffering from function naming evolution and we need
> to rethink (slightly) what we ended up with.  See inline.
> I walked into the same trap recently so was on the look out for it.
>
> > ---
> >  drivers/iio/accel/adxl313_core.c | 326 +++++++++++++++++++++++++++++++
> >  1 file changed, 326 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl3=
13_core.c
> > index ac4cc16399fc..d2c625f27555 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -13,8 +13,10 @@
>
> > +
> > +static int _adxl313_read_mag_value(struct adxl313_data *data,
> > +                                enum iio_event_direction dir,
> > +                                enum adxl313_activity_type type_act,
> > +                                int *val, int *val2)
> > +{
> > +     unsigned int threshold;
> > +     int ret;
> > +
> > +     switch (dir) {
> > +     case IIO_EV_DIR_RISING:
> > +             ret =3D regmap_read(data->regmap,
> > +                               adxl313_act_thresh_reg[type_act],
> > +                               &threshold);
> > +             if (ret)
> > +                     return ret;
> > +             *val =3D threshold * 15625;
> > +             *val2 =3D MICRO;
> > +             return IIO_VAL_FRACTIONAL;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int _adxl313_write_mag_value(struct adxl313_data *data,
> > +                                 enum iio_event_direction dir,
> > +                                 enum adxl313_activity_type type_act,
> > +                                 int val, int val2)
> > +{
> > +     unsigned int regval;
> > +
> > +     /* Scale factor 15.625 mg/LSB */
> > +     regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> > +     switch (dir) {
> > +     case IIO_EV_DIR_RISING:
> > +             return regmap_write(data->regmap,
> > +                                 adxl313_act_thresh_reg[type_act],
> > +                                 regval);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int adxl313_read_mag_value(struct adxl313_data *data,
> > +                               enum iio_event_direction dir,
> > +                               enum iio_event_info info,
> > +                               enum adxl313_activity_type type_act,
> > +                               int *val, int *val2)
> > +{
> > +     switch (info) {
> > +     case IIO_EV_INFO_VALUE:
> > +             return _adxl313_read_mag_value(data, dir,
>
> Same issue as below for read functions.
>
> > +                                            type_act,
> > +                                            val, val2);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int adxl313_write_mag_value(struct adxl313_data *data,
>
> This has me a little confused. It's called
> adxl313_write_mag_value() which seems pretty specific but
> then calls another level of _adxl313_write_mag_value.
>
> In the next patch (assuming diff isn't leading me astray) we have
>
> @@ -600,13 +687,17 @@ static int adxl313_write_mag_value(struct adxl313_d=
ata *data,
>                                    enum iio_event_direction dir,
>                                    enum iio_event_info info,
>                                    enum adxl313_activity_type type_act,
> +                                  enum adxl313_activity_type type_inact,
>                                    int val, int val2)
>  {
>         switch (info) {
>         case IIO_EV_INFO_VALUE:
>                 return _adxl313_write_mag_value(data, dir,
>                                                 type_act,
> +                                               type_inact,
>                                                 val, val2);
> +       case IIO_EV_INFO_PERIOD:
> +               return adxl313_set_inact_time_s(data, val);
>         default:
>                 return -EINVAL;
>         }
>
>
> Which is adding PERIOD to something called write_mag_value()
>
> Whilst I can see why you ended up with naming as:
>
> adxl313_write_mag_value() as the magnitude event specific part of
> adxl13_event_write_value()
>
> and indeed
>
> _adxl313_write_mag_value() as the thing that writes IIO_EV_INFO_VALUE
> value (i.e. the threshold) for the magnitude events.
>
> Last time I hit a similar naming stack, I spinkled in some _info
>
> So have the inner one called something slightly more specific like
>
> adxl313_write_mag_info_value()
>
>
> > +                                enum iio_event_direction dir,
> > +                                enum iio_event_info info,
> > +                                enum adxl313_activity_type type_act,
> > +                                int val, int val2)
> > +{
> > +     switch (info) {
> > +     case IIO_EV_INFO_VALUE:
> > +             return _adxl313_write_mag_value(data, dir,
> > +                                             type_act,
> > +                                             val, val2);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int adxl313_read_event_value(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info,
> > +                                 int *val, int *val2)
> > +{
> > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > +
> > +     switch (type) {
> > +     case IIO_EV_TYPE_MAG:
> > +             return adxl313_read_mag_value(data, dir, info,
> > +                                           ADXL313_ACTIVITY,
> > +                                           val, val2);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int adxl313_write_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int val, int val2)
> > +{
> > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > +
> > +     switch (type) {
> > +     case IIO_EV_TYPE_MAG:
> > +             return adxl313_write_mag_value(data, dir, info,
> > +                                            ADXL313_ACTIVITY,
> > +                                            val, val2);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
>
> Otherwise LGTM
>

Hi, I'm about to wrap this up for the final version (let's see...).

I understand that three levels of switch/case are not good. Instead
here I did a particular function/helper per switch/case level.
Finally, I ended up with, e.g.

adxl313_write_event_value()  // calls
  \-> adxl313_write_mag_value()  // calls
         \-> _adxl313_write_mag_value()

Personally, I think, why not just having the following calls hierarchy:

adxl313_write_event_value()  // calls
  \-> adxl313_write_mag_value()

First question: Regarding the adxl345 driver, with a little higher
level of complexity, I adopted such a solution keeping still 2 levels
of switch case inside the helper. Would this be ok for the ADXL313,
too? I mean, having just one helper, but that one containing one level
of nested switch case inside a switch/case?


Another question about the naming of the helper. As you saw, I went
"creative" and used the commonly used name for such functions
replacing "_event_" by "_mag_". I see this can be confusing, but also
it might make clear where the (only locally used) helper belongs to.

I understand names with leading '_' are not likely to be a decent
choice here. But in general in case of adxl313_write_mag_value() -like
names. What would be a better name for it, or would it be ok?

By the answers given to the above, and if you don't object I would
like to prepare the single level of helper approach (then having one
nested switch/case) and keep just the adxl313_*_mag_value() or
..._config() functions. Let me know what you think.

> Jonathan

