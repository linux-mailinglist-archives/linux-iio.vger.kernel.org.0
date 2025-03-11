Return-Path: <linux-iio+bounces-16732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210EEA5BE48
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 11:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF91A7A3A06
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE8250BE7;
	Tue, 11 Mar 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpGG+Wcb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B422F163;
	Tue, 11 Mar 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690544; cv=none; b=bt32KD/nbA3ze6fABFmIfr/zFx1ZyBT5srJ5rjo/5XR3ZarzbFZjEAoThsWkCBjpLfvw+Kjs6VVrTLHSYSgyQD27cj7dEyGt2H3bEFxh0xaZBAd+MP201NCANOPbJQ8btgAgBneL/xRYVwHqfepc7xoO2JkUeMVpDeRFpuiPfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690544; c=relaxed/simple;
	bh=R44SPJNpxlOEwzV029hekw0Z0d2JnpMKVd0YobaXWTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yk9GPK1iyiiQY6C0nozNEFrI1kt3MtOo0ytvMYd61HWufMstNrSuJH/rdlHuAsOlk0Llb1KnpvuhsVDG+D7bB3TE3/NAQT9ZCWAN3NGfXRdW3ONdMtKOMslooqn0+t6YaPeFag39Xm3/gOQwe+6ouZbSUhi24AIFB3XtFvI7cIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpGG+Wcb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6366fad150so428502276.0;
        Tue, 11 Mar 2025 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741690541; x=1742295341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6p94+AhWHfunYTAhfze7DttzhfYw6e5r1WKInYKyhY=;
        b=KpGG+Wcb5FqED6QAqPT/eQqeEon3j8Ov5rxYZEk4OYNRNVQBVjQAgQfr4CT059hisE
         B9OVjwa0dxIBNORVUtcbDG75Qlu7uYXL9VrNSzuBUsfMiV/YFVZ7BA+kkS7y4y8PEtAw
         Y56PzWmgDosnYl4G1uEOtfFGrug3OhEzKl6aQYZ5lhSZgCmcVojIHhCop6zQ2alW2KAI
         1B8WiiGGE8vSP9OsOT9FeGl9QqI19WFhxEMVZcrCDUMzN6BMlWKDhKa4QMcKTKzwAqNO
         SBNp9JCK3360nqDKZdeXclJXTm8izq3JCiI9w4mvYnbSnQM3CB9biA/nb+veYCJuEwWJ
         fobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741690541; x=1742295341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6p94+AhWHfunYTAhfze7DttzhfYw6e5r1WKInYKyhY=;
        b=UhV6rTsFkQfr5pgBsmLZfVxj7XSoZDFK8+XksKH+NtRrW4EfgleRKECi7HuWpOC00V
         ynnT0WH7Rsw89ky5NO0Vrjkl1lhx/zSTE2WeA5wvaJH/uZfqW6sICkTVL9XFHDc2RnQd
         RtRj1Cqpayq1gcfFcCv3fDGzpxkhWx4lTwfLC3U8dSBaaWnKRp4fquXnKEkIgXAwZHok
         GfWJ4i2IpBelkj5oz8sRGwHA8t15Ru8P/ohAkOAjsivnWd02mYNV2eQfDHuRb44n3/ci
         yAsxcq7vfZhAVximgxKfUwoX0ViCI3xq4xEZGhdSB6v9mR6nZhKlyle+nYdkfM7P6/P6
         2lUg==
X-Forwarded-Encrypted: i=1; AJvYcCU/CQRgQYtuh4MMnP7pv/sdx9oFAiIzzoLv7iMW1T+f6pKFsTO9GUMK928jOguf2CvxSVEfvRtfKnw=@vger.kernel.org, AJvYcCWKr3IXoU8XljIxbHn4Mxuao4puO0H3jHD8kdTCi+ohvGP3t5606BPPU3uHPcLxTk7WFQlS5zY7L5LUzzys@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHWt2BVbWNSLQ9nZjqZzQ7hKhtKEANxOtiLhwhe4GIbHApfM+
	AYxPVaGj5m5kcWtwQcnAb2pDsvJFshejdN3q96cesUoxoxstlLMOo4hEsw3fpA6f3WTFFwCZAmG
	Bwgiz4y1duBPKdHIaZAiAjh2YHmqA8OnblS0=
X-Gm-Gg: ASbGncvwMiFei8MjkLRMZuTLFZsw3JbXYjHY0gZvoDaICKYE+AmVmOQLyS81e9afLF+
	B8Z5uz0SnMvDgEIhqBJW84TZVBfjIG/nJO6ZB3rmTr1d45Y382F/3byT6IK42iaDA9Q1tFumQ8e
	mco0furzL/gacTDnKu7bE+j4SYqXv3sguudl9L
