Return-Path: <linux-iio+bounces-20528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F8AD694F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1424A17ACD2
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A912139B0;
	Thu, 12 Jun 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA0ViAuA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA425212FB7;
	Thu, 12 Jun 2025 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714073; cv=none; b=jTZW7mYh8XHynfBsHGi4/XeHmdVL9XzIiKr4MlQM71Ku8L9ocq7xhlsPRlX/q/iIYguJMI0rhSeNKZZqXKVYlfEIYqVh1ioFd2DymKyi2LAiJpt3LD4zYf1ulFZsJ6OCEPPIwXgJA5c5PaEo864Gh/6ihsPztSXHlQk5M1Dy+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714073; c=relaxed/simple;
	bh=fh1vbhoItcY0toN2uOWniNiGxNYtNpDoDlXS6V8PF1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tXltos+99cGMqLYFUCNd7y4S6DL4N6n7szTwz9D6FT2wlc+Fqy7aUILh02dhyS2Q9UYAFBIecdHFYO/V5Xtjeq+jWUI+TmyU8KlGgF0h18tohHWdMP02/NtPR1TVmDPPLboi9CVTSa0jGBxpnqMr+4nUg7VbAN8/KYya+9ZhHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA0ViAuA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a375e72473so466265f8f.0;
        Thu, 12 Jun 2025 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749714069; x=1750318869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NE6sl/3ii4GV4fF2dhKrJVyQtrM/ceM6+ALYFfRXTYc=;
        b=BA0ViAuAtMaaG4zB7AzvRfZ5gsNVjYrezcC/Liq/K1KpnJtk140Ml9pE5s1WxJJhec
         dEmlN+YRBxVsBbsa3sUAuBwlOMdxXFt/6fz98mGWfSLxWf2kA8QV6MRMxta1eyf80DeU
         1GZKF0Rk3mMxe/Qs0B1ernjfevMN/Td1AXKTl1679d6C0DeqUgfMNwTTmMI5v8ygOgrz
         sT30MAprT1dt0Rq6Hha6B6JfraIdzJSfWzbrUOgJilUwbCHgFhDzBbyMbr9QxaPAq/EW
         KePisiky4kligXyoeAfqxf3MiB7INTTHPixEt1vSh21HKrN7l4XJGJbGA0MCxmxtw3qN
         zJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749714069; x=1750318869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE6sl/3ii4GV4fF2dhKrJVyQtrM/ceM6+ALYFfRXTYc=;
        b=LcKUzj2Pd7nQGjSDa4yYFT3gkywPmPWJsgqBZh92lp5SLK0vM61VJCWMG6QMmRJ2w/
         uhV4gmslbNQVRl7XAgpaS5R8ao+RtNJX4wF0boUBM+FC1x8IhrUsOoSsiAOtP5E4t8Ho
         HmAU4lSm3fGW424Turv1B+vwnvWXXBOEdFKxw+6hH2bRMdv9eXE4nklTWnvGo2DfeFDN
         Vi1rsSwFXLv1R3tYgYugi9ueOqp/FuuA7+7wOp7xuRWC6vy4uBxw0OsyoV1dBqgeGCF2
         OLW0TZ9/raky8GcfJuUEs8Tsel7Uoycj2SuKdvC5w9lfDJxVelf9A8m107edCu6vJPl8
         EL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAaEzlyKkZ3JRfxnyVH376t1P6R9CAXrzRDBZZdto/iVW5g7fr+24fTs+M2L16GlmxaanMo/BQEI7S7oko@vger.kernel.org, AJvYcCW/9BDkiZxDeQCr1sG3Djzi1qCBbU+/lz68a3bWTkP/ofU4DEdj5WCZM+B2juNLqNYp7vBCh0Ii3Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqAosGoHGaJARKRLotTw0gM9kZkRF1EX8BiygmlQC1PmjtsOc
	s1auibL1+0StYrFoiwcOsH252gHjF7egxqm6Ab+kLVN4q9a89/+HPejN
X-Gm-Gg: ASbGncskNdhWaw5WTpLJzo6AzIzzAnRTvoO3DpqW3I3YRPZllhwiunEaiRRMzo70yjX
	WfHjINcw9qVe+8Hw2s9eU90uEdf+TTF/Qwuv7jvypdmzEX2ecHcxUjzOF7SxF9t1QJYI7w6ETAt
	iUXGdeO3Zkd9P7DAQRLHzTEbz2oeTc7ugN6YCWA68JlVWKVBYtbU5r4B88hsemf4DzdYQ/WkbHz
	tPlzePHvsTKRScF/gURZyNXm47kzDEFR30NCgi62DuWKQTZ2xLYRXADJicCPMSFpwQnnkruomKj
	yohPxJnWwwOaT3xCL/wUJNzuRWbDGZ4PjwIR4PcZnnoOBNXKz11v4XFKUBfu4msH0psa2oXNV3i
	ZJSxYeuLqxsDg5/eXrqw9lTqUq65asjznC4K/
