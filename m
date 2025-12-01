Return-Path: <linux-iio+bounces-26580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33388C9660B
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0DD6342B0B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB73009DA;
	Mon,  1 Dec 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsgT+etL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB22FF143
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581304; cv=none; b=lxRUw9N6bjxEbQmJ6dMwHHKklZQ03YtNZLiHoCnJLWTmbSQVqO14pYsni0Ha2yT45kOdbxEwU/W899cJUrIpADPZ9usFItx96cBzCiYaOgJEz67VHw9bKRw7CxxsGggfHt5etaSI3me0AfhspFQmyH+rCATyes6wxpdm94UbCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581304; c=relaxed/simple;
	bh=XeJ+8BY6Z0qO3voOXidYlNL9h2fMDUt+xyiiBSqTOl8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmKOb7xqXV3fvpxyviAmn8TlXdErPJFcNwoJ3wlOKiHEg6K7pMfvbkArWKavsnCCnvR7ohXMEa3+3WlEkx+dfKDpmKZ3w2SnGRpJrLNGmY/YF9+69qfNj5TW/vesF65b6vejhn19XyHPIXRJWVMYY1QLFOvIWCjbi+kHRL+ssV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsgT+etL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so26896685e9.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 01:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764581300; x=1765186100; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWM5gUAC6NLggoknpU66m7hHs6PatxwsNQf7bof+L+g=;
        b=AsgT+etLvLxMDDfRHoPj/0nXgk19LsdLRj+3fm+tRp1VKilik9pRQv5uEH/OSybmVB
         +S+faL4VUT1mPc/rUaYfSJtM3c6ntMtdPX7ChJSHig2jeiUGEQElEigV+tAgrgMK34hS
         GEz6a6D4s7IcE7PL6mtKuiJm50jfXrZMxvlCCifCecBlKmIpXUeNZB5qaoucYUMEaMAw
         NUnvBcMrA2sB4yBlLXGmfO5thCsHr6Zr/AUHhBN7Rj3kcAEWCEcs1a8fX8mrHkepy070
         REMauT5wfdLwfG5Pbgg5IxD2P7Ui18zNh/42tiDQxPvgkKVjjBtRDFh1VhdT9G2XuPuq
         nHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764581300; x=1765186100;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWM5gUAC6NLggoknpU66m7hHs6PatxwsNQf7bof+L+g=;
        b=YrCFQdG00saJ9V3ZnawrIj1PvLO4XwKG0be9nh53uPrlVjREpNrlGrueLX/RQcsvP7
         +0VV0/77Od+H30S3zS/yqNPezk/L+7sNUIx8kC+JZp6kJoSA0Mu1FDNg+YuC0qlzKCAR
         i8KM237x7kreE3+YmTaaD4ETsxVj687rus9Tnc+5luqntc1OQ5nr0wU+FFG37FbNrc02
         rxvd7Jrt1biQRuC7rz85NBaYJGTZnWkhFqMSyKpnctDJf4xgn8Bl6+0tWZMPHafRNeAC
         tSaqltUsM3ZzQRxnD06rDvuHF6ZT/0bwTnaC1BlsB+4QYW+B/NEzXkO2StDOqwLCjR6L
         i3jg==
X-Forwarded-Encrypted: i=1; AJvYcCVKzPbfCzonNv83fcau5pvbDAUyjFC49R+KIdu1dKtS5DCOHSh52Zi06NmSsj4cjq5N0LkzabxRH5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRcubnwARxwlUTVdOrGsrSlB3xYZwXOVd7OTVhn3QonxPIJo4
	HhSSOSSphny+KIov7PpB0HUqHZpjNhT+SczoMhV3TaCsWX60y7Tavi2A
X-Gm-Gg: ASbGncs9/az9655X3jANHKAABq8Mthe/jIXx6be92cg2VT3d/It9m+GZOPxgKi6jn5Y
	bYaHPj5BF/QS8pZMH/nz3ae4kNvOodOP5WFSJJ1aPgRrY7UMBt7RAAOAieK8AHYYiatAVm4IxX8
	0XFXTESqLWsbVxz8RbYEH/z+S6FpInRHzHDWCRkSikHxbEidk1nfBsOf3uAvijd2RbJz2NJvHvX
	11UVKpVgcPluNbd9GU4OgC/9gbZlnke2BiqPs0gGVJ1AFXFpbuZE7vg2+CDNxm7eWLQFBG8fqhH
	VLQ99deEIvwKAPuonPOuy04V5OJJHwFvOTxwCpoFl485LOS3+EQyTfmJ1V3kCSJh4aIpn03qCrl
	5X+wWSojerl6HTN5sXNbTtNPYx74SexbcNavwbrKs8zFJkfHPGAI5LEJyOCnvnEeYYjTY7Z40l0
	IYNtdllg6P5XETO3zyokXMrgHjFetYbcWb62g9u1fhDHDTcRzsdwuAJw3F4n8=
X-Google-Smtp-Source: AGHT+IF7VSuwlWAm02QgNj6nGf/KE1Sf5fi3Zg6t0umFUee3c+13DG9VIM3IyuKco947be6sfmeM+w==
X-Received: by 2002:a05:600c:3b86:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-477c10c8038mr371392765e9.5.1764581300202;
        Mon, 01 Dec 2025 01:28:20 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479110b6da9sm239410085e9.0.2025.12.01.01.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:28:19 -0800 (PST)
Message-ID: <ae499a34490566cb2b1cf18ba92adb4e67210da3.camel@gmail.com>
Subject: Re: [PATCH v3] iio: accel: adxl380: fix handling of unavailable
 "INT1" interrupt
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Francesco Lavra <flavra@baylibre.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 01 Dec 2025 09:29:23 +0000
In-Reply-To: <20251128172138.257961-1-flavra@baylibre.com>
References: <20251128172138.257961-1-flavra@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-28 at 18:21 +0100, Francesco Lavra wrote:
> fwnode_irq_get_byname() returns a negative value on failure; if a negativ=
e
> value is returned, use it as `err` argument for dev_err_probe().
> While at it, add a missing trailing newline to the dev_err_probe() error
> message.
>=20
> Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes from v2 [2]:
> - added missing trailing newline to the dev_err_probe() error message
> =C2=A0 (Andy)
> - added Andy's Reviewed-by tag
> Changes from v1 [1]:
> - added fix to `err` argument passed to dev_err_probe() (Andy)
>=20
> [1] https://lore.kernel.org/linux-iio/20251126144624.24512-1-flavra@bayli=
bre.com/T/
> [2]
> https://lore.kernel.org/linux-iio/20251128140726.243005-1-flavra@baylibre=
.com/T/
>=20
> =C2=A0drivers/iio/accel/adxl380.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 0cf3c6815829..6d82873357cb 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -1728,9 +1728,9 @@ static int adxl380_config_irq(struct iio_dev *indio=
_dev)
> =C2=A0		st->int_map[1] =3D ADXL380_INT0_MAP1_REG;
> =C2=A0	} else {
> =C2=A0		st->irq =3D fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> -		if (st->irq > 0)
> -			return dev_err_probe(st->dev, -ENODEV,
> -					=C2=A0=C2=A0=C2=A0=C2=A0 "no interrupt name specified");
> +		if (st->irq < 0)
> +			return dev_err_probe(st->dev, st->irq,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "no interrupt name specified\n");
> =C2=A0		st->int_map[0] =3D ADXL380_INT1_MAP0_REG;
> =C2=A0		st->int_map[1] =3D ADXL380_INT1_MAP1_REG;
> =C2=A0	}

