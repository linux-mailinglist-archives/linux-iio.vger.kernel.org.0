Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B74713AF
	for <lists+linux-iio@lfdr.de>; Sat, 11 Dec 2021 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhLKLrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Dec 2021 06:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhLKLrc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Dec 2021 06:47:32 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20006C061714;
        Sat, 11 Dec 2021 03:47:31 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso12313500ots.6;
        Sat, 11 Dec 2021 03:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=APfD8Msjv3cMWaQnrRrUKoea/0+QubyTXryAN3vU0ak=;
        b=czAWQoXKuzbPPfDi1zNnw4ksQJs1njgWxQthEivZT+HQy3lqWDSuT06cG0dBZxx2sQ
         sHnkXYohkYQNeHso3M/ZDMTIrNt9tYMgoSbihMKTfYLzCVP54RtyMf+lndSAN2CcCwl6
         yg5y2ZdYQgBlb0Ux9mNBf567hqooInlqIyjNBtr2RlJLGXFOyiOK/IF7zmGdvc98JK3b
         opx2FFfLiiRAWHgrThvAoOu34evhebmmYNZae1Ik3kJOeMGMQvKXensWT+QYcxT3VLc6
         gg7SrwVDPJekTnRlOKz/qH6B/HLcxI97inoIo375qK4+15OrbEGAo7BMQUOACc2c43mp
         SOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=APfD8Msjv3cMWaQnrRrUKoea/0+QubyTXryAN3vU0ak=;
        b=290hbvAPexzNQQ/92ZP6lZ5dMbWEx/Ryjmx9EnkwFw+w9IavNrlDOu9yZ2E3DAwL0c
         BnMD99Oi+LQQXLlJhEyrtGadoszaqcOd9iIMlTpOzmmqc7b90nyPhmQ7kE5ZWdAlpGSd
         pismEtYBmwkLjCpj3WtClfZNzVTEf4X09s9+r6GvHPH3uu3G3BZMcvF0XIBAwrdI0aoA
         mYzqxpIHUU2Q8Yp4e9zQ3+ETD5/ulrntg1kDMkOkCOTVGJ2VSEH9Rzy1fTaotoWl5nxk
         hcy/2z4fNZlIxji0X0tbh9vYWnCR0lYNTBeDdFBcIHiJPJdsdjHFZTl/w9IJZwIot0FW
         KrEA==
X-Gm-Message-State: AOAM533tnb5lACvM8t3B9ZMm6hCMfRK8Q2Y0sQ2pGB6uc3NgR5YR1EnG
        jX7oEksMQs96UldvK2SydC27dNpnITcsuAxkDtw=
X-Google-Smtp-Source: ABdhPJwdNZmaUPePaNxSNzPw2XLnrNKvf2km55I+dvW+8bk3pCLIwm+gTSDTTbRjdF4llbftsto+CQuw72J6sRTuxTs=
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr16185737otr.46.1639223251076;
 Sat, 11 Dec 2021 03:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20211205130816.4121898-1-siyanteng@loongson.cn> <YbPUcMljr3LUmeMB@shinobu>
In-Reply-To: <YbPUcMljr3LUmeMB@shinobu>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Sat, 11 Dec 2021 19:47:19 +0800
Message-ID: <CAEensMziDL+MLc55+yLTZPKz-GL53h45-MYzqb3Fd=JfKQNZLQ@mail.gmail.com>
Subject: Re: [PATCH] counter: Add the necessary colons and indents to the
 comments of counter_compi
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-iio@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

