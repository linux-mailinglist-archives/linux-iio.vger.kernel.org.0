Return-Path: <linux-iio+bounces-18887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4DAA3B8B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A15986D04
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB94527602B;
	Tue, 29 Apr 2025 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1XtHBp9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D12749D8;
	Tue, 29 Apr 2025 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966121; cv=none; b=nIEBIHWQxLWp7LCdFD+zgT2v013WI14/aoqtDO92intLTAnFU5Ok5swke0HvL3QWYT5wjQCIHhkCaKVznzcXBwvpBCRBdplQfXWR7xiZVYzsMGs0sfkkXjOwsMz3iUj1KK8JVnk6giAypiqnIKjelfobaoRBnDafyHCe0fOS2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966121; c=relaxed/simple;
	bh=5czEtHgcEsmSnXZy8rUpok3EBdWX/mkjP0hYJ3tUcr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFWECiZBAWNBVu5cY/KXjKUQ0NmHA3zEHD+AfLWjf0LIs9CxVp80jinnL1bu/lgueZk3w+dixH95RVJ03GSxdXGq3XrH/2Ek6eq/CJPUX7IuxAop5LNzusbNg5qcB29QrQJAs45Z642K4na9F/enOpc2D/CZu5CuH4zztfLXXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1XtHBp9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1177673066b.1;
        Tue, 29 Apr 2025 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745966118; x=1746570918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqekzJ4SHeJxJT4+4vycfLq5IoK3pSLydSXi4y3rfUc=;
        b=l1XtHBp9yRAuSQdzRxJ7ec7RO2mgjUuVf1Ke2rRdZikOKc2L6K3xIpuqMN8i5NBKCN
         HhVLOTGIfO4IWrPkUkAvvwaVrTeTBZOoBNT0pSmaHAg+cTTUlImYJ/Ljksl4pdMCqWQO
         1bpZgR9ioebj1cRPrmcp5nuKeE/uu4rt72r0FaZUgy/XLNm6a00y50t21nhXE7FzrXfA
         Uhp5gdxV44QxFwNzTMY475SxjcumYoQqxvFmw4miseEtK52MTOe2TtO/d2YmHm6sGIeY
         SY0VcVtmV9DuSLOmhpZHtCDQrj9YCuJa+ze45zNnlzLCuvVr88znDy9UTK7Qr+mUUBbE
         67FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966118; x=1746570918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqekzJ4SHeJxJT4+4vycfLq5IoK3pSLydSXi4y3rfUc=;
        b=AkbSmYYecEg4Uht1fWvYSrt1lmo8Iim4HF38Qa29aemFbsDf5wj0lEpp9gNDzk8b58
         C7RFCvNG2L94N4IAe8uAYSuVszKiCgS4WHd4bcUpqEph00s6asG7ypjWzdV/1PjfcOzh
         E9iqlRy1O5l16fImYQKgBxDuCW3aeEAto8b2ZaSYHNWCJ+XsuAkb0gp3CSTHncCZ5Udy
         DR1YgejPCuYU1+rfsryFb5/DrZgXdcttxEs2DjMuXNvpn98+nAzJowUZH3ddSgULSWqX
         Ly0L6bBbdJhhqWK7IJcAXG+I1ZH8WaTIXYjKT3jqbkBTQkc1Ls59hfMBcyX6yU4px1FW
         SZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1zq432NrWFayJgLWyCwUrEILr3/Xb9wXzvVAxuiZGrLUCGhFiOP4F5B1NHb+8KpXgeGEWpYaYzQVG@vger.kernel.org, AJvYcCVAuj1Recg7mBKwlQNZYlnHmshjYdGsgqv422bRavAIhZ+SXlLh6i2Y8xlwCOwTISkVuezwaG2+2u7x@vger.kernel.org, AJvYcCVTsz/v/mdvptPUNlqqJOqNB4fnSu6+j9tBP2jLQdmaLbYm4LxaVGyZ6MMr1yCRBKnmkUQBSqCaBTPuvxvh@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmJ1z9DM1jMkmPIAc9Hb0ITs6qC467HCyzAYY3or5v+PG/kzh
	l1DdhDMoZDqP7bLGauN195XW/LLloNNzfF7tNXv1rZybMrU3iVGuwKzlAOJ1/Rd+DsSx3exepiJ
	oC4s1TYkFNTp0K5tmZynxbdCulfk=
X-Gm-Gg: ASbGncswEAnSohrVf8jR75kNnmqEsKdplytdMS6zaX2hNRq+sxHjb3ne3ixx3fFGio6
	ptws5MVBPnOdztYjxEIk0l8J0J9ompOOlRPIihVLsNYIbbGrr+THhF/iO5YiccdZEg/7sEPo9Qb
	/dDAgq2+TVRWkEc11YkTXGvw==
X-Google-Smtp-Source: AGHT+IGniIHpBcjioY/nEHYQtjwbpfTlr8RRJkFWHLRXUzKFgDdxV3Ears/mmavtrFoXd2TxSQs1c8TZPu1UcGUu7qw=
X-Received: by 2002:a17:906:fe48:b0:ac7:3918:50f3 with SMTP id
 a640c23a62f3a-acedc75818amr119043066b.58.1745966117766; Tue, 29 Apr 2025
 15:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-5-eb4d4821b172@baylibre.com>
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-5-eb4d4821b172@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:34:41 +0300
X-Gm-Features: ATxdqUHVfqZHfPjriEXKKodfvaGABNHKrKODfVOT6j7EtuMmXA6unQ_JyIDybSQ
Message-ID: <CAHp75VfBrodRH0gW8teULNSt3f_uJA0Ze+P+YOTKLhtec84-3Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7606: add gain calibration support
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 4:08=E2=80=AFPM Angelo Dureghello
<adureghello@baylibre.com> wrote:
>
> From: Angelo Dureghello <adureghello@baylibre.com>
>
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
>
> Usage example in the fdt yaml documentation.

...

> +#define AD7606_CALIB_GAIN_MIN  0
> +#define AD7606_CALIB_GAIN_STEP 1024
> +#define AD7606_CALIB_GAIN_MAX  65536

Are those values in decimal in the datasheet?
It looks to me something like

_MAX =3D (64 * _STEP)

but is it for real? Usually values are limited by the amount of bits
in the HW, here it spans over 65 steps, i.e. 7 bits would be needed...
Confusing.

--=20
With Best Regards,
Andy Shevchenko

