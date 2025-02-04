Return-Path: <linux-iio+bounces-14970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87019A273D2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E9C188AD19
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BA2135D6;
	Tue,  4 Feb 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpyM1jam"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CB21128A;
	Tue,  4 Feb 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676950; cv=none; b=d+iohLT5SrLl0o1yrzKGoliAFMgrS8Df9pESxL9TBF6stphO3Zp8CY2VwNkgNonSvV1dyymkHSM4A7XYh6XNR5e2sNCCcqj++BEmByyxSQ6aoOKxMoaNApsfS4ci7QzBdg2yW6R5nZi0iRtzJAAAhRlteSrnrhrTP4VpADzaMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676950; c=relaxed/simple;
	bh=Hw6G83tOXqFtoPILrkGLuq62iockMd91CoPo15zY+Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or3afssQcEkts5n3A4xY9yfZjgB0ePT6ubQm9r+pprutAt1jOZHEDlko/1scFlOqxtH+ifhq8ju+xl/N6lD45c57asbsd0/aHkSXW8JpFfUKcmazids3qFZzx8/JMGRBkXeyH5hBNq0+a/A9qO/rfd+W7qCudnm2AaeHwingFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpyM1jam; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e549488eb07so410079276.3;
        Tue, 04 Feb 2025 05:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738676947; x=1739281747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1fPLLuhMH3uSvITzs4VpgzmKtx/A9LIlEx5oEFml7Y=;
        b=lpyM1jamXFFbYFD0HkyKSapurXRB7qQWoVazk9Z4zbM98HlOCjiwpddx8EYPlz4Vmd
         m7z+H5vlhnH93RlVw1M9ltXONQNv3mXnzWnwmfk01Od2X8CCCWjnzc59G1LeJUrdfrJm
         0Imd3L2//cfjpoDWoNh6Dq0nZue2wFzuobKNOFix/1OXEg0HRPDhPlAFqmoV9iU6npqs
         0xAM37+oNaFcT8t2UYXblOwej0JfXpM2BsbpV40dxdKSfkwEjxkEAmpfMmrwXVZ3eaf/
         PHznNHKMWUW/4ebJ4QcVR6cnKLzmONT0T0PLACXVq+eaXpk6M3Db4HjII9OeEPFuBlnu
         YQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738676947; x=1739281747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1fPLLuhMH3uSvITzs4VpgzmKtx/A9LIlEx5oEFml7Y=;
        b=jKAABrRcOOqhn3Q6rqRM5y3kME1z3OlyzYHXevUq2U4548VnBzs335ViHzmg8J4Q3A
         C7WVP6xqKeHJl1uw02sy2B8Oob7m+nOp/Phhm0ycRMOUCpy7XyAPAuE8Rc/LBuYeVgKN
         O3Lr4vTXnYrbOKfjrOs5NUAPZ+XfEiIAngkawC2y6hxoKedVSJhRukCwMx6gn16qW59V
         gqo3eHIeZqzVNoxpN5rRPWmShgVBGDA7pyABFDPeRbi/hwnMlHhU2HXzYVtDWKPM7iWQ
         J/NioWNE7vwnr4kn91NqiJ9xPnxHCnJoBTTkfHMfekN4VtJNHLv144vVhwUFN09ms82U
         8+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVDkM6JrPVlphLhZYXnJKbfmKh8diYVhriJ4GtSxz8KNWYDqK/JPjREpG2u+mrvXcIz3FjVKwFfn625iWa7@vger.kernel.org, AJvYcCXDNQrC6m4K9Q2agqg390oX7Kuo9Glx6ozNFf8niPrGOdVBUfZsm3P4Qu6qWGgPrM4O5FiI5N4Thhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDun5yCR0HqIiceDFBcgSVc93g4A6tvZJ3TFguogR50MZEkQd
	CBAd9c0UTrPLbJ6S8bKBgE6ShKDarsNoEMxU+ujCzVBNOU6LIWBKpmpmUnB8yfaKKRCPisEF+Zs
	qtKkp1A2Waj8QeKcQKaHL95gSGFw=
X-Gm-Gg: ASbGncsgQ88M/w8G6MXDXL4J7Mhq0W1Uri3c9/kIF8nMCrq9PVks+0vUilU0/d/ngMF
	ZdkZ3H5hlv/orgBSSPj2Qav7+6nuHu66Zj/rwlxTDQLiVOyhdXrvbf7le11EKF0Xwt0iFN/J7
X-Google-Smtp-Source: AGHT+IGyOGD0iF7cz9hsPF+vsh1YWLpKA6/6TIWnkzk9LClSbrBuaY74EeOaR+M1NvaDpSBqgBbM5lXFNQsCx6bHSFI=
X-Received: by 2002:a05:6902:1027:b0:e5a:b05e:4da0 with SMTP id
 3f1490d57ef6-e5b130e9440mr1329536276.10.1738676947486; Tue, 04 Feb 2025
 05:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128120100.205523-1-l.rubusch@gmail.com> <20250128120100.205523-12-l.rubusch@gmail.com>
 <20250201172739.40d12340@jic23-huawei>
In-Reply-To: <20250201172739.40d12340@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 4 Feb 2025 14:48:31 +0100
X-Gm-Features: AWEUYZmrx2livgOQ4RAODyRX9Mooh101jP5iUM84BteuhrgYGPN2kRxql26PsME
Message-ID: <CAFXKEHZ+QqLR7WQdAEj+9vyjWefPGX68vjHGL1LXHmLTAUgwAg@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] iio: accel: adxl345: add activity feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 6:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue, 28 Jan 2025 12:00:59 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the handling of activity events, also add sysfs entries to
> > configure threshold values to trigger the event. Allow to push the
> > event over to the iio channel.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> I was going to guess these were rate of change detectors or ones
> at least slightly compensating for g, but superficially
> looks like a straight forward rising mag threshold.  Not seeing need
> for new ABI.
>
> We've had those interfaces with accelerometers for a long time.
> Key is to map the pretty names in the datasheet into what is actually
> being detected. That allows for a lot better generalization across manufa=
cturers.
>

