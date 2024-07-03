Return-Path: <linux-iio+bounces-7194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C685925388
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EE828281F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8661FE0;
	Wed,  3 Jul 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HpIhOkSL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1033D5
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987340; cv=none; b=U6FQ4Qs6MvcGiGyyM2MLdmp1QBCNCPwmyWnAihOjH0HTPCPiAGZO3/aCWaRYBsWJK8Brue+RBU69IV2ZzkZkfNBqck1yAPRrfoIlC2WoshZwg3hyfo2YpblD0ktUv4mCfMUiPBnbm/c08eoWtknWD46zDyhuPN0EWvdnGxrbrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987340; c=relaxed/simple;
	bh=enrI7x/wMroG4ij0zIBOqks55RgX80qAadRtM0RUHvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVnWXP0GynXDJLJfvwsWdVWxaEHW3Y84BkYSCQpPWPIuNdV3ryzUvMsFHg2iO00SlGMA+YDQn6VIXkSp+PoHH7LUNjpZ6X3ie2szbqKnlYyr93kTo/Ykl0kZTxrbafZKhPkahe2KdBrWrAQBt+O4WA8PlJkqmoNrQX3CLk74xUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HpIhOkSL; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4ef54591b7eso104532e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987337; x=1720592137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ospkLhGDdrrJDke8gZMbmwgf9pCpLuO1ElewomPagbk=;
        b=HpIhOkSLtJLnX9aaueDZy3A7jWV+yXany7oEIr9gO5z8+nlXyafFOsU2tn/o0lbyJn
         uaTpgaouu4F31ZDenwcMLLaUAmPx95r4g5r+qmAZJJCoN7PeHQNsgerN6aRpMHQMTW+1
         qHW/Ly8swQIApC+0H/1Tct+zQT1vKR8JO+J2GxnIvReByXf8IyiRzPohnPnjE++YZCsF
         H+FOUEMDcjlnVIAWL9qH6VF9ELoUeS+Kc5l3WK9sp/1JR0aSo5xiHyt94xRaZndLpGNf
         wBT5l4FftZHYghiwWdYZ4by5G0fhghAG84PZpd6UXvBlKIO3S5ODsgQHlc9xN1KYT7nz
         kgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987337; x=1720592137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ospkLhGDdrrJDke8gZMbmwgf9pCpLuO1ElewomPagbk=;
        b=BfPJe/TPmm4chkOsCbJhgn0IcyXy27ZR/EFm9vv2gW8/8Ow1eUz+5mjDJ+iluoaFfj
         MfD6aJpaW455HCYoO8RVvYhBYfbRfFQFPLI2djvg06PiuHLqoA6XG9pxnoogTClzFDiJ
         j+oSvWUgNSk6z33ZbMRDDQMTL4iy/YMDrY5gQuBvNfyUHI2pwyMuoVRm2C/zglEbxo+n
         72pkii2yKjind6X3dY+j7rcwlL9tHP16FJxE3bQuNxPMlfMQgeV/AXdHdDcOov9w/B4K
         yM4cwra7r5GzD5jaStB0w2g7rw/vHk9YMeavsZ+VHv0mjqR9a8sTLCi51iieY/4cGEcJ
         3SWQ==
X-Gm-Message-State: AOJu0YzR1nRtIfaUU9YV88kxcIahF3zN1XOoauOmcnaT8iulj1bwrunZ
	QO0HWGHnDW58rTQLNBEqTOaVxfQRLHhfauioJyMqyYQai2S3nw4ySkjROcU7KdLAbmI0cQOLwFr
	VUGMhuIaToqK9DDnbLwI+aFxlY8a7JykirxxuEw==
X-Google-Smtp-Source: AGHT+IECBllyXchrdYoUNpWJzOOGJLXZiZZgbO0ohge60b39fTNOUnMTou8zvpGywZa32X/20c/kSBBa3MkQ6KaQi0c=
X-Received: by 2002:a05:6122:1d13:b0:4f2:aa91:34eb with SMTP id
 71dfb90a1353d-4f2aa913b3cmr10069449e0c.1.1719987337036; Tue, 02 Jul 2024
 23:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-4-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-4-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:15:24 +0300
Message-ID: <CA+GgBR8p3T+AbRJNxBeTEdQOPkeXV4BouRG1HiCENo_8JOG0zQ@mail.gmail.com>
Subject: Re: [PATCH 04/20] iio: accel: adxl367: make use of iio_get_masklength()
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

On Tue, Jul 2, 2024 at 7:02=E2=80=AFPM Nuno Sa via B4 Relay
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
>  drivers/iio/accel/adxl367.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 5cf4828a5eb5..1c046e96aef9 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -1220,7 +1220,7 @@ static int adxl367_update_scan_mode(struct iio_dev =
*indio_dev,
>                 return ret;
>
>         st->fifo_set_size =3D bitmap_weight(active_scan_mask,
> -                                         indio_dev->masklength);
> +                                         iio_get_masklength(indio_dev));
>
>         return 0;
>  }
>
> --
> 2.45.2
>
>
>

