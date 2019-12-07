Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5515115C41
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 13:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLGMrX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 07:47:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47825 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbfLGMrW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Dec 2019 07:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575722840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBvyIcHAnGjy/2QtjaV5U7/bDvZIZCOB7/IQNIOy9qU=;
        b=fyw5F1t+8YqXrabj2+Cu/AayxhgOuEUMd5+MjEmRShO3EKNJYAz1pCXaDVe1WcFU/J0Hbd
        DHv+yN3ACKbsiPhc+GKPDQwhv97JPsq1WcQ9WWeJRlZ7Q2fhDJ3wGdDzt8aqk4WJ+5Atay
        F6YlSaLoGSD6CZM4DETClODV9atU93s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-P47FfugPPZ-_bgwDe1UWow-1; Sat, 07 Dec 2019 07:47:19 -0500
Received: by mail-io1-f70.google.com with SMTP id p5so6872998iob.23
        for <linux-iio@vger.kernel.org>; Sat, 07 Dec 2019 04:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/X0EWaLMy1+4rqn9rDUZTuxbtgnd193KN5JXmEayvWs=;
        b=jGWhoV/ObiLbsOJl8AjTaOrGdCnihYm88pLOU1Exbigq2yCB/zGjLGOeJB4EOyQMA3
         onTfnhbmU51Kl3y41OjehGbRNhcoFLy01LxxZZYOg029HKgHirJL68v1MAIbb8x9C/6y
         Qks5ITLXce4PZ4WQl5a9gs8b834C5ZK7n3vKN6ZIb0kmEwxS/h52DIVL4/8wzRodRoPh
         wLJXaYcaRervl0X6kaJHr8PAGyHO2hdTrwA9uYwIZjIsfMnuXB9z22eJogL4xufYZsoq
         aEFXI8i9c4S7kD86wEk5UBrQsz4IlvcHsEo04XL+do0B0oDQQ+AYRwTnfUjyNKCO2Zrf
         AwSw==
X-Gm-Message-State: APjAAAVxmJlVYMu/T8KPJmAeAUXiULAl9iclKD22lWi4yeuPaXqpHfU4
        4kSiMUsUNab/ffwnPfxIoCuyass2FCyROvhvL6fritzOzC4PpnYHJhBTKGP+n3hjyGDwd+aoyCd
        JcSKAQDa6l5y6ApfzNSIadN+Wea0sVLtuTggZ
X-Received: by 2002:a02:2404:: with SMTP id f4mr18348452jaa.50.1575722838647;
        Sat, 07 Dec 2019 04:47:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqx06IBVsjp5k85J2tqFE1p4I9kZ18/aeKygj84okLKivR/5VcdaqKGUerZtHY1nl/HapqoVF0tVL8eswE9b9tQ=
X-Received: by 2002:a02:2404:: with SMTP id f4mr18348436jaa.50.1575722838324;
 Sat, 07 Dec 2019 04:47:18 -0800 (PST)
MIME-Version: 1.0
References: <0e49f52be057a14f0885dfaf496e8274c8107f60.1575282133.git.lorenzo@kernel.org>
 <20191207103927.035eda2a@archlinux>
In-Reply-To: <20191207103927.035eda2a@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 7 Dec 2019 14:47:07 +0200
Message-ID: <CAJ0CqmX-e0tC3x-Bfgb3i1qcQSHurt-g6uO7wkrDQ1T8B3DrOg@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: move register definitions to
 sensor structs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
X-MC-Unique: P47FfugPPZ-_bgwDe1UWow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Mon,  2 Dec 2019 12:23:28 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Move some register definitions to hts221_avg_list, hts221_avg_list and
> > hts221_channels since they are used only there and simplify driver code
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> You could potentially switch this to GENMASK for the masks, but that can
> be a follow up patch if you want to do so.

Hi Jonathan,

ack, fine. I will post a patch.

Regards,
Lorenzo

>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/humidity/hts221_core.c | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/=
hts221_core.c
> > index 4922444771c6..9003671f14fb 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -24,13 +24,6 @@
> >  #define HTS221_REG_CNTRL1_ADDR               0x20
> >  #define HTS221_REG_CNTRL2_ADDR               0x21
> >
> > -#define HTS221_REG_AVG_ADDR          0x10
> > -#define HTS221_REG_H_OUT_L           0x28
> > -#define HTS221_REG_T_OUT_L           0x2a
> > -
> > -#define HTS221_HUMIDITY_AVG_MASK     0x07
> > -#define HTS221_TEMP_AVG_MASK         0x38
> > -
> >  #define HTS221_ODR_MASK                      0x03
> >  #define HTS221_BDU_MASK                      BIT(2)
> >  #define HTS221_ENABLE_MASK           BIT(7)
> > @@ -66,8 +59,8 @@ static const struct hts221_odr hts221_odr_table[] =3D=
 {
> >
> >  static const struct hts221_avg hts221_avg_list[] =3D {
> >       {
> > -             .addr =3D HTS221_REG_AVG_ADDR,
> > -             .mask =3D HTS221_HUMIDITY_AVG_MASK,
> > +             .addr =3D 0x10,
> > +             .mask =3D 0x07,
> >               .avg_avl =3D {
> >                       4, /* 0.4 %RH */
> >                       8, /* 0.3 %RH */
> > @@ -80,8 +73,8 @@ static const struct hts221_avg hts221_avg_list[] =3D =
{
> >               },
> >       },
> >       {
> > -             .addr =3D HTS221_REG_AVG_ADDR,
> > -             .mask =3D HTS221_TEMP_AVG_MASK,
> > +             .addr =3D 0x10,
> > +             .mask =3D 0x38,
> >               .avg_avl =3D {
> >                       2, /* 0.08 degC */
> >                       4, /* 0.05 degC */
> > @@ -98,7 +91,7 @@ static const struct hts221_avg hts221_avg_list[] =3D =
{
> >  static const struct iio_chan_spec hts221_channels[] =3D {
> >       {
> >               .type =3D IIO_HUMIDITYRELATIVE,
> > -             .address =3D HTS221_REG_H_OUT_L,
> > +             .address =3D 0x28,
> >               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> >                                     BIT(IIO_CHAN_INFO_OFFSET) |
> >                                     BIT(IIO_CHAN_INFO_SCALE) |
> > @@ -114,7 +107,7 @@ static const struct iio_chan_spec hts221_channels[]=
 =3D {
> >       },
> >       {
> >               .type =3D IIO_TEMP,
> > -             .address =3D HTS221_REG_T_OUT_L,
> > +             .address =3D 0x2a,
> >               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> >                                     BIT(IIO_CHAN_INFO_OFFSET) |
> >                                     BIT(IIO_CHAN_INFO_SCALE) |
>

