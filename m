Return-Path: <linux-iio+bounces-20733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF988ADC253
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C653A3AC85C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 06:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10EA28B4E0;
	Tue, 17 Jun 2025 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIeAP68m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E57C2D1;
	Tue, 17 Jun 2025 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141485; cv=none; b=SOEwwqxFkjf7NUp7+Dlsx06Yf44Olun3aLz+lRq+4Gy7WKrPDadVx2MSo0yLQW654lAlKQEu7sOGYZ9r/b+IlwadspwE5MNvYWSLUXk2iErCMk0kplhJrC2GUbjadM4Q/j67xsYBzKiMQDOj3/rPBH+jRpN1Csn0Fav7BuC6xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141485; c=relaxed/simple;
	bh=FimawyL6R59yeyleZHcqYiYhCdOgIj10rs3P2dnnxm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGJH1n4IPpHWhZzdqhKVHL39lvFgmYegKHgLsnEYC/9rOwP51fRupc3olEEzZN2ZhA4QwXjRI6oqIlPnYx/gxMZG8pheC3jG+9eAGBsW/JYp/OIJGAK5y/waKZ4P/KkrC8LP4poSj9Ft3Y5WPWQoknpEniCLEiptnnNRPfwkpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIeAP68m; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so10034950a12.1;
        Mon, 16 Jun 2025 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750141482; x=1750746282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv52R5nOhn8eM/6uHkKiOhAOsj6LjD2US5K7BMLlrJQ=;
        b=RIeAP68m7RJQTqb5LosmowMZ/m2TqwY8JyxlmZCqTEJp3SoHxjuO/FIr1nIsZ1Nbhb
         TnMIZXE/MTchWgOYf27rnO2xNAw6dcey6hjpapjWbyycHc2FdkUAlANWZP/zXG+4Jqwb
         mwEimBN//7Q1B9+dQcSxN0Y+4XLY0Zg2O3sTKC4TWm7W68DFKNQ98/DVs09cCANEt9VD
         pEQJlFrl1kp7hpMGu9NxjI4Wu7uzDR8dOdtSmbTRyRVN5hkGmw2pJ5RphfjDcyRYBRJg
         aL69ygRxzZXn0pVujRQuvF9w04PolVwCwOZ1mo2/ZcsByw+u/He6aaxDXNkMkYYHre7B
         aKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750141482; x=1750746282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv52R5nOhn8eM/6uHkKiOhAOsj6LjD2US5K7BMLlrJQ=;
        b=cZgyFXLrq8VEz1Jd7SYuXCPEX0CVxdEVpUcrzwfhFVDNvsAel7KVQt0WDnQU7K6dOf
         fbhaGBH6Axdj/xpy8j2zwFc3j7+Qos6JTHU4vp0dm7rTl5gI51hP6L3eoGxdxUMZXE7k
         vH24BGmzUyk23AeYHvOpVcnYPRWVtxbdKaHZB7tIEA21lqQM2PsAyPjIQPufF1fZogtj
         UYbRczn2U+Xp/p6wtjMeRmXxZA/fyM06eR9/ZsPklGljqfNqy36fYDRoRdgwJcB7e6N1
         B/7VrUi8qio+HEHF4VJGBtAdohXcXvwlyIz/jlnm0zu9XFmXesMSYfuzIAdRHHELmrsh
         EfFA==
X-Forwarded-Encrypted: i=1; AJvYcCVBnu7BhhGdMxyA4ajp3YhBX5KlYnW3Bp84YT57Qyw+rwgH+mX5Bd0/0R0h+6N6Zdj/M64cMpcnVmev0YL3@vger.kernel.org, AJvYcCVLRsDQa3DRnwMFFhrSlhGcYDOojdiM7/VtbI4FV4SujV4zNIr97UAXNRUgE+OWDNyzYJRbR2mnXyi9zg==@vger.kernel.org, AJvYcCWElzJ+6KjN4NKtT5pvYysSCqh5AyQMW3/Y54E5nyc/cXBSTKggCxSTwJ52h4yp4mz2+sUkUOUWLI77@vger.kernel.org, AJvYcCXweFfEmUl51Y3+L84rk4bTrEADrQ+TICzSFG9GJIgP3HyQsfjSs8A2zPHYJoXEHBE/Xa5AcbvNblKt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZYf7TshHCevs30LbX9sCQ8Gxl3rGadUgYzaNtNqLjs/s/aHU
	dS2cGevdu4a4I0Frb14Mz94P+0Va9I2Vch+Alngg5fL6fgoQ7c63yRN0T1Pu9zSc/5byqlWv23h
	rmOzzz6P2RBYPC2a4fV3c1FLKYX0CUlw=
X-Gm-Gg: ASbGncvfB3WmDqVMwDotHA46P4ouhCk6L7SIZTfPbXcCNBfGoooyihLifiizaSUMRC2
	hgbqavX+91UVZoELB+rXSuhhYMktuValopYNG420Hr1mC9myPJ/v0/V7KOc1cFjY5XZ1m4c6gSS
	q3W7C/fyhNBMKBeVjbc5gJEN4k86Kmi/5jJ0KiSB55CjhY312qC8aDZGfw
X-Google-Smtp-Source: AGHT+IHcqfTh/AvxtHJoXN0Aouf/N7BBC+fBhy8N8VL7NPaH0I2m/3Xb9qrKuj4B8tBu7moZAtR9qNi91UVwj4kUDc0=
X-Received: by 2002:a17:906:9fcb:b0:ad8:9e5b:9217 with SMTP id
 a640c23a62f3a-adfad60cb3bmr1179369266b.45.1750141481870; Mon, 16 Jun 2025
 23:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <5ac4b2d54f426d997cbb067530ab8e9af9bdcf16.1749582679.git.marcelo.schmitt@analog.com>
 <656c43dd-c39d-4e35-a9d8-70383c0836a0@baylibre.com>
In-Reply-To: <656c43dd-c39d-4e35-a9d8-70383c0836a0@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 17 Jun 2025 09:24:04 +0300
X-Gm-Features: AX0GCFtxDmHhNdgXUIjNyDwrmnrpwdMMC-qSKW_2BduktjXGeT0kT7zLcVFr9BY
Message-ID: <CAHp75Vcx+DY1T03RiLjqo6PEe0C97N3bzW1irvCe_1ZBpO_n6Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] iio: adc: ad4170: Add clock provider support
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 12:11=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
> On 6/10/25 3:33 PM, Marcelo Schmitt wrote:

 ...

> > +             if (!device_property_read_bool(&st->spi->dev, "#clock-cel=
ls"))
>
> This isn't a flag, so device_property_present() is probably more correct.
>
> > +                     return 0;

Good catch! +1 to this, it must not be read_bool as it's not a boolean prop=
erty.

--=20
With Best Regards,
Andy Shevchenko

