Return-Path: <linux-iio+bounces-19545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C0AB83C1
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 12:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEBB3B3750
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7180297B8C;
	Thu, 15 May 2025 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICO1aErG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79717993;
	Thu, 15 May 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304819; cv=none; b=qBnSpJ0sHZbdp8z/TDyxJMF6s1nIx/S0Vx7WqC8oPOGkzZXeZxbLdxW9vmjxmFxR1c4kOgamTX8vGCK7j2mlWSV6PDb/J7d8p//7FO2qwNXXEdDtvXncikmAeJ8zePMRVqBbA0TP16z4fxsW1gVsLhROMtfLDXC6C/mzK88FCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304819; c=relaxed/simple;
	bh=rHO0Fp08LZpUyRjpdcGtriQqtVm32Fg2XpyQfGbqgGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jpcx+UaVV2LAA1x7LZKddc/sFQwVOy8iSo0YOCM8EktfD+b4vrbc47ifIrhADByvIFQn6Qz7s6F/YZpgjcXZz+bhAE2FgZijRk8yzLweX+FWHzbSU/gYHT3g43gAq+ET008kGRIyiYgX/0REHnfP3Xys9jbQ9g/9rhdiNH5fprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICO1aErG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso5743235e9.3;
        Thu, 15 May 2025 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747304816; x=1747909616; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gk0+gInQFLq5TPyTiE4dxKzocRffo/w6/nhsIkH+AfE=;
        b=ICO1aErGImOiBApjuIk1aVcNRohHb6r4L7lPyJtU8bbvmLcR1AqHHWEyaQFlG9KQw1
         7MK2Y7ZOlI5RwntauiUKrtpkHb80f8pC2g0UlV5bcvLgHqumFOU8hYnyO//Kn93IiDlg
         FN5OFYeHM0gVWEQjidl4YVjBriTkOK4i6oxyp+dfqjttFBq/IUspshCROhTuZTf/5g6N
         atDsl3YTdIQkxHyY3lgKLq97hsZ7bWK7PPuUpGXvF6H6O4fz4Oq7CbwbROXr3XYPq0yR
         K3eFsvC3xr080QAaEGBCjMX59P498VBiMRCQw2quJ4EHNVno1s08XH8V/NC6APalO4BS
         gQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747304816; x=1747909616;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gk0+gInQFLq5TPyTiE4dxKzocRffo/w6/nhsIkH+AfE=;
        b=fyJcg5rDXRViAUgfNXJv2uNlsrBGnue0xjesS+PmHDAr0s5M+xnScYkMmuS3c305lr
         E7cuvY85Ee5ZLSiVtUxhA+36n+Js5ZWIEtn4YevTQxai++0VBkdAgWspf7/oejKzUtkH
         AT8PYVL69Es7I6jUvujZCLS4baEJWcYUQWYME5XYppZCcashqgOc5//bhRWRlHRC6psu
         iMgS1ZUa7Iyt/Tf8Wok3YGPH25i6RvO3YMYSl9VI/PpvuFhlM9SEh8E0GR7nBSwUJV3/
         AB63oKRW9pzsJxu3fmZU42hEokBGbz07DiYUwxd9BnOPEBCNlLWP26R1R9G/mZzibN4m
         ruHw==
X-Forwarded-Encrypted: i=1; AJvYcCURsL4TVuf2L8Mjx4jfGc1Sj2hR2VCJ7TGmaJgB9Di3KzjLM90sgZ0Y0TlcTmBDfIgZW9HMi5IVIgIKPh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHzOlqC8UJ7ehkWcmsm1b73YCFRdp7rx2ugK5pzThoJ/OTZ9b
	Q+jsudmP1vYDKmXtimFrS1Z83uDvjibeP6S///BlGs+NhwTud6mU
X-Gm-Gg: ASbGncvDsk9qPfCXZytdRxqx730+CorBnJ9C8Hw3oEh7LATmTx8O6FmLaNQZy/Syzho
	nS35YEB+K3RpuAtQxYbvhGXj7w2VD7EI45gLYKFQSvAu8lc+2pee1pupWGu1Xo0L6vTGKl9+lW7
	K0WMKH03mUG7rwmy9r3p8ddv7ZcvPu2Ab5Zp0g+IXW92hbHmKHYcX/VPKl4e59tOOVxIM/L0bVQ
	zrDNYxU8S78q2YugJtGav5GmtrkFWAh453G3CDK2C3P63eTNH2Q8dP6l1YeSnADpSI3v4HFQbFU
	7P6buP5cMtAYAihtRwlGtvN4VH72owYT/O2PZzsPQgAMvXlLc+HyTZHAZdrH
X-Google-Smtp-Source: AGHT+IFVgomBW1IBuXpOUR8LYcnGSxhFAoIygDxxwvgbwklcoUaA6rWn38wHMH/dhn9JUS9lxDBang==
X-Received: by 2002:a05:600c:154a:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-442f96e671dmr15113075e9.8.1747304815938;
        Thu, 15 May 2025 03:26:55 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef400sm60703995e9.33.2025.05.15.03.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 03:26:55 -0700 (PDT)
Message-ID: <229cf78caaa7e9f2bb4cfa62c019acd51a1cd684.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Fix race in installing chained
 IRQ handler
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tglx@linutronix.de, 	robh@kernel.org, jirislaby@kernel.org,
 fabrice.gasnier@foss.st.com
Cc: linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 15 May 2025 11:26:56 +0100
In-Reply-To: <20250515083101.3811350-1-nichen@iscas.ac.cn>
References: <20250515083101.3811350-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-15 at 16:31 +0800, Chen Ni wrote:
> Fix a race where a pending interrupt could be received and the handler
> called before the handler's data has been setup, by converting to
> irq_set_chained_handler_and_data().
>=20
> Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changelog:
>=20
> v1 -> v2:
>=20
> 1. Add Fixes tag.
> ---
> =C2=A0drivers/iio/adc/stm32-adc-core.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc=
-
> core.c
> index bd3458965bff..21c04a98b3b6 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -430,10 +430,9 @@ static int stm32_adc_irq_probe(struct platform_devic=
e
> *pdev,
> =C2=A0		return -ENOMEM;
> =C2=A0	}
> =C2=A0
> -	for (i =3D 0; i < priv->cfg->num_irqs; i++) {
> -		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
> -		irq_set_handler_data(priv->irq[i], priv);
> -	}
> +	for (i =3D 0; i < priv->cfg->num_irqs; i++)
> +		irq_set_chained_handler_and_data(priv->irq[i],
> +						 stm32_adc_irq_handler,
> priv);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}

