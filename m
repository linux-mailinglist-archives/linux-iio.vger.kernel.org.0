Return-Path: <linux-iio+bounces-27177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BFCCC345
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 863F03031063
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1CF33C1B7;
	Thu, 18 Dec 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvcZr9B/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381333A6EE
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065710; cv=none; b=NX04pHhGf6lBrEkM6igC1joMFla3ie/ckhYIrdheqOc1DYXFZL2dVrzqnAZ/PEHyOfr3U++XxOUI0hN+3La8ttZdTUEM2CEamNin0080eabGhZWJ+7+r8UFKO+YyyLTELOmxEL+sfIQrEzQZ7zCuKC4/R3doy55HIMPZQzDTIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065710; c=relaxed/simple;
	bh=ZnIegsC3Gyy9VFNbUZxdrDxtSveJ4mNx7L3shQp8w14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jK22gc7tHEdW1wRc6uGnRkRiOmbLbDBBexA4CJqXKOCgYSJMCjWCIINsfhWVlOSRCnRc7sCKHzLBVuWbrNTZ7hc4+Cfsmlzo/PQGfqXTCRT0BWxqamyETClIebB6Pyz3nqPx35sK833DHUkhNqqOZLnRT9R2ZVFOb9T1sCcavNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvcZr9B/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso7067675e9.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 05:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766065707; x=1766670507; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+RKDiQXHaclpMfqjcaOyio0I5Z0xDgJAm3l0KAwmXfA=;
        b=QvcZr9B/ycXV90oodOexmLIuPm8SWcsSW2T4RAsXs2ERsrHs5rRsPQzr1y4NXPCoLS
         pOo99kTfMkbXHlROAN7Cy7AKrOvb0Y7YEqdkgOtTyLPcc6NMRC7Q+6Gv30D+rFBJwlTd
         xzEMZNnoMHUOSe5PSTEZ/DFI3yRUJ+agTSRLOHiPPlmF4p5ICg0jr2zqtM7T7IZg1DH7
         yOWztXG9akESOSMRI4+XRS6t6N3m1qhqIKc+x6rb1f74hR70qQNZ9u0Qd3R6MZkQX6BF
         X3HhNWObG6PHHP50finHZFVpHYAkQewl8dT0wCkzqADHkqM5LTdmfENTpncuaP5qYDVI
         YWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065707; x=1766670507;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RKDiQXHaclpMfqjcaOyio0I5Z0xDgJAm3l0KAwmXfA=;
        b=AnHUCYpEfrgG7OQDKGl3rBO896lXyP3Szb0Ak1mLw48YlL9kgK01lzClYmDAY4P/dr
         fxVuz4RrkBE5dii5Z2IpmRu++3CiQBToDDHF40McoUv/W0EJ0B0cALyeKa3JtH2q1eXr
         wUV1q4WH+0MmnvF+kQAUtqgHIGFOUpKcWTiH529Woaen2oyd/Y8PVliDjaPnqBPQnOWh
         hosy3bMtiixhkToQDD7K0/w4iS9+uocT+rprtDgJt/quQwB13vdEUcF8B8PmPrXTiDAW
         9+OlwIztdAXgIVY7Tzir8MqioLRxWsNAtADLF0H3w+v8Wjqkd9nHtf8A/nRwoMuLpMJh
         ctHg==
X-Gm-Message-State: AOJu0Yziwf7FYiW2/OeOU5S3Rc8IxTeY26Hm7TV/mZpJs2PUeBo9JaB5
	s3JjHsAmst2gHXdXVLKwMLO/8J+pzvr0cnBY8GRDlmcg8pQjV+8ZXjPm
X-Gm-Gg: AY/fxX5c6T9RAWRbme+8NhEt2Qe+UGgitBzcZElvSeZk1Bkk/G5vjtyBBIF/fjKi1y9
	GvdSBIzmdORwPGcwzccYatlQxmxrnGMIjOV0pWjnX/50UeVzpLkwRSiyMjUdUKyhZ4c2JJEembN
	LnPPrLqJpi26mBPzpLjvvd3AR7vnVJbxWqhmpKaaG9/k6h8dH8vRQWiF0kaxVcjBWJ2UtTaV1AP
	7l/yAjSJUUvOVwBY//RyU1crxPj2D7fqqG27hkqPNvKuif6MLQnkUSAYkQHwfDsrOecL32dPnzf
	t0PqtMNR7nrQaegCIuLKS+X66ue87IJe22FQ5isviZacErk3Hz+zmq09mM1yrwbKZLFJSiofe72
	O8ZwE5/3lBwVW1e9VVOq2qSJeNIQm3y9m/aG5x7dQLxgv9pj43xe5+tdzTfwEcaDN7zURPvuqF4
	k1qu9BQo9J9U0=
X-Google-Smtp-Source: AGHT+IHxI4NcgLibs10P8ERS3NVgrM2LIUaADcTQVD2Njbb3HrKZvZOwi8s+0QzT7KTYaYP7ns5RbQ==
X-Received: by 2002:a05:6000:3111:b0:430:fcac:24ba with SMTP id ffacd0b85a97d-430fcac2aa2mr16838373f8f.36.1766065706795;
        Thu, 18 Dec 2025 05:48:26 -0800 (PST)
Received: from [10.5.0.2] ([45.94.208.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934cf5sm5193168f8f.1.2025.12.18.05.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:48:26 -0800 (PST)
Message-ID: <88efd2784c9fce72e432a59a03472bb4441e975b.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Dec 2025 13:49:07 +0000
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
> Not all users can or want to use the device with an iio-backend.
> For these users, let the driver work in standalone mode, not coupled
> to the backend or the services it provides.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> =C2=A0drivers/iio/adc/ad9467.c | 37 +++++++++++++++++++++++++------------
> =C2=A01 file changed, 25 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 60fc3361b2689a4c38287c613ef93fe00338e5fa..37b8f88da6681d44f3fbbb6c8=
c171ae7117b9090 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -1000,6 +1000,9 @@ static int ad9467_update_scan_mode(struct iio_dev *=
indio_dev,
> =C2=A0	unsigned int c;
> =C2=A0	int ret;
> =C2=A0
> +	if (!st->back)
> +		return -EOPNOTSUPP;
> +

Let's not add the buffering interface if we can't control it.
Having it just to return error does not make sense to me. This means yet an=
other info:

https://elixir.bootlin.com/linux/v6.18.1/source/drivers/iio/adc/ad9467.c#L9=
16

Also the channel definition should not have the scan index. But, given that=
 the IIO device
won't have any buffer I think there's no way to reach ad9467_update_scan_mo=
de() (unless I'm
missing something).

Still, while I understand that updating the channels to not include the sca=
n_index is very
cumbersome, having a new iio_info with no .update_scan_mode() is trivial an=
d make things
more clear and explicit.

- Nuno S=C3=A1


