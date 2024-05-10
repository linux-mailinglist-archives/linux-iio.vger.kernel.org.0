Return-Path: <linux-iio+bounces-4935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A08C294D
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 19:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18821F23B32
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30F18E25;
	Fri, 10 May 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MKMFiRVN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2C168BD
	for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362260; cv=none; b=HB4ERz3LyhcikGpqh2Xkfa3mlXFr7hQVP0Q/3/HZ/sfrvJNwFEbkrJQhOVYd7X+A+ZujCG65vJQyf/nnGXP8SkzKUKVwqqdA2yjGNmyl+ZMpM/Lq61Kjg85JJxmWTUVLKCMIdTg54FRi9K1Ie/QSjufGPfKya9vX1M7sVtTeE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362260; c=relaxed/simple;
	bh=XqrCfizCQyF2KKw0/WdajRp4//EIlKPiWT2wjme1sQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7EsSndsBFkFLEwAuZ1wdQeLejjeaQGTAyjsBGR77Fz3RcJ3fnDql2IWWlwGIxZFW3tvNUESig/CUb5yM3MASAdRhxHbiz2qszRVWh/yZTg4OuEQLIAW7vX/URSVSdPzP3qroQVgh4DSoC4mcKHOgpMZaF1md2X2z/C2s3qqOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MKMFiRVN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1fa2ff499so32107991fa.0
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715362257; x=1715967057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Occ+O3gQaZXJydVURkKGuh31GRbkBBYoYZRwqv9bgzU=;
        b=MKMFiRVNAcyzIJGC2QnIM1QG7lmYziPooPnFU2OAmhysGLxVjbf6sjZ1sWW+6g/UN1
         5V9yI6E6A1f/TlYlKrW5wokEQly/x2Dx5a6tHyut5iMoGruVjkmG4L60vnTmCNLBd6Fk
         jpy6tlsln4szy9nwGBJx/AEQeZheYLJ4f+Dys+3XMr7eJAf29IU/hGopikjjI8fuFJRf
         M/udYs83RH17iIGCVrrsAD/oPPA41c9PmaeUaU20hEGjFLmDoA3nOSBNiFwjui80je4M
         LFYiZtgrgBm/tMHG5R8lyJT/RL/uQ8VDPpj500UNYrM4Woj2/0bPrlD7IEGHjri4SGO3
         n4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715362257; x=1715967057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Occ+O3gQaZXJydVURkKGuh31GRbkBBYoYZRwqv9bgzU=;
        b=kcfVqGyLIACpJRsrMuP7HJkknom+Cadnnzi/jZ9+GOSWy+k8gO+AkEW1meUjG6QxUh
         zcbS3N5iXBCSE+KSd2BwVel8neXT5QAvcRj6hKyUIofWwzcDkFOPxFJYGA2lz+U5yoZk
         k6xLbvYHEaLjdSIoPXPZ/u/tlfPZqQKLkfVK4KASLXrWrhB8lrIFwI7iWqh5lrqa3Y0R
         TJC9tkgQa7Qdw5omWSYAX7TGvzFuufXjMQfK6jNl6pILJZzViKuMSfTWwKVCMy8alACk
         71tqIZIDFyZxsyhQTDCqXFkjBPQkbVBVUumoRuGmjEu8WbljMpVELuhUoBYHyU0g57ER
         z+ng==
X-Gm-Message-State: AOJu0YzXT8D0PfHeWeA01YJvxODOstQ3x0AqnbV3ZdWatTIVOLcClOHh
	SQvjcqKqKwk4O5LHDNX30BlnO5B6jDLwJ7HkMbhUHgEShCCsMkCAZ/buOnjAo99g/5ZwDRusm51
	QYS7BgazRm2fiiu7bEoaKjzms+MbJRP5r26pzjw==
X-Google-Smtp-Source: AGHT+IEth9+yiMEnT0dyi6WAr5+H1hY9rOJ8pfNbE7ESLJAECOzbNoW9ASNpZO6jpztELqcXrloxCo8atIKPBbyxWz8=
X-Received: by 2002:a05:651c:c7:b0:2db:2385:d024 with SMTP id
 38308e7fff4ca-2e4b1ad9c2amr17614851fa.26.1715362256957; Fri, 10 May 2024
 10:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
In-Reply-To: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 May 2024 12:30:46 -0500
Message-ID: <CAMknhBHd2XCJH4rgYDq=vbCL5E_tM3FxFPWbNy9PvxLCJL4tcA@mail.gmail.com>
Subject: Re: [PATCH 0/2] add AD8460 DAC driver
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:42=E2=80=AFAM Mariel Tinaco <Mariel.Tinaco@analog=
.com> wrote:
>
> The AD8460 is a 14-bit, high power +-40V 1A, high-speed DAC,
> with dual digital input modes, programmable supply current and
> fault monitoring and protection settings for output current,
> output voltage and junction temperature.
>
> The fault monitoring and shutdown protection features were
> supported in the earlier versions of the IIO driver but was
> scrapped due to uncertainties if the functionalities belong to
> the IIO driver. However, it would be best to implement it for
> the device's quality of life. I'd like to know if it's better
> suited as a stand-alone HWMON driver.
>
> The following are the configurable and readable parameters
> through SPI that could be implemented on the HWMON driver:
>   * An enable bit to arm/protect the device on overcurrent,
> overvoltage or overtemperature events. The device is shut down
> upon detection.
>   * A configurable range/threshold for voltage, current and
> temperature that raises alarm when exceeded while the device is
> armed.
>   * Flags that can be polled to raise alarm upon detection of
> overcurrent, overvoltage or overtemperature events, and apply
> additional protective measures.
>   * Programmable quiescent current (optional)
>   * Thermal monitoring is done by measuring voltage on TMP pin
> (unlikely to be included)
>

Adding myself to the cc: here since I'm interested to see what
Jonathan (or anyone else) has to say about the fault monitoring.

