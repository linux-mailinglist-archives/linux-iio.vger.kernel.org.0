Return-Path: <linux-iio+bounces-2347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A85184F9FA
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FC428FDE6
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDDC82878;
	Fri,  9 Feb 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR2lZzsv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B07BB16;
	Fri,  9 Feb 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497147; cv=none; b=HBa9ozWg4uFVzFgk7FpDllm4lwZJUzisjclBC4E6Y1HGuDY8qBoGit5SmwKfxjeIE5iZ4DgB94JVUSkEcq041bgy9Yh0nQjB/n0gfrB1GGbQBvRjrp18kgI3tMPnmO0WPURZCdBZGdYU4tIRdkNtAUkjti5JOuUMRix7uYgvnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497147; c=relaxed/simple;
	bh=KGH5OXP8EbvTmHw25GrldAD2WeRQUqpcbMrriiRUIKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAGhP03Onw1PJfhl3RuX6oqTwEh/8mc1aQ7kuM+6Mp1rUJovtUCIbljog/bhiyPbEitmQGHywwpCpTZtwz75GFgkRiraXLE1FmyL476xqUbb/bdmBrgZcObknCOxVCUQ6P1FuO7cOXv7yQQfiHfrZuDVmJZ/EaYx3mdnE9Lo7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR2lZzsv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0a0873404so12637201fa.2;
        Fri, 09 Feb 2024 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707497144; x=1708101944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+yYyr70UKV2DkHopnVFh+mCvqXDfbCeLVfwKeuwJcc=;
        b=CR2lZzsvFoDhOvGLm3wyA9VML8r7bEYY/WA6afTSTvzOdXG9WlBhapN8rLH26pYrZB
         t3EqDgID3e6rIUyOJ2urD7vOExkawXO2w567CkuBAnoYMxuM5lxcjMJSKNsDul+3BvOO
         JFmL/PB86FtoMo+X0rv8oPkIZsWvC/BKeaZpZCxqAS66Lp5nM09CcyHU8IG9HV1fBY8f
         3nHT6atjhR0/UnskYa7L3qOssEqfZRg42OWTZH6hep6twYhRu7z+d8Ee4M45p7bx4JNs
         wmLiQzEG1qDpgdRaxmftZORb00zPuHZ4fgu0FvvwlsG39LmOflaQtPD9x3dRpLWaXrHr
         RZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497144; x=1708101944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+yYyr70UKV2DkHopnVFh+mCvqXDfbCeLVfwKeuwJcc=;
        b=I9bOfaEwJel6wiegO0LQnVHWVIuuK+P667GxcgPTd7uTgxGa195cNq/7wSVE5TvoBE
         qz/zEvzzPBkWmG1XN3gaiU0R3F1K3xmXpG8xWJGpr/4B8BEZ0l2SAdIVBSz2DWf/q1n+
         ETsSWkO1tMVXxQDcV/UD4tPLQ5HjP8MNYfN9FOn1ckAKUn5EM7uIJuO+/w10qMipvs8K
         bLT7pES/tZ10rHre/Bve9rjNRs7bmt6jruMaWgJS51ln0Khdjvyt7NDXSczssm/wykI+
         4Ldjnt53mDqs2OTGcEx9Ol9cQWfo82ZbEXzdAF18uFz+VGIoKCymRkEwC3Y8JiQEKiWj
         sIZw==
X-Forwarded-Encrypted: i=1; AJvYcCWoKI4smazUFfpU6oHpmhqxk3EwGwUIkLYz4indAlHzcepqbRizE/I3yOaQeDErVvHfj2RhRfi/2Ogd0YM0pxz8PtHdc++tXqDFHQ==
X-Gm-Message-State: AOJu0YwmTdrTMyON6pBN/U57uEw7N2xXfJI7GJQGNMsOFQDvu+vRtRdy
	jeEsFkl8kXvBb6OarVtj1UA+o+5IypGe/iR+18mfviRnclkeeJ6VQWsxQpOqlBR60tWxHlQu1SP
	+k92kp0qm0dD+VOMyswalbhwoy/lorfWMDYU=
X-Google-Smtp-Source: AGHT+IHnBS1yK9r1wjZuIuUaP0HbxNbqI+X9ixPZs5tjP7CSv3LvAWOcXFdkLMac4Mb70plo1+ddeEvLWmj7vfONT9Q=
X-Received: by 2002:a2e:a787:0:b0:2d0:9b1c:648f with SMTP id
 c7-20020a2ea787000000b002d09b1c648fmr1966315ljf.24.1707497143855; Fri, 09 Feb
 2024 08:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com> <20240209-iio-backend-v10-7-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-7-3ed842064318@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2024 18:45:07 +0200
Message-ID: <CAHp75Vd1KkZHFon205O8sNF_zo6G5-m1vZNpnZZNr-V1CTP_VQ@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] iio: adc: adi-axi-adc: move to backend framework
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:26=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wrote:
>
> Move to the IIO backend framework. Devices supported by adi-axi-adc now
> register themselves as backend devices.

...

> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/buffer-dmaengine.h>
> -
>  #include <linux/fpga/adi-axi-common.h>
> -#include <linux/iio/adc/adi-axi-adc.h>

+ Blank line?

> +#include <linux/iio/backend.h>
> +#include <linux/iio/buffer-dmaengine.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>

...

> +static int axi_adc_enable(struct iio_backend *back)
>  {
> +       struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
>         int ret;
>
> +       ret =3D regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
> +                             ADI_AXI_REG_RSTN_MMCM_RSTN);
> +       if (ret)
> +               return ret;

> +       fsleep(10);

Would be nice to have a comment that probably the datasheet defines
the minimum timeout for reset. Ah and you decreased it 1000x times,
why?

> +       return regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
> +                              ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_M=
MCM_RSTN);
>  }

...

> +       expected_ver =3D (unsigned int *)device_get_match_data(&pdev->dev=
);

expected_ver should have const and you can drop the casting IIUC.

> +       if (!expected_ver)
> +               return -ENODEV;

--=20
With Best Regards,
Andy Shevchenko

