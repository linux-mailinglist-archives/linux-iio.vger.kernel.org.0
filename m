Return-Path: <linux-iio+bounces-18491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8AA962B5
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 10:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689A93BCBE9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9596283CB8;
	Tue, 22 Apr 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkall4kD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23359283CAD;
	Tue, 22 Apr 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311149; cv=none; b=ofZAwbRrKTdhnb+xnGRGXCCPleCyioO5DnV3TN+gZtbhHGjdo/0VrbXoLZ4Lm7xtWHC5sJSiKAuCDKMZmeT5DRZNOp/LPTqJiMAy5+O0Iy58+cL3Y15WHkKaZ6wU5HCO04oN9VrU31r7tNJGR/8OyTijEg99IvSM1FIwqZBas0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311149; c=relaxed/simple;
	bh=IQFl72OzJ4mBTOQPAIwQGKqNCYqAnIWUEXWp5iXWCeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEEOHeJStX/EvBuIS1OFxnHZqHcU0j/i+pQa8J/p9nKGbAUeNO9yaU276fLGdUEjE1m9XNtLEI6SpEHwhfmS6WQa2NZOhZ9juhXdwhFIMgQSFDE4N/mWETGvM2tM8Mr+dWjmwjCVumhasJv3Uo08n16C5IW03eGeqUN00WGHDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkall4kD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739be717eddso3621468b3a.2;
        Tue, 22 Apr 2025 01:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745311147; x=1745915947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCvA/v2EUituzS9kNtyUPMk5f4h9VA5Fx3x52Zgd4YE=;
        b=Bkall4kDbQEDDdGOL3qER4eWI+RYnboB0jYAMcKsw+jcZq7CGYiPIXW2Zb8C63ZmXZ
         AfoIdUvcjf8rCxf59pQDPKzujBAFYE69Kixg0+wAwpI+mH2HyblnL9MWHKF3tuQH019+
         2VgBSEb5BCi9SyhVsVrP+bJP2j1PofHGgOXTuMiCBh6QqfjOv9H6hYycyTc382F6ypFj
         Grk8QTi3Yz4DC+123H4DEcyvOphemSbui6cAg9PlsMz1gwF47isWom9SYSkVqcTtf8dC
         8Y75Q80cbq3RGNYSsqC88FLnT03RF22s2Vw4DfswaFn5eJCK5ttLET7mDu22HsXr6A7C
         I3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311147; x=1745915947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCvA/v2EUituzS9kNtyUPMk5f4h9VA5Fx3x52Zgd4YE=;
        b=I0R5cPM/cZUSe0mlLKum9T9rFGe0RgP3Z+CJ+Jq4QQi9Uzs38U669hr63QKtPXvm2G
         J+hkWnogteFqbU7nLP7P34ztP1oVpJvy+OptImXHdTmt+xsBLCZ6lnm3jNgm6BW3ubcM
         LARUhMyZ2uZ1L1Bf6Zfh36QVopPZz8Kj9cW51ju26vV5ayrCTk4jAyjk8NuW6qME8Sa/
         6Zz1DxBPHgePLahO7vCAaW4vA58LpbPAw4DpEv59VNd7kEuIJE7BVxroeKVVKAOihxa3
         vX84I/4N3QLVbklytq54ERlvMqXghnWVJYsg6YFU3T01PVgRgeIngSIScBYSxhyx7F/4
         4NUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq1z821hXbtw8eeIO5zOxWEg/r4VI2+u8Lt7e0+EVagwO+m+ysv4bAKnZissvJOY7KPBrzADdKVjXb@vger.kernel.org, AJvYcCXS4p5prGcNUH2jhZyZ1DbFT8amUALX/7dbhL2mcKHNeWIQ8QZ44Wdi1K4JE4x6vRXM1zzmuCiNdGQL@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlafZfT2r3JLc3gFk/WPwlzuI8F+jEUygWII1LrGbRuoUMKFL
	CSdtpUvkzA0R/Z9h6uaBjSPD0QkhfGi168lT17yZR68rC1bWO96ydY6BJpzRdTPhN0wE7L9XYAs
	DQSnY1Y5UapMya/INHa8UneFU/I4=
X-Gm-Gg: ASbGncsJu+O/P6+wMBUUNjgARK6JzW3fFfSF897Jj/rEEIq2hFs+QZdJeUYe5DloMhg
	YNAip3VWNGX15FHpENYiuEoshlu5+BBYs/bqemfV+bTIsZ51fTQv8guSiHAC+CHfnxj482iFyv4
	MvA6Wzq/ibxo436vrKJRoeJVw=
X-Google-Smtp-Source: AGHT+IG3YORNxBuSlbAhFau+N9rvGD7+/9/RdXTUKn/Kh/4XSDX1FAf35cZy5fMzyCG5uvoyK9JuoYkTcUJ6i/fljrY=
X-Received: by 2002:a05:6a20:c6cb:b0:1f3:388b:3b4b with SMTP id
 adf61e73a8af0-203cbc524f1mr21369900637.15.1745311147329; Tue, 22 Apr 2025
 01:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420181015.492671-1-gye976@gmail.com> <20250420181015.492671-4-gye976@gmail.com>
 <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com> <CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com>
In-Reply-To: <CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 22 Apr 2025 17:38:56 +0900
X-Gm-Features: ATxdqUH6KFlOdTRKwJGiiGzCSdBIeAWcBl164uuauYurpsla6SOBr9ewPOQhegA
Message-ID: <CAKbEzns_cve+=8wQu2poVx5ZFr8zfUyMajmEz_YpSCDxffQXyg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Apr 21, 2025 at 4:24=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Apr 20, 2025 at 10:21=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Apr 20, 2025 at 9:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com=
> wrote:
>
> ...
>
> > > --- a/drivers/iio/chemical/Makefile
> > > +++ b/drivers/iio/chemical/Makefile
>
> > >  obj-$(CONFIG_SPS30_I2C) +=3D sps30_i2c.o
> > >  obj-$(CONFIG_SPS30_SERIAL) +=3D sps30_serial.o
> > >  obj-$(CONFIG_VZ89X)            +=3D vz89x.o
> > > +obj-$(CONFIG_WINSEN_MHZ19B) +=3D mhz19b.o
> >
> > Preserve order.
>
> Ah, I see it's ordered but by Kconfig, Why do you have WINSEN in the
> option and no such thing in the filename? I would drop that from the
> config option.

I followed the 'vendor_device' naming pattern seen in examples like
'CONFIG_SENSEAIR_SUNRISE_CO2'
But I'll drop the vendor prefix in the next patch, thanks.

--
Regards,
Gyeyoung

