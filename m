Return-Path: <linux-iio+bounces-18750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D39ACA9E86E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6485C7A98DA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B94B1C862E;
	Mon, 28 Apr 2025 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbRNNlTP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F318EAB;
	Mon, 28 Apr 2025 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745822577; cv=none; b=t/j2Kb/ABVubOeNRVWKLaK/cZZg9UTvSk+YdsLliHbj3V074YCc2GA3a/XlCXRL+tgQyM8jezD3vwWPe+YbyOZQKbyxCDZwt8k6jpKQsxY73Dv26ZpV/Qt+tXxwuPL6ye88YevjD/RlcDfJROrvKmQk8AHQoioW3FcM7tc5dDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745822577; c=relaxed/simple;
	bh=ZqZzcK4ZiQKN3TxBucAS5gbR0geGoW9MhIU8xDyaGYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+eD05mksRik9NuEwJ+/nJz9lAFGunxSG1BrtZ2c4Y5vw7/m6wCWzHag4821gscpy0bQxwAXUylz+kB9GDdzEForiIdXrzZHTIlQUWzh4dTixHSuTNzBIo/vUhhtHUTVuLKdl+nKmHyZukQygNMswAuUaCi+izuvZ88s3dP5BV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbRNNlTP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aca99fc253bso647992566b.0;
        Sun, 27 Apr 2025 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745822574; x=1746427374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVeoxsrZ4tC2juWsFPI6k6Xd61VJ0s6yaeeo0JTTl0c=;
        b=NbRNNlTPUEUf8X7pNnRpxd+Rpz0wDeak9vrIOnUWglbl5XtN+zVKA1iYES0vTiZqMi
         9JD6J1tCWkPXLaJqMigcyxjNK3OOBSglfNJmSdA4w+IYWSNbnJDcvsH7KiBRMsZNM0ge
         +SWdd2+pX/Vr8ykci9VN53YVn8XyWuF1Z5OlrWNAdrBWnatzCTHLGCCkkfVu7OAKBlKn
         A4BdoWdJVD0z+uGhdI63ZfPyhArEMj7tFK8fr1TNp04S6LqMLFz9B+efbBuG/nqN1O8Q
         Ny+63CMg1cElrVrR4cmRIWCS7ekOgrkCx1ylNYIlkTssclf8+YnpZrHRdaQjO/uWXVHb
         OSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745822574; x=1746427374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVeoxsrZ4tC2juWsFPI6k6Xd61VJ0s6yaeeo0JTTl0c=;
        b=Wb7DrTQL4m9Bv7g84403GlsFI2GABtM20USUg3GjU4G/nZ7+RBhLWs3xJI9RJM4zDO
         +VJeSBfYulEp8BKtV/TQVqC/1kD6EGk0KutA7k0MfptK1P8JbZP46xW1ZpOSTCV604PR
         OGaMWks3aTT5u/CjoNrXlwFCV/b1rP2ZqR2mVwPnKEaQDdEs9GaiWCrgsx9QHY3uWdx5
         MOSAmq84GbtRtQCqTbPHixWLwnez63fLW+Pbz3TWUUufoXTWvxxk9rTdjAyC10Q6BNSP
         JZ+1E0O+kKDhQ+/gUFxIn6HZbCY/Tg3v97MxKJdKd1KTMdtkxTd6sKx/QOUiAx8xxyxp
         0jAg==
X-Forwarded-Encrypted: i=1; AJvYcCUa3Si3SuR43P5Km4BmJtfZZndMJ3nxel0t4pdYbd8GMkTcRgwyGRs9Nykiqe3+IepvzKufZZ3fWakOFA==@vger.kernel.org, AJvYcCUlhFOy5Tgf8ppDGXUycnSeG8h6iAgyjykh2CciBKHSP/5BroS51sMLAjbNjsLziLSVmZle0GMxv8Vnr29i@vger.kernel.org, AJvYcCVNH3LODluiUjo1Rm5FV8vX3431wOxHrVNMo0tPwFoNyp1l0xTX0/DN+wDu/9D+XBdY8VrbErYjQBca@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ovHp6FOgIdros1tS8U2CkJtEkzOiBWYVDM7r38Tm59Bnj7Sj
	ZFnd1orD4DYqmlbGya3l9bzUUaa1Q0D9nTYMyw2lXEIwaab728627IDKmKKqNHQTyalAjn4SXbe
	qI2GBvKItPykcTRKQpGlBlgdghHfRo7dU
X-Gm-Gg: ASbGncvL0PYP90EcrYe6JGoSb8zrvJa+X/vLLap0gT7jaAsvT2tnE/E5G4yHiv2sPhQ
	RrB7qzg6dRzgjdpHXNxU7YXFksw8Ct9vmOIc84n4Xzyjh1KvJIhhCFuJXKfolf4Lr6pKfgPxYhD
	xV9BZx4Rlt0bIEbklUuwvdIk92
X-Google-Smtp-Source: AGHT+IGCayb7OFCeBVQAaEXALm4GeBcZZQcEMMx+8n4frmJFVPip/NVbyIlTD/nMPAAub1h0ZHmAsGYZeDJgjRk/2bg=
X-Received: by 2002:a17:907:9803:b0:acb:7104:353a with SMTP id
 a640c23a62f3a-ace8493c612mr593840566b.34.1745822574299; Sun, 27 Apr 2025
 23:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745605382.git.Jonathan.Santos@analog.com> <8a04f8f1e9c14d57b1db2f38a8433a0367c0c9dd.1745605382.git.Jonathan.Santos@analog.com>
In-Reply-To: <8a04f8f1e9c14d57b1db2f38a8433a0367c0c9dd.1745605382.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Apr 2025 09:42:18 +0300
X-Gm-Features: ATxdqUH27S-RbreDqWEJoxLFvP3nZaXCbK2hRvS8GpnytOwtgktp0cPwv3XnNq8
Message-ID: <CAHp75Vciw_ivdKFsqo=FML64zUL_cDCzjuhmdVC3V_Whnatqwg@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] iio: adc: ad7768-1: add regulator to control VCM output
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

On Mon, Apr 28, 2025 at 3:13=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
>
> This change allows the user to configure VCM output using the regulator
> framework.

...

>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>

Why?

>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regulator/driver.h>

...

> +static int ad7768_vcm_enable(struct regulator_dev *rdev)
> +{
> +       struct iio_dev *indio_dev =3D rdev_get_drvdata(rdev);
> +       struct ad7768_state *st =3D iio_priv(indio_dev);
> +       int ret, regval;

> +       if (!indio_dev)
> +               return -EINVAL;

Isn't it a dead code? Or i.o.w. under which circumstances can this be true?
Ditto for other functions with the same check.

> +       if (!iio_device_claim_direct(indio_dev))
> +               return -EBUSY;
> +
> +       /* To enable, set the last selected output */
> +       regval =3D AD7768_REG_ANALOG2_VCM(st->vcm_output_sel + 1);
> +       ret =3D regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
> +                                AD7768_REG_ANALOG2_VCM_MSK, regval);
> +       iio_device_release_direct(indio_dev);
> +
> +       return ret;
> +}

...

> +       return clamp(val, 1, (int)rdev->desc->n_voltages) - 1;

No explicit castings in min/max/clamp, please. This may lead to subtle
mistakes. Also, don't forget to include minmax.h.

--=20
With Best Regards,
Andy Shevchenko

