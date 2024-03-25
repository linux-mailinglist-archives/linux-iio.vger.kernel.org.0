Return-Path: <linux-iio+bounces-3787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F788B11E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 21:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564AB30044B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2D4AED0;
	Mon, 25 Mar 2024 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iuCw32tm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84F4C618
	for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397676; cv=none; b=WPNSpStT+a20sSx7epcKOAfsTS5RyqIqhEgPzhdLBvSpz/adW0ZXn8UGlYMcmiAfpDsjUvt7sV2cFo7T/jkucA0U1i+F5If/BfHSATx8IotiISQkBHkLRMmTwTinPFteqajR96XhKh0XniQg4Pot0t9i5qbOpU48yqmMUHVCgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397676; c=relaxed/simple;
	bh=y/Copnmio+r4JHJn7cH1SHr0SKFHmhJFbDXHchbZThs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tn7/Ug+IAVJZ88f54FDxku1rWoQLQQRcBrb9dfVdvVI/pjDpJmOut+44PuvDHx91y+OwWC4sewf9yY4fbnlpTmc+Q31XnOFaNXr8KS3QV+kRqZfzQXPsbMFrS7wGQdSkDWFq1BIrCppCvqJpw/p0GD3YzjqbbsE9vLFADlp3je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iuCw32tm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so11226991fa.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711397671; x=1712002471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/Copnmio+r4JHJn7cH1SHr0SKFHmhJFbDXHchbZThs=;
        b=iuCw32tmWhnvpIewveu6AYiYQem76Mvuok28exwJhKuuVd9PPE3un09zFyzpvWdRCI
         TZAgsWjtKBs9iUKm9xLnRdpCeXrwLHmzTQ12WFULfOw+pLRcf7IpcXjAmu1DzvQqeWJa
         s8H0kNyJtbA4e3VwLQPNXDk32TUumk7eYDBv/2xA0aYs71xBTurLoZfCp838PSBMSuTv
         Oo5XXzKCJ5hoknalahHv1ODni1grES9CSg6/6j+6Tx8jrdqkaynTSv7IwSTKM0eowuw2
         aGtWqxcOV8O7XK07cWN8s+HEZF58qR1/aQAeA65XXbZSlyXcWWJaH/snXMGk23zF4h/w
         x6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397671; x=1712002471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/Copnmio+r4JHJn7cH1SHr0SKFHmhJFbDXHchbZThs=;
        b=a92Eb+svbDck6/+R1B427gV8WniXg5aH/MaTU4K+LZMT/6HifDHXhvSTeDLtK4o5CC
         dWOFdLNI57qZdIxQCKmGFwwZ7c47/THriegHtuZmR6hGKot4U39xO0lCAEA2YlR/oBvz
         igikZ++PF3YH6mrfc6Ff0txKyPSB2fFG+q0RSGHZF8ADljRv5Py3gBM/2gpfvOaZme85
         v5gZmzsJd2K654M/3poXubrxhvEiU2Xkmgnnzq+mKGUU/L8K9f8lkUo9rFtBmYUXLw+n
         9WeQqTlV5MurztuvwugolKzVrWpcnaeyJJdoOhHTrW0m48DNpGpKRqCxiaBb5oy1J7Hd
         wcVg==
X-Forwarded-Encrypted: i=1; AJvYcCXTa1YtMFnP+2w6FuiVhQnwek2LAF2qgHv5ZS18KIHTavV7XKavI30SibCFI7Nmdn9UCEFZWM7IudVgZnJU8RofFQ2t6qL+y07V
X-Gm-Message-State: AOJu0YxvNr2VcN2h2/0FDaZE6higskeTrKzJ2shoVcRx2aYi/iLwemdl
	V2gDiKS3nWw1dYp9GkzVxPFwdBP9FyTsEZFHtXnIUnX8NtjOszZyHxAeljO/1kNZ9YfZ+a6KkeC
	rdhQiPXTBkMqDZOH7c/zvuw+w9/nSYrS8vSvhmQ==
X-Google-Smtp-Source: AGHT+IFxfzGP4GDD9D61DOApZnzJcZ5mRVakIzo2HcSyu+da0kxkxSHBt5x0XHbve5H0YnB5oZP4U6ETJVrQilfX3uE=
X-Received: by 2002:a05:651c:b0f:b0:2d6:a2cd:bb8c with SMTP id
 b15-20020a05651c0b0f00b002d6a2cdbb8cmr657809ljr.10.1711397670501; Mon, 25 Mar
 2024 13:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
 <20240319-adding-new-ad738x-driver-v5-4-ce7df004ceb3@baylibre.com>
 <20240324130135.35f4b0eb@jic23-huawei> <CAMknhBGmM7yt1JR1tW4SS5RLGpN9PtnMrf0WvZ-bhU-gSv3YUQ@mail.gmail.com>
 <20240325200625.5a07cec4@jic23-huawei>
In-Reply-To: <20240325200625.5a07cec4@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Mar 2024 15:14:19 -0500
Message-ID: <CAMknhBHNhL62A8KY3vnNqQm+c+5M-0=w3qAWN=54FxYGjicUQw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad7380: add support for
 pseudo-differential parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Julien Stephan <jstephan@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> >
> > But given that this is a common pattern in many IIO drivers, maybe we
> > make a devm_regulator_get_enable_get_voltage()? This would return the
> > voltage on success or an error code. (If the regulator subsystem
> > doesn't want this maybe we could have
> > devm_iio_regulator_get_enable_get_voltage()).
> >
> > If the dev_err_probe() calls were included in
> > devm_regulator_get_enable_get_voltage(), then the 10+ lines of code
> > here and in many other drivers to get the regulator, enable it, add
> > the reset action and get the voltage could be reduced to 3 lines.
>
> I like this proposal a lot. RFC, so it's visible outside the depths
> of this thread?

Yes, I can send an RFC separately so it doesn't hold up this patch/series.

> Particularly good as it will keep the regulator opaque in the same
> fashion as devm_regulator_get_enabled()
>
> As you say, we have a 'lot' of instances of this (quick grep
> suggests > 50 in IIO alone and smaller numbers elsewhere).
>

