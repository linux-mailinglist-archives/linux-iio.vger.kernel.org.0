Return-Path: <linux-iio+bounces-22112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC0DB14028
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9751621C6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C727816B;
	Mon, 28 Jul 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwnpWDNc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C727467F;
	Mon, 28 Jul 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719559; cv=none; b=eQTl00oO+c6MYOQ684j0/8Yn6ZJIc/5ENaK7jlfln9KRXdNDZPFouCypWgbGd6AKjakzs7gTOlf0sxIhml3oEDoUaDc65jK+x9q0CiFEFWs3SrafKXs1XkcdDzxctt7iJVuXQ1kKu9OU6vIOd/giEgsR7G67lTMQMk8hJ1O9FMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719559; c=relaxed/simple;
	bh=AvKzz79ddX6NuvBuNP+Qo+rxtzMdj1r0RJ/4rRyBC40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQg8xXGxOxRoB0Nch7CaGnUC/huSJojKwpf5ttwf4/apRSYWLiJgExlpbTZCnNyTHuqBZJZfs3pykoQtZ9khRBIgA4h0CBdfSiXpTS1OdUdXIJe1fcT78dkmnpOPP8aLJCGOkE8MfvTJdNKcRfVwRC3EKgxgXEp+M3h3WxGMmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwnpWDNc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso38623491fa.3;
        Mon, 28 Jul 2025 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753719556; x=1754324356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aeTD6f/9K4vfVzKLbumdmyL1/jsV1u1KGLIpuCc4gE=;
        b=kwnpWDNciFG2jfUTlJUxmicZJ4Zy/Lg2pdSD6iOiFplZLEFG02Te3wjxM9a1ZWeFJn
         G8o7fns38O6Spw0Y38KBA3dAwHvXN4wYgOU1hoZpj4OdOZZKcEOVMPckgF1vI+WQ6heI
         I4ugt+9xHqL9Om0ad0hSA0ub0UbLlh8kEwIwX1m3PP8WRslKanbybtDhf9oMAHXFeOF6
         fztQjT0LJv1eDaE+Y6aNtX9ehcfXJQ9YGmMVgxWE6TAGmQDuJrdrHgcdqcm4nqh8B2iI
         +eiBKrJfqsUireiXrYSlKDAR/7Sx8VYeee9Uy7K1ETVBv94Hx0VHrARU8FwnhrbZI3vi
         ySbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753719556; x=1754324356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aeTD6f/9K4vfVzKLbumdmyL1/jsV1u1KGLIpuCc4gE=;
        b=qqK81rFV6IdiLIutNl5xd/c9BkzifotTqL7i34fQdU3tqhQHZuxyQCevjYBQiAwGrZ
         RK+ltyPiOovGaJ3R6PZ7gkIPq3CINFx0mAM+W0jXuEFlKhyKkFikJtLL71X8NRhDYZaw
         VhCYFH6xo/tqJtGZG+cYiumf6QsiznV2ia42Lbc+1DiA9J+2Ot0+TYuwuBACzuFgXiqW
         9Gbb/fz0nBm4EFydb+eSSry9AdKSSY5YR0hQFeYbGK/XWIuEtr9QcbnajVLpjwTfiJTi
         eeva345LW21uFl16LY3V6D5weP9b7RzmdtUUjhRSgPrjrdSir4Ttxk72PTbNUBulCI4N
         344g==
X-Forwarded-Encrypted: i=1; AJvYcCV0OqiXLoEW7i/6/wJ4CROfdc3rFPIUqoPYtVFCHeFCtLOvdHX0P/1f+uq48TsUJU5+0u4fJLUb3zhyt5nk@vger.kernel.org, AJvYcCWQVYVcWHAOBNGkZeQHh7RA+TF8rKeSf//3KDQcvgyJCju9jWoVkl3eklZ5Ekddwa8Dj1/rZAjrOL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yjaZUwf5WP/gjOBYj0SHYCWLyejoEG0SYXVrpFt8P/VlT4Bq
	NFz8NGcuAu6yWaTxghubUKKTISCpZnYSj3CJaru4IIST3Csfin/i4RlCcQCzEeyU6gdQnBWiAQT
	P3oAKRcYWAVeqQVPzb+aJKxCYgbUPT+Y=
