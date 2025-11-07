Return-Path: <linux-iio+bounces-26013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A6C3F689
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E45A4E5FD6
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE0304BDA;
	Fri,  7 Nov 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Pke54a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517063043D5
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511114; cv=none; b=IFpvetR+gnf4/qupK50XlNtf2H1GkCZlt7xHnv+LZQHtm9RjhM45zobz0AEJuVDvGWelTzWBOkapEzwcwhocVKDD234UfsJS8koQj1x77oR0F2LZWXBmOVsHdoZUqRuwC+bZ/0iwUNK2/8E7WL5VN6Ivnto1f3wv/IQeee/a2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511114; c=relaxed/simple;
	bh=IUUYLHIKD4aI0ypLpcDmYUaYJJUxDWp5WxLqwWMOv3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBer1Znh96i3MP4EECx5E+HuWuxtxT8llDKLqnIp90pjR8Sm0xbn8s1vgLhRyk17SB/qxF+D/yMBqMgQ/+xuU4vs3ExBjrmOCyjISacL8EhZFnS/6GnLrsOq0Piq1g8NysRTY5WhOiG5757lv7lDkvxf8FlBYxTsaAvZQ32jo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7Pke54a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so267970f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762511109; x=1763115909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I5EihXK8u2Mu0aJRNair/6wLWw4qo22bIK0FioiBQgQ=;
        b=g7Pke54ah5DzMzyx4yVYCNsZ7WB0GURZZYvzvmHm+RsHBNo75i2iNhqlG6Mn20xzhL
         x+CP3JZLvWSYXp/SMaRjqU+CtqNAQqu73MR0MYahssSFbkCVlu3OwLZzu3SZLXe8gQiK
         MjJKiv0pgtXJyQJmabRI9TFCsGYgTcY0E3XSwGK18HIXdY70kbMsBR70+Wzj51csnKm8
         k7MJJOeyeWJLi7CTeQdouZbyj2Xj35zH+ft7M1t182z+G19ikM0ymAZziH7wM27RHX2P
         6UaicQ9fQ38QLm4nkdGC6U/MEY/xXgjwEpcersOWvcRUBb1tUIOL6usNqDn6gZqv6n7d
         zTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511109; x=1763115909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5EihXK8u2Mu0aJRNair/6wLWw4qo22bIK0FioiBQgQ=;
        b=eKdcfTpmfkrZ50IqPuLr2BqIEK/944EIanCjBtKd0/zi1THVRu0VRjoNwBSyEMPcsY
         iUdBoBwa+NoShBLcyLCkpZVeRzPQ2YRc5DvdnnJiM1nBQmv7BFo3kVoB1dmvx/nMy2XL
         LRuMVZgQq8JHj7a6rLeuBWMVkKC1W9zvtltyPhUHTqzJ4vfrPppk6zLhD0vFNFMh9n4R
         c/ClR4GGztCVifeU5t5a7YkRYK5lF880SFyFZ9FmMTw0ihGMQUQzeFIJGb7nrfVCArBm
         mf2jHiyF7RrKrU2RTY0TLeUmNQpP4FwDfGEiQyFEVffVEv1mEAR3yofwOA/0IA0h+xeK
         STHg==
X-Gm-Message-State: AOJu0Ywuk/t+A07/ak/iE3nIYDuvGuhG54yzo09DGdkE6UJ/vLWi6ozu
	Kmr4AQ7K+4VB6r9nmmbxz/an0f4XSG1ME3SClTGvtvQBJNqz5tLzbnRQ
