Return-Path: <linux-iio+bounces-23428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2600B3C815
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB741C81261
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 05:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC912737F6;
	Sat, 30 Aug 2025 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7eAq1r9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AB2367A0;
	Sat, 30 Aug 2025 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756530199; cv=none; b=gR+J8rHU+7WsFz25vx2E3QRqU248Z03A5WwxN6/iclBLGQ8fiRssJ4K+0uFMy24HHzAz88ghOCVv2sYptQ8q3c5mpHy0w4QJh73hl8VLSznW2vIEQ718BRf3F11Om+VbrpFYh3/u6hTEw8Q09/tPUGjWdJOlZdglf3dVRBGlGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756530199; c=relaxed/simple;
	bh=wYUl4DeNulG2nYtPa7cq5JFPrL6inxtZESaOl5w2q0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLT5WlK6Sy0f3lsrLqFs7ViVZ3RCmGfNx7Jg3nUXxVNm41rSG8EjHnBPNYxEWOXG6018AwO8c0LVlFg0Xup/feUUW/w7zSIOFVMoRYCbL59cVvqHg8g16eGnREJ2+osw1RSlvbebJu754fTjYo7gAnZCwNXd0MZp+a8e7V9HIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7eAq1r9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so383261566b.3;
        Fri, 29 Aug 2025 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756530195; x=1757134995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y83Q+Ok40+eVrTvGcNS2tSYv/8VFYqrlbD0JuKTjJ0M=;
        b=G7eAq1r9feOztUYFRmZBHehlurwKIDO5lAcGCZdlK2SSbqot+iWWJ2905y+M7mkfwd
         LXNoiAUGJ5aTiA7qPgOtk/2+DcrfiM2ulNQQMQxF0r/2OXo03sQE7jD+Waa41sF+A082
         AeUAaN5JUvaCPC5tHj3We1Yo9OA4SU3kVS0StM42pT0wIVM2Op2VFojoa9n8CS+ew+YH
         8bQXw1igH/0xOGIvnDD7lcwsZr4Q6OmSb0YDD29UV+xnxxWffg3dC5w5CgnHJhc7mIng
         VCIrKx1Jocpt6rmgO1/3pjIjxWL/1CC0Ngnlg9nZkCbQHx7EZR6gbiWKOB2zo0tPQhbz
         8v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756530195; x=1757134995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y83Q+Ok40+eVrTvGcNS2tSYv/8VFYqrlbD0JuKTjJ0M=;
        b=bHlgR4Cm76uTnypngTWfc0cruuFQR+Q/0bMNGI95uch9Q2rl2mb8NZdcK4Tz/w0TT4
         ydjz1zuZ+TpzlLZ+4WCr8er4xNMo2hOxkHrp91jETEKEgZxV9ElsyhLav5bZEQgKk/Uh
         BJTIasfRjetTuX/HkclwMhD6CNEe7seijrjubq9teN4/7B2uXXaw+WSiAMywMXVEhj+I
         8r50pBnVVy1yWsa9UvA7RV0/2IG2lI+nD3nhJsq1iQCp9YCKAQSnskVM7P2b0DMLByG0
         6q+GFBydoo9Pw5NtGIF9HD+hi0BphLX3JuFOSb4MAknwy/phdj5BNvOnpgmkNdOkcg7P
         3p7g==
X-Forwarded-Encrypted: i=1; AJvYcCVHxwE19RRBlUizqnEdMvG/vNCgOvXUmk1bkqX5Xfz/eqm4zFlNl+SufsNmUzgc970AnAtftbRrcwk4gZay@vger.kernel.org, AJvYcCVbzHMOcpvqH6T+6MItlLORZjWP909IEYJlWe+Se6kCp71NOtDROofvgfbjOr/2I9+UtiZ6h+7De6DC@vger.kernel.org, AJvYcCX5JsEcqKz5WB9mybzuQq2GvoZaK8DMgM4SjHTw9R00whfVAVqhF7JoyZSUCHX8GrPkqqdmMmgRRo6H@vger.kernel.org, AJvYcCXcKeikVc0hT8Z8kgMdClTVelAcG9uQhx9ccZwnXVbRw5RwCT0VNbcwgyaumuhsZEdhcH/qrz41e8ZN@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBNsFvTQUe4ECYPzKzKwgv4dDlIRYA1V5ebmoCoKevoGmYqpS
	mza9UctKeYA3K8Ue1y+ZdSNhwd3Ziaz5x9x10IcDr7PuMr92+u/0q03GaS2+a4SuxDfZlWwPLpD
	EEN159Gk4HFiyKn15TFT31P76Xajv6wA=
X-Gm-Gg: ASbGncsFEjbiO47/aGD3VMPPvFrgJYDqKE2b14V2ySCsNTlyH7jhumLGFnC5GmdXbXG
	9LW1NCt/++782y5BccciEZCmKB3q15jmbY6s/gniKEXipJ63h2GQdNw6SRKs1JZnxaFixEthY+E
	5SMqrPrNKNZCq8OQ6awiJNNmZDAmJOFr9PE6WXWGNi03RNNugZ292AH77PIZvTtzLA5NuouDAEw
	gghyTS76HSEeQbNJQ==
X-Google-Smtp-Source: AGHT+IEbkBkrbeSypy4h9/1ADvznSwJLckuiapfmo9r6+CM2U9raJzZxBYhhviTWMbiVVRUnx2QJqF0QdhkSXsG8LIg=
X-Received: by 2002:a17:907:9815:b0:ae3:f16a:c165 with SMTP id
 a640c23a62f3a-b01d9732e2dmr93973066b.31.1756530195102; Fri, 29 Aug 2025
 22:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <2410525339f56466fa566dda367678ec92f9fb98.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <2410525339f56466fa566dda367678ec92f9fb98.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 08:02:38 +0300
X-Gm-Features: Ac12FXwhf8j_-7iVGqgS_dqVdNdK4mGLZgMp7J2XF982AOSeHo-SK8Lw1m2kmq0
Message-ID: <CAHp75VcvVqdgCXKuKLvpegx6bN4af=7xYO=Nh8T37_gMjG1Y6Q@mail.gmail.com>
Subject: Re: [PATCH 06/15] spi: spi-offload-trigger-pwm: Use duty offset
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>, jic23@kernel.org, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com, 
	dlechner@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, 
	Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:42=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Pass the duty offset to the waveform pwm.

...

>         wf.period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->=
frequency_hz);
>         /* REVISIT: 50% duty-cycle for now - may add config parameter lat=
er */
>         wf.duty_length_ns =3D wf.period_length_ns / 2;
> -

Stray - line

> +       wf.duty_offset_ns =3D periodic->offset_ns;
>         ret =3D pwm_round_waveform_might_sleep(st->pwm, &wf);
>         if (ret < 0)
>                 return ret;
>
>         periodic->frequency_hz =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.peri=
od_length_ns);
> -

Ditto.

> +       periodic->offset_ns =3D wf.duty_offset_ns;
>         return 0;
>  }
>
> @@ -77,6 +77,7 @@ static int spi_offload_trigger_pwm_enable(struct spi_of=
fload_trigger *trigger,
>         wf.period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->=
frequency_hz);
>         /* REVISIT: 50% duty-cycle for now - may add config parameter lat=
er */
>         wf.duty_length_ns =3D wf.period_length_ns / 2;
> +       wf.duty_offset_ns =3D periodic->offset_ns;

>

Especially as it seems that the pattern is to have a blank line before
last return statements.

>         return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
>  }


--=20
With Best Regards,
Andy Shevchenko

