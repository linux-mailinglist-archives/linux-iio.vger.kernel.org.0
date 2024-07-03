Return-Path: <linux-iio+bounces-7206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEBD9253CE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC1E1C22BC5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618B131BDD;
	Wed,  3 Jul 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ba78Y12u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25158381D9
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988861; cv=none; b=G7zBI5MYI2aMKlgvi21jcaNIk/ysrRtrKyEoTC+FK9BdPuznJty+wLjNMXWd3cgCGSfNpU/LuseDU++e8MZkU6Djs0hrQQBzjNQXm+Q6Is4YoDmcXwFK2qIQa0pax/U/u0E/D7lODJBQxFHNJ/w4UlN3ch4K3ByG50/EnLiWxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988861; c=relaxed/simple;
	bh=b3Gra3xPgSzh01tKGQkwhscHUYlX2gaWUGiLZ4F8iFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQMa7QLWN8zgL9wWotX3o5mgFEUKYBQroDKKzyTSQUEzuDYPy4dRgZdp76KeY/zkic0ibC9zeTR9FVjRHdlBrovTDZyzXqTs6/0xzZ9ocFFvqsPKy+gu6qCD7hD4bSjcQ0y9gPeGZcoy1vD25cLBxszVBxNs9hiKM1zZH/1uBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ba78Y12u; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80fe94ed6caso87594241.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988859; x=1720593659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuVsBlN1Ampw/0MbAn1EX5JTwHlSMtoeNHSIezCoekE=;
        b=Ba78Y12u95/7liYIPTHcWe1DACXNq3IHH7bR1F9/iG9ACUOERmve/Ga8TMv2mg8rwd
         sIshF7rgqd/59CUYi4XxTsaNy8JGGLw38ETFGEY/BWNGYv1yWFqByRfkFE40Wb7hCNdq
         FKFcbO3hYMx6VFgW3buRdWDFXf2u313W6RyiBCJWxVkLX5sllIH/M1R/NFnyLlO05M4d
         Fi+8Jmh6WqJnkl6N8m7rcsPPNit1jweLnrfNoQdZt766oTyTYLhZDdBWbvl1LGc+xkds
         JLOAi+zqY7bPTJSdZOQT2ArsfFZJqKWUCbV89vAuTwAcf74i++GUBzPt7b2JfRnj7wOW
         H6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988859; x=1720593659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuVsBlN1Ampw/0MbAn1EX5JTwHlSMtoeNHSIezCoekE=;
        b=prZF8vjW462Dv/j0cyzFTbU2uMHIotY/ogaBglhEkgNrLNNXY66vzBwN6A9h7Q5M0U
         Pp6qBiEu+nSyygbSgIdPh1TZSjEgy7QtwThXpYzwM2oKpi167FvMroRjRbTk6BOZrhik
         928KrrOVrF3YgHTDuwO1vSrQ3QVmV4TVmC6XA1Tji7hmTinfYDvzS3daEuPW7M2Yl/HV
         mayV+gFNYh0vGcRMLcvaP3XGe8rd3erSokM/nwvKFPapZua55ZH9Ymh2G++v5Mo7yQMp
         r+j44r87kQuF50Yb0ifZNNYzNA+15Dnk1DK8wgRvIL5BAadQocR/9sRoY21pqG8k/Hy4
         3PHw==
X-Gm-Message-State: AOJu0Yyvc2gl3SMh4+ViQaInPdIKGFVC5uGqO1iRTgfwEhn6/hWwwsUH
	1qCOr5FgGJfOoIFYU/WUESgLrSDvSch/R72eZsbQCCvj/TX0Kb7nwRU1xMKc9cK/a2b7ft6bhB3
	pzDcsIQ2gyD2ePdSDpxacjD7Bbt5LC2ZqFzNTRQ==
X-Google-Smtp-Source: AGHT+IFmD6afXbtOVApkewoPxD88vcrnBe2vVb7JKdaC8OuHe6uJaw0g7oLJ41hraaYg8zdjI5DUtty1osY5QrryZ3g=
X-Received: by 2002:a05:6122:698:b0:4f2:e302:4577 with SMTP id
 71dfb90a1353d-4f2e30248e1mr474701e0c.1.1719988859113; Tue, 02 Jul 2024
 23:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-14-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-14-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:40:46 +0300
Message-ID: <CA+GgBR-TFpWtGGC7S=McaDOFiyCo=nJCunAMVsY8fjv03_-pzA@mail.gmail.com>
Subject: Re: [PATCH 14/20] iio: adc: ad7266: make use of iio_get_masklength()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:03=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Use iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad7266.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 874d2dc34f928..accb78d4c3086 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -123,7 +123,8 @@ static int ad7266_update_scan_mode(struct iio_dev *in=
dio_dev,
>         const unsigned long *scan_mask)
>  {
>         struct ad7266_state *st =3D iio_priv(indio_dev);
> -       unsigned int nr =3D find_first_bit(scan_mask, indio_dev->maskleng=
th);
> +       unsigned int nr =3D find_first_bit(scan_mask,
> +                                        iio_get_masklength(indio_dev));
>
>         ad7266_select_input(st, nr);
>
>
> --
> 2.45.2
>
>
>

