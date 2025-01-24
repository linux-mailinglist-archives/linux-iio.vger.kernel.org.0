Return-Path: <linux-iio+bounces-14551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF7A1B60A
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 13:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A3F188D2C4
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5115C21A45F;
	Fri, 24 Jan 2025 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M19wSEWl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3514B956;
	Fri, 24 Jan 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721968; cv=none; b=idbQlp6alnds4mpIEWshB/BWEaqa3b1Br4DjLBK/PNFKDHTDiB9Vb0jIC3PPw4FgxcJPtxEJrSeEFzoUNbTIVDRMH2ExcYU6N2iYTvy091NK3js2uDqF6FH1pGFXri+XGn8Y8cNKx10NPNKSj2vNHCz+R7d4ciFUcr6UADBvI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721968; c=relaxed/simple;
	bh=creJHP7QhDliPliNEAUY+MSw2UqmWBO49Cx+nD2MXzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRIlwjRUkXN6cB4CW+VXBbTaQny6JcjdPXNMd4WZi/78oMiRi/5PwbDKKuDZ9TCXyQpPaWHYRbLQX/SOXAHn8rBYk+b+N7E05POBQ9qT9GwNe1UIX3FCCIWcUc5Fay+XrOGGyuhkS7dzf3oTjq5p4Ms0kpE9FLEwA7OQwbC7Xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M19wSEWl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363ae65100so21589305e9.0;
        Fri, 24 Jan 2025 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721965; x=1738326765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tfWjyrBh60o5DYmfZkgIkHQccHfOP2L2jkkJtB4HFNo=;
        b=M19wSEWlqZVdmvzdPE35NOY2Z+CV9N9jpYSOlsnxeJswROJ7ThlUuZi8kzAIh+ILtW
         BHxGaUJISpWaCRy9SsPZ0aC5/XZ/jLJ+V99ftg3rLy8a0HYbuHQFmzJjEMbtAjyc7S65
         iPR2oAE0qCq20eF1iY2roK752oqWlHi13MVwzlg2IHHCIPzDao6yA67WeUIGxGhciJUJ
         7TDtFnAfoKn3fpXgZzvPzcXvcX1O4z4hp783jdhBT4HxqGYT+Udy3gi6kET8XcA8Mq+D
         1F4j2zKdk8l0jmRGwn5C5rEYaBrcdPinMQcEqZjFlk9CZt0x3EgU/HGh+dV5b+4ih/ca
         ZL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721965; x=1738326765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfWjyrBh60o5DYmfZkgIkHQccHfOP2L2jkkJtB4HFNo=;
        b=YL1Rsn3cf/QBC0CC+rR80vXx2ICL7DL34Eh/BVWbaznFpNZbNBynVUAjCoAnMktIl4
         JwJuLv+ALhwfGwjAX07rGl+qLQrP5e99FdS4NifWQJQBZgPOGAsfKQ9pcK7o5+jD2lmR
         0bMNeLy70XSmsZjPeGN3bhmtrMUmwQvWHv0KNVX+b65rBvih/RXLsK9tr+G3szyXMirv
         Y/leg0pZ2wLLVamGrkXFoTFY4GE34EhKdSA3YPXpcOjAi+5GsYA0Nz/oTbITfMgeX8it
         ZFR6lZwKVt4nh0WAnFa/Q0AOFjHbSz7OAzWQ3f3OwEK99/IceD3V7IIR6P/z4MGIgLXC
         6JaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoXyfzv4SbD/duHAKmnGATy0hWbPLQ3OgzTQL0N98Mp0qs0nQuvz+lsolIVK9F2Edz/UJQkm5F501kdfmY@vger.kernel.org, AJvYcCUtODRKLRhJwXsuMItZAkvrnzE7u8P6HE0vwNQ7LgNHQRfIseOBx/zMeZyKQ4De+1gkSPL+cYv+O/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIOly9tZhNevDIUoB8EZ9dwdNlVOTg3IhTbdWDTAE67ZJD1km
	VkgK+mFbACoQdi6lGzRGK8kXEbKUeSd4pefQKE7w7kRvh0VOnDoLtxgtmqJZiNI=
X-Gm-Gg: ASbGncuErKnsAsF/5taqigqLY2yzhxsjPwwDLpuTjaQfMYtd3Wr9ZaF+iMzYuB46noh
	hbUHzu6VGxrTgJ+8UADE5KWCT3iOPGbWaEeUDKIIJTJ57bs5WR8s0NHBIm6AH0APKDtrN0f8Ybc
	GmgsVf3qBXhalZrL3P7+rST8VmxuvHYs+j/UjtCr4n2Irwqn72kYPuJijAUwaklx3rpcHdR6sRx
	qUlDrVv4noztiKtS38JEpAAWy5cd08xIpw08yxelBnFhiBGcUNNSPkTXkjIfIXA8yqv8OShbBEi
	dbzeoe78kJg3x7huhZfhuw17H02G7ScndkHYTqWv1xqEUBWgwS3s
X-Google-Smtp-Source: AGHT+IHVg6WOb1OvNZTh21gKPi4cfwple0LA84ZKjPZ2mhZduzkF4TmoNfRzCB+tAsTbgnvn6OT3Gw==
X-Received: by 2002:a05:600c:8712:b0:434:a802:e9a6 with SMTP id 5b1f17b1804b1-438913ce0b7mr303512495e9.7.1737721964334;
        Fri, 24 Jan 2025 04:32:44 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b16ff48esm66095855e9.0.2025.01.24.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:32:44 -0800 (PST)
Message-ID: <b0fc02f1f3a6221e12e465207aa606bf15a49ade.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: fix channel select
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Date: Fri, 24 Jan 2025 12:32:45 +0000
In-Reply-To: <20250124113741.36275-1-markus.burri@mt.com>
References: <20250124113741.36275-1-markus.burri@mt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 12:37 +0100, Markus Burri wrote:
> Channel configuration doesn't work as expected.
> For FIELD_PREP the bit mask is needed and not the bit number.
>=20
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---

LGTM. Just missing a fixes tag. With that:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7192.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 1c87db0e0460..c4effe8429c8 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1082,7 +1082,7 @@ static int ad7192_update_scan_mode(struct iio_dev
> *indio_dev, const unsigned lon
> =C2=A0
> =C2=A0	conf &=3D ~AD7192_CONF_CHAN_MASK;
> =C2=A0	for_each_set_bit(i, scan_mask, 8)
> -		conf |=3D FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
> +		conf |=3D FIELD_PREP(AD7192_CONF_CHAN_MASK, BIT(i));
> =C2=A0
> =C2=A0	ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
> =C2=A0	if (ret < 0)
>=20
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04


