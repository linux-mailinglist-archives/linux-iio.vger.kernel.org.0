Return-Path: <linux-iio+bounces-17485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF217A76C7D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 19:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018FB18889EB
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2A214A92;
	Mon, 31 Mar 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcOCNgVc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157542A94;
	Mon, 31 Mar 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441841; cv=none; b=QDE5/qPnXNlzOBIrYmmkgT+C6w1YulitcGxSTkIE+3C6qt5olSIGvHb1u7CRT4d4zdEHBpVqJem1r/jupQNHl64/oMhzyPQeLTl5I8YxeP9k9UlKdn/nUJow4mIFIpsKUycqJtTX2s6RLqRWF3cEWr4wKU7V8rmAH0D8Sb9RVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441841; c=relaxed/simple;
	bh=bVJ061wVgNRKZRJHbB/7eTIRMbIioUYkRMdIyide3+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsGy5iKidYhBIbS3gLHWwQ02YYqlzLtDcZiCTadIx4aEfl6cIIySROe1tv9b18C/Bxtl04vSs7Ld1bwhyv4qN28kHH0RrR2tO8bM9C/PzdxTn/MSJGDVI1Iiovi0FHMBVM9DuC/R/6YAVa8y+8vdYjTSxyZdf2eysbehkQl2CIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcOCNgVc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e63dbd3d135so611675276.3;
        Mon, 31 Mar 2025 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743441838; x=1744046638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o07hwfiMpLEBbCh4LVHZ84R+SoFB1PtcMrDSIEkGBBc=;
        b=bcOCNgVcj6ZIoF44rc+8+480EedwRMwjTPVzgYf5l6dgbRhsQQEEX6y/24rj10Wmh+
         EhHCNB9Zh4tzh/Z9pMiBifMZZWFBmRAur2Ta9AnAEU/8LC2Fax4MOQ72coqgrttpLrth
         0PBYUzKB8OtFyCpXg14mztYgzQvwgDS82L+91eVsb8gbyUThRrxDFylcE5P1Qtkdeoyj
         4zpyTJrKrd3ayCgwEkLWQzkw9qFo2goBhkWznanWjq0z6iY2Hnfy/N4cb54Gne25hnjg
         1tBOvmXgYwKL4EMi1pqntw5rbkW7hUylY+/cgeumhOm/Qhxa0LdH+5uyajlWe8djkw7C
         xJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743441838; x=1744046638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o07hwfiMpLEBbCh4LVHZ84R+SoFB1PtcMrDSIEkGBBc=;
        b=ay9tfz7nCaNiGsYQ6g47YnO9/rm2MmtwyndQJ72IoQQl6SOdrEOZxG/qyssqM6Dycp
         nE6BgS/yhkD8Kcbixmr13iG02ORqwcRQfpdEyPZqfLCilPDF58b8AajUg6uhyhf93Ogc
         BMiMdyLUl4OReiyOvVmv5HwSIKNLXBAuOg7vqsEgWAnaQkkSiogcAs8RMTJB8N3b69ox
         72JrIYH/4uE3PfuVDO7Dw8KUbLRe1WFOaXb0p8/MpObHEByrh9QsqWu10UmWlOiq+pCj
         NaRpcSbTGU8L9sGqKIAag4zCoBhQcctKcXIc7WvlQn6Chso7+OrFbC5mJQru9gSk7FTR
         VYTg==
X-Forwarded-Encrypted: i=1; AJvYcCULLRW4t87C2SQmJR/mpCg7TE66rb+ItLzuuCqtQgaBtp5Pc7kr+uiKcEcGXVLirH224ikxqhoZBzU=@vger.kernel.org, AJvYcCWn377U+6M6zcbkmdgyfnx6Exw/OOBKV+nBmxu+3p2OQwTVfqxx2qQ5Vd9VAhjh/Hes3jiz4MMC3Qjx6NFk@vger.kernel.org
X-Gm-Message-State: AOJu0YweJT6y6svSL7KxHbQ+gI4ofT5OoLj5ebKST5+RxBiw6wHFgK1I
	pJdiVs4Oi8Vw0s6Y83hCAN1Zrf9sxRnrZP+/qKbftcGXVB+rzuQ3fQqOr4YwL/I0iW3DnVpWbhQ
	2nXNtuyZkMzsYZ5em4XQIBAaKbFe+hQ==
