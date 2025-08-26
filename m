Return-Path: <linux-iio+bounces-23280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA4B35208
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 05:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599007B1F8A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1C2D0C89;
	Tue, 26 Aug 2025 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyTeG+Ex"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF261FCE;
	Tue, 26 Aug 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177356; cv=none; b=fMP0rc7tr8k8fZJVEY3/B7bRdfB8iQ58xrSSuXoI3sKy/A0nGwVc2da7sQ0O+MFlPRfAfKL64NQXoUxRYjU0VOvvWoF3r6zxQwyxENI6dSJIqh5IWFqvx5jpBQojxiFrJ6yiwrpJ0Lc87Q0joQ1pY+H2PVyaAi91+88hgMmzwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177356; c=relaxed/simple;
	bh=U8rBJyGf8GXPaCjvrgkI7qdOb15TPWdA2f3IhbOFDCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/bcEAdFfYFAqtuiEs3boqZkA5e5K802CBwODhVTjg5yEN0mdpllkp/1t/1ceFj2jjdjPM0XWtfgUuL1SF8IeLvMonwEwFQQGRfLQCdE0BjzJYzCUmNH8ADmPCgu9LFt//3D+WK3ezEeTsdrwNCgqdS8lXhid+52dhjOkHtZuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyTeG+Ex; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-435de5b2f29so1553536b6e.0;
        Mon, 25 Aug 2025 20:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756177354; x=1756782154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U8rBJyGf8GXPaCjvrgkI7qdOb15TPWdA2f3IhbOFDCo=;
        b=VyTeG+Ex8xnH4QqUSzNN0mFfYsXnKL/MuKfUwy9jOurTvpJCfVJ+4ki+l0ny77mHj7
         oMjQlHjPr9Eiq3hP6LnAhOIiww+j0qlsqp+4oEDUxZNZD3kV7QE+SAx3XvT64AlqdNEA
         p4QC3naWtl7Pazy7Iq/B2NHkKvWSpuvH2BS/fjdkIGAB0+d5hRydJQAopERJ9/lcdM5x
         DtLQ4gWg7ZCYXyRJYlq7YKLG0aoQ99R10JAbVWJuz6pOCnWcoS3m4LDknEhdlFoKsDf0
         JLEZmlBuygmlz/B3LW8fuPtxlThHQqGYb+SNgQuHhpXfFtaq/Bjg3fGq5SLIUNUgKKKY
         8+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756177354; x=1756782154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8rBJyGf8GXPaCjvrgkI7qdOb15TPWdA2f3IhbOFDCo=;
        b=BhZUhcqx+EG8jF9hoP3cekqRFOlbkUur8fbxxco+5PFFNQA0xbkELIDI8aNv6Ef4zp
         1SbiM0f1ybl/Z8qXAp4An8K4HVbLMnibTXZKa8oY7MYokbQOYDrHX+8knbG5Qj2zRVQn
         L6BXA9dLkgck1uuybF01r4VJtn813K1D3goTGlxiuSlu+f0Sd8CP3dSi4+prmk7qEGpF
         pnZyrKJh8qT8r7BQ2DEFfwlR0xx8UL1XrgZCLOzGhecI1+SumiwEMhbMQtyB7HjdYBsN
         PWpFDjmFgbC558RfOEZUuggeuWRHc6UJ1prhriao1E5Qhxk9FMaGLKAx/lvBRdGH06g5
         FJNg==
X-Forwarded-Encrypted: i=1; AJvYcCVKkjPHgWmZMgLZEYAYr2j/k/XG3ZXjeWmk6nXwKw9X+tHx+KVdL5DXoeANCjwhDuwiHx/282rb8kUY8aHd@vger.kernel.org, AJvYcCVjfA3ZjCymNJ8Hmdj52POhhdbgm0miPELADhvGx2/h0eD93yXiZN+GdvfjkhEF7tV/PdHShjzzSimu@vger.kernel.org, AJvYcCWfsd8vMb15uH19KM/cM8vHMFZiwXLXnzVPPkJY1ofy+2XN7hqsCDw+Ildd9M2mBpaXz8CgQQh1pXLp@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlWcg4kqztsAIZjnaw0sDVF6yUpgXrOtJmnRoSmFqhuOOZWXp
	eCch1GyJT7gFEJiRyOzSf7FTOJ8n1crMRdZ03I2psXqhcoszZ8ht64xNNxWvivoJv92EWRecNCG
	mA8gdbqpr3LLb5w9dVuIlFIS4eXphi1k=
X-Gm-Gg: ASbGnctS+T7OeL007+nsqrK6nS2VcNoQVelAeUy8GcVy4EO0rlTSh/ISz2q0n+OxRSq
	MMw2PxseyYWdeRkSXC/O7Nxgjvt5hA6Z0jvA4idz5+INMB4sMbmKZdc5MvMaItdw1bzJ+LDKm9i
	GIV7YLW6IHRn7t9H3mba0F3O0WS0puy07v0mPD4SXlfk1ri3c9yfBVSKJjqSmr5s85Nh28bFlN5
	KdVNB+NMcCCR5gEUnwHL2eZKXU75UMpCL8BSUs26jQ7/XrHNLhmlA1fITIswDI=
X-Google-Smtp-Source: AGHT+IHA5O78msOaujPEgXdw1N91FZx2RrIENAozLCuyOUO61bIxOqO/5wgiJHuUEaII9/Tae5CTlIvPpxkLvqW2zfs=
X-Received: by 2002:a05:6808:21a5:b0:435:94db:5d66 with SMTP id
 5614622812f47-43785191e6fmr5914094b6e.6.1756177354223; Mon, 25 Aug 2025
 20:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <aKXW5pGiN18DyIZ7@smile.fi.intel.com> <aKaMPMnGRyvKqTny@dixit>
 <CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com>
 <aKfYlP-yWdQi34db@dixit> <CAFmh=S0gAB93Gqnrt9NdtLA=cjOcYwy6+ECnwH-j9sN_sZYjZw@mail.gmail.com>
 <20250825105032.45f33b12@jic23-huawei> <CAFmh=S1hdCMnWYzHsvTDb4C1vvinMCeG_=1m-N+psw5tp4nm7A@mail.gmail.com>
In-Reply-To: <CAFmh=S1hdCMnWYzHsvTDb4C1vvinMCeG_=1m-N+psw5tp4nm7A@mail.gmail.com>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Tue, 26 Aug 2025 08:32:18 +0530
X-Gm-Features: Ac12FXxpQ5CCC2aw6YeY4uuv2OPPM8OX2_zm8E-c1eG_XN_XsuphyEMC-YiiHXY
Message-ID: <CAFmh=S1KtqOa=4FRojE1ndttv_pFu2aLJwzGFbam1CJxoYtdgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jonathan, Andy,
One more query, Do I need to update the MAINTAINERS file with this new
entry as we are adding this new driver in this same patch series?

