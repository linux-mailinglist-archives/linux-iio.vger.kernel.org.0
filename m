Return-Path: <linux-iio+bounces-12517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE49D64C3
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 21:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C881161730
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CF183CBE;
	Fri, 22 Nov 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipqy7qiE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933E158DA3;
	Fri, 22 Nov 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306074; cv=none; b=tPYjwpl2ThzsUBXafuMMXzMtLHxyaDF6TxHazhP+bccX/kVPW3hE/wXP5UlC0F2YYTendre0iiPOkzI0jQvpyupIpVqc5enP2La3kAoYvbx6FFYGFM72fIYc6gUlZOrx6zb6K4aA67+p4o/SofoQYQgqOOMhTXwGdwWYhTvm4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306074; c=relaxed/simple;
	bh=jng9m8Z6ojcV7u+/PqNBbvwK9kj8LnBfjcBNdAmtkB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGPDvNpPXtTYs0ur2iaq3TsgJqLr0mcqPZ9wVKYsnIhfFl4Ks+yjVgU8jy3tk3ss/J08Ub5sWQZb/CEslqkpuDZSBtCuUCxVLcEV7OomJlOFm//mT0KYOiz8qR5HG71+ibtAUmV5qG3NG89AOAKiq2pKQe6nz0SW3UFuC8/2SFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipqy7qiE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso388282166b.1;
        Fri, 22 Nov 2024 12:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732306071; x=1732910871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPTkfiGJ7AaYlZP6rIOF08Mqd1nmcw/G8AMr/XE4/Mw=;
        b=Ipqy7qiEgW7xD0nQXNgRuvwrCbBu+sD0EMJA1h1/ZfAZkwmb9KsMXbvjJKQ7OYxDFe
         reehBb4zf4rcwSavWiFgvADXkbMZF9TdwYx8wufY0e2r6jfNUctlWZCeE/Sx4l714Pgv
         RJ3X3LLSye8Op/kRFg8/4Vxz+/SF+ywMEbOobhHEJXcq2HbSCCGoWhuJWXzkbLvb6MRQ
         y0BeVZ6FYB6JPjxPENYgr07RLtdK0UMNGSBGEqtP0s6wkldYfEDivZyVNgaChjPcexbL
         lBUSVWPRECg2F/6DCtcTPogvQPUtYQXq+t1kmKf1uwWXQ1dPZvZiKWqu6G8/LKmD4/6R
         RSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732306071; x=1732910871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPTkfiGJ7AaYlZP6rIOF08Mqd1nmcw/G8AMr/XE4/Mw=;
        b=ZbRTHTMz4sAKlVI5RTZeGBQBGtN115bFxFMqOxz7QfhhoMzIq+6gUZhbFCc/6XUrkC
         HwtEcYTwkjj66kJbtfIOq8ZM5NGNRJbK7NkXo3KlK/cU0mQMGKL9luE4FMrmGhw2zECp
         KGinb2OKyEhwvmMu0eEXBzq9OMerPQh+cUGx46AcC00IT9Cnj5kk2YJs6vSh5uIjr+qo
         Az/8kaZ3cftsjSSdwdKXaAy9iqhX0pHU1KJnNkO/NheSVYbw/75Upe764Ey2T+9+fwg7
         fpuxlsAIhquNzSW0008XYBUj0LADIIw8JHAVMZ4hhE/cQnzZCcIkCRzEKj4zy0THA4ha
         OIDA==
X-Forwarded-Encrypted: i=1; AJvYcCUYbyEQq6sffh2HjTCvWH+LqTtbsGWDzSDn+0QBegw5G71o/WHgqYgeO6CiOwQdSuzoNFPSKgx2owRg@vger.kernel.org, AJvYcCXjAKJKMGV4UBNrTDRTs8LhIpg+bzDCkTEDrc4uZ1LtG7QrNZD5gfGg7b8OvRhiL8iMaJ55mw38g99M@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfGdkFmTiSusAluwOTbMwR8oU8BdF0k4+pXKMesZU9/dWg5GN
	ZN/zMVg2Aoa5mSMzjUldBjWHgNd5gSamDBwfxyWBx4TF70qn5erOgCE1bD4a6Typ5KRuEzCMVQq
	v7iMUq6D/UAUYx5oilqc1vuy+UNc=
X-Gm-Gg: ASbGncto0gO9V1CYtwIiEh8bDO4eDD5RPrjqEDDZyOkoxGlAsuYAdm8DkufHDXHYxzU
	rlVp2RJyLIh1/J7ynS76PoTB/YwaR3gE=
X-Google-Smtp-Source: AGHT+IG8/1nWwe70NWCRMKSCsj+YFoTPMYv0izZCAojy60ozffLpRP2VMkCK08taF+3/7YTlmbESsmF1Hs+LYmlDy4A=
X-Received: by 2002:a17:906:3108:b0:aa1:e51d:cf83 with SMTP id
 a640c23a62f3a-aa50996620cmr374345266b.11.1732306070941; Fri, 22 Nov 2024
 12:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com> <20241122113322.242875-19-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241122113322.242875-19-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Nov 2024 22:07:14 +0200
Message-ID: <CAHp75Ve68F5YJ+C+UyL0QK4xEyS-TMErtP9PPouBc8o+uN9=yg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] iio: adc: ad_sigma_delta: Store information
 about reset sequence length
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> The various chips can be reset using a sequence of SPI transfers with
> MOSI =3D 1. The length of such a sequence varies from chip to chip. Store
> that length in struct ad_sigma_delta_info and replace the respective
> parameter to ad_sd_reset() with it.
>
> Note the ad7192 used to pass 48 as length but the documentation
> specifies 40 as the required length. Assuming the latter is right.
> (Using a too long sequence doesn't hurt apart from using a longer spi
> transfer than necessary, so this is no relevant fix.)
>
> The motivation for storing this information is that this is useful to
> clear a pending RDY signal in the next change.

...

> @@ -182,14 +182,13 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, IIO_AD_SIGMA_D=
ELTA);
>   *
>   * Returns 0 on success, an error code otherwise.

>   **/

JFYI: unneeded asterisk.

...

> +       unsigned int size =3D DIV_ROUND_UP(reset_length, 8);
>         uint8_t *buf;
> -       unsigned int size;
>         int ret;
>
> -       size =3D DIV_ROUND_UP(reset_length, 8);
>         buf =3D kcalloc(size, sizeof(*buf), GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;

This is somewhat like unrelated refactoring.

I would suggest avoiding doing it here and instead add a change that
either uses BITS_TO_BYTES() or even bitmap_zalloc(), whoever the
latter might require more changes in the code.

--=20
With Best Regards,
Andy Shevchenko

