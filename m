Return-Path: <linux-iio+bounces-22232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A8B19522
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332A13B54AD
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581A1F099C;
	Sun,  3 Aug 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEl+pZNA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CD1D5CD4
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754252972; cv=none; b=Wc3qXVeoDvq7TP3brpLQU6m1yerjjAikYbwmPzYU3OuOBMfi91e3lwErY37F6NGFOh8wYvgAkoYeAzUPGA2a1pcqbVo+6819zYxpy5i2uOPlLQdjAHfpLbFsXxHKTKDrLm7LdZvsghIqixVVqU0lzFvuVH5ZyBP6GB8IOWNKbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754252972; c=relaxed/simple;
	bh=LtC4bMDve9sQiJSMK6cvoNIP3MJpz04v/H2st0Ut+Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoTWHyllE9SE3BR5Vac1i4NN5aSvZEHL9PchMxEXU/aIprx2mR73XiePBn7R+PxTU+l+jieBKHIIGMEPj+ebpbH8+g5dGhuORAAEMjuV0N1zbuDRtpiK08kySOF9ZlExyTFOhu9Xcle4TwCcRdufUlE5HK8c6z8tDwD2wrS9Pz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEl+pZNA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so4518820a12.1
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754252969; x=1754857769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdiHYqxEQDEy1N9AXAAgjKikNkWoUbVbOnSi9bVBXcA=;
        b=WEl+pZNAs21M82JyL9tN7Hb/xflQ77GWmP0woxUEi4Vtm+pfBGazK0EogvM+ZapOtz
         pPS6x85FQFL92Z0/r7Rf6pR2uY33rhRhoxFFCWV0Aw+clFdQBsmW3QRa3pWsNH3rMBT1
         IK6z9Zt81VgMQshjHr9TuuQJOSQHFpGgWWLYLuDVa/Y339XKxGo76OTfGPJC86ZzFkgw
         58Klbon9sV1Ua/AJkXGeNkRjB/dMvBxWFoy05gvgJ236TcLUDhC8L1OwI7hykEyP0cGM
         h7wY5Y1c0IFX7vmStaSClRlGgnePQpiyXKC5pmGvY5+QDJHvuRdEFs1tZ5B0JP4WdIpI
         umHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754252969; x=1754857769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdiHYqxEQDEy1N9AXAAgjKikNkWoUbVbOnSi9bVBXcA=;
        b=V5c0tehfj9MlCQg2SIx51vrTD/Qv5mfpwJ1YGNBukKccod8qDHT+Tjsh0lNV7LLQCr
         YVrHgWALMwnaalH+m6qilJEERXDwy+VOeWi6fkKqHFh3E9lxHK9TayAo/wZuSZzL3sw9
         FVr2rPV8Acc0p618nQSbFm/1DRgq1QhOVv8PF1MyzAMfz8w5GijD06sheqTCBFgIYrEP
         b2x/HYeC2Jxqk9OjXzhmhYGT2n0NR7VPG2qIgJVc9xplnfecqfwu1aSPDW+b1hC4ecRK
         vxX9WSfkYOsDlM+ZhXivhzq8T7o3trm8LSoDnAAMINb56ep2qSYwM1A587/UG/j6yVxL
         XQMg==
X-Gm-Message-State: AOJu0Yw1coayzbsROYFSDKsJf+ti3Z8RQbB4qyG0t8AN/LZYeikrMZ1t
	gxJ5zWWCYXEKuikyibz06rXtv6gEjcLFzL+f09YsoyG6haTJVQsHF8FtHb4fuuGpBURR6Tpfj9+
	V5gaYa+usqJySzfThR0GnFSL/5FfWH98=
X-Gm-Gg: ASbGncua8ikVrhd7ewi26vW/kvQcpDBNlphJiS5dIRLL425BPJ74Ei09EB0uWLBiCnp
	8BBwwSe2yQ0MOGd6prwsaTXFvQ5I/czk1En2QhKsw26lAzQ0IYMynMkviAsjlCLiGNZa5ndzRS8
	8LEEtyPhDDnPIPQf5xze3RAaT1aMnEXEotkdze/AdUUe94SYFmTRBpe5oMHzs7mMB/6SAnidJU3
	Q5V7j83noDgmDpoC4GLWExsC3hi7yppjjz2kc00Gg==
X-Google-Smtp-Source: AGHT+IHm67UAzBcBKDh8qBppIIcJcxDt/Wx9ywht/fLrYo33T5hmUZJGO6FCXhiNMwl2/c+frf0Ya8FmsFD0KocyHb8=
X-Received: by 2002:a17:906:9f92:b0:ae0:bff9:98de with SMTP id
 a640c23a62f3a-af9401ff12cmr636371066b.40.1754252969159; Sun, 03 Aug 2025
 13:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE> <20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
In-Reply-To: <20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 22:28:53 +0200
X-Gm-Features: Ac12FXykkPGNvqxcwoDngCh80TNHv2FdI3Y2sxI1T-9JQXSAkB2kqsOz-pqHqa0
Message-ID: <CAHp75VfB0+aZKLmYYq3dYirQE0gXJeqNC2OkMR3s2PEzkT4uLQ@mail.gmail.com>
Subject: Re: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings for BMx280
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 4:09=E2=80=AFPM Achim Gratz <Achim.Gratz@stromeko.de=
> wrote:
>
> These devices were using a hardcoded IIR filter of length 4.  Enable
> filter_low_pass_3db_frequency settings to control the filter length
> settings of the device (as done already for the BMx380 and BMx580
> devices, even though the 3dB corner has an inverse relation to the
> filter length).  Remove an offset of 1 from the internal handling of
> the available values.

...

>         ret =3D regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
> -                                BMP280_FILTER_MASK |
> -                                BMP280_TSTBY_MASK,


> +                                BMP280_TSTBY_MASK |
> +                                BMP280_FILTER_MASK,

What's the point of this change, please?

--=20
With Best Regards,
Andy Shevchenko

