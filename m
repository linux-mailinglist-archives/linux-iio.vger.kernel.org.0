Return-Path: <linux-iio+bounces-23282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0148B35673
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7311416CE81
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C22F3C35;
	Tue, 26 Aug 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyWqIOHq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449B18A6AD;
	Tue, 26 Aug 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195870; cv=none; b=qg2qdYXX7Z4PRBhxS4JYw6byA2wsNuwzlmS/JkXz0asPrG/sZAxF4c5zOytBisRIe/cUBfvkTq39ZJnYYPGepIA0TPSxJkRUdc4gtccSnIQghoqPs2+0RuLVLW4IBpJvXcPx0Ar2DywqLD3mekNo8XvPAFfvpyKRGrP8PlGaLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195870; c=relaxed/simple;
	bh=KsddloKoUCQZm0lpBEkjLyAKdvQi4ATkyfiWQKdGr5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECpeepw+qYn13GCm9mRrX+p3SxjnV3wK+0j7RFXa9out6e7QiI6EuobvcxmUzzoQ8H5wjRieg8fC4ARPiT2Jh9ZCBdiiSWUKoGeyD8WyR7XvAoPKwkX9eRky6UfwAip80bRB0YJ2il4yhV2Ua2f1FxAivr9eVCfrDSR0AacQPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyWqIOHq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb72d51dcso723092566b.0;
        Tue, 26 Aug 2025 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756195867; x=1756800667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aX7FenfyrBV1mKFKmXZQBk55IyzLqtyKU5LAZ0/lVg=;
        b=UyWqIOHq2fEKP7bJLNPNdR2oEy8//sECThBxVuN33OANXX3HhGv6nBFTAN3ADzJwAq
         ZwiY7+fNzA76w0VDhUDoaS9d1V/aPgGJrO3qvndFbAQ+bJf/U0uAjXrXqSf/na+kJhpm
         lzujA6dGaGBKGdL8QV7gkNJ1lTRBNWVTrcYP/KrCzqJaW4fRFUlF4SWGYTxsVlNNNqHo
         a79xo/uw2BU3LB8klUeObbdaHJ9ugxy7zQOwNF/RAaLk+K00S8WR7/TGONLOhE8T7pZC
         ORdV6ZF+GvlqEjVlrCf9P4uOqh06McdKRup7xrU8q5kNNJcXUFSjnwUBfPjrpXwBwMoU
         g1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195867; x=1756800667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aX7FenfyrBV1mKFKmXZQBk55IyzLqtyKU5LAZ0/lVg=;
        b=wot4oPzGSuH8XZexxaIzuytk2bp4tA8HodlEWY+wfruifzzc6hTZlZDkDKgkfq1/YL
         4+Et3IaqQrd5cbYH2zF8Yfgm+6x481bGYeM8hARKfkUoKGtXTnRukIEPl0mX+4g5Nxwa
         XUkAC7QRfi6fGtXq5WR1kx9NOiCEi60RlCQsz0lB1z7teScfHJuFPwhC6DsCNY2/YSFC
         iY0jcl6ejD85M1NfML8AZNvVHzXcjRMN/IfK9UTNoVnogeg13VJUojR9PZNJUC71NUCz
         53f9DUkN45XicArd5k65hsIv9ppj9BMEkbDwCPQkj7/QvWwTbxqM5bpMRptaVh1j0zal
         oMRA==
X-Forwarded-Encrypted: i=1; AJvYcCUIY36aXjpFM7r/hXB8gxlRrDYoMaa7VcCKfUMN3Pl3evdb7vG3RgSJqzFdLlv55oYTZUZ1L/2N6zGXRx0U@vger.kernel.org, AJvYcCW1lwrVzy/iLxVm/K5b9OL+jbSUq8iX191GqFtLpL+CPpmkuzOjIUpE8essbXzwT9IY7fZn37LuQRa+@vger.kernel.org, AJvYcCXOjp5e4UcSnLhUrdoOLF9mJk6KZJVrGTQnPY4v0p21sSWezP+r35TFYeJQK+oj5zHZqDAnDjLQlQ4d@vger.kernel.org
X-Gm-Message-State: AOJu0YzWbMe4uN4L0aUz0ubciFypWeNvms9gyxikaknH0JlMx1V05GCP
	hxDrMyG+mKWxRWKSYCvi2NaqIbVKuTTLSA0fGbfjLk5NctsJJ2dsLI6mTot36OFKeymT2K7UzIr
	jUuS2yPbUOw2b/G6iMzdNF1IlMJEbfqaLSByso7w=
X-Gm-Gg: ASbGnct7lqi6dddkNITVqSQwBS952CGXNRfK4ycM9NW0Ry7Zl95/bKsZXlZJx+Nwsp0
	aLOjHQwOQ/MTcTSEIe/que4e5WGbDcN3xyDozCbMit9ClVR54m5UhNJxQ4lJHAbamrjvIWbyExA
	aes/HACZ/BJSD1+9L721VGjxJDKirM7YEG7R+0vM3QWYvAf9fZzAKoOXBuBKLl4THcGpmnSh1DC
	E+nt/Q=
X-Google-Smtp-Source: AGHT+IGEd1eZnHcmzpvXANGzhr1yd+oGriamqJKZ0s2iB8R/aw4f3dtalaUKYgCOlOt4g+XTgdfhCNITfaZ4EhFXlkk=
X-Received: by 2002:a17:907:1de5:b0:afe:8d25:771e with SMTP id
 a640c23a62f3a-afe8d258216mr372706966b.54.1756195867146; Tue, 26 Aug 2025
 01:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
 <20250825-iio-adc-ad7124-proper-clock-support-v2-3-4dcff9db6b35@baylibre.com>
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-3-4dcff9db6b35@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Aug 2025 11:10:30 +0300
X-Gm-Features: Ac12FXyHRa3HqDklPqwL16eed7EcWQFU3zytsF-1uM7QmzKO3PNRAwfy77ztEGM
Message-ID: <CAHp75VfBEQAettOACoSix748pu0T2D+ihie0VjNW7U1_AuuB=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad7124: add external clock support
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:55=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Add support for an external clock source to the AD7124 ADC driver.
>
> Previously, the driver only supported using the internal clock and had
> bad devicetree bindings that used a fake clock to essentially select
> the power mode. This is preserved for backwards compatibility.
>
> If the clock is not named "mclk", then we know that the devicetree is
> using the correct bindings and we can configure the chip to use an
> external clock source rather than internal.
>
> Also drop a redundant comment when configuring the register fields
> instead of adding more.

...

> +                       /*
> +                        * The external clock may be 4x the nominal clock=
 rate,
> +                        * in which case the ADC needs to be configured t=
o
> +                        * divide it by 4. Using MEGA is a bit arbitrary,=
 but
> +                        * the expected clock rates are either 614.4 kHz =
or
> +                        * 2.4576 MHz, so this should work.
> +                        */
> +                       if (clk_hz > MEGA)

This is (1 * HZ_PER_MHZ), but as the comment says, this arbitrary
check may be improved by using the exact values.

> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_SEL_EX=
T_DIV4;
> +                       else
> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_SEL_EX=
T;

--=20
With Best Regards,
Andy Shevchenko