X-Google-Smtp-Source: AGHT+IFBVqwshadUnEeqBfl8nMC7Z+hi9HpaYgrZL+Jjz62pcb6Y0EM8cDmre7/lJFwrPhW0h57kGPWKsT/TTNSiRds=
X-Received: by 2002:a05:6902:120b:b0:e60:aa9c:8c94 with SMTP id
 3f1490d57ef6-e63b517860dmr1511031276.4.1741690541230; Tue, 11 Mar 2025
 03:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104234.40958-1-l.rubusch@gmail.com> <20250220104234.40958-13-l.rubusch@gmail.com>
 <20250304134918.797e6386@jic23-huawei>
In-Reply-To: <20250304134918.797e6386@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 11 Mar 2025 11:55:05 +0100
X-Gm-Features: AQ5f1JqsPv166OFpHsZy5X71kMES8SflRYuPqY_s11R3v7BXA40RSpLRd-GxYYI
Message-ID: <CAFXKEHZF4bW=rvbJDkrs04XtGo5rV3Y4HR0fBgOR_03ZTpc-Cg@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] iio: accel: adxl345: add activity event feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

I'm currently about to update the series and like to answer some of
your review comments directly when submitting. Nevertheless, here I'll
anticipate this one. Pls, find my questions inlined down below.

On Tue, Mar 4, 2025 at 2:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 20 Feb 2025 10:42:31 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Make the sensor detect and issue interrupts at activity. Activity
> > events are configured by a threshold stored in regmap cache.
> >
> > Activity, together with ODR and range setting are preparing a setup
> > together with inactivity coming in a follow up patch.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Some questions / comments inline.
>
> This review is has been at random moments whilst travelling (hence
> over several days!) so it may be less than thorough or consistent!
> I should be back to normal sometime next week.
>

No problem, no hurry!

