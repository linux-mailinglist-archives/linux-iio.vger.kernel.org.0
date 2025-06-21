Return-Path: <linux-iio+bounces-20829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0AAAE2AFC
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F857175F18
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A690269AE9;
	Sat, 21 Jun 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/IxeUmN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E818B464;
	Sat, 21 Jun 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529247; cv=none; b=rBB7DlIjlciIxVv0jr7xsijo0+Oi5eW2Q+hx3lXG+nAfAQ/1859L2x0LaD7R7Vhe73XQHHmPbMQ0uwQSCEjfbG/v56ZxDHTBjR/FD5MfsS8fzPM6Dg1JrOWDUA9XGFOCbdUPKESKXcX1pZjVeBtmljdmxFQh4xQ71nIJVfimT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529247; c=relaxed/simple;
	bh=vj1ttaPOW9gPULSl6ptE6HmjBxelIsl9MwVWNPFo/pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBNY3yizFxbXMVNSporJNOwpKKXJa9RaGIiMFbaKng0EEQ0BXjxbrpAK03j42kJVMLCPK84gRl70ZDMAofmne3Idy+jt2G1+35rkYm5hirGj64HKbanXU99vNX4/IAHEokWJ/qLCMP1wu0et//jLcOMCNaaZso7zQyuRlIYU++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/IxeUmN; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8187df27f8so397734276.3;
        Sat, 21 Jun 2025 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750529245; x=1751134045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r5cq0xega02GRd00js5T35nyhJCJNHDO5vMWlXDnpfU=;
        b=F/IxeUmNSY72T+VBZd2NuLgkFfxtzZ1zDQpS2eCdDItWjjXmNw8qnRuK64sX4oHmYw
         3NwKRWDv6Ur6HC5m23VmevVyXLKKz+URlTELO765hVot/P5Xxcv5FY60msUxL6PRs/MV
         bQi6li3+7sfkdW46AAWSCoJl6VU8rtJCdD5o5e5hYh9iuiq2dbILvC7AE0ANbu8CLN2B
         hq/bqWBXm1tqgKYH5eApJlIvTtjYFm1nKUGdSU63gs2l2Nq760/OhsSSXT4VkwocaS/8
         TbWGIVUnxJKs84FRheCTPUNlQN+b9FCRnsmwEojDT4GyvKAhkH4cVBlVb4tAt0OlD0Iq
         nFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750529245; x=1751134045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5cq0xega02GRd00js5T35nyhJCJNHDO5vMWlXDnpfU=;
        b=iHYUxuKgSDS7UFMVSarqy6h0OTk8ESxMEWclLquXdJJ7wwnwdRndWhIxzN6ppwykM7
         VffEOkF3SOopmrMBABtqJXu2Nx8+oORCyG8alnsUFKA5SApLmDpnWDsKKL4Zlb8X0leX
         DeqaG9VcaGZikELJrLSStdNWPwZZj7IqHoV3n1lNHZEZLYM4qecPr0oZr5BkxuY4FFX6
         fQQsFYeN8BsRwZDlwmx3BKxv0egeaVoamiHfFNuZTBXDNcn1YenKlSDw9HoKwnEg3cx7
         JIGNf0c1A88zAJ3xjicTOed96MTnLIH/I3s/BMu/m6UndEX88EWddFdIMt7pRTOHn2dv
         Xz4g==
X-Forwarded-Encrypted: i=1; AJvYcCU7YA3p1om6wvehBYuO75ktMnIOxwd8nY3IlBL/yFWmH8+PfSyM01N1XsqdIDOzMEy1ydeFhiAHdFGcwLtC@vger.kernel.org, AJvYcCV4p1IYQM7rjDqd1XoAUb5A938tR6bP7WIw5RNyn9UXZt5tNmulHmjj2+hDbdQEuLPJQq1IB9mrPmE=@vger.kernel.org, AJvYcCWe/c7IrnjslYssvhP6smgsoRPGW1XwfxCbnLDHDfjdyGMsPYVLoBUQiVbUN0AeRCWSMmwu/vvScIzy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nuhCiN6umrq+PVv/ZFe46kpDTMDi/PBJL54ahLp1iFoJeIDG
	bJMGLUNMYCm1im2OY0gO4WCGd/ke1MrRKZzgVnfmrBecT0IYWaL0f28Rr11MwxNi2niOmCRRKbD
	uFWHQonfZU1arx/+BaGNL+VEUmkwQH5U=
