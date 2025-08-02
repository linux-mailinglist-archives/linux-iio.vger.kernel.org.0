Return-Path: <linux-iio+bounces-22196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF71B18EA1
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29698563582
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEFD239E96;
	Sat,  2 Aug 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS/Hx2vi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAEA1E489;
	Sat,  2 Aug 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754140692; cv=none; b=ndSR4XL+qUNksh4WSBdEnvrhbqaV2dQFNKulVttbmM79nbuPrOPNYg5s8/8q0f+1oVHfgcg5ip4uknoAwAgxBhGilbRtiP8I5KIvmk3dUUOQwA1j8hg1Rkn2Q7S2sXDTiO7Xg2czteDicR3yMVOfOnrsPLGqP9YC3AJm4Hf1VPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754140692; c=relaxed/simple;
	bh=rwM7aZc0/79RFn/uBW4n1pV92J+gZDfBn551fgemfKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDk6OJZGc2QcsZlEXoGSvWe9XQz/E0MXZu7BwsSK/wO4AxBjRbEhYTob9onx1PwnfOsTdqEkpDCHpe3vhmpuyWV89rW4ECts8IjRwPn59DQtKrGR37Zf3CTIVAqQn9qbkLV0wQWzfAGwumcas9GKCm32RsR2/hVnbxYMbU+MuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS/Hx2vi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so3071014a12.1;
        Sat, 02 Aug 2025 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754140689; x=1754745489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=851sI+0lSVYLOYz2PZ6RCpHKug8iuu20s6r18n52W5c=;
        b=PS/Hx2vi/DgmzLpKLVuwfDw8jYNLCxyUYBsWAF+odA/oepGVlwZJoY6lfZYsyIfsP1
         NpgHP3U0fllxSRUp4yZhqfkjzHwncVxS4h5j8HAyQAgUcpVz++d8pN0RZJ+POcGbO8Ly
         8W7UdJpuKTDq+bNqX3Mw5vQxI/sdEQB1XayEU/dtJfxGHX0T2SeG43uUPipQFthP2AMw
         QlSyIEpasLl93KaYgyfV5vpchIHclnxcSNbl2/7ruGm8xRzXcfbTQuJaOWM+8qaYzCyF
         nyG1qTIvd3lNksD43t5P1Su3nEO0bWIUxXVCYXx2pCOUIGWAKWBDY5NcKCqTbESZDYwm
         ghyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754140689; x=1754745489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=851sI+0lSVYLOYz2PZ6RCpHKug8iuu20s6r18n52W5c=;
        b=kHR2PS7jR7CYi7pr9HVjWBiZ+ZidY2DFw1HF7cNviS6HH3PZfIHEv12KunHwnQ/teL
         822apEQfwrVi3Y3o9pzIEkQrfMDh40rVF4/wCBQjK9umEqZ4M2cTzP1a1D4bxdvFLRzQ
         RtMAShPPllA+UYnMzYQPCwycZSNyYq09HfnXMyraQyMDKc5xsdORQ5X1WoxtCa9Lj7i4
         chE8GY2V9S8zqvfEs5B6UUS4AOcrs/Jfrg/SN5pTax+rmEtR5B+kSBdrYdr/TgXh0T5N
         VdEeFEavpiDKi+nP9HBhWQ5TP7gms5ehDn3pn9nUSUxA/6ywRtLlxbbo5ekqm8UYSeBb
         yKPA==
X-Forwarded-Encrypted: i=1; AJvYcCVeh3l3iKg7LijiJ76xYwvMcfnlD6vdBDnu0dEf8baRbI6ApOKsJ+aCCc4Y8iM/M4RzUL01ZlfhCp6N@vger.kernel.org, AJvYcCW0A2HOTFToR2ELn3KM7M9VK7GMd2FU0ar/rgX+EeHI+ncUNRP2Y1N0DIdNUrAD558k5xh7MV7DEKSk@vger.kernel.org, AJvYcCXIrs0s3NpZSsWNZa/1DzyivZNcKRlrZXaYgqctrnSh8tQfZHMyhQdLIliswEfeziNkv2gpHJtB614wjGKT@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvu2irzQv3hr8EFnJKF77AcEZTaWKSCK3P9ymkQc9v+THaoko
	5FRUgex82DNs5i2eKVyavArIV9TQXVxQGfkeUnB/YKLHY4CQW3D8ZGm5u7JMd8Ohdx469J4G0bB
	IRJCfAjH+xmHRNFF9Io09AFniiB74gH8=
