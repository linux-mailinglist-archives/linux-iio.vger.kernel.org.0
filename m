Return-Path: <linux-iio+bounces-5759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC18FB395
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151E128772A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8C143755;
	Tue,  4 Jun 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWemrCxh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A489146587;
	Tue,  4 Jun 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507404; cv=none; b=Fw8gTbhMl2yKmTlCuDRwdOrZf7ZKRpvPG9LKy2ieHhSN2cIose/7AtUyIIFce4vvGzzLkm1vrWc96HhB8q/sHA1ZqpiDRY83aDPJTkkWx6fp1vJbPHwgplKc2jonWh/iMuWm1HlbuSrh+jzxPw11H7yOrMEm6+WsJtY2zm2GSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507404; c=relaxed/simple;
	bh=D4HtLoTVU3H+eyUhPZTSVo5LCusxKwB+BLH0C2Ip7jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuIT9a21E9Z+Xp8xvjm35Vx1UtPuwhJQtmTKhvZeRj9nTUZL6cIG21iD6qMa/Y0c/MgNY5TVD6ShAzo0Cpl+9MYg3L/DxU+8ULSrO7VkzICC2P79b3eDygfHA+rC5UAhLGaLYQ1kprRIQDYAFMz6u4I0W/LkAaEpxXMlXFXL7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWemrCxh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a63359aaaa6so721905066b.2;
        Tue, 04 Jun 2024 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717507401; x=1718112201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4HtLoTVU3H+eyUhPZTSVo5LCusxKwB+BLH0C2Ip7jQ=;
        b=NWemrCxhYCNnMM0EfqVJkc1B3z0I8MWk4l1Lnbcnmr0g/SOhyQliL029/rGzzNypPy
         sXBXjOgUDISzsplbcfFH6OMxdVwnEvXhJW4l9RYDndx8+zZgZTzepga+yE+yug9wLsTk
         JvWZhSsyPAn+1LyfSiqfZJHCfvt+1jRHwFk0Dq7sHu/aNF0ZgNBnqcwM4MwQl+kHmUSF
         yeQmI7CZTdLGm6mi4WTt1ryYS8WgPa7AWEeKWpjP+DjPpECijBkDdFFxYwk07wt9sBd8
         Ez2d4wzW1OSaqYUmjIKnsmT4l4HeP2yhqU4ZuEF4SjXjwJRBLrQJ7EACazkEcM7ml/bo
         H7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507401; x=1718112201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4HtLoTVU3H+eyUhPZTSVo5LCusxKwB+BLH0C2Ip7jQ=;
        b=JPnl3Y7N96XOPTwLNrznsJJgOQIsNTnQiYOuYkSjT/L/eD/TT8ei6OdYyWTy9jtu6V
         4tJYTokLMgTl4MGgErMsaTnM7P1LjCDG/WeHWa8NuImSO9KOoqtGJTQQfXJP3c2EAnae
         c1y8bqnHTXZZn6vsdqWmSNThxV0wYS+lPN1ubE81rYMEIZ9Quu4gP4GP5lQ6H1752IOR
         /Q4/SzB374HTMjvD9HiJOkVrr5cxtKuXtusdWRt7AEN3UpHcEv7sdU1HS5vZgnyRUpJ+
         6346IGYQnpz4ckTswJzlpsClFQk92X2WMs/1ZbiGTNfBayVopL6Q7w8DYHM4a1E7yqqG
         26Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Fg0UG4qU009TIbWRySmei6MepRpNdclOODPOaxGjLRIz4DyRHyrp3g1toSpI+NHZfoAeM2dE/aB2vHF2GJt3+GGIjKXAqsNd4nYzuks7c7VCuCSGoF/3Yg2xN2ggDdTmJqrlvXIlggkngUaKmLTp7JyrHtUFbzaEZItLCFUqjx+wwQ==
X-Gm-Message-State: AOJu0YyMZOfN4jfY7w3HnsAgrmdEf/xX7NA+Zwvr10tXzqS/g324Eo+T
	aYDBaMFWsNi/08x20gqrwpbIMijV/G30hVPsLzvzk89XLe1uvtBKj7ARkSWzgL6A++ics9Vee2o
	A0oqUMS1xh6iFL+SKs6KBEjYwUnU=
X-Google-Smtp-Source: AGHT+IE5s5ADNfYnbPI8bDw/CpMfi1LzejGDjcTFcbYzZnvQgliM5/TmXHdkT9xdHYahqyYsZ6pgxgeQxvDpCe8I2qg=
X-Received: by 2002:a17:906:2b51:b0:a68:cc6f:cb5a with SMTP id
 a640c23a62f3a-a68cc6fcc2emr493202266b.68.1717507400768; Tue, 04 Jun 2024
 06:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com> <20240604123008.327424-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240604123008.327424-5-angelogioacchino.delregno@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 16:22:44 +0300
Message-ID: <CAHp75Ve8qPLu+gS8o5Q5A20j_+AP_UVkOzdKqcnhUawA_sW+VA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	marius.cristea@microchip.com, marcelo.schmitt@analog.com, fr0st61te@gmail.com, 
	mitrutzceclan@gmail.com, mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:30=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a driver to support reading the Auxiliary ADC IP found in the
> MediaTek MT6357, MT6358 and MT6359 Power Management ICs, featuring
> a different register layout, configurationm reset and ADC reading

configuration

> sequence from the other already supported MediaTek SoC or PMIC
> (aux)ADC HW.
>
> This driver provides multiple ADC channels for system monitoring,
> such as battery voltage, PMIC temperature, PMIC-internal voltage
> regulators temperature, and others.

Seems all my concerns were addressed, so
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

