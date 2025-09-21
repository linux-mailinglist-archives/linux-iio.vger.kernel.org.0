Return-Path: <linux-iio+bounces-24330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA291B8D8D2
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 11:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4690A441477
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33241253F39;
	Sun, 21 Sep 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9dkzqTt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB3189
	for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448106; cv=none; b=NODcXP0+1NHZXPukmM8Tk0ybz0Nc+zt44eKnibTni1juZMvaFtcGAesh7p1Vr8CiFlgVGyjmtsbkfALXEeCs98mvf7mza6iU1YNFQBXNPabBKl7sPGMLaLaWnNPIPijQRUspIOflpOkGkyZiM/LAk2gmrmqZFZyzrxtAjj/yXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448106; c=relaxed/simple;
	bh=3Xp5rimRDl92A6tE3YHw3ySK0v8J6JaN8mnKUs28wYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGfzRc/912mw1kyel/x8WzJg9bk5XNFvsrLqzGKipqMJa3Fv1eGfjbJaf/2BsMARZYkyJnq3opkS0TmGH9JESk2hWvoM+CX4Kr60xqcACDs8jNvQkN96dbYfktG7JjxfPJ+EZeggHNX67p87TPKGeD+DrjMKgeKRqgk+VNRobOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9dkzqTt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3515a0bca13so45721761fa.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758448101; x=1759052901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wodcIgNbF/CozomEA0c/cSEsbbQcOGd021hVupozsU8=;
        b=Z9dkzqTtldxvuKb7ceU+23Fu52kxGDgBs0fwzgyOVwhe6mIuIbZHMa9dLhwPzf5Hgx
         cBLHm++Tfc5Pv3dJdjL3GSeYxpYYYv8C2YepwwEaGiG63LRJOacUU9oKc9kvTt5+mKV0
         mXdBFgsQxJsNGtDIZb50NXPV8J5jE4ERYG3EQ2rauqcI9p2lSomm47gIfb+euaM05yV6
         tObh56KqspyME5ES+co3/lO0I3yhT5KKf6DPSXGZ0lfg+vDl1SMtwaM5EulCKQ0ZkVtn
         BK1BAdPA/9JM6I7R1FFVhH2e/keaQpNLIXROGAwnj9kSvuMoABNVSL8Dd0fZ8nn7AFOr
         2gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758448101; x=1759052901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wodcIgNbF/CozomEA0c/cSEsbbQcOGd021hVupozsU8=;
        b=GCPKdvQPwZUy+c0BeRLTrhcnB7hC5jEz2N7+iprqbD4m304vHltv/40eGvWK5rxS/j
         jwN3eVZlM+srIqk/8ZiuHUShqHW1bzn/H0Cx7QWLiCEZsIHHj+DcPtcccA0ZLBxPBc0d
         FFjSMa7EJ8HxzvXC8Rfg3AEaIX57L/9BhVUg/CuCEFCme5KLnDZoXzf/K7RX2nkMUkHE
         E2ueDicdlBqtYnm3sPkNYJI8Roz8L98tBTXT6NOf14abkkRmJgBHOKZpTVcboqyqzV9n
         7Fr3RpkywbncPdQq2umdNOeokNhMLb38g06eHvwzeRMiiX67AQEPbjFxiagA6Cbez1ll
         S/ng==
X-Forwarded-Encrypted: i=1; AJvYcCUHz8kHGmZdpxw5zhhY3FejWNABTj6PaqNLUKyP1FBKCrnlpXxdmHO3XH5dUsXaE5TFSznnfV823m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzIhDJgAwhi3Gt3dm099HgH4pwzJOsI9oMK0+f84Y2FeIOBoLj
	waVn/8g03g1LoBx0dKAcxg69Ijpp0aL7+HtuSM0qLt7YVEsacYmJDksWarFn0+lLfBDWdT3NYfR
	NWe7YNqYttaLO5cARMPdrw1cI8SYjE/FZRA==
X-Gm-Gg: ASbGncuWojps0XA/V6WfYQxeGcDdJi6bZzZm/5/sa0NiQt/+lMsYokWa7psetYMkbdU
	Wg7g3e06jpqsbUPw6VMYuGqiBmqv0DCu0F7sUeqD2ZohFqr7prtiQsxFyaKOVCWBeh4Ru9hxv0n
	fLnB66zPjRUZ1p0tZ3+diRXANbKU1EAAnpjI2q1eL0LXZCFPBTThpnte0zYsTy7kQFTWPbwq/z7
	dQ+Hic=
