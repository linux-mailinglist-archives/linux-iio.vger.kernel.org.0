Return-Path: <linux-iio+bounces-17798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27008A7F468
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 07:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A3C3A942A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6D23ED60;
	Tue,  8 Apr 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4XBx/h7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C0221F11
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744091463; cv=none; b=pwLJ+oMDoItBYq5F+gIDOkDKLPO9OQNhy2UK3piPdf97GBmmOkBHLdN6t5NKvd5+u5n5yu0sh8ykYVZJaezhG7VpqXK6x2J1RlMKvNQRS97W1+Q/l0YtHvUuohgyJ+Pkk0TClDvGZp5enK+s44Rsk6xGGzNKvY2e1Q8GG9bRe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744091463; c=relaxed/simple;
	bh=cTBS4EITLH/RKTsefjWnrcJeZlWKccC9lxnNUiQXvQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEwgcAkX37x41JTqaz5UZ0MBnx/LtUU+ZCGK4uKVabLm58dmvXSCmU1PzWt5X+yUT3/IWBEhKe1HnuqieELO1xnSjs/fBbBD9DULlNuoeMU+JSPNTZ72kylcXNHFGd1skiXeur3LfBkGRU8WthElZt51znbFwwriK3ZzruICLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d4XBx/h7; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5241abb9761so2250177e0c.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744091459; x=1744696259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFD2PpKOKkhNcofkMXws158Oc7eyZufKfu/WKUdKoaI=;
        b=d4XBx/h78XnWkbjra4nFfaMx8SgzUCrhWKd743tNa0hJeRcv3C7Ti0fDrJQPNbpG42
         wSLNG830vGCf3MpddKb2WvdSvlwAZhMW/234/obM/II4PlSvCAsiG7sb+qFr7XvmQQYZ
         5mTuADU4RsvcuKTaVNRhFW/9maADOq5OSlFMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744091459; x=1744696259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFD2PpKOKkhNcofkMXws158Oc7eyZufKfu/WKUdKoaI=;
        b=ttbQXrOiV4EyuBKR1u6ZI4oKbcfWFHg/y6S5V3cdwr/8DEIxpddldZz8OpJlA9H/R5
         SclxUZ942is/aWe80MJuMKZ/ACfz6vJCGaCyTGnaBaPoqZZvUbFm0DmOnQI8l/4lsG+Y
         9aGo1/1GqzVvBHARpS/VehtGJ19ecwtoFpV+KTdfZsTIbPn4geMpfOSaJqDjRw+D6A8p
         XCd0TmaIqlOT4EWjzNAUvtdTwuiKtROjxX0a8VNPAO2hVF/9Nk7QacPRTPzLbjGlVWaa
         0oMycEsARGCrwjlivkfHoshi1IvnX2aO3GvONRxfG/zMb5zQ98PTxHV6X5FAz331GoxX
         t6cg==
X-Forwarded-Encrypted: i=1; AJvYcCXDsGrPgV2cq5NvGnQJwa6v6cJ66V4TBUTNztMvQseeyY/CYr+iftGr2UJQP9uBpoFZaOdttR0HpdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6x/vr0U9NWYupqHGn+P361c5W4k277E3jf8yrCznKNs86SYO
	M6KmHCwq8gGK+PrI8+sLxVFpCM4sjVuJd0s27Rgnyhi74lh7XVYEgtPqVpPm2C5yee7LOgIh2jH
	tLz+oe9wNkF9A89Cnqj2qOAO4EyRhpg/UaUVJ
X-Gm-Gg: ASbGncugOC5oaKHIkB8TDqAArE2POJwH9xuSlH22ggTQJ0NPvCOeRI7F2RuePC6Iza5
	DOCYd2YxzktpCt1SB59HSxh4ykS1WO+jiwDRTp50POferHNtAORPUMTypeQCceRTAxkquio0VwX
	dNv90bICEz24FeO8uAEYYg8JPpSx/WArrpKiL+kxEaLjb7u4QJM90ktja9B00=