> > @@ -258,6 +284,73 @@ static int adxl345_set_measure_en(struct adxl345_s=
tate *st, bool en)
> >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> >  }
> >
> > +/* act/inact */
> > +
> > +static int adxl345_write_act_axis(struct adxl345_state *st,
> > +                               enum adxl345_activity_type type, bool e=
n)
> > +{
> > +     int ret;
> > +
> > +     /*
> > +      * The ADXL345 allows for individually enabling/disabling axis fo=
r
> > +      * activity and inactivity detection, respectively. Here both axi=
s are
> > +      * kept in sync, i.e. an axis will be generally enabled or disabl=
ed for
> > +      * both equally, activity and inactivity detection.
>
> Why?  Can definitely see people only being interested in one case
> and not the other.  What advantage is there in always having both
> or neither over separate controls?

Ugh! This happens when I mix writing code and writing English texts,
w/o re-reading it.

Situation: The sensor allows to individually enable / disable x,y and
z axis for r activity and for inactivity. I don't offer this in the
driver. When activity is selected, I always enable all three axis or
disable them. Similar, for inactivity. The question is then actually,
if this is legitimate, or should I really implement enabling/disabling
of each axis individually for activity and similar then for
inactivity? I mean, when not interested in one or the other axis,
someone can fiilter the result. On the other side I can imagine a
small impact in power consumption, when only one axis is used instead
of three axis (?). Since the ADXL345 is [was] one of Analog's fancy
acme-ultra-low-power-sensors, power is definitvely a topic here IMHO.
I can't really estimate the importance.

I guess I'll try to implement it and see how ugly it gets. At least
it's a good exercise. As also, I'll try to bring regmap cache and
clear_bits / set_bits more in here for activity and inactivity in the
next version.

>
> > +      */
> > +     if (type =3D=3D ADXL345_ACTIVITY) {
> > +             st->act_axis_ctrl =3D en
> > +                     ? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
> > +                     : st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
> > +
> > +             ret =3D regmap_update_bits(st->regmap, ADXL345_REG_ACT_IN=
ACT_CTRL,
> > +                                      adxl345_act_axis_msk[type],
> > +                                      st->act_axis_ctrl);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
>
>
> > +static int adxl345_set_act_inact_en(struct adxl345_state *st,
> > +                                 enum adxl345_activity_type type, bool=
 cmd_en)
> > +{
> > +     bool axis_en, en =3D false;
> I'm not keen on mix of set and unset in a declaration line.  Better to
> use two lines here as it can be hard to spot when things are or aren't
> initialized when that is not the intent.
>
>         bool en =3D false;
>         bool axis_en;
>
> > +     unsigned int threshold;
> > +     int ret;
> > +
> > +     ret =3D adxl345_write_act_axis(st, type, cmd_en);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(st->regmap, adxl345_act_thresh_reg[type], &th=
reshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (type =3D=3D ADXL345_ACTIVITY) {
> > +             axis_en =3D FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_a=
xis_ctrl) > 0;
> > +             en =3D axis_en && threshold > 0;
> > +     }
> > +
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > +                               adxl345_act_int_reg[type],
> > +                               en ? adxl345_act_int_reg[type] : 0);
> > +}
> > +
>
> > @@ -842,6 +972,23 @@ static int adxl345_write_event_value(struct iio_de=
v *indio_dev,
> >               return ret;
> >
> >       switch (type) {
> > +     case IIO_EV_TYPE_THRESH:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     switch (dir) {
> > +                     case IIO_EV_DIR_RISING:
> > +                             ret =3D regmap_write(st->regmap,
> > +                                                adxl345_act_thresh_reg=
[ADXL345_ACTIVITY],
> > +                                                val);
> > +                             break;
> This collection of breaks and nested functions suggests maybe we can eith=
er
> return directly (I've lost track of what happens after this) or that
> we should factor out some of this code to allow direct returns in the
> function we put that code in.  Chasing the breaks is not great if it
> doesn't lead to anything interesting.

I understand, but since I'm using quite a bit configuration for the
sensor, I'm taking advantage
of type, info and dir here. It won't get more complex than that. I'm
[actually] pretty sure, since this
then is almost feature complete.

I don't see a different way how to do it. I mean, I could still
separate handling the "dir" entirely in
a called function. Or, say, implement IIO_EV_TYPE_THRESH handling in a
separate function?
Pls, let me know what you think.

> > +                     default:
> > +                             ret =3D -EINVAL;
> > +                     }
> > +                     break;
> > +             default:
> > +                     ret =3D -EINVAL;
> > +             }
> > +             break;
> >       case IIO_EV_TYPE_GESTURE:
> >               switch (info) {
> >               case IIO_EV_INFO_VALUE:
> > @@ -1124,6 +1271,17 @@ static int adxl345_push_event(struct iio_dev *in=
dio_dev, int int_stat,
> >                       return ret;
> >       }
> >
> > +     if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
> > +             ret =3D iio_push_event(indio_dev,
> > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                                     act_tap_dir,
> > +                                                     IIO_EV_TYPE_THRES=
H,
> > +                                                     IIO_EV_DIR_RISING=
),
> > +                                  ts);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> >               ret =3D iio_push_event(indio_dev,
> >                                    IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > @@ -1157,6 +1315,7 @@ static irqreturn_t adxl345_irq_handler(int irq, v=
oid *p)
> >               ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATU=
S, &regval);
> >               if (ret)
> >                       return ret;
> > +             /* tap direction */
>
> Belongs in earlier patch?
>
> >               if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
> >                       act_tap_dir =3D IIO_MOD_Z;
> >               else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
> > @@ -1165,6 +1324,19 @@ static irqreturn_t adxl345_irq_handler(int irq, =
void *p)
> >                       act_tap_dir =3D IIO_MOD_X;
> >       }
> >
> > +     if (FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0) {
> > +             ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATU=
S, &regval);
> > +             if (ret)
> > +                     return ret;
> > +             /* activity direction */
> > +             if (FIELD_GET(ADXL345_Z_EN, regval >> 4) > 0)
>
> I'm not following the shifts here.   That looks like we don't have
> defines that we should but instead use the ones for the lower fields.

The 8-bit register is split as follows:

| 7                |  6         |  5          |  4         |  3
          |  2              |  1             |  0             |
---------------------------------------------------------------------------=
-------------------------------------------
| ACT ac/dc | ACT_X | ACT_Y | ACT_Z | INACT ac/dc | INACT_X | INACT_Y
| INACT_Z |

I thought here, either I shift the ACT_* directions by 4 then use the
general mask for axis (lower 4 bits). Or I introduce an axis enum for
ACT_* and a separate one for INACT_*. Thus, I kept the shift and use
the same ADXL345_*_EN mask. How can I improve this, or can this stay?

>
> > +                     act_tap_dir =3D IIO_MOD_Z;
> > +             else if (FIELD_GET(ADXL345_Y_EN, regval >> 4) > 0)
> > +                     act_tap_dir =3D IIO_MOD_Y;
> > +             else if (FIELD_GET(ADXL345_X_EN, regval >> 4) > 0)
> > +                     act_tap_dir =3D IIO_MOD_X;
> > +     }
>
>

Best,
L