X-Gm-Gg: ASbGncs+Be8QUMpOVhDzD6Jp7PaDQZPtRZIvJj2HoO4kVR9exCBt7g0YpMbdQF0ers5
	4w2Kj5OG+X5jyEXLGVsR77LeJP9rb1NYsIOZxyEbRQmKC5DTneJ84GeCLRaa22RADm+5Col2hXa
	O+v4cJJ87YD5wtnfmO+3SgkRYGc1qGbsKhUt3fcORkSnc=
X-Google-Smtp-Source: AGHT+IHNNRZC8v6KOJolb/hRsYMhvGI31oPIqwXOwHUeSNduVlWe/1BA5rv5K3f8QMMG9colY8S1KHr6er6ZLLG3QdY=
X-Received: by 2002:a05:690c:a0a8:10b0:712:c5f7:1ef9 with SMTP id
 00721157ae682-712c6767523mr34345407b3.8.1750529244942; Sat, 21 Jun 2025
 11:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-8-l.rubusch@gmail.com>
 <aEq_SJMDzPYGSMu6@smile.fi.intel.com>
In-Reply-To: <aEq_SJMDzPYGSMu6@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 21 Jun 2025 20:06:49 +0200
X-Gm-Features: AX0GCFsvJjMw9yKd_0baJrrBmXyMs3ujx1Tb5rt2bS-6bs4zuSqH_fl8jO3Q6Rw
Message-ID: <CAFXKEHbdeomMfEBwO+Cvkn5dkN4h47CEAMfmEGQC2V82zQ+U8Q@mail.gmail.com>
Subject: Re: [PATCH v9 07/11] iio: accel: adxl345: add activity event feature
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

[...]
> ...
>
> > +static int adxl345_is_act_inact_en(struct adxl345_state *st,
> > +                                enum adxl345_activity_type type)
> > +{
> > +     unsigned int regval;
> > +     u32 axis_ctrl;
> > +     bool en;
> > +     int ret;
> > +
> > +     ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (type) {
> > +     case ADXL345_ACTIVITY:
> > +             en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
> > +                     FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
> > +                     FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
>
> Something happened to the indentation.
> Ditto for several places in the code (upper and lower from this).
>

What is the matter with the indention here? I'm doing `checkpatch.pl
--strict --codespell` on that and don't get an issue? Would you expect
cases like the FIELD_GET() calls on the next line, linked by a binary
OR, to be indented by yet another TAB?

Best,
L

> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!en)
> > +             return en;
> > +
> > +     /* Check if corresponding interrupts are enabled */
> > +     ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return adxl345_act_int_reg[type] & regval;
> > +}
>
> ...
>
> > +     if (type == ADXL345_ACTIVITY) {
> > +             axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> > +                             ADXL345_ACT_Z_EN;
> > +     } else {
> > +             axis_ctrl = 0x00;
> > +     }
>
> Besides an indentation issue, {} are redundant.
>
> ...
>
> > +     en = false;
>
> This line makes no sense. When it will, it should be there, not in this change.
>
> > +     switch (type) {
> > +     case ADXL345_ACTIVITY:
> > +             en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
> > +                     threshold;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
>
> ...
>
> >       switch (type) {
> > +     case IIO_EV_TYPE_MAG:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     switch (dir) {
> > +                     case IIO_EV_DIR_RISING:
> > +                             ret = regmap_read(st->regmap,
> > +                                               adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> > +                                               &act_threshold);
> > +                             if (ret)
> > +                                     return ret;
> > +                             *val = 62500 * act_threshold;
> > +                             *val2 = MICRO;
> > +                             return IIO_VAL_FRACTIONAL;
> > +                     default:
> > +                             return -EINVAL;
> > +                     }
> > +             default:
> > +                     return -EINVAL;
> > +             }
>
> As I mentioned before, try to avoid nested switch cases like this. Use helpers
> to make this gone to 1 level or so.
>
> >       case IIO_EV_TYPE_GESTURE:
> >               switch (info) {
> >               case IIO_EV_INFO_VALUE:
>
> Ditto for other similar cases.
>
> ...
>
> >  static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
> > -                           enum iio_modifier tap_dir)
> > +                           enum iio_modifier tap_dir,
> > +                           enum iio_modifier act_dir)
>
> If the order of parameters is not so important, I would squeeze new one to be
> before the last argument.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