William Breathitt Gray <vilhelm.gray@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=
=9C=8811=E6=97=A5=E5=91=A8=E5=85=AD 06:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Dec 05, 2021 at 09:08:16PM +0800, Yanteng Si wrote:
> > Fix warning as:
> >
> > linux-next/Documentation/driver-api/generic-counter:234: ./include/linu=
x/counter.h:43: WARNING: Unexpected indentation.
> > linux-next/Documentation/driver-api/generic-counter:234: ./include/linu=
x/counter.h:45: WARNING: Block quote ends without a blank line; unexpected =
unindent.
> >
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>
> Hello Yanteng,
>
> Thank you for the patch. Is this fixing commit aaec1a0f76ec ("counter:
> Internalize sysfs interface code")?
Yeah, I will add a it in patch v2.

Thank you very much!

Thanks,
Yanteng
>
> William Breathitt Gray
>
> > ---
> >  include/linux/counter.h | 40 ++++++++++++++++++++--------------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/counter.h b/include/linux/counter.h
> > index b7d0a00a61cf..dfbde2808998 100644
> > --- a/include/linux/counter.h
> > +++ b/include/linux/counter.h
> > @@ -38,64 +38,64 @@ enum counter_comp_type {
> >   * @type:            Counter component data type
> >   * @name:            device-specific component name
> >   * @priv:            component-relevant data
> > - * @action_read              Synapse action mode read callback. The re=
ad value of the
> > + * @action_read:             Synapse action mode read callback. The re=
ad value of the
> >   *                   respective Synapse action mode should be passed b=
ack via
> >   *                   the action parameter.
> > - * @device_u8_read   Device u8 component read callback. The read value=
 of the
> > + * @device_u8_read:          Device u8 component read callback. The re=
ad value of the
> >   *                   respective Device u8 component should be passed b=
ack via
> >   *                   the val parameter.
> > - * @count_u8_read    Count u8 component read callback. The read value =
of the
> > + * @count_u8_read:           Count u8 component read callback. The rea=
d value of the
> >   *                   respective Count u8 component should be passed ba=
ck via
> >   *                   the val parameter.
> > - * @signal_u8_read   Signal u8 component read callback. The read value=
 of the
> > + * @signal_u8_read:          Signal u8 component read callback. The re=
ad value of the
> >   *                   respective Signal u8 component should be passed b=
ack via
> >   *                   the val parameter.
> > - * @device_u32_read  Device u32 component read callback. The read valu=
e of
> > + * @device_u32_read:         Device u32 component read callback. The r=
ead value of
> >   *                   the respective Device u32 component should be pas=
sed
> >   *                   back via the val parameter.
> > - * @count_u32_read   Count u32 component read callback. The read value=
 of the
> > + * @count_u32_read:          Count u32 component read callback. The re=
ad value of the
> >   *                   respective Count u32 component should be passed b=
ack via
> >   *                   the val parameter.
> > - * @signal_u32_read  Signal u32 component read callback. The read valu=
e of
> > + * @signal_u32_read:         Signal u32 component read callback. The r=
ead value of
> >   *                   the respective Signal u32 component should be pas=
sed
> >   *                   back via the val parameter.
> > - * @device_u64_read  Device u64 component read callback. The read valu=
e of
> > + * @device_u64_read:         Device u64 component read callback. The r=
ead value of
> >   *                   the respective Device u64 component should be pas=
sed
> >   *                   back via the val parameter.
> > - * @count_u64_read   Count u64 component read callback. The read value=
 of the
> > + * @count_u64_read:          Count u64 component read callback. The re=
ad value of the
> >   *                   respective Count u64 component should be passed b=
ack via
> >   *                   the val parameter.
> > - * @signal_u64_read  Signal u64 component read callback. The read valu=
e of
> > + * @signal_u64_read:         Signal u64 component read callback. The r=
ead value of
> >   *                   the respective Signal u64 component should be pas=
sed
> >   *                   back via the val parameter.
> > - * @action_write     Synapse action mode write callback. The write val=
ue of
> > + * @action_write:            Synapse action mode write callback. The w=
rite value of
> >   *                   the respective Synapse action mode is passed via =
the
> >   *                   action parameter.
> > - * @device_u8_write  Device u8 component write callback. The write val=
ue of
> > + * @device_u8_write:         Device u8 component write callback. The w=
rite value of
> >   *                   the respective Device u8 component is passed via =
the val
> >   *                   parameter.
> > - * @count_u8_write   Count u8 component write callback. The write valu=
e of
> > + * @count_u8_write:          Count u8 component write callback. The wr=
ite value of
> >   *                   the respective Count u8 component is passed via t=
he val
> >   *                   parameter.
> > - * @signal_u8_write  Signal u8 component write callback. The write val=
ue of
> > + * @signal_u8_write:         Signal u8 component write callback. The w=
rite value of
> >   *                   the respective Signal u8 component is passed via =
the val
> >   *                   parameter.
> > - * @device_u32_write Device u32 component write callback. The write va=
lue of
> > + * @device_u32_write:                Device u32 component write callba=
ck. The write value of
> >   *                   the respective Device u32 component is passed via=
 the
> >   *                   val parameter.
> > - * @count_u32_write  Count u32 component write callback. The write val=
ue of
> > + * @count_u32_write:         Count u32 component write callback. The w=
rite value of
> >   *                   the respective Count u32 component is passed via =
the val
> >   *                   parameter.
> > - * @signal_u32_write Signal u32 component write callback. The write va=
lue of
> > + * @signal_u32_write:                Signal u32 component write callba=
ck. The write value of
> >   *                   the respective Signal u32 component is passed via=
 the
> >   *                   val parameter.
> > - * @device_u64_write Device u64 component write callback. The write va=
lue of
> > + * @device_u64_write:                Device u64 component write callba=
ck. The write value of
> >   *                   the respective Device u64 component is passed via=
 the
> >   *                   val parameter.
> > - * @count_u64_write  Count u64 component write callback. The write val=
ue of
> > + * @count_u64_write:         Count u64 component write callback. The w=
rite value of
> >   *                   the respective Count u64 component is passed via =
the val
> >   *                   parameter.
> > - * @signal_u64_write Signal u64 component write callback. The write va=
lue of
> > + * @signal_u64_write:                Signal u64 component write callba=
ck. The write value of
> >   *                   the respective Signal u64 component is passed via=
 the
> >   *                   val parameter.
> >   */
> > --
> > 2.27.0
> >