X-Google-Smtp-Source: AGHT+IELiTF7nvBwPVcb8OTPJcd3g9xZRIjW6RnFXdey7MHIswMqgMH5SRSzkS8y6AyvbIgl9a6JpgL9HSWds5p3otc=
X-Received: by 2002:a05:651c:23d3:10b0:336:e22d:804a with SMTP id
 38308e7fff4ca-3640b9568cdmr24486581fa.17.1758448101079; Sun, 21 Sep 2025
 02:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918190729.387117-1-akshayaj.lkd@gmail.com> <fe32537d44cbb187e1518740f33e3a6716dd363a.camel@gmail.com>
In-Reply-To: <fe32537d44cbb187e1518740f33e3a6716dd363a.camel@gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sun, 21 Sep 2025 15:18:09 +0530
X-Gm-Features: AS18NWCOXe6o_Ql7bTL6ftgKTumSZmhwaEsTy3nG_6BKoiFchqeKG778ztLixEM
Message-ID: <CAE3SzaReUnhWyzA8RtdizKeRU2zMsGbvQaVT-ug6v+=Pqq8WzA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Refactor generic interrupt configuration
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: dan@dlrobertson.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nuno,
Thank you so much for your review. Please find follow-ups inline.

On Fri, Sep 19, 2025 at 5:34=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> Hi,
>
> Thanks for your patch.
>
> On Fri, 2025-09-19 at 00:37 +0530, Akshay Jindal wrote:
> > Refactor the generic interrupt configuration logic to improve readabili=
ty
> > and reduce repetitive code. Replace hard-coded register values with mac=
ros
> > and enums, making it clearer what configuration is written to hardware.
> >
> > Introduce a const struct to map event direction to the corresponding
> > generic interrupt. This removes the need for switch statements in multi=
ple
> > callbacks, including activity event setup, read_event_value, and
> > write_event_value, while still performing the selection at runtime.
> >
> > This change has no functional impact but simplifies the code and makes =
it
> > easier to maintain and extend in future updates.
> >
> > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> > ---
>
> You may be trying to refactor too much in one single patch. I would maybe=
 think
> about splitting this into 2/3 logical changes.
>
> >  drivers/iio/accel/bma400.h      |  71 +++++++++++++++---
> >  drivers/iio/accel/bma400_core.c | 128 ++++++++++++++++----------------
> >  2 files changed, 125 insertions(+), 74 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index 932358b45f17..ab7d1d139b66 100644
> > --- a/drivers/iio/accel/bma400.h
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -68,7 +68,19 @@
> >  #define BMA400_CMD_REG              0x7e
> >
> >  /* Interrupt registers */
> > -#define BMA400_INT_CONFIG0_REG           0x1f
> > +#define BMA400_INT_CONFIG0_REG                       0x1f
> > +#define BMA400_INT_CONFIG0_ORTN_CHG_MASK     BIT(1)
> > +#define BMA400_INT_CONFIG0_GEN1_MASK         BIT(2)
> > +#define BMA400_INT_CONFIG0_GEN2_MASK         BIT(3)
> > +#define BMA400_INT_CONFIG0_FIFO_FULL_MASK    BIT(5)
> > +#define BMA400_INT_CONFIG0_FIFO_WTRMRK_MASK  BIT(6)
> > +#define BMA400_INT_CONFIG0_DRDY_MASK         BIT(7)
> > +
> > +enum generic_intr {
> > +     GEN1_INTR,
> > +     GEN2_INTR
> > +};
> > +
> >  #define BMA400_INT_CONFIG1_REG           0x20
> >  #define BMA400_INT1_MAP_REG      0x21
> >  #define BMA400_INT_IO_CTRL_REG           0x24
> > @@ -96,15 +108,53 @@
> >  #define BMA400_ACC_ODR_MIN_HZ       12
> >
> >  /* Generic interrupts register */
> > -#define BMA400_GEN1INT_CONFIG0      0x3f
> > -#define BMA400_GEN2INT_CONFIG0      0x4A
> > -#define BMA400_GEN_CONFIG1_OFF      0x01
> > -#define BMA400_GEN_CONFIG2_OFF      0x02
> > -#define BMA400_GEN_CONFIG3_OFF      0x03
> > -#define BMA400_GEN_CONFIG31_OFF     0x04
> > -#define BMA400_INT_GEN1_MSK         BIT(2)
> > -#define BMA400_INT_GEN2_MSK         BIT(3)
> > -#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> > +#define BMA400_GENINT_CONFIG_REG_BASE        0x3f
> > +#define BMA400_NUM_GENINT_CONFIG_REGS        11
> > +#define BMA400_GENINT_CONFIG_REG(gen_intr, config_idx)       \
> > +     (BMA400_GENINT_CONFIG_REG_BASE +                \
> > +     (gen_intr) * BMA400_NUM_GENINT_CONFIG_REGS +    \
> > +     (config_idx))
>
> Not sure the above macro helps that much. More on this below...
In my last patch regarding ltr390, I was given feedback towards
reducing the number of macro definitions. This may look little cryptic,
but it enables me to access GEN1(11) + GEN2 (11) registers with only
2 definitions. I see it as a reasonable tradeoff between readability and
code volume.

