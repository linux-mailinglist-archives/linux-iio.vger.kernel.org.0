Return-Path: <linux-iio+bounces-21340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BDAF8C8C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BE4A0FFD
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C32EF64A;
	Fri,  4 Jul 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnG8IIrk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D962ED17A
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618598; cv=none; b=FEqxg+PDGDZZ+U3AC4/voriRmTHmQEBzRcRvQ55FJtnaGssrV44mNePVfOcxtRLcSZMwAFx5QcNmOhYLePBHxWRXZe8Gp8FpX3Gob8qhC8HempE9UQ9WrcYHrVaxI/aJcLvVK5a2uIDpE8VMFZhbc3d2DIt1wV+I6CQImBXbsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618598; c=relaxed/simple;
	bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnHqGbptQAeIzT5kSdPGPu6PaMzNg0wfLO+R02V4Ejlh1PJ7VPMPkOXitWtMbts0z/PenFzURCLhCGWAPASi7xtC4oLqAFYYi8NHMlAfpOVKhili05gqUDGsUZU8llRWMW18+hhNdstZZ+dy9oxCgiPaKxnLAt2Ih1HQM6fT7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XnG8IIrk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55628eaec6cso718367e87.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Jul 2025 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751618593; x=1752223393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=XnG8IIrkaR4PiO2w5NhZizCrv5VJ8gOFBTeeRewG/O8LNKor/464lUJadrQ1rZlljH
         iJ4ZQTIkfaa/mUxRIXa/2Ev0HsFLlf804FyJ/TMAW5MK+pwG+p3POASsRFVOIM5G2/0v
         ZRQQJ+ER5g0gMZzV/3aO0/kDeqL7KEmaIzaBd25o7QeC5FOGXJOjNCrUkHDB0cYTf9gh
         hXFF+jny+BkHwqFA9VwPAmU52AAdf+50HvxTFaMp+yfqzGeAgx/GikIG/hKyMcylqEAe
         uDareKppgpvC/0Xge1rko+itxMOrmNnNkp7ltZNon9v7CpbfO0yVAywQh4EaDKMZEszq
         +BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618593; x=1752223393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=J2ahlIQfvTKkfQ5mA5Om0T29U9FJIDiwz21gbc1v0l5tPnuPZLnEMpzN+AFfGgM/xe
         6D7rf4exxTN1dVXyQa7MjrG5F/1pWIpcDiqGXlex4XAD3q+/Vnte7UoZNruPX0bvWb3u
         NU7Vx9PNrownfj30117QddmTFvH7AF1hrprJNd/b5qZBRZPrTIRBuZ0JER49KxxHHPwy
         pHrxUfRZYa2cjAYv8kF/wT0iC7QjAiJvVvY63Db3AilNFzKUpLlTukEY6m8AgiuGInWl
         FOATERPELZ3ht+qUE05fnMpISFLYjc0jPj1eR7iaMGP2gZG7vJyB+Bejy09LNxaa+H3K
         MA1A==
X-Forwarded-Encrypted: i=1; AJvYcCWuxz1g5TUkuBnSv861NI/dyMxI9c7/GdZ1Us5Wz6z71wz1h1WyGghBIN9oZeP2Hmd2UoMxfUNxOpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0t6bKpOQH+NsOMud/byvokkQqgwVBslTOmov3nKvEfY8uVtyn
	QVaEyHZMoL6U/Tp0eiyS0lF9wClmzoE2JN4xlzveLvtQ6LMzmyVytpaESeYA8OZO02NiY/OLoO+
	ef3SZbDNlYAL0NTtallBW5C/f8elyZJVlTeqABJK1xA==
X-Gm-Gg: ASbGncur7TdmHqEIcVLpCcfSUSyE52NSM+ANbM+uEa3XWbc4BEO1xF8IKwYTfpeVza+
	E+vPbsRRQwtjQm0wGAwpTmapudT3KA/Z2kC0MmmRSKGTMmGz4emVy/WwwTWbf6X21KuvRwyF99c
	7gJcEinK7vfUj1E4hporQawx66G2JypIdbZsek1DxU5Eg=
X-Google-Smtp-Source: AGHT+IGygUbBqXVfLxaLDk54V2AN8vVvj+sifspuQseTLX5ENvM8EjcwjnY64cUuxldDodJn88Si0MNwx96DmR8ZR2k=
X-Received: by 2002:a05:6512:15a7:b0:553:23f9:bb3b with SMTP id
 2adb3069b0e04-556f2f25595mr495692e87.49.1751618593487; Fri, 04 Jul 2025
 01:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075425.3219648-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075425.3219648-1-sakari.ailus@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:43:01 +0200
X-Gm-Features: Ac12FXwoTDxBT2X9zSk4EsbKoD54_AAQBokPURktdmvdCe76XBldGoZG3G1FI9g
Message-ID: <CACRpkdZewS7FUFZZTbR3QXZ6y_MPD0g1vwMPmx2ALA3H7+H=xQ@mail.gmail.com>
Subject: Re: [PATCH 35/80] iio: magnetometer: Remove redundant
 pm_runtime_mark_last_busy() calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gerald Loacker <gerald.loacker@wolfvision.net>, 
	=?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Waqar Hameed <waqar.hameed@axis.com>, Hans de Goede <hansg@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jakob Hauser <jahau@rocketmail.com>, 
	David Laight <david.laight@aculab.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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

