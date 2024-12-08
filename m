Return-Path: <linux-iio+bounces-13261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A99E87CB
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E080163FA3
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA129460;
	Sun,  8 Dec 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD6wfvQb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7E81749;
	Sun,  8 Dec 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733689951; cv=none; b=KpjlxPv6zLtjXJsWdwewfgiMRxmBZwGylMftOI4oaDIhZoCHBID/Ck8qAkkntxKyn9osZbUOvGpaQLuJ0+pyYHEApvazC645/Bnj9y7OPu5NILqGxf5BQOTJFHfSXuGxkz/f7Hx3IeMCctK3n0sgBTI/fsKtfqZ0xd8s9PwncBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733689951; c=relaxed/simple;
	bh=bxhyU/xSCgjfkO83jJk78L6vCXb8cOZBGo8eDAD0QA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfvSJ5gWObxzxGmdOfpmH0BUHHlG7/EGzrA5sFsRq2u8E+FjddY2/V46NLNLdVaI8F7bh0bdG8TB5rp4+noeNfCeBKZ+8VrLKUqwmC6FkhqF2lUh52rFtAhc+BADOj46j9Gq2/+UcDPjwFVB4d7CiFKXD8uTzckyrntFef3vwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD6wfvQb; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-515ec243329so813581e0c.0;
        Sun, 08 Dec 2024 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733689948; x=1734294748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrrItemxQW1VlJXt/pJxii3BAEc1oNyRdLT4xJHfgOc=;
        b=gD6wfvQbk1a8oOmlhrVddlv85f8S++O2TQhnVE2zzLl8DEjyIbha4f3rb0jpiCb3BB
         WrFrSdBD8T8LOZaT+gOcQoQxBugxPMkQr1F1iAU5qyhDO7O/DWBfr7SCAZGQ16oJ6KtG
         Z9wdiCWS7RRTM5np135DKWEdZ3RlScysKg8fVi+uEfSK6Z8fM1UaIHlrhIPwbntWnWYT
         dUqE6ZeHF2Y9nYGrHiMDgqmymxxo8tEhT3kCY+caWiToRNEgE8UKY+KqBbY8bPVHINVy
         6yIzwRfqMcOgrHhoR74UN6/xHagrgJo/WDvemhArzB0PTQeyFU7ATimho8L3yQvpE6ar
         2VOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733689948; x=1734294748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrrItemxQW1VlJXt/pJxii3BAEc1oNyRdLT4xJHfgOc=;
        b=J6cwIzhWAV7TmW6JOVm/Nr5Cywrk8BtU+Ahv5AdDNgfZ3rKVhfNnDoxE6PqUpP06nd
         ym2At3eHfwwHhwBeIddlEB0HCH3rRjoHHHW3cU5BYRLsjww+xr9wY2n/gOR/Fwe9ne4Y
         8ZHk2h+ZwwohSjD+vnmI0l/s7L/qjs/vwOufdXvz3CgZowRpipknE9cML7iQuNZ+dwrk
         dVOcYOq5BhDAcacgy6amAUW0MBniN501aE+WALPFxbeFSKZmWtAEu8hX6z2d6I33SRBo
         Cj6PZP6jZzC6PAWtEUWV7l0bALj2kgSyxlaFJvgUnlF4ARLenZa3rDpdBg+11u15A0kd
         pqlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/gR5y5ZAZWP8zFx/a5xHj54CfnqS9ddk2rBtkM7NbvOGChVj6gfPuzL8f9NYjBq5eVinrnJH2paDp@vger.kernel.org, AJvYcCVDgdrgoOqws7DFtbL2gT0ngMqBCx8HS1HW7k0TDvwqpAjcnAanv85y5IJlfpbeH7MUGUWa/oGmvry7@vger.kernel.org, AJvYcCW4hLTrLiWpjcPnLAEQq/5jl7VT8q9ZFHloRedT9eelqTia23zYuCp3eBXil78R0GznSR31FqQMcXVaLEiF@vger.kernel.org, AJvYcCXJMHd841brkuZlSJ52iiHD1vNr+TmMQQ229BkWAyMhCmytZFtrsKUca4P/LnXLwUluFYfi5le85a+S@vger.kernel.org, AJvYcCXe9YUkASPhJWVvG5X/qRCeC7/4vfjgk42rOXDdtIxyaXcJbD8lEJCURj37kmXGoGlrGceMjSxhgnJzBBSE5TtbE5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzck+QPqeTHqGXU4MS/Lk3p01j9KifBZ4jbjCZIzPVReChoHZzo
	K+CNYfxLoymTI0nKEMF6l3MACiTNDe8zhWMO0FMGTakExKiPzE3Alb+VB5eBosbZwmUZTeDXXGy
	7VLTGizwfjM2zh3CXbDWssGLa5FY=
X-Gm-Gg: ASbGnct78twHRdGSK701djwrF36/EvVnbJJmRj8dFxml26SHwjG1oF/ON8IWUn7aDXg
	KTE125Go22GTKaErXbs49M36Uq+CAoUUy
X-Google-Smtp-Source: AGHT+IEgxmooDjk2xdyWhgKYOxteJcz5ZfbQETjfc2zl/K8fImvYS5Vyd0CiRolxIiBvDYp91REeaik6bPe+vPUB9eA=
X-Received: by 2002:a05:6122:3549:b0:518:778b:70a1 with SMTP id
 71dfb90a1353d-518778b8658mr1013622e0c.7.1733689948403; Sun, 08 Dec 2024
 12:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-6-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 20:32:01 +0000
Message-ID: <CA+V-a8t248mJZRcXbLtgLyfDo0au8acaEUTCmEG0NCObFUxrtw@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS()
 and pm_ptr()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:14=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The use of SET_RUNTIME_PM_OPS() is now deprecated and requires
> __maybe_unused annotations to avoid warnings about unused functions.
> Switching to RUNTIME_PM_OPS() and pm_ptr() eliminates the need for such
> annotations because the compiler can directly reference the runtime PM
> functions, thereby suppressing the warnings. As a result, the
> __maybe_unused markings can be removed.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - none
>
>  drivers/iio/adc/rzg2l_adc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 780cb927eab1..482da6dcf174 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -454,7 +454,7 @@ static const struct of_device_id rzg2l_adc_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
>
> -static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *de=
v)
> +static int rzg2l_adc_pm_runtime_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>         struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> @@ -464,7 +464,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspen=
d(struct device *dev)
>         return 0;
>  }
>
> -static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev=
)
> +static int rzg2l_adc_pm_runtime_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>         struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> @@ -475,9 +475,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume=
(struct device *dev)
>  }
>
>  static const struct dev_pm_ops rzg2l_adc_pm_ops =3D {
> -       SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> -                          rzg2l_adc_pm_runtime_resume,
> -                          NULL)
> +       RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime=
_resume, NULL)
>  };
>
>  static struct platform_driver rzg2l_adc_driver =3D {
> @@ -485,7 +483,7 @@ static struct platform_driver rzg2l_adc_driver =3D {
>         .driver         =3D {
>                 .name           =3D DRIVER_NAME,
>                 .of_match_table =3D rzg2l_adc_match,
> -               .pm             =3D &rzg2l_adc_pm_ops,
> +               .pm             =3D pm_ptr(&rzg2l_adc_pm_ops),
>         },
>  };
>
> --
> 2.39.2
>
>

