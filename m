Return-Path: <linux-iio+bounces-20926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA2AE4E67
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 22:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226D8189EBF5
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0497214801;
	Mon, 23 Jun 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPyYVwdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C932C190;
	Mon, 23 Jun 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712298; cv=none; b=XL7W4Zhw3wecac1Br2WD8nS4tbWVYdvfwaJFbwqK3x1+MtoCZ5THNxv0BRWzYzFET+pRy4tlUPBR3UZtPm0QnfTHdVLS2fcaIegONUMptnmoOBvsYPJKraEsrrEF6AUYhQK5tkkYHNeNsLNDhHiYefXtxUlDi4YrvtXKJYaj+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712298; c=relaxed/simple;
	bh=776wSncQW1xwOP34kmp9xdM/HLTWzzodZmtjjkoBmgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiO57bf2gERLdh5h/zxdgqifscmaS7s2rHElpCCmJKPGqkkD+ESBZv0wv4YPRnNpRwTwj1yFNosM0MWbtRuT55jMQWzgJ/lEeX7t14TNB1Bpm1skfeo6TswlkZdzoHBRsL/rjCwxHOXa1VR7hGbs3/yWPlaFDH8yeQXi9yssjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPyYVwdK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e81e8321f11so554835276.0;
        Mon, 23 Jun 2025 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750712296; x=1751317096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCvTT8wvpYdg449blLDp6fi3HEHpX9BGcZcH416Lr44=;
        b=GPyYVwdKWh0nc9airPnZnoA+b82oKRgAgIo34TpU8YJzvIKckZ8DEEZxilh8dmguJJ
         J/S3Zzuq6Trg4XhdzQflMXCZB/Itb7hvYme8SJebVAlvBCPXUKO+Zx21gMctmDlKazbn
         YrK2hM4GgUhEpJZku2x5KCxwNZaw+t8zBYtqbfiuWBKVpyw4kEdZkEcUuD5+YvaF1Wdu
         q6naTNV77jvmqOI9qd+9/+RHPZ6HI5XvAJjtdGPIYEg+IW7K//m5WJQrIDCed4GMlkWQ
         kx6pEx/6ny1Ao9CvQl1EI4S3uPo9XWG4fPq9FwPQlt28V3kcuUGXQBb/xN4mVYzStzDw
         LG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712296; x=1751317096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCvTT8wvpYdg449blLDp6fi3HEHpX9BGcZcH416Lr44=;
        b=UiowfiPRqOjfTzV0OJIVxlYz6esuLHuYkaZPXRbahTD+NkLUI+ZyNIGOrD1ZdJZ0UO
         6llm+MK715ptSYbDnAikF5XOUHclsAW1PwtJia9YAPUEJG1yA1VK6/rDHWtalh/7mtYR
         1QrAp0s9qY86S05CWgxNx/fMhnd05b9yrTo+4p3XKWOZr0vpGTCYA43QyS35RQDdSQJa
         cNKju/AznyuaoJE56T7gNh+cZH8s9ejyKijg2Qfo7NQSFgtG00bTRbjcwhHPpb/Ayq/k
         poBKlrWcmKhEh73lM5T6fg0mskE835/CCGFhDZPOWnrm3Wh/rqsSh7FIs2oL2fmb/Gk7
         Fz5w==
X-Forwarded-Encrypted: i=1; AJvYcCVFHdkBZ3efaz2skN+fZ35JoGUkjCR5JYJwmW1cd4tOj/Z8LYk/qvn1nlF5Q2MmOHCO8g0sX5pb7oo=@vger.kernel.org, AJvYcCVMvojeJR9Osg6cdgx7WpcOdHSt/RL/qR2/BNY/h6EslCCSyox6tc0zmqddABYA5MPobEI5oOLgmQFz@vger.kernel.org, AJvYcCWlflHDhV/C6QNg8yLC1bbryCQoqmP/rkQUrY20OMBwBwMmO0D8qyGiUe4wg79T94HJ8ALpPspt/44zI0GA@vger.kernel.org
X-Gm-Message-State: AOJu0Yykm1Cnd5+5f6egS5yEFJdRQYi6JrwxZm2bXrEds3pSElgr+U5+
	kqXsTZkR2YrpdqdbYpaKjhybajXVMl4K05ZOsLJ1Vtwg3yvraDw3Xtvh0u3tHdiFl9X33Ujk3vI
	eCO64bKi3Qc4rFZBIa1jNuNhwqmnsVuI=
X-Gm-Gg: ASbGncuJmkJEJG0lkGVsk6v2igdXsZJUNdm+B1JzIx3REvwK6s/MOYAoZZnn0fnfQY9
	ZvOPDz1xs8IVWWSa6BjN63MK4BlRoLCVbz9zSHJp1r+WkRaOlie0rWoGl77Mu703wf8IzTdDMYb
	YkEmNFvTkPhyEVj1gYaw43gducGZjQPBraQ94OO4oa6zw=
