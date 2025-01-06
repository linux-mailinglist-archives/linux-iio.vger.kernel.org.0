Return-Path: <linux-iio+bounces-13941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC3A032C8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 23:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8686E3A3333
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86C1E048D;
	Mon,  6 Jan 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="liqesWqi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA31D89F1;
	Mon,  6 Jan 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202863; cv=none; b=PSlaWIK3npuA7e1949UochZnsEUQbAjZ7+knbCYk6GxfkHx2VNX4AgZnt57v6PkPDW/qJ6e8X4cefLgC4746z/CP7W7zejIFSAKA/4wt0uQ7Tk5rl4of3dyaTTWF29bbXWhNnfaroPEK51YKZD+AeLrPlLddku2E3oD6n6hRCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202863; c=relaxed/simple;
	bh=kTZNAAQATgjafL0+cNMfQi7UWRyLhbXVq2LoDFgRTps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSMcO53Uq6i1ngvJWPzCZdBGYlUtrqvSJ2kcf2xO+t4arjYpZlUl98AMZgmzHvRlQgfxLZ3RlNlDq3JvqsGAPplxjPHqthRy/mfDojn1r02ELz4nnBJTBD3rJoBIn2Nr8eQui89Awqtr5fjgWwxaKaSFQtGJrshE0YWM/i93Bh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=liqesWqi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166360285dso218253305ad.1;
        Mon, 06 Jan 2025 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736202861; x=1736807661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRJ5zQMdFgK4dAX2MgR2Lkjmxo4dchPiAv78ousBkGs=;
        b=liqesWqijaRpkoUF/d4PF9ILxcorBAnLf+1cpUbnSaiMvycKPEmDV3VJu/SLEJ9mKu
         fwNB7pvGgurCG5wl5HR435e5rLIs340L7SnCZu37Rcrwp9SLvK37Tt1f52YBopntTJYe
         SAC+aUS3vcdOOmvLd8e9sq/XarqHHHe6LFImBHayGJbtsDwnrnv3PrNrSJEQ5ZP0vTEC
         V+0IuAVAHERfib6TJwrEh2jDMjD2dWq16ARzFWgjCCXHSZ1kQ75gKFbL88lmkyhvU/xi
         ehd1vU6fuLPOpzoNYQKHYB6JzzqYmscwIg4P2KLHyI74m+8xhBe8oqDNThvCyGbv4wtx
         DYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202861; x=1736807661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRJ5zQMdFgK4dAX2MgR2Lkjmxo4dchPiAv78ousBkGs=;
        b=XrGA/I656ifV+qnMf2hOVynOgetSX+ZwQDMiLeNG9gLVC9AsNP6i4Un8LHUVYErQhU
         Os573Z7zOOHX5RMqKfSb4Ha2rL+05S1cO32Aswe6qtyLy9ruRFUXF8T4Gz3ZUsDC1IvD
         sxCIontCOXHM5MLk1wFZIFPrxrP0OktEukFIZcEk/F9aDgLxPmngeWKULxvc2AoO50p5
         71uxT9PuTv8/w4Nem9aKQkU9waaKOVB9jdUZqb0KKkPnubxuORBpazsA0QPGKAmVjPGz
         QBO97N78L0bNy04/H89VWTIlLbMxR7IZFiPmFppbUYz9UZw+N47Q67zqc4pQmkpRSHPK
         o0FA==
X-Forwarded-Encrypted: i=1; AJvYcCUEiQduJw7sIBjOff8ZzSwrsjrQZQJomPcaP3JGHrjx7iCAeB1kD9YW6aFKN5VByE7hxLZCJJxhnikjJo2i@vger.kernel.org, AJvYcCXHT37+6FC9RIJztoy4F/H0Q+q3Ph+k1X+FWT2iMJslXN73IF8YsmSAsfxhrePv4WrL/Td2NVIlT4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2wNJ0/b5/tawpsIZal33XEuYMTR6jxg/9VEyS2Z3TkgOuk/u
	5H5g+llyvc5deauH6tQ1lBo4hGdgmR+qZGuxDkQfAYScSmm3251SuobUuXh7Yluypes+aXy5Z6Z
	pRgfDlvgH77iY08CERDCdyFy16OE=
X-Gm-Gg: ASbGncvlNkePtMyW4nKNgGBifUyPZqjcgrw2Z0HCa+zWzkTWmF5Bq2hM/w0/SIMyNkN
	nXRi3mozpmBdNjkm28C3pRPnX9fETjuurH+F/zby647VYWxsJZQutV/pHYAo9qoaUuIpPlZw=
X-Google-Smtp-Source: AGHT+IGuUWgHSGN1lA/AsRYmUZDFO+rvMP+cWksOszeiSFwoBDZhKmY0oZmSfEmHnYRQlzYmpGLf37XLSYew5ncL1FQ=
X-Received: by 2002:a17:902:fc50:b0:215:b8c6:338a with SMTP id
 d9443c01a7336-219e6e85ccemr917173095ad.4.1736202861119; Mon, 06 Jan 2025
 14:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com> <20241231194207.2772750-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20241231194207.2772750-3-martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 6 Jan 2025 23:34:09 +0100
X-Gm-Features: AbW1kvaztPL8d6H70jEb3XF9EAvFNAZiRKy1VNxPZvUwBLqrgdTHWiSR8CCcvyM
Message-ID: <CAFBinCCC54naeaRj1ZvRDk6ha-sV=XhNrD8eHUjr30_87hViEg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] iio: adc: meson: add support for the GXLX SoC
To: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, gnstark@salutedevices.com, jic23@kernel.org, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	christianshewitt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 8:42=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> +static const struct meson_sar_adc_param meson_sar_adc_gxlx_param =3D {
> +       .has_bl30_integration =3D true,
> +       .clock_rate =3D 1200000,
> +       .regmap_config =3D &meson_sar_adc_regmap_config_gxbb,
> +       .resolution =3D 12,
> +       .disable_ring_counter =3D 1,
> +       .vref_voltage =3D VREF_VOLTAGE_1V8,
I just noticed that I did not properly rebase this locally.
VREF_VOLTAGE_1V8 only exists in a local patch of mine (to be sent
later, I assume Christian also has it in his tree which is why it
wasn't noticed).
Before this can be applied I need to change it to 1.
I'll do this once the discussion is over and then send a v2.

In other words:
Jonathan, please don't merge v1.