I understand. The adxl345 should actually be nothing fancy. I prepare
something more IIO-like event handling for the next version of the
patches. Thank you for the feedback.

> > ---
> >  drivers/iio/accel/adxl345_core.c | 158 ++++++++++++++++++++++++++++++-
> >  1 file changed, 154 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 62d75d28b6fc..94c3ad818ba5 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -121,6 +121,8 @@
> >
> >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > +#define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > +#define ADXL345_REG_ACT_ACDC_MSK     BIT(7)
> >
> >  enum adxl345_axis {
> >       ADXL345_Z_EN =3D BIT(0),
> > @@ -163,6 +165,10 @@ struct adxl345_state {
> >       u8 watermark;
> >       u8 fifo_mode;
> >
> > +     u32 act_axis_ctrl;
> > +     bool act_ac;
> > +     u8 act_value;
> > +
> >       u32 tap_axis_ctrl;
> >       u8 tap_threshold;
> >       u32 tap_duration_us;
> > @@ -177,6 +183,11 @@ struct adxl345_state {
> >  };
> >
> >  static struct iio_event_spec adxl345_events[] =3D {
> > +     {
> > +             /* activity */
> > +             .type =3D IIO_EV_TYPE_THRESH,
> > +             .dir =3D IIO_EV_DIR_RISING,
> > +     },
> >       {
> >               /* single tap */
> >               .type =3D IIO_EV_TYPE_GESTURE,
> > @@ -276,6 +287,117 @@ static inline int adxl345_write_interrupts(struct=
 adxl345_state *st)
> >       return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_m=
ap);
> >  }
> >
> > +/* act/inact */
> > +
> > +static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
> > +{
> > +     int ret;
> > +
> > +     /*
> > +      * A setting of 0 selects dc-coupled operation, and a setting of =
1
> > +      * enables ac-coupled operation. In dc-coupled operation, the cur=
rent
> > +      * acceleration magnitude is compared directly with THRESH_ACT an=
d
> > +      * THRESH_INACT to determine whether activity or inactivity is
> > +      * detected.
> > +      *
> > +      * In ac-coupled operation for activity detection, the accelerati=
on
> > +      * value at the start of activity detection is taken as a referen=
ce
> > +      * value. New samples of acceleration are then compared to this
> > +      * reference value, and if the magnitude of the difference exceed=
s the
> > +      * THRESH_ACT value, the device triggers an activity interrupt.
> > +      *
> > +      * Similarly, in ac-coupled operation for inactivity detection, a
> > +      * reference value is used for comparison and is updated whenever=
 the
> > +      * device exceeds the inactivity threshold. After the reference v=
alue
> > +      * is selected, the device compares the magnitude of the differen=
ce
> > +      * between the reference value and the current acceleration with
> > +      * THRESH_INACT. If the difference is less than the value in
> > +      * THRESH_INACT for the time in TIME_INACT, the device is  consid=
ered
> > +      * inactive and the inactivity interrupt is triggered.
> > +      */
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL=
,
> > +                              ADXL345_REG_ACT_ACDC_MSK, st->act_ac);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * The ADXL345 allows for individually enabling/disabling axis fo=
r
> > +      * activity and inactivity detection, respectively. Here both axi=
s are
> > +      * kept in sync, i.e. an axis will be generally enabled or disabl=
ed for
> > +      * both equally, activity and inactivity detection.
> > +      */
> > +     st->act_axis_ctrl =3D en
> > +             ? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
> > +             : st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL=
,
> > +                              ADXL345_REG_ACT_AXIS_MSK,
> > +                              st->act_axis_ctrl);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_act_int(struct adxl345_state *st)
> > +{
> > +     bool args_valid;
> > +     bool axis_en;
> > +
> > +     axis_en =3D FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl=
) > 0;
> > +     args_valid =3D axis_en && st->act_value > 0;
> > +     adxl345_intmap_switch_bit(st, args_valid, ADXL345_INT_ACTIVITY);
> > +
> > +     return adxl345_write_interrupts(st);
> > +}
> > +
> > +static int _adxl345_is_act_en(struct adxl345_state *st, bool *en)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D adxl345_read_interrupts(st, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *en =3D FIELD_GET(ADXL345_INT_ACTIVITY, regval) > 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int _adxl345_set_act_en(struct adxl345_state *st, bool en)
> > +{
> > +     int ret;
> > +
> > +     ret =3D adxl345_write_act_axis(st, en);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return adxl345_set_act_int(st);
> > +}
> > +
> > +static int adxl345_is_act_en(struct adxl345_state *st, bool *en)
> > +{
> > +     return _adxl345_is_act_en(st, en);
> > +}
> > +
> > +static int adxl345_set_act_en(struct adxl345_state *st, bool en)
> > +{
> > +     return _adxl345_set_act_en(st, en);
> > +}
> > +
> > +static int _adxl345_set_act_value(struct adxl345_state *st, u8 val)
> > +{
> > +     st->act_value =3D val;
> > +
> > +     return regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, val);
> > +}
> > +
> > +static int adxl345_set_act_value(struct adxl345_state *st, u8 val)
> > +{
> > +     return _adxl345_set_act_value(st, val);
> > +}
>