X-Google-Smtp-Source: AGHT+IHLCiITHeFFUwoaBxSNyLK4rYf8WdbLwlQxrGcpm/VoZtCB2g+5XkdMP3yvnFePdMAoH9a2s+LwPMMXJAto858=
X-Received: by 2002:a05:690c:6ac9:b0:710:eb0c:da33 with SMTP id
 00721157ae682-712c654a9e5mr95110387b3.9.1750712295894; Mon, 23 Jun 2025
 13:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622155010.164451-1-l.rubusch@gmail.com> <20250622155010.164451-4-l.rubusch@gmail.com>
 <aFkfjAekGJTU5o71@smile.fi.intel.com>
In-Reply-To: <aFkfjAekGJTU5o71@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 23 Jun 2025 22:57:39 +0200
X-Gm-Features: AX0GCFtB93pXClswuiGY716ZjbH1aG0FWIojnaRDxI8nwCzYrny1LzkihVh3GS8
Message-ID: <CAFXKEHbGThKzMxg=aZMgVEZ2S2hUoGAOoE5wu_vCuzEPqL0+cA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] iio: accel: adxl345: add activity event feature
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you so much. I really appreciate your quick feedback. I'll try
to implement
the changes in another version, as far as needed.

Talking about the 80 characters, let me give an anser inlined down below.

On Mon, Jun 23, 2025 at 11:34=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Jun 22, 2025 at 03:50:06PM +0000, Lothar Rubusch wrote:
> > Enable the sensor to detect activity and trigger interrupts accordingly=
.
> > Activity events are determined based on a threshold, which is initializ=
ed
> > to a sensible default during probe. This default value is adopted from =
the
> > legacy ADXL345 input driver to maintain consistent behavior.
> >
> > The combination of activity detection, ODR configuration, and range
> > settings lays the groundwork for the activity/inactivity hysteresis
> > mechanism, which will be implemented in a subsequent patch. As such,
> > portions of this patch prepare switch-case structures to support those
> > upcoming changes.
>
> ...
>
> > +static int adxl345_set_act_inact_en(struct adxl345_state *st,
> > +                                 enum adxl345_activity_type type,
> > +                                 bool cmd_en)
> > +{
> > +     unsigned int axis_ctrl;
> > +     unsigned int threshold;
> > +     int ret;
> > +
> > +     if (cmd_en) {
> > +             /* When turning on, check if threshold is valid */
>
> > +             ret =3D regmap_read(st->regmap,
> > +                               adxl345_act_thresh_reg[type],
> > +                               &threshold);
>
> Can occupy less LoCs.
>
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (!threshold) /* Just ignore the command if threshold i=
s 0 */
> > +                     return 0;
> > +     }
> > +
> > +     /* Start modifying configuration registers */
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enable axis according to the command */
> > +     switch (type) {
> > +     case ADXL345_ACTIVITY:
>
> > +             axis_ctrl =3D ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> > +                             ADXL345_ACT_Z_EN;
>
> I think
>
>                 axis_ctrl =3D
>                         ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN | ADXL345_ACT=
_Z_EN;
>
> is slightly better to read.
>

Agree.

> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL=
,
> > +                              axis_ctrl, cmd_en);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enable the interrupt line, according to the command */
> > +     ret =3D regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > +                              adxl345_act_int_reg[type], cmd_en);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return adxl345_set_measure_en(st, true);
> > +}
>
> ...
>
> > +     case IIO_EV_TYPE_MAG:
> > +             return adxl345_read_mag_config(st, dir,
> > +                                            ADXL345_ACTIVITY);
>
> It looks like you set the editor to wrap at 72 characters, but here the s=
ingle
> line less than 80! Note that the limit is *exactly* 80 character.
>

I have my setup adjusted to 80 characters. Anyway, the cases here is
different, it needs
to be seen in context of the follow up patches. I tried to prepare the
patches now in a way
where changes are mostly "added". Is this correct and desired patch prepara=
tion?

In the particular case, this patch now adds ACTIVITY. A follow up
patch will add INACTIVITY.
Since this is still building up, it will add yet another argument to
those functions, i.e.
> > +             return adxl345_write_mag_config(st, dir,
> > +                                             ADXL345_ACTIVITY,

will become, later
> >               return adxl345_write_mag_config(st, dir,
> >                                               ADXL345_ACTIVITY,
> > +                                             ADXL345_INACTIVITY,

To make the change more additive, I did linebreaks earlier than 80
characters. Is this
legitimate in this case?

If so, I'll keep all related formatting as is (and will only change
the other requests).
Otherwise, I can do it differently and adopt all the formatting
changes to prioritize 80 characters.

Please let me know, what you think.
Best,
L


> ...
>
> > +     case IIO_EV_TYPE_MAG:
> > +             return adxl345_write_mag_config(st, dir,
> > +                                             ADXL345_ACTIVITY,
>
> Ditto.
>
> ...
>
> > +             return adxl345_read_mag_value(st, dir, info,
> > +                                           ADXL345_ACTIVITY,
> > +                                           val, val2);
>
> Ditto and so on...
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