X-Gm-Gg: ASbGncsFqxh1wOMYt6Oik/44EH0kwtGBrD6ov9skCSD3OHZpD7animsD2X/M0dukEJF
	GLSvj4MwXbZPth6SotmRqrdCIG42ohUSAMH91nDAdH+Q3ysjlL0LeKvqS0NKRpj3Kc8ss3EF8oM
	uT3nSwr/9gjIintyBQr1qETYlHG7eh2jwkObs4GICOVXcS0VIuug6dc0koIDepoUXh4JwI/Z6CI
	mRENhcM66tpx7TFriM5sMgQm8nYad9HOOnM+HKvWz48wslixnQsckDMQ9F7n55b4q68/vKkDuSk
	SF4g8MUIpQjtqzNwO6FjbO5q0Xc1mqb5ZG4aMOJnmDCTq0gC/27poRenB5PmJ4VubKHMFqIUMkp
	Ohyw7/PEeiPXUCK1b8Mz0CE4TxP0jV1EvVnTCUXYYqf46Tbg+XxoRtkUjvNMlR1T0Yp3FRW9o0c
	7WR0v95CR6JbrdT8IX4ztxlXVhbZ/Ka3ZOqFE+j23aaqVtZ1Z1
X-Google-Smtp-Source: AGHT+IHQyUK4Su6rUoIp8KEg7T5eItbPyqxA7l8hrPET/61ltVWDpihHlU5m2GmVndigldsxCL/WvQ==
X-Received: by 2002:a05:6000:400a:b0:428:3bf5:b3a3 with SMTP id ffacd0b85a97d-42b26f4bb54mr1102527f8f.1.1762511109312;
        Fri, 07 Nov 2025 02:25:09 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675caecsm4523252f8f.30.2025.11.07.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:25:09 -0800 (PST)
Message-ID: <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in
 viio_trigger_alloc
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Date: Fri, 07 Nov 2025 10:26:10 +0000
In-Reply-To: <20251107020200.6285-1-make24@iscas.ac.cn>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote:
> viio_trigger_alloc() initializes the device with device_initialize()
> but uses kfree() directly in error paths, which bypasses the device's
> release callback iio_trig_release(). This could lead to memory leaks
> and inconsistent device state.
>=20
> Additionally, the current error handling has the following issues:
> 1. Potential double-free of IRQ descriptors when kvasprintf() fails.

How? If I'm not missing nothing, your patch is the one bringing the above
issue.

> 2. The release function may attempt to free negative subirq_base.

Same question, how?

> 3. Missing mutex_destroy() in release function.
>=20

Mostly important for debugging mutexes but not super important.

> Fix these issues by:
> 1. Replacing kfree(trig) with put_device(&trig->dev) in error paths.
> 2. Removing the free_descs label and handling IRQ descriptor freeing
> =C2=A0=C2=A0 directly in the kvasprintf() error path.
> 3. Adding missing mutex_destroy().
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> =C2=A0drivers/iio/industrialio-trigger.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-
> trigger.c
> index 54416a384232..7576dedee68e 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TR=
IGGER);
> =C2=A0	}
> =C2=A0	kfree(trig->name);

Not that this is a problem, but now you can actually get in here with trig-=
>name =3D
NULL. And typically that's not a get pattern for your code.

> +	mutex_destroy(&trig->pool_lock);
> =C2=A0	kfree(trig);
> =C2=A0}
> =C2=A0
> @@ -575,8 +576,10 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0		goto free_trig;
> =C2=A0
> =C2=A0	trig->name =3D kvasprintf(GFP_KERNEL, fmt, vargs);
> -	if (trig->name =3D=3D NULL)
> -		goto free_descs;
> +	if (trig->name =3D=3D NULL) {
> +		irq_free_descs(trig->subirq_base,
> CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> +		goto free_trig;

I think now we do have double free of irq_free_descs(), or am I missing som=
ething?

> +	}
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&trig->list);
> =C2=A0
> @@ -594,10 +597,8 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0
> =C2=A0	return trig;
> =C2=A0
> -free_descs:
> -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> =C2=A0free_trig:
> -	kfree(trig);
> +	put_device(&trig->dev);

Yes, device_initialize() docs do say that we should give the reference inst=
ead of
freeing the device but I'm not see how that helps in here. Maybe initializi=
ng the
device should be done only after all the resources are allocated so the cod=
e is a bit
more clear... But doing it like you're doing just means that we might get i=
nto the
release function with things that might or might not be allocated which is =
a pattern
I would prefer to avoid.

- Nuno S=C3=A1


> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0

