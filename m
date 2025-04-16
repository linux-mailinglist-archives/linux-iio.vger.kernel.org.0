Return-Path: <linux-iio+bounces-18168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B5A90436
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E397AB848
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443A14F9D9;
	Wed, 16 Apr 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMJSzGBv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C0EEBA;
	Wed, 16 Apr 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809559; cv=none; b=pNi71BiO+InVZP5O7+hcm67HsUacSUbz9xhje/9HX0Qm3YdDztlJLo5RMc+ialFmflp1j8ZC+LsuKjpA5q24gUc8TMIj31Aeg9lU0zykNRlnW9784CVaOH/jK/V59U5wN5Egrj9odA+nsVDpTSoDcaQaZsS+ymUxGeuv5et5za8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809559; c=relaxed/simple;
	bh=d/udd2B7Y0VI191ExR+1L3W7+gceLLv+un2vjEbyfl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecZQ53iBwQzmv4bZwXlQyivDg6US5R26VleVbm9BDXFdYYuHN9MZUlwypqwNAIV8KObF1LLvrIGr1mwfwH3Tp0wISluyJdlfAIE9h209D015nz4sKfcvtjPnMyCMr7bIMGHSUxa7Y7CbEWpsduEEeQ9YFhdvUcHLtDJ4wfmeAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMJSzGBv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ac56756f6so5953641f8f.2;
        Wed, 16 Apr 2025 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744809556; x=1745414356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ftO6UvkbAtkC5RGcnJVJ0q5Bo/l6aGEAvocwriFHJeA=;
        b=jMJSzGBvWpJjjVK5isiMlUxvutyZL8CJiYGVGGE4z7zneiCtb+qivgB4ki9xBnMnEm
         UfajVhDpeYV4cntrwutjZsIJ1LU1tS9xHx+tGQeF8h7jx8jQag0OrQ4GbFp5J0HgBquq
         YyG2X3sLRfikr8efIJQwinissrrndeHjcO4IB6T5VyRLajeP2+Z/RN6SbM1QcwWlM366
         ors2cQjFazKDERz/bd3HFMzcjUz64zHUurE7vgijUZZZ9DHZBnWnVBNEOiWXTrK4k+Ux
         /rx7K42SIyVGdI4Tlq1iQaFETFH8wXaZKkx6Ic03L8LEulcXTz7+RqyTl7cWm4jYrmwt
         BCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744809556; x=1745414356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftO6UvkbAtkC5RGcnJVJ0q5Bo/l6aGEAvocwriFHJeA=;
        b=oNl6yRzxExlsm2hSVocyMvhMA+ihr2fHMe6Qc/qaWyNFYJEN2ODV0u6xMc6VqLLY2N
         WkhJQEE2jwSJJmBY2NwLQg0H6bL2byKeXdW7Rv2vE6rxDeqHLxHYe5QWnNnKt/vs70Al
         4i1/Q9u6o7tfMRXOnYwVUz4CM9CWEYQoWbdH8aXrCJldUZf7uf7+d8yG0iXkqmkmYI5T
         7Iwppuw2yVkpiDxhLmtCvDw+XcJf6Y6cOgLOI2YIFSM9qYOfIQwvWVRumagaXE0X17nj
         l4YRNHvuC6MJgZ/pZRt9V5UXBAV/Sdm2Ur0tHX6+6OaFef6V+3YM89p5NbAfBYIBISgd
         ILAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmmS3RvIrN3xYza4PnF3JHWG4kbwHBnB+OGDC1RqNDM6Sb2zbgB0rkRRPYfvO4NNt+rhpjH0a76UJih3jz@vger.kernel.org, AJvYcCWgvZqtxtDw1p2CPnfckhySfJAathJXOfXYScwCuB42TKLKCdGKK6Bd/H7QMs/NGi9zL7LHmPsOjijs@vger.kernel.org, AJvYcCXY0Lx56o+59unIgFQ2/QhZNdaTefVcTBzLh2AaKNTe82xJa0R6ydv7n4FDyRZkPSq5VIBDMp/8BJmfVlCNA0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZD51ccb8cLpam/A4k+ZyUdf5kSmK+AyKkct/1bs+x6ABAkmt5
	PBwXuYU0qEOGPLzYgA0oaoyYwKNSr0vgi1xTxPoQL/SLP846QP4W
X-Gm-Gg: ASbGncvoGKzrpexM1g2HE4FvOdQYRByVXU2AuVnCBSGHaVfxUs8UZPgHuhBvlQ1dQG1
	6I+XwI5wjxVQlCIW0kvv703iNlAWer3SSqySqyaZGKCpgDbWhFOLysxW2uMCpRTTeuYKBl9FIT0
	QIlS9HgTSsbyT5A1HNYf7uasyi0a8o+3aX9ePlH3AO9+TzrAImNknhv72CXtJpuoGkZdQ9HC9D8
	5xlAX+wuzz2HxjVhEU6mKGL/EabLPeq8KZmP59+jMB/Xzmq5/MGejGnzAGlpVSrveDGh+dZb3CC
	6QwUEl3+aYEkBs1uxkKQuEgPmHnAA96d6OICQXSgALBlTsGQ/TQGWgA7PE3tctvPG8eadCfKfVw
	cDRe5qcCEDEFP
X-Google-Smtp-Source: AGHT+IH0YNS152XSmvc0NDtCYX1PqZ27HFQpgBWaXw22TiKmFDLkknNZQOvna5H3DWTECUh12wEskw==
X-Received: by 2002:a05:6000:400b:b0:39c:2665:2c13 with SMTP id ffacd0b85a97d-39ee5bada76mr1708063f8f.54.1744809556201;
        Wed, 16 Apr 2025 06:19:16 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ee411dd02sm1937677f8f.55.2025.04.16.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:19:15 -0700 (PDT)
Message-ID: <1bd49e142bdfd6faa246dbbd208cd7d2e01d4857.camel@gmail.com>
Subject: Re: [PATCH next] iio: dac: ad5592r: Delete stray unlock in
 ad5592r_write_raw()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Bartosz Golaszewski
	 <bartosz.golaszewski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Wed, 16 Apr 2025 14:19:18 +0100
In-Reply-To: <Z_-P7bsD3KL5K25R@stanley.mountain>
References: <Z_-P7bsD3KL5K25R@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-16 at 14:09 +0300, Dan Carpenter wrote:
> This code was converted to use guard locks but one of the unlocks was
> accidentally overlooked.=C2=A0 Delete it.
>=20
> Fixes: f8fedb167ba4 ("iio: dac: ad5592r: use lock guards")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Thx!
- Nuno S=C3=A1
> =C2=A0drivers/iio/dac/ad5592r-base.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-bas=
e.c
> index 217a8a88818d..5f2cd51723f6 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -324,10 +324,8 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev=
,
> =C2=A0
> =C2=A0			ret =3D st->ops->reg_read(st, AD5592R_REG_CTRL,
> =C2=A0						&st->cached_gp_ctrl);
> -			if (ret < 0) {
> -				mutex_unlock(&st->lock);
> +			if (ret < 0)
> =C2=A0				return ret;
> -			}
> =C2=A0
> =C2=A0			if (chan->output) {
> =C2=A0				if (gain)

