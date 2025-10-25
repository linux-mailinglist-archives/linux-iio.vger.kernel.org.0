Return-Path: <linux-iio+bounces-25439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84BC090DB
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4193BEC03
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79032DF138;
	Sat, 25 Oct 2025 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5Brjm1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A72343C0
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761399316; cv=none; b=uxQY47iiX8Hs/0pDHymYT9TuaLenXD2hpDwn2QzfUs+b19tyCaz35ORBNCZZIu1LfgvY9+RkO+JiFHqpZLDi6AAtpK0hmopbsFN7Tvadilw1n6tIyXfYgBdFEzD6kSH4eu23VjYl12OHDwqAOWUH1G7FdK8cZZjWK0uDrdMWstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761399316; c=relaxed/simple;
	bh=MfijaoVY3izM3fqXrWCWyMWpoHEq2dEdD86JsySrhGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSLHOGstGINKfQyXCzGS9mWeKjqqYjdXbJ9O8lwpUkxSk4gQYZ4g3ct77aMHoYxdszt2C7ICXXIPT9I+Ouxce5d/Le0T1AoLAbLm1lKqbhjH+E2FGtJKQ8qMNJpxZK3cvU6V0HfFKOR3ZcZDlbvSI7tnzgVJTeVMo6zj8aTawTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5Brjm1b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b50645ecfbbso621989266b.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761399313; x=1762004113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfijaoVY3izM3fqXrWCWyMWpoHEq2dEdD86JsySrhGc=;
        b=b5Brjm1bhOaLOjrZZ6/NrbrSuOtLJcIweyh9gcGmA2a97zXJGo/DTaM+4QRp+kjtxw
         i31ZxTnAnhbnQR4hnKYa97VMVK+MtmYlW9UNO4/fOkyjYYQB8cBNK88rFH1kKwgowZoG
         ucLVqzmh1iclZfHBH5XyyAJuYTKRMTxju2zHHvfE88O1N7yvo+Q5wvEK+eWTFPgONBZv
         wKSa7N2Jy3EuKyNDPRwvrFhBRlANDwyV1rBgtFFzX2/rhMy8MibQc2QIiC0vnMPE5mgA
         SIF5ayGQcw6g2CvrRtVWjOpCLrToXNE2C+Lm/9JnthJvmPYMjtXKnnWneincdUS0OypQ
         z8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761399313; x=1762004113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfijaoVY3izM3fqXrWCWyMWpoHEq2dEdD86JsySrhGc=;
        b=spZZo3208N7Lsdprql17R/4CBl+3QUSWZ05YGmA2D/uJ2P2dT7jEzskdBT0pix8ylY
         RDXpucLTEUpoa8DwwaZMjV+BJTFLtxEtfpxPImZU0LyZnKABEwoEVGXJH2ccIaxOwOPb
         nFlR98izZuOee5hgFma5xWEQJwDVH29w7VZ3RxCuSTMcneqgLUqoE3yF5EsWrNiMjjcA
         Ch+rjpUZdjjElqlWQGrYGdsSA6EgKLE6xzMs3t59MGTOqRaYwuWYX8Xz43X5yQAfWmWY
         wtUkZ1VHe5emJbSS0N4RbGd3RUjJIUl4qR10DIpO4LEXtlGMGIUV8yFup7v4YdgJ7Ps4
         h2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWYZaY97xi6QTkSfx5lTqGNhmctk3fyfVh5ZI8NNqVk2Tn+ha4QrHMis3UOgW9ldU027kYep8gPp1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBH/42ze6fWDEx2z3EIRsz6nPvM1FakHSwOIu+MSduDM8aqqZ
	rE/4pLt8JVzOyYRjNW2q4rgPfBcZzOX9pvPhw4AcFRrnAXy1pnJtHeao1qsXOljaW90ooIDruKh
	AyydUnUcIn06dmnF9xwcFU8Mgzn7+5pOUj2rcfz4=
X-Gm-Gg: ASbGnculmijy6mcyotfwM9il0uwbB1Km8SiREv/y0BPFtE1xL9zhQAQU+StRwRI6lJJ
	ySES4gleFPYML8iHJr78Ge8uh4CaTPXp9Er0d3eIXKKfQ+tZuCJ35VP17Xul8ErIcbGukHP0jDe
	PLrSm7VKhyDozXh8yQwKZl50HH2m42P6+J/kMdlZknMcdhZtsRzpeVBFMBfYkf+q/cj6x0suQXp
	UhIvTuVPLifH8fT14Shot19GtfFqhJ61I0TmoYh5lqmKs113w5nJYl3zK/y7Gv9Kdff0vNE
X-Google-Smtp-Source: AGHT+IH7uZY/c9aXdldzkMbKAoJ/0i8VLLTPQXrnrc50zjlhNJvLjiDVLNrDt+OLtE1ordGJQHVqtIjtoshodf9kJXM=
X-Received: by 2002:a17:907:9626:b0:b6d:5840:4b3d with SMTP id
 a640c23a62f3a-b6d58405579mr947011766b.14.1761399313114; Sat, 25 Oct 2025
 06:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 25 Oct 2025 16:34:36 +0300
X-Gm-Features: AWmQ_bl95j0vXJ3ZD4OQCpj-LWwza_GWmiE_3yUYJYUFMXDEz7Q-UHF09K0-mhY
Message-ID: <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: kriish.sharma2006@gmail.com
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 1:20=E2=80=AFPM <kriish.sharma2006@gmail.com> wrote=
:
>
> Add missing kernel-doc entry for the @chan parameter in
> iio_backend_oversampling_ratio_set(), which removes the warning reported =
by
> the kernel test robot.

Is this the only issue with the kernel-doc? Can you run manually
scripts/kernel-doc against this file (with -Wall) and check, please?
The change itself is okay, FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

