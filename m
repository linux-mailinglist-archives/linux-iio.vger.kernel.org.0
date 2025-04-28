Return-Path: <linux-iio+bounces-18760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71AA9E8E5
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55112168E22
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3011D6DB5;
	Mon, 28 Apr 2025 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOv4NGuy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82044610C;
	Mon, 28 Apr 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824245; cv=none; b=c/JPhJiUfpZg2EOfXpR0yPT80cPYcJ6+jPVLnDZUyeU0cXBvpnEHzdNXYhc75U/BLs8QvTGA6ag8Toe+lzs0nO9yd3m0qJDuLB4N8u+47vnfuFPer5g0JMB5oHTCNFzWIgLgVLDWrLmbHJyyGc4v1t2b41jUBtH5a9DvkpcGjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824245; c=relaxed/simple;
	bh=aySXpSXRWRRtP4dlGp4idY6DfXJvB6nPlOBjz2x0fls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSbvUCaNLiMc8+YB/+S/6pz03j9E8pOZhg8MpADqOsh6Cffgov6vRpAfv0DRo2Tuiu27T7/jIPEysQ5eVYjyhClhM7A0UOp/x83/+qF7I7Oc/bZGaeqHmhUaqe44220OyNQgg0T7V29r3Z7mAOIjatISQ7OZxEz15EOtDMeDT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOv4NGuy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so785526566b.1;
        Mon, 28 Apr 2025 00:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745824242; x=1746429042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqzLjPjkbpIKPWTWNjXwUoG3WgWvGtDW3UH4waTe6EU=;
        b=HOv4NGuyYOtd0S3qpT+8LHU8+jYNv0kTcbWYnaUeMgQZk/cS13KtdNYpYmDUW6VBZ2
         YHQ4+uV3Qg5bDjVk8OUI9Rq9IULG6Rk+EJNAr3db0K4jOe7TmTuDsZRd3khzpyRNs5j+
         QA5D5cZ0U/PusvZxaJ1pVp+7V3TOJ5J+4WBgyV+yTMbVwdKNpsF1mz+k1WW3LJqX/DjS
         G2d2YVZgOLmN5rsx0qc7bXYb7UqgukPcc2AnUnBb+TFaSNoGK1XqKlagO+Jl+Q8DmyGX
         JSUDI7UmjOQIObPbkQq7MqwrXdNHYlVsbSxou1w6gyiDKmYicFZB8bh9WS+C0G7S2twq
         D5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745824242; x=1746429042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqzLjPjkbpIKPWTWNjXwUoG3WgWvGtDW3UH4waTe6EU=;
        b=hOrcqxDluLrQx1cmvDi6Fp73Lxuz6pkEI+TuJXm9Ai4CpDiK81KMyn4oVafkMGTjOt
         sYWudAvTC6n85sOWVwUzGmyITcFFpEm+qdS+tRo0gcSCNmUFxROpRAXFSkTv0kha9sE4
         ox8/GI461LkH9JV/US9LD/G2Ct0KzrWF1V45ehRcoT2ECsLqHLq5JPNCbBLj0b5pxHtb
         doAAo8eK9LDxLcy4xAdyN/+pJSxg7Bfen2jPKxzX9oTLH+22c124EXGDCHZUgkHt3P0+
         sZLEJA4uy5w9XL4oU8QjMwCdFR3V36OzpFqCpuczMgGGhiIfeW4r0G8gI3QyZW2d7h3g
         eYFA==
X-Forwarded-Encrypted: i=1; AJvYcCVeD2+yBrOZ8VDLFkWTbV6XhWTaZwPVOJvwlm71xjVQUrd7t9ed9RxUxnqhCwOrF0FR8qGYnJboq6Du@vger.kernel.org, AJvYcCXaI9x5R+Sebocu/+5/mlsi8XU2Gomb8txkHyuPGksYhW3KlDq3TgiPwgAg1PHcMMhyLXU8ZBrjt3tVnw==@vger.kernel.org, AJvYcCXw5FTucRmxvnZAFWzdEb9uWW94bbmkJ3daIo27zldXnqDYuyQqVH12TqMc2uibrKLNdjx3yh1mGIs+uX+D@vger.kernel.org
X-Gm-Message-State: AOJu0YzeeQOYZ3hjEZ69adUVW+OUixZDhz267ongr3uBeEEYVagi0cK0
	1MvDtngDD/1CQ1/+muw7EbyAktS2se6ffjQ3Hz9B7o6KM2APbfo3HRQAoUhLyRuQZMwVY5GODGv
	1QMwY22EQGCZcH1PxWQrnBEqRmjU=
X-Gm-Gg: ASbGncvPx2U8rr9LDsiHaXIVSTmFWyYg2hfnskvREPwR2f7ZNkUgmiqL1FYW41spZKQ
	n3bn9uOZVdTAuELa0/w3VYaTUNy4G2ORJ/dYQltnezDPA/LV1QYhm3UlY7G4ZoAVXMJk4uOpmFz
	OH3JWB52EU0K58fD7Yv3KDHOma
X-Google-Smtp-Source: AGHT+IFRMuFZcNRNjfeF9AvnM7Bj9iBUzUeVmXdmu7ZHhNJMmpa4po14psUPiugLj18fOlz9Qi+euRe8nRR7W/lKtE8=
X-Received: by 2002:a17:907:9816:b0:aca:cac6:3ca9 with SMTP id
 a640c23a62f3a-ace71107381mr984506166b.27.1745824241407; Mon, 28 Apr 2025
 00:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745605382.git.Jonathan.Santos@analog.com> <7c308dac8869a0152c09f6218df32bbc516594d4.1745605382.git.Jonathan.Santos@analog.com>
In-Reply-To: <7c308dac8869a0152c09f6218df32bbc516594d4.1745605382.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Apr 2025 10:10:05 +0300
X-Gm-Features: ATxdqUHWYVdMPoHiP_7ikj6eXNEtH7KvpMnnFIsMTk8-_2GRl2efruCjIZIF3uY
Message-ID: <CAHp75Vc2AN0_KBDj--eaFYsQBzFJYiReXfweasuyntxdkP1Xhg@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] iio: adc: ad7768-1: replace manual attribute declaration
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, 
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	lgirdwood@gmail.com, broonie@kernel.org, jonath4nns@gmail.com, 
	dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:14=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> Use read_avail callback from struct iio_info to replace the manual
> declaration of sampling_frequency_available attribute.

...

> +static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
> +{
> +       int i;

Why signed?

> +       for (i =3D 0; i < ARRAY_SIZE(ad7768_clk_config); i++)

Check that the driver includes array_size.h...

> +               st->samp_freq_avail[i] =3D DIV_ROUND_CLOSEST(st->mclk_fre=
q,
> +                                                          ad7768_clk_con=
fig[i].clk_div);

...and math.h.

> +}

--=20
With Best Regards,
Andy Shevchenko

