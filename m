Return-Path: <linux-iio+bounces-2499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870738522DD
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 01:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D841F23E5E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 00:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03913181;
	Tue, 13 Feb 2024 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aHElrfrF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD851374
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782556; cv=none; b=nuMjoriQnlg7hF67sv3/KE8Lq6l/ZogZYpyeiVSjkXPFuCjnZ/tBGi0yA46H8PsUYT3U8s/ZYwze7yiFSIr62if4xjss+W5brr1OLj3XuqMdUIMz16Lb8KWFQTH5BWTjSqjEHiCGdG5U7DuJP+1p8Fnsdxoq0cJ4BfQrLyd6uKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782556; c=relaxed/simple;
	bh=OFPq/PoZZD7Aguuzbu5jk4coBRYJtpNv3Z4qTZ3NP8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkkS4r/18NtKRpGYeclE25eEn8EKFMfYnED9lro6dom0AG0nV3cU26m/grGmZcf6smr524RE9e49GcAUnj0FeeLOozt5pE6NE9yxJ3mSzCuk5To6s/9si5RG9y77TPP40L7H/ToG19Zr7TWeMssqxf6Vqi3Tnv9srNpRjMa3fZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aHElrfrF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso52275871fa.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707782551; x=1708387351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihmkh5un84FRoNuAfZ9vcL17jtZqCY6EAIHbD2B2AQk=;
        b=aHElrfrFUDgdHdvapQeST55WrYM+/P4SR/AdHsN1b3RTofaeorksHPZlJNrRpoHlMp
         p7flB9iHdgq4IvfncdHko0iRuL6nIrdxOuBR+PgBVwKvQw6flYMGODYFeuUOiwDnr4hZ
         EjHyNiV2ivBa3+gMm2LEOxp3X1uUcYzzqNor3vD3tWhl/wkAE/oOitZEVhbgATY+44Ef
         i76fNK8qv2+1gRrpBClZHQektSAWHhxy90m7mEFjErtfiwtrNfh3ZqsWkotBxu4p7gD9
         ZX2LZVWuxWVKWpbZ+1SGm9n2pUVXeHMpVr/RfLh5GLWERCN5VHB7fmJA4REQqdZwjLEK
         HNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782551; x=1708387351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihmkh5un84FRoNuAfZ9vcL17jtZqCY6EAIHbD2B2AQk=;
        b=DNtu9awUbS6p/rxsJSlG/BiQeCTzn6fIx1yk4VMC5uZwNbW2xfI00lva7z+L8dc5F0
         HWZdqkUk3ujYRIvkQW0etlMmXg73agpY/iYzWH0zQn2wfxsKzK9AXUepMqX1pG0gTlVI
         9UC6PnCS5YoPhU2hBnTI4stykF1AgDxC+2HyZPUULfCJPlSABgiMZUozNl3JGDg5DXRG
         p4xghgpZV8Du34aAg9To87mtz1F8ZVkrhyhQuj3X3YomHxPa1FPHLXDqy6bNxTVDCOea
         2LakSw66+IwNzOganv3l+NV/be3ELsZt5Zb5dLYMVVGXGgQeTRUgQ0aqRdhDZeDk2n/X
         Mzmw==
X-Gm-Message-State: AOJu0Yx6WEMVhFwbDZ/UksG6pHnzSNsiG+QMmYTR8NWzdcqgtUP/iePD
	9Mla8O9R/ocWKLOekhErmozuYmW878To7syO2FETs0t259wDkS3NgUiW/OtmIJRYSYvO0UobOdX
	An3yPnyaX17RIBkYLvkfnAoSP1f8aL6PDIu1WlQ==
X-Google-Smtp-Source: AGHT+IF5xwBN3o55yRhE/5jJFyF6eST75CUw4vcAlVY2YAUVO6i+Gyl4O2OWxiswbT88gJgkL6Ha+7XeGsx4dRFEmxA=
X-Received: by 2002:a2e:9ecd:0:b0:2d0:de71:935c with SMTP id
 h13-20020a2e9ecd000000b002d0de71935cmr5745395ljk.0.1707782551230; Mon, 12 Feb
 2024 16:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-iio-improve-define-dont-build-v1-1-875883bb9565@analog.com>
In-Reply-To: <20240212-iio-improve-define-dont-build-v1-1-875883bb9565@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Feb 2024 18:02:20 -0600
Message-ID: <CAMknhBGEKJa_q2MD1q++mTAOP9SrJ_WVJv_CBP+s_8PiBgz2eA@mail.gmail.com>
Subject: Re: [PATCH] iio: core: make use of DIV_ROUND_CLOSEST_ULL()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 3:07=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Instead of open code DIV_ROUND_CLOSEST_ULL(), let's use it.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
> 1) For some reason IIO_G_TO_M_S_2() does do not a closest division. Not
>    sure if there's a reason for it or just something that was forgotten.
>    Anyways, I left it as it was before.
>
> 2) This conversion could actually be required. In some experiments with
>    it (in a series I'm working on), I actually realized with
>    IIO_RAD_TO_DEGREE() that  we could have a 64bit division in 32bits
>    archs. I'm still not treating it as a fix as no one ever complained.
>    Jonathan, let me know if you want me to send a follow up email (or v2)
>    with a proper tag.
> ---
>  include/linux/iio/iio.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index e370a7bb3300..3ebf9fe97f0e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -10,6 +10,7 @@
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include <linux/cleanup.h>
> +#include <linux/math.h>
>  #include <linux/slab.h>
>  #include <linux/iio/types.h>
>  /* IIO TODO LIST */
> @@ -799,8 +800,8 @@ int iio_str_to_fixpoint(const char *str, int fract_mu=
lt, int *integer,
>   *
>   * Returns the given value converted from degree to rad
>   */
> -#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000=
000ULL)
> -
> +#define IIO_DEGREE_TO_RAD(deg) \
> +       DIV_ROUND_CLOSEST_ULL((deg) * 314159ULL, 18000000)
>  /**
>   * IIO_RAD_TO_DEGREE() - Convert rad to degree
>   * @rad: A value in rad
> @@ -808,7 +809,7 @@ int iio_str_to_fixpoint(const char *str, int fract_mu=
lt, int *integer,
>   * Returns the given value converted from rad to degree
>   */
>  #define IIO_RAD_TO_DEGREE(rad) \
> -       (((rad) * 18000000ULL + 314159ULL / 2) / 314159ULL)
> +       DIV_ROUND_CLOSEST_ULL((rad) * 18000000ULL + 314159)

Is this supposed to be "," instead of "+"?

>
>  /**
>   * IIO_G_TO_M_S_2() - Convert g to meter / second**2
> @@ -824,6 +825,6 @@ int iio_str_to_fixpoint(const char *str, int fract_mu=
lt, int *integer,
>   *
>   * Returns the given value converted from meter / second**2 to g
>   */
> -#define IIO_M_S_2_TO_G(ms2) (((ms2) * 100000ULL + 980665ULL / 2) / 98066=
5ULL)
> +#define IIO_M_S_2_TO_G(ms2) DIV_ROUND_CLOSEST_ULL((ms2) * 100000ULL, 980=
665)
>
>  #endif /* _INDUSTRIAL_IO_H_ */
>
> ---
> base-commit: bd2f1ed8873d4bbb2798151bbe28c86565251cfb
> change-id: 20240212-iio-improve-define-dont-build-c0f9df006f85
> --
>
> Thanks!
> - Nuno S=C3=A1
>
>