X-Google-Smtp-Source: AGHT+IFHUEEHaCMswiYcbd3LW7ES3Qk+5wg3qFnnjDMDIPQCRtyPEroeFOvALcl/ivpaJtotZVj/fw==
X-Received: by 2002:a05:6000:26c8:b0:3a4:ef48:23db with SMTP id ffacd0b85a97d-3a558800eabmr5338979f8f.59.1749714068853;
        Thu, 12 Jun 2025 00:41:08 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561a3c538sm1172146f8f.50.2025.06.12.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:41:08 -0700 (PDT)
Message-ID: <304d3bcef438a78564650edd52f7570f0bd30c95.camel@gmail.com>
Subject: Re: [PATCH v5 1/3] iio: accel: sca3000: replace error_ret labels by
 simple returns
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andrew Ijano <andrew.ijano@gmail.com>, jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
  nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Jun 2025 07:41:40 +0100
In-Reply-To: <028710c4e4494285bee82ae811147b03cfa612f2.camel@gmail.com>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
	 <20250611194648.18133-2-andrew.lopes@alumni.usp.br>
	 <028710c4e4494285bee82ae811147b03cfa612f2.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 07:20 +0100, Nuno S=C3=A1 wrote:
> On Wed, 2025-06-11 at 16:39 -0300, Andrew Ijano wrote:
> > Replace usage of error_ret labels by returning directly when handling
> > errors. Cases that do a mutex unlock were not changed.
> >=20
> > Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> > Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> > Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > ---
>=20
> Code looks good. But since you're doing this you could cleanup some of th=
e switch()
> cases. Some return in every case statement while other don't (even think =
I saw one
> one place where 'return' in the end was not needed). IIRC, there's prefer=
ence for
> returning in place.
>=20

I see the above could be a bit cumbersome in cases there's locking (which g=
et's
cleaned up in patch 3). So, nevermind the above. If there's any leftover, y=
ou can
send a follow up patch or introduce a new patch if you need to re-spin.

For this one:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

>=20
> > =C2=A0drivers/iio/accel/sca3000.c | 29 +++++++++++------------------
> > =C2=A01 file changed, 11 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> > index aabe4491efd7..bfa8a3f5a92f 100644
> > --- a/drivers/iio/accel/sca3000.c
> > +++ b/drivers/iio/accel/sca3000.c
> > @@ -369,23 +369,20 @@ static int sca3000_write_ctrl_reg(struct sca3000_=
state *st,
> > =C2=A0
> > =C2=A0	ret =3D sca3000_reg_lock_on(st);
> > =C2=A0	if (ret < 0)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	if (ret) {
> > =C2=A0		ret =3D __sca3000_unlock_reg_lock(st);
> > =C2=A0		if (ret)
> > -			goto error_ret;
> > +			return ret;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	/* Set the control select register */
> > =C2=A0	ret =3D sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, sel);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0
> > =C2=A0	/* Write the actual value into the register */
> > -	ret =3D sca3000_write_reg(st, SCA3000_REG_CTRL_DATA_ADDR, val);
> > -
> > -error_ret:
> > -	return ret;
> > +	return sca3000_write_reg(st, SCA3000_REG_CTRL_DATA_ADDR, val);
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > @@ -402,22 +399,20 @@ static int sca3000_read_ctrl_reg(struct sca3000_s=
tate *st,
> > =C2=A0
> > =C2=A0	ret =3D sca3000_reg_lock_on(st);
> > =C2=A0	if (ret < 0)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	if (ret) {
> > =C2=A0		ret =3D __sca3000_unlock_reg_lock(st);
> > =C2=A0		if (ret)
> > -			goto error_ret;
> > +			return ret;
> > =C2=A0	}
> > =C2=A0	/* Set the control select register */
> > =C2=A0	ret =3D sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_re=
g);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	ret =3D sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, =
1);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0	return st->rx[0];
> > -error_ret:
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > @@ -577,7 +572,8 @@ static inline int __sca3000_get_base_freq(struct
> > sca3000_state
> > *st,
> > =C2=A0
> > =C2=A0	ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > +
> > =C2=A0	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
> > =C2=A0	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
> > =C2=A0		*base_freq =3D info->measurement_mode_freq;
> > @@ -591,7 +587,6 @@ static inline int __sca3000_get_base_freq(struct
> > sca3000_state
> > *st,
> > =C2=A0	default:
> > =C2=A0		ret =3D -EINVAL;
> > =C2=A0	}
> > -error_ret:
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > @@ -834,7 +829,7 @@ static ssize_t sca3000_read_av_freq(struct device *=
dev,
> > =C2=A0	val =3D st->rx[0];
> > =C2=A0	mutex_unlock(&st->lock);
> > =C2=A0	if (ret)
> > -		goto error_ret;
> > +		return ret;
> > =C2=A0
> > =C2=A0	switch (val & SCA3000_REG_MODE_MODE_MASK) {
> > =C2=A0	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
> > @@ -857,8 +852,6 @@ static ssize_t sca3000_read_av_freq(struct device *=
dev,
> > =C2=A0		break;
> > =C2=A0	}
> > =C2=A0	return len;
> > -error_ret:
> > -	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/*
>=20


