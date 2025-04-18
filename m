Return-Path: <linux-iio+bounces-18237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120CEA935AC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D9D1B670D2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB326F44D;
	Fri, 18 Apr 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg5qu0tT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A08269CF1;
	Fri, 18 Apr 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970212; cv=none; b=ks8kXwfGbaMq/4kgBngGj3BfgS2dzjA9QH1vCpA55wBKT2E6GeUIfMp2w39kqb7zM/GQGdgmvlM269XDwRpM1wsP8daFcLFIzha/7vDXY/fPZ/FIe8DkMjvYJeEIF9pq0GKED8pPQdUuDMjBIot3dxo6W+EZWQPxgrF8cIBGM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970212; c=relaxed/simple;
	bh=A/QQjRB4nQMCJn6/TufvAbEtoA9rAkgMzsLpUvfuF4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frDYTwqE2wdfEaaJm/aWSQWwVCQzRpvpy9H9fEPPGUXkBu9gK5+DsTXCSQhkAd9qJx+6v1rOkiOSArAAv2FEotETVCKOWfcr4wUveFvgc4HkDg3SPYDogKgaevAxXtHGtuUCLXeWM1GXFTLJld1KtCFxf1jr80+kENgMmUav2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg5qu0tT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39149bccb69so1723189f8f.2;
        Fri, 18 Apr 2025 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970209; x=1745575009; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6JnbYNgpq8QEYxht1353W0il/coYdog3puA39+m94LY=;
        b=gg5qu0tTWvYdlliOIGIiiasXRA4gDmAm/jYjARotM+/z/ZRbPKaoaB/Ch/CiyiGy6y
         Ij8vEzbZHespuh76GwqS83OWT47XRHZ0v/ZyB7Sis8fCMC/DOr0D1KMwEMhYpXJCeQCc
         hXRM19/RwSJca7Yb6pXHJFm6nzBm3lrM3rslpjX2QKTfpkU0+2NmdFkphq8kBXTszCU0
         92l56y1S+88aL+2GSP3kbafjCOdiXlqazVd+tK+5ki7GSpRAUYA2oj3ERARlaX5FuOYj
         GKGfFZBRqgLPW9vabdnk2ii8pXML4e9gFvL5gFRM0S6TXNeYtpLAtj6SS8fVCzFhU694
         pZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970209; x=1745575009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JnbYNgpq8QEYxht1353W0il/coYdog3puA39+m94LY=;
        b=ldVbxmIARMES0w4E8mb86G6UZ3TP6b58VovTRJ6aZu45IMMdTHpIs11aLcmYxBGTyU
         5XEQXUmj8A1hsaPQJF9LFHxb/wiY4eOxjM9NTlinfx3o/Wokt5Okjf4JYvyOom4CUCI2
         3Nigdg6H5W+jn2pu8rg3dtDI7AX07NccgwRB2DEnfAKcbSvFZnFUDUQbgvDuiaAjusUx
         9Y6fZDtpQ1y7yanXfWB/LN3DSr3+nD01QS+ZDCAJQxOKsHvcMFUqluRX3LJJlcQM9wNt
         UzSFgjwJTF959mvkt9slx4UvSycnE29J4cnuE31X2/T3H6lTYQ1uY2POcsfmOtKNDvby
         /X7g==
X-Forwarded-Encrypted: i=1; AJvYcCXq+36egy4C7wBeuYGVb0wMKobVJ7erF2LS7zAwnWPg0BH2nweb0fbsruJCxdJxKsG7yCmSb1b2m1/V4LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbM/51hYKDBN9rFGqiQsHL1qXtCEecBCnxZFnCUH+qC4a6Cop
	BWZeIwuSos82ljV6UWO3nKboc7YqUSxe75xPNeZ3/CCzWrZTfa8S
X-Gm-Gg: ASbGncvg6a+u6Iai5NnKuNCkwogua5IVkvPYwM4ZE6tOn2zELAhXfPRX97i2j8vW0cl
	4SVwJ4QKsT0W4+xKSXJo/em7c0d47LySGcOfVE+vcOWnVhupCEtkRt95NytevpBd1ID5L5lSq8C
	axizfVQ78utkw78caSl8KDuuSq2HaJKqLbL3y4jV4wwat/l2wbgip59vYkXbREE5a6oXZ23P5Ec
	EWZH7DnlzI+Nlx3bdyhSP8SCLvf3tEOGzMbwYtEgWMsNuZxMHkrz6RuNSqI+DD9riAPI31kZJtA
	uEXAUSat2PQoAbU1jGaMQy1Ujo5QiWG/NL1KXmAqDOWL3+IZja3C2xceEJOgJ7WG2+R7uhgvnSP
	ThmNqYzXsq7BWooA=
X-Google-Smtp-Source: AGHT+IG9XuTCmPLVk2umtFfxUnIxxKIA2Xaugc9G5OZzls8mvgzpV5pXnzR7Jt8N8XgwxqLl/robOg==
X-Received: by 2002:a5d:648c:0:b0:390:e62e:f31f with SMTP id ffacd0b85a97d-39efba2638cmr1792786f8f.3.1744970208853;
        Fri, 18 Apr 2025 02:56:48 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43d07csm2323159f8f.58.2025.04.18.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:56:48 -0700 (PDT)
Message-ID: <d3800b1fc2430d897750541219e39fd43216b199.camel@gmail.com>
Subject: Re: [PATCH 2/8] iio: adc: mt6360-adc: use aligned_s64 for timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,  Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,  Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 09:57:09 +0100
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-2-eafac1e22318@baylibre.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-2-eafac1e22318@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure that the timestamp is correctly aligned on
> all architectures. It also ensures that the struct itself it also 8-byte
> aligned so we can drop the explicit __aligned(8) attribute.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/mt6360-adc.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index
> 4eb2455d6ffacb8f09a404df4490b5a11e49660d..f8e98b6fa7e923c6b73bedf9ca1c466=
e7a9c3c47
> 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -263,8 +263,8 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq=
, void *p)
> =C2=A0	struct mt6360_adc_data *mad =3D iio_priv(indio_dev);
> =C2=A0	struct {
> =C2=A0		u16 values[MT6360_CHAN_MAX];
> -		int64_t timestamp;
> -	} data __aligned(8);
> +		aligned_s64 timestamp;
> +	} data;
> =C2=A0	int i =3D 0, bit, val, ret;
> =C2=A0
> =C2=A0	memset(&data, 0, sizeof(data));
>=20


