Return-Path: <linux-iio+bounces-22689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067D7B2520A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8BD680437
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B11281352;
	Wed, 13 Aug 2025 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+xnHhCw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B75246765;
	Wed, 13 Aug 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105519; cv=none; b=c6BGvLpPWKI8KXDei7DWBLhsnYY0hYwmToDhIDLulFm16hbZC49XaZu9FlhuOSV35fW8/YJIs4vKsSJ4P1Xyi51FQqaL55FsrFIQ3myOjrr9DHvv3p+1QWI1k2CR90XI3d3Q2lkgyCKnu9gdOqIQcBnY7ZjFIYKt7P4ZRPjTxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105519; c=relaxed/simple;
	bh=ZdO3vj+x81gpLTOdoeLc9zE8DEJLrZ6F5do/Ku+TBSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxJZsbVUEsjoB3geDZrrfDoAeai9BVWyawK97F2+rwS8Wk2rJxLSqZPNyE6ilDKSS6Yux6R8O1DlCPtwjiqiHtfgvzLhuIpxKLFRcsin2H/TV4Jory0CUpZ8SkoLvYaCIUue6luFKr99+b94kOc2B3SuETj2jxHKQiszJHemveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+xnHhCw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb732eee6so17154266b.0;
        Wed, 13 Aug 2025 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755105514; x=1755710314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9cFUtAJj7xlAv9nBAyLCc5TYl6OBifBoQUVoLy+YEo=;
        b=E+xnHhCw4RAEK7ETWykMuOacselKovGY5AsEsgZoZSqBte0e0r79oXy+BGA3qLUBIa
         nxC5n1IX/utTJjeOwvxhT2R5eKHZ2snxt45Rf5BSNGoGzUvD/vL594nXzP7NdZ6CqWwR
         wTR46YeiEt6Pc0chlEio6s+dj3k0bBfIG3cVDm82t5F+xpeM7WlpfZ01iaq50DGG+54y
         dWEtz+glL2WCXxl4OYQ0nKFdUO9RWtUyBqTkDr5at/hvrsu5psbFEqS97wx+QOhT9T4i
         /gc+8MKFUP4vgZWpSwBB2MNfoybw48FgCkcglkq8z75kRMlGWYd66B2w7KK9NnJWe2Sr
         zOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105514; x=1755710314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9cFUtAJj7xlAv9nBAyLCc5TYl6OBifBoQUVoLy+YEo=;
        b=jKWaxBNnJhhR4qGCzP/T66JZD1IX77xXunFGxaP5oleIYNmXa22GgXdysjZGmBThwA
         TN2c7HsNr3qoi6IzhDqipkKINfwOuxySGPJS0qYZrauzI0lW8X5rfn56QnedKREx0dnV
         LvihD7A8WCZNiUJyLnfAOSbGGL0IHjoTcbZRBp5k/wUBdWUvp4wKi1UoqhrLeZ7wljry
         +CHLF4hn7+hoQp2Yu63DDp2EazJ74zzGMLRy6AeIjBSgV2gd492NyAIG+T6LmrU1t2Iw
         9UBP8V9E9tUi94ii9/oLcwzOWajv3+Ze+NNNpXp9QXl8ReB7Vw9Mr0EDkWFpBeonA7ck
         DWuw==
X-Forwarded-Encrypted: i=1; AJvYcCUHcKu/gRxQ7g4Vi+yQ9rX3fkzJuGG7hGp5NrOZXjNHn8gVGsRy056YWm8jhYBndzZZ/xEbv2JpPZ3T@vger.kernel.org, AJvYcCWRDHOyX7ibkovbY3fIJbpwvah0Hjk6ek3Ze5/NhRVu49jbJKrZkEc9zM1oLzN6yJRUjKcBiZlw2xxF71/Y@vger.kernel.org, AJvYcCXYL0jFJF2C8s5fMpiHlRkZVctDomrV1E6tCK4QB9nSQzfNeZ3D8wTx6En2R2vNRq/m15Tu1tJ9f4l7@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZnMBzcUg1DfyO3L/tbKX6Gii9zdrk475JGtyKVEZWbv8Ewk+
	U8kKa+PoqGh91QEg91eSACpm1TtGZg6eyZc/1kLxOHyodCl5oNEa+3/hfCiVXYu+tWbNvE0mtC8
	dHBJTKOx0uwLRXtQvs0UFsWwyrRKa6Js=
X-Gm-Gg: ASbGncszC9fI5nVwBqn2B4M8+4haekIjUZTOVoxfLJxebxTmlkv6N2f6zh4xY0aJCBm
	DJvNW4RsQBikLJWWorg2I3+Q0c8pOKFPj1qrO0sjlWVvc5H1Uo/uV1xrpV02N0C5CsjJjn0k0Q2
	QvZ6SuPABe878DI0H83ZZMF7JPKIs+KDrtqHLtdmIgVI1pA/MLOW2bYH07VtSiHNxb1Z1jlEZQK
	IkvxG6FFw==
X-Google-Smtp-Source: AGHT+IHJRX8gcbrpt6fHwXcSzar55gkLr4CKmHsuuvq5FOw0YFxGXD8cf9KgKZK/ajb0i1C82kDqzCXjd2pxQNmVLXQ=
X-Received: by 2002:a17:906:6a22:b0:af9:237c:bb1c with SMTP id
 a640c23a62f3a-afca4e7c1camr410625466b.43.1755105513755; Wed, 13 Aug 2025
 10:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
In-Reply-To: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 19:17:57 +0200
X-Gm-Features: Ac12FXzSXyjK3LWLAixYn4dav8CEFlNoAdUe5OFp4hPJ228WqnbJD-U8MYY6ZPg
Message-ID: <CAHp75VcmNtLD+ZmjgLsV0xPHOZkRwRZW0-dnKYa2JhXxYpHc4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add LTC2495 support
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:54=E2=80=AFPM Yusuf Alper Bilgin
<y.alperbilgin@gmail.com> wrote:
>
> Hi All,
>
> This is the v2 of the patch series to add support for the LTC2495 ADC to
> the ltc2497 driver and to enable the internal temperature channel for
> the LTC2495 and LTC2499.
>
> Many thanks to Andy Shevchenko and Krzysztof Kozlowski for their
> detailed and helpful reviews on v1. I believe I've addressed all
> feedbacks in this version.

You're welcome!

>       iio: adc: ltc2497: add support for LTC2495

I'm fine with this patch...

>       iio: adc: ltc2497: add temperature sensor support
>       iio: adc: ltc2497: reorder ltc2497core_driverdata members to remove=
 hole

...but these two need a bit of work, I hope the next version will be final.

--=20
With Best Regards,
Andy Shevchenko

