Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7924767E8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 03:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhLPCZ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 21:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhLPCZ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 21:25:56 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70027C061574;
        Wed, 15 Dec 2021 18:25:56 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v203so60485694ybe.6;
        Wed, 15 Dec 2021 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bbbiGuKMoQF+c/eQBHahQYSMBkkuf99zfiE+nnf5DBM=;
        b=gqChIAC2vhx4Gq7PmfcPnI4hQyggxJ/GQ3Hr2Y9k/v4tOcyfv0Ybd0ilmzYF/R/cv/
         Y61rCKEYiyn47MHUXzkJD4RfZOkWKlOyILA7moal+R86kh1avm8p/xU7t58uScNiJXZA
         IAS1dhHEp2A0YWKhvFrs5KDh9Lt+14YRezC27QLlBE/OE2FSOJkUAd1t1Bro9yO98E1i
         kwidbz5jIyBSmGu8BDdUfVFZ4OTanIg+SqsZtSRi/rs4P72xM03+lu/VEVvJNiYOJ3kZ
         1HHc/kX+1QI7vZJPrvG3/CcmIG13BqHd409LWQy9HReEUlyhlqIuYSnIhoEhYCGMhx5o
         pJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bbbiGuKMoQF+c/eQBHahQYSMBkkuf99zfiE+nnf5DBM=;
        b=TUbzr8eNMPqGxlVZnSbgD0fN+nh6O/m5Qr5PChfWaXWGSX6qfDImW/ar6gTyIE+dme
         POTdo7cmn6NZ1ZIQOL9/gb5Q796Z5MzQKqq+g/2ZMoSiHIoUu6MC501qdW1oh1KYUXXQ
         aGYZncLiw/8SthC65yAYCCcpLwGgNw8kNpsLxAQORjbcyu6ICUJvLIn2uBz5V3uh2jy+
         xVkdhoqe93bJIpNRyu08v1UHMQawH/ISBErljABDNfzHOCv1QGHcYF08fLLhKZvUyGHA
         8dI1DS+SsGilBipIalcbcsHhxV/KrIK2GZ+hyqwz+AMX8+Jha8Jgwz42tKPPQumzR8gy
         eAlQ==
X-Gm-Message-State: AOAM5338rUEo6k96SLXk9SAJ+51sxVIdh4Xijtlrw+Rkufl3KnBpGxJQ
        yOS/uI8iPPQ8gkfREtITIowM0z5xpj7kcRLNN64=
X-Google-Smtp-Source: ABdhPJxZQbzsSw+cnW4IXlby0+XmnLrwXcEgPjY79c4pj270yPgkxGJYKW5covLdygtTouCz4PODmyVD39QV2dCBeAc=
X-Received: by 2002:a05:6902:154b:: with SMTP id r11mr11702124ybu.298.1639621555602;
 Wed, 15 Dec 2021 18:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20211211115315.2255384-1-siyanteng@loongson.cn> <Ybmk0s47ZqpXV2xy@shinobu>
In-Reply-To: <Ybmk0s47ZqpXV2xy@shinobu>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Thu, 16 Dec 2021 10:25:44 +0800
Message-ID: <CAEensMwHXo-1Fy8VgDE05qSOLEbuRLfLaKN15y=ce+f_SFyYqw@mail.gmail.com>
Subject: Re: [PATCH v2] counter: Add the necessary colons and indents to the
 comments of counter_compi
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-iio@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

William Breathitt Gray <vilhelm.gray@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=
=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 16:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Dec 11, 2021 at 07:53:15PM +0800, Yanteng Si wrote:
> > From: Yanteng Si <siyanteng01@gmail.com>
> >
> > Since aaec1a0f76ec ("counter: Internalize sysfs interface code") introd=
uce a warning as:
> >
> > linux-next/Documentation/driver-api/generic-counter:234: ./include/linu=
x/counter.h:43: WARNING: Unexpected indentation.
> > linux-next/Documentation/driver-api/generic-counter:234: ./include/linu=
x/counter.h:45: WARNING: Block quote ends without a blank line; unexpected =
unindent.
> >
> > Add the necessary colons and indents.
> >
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>
> Hi Yanteng,
>
> Thank you for resubmitting this patch with a reference to the commit
> that introduced the bug. I'll pick this patch up and submit it later
> with the rest of the Counter changes for this cycle.
>
> For future patches, please add information about which commit a patch
> fixes by using the Fixes tag. For example, this patch would have the
> following Fixes tag above your Signed-off-by tag.
>
> Fixes: aaec1a0f76ec ("counter: Internalize sysfs interface code")
>
> I'll add that Fixes tag for you as I pick this up so you won't need to
> resubmit this patch again. :-)
OK!  Thanks!  >_<

Thanks
Yanteng
>
> Thanks,
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