X-Gm-Gg: ASbGncuQ0yZFgBcxUK5GwI+dVxQuiTL/rkp/0mzG0WOEW40sMfCXbolsh9EldV9mz94
	t57v8RtZuDL4U7T3cF5+MmP3Hv9XzKpxiZAype6xnTvfM3Z+NW018I6Z4dqriYwmXzS/M2lt3yN
	xYjBLwnr+pogifjC8roSb4LfTWt3DSM85uWBG1mIxdyblgDBgaRkSb+FedpMJ7MxXk4P4o6RiVD
	ATEhOt73G6X9CLpivj4gl+ah1geWpTHBdz6FSjVBw==
X-Google-Smtp-Source: AGHT+IFTKCyAVJn11gn/xnuKwqwzld9DMsQpXO0r2O3eomWkFeiiuGXODxVKKED6iZphrXcjh/gM8jEjGxw9VUA6pe0=
X-Received: by 2002:a2e:be94:0:b0:32b:755e:6cc8 with SMTP id
 38308e7fff4ca-331ee78feebmr29383321fa.31.1753719555591; Mon, 28 Jul 2025
 09:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724143945.636380-1-akshayaj.lkd@gmail.com> <20250728145259.753b3999@jic23-huawei>
In-Reply-To: <20250728145259.753b3999@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 28 Jul 2025 21:49:03 +0530
X-Gm-Features: Ac12FXy6H-weD_HBnJhP1QjCAAhr6pW5pnyp64ZWq37KdAgF6d94rzZ_sQekslY
Message-ID: <CAE3SzaQwU47-qijxwex+5WFmRXjqodqPMZ45_5UU3z-7i_K5ng@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Add debugfs register access support
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 7:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 24 Jul 2025 20:09:39 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
>
> > Add support for debugfs_reg_access through the driver's iio_info struct=
ure
> > to enable low-level register read/write access for debugging.
> >
> > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
>
> >  drivers/iio/light/ltr390.c | 53 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> > index ee59bbb8aa09..b1028d027e1b 100644
> > --- a/drivers/iio/light/ltr390.c
> > +++ b/drivers/iio/light/ltr390.c
> > @@ -38,12 +38,21 @@
> >  #define LTR390_ALS_UVS_GAIN          0x05
> >  #define LTR390_PART_ID                       0x06
> >  #define LTR390_MAIN_STATUS           0x07
> > +
> >  #define LTR390_ALS_DATA                      0x0D
> > +#define LTR390_ALS_DATA_BYTE(n)              ((LTR390_ALS_DATA) + (n))
>                                                 (LTR390_ALS_DATA + (n))
>
> etc  There is no benefit in brackets around the bit that isn't a paramete=
r
> of the macro that I can see.

Fixed.
>
> > +
> >  #define LTR390_UVS_DATA                      0x10
> > +#define LTR390_UVS_DATA_BYTE(n)              ((LTR390_UVS_DATA) + (n))
> > +
> >  #define LTR390_INT_CFG                       0x19
> >  #define LTR390_INT_PST                       0x1A
> > +
> >  #define LTR390_THRESH_UP             0x21
> > +#define LTR390_THRESH_UP_BYTE(n)     ((LTR390_THRESH_UP) + (n))
> > +
> >  #define LTR390_THRESH_LOW            0x24
> > +#define LTR390_THRESH_LOW_BYTE(n)    ((LTR390_THRESH_LOW) + (n))
> >
> >  #define LTR390_PART_NUMBER_ID                0xb
> >  #define LTR390_ALS_UVS_GAIN_MASK     GENMASK(2, 0)
> > @@ -98,11 +107,40 @@ struct ltr390_data {
> >       int int_time_us;
> >  };
> >
> > +static const struct regmap_range ltr390_readable_reg_ranges[] =3D {
> > +     regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
> > +     regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_MAIN_STATUS),
> > +     regmap_reg_range(LTR390_ALS_DATA_BYTE(0), LTR390_ALS_DATA_BYTE(2)=
),
> > +     regmap_reg_range(LTR390_UVS_DATA_BYTE(0), LTR390_UVS_DATA_BYTE(2)=
),
>
> If we are doing maximum length ranges can we not combine the two above?
> Looks to be 0xd,0xe,0xf,0x10,0x11 and 0x012, so a continuous range simila=
r
> to the thresholds below.
>
Done the changes.
> > +     regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
> > +     regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE=
(2)),
> > +};
>
> Thanks,
>
> Jonathan
>
Thanks for the review. Floated a v4 with the changes.

Thanks,
Akshay