X-Gm-Gg: ASbGncuI8HDIlq83ILu3pDdv6ul2ZiC91zMsFJUUcbdJu4cNU+YqGJ7l72lFsS3UAme
	P5DmSTeAYhFZt/1hoa5IyxrWUJ5YMzygpesHi8jr3qQbPrd8VeBohjPdtB2lH4UmAhyjMzsBsL0
	0t6eQdiVfLG/9p1lAGObcyXQ+xONBZJQGuFKJRTh17cDXzPdUcWOtIWuLuh8bI73ers1yj30Ucq
	bVQMjlxHg==
X-Google-Smtp-Source: AGHT+IEtMEI17hNXHe0GwF9SHO7tnCgjtyIkpF5rCMet+Hw8Mh2ic7Ic2pJQBAVoIyUv9fNGjcWO8xhTx5j6u7095eE=
X-Received: by 2002:a17:906:6a0a:b0:ae3:6659:180b with SMTP id
 a640c23a62f3a-af9401ee944mr330584866b.29.1754140688962; Sat, 02 Aug 2025
 06:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <CAHp75Vdc7RB8MG+jYcSxkvD2EY2weZJMnvkbgmqibYGLkcUEBQ@mail.gmail.com> <20250802121556.36440419@jic23-huawei>
In-Reply-To: <20250802121556.36440419@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Aug 2025 15:17:32 +0200
X-Gm-Features: Ac12FXy7X71a8oTk748EvwK_PRQ77GO746ailvjW076YYe5H9yN1b9iPNUJfg18
Message-ID: <CAHp75Ve8GOGYLSYgWDncTJOE5_iJqzxQ4BYmvgQ0AO5YYF1K3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magnetic Sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dixit Parmar <dixitparmar19@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 1:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sat, 2 Aug 2025 10:53:30 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sat, Aug 2, 2025 at 8:44=E2=80=AFAM Dixit Parmar <dixitparmar19@gmai=
l.com> wrote:
> > >
> > > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > > applications includes joysticks, control elements (white goods,
> > > multifunction knops), or electric meters (anti tampering) and any
> > > other application that requires accurate angular measurements at
> > > low power consumptions.
> > >
> > > The Sensor is configured over I2C, and as part of Sensor measurement
> > > data it provides 3-Axis magnetic fields and temperature core measurem=
ent.
> > >
> > > The driver supports raw value read and buffered input via external tr=
igger
> > > to allow streaming values with the same sensing timestamp.
> > >
> > > While sensor has interrupt pin multiplexed with I2C SCL pin. But for =
bus
> >
> > the sensor
> > an interrupt
> > an I2C
> >
> > > configurations interrupt(INT) is not recommended, unless timing const=
raints
> > > between I2C data transfers and interrupt pulses are monitored and ali=
gned.
> > >
> > > The Sensor's I2C register map and mode information is described in pr=
oduct
> > > User Manual[Link].
> >
> > Replace Link here with 1...
> >
> > > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49=
/infineon-tlv493d-a1b6-datasheet-en.pdf
> > > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic=
-UserManual-v01_03-EN.pdf
> >
> > ...and add space followed by [1] here.

Note, my above comment also applies to the actual patch.

...

> > > Changes in v2:
> > > - Drop regmap implementation in favor of using direct i2c APIs to
> > >   have uniform communication APIs across the driver.
> >
> > This I don't understand. I mean the motivation behind this. Usually
> > direct I2C communication is used to do some initial checks and
> > configuration and rarely for the actuall run-time driver
> > functionality. Otherwise it means that the regmap may be used with a
> > customised read and write methods.
>
> This was my suggestion.  The device has very odd characteristics that
> means writes really are not register based.  You have to write them all
> every time with now addressing.
>
> So to me regmap just wasn't a good choice here. You could do something
> some nasty stuff to hammer it into a custom regmap, but to me it's just
> not a good fit.

I see, thanks for explaining this to me. Okay, let's leave for now
with the direct use of I2C APIs.


--=20
With Best Regards,
Andy Shevchenko

