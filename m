Return-Path: <linux-iio+bounces-21338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC1AF8C96
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A2248521E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDD2ECD14;
	Fri,  4 Jul 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WT1PQbZr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B642E9EAB
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618551; cv=none; b=XT+OyB1E6svT7V4YzgvdezvGih/uUfsL5tAABG6/y+FySZoTAiWcF6ZO0gwYpYFINYLjhw5YGUt4tthdhfQQBzZoyKxZyOpb7gwu/ntiKhFYtv1/W9BRyRvwe7hoeWtaRBJWL+J8l7rlGJZNr/tyXeG0mW3NUvS+re/r8qtR834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618551; c=relaxed/simple;
	bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEUubeQd0aEk64y6lnDQ/C691llNspLI6M/fj9PZbWVsOXG1g2IawSH5DRcVOxvQrDE452xc7uPOXRbk1wvYGSR+Out/iNsv4ip0iNrbMyjZEa0DMls7kEqI3LsMMYR5UZpccgnpZ3OUoRpdlcydbwDlGcz79uZCqOZrrraJfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WT1PQbZr; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b43846e8cso6421331fa.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Jul 2025 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751618547; x=1752223347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=WT1PQbZrsuPgO1qF1LG+wIXjOUzXj3bN4EZ0ZC+GnWATLCuKCtE1zhg7Q4sH75kXjP
         sDooLeu8wP18sjQCsEPxaQrUttPKVo078xPiNKzwGf5jlPy/EaEVqEk+OGPIeSO4kiXg
         IcYEESwCA7vLRTMk2VidIH5xdOOTU7zJwyexTAGJQi80H7WFpzjYyLfjE8cvteGaMXO/
         j39T3k+8TtyyntwlF5qOM4LUeh2WRRpnjbB24Yfw51Y7OcYvNvj9Zxqd6pejoKsJJrrO
         Bg247XBlCQKwFmJQQlXRL7TBRmWf5rvN+Oam+dfSvokR4dfjYUcNNSK/t254V4zpSVa2
         ENqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618547; x=1752223347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=PgTi3/A4aghqmcKMYtECazOQHJ5OrDG+U/luNSCe18EhAQuGEgUR1B06yu1NveBJh2
         ECG1/s53XuuNRVYQviq+lkpJmJWctWq4t31fMflv/kJBB/x5sHlMnJU7S1swBQcVOMBt
         NR+WrmxZhfKokfZoAnc0u1TvAbgNrfQ6vWCVaPiwox4ozrvFmU5X8ZsFpHJSVywl8POY
         6uVl0oIckjBRuww5O0Z/35VJHHusnw7qH/0li18vXKqQcPnD3CsRGxEXE6mUT/Fcl6ah
         gldRc65UFmWT2HHKrOLOw3dt2qiTlC9QC5263q4/KACCf9v54tudoUMV3TGxmdyvCMSb
         lHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7vonWKgWC/cPdhYy3DoMR7p0kgE/mmaeoPxM9h3necGDQ2Dwf+QFlq7tNGPEtlkwEYw3cWKhVqtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByP/lJBtY2dVdsEcWjPNioaHz1TsPSy+L0FxmexFopZMnSdbn
	87lnxWtlmJ2klT7SUk7az6Pr1bwwUaUPmrDGxJRPJXrZCOWBkEaSUd+R3neEe4m2yfPtua56DV5
	6gBi//vAQ51Kh/8AYwIHs35JwQX59T0+f68MT2C0qTMlM/NZ4c8K0OREVMQ==
X-Gm-Gg: ASbGncsB7HRpJMYI21SKLxjc9rfxGgLmqKhzRSrgdf1DK5j/uItXLe3av+e3sT5Y1TC
	ooNiaD8Mo4baQyjPwKvcSQyfR+bhZ4UHbKKQut8PnAxCT4XzZGrKVm+MLpGZb8C6u8Mre2F8AcF
	TKJrhWF7mldqbOvAwmOSuBJpQkcQ01JYQOWtGV66r7IqQ=
X-Google-Smtp-Source: AGHT+IEAaBTLo3EbOBke4r+Qqb8oEiI0VY9CZIrYvxq+ehJ6Nqi1uPjI7Afw/XyEmGYHQQIcPc/bUSJo+rniRRe4A7s=
X-Received: by 2002:a2e:be29:0:b0:32b:3cf5:7358 with SMTP id
 38308e7fff4ca-32e5f61875bmr6171271fa.28.1751618547556; Fri, 04 Jul 2025
 01:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075424.3219556-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075424.3219556-1-sakari.ailus@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:42:16 +0200
X-Gm-Features: Ac12FXyNCQpVK4fo6g60VvOdFC9JZ82H-ON3QvDAbIzzJ0Cs1R5sjNEchTY81F8
Message-ID: <CACRpkdbdPqHVHhTjBiLPmZ1nGiaJqm5kSa1--uMkp6OXmAprhQ@mail.gmail.com>
Subject: Re: [PATCH 34/80] iio: light: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Julien Stephan <jstephan@baylibre.com>, 
	Waqar Hameed <waqar.hameed@axis.com>, Abhash Jha <abhashkumarjha123@gmail.com>, 
	chuguangqing <chuguangqing@inspur.com>, Shreeya Patel <shreeya.patel@collabora.com>, 
	Marek Vasut <marex@denx.de>, Al Viro <viro@zeniv.linux.org.uk>, 
	Vasileios Amoiridis <vassilisamir@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 9:54=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