> >  static bool bma400_is_writable_reg(struct device *dev, unsigned int re=
g)
> >  {
> >       switch (reg) {
> > @@ -1114,10 +1137,10 @@ static int bma400_read_event_config(struct iio_=
dev
> > *indio_dev,
> >       case IIO_ACCEL:
> >               switch (dir) {
> >               case IIO_EV_DIR_RISING:
> > -                     return FIELD_GET(BMA400_INT_GEN1_MSK,
> > +                     return FIELD_GET(BMA400_INT_CONFIG0_GEN1_MASK,
> >                                        data->generic_event_en);
>
> Like the above is above renaming defines in a more logical name. Not goin=
g to
> opinate whether this name is better or not but you could put that (and ot=
her
> similar changes) in one patch.

Initially, I thought of doing this, but if you look at the diff in bma400.h=
,
only GEN1_MASK and GEN2_MASK have been renamed and re-placed closer
to their register definition macro. Rest all of them are either new
introductions
or have gone for good. Hence I felt it might be an overkill to create
a new patch
just for 2 reg bit renaming. At the same time, I feel new
introductions should be
clubbed with their usage. Ofcourse, all of them are not being used, but eve=
n if
the code is using 1 bit of a reg, then all of its fields should be defined.
Due to the above logic, I kept it in a single patch. Although happy to chan=
ge if
you still feel otherwise.

>
> >               case IIO_EV_DIR_FALLING:
> > -                     return FIELD_GET(BMA400_INT_GEN2_MSK,
> > +                     return FIELD_GET(BMA400_INT_CONFIG0_GEN2_MASK,
> >                                        data->generic_event_en);
> >               case IIO_EV_DIR_SINGLETAP:
> >                       return FIELD_GET(BMA400_S_TAP_MSK,
> > @@ -1159,59 +1182,50 @@ static int bma400_activity_event_en(struct bma4=
00_data
> > *data,
> >                                   enum iio_event_direction dir,
> >                                   int state)
> >  {
> > -     int ret, reg, msk, value;
> > -     int field_value =3D 0;
> > -
> > -     switch (dir) {
> > -     case IIO_EV_DIR_RISING:
> > -             reg =3D BMA400_GEN1INT_CONFIG0;
> > -             msk =3D BMA400_INT_GEN1_MSK;
> > -             value =3D 2;
> > -             set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
> > -                           FIELD_PREP(BMA400_INT_GEN1_MSK, state));
> > -             break;
> > -     case IIO_EV_DIR_FALLING:
> > -             reg =3D BMA400_GEN2INT_CONFIG0;
> > -             msk =3D BMA400_INT_GEN2_MSK;
> > -             value =3D 0;
> > -             set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
> > -                           FIELD_PREP(BMA400_INT_GEN2_MSK, state));
> > -             break;
> > -     default:
> > -             return -EINVAL;
> > -     }
> > +     int ret, regval;
> > +     u8 genintr =3D bma400_genintrs[dir].genintr;
> > +     u8 detect_criterion =3D bma400_genintrs[dir].detect_mode;
> > +     unsigned int intrmask =3D bma400_genintrs[dir].intrmask;
> >
>
> Hmm, you should still have the switch case. Again, not sure the const str=
uct
> adds that much but I'm also fine with it. But I would do:
>
> switch (dir) {
> case IIO_EV_DIR_RISING:
> case IIO_EV_DIR_FALLING:
>         genintr =3D bma400_genintrs[dir].genintr;
>         detect_criterion =3D bma400_genintrs[dir].detect_mode;
>         intrmask =3D bma400_genintrs[dir].intrmask;
> default:
>         return -EINVAL;
>
Thank you for detailing it out. Yes this gives the best of both worlds.
Uses the centralized lookup struct as well as makes sure dir is sanitized.
Will wrap it up in a function and apply in the v2.

Thanks,
Akshay.