X-Google-Smtp-Source: AGHT+IFsFaGuDyfD68CP+ZNLD9shyFqBd9AQJ3vcfkck4zR+gGjbycYTOgcXunEXfd4yoTUnoVMXRqcggR5mLBu+yvk=
X-Received: by 2002:a05:6122:32cf:b0:519:fcf2:ef51 with SMTP id
 71dfb90a1353d-52765c8dffcmr10352098e0c.5.1744091459553; Mon, 07 Apr 2025
 22:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331164832.4039379-1-gwendal@chromium.org> <Z-0DleD6CRIsz3mY@google.com>
In-Reply-To: <Z-0DleD6CRIsz3mY@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 7 Apr 2025 22:50:47 -0700
X-Gm-Features: ATxdqUHWPQg6Apyn0wZxPwlmra2iHZM1bBqQ-DWkID63MHsvM5z45gsmlO6U0Ew
Message-ID: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: cros_ec_sensors: Flush changing the FIFO timeout
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 2:30=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Mon, Mar 31, 2025 at 09:48:32AM -0700, Gwendal Grignou wrote:
> > fifo_timeout is used by the EC firmware only when a new sample is
> > available.
>
> I guess you mean: "FIFO timeout".  There is no specific symbol called
> `fifo_timeout`.
I mean sysfs attribute `hwfifo_timeout`: its value is only used when
samples are flowing from the sensors.
>
> > ---
>
> "drivers: " in the patch's title prefix can be dropped.
Done.
>
> > -static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_stat=
e *st,
> > -                                   int rate)
> > -{
> > -     int ret;
> > -
> > -     if (rate > U16_MAX)
> > -             rate =3D U16_MAX;
> > -
> > -     mutex_lock(&st->cmd_lock);
> > -     st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> > -     st->param.ec_rate.data =3D rate;
> > -     ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > -     mutex_unlock(&st->cmd_lock);
> > -     return ret;
> > -}
> > -
> >  static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
> >                                                struct device_attribute =
*attr,
> >                                                const char *buf, size_t =
len)
> > @@ -134,7 +118,25 @@ static ssize_t cros_ec_sensor_set_report_latency(s=
truct device *dev,
> >
> >       /* EC rate is in ms. */
> >       latency =3D integer * 1000 + fract / 1000;
> > -     ret =3D cros_ec_sensor_set_ec_rate(st, latency);
> > +
> > +     mutex_lock(&st->cmd_lock);
> > +     st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> > +     st->param.ec_rate.data =3D min(U16_MAX, latency);
> > +     ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > +     mutex_unlock(&st->cmd_lock);
> > +     if (ret < 0)
> > +             return ret;
>
> It isn't obvious (at least irrelevant to the commit message) that
> cros_ec_sensor_set_ec_rate() becomes inline here.
I changed it to be consistent with the flush being inline, and the
function used only once. Fixed in commit message..
>
> > @@ -152,7 +154,6 @@ static ssize_t cros_ec_sensor_get_report_latency(st=
ruct device *dev,
> >       mutex_lock(&st->cmd_lock);
> >       st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> >       st->param.ec_rate.data =3D EC_MOTION_SENSE_NO_VALUE;
> > -
> >       ret =3D cros_ec_motion_send_host_cmd(st, 0);
> >       latency =3D st->resp->ec_rate.ret;
> >       mutex_unlock(&st->cmd_lock);
>
> Unwanted change.
Removed.
>
> > @@ -853,6 +858,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sens=
ors_core_state *st,
> >               st->param.sensor_odr.roundup =3D 1;
> >
> >               ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > +
> > +             /* Flush the FIFO in case we are stopping a sensor.
> > +              * If the FIFO has just been emptied, pending samples wil=
l be
> > +              * stuck until new samples are available. It will not hap=
pen
> > +              * when all the sensors are stopped.
> > +              */
> > +             if (frequency =3D=3D 0) {
> > +                     st->param.cmd =3D MOTIONSENSE_CMD_FIFO_FLUSH;
> > +                     cros_ec_motion_send_host_cmd(st, 0);
>
> Wouldn't it want to check `ret` from previous cros_ec_motion_send_host_cm=
d()
> and override `ret` by the latest call?
Done.