X-Gm-Gg: ASbGncucNhzql4/hNNGsMdSoh4GgmUp1Sdkg7ZVDp/6+J98l4K+KLRmQGEr8afmbFLV
	8kdPBpG9wMRBrdbr/VHS39zqUWZAFkVeIUueVyo6DB8Ott+00DDX7dBNi05vVT7+d5eetk7wxSf
	SHej+046eLvV+UdTh2WTv9EafxRQ==
X-Google-Smtp-Source: AGHT+IGmw3c2+Lwdd/F8uB5cjr+TUjvNtqnjp7SE2z5kFo0mehDfyHaZ7uEe6fqIMMscsB6teQR3bzJnKdrps/YT3rE=
X-Received: by 2002:a05:6902:2e0c:b0:e5b:4019:50fb with SMTP id
 3f1490d57ef6-e6b83acc996mr5516246276.8.1743441838300; Mon, 31 Mar 2025
 10:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318230843.76068-1-l.rubusch@gmail.com> <20250318230843.76068-6-l.rubusch@gmail.com>
 <20250331112839.78c2bc71@jic23-huawei>
In-Reply-To: <20250331112839.78c2bc71@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 31 Mar 2025 19:23:22 +0200
X-Gm-Features: AQ5f1JrqaKUNLa2CyJwwV4UIormZlXTOJ6wU_endFPTyRK4uIqsxzUGfErFD7V0
Message-ID: <CAFXKEHYMgv1-rt6Sc65fCoki14v==NqQTY6J3WnQBG+ASoLeaw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] iio: accel: adxl345: add freefall feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan & IIO Mailing List'ers

On Mon, Mar 31, 2025 at 12:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 18 Mar 2025 23:08:37 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the freefall detection of the sensor together with a threshold and
> > time parameter. A freefall event is detected if the measuring signal
> > falls below the threshold.
> >
> > Introduce a freefall threshold stored in regmap cache, and a freefall
> > time, having the scaled time value stored as a member variable in the
> > state instance.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>
> Apologies for the slow review!  Just catching up after travel
> and I did it reverse order.

No problem a all, hope you had a great trip! I'm glad this goes for
another version. In the meanwhile I was messing with the zephyr driver
implementation for this sensor and had some findings and final
thoughts about the ADXL345.

First, set_measure_en() I use to enable/disable the measurement by
setting a bit in the POWER_CTL register using regmap_write(). This was
ok until adding the act/inact feature. For adding power modes to
inactivity, I'm going to set the link bit in the same POWER_CTL reg.
So you already guess, yet another call  to set_measure_en() simply
wipes this link bit out immediately. I'll probably replace
regmap_write() using regmap_update_bits() still in this series.

Second, while playing with the zephyr driver and another setup I
discovered, that probably the sensor is capable of mapping events to
both interrupt lines in parallel. Currently, either all events to to
INT1 or to INT2, not both. This affects actually 8 interrupt events:
data ready, single tap, double tap, activity, inactivity, free fall,
watermark, overrun. Actually they could individually be mapped either
to INT1 or INT2.
Initially I assumed they all need to go either to INT1 or INT2
altogether. I appologize for this, I was wrong due to the breakout
board I was using. That's a kind of crazy feature, and I think of
implement it perhaps in a follow up series. Anyway, I was curisous
about the approach, currently only can think of introducing 8x new DTS
properties. Are you aware of sensors with similar features, what is
usually the approach how to implement that? What is your oppinion on
this?

Third item, there are 4 FIFO modes: Bypass and Streaming are currently
used. There is another FIFO mode and further a Trigger mode i.e. only
when the sensor got triggered it fills up the FIFO with data (also
this is mappable by the INT1 or INT2 line then). What would be a way
to configure such feature? I know many of the Analog accelerometers
seem to have FIFO modes. Is this to be configured by DT properties?
What would be means to configure it? Also, this would be a separate
patch set.

Best,
L

>
> > +
> > +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> > +{
> > +     unsigned int regval, ff_threshold;
> > +     const unsigned int freefall_mask =3D 0x02;
>
> Where did this mask come from?   Feels like it should be a define
> (just use ADXL345_INT_FREE_FALL probably)
> or if not that at lest use BIT(1) to make it clear it's a bit rather
> than the number 2.
>
> > +     bool en;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_thresh=
old);
> > +     if (ret)
> > +             return ret;
> > +
> > +     en =3D cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> > +
> > +     regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
> > +
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > +                               freefall_mask, regval);
> > +}
>
> Jonathan

