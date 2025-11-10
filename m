Return-Path: <linux-iio+bounces-26137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41DC47555
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B78E1884D84
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468EF313E21;
	Mon, 10 Nov 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFWpkzen"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31F23C4FF
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786166; cv=none; b=mRF6JTMjGZrpGDcaz9OTZIIODMiTBChmnp75sAxnG0pABRPtNu3zzwBu4R3ZGbCXFVQrt8+h5Ggcclp0T9uBbiIEKd5kIQYP8NPmNNdJyfQn+CS+Y0EmjFdEm/YO1Ialm0dvxhQYKtTxNP9d2xtzXqBh/Jgt2G7Kz6mOSfop8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786166; c=relaxed/simple;
	bh=fj1lgNaqat0WAlpO8teOq5f/zGFKDOK7LqmlNPzOs28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E8eluGD3KxU/mNa7KEmglF5a8LaHWFa4GuFOPFDIsckp7u4ngC1MOb8QXqCMhMCRb7Qfj/GbadA1lzra+P3riSQCgobWQgtCqvGjBVKF/KlezKfwX5/Ex2Ee/LtY12M9BK8QHJHIzn+xSXWdpz/5t7JEr5No5QDzpQWgiTmgrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFWpkzen; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so579740f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786163; x=1763390963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rtwHEg8AcEZ1RJZW5TUVf80IN2gTbqjeIF8J9dLK1i4=;
        b=KFWpkzendZ1grw5IfI9Hl6ZrCXpIXCwg3kYWuXAvDZEGI1J4+uFP9OnyWhtyJp5xFU
         b1s8Tx1zj8/CcCKOxL3b7ziLXL4LZYMaTdqfs+QF9P/oNQzgr/Cka9NCKdO5WB2UYsZq
         ISYrit+eN/UvWFAgfUIEdAnxGvUgdUBoa/tx1yJEWzUGq4hkDnErMuiGTplntjwzztLP
         Sdd3IDe3rgJfwdpbgmZCncwM5b3hJ9mC1r/d/B6eupG4je6p/D/B0z9YIvnjC2y5/MGG
         wVq0mrHXVQTeoSSFaoFTpeNi+IWr5TcEBhGq3NaUOVHGAoIiDDojun3WPQrNSteMUPmL
         7gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786163; x=1763390963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtwHEg8AcEZ1RJZW5TUVf80IN2gTbqjeIF8J9dLK1i4=;
        b=HcvjJAQkd0hEHaWOMZi7cmqEj88T833j0Sc8dw9WZ7u3vthGD/5tHiB8sh5Tv0/H3f
         hpMmofez1BxaaWx51BKZvLLLGDBrhxou+1BEi7Z6iNBUevJoWqNkqWyxfcOxmGm2L+wC
         Fd2Aaz5VxDkigV8Pu0ehXnDrdVmaIaeYmcUGS96N6CY3Hv7HHpK550zd+UbeD63vigZ5
         zVEZT8ONwQ5OUHzUOGQSdkGp8TN7T96KJzo/fxUrQF+BVdiyNxAym4FJkjnOF7wvGzfI
         cSFWGuSXmZZcLtj4450tbs2i8J3d2od37sUHR9e6lBwPNovOBqQ/q1+FXBM/xI7YxmFV
         YKRQ==
X-Gm-Message-State: AOJu0YxH62ScrCDQ3Slsullr5YHj/yMWqU3SjlArDcaMmDUkgOT2qrDM
	CsAWzZRRpfOeKMFxxMdFUqRAJhX9WwEKQHVscR9amNl3K6Caskt8vk4q
X-Gm-Gg: ASbGnctHLRvnwKNla6XDcxkE04uSuC5h9F2nhc/Jicy0wTTweO8z5PLb+Jh+KmxL9bD
	PtsgHcU9/gy6nXR2uF+sz4Xt67SjwTqc79aK8Z6mHIpC40vRFEG/nNHvdJwLrw6k0/l9tnY0w6b
	hROeKSiGN6rNQTxEdRVNKdNsAiMa/upTzAoWKFE671X2QywXCetTWsunJbl4w3Ss1aj3LejMfTG
	iLtsJOOL0SCOXG6yujojcgbVdnkMiHNJM/wG0tXn1v/Ju+3UVbZjQZFvq6CYCNeX5TB6+3EGZ+t
	uVXPfKcT7fk4YJBMklMe/klfDKNf3jLPaSUFCsMyJu7A25AAK41vwLzVXn4yKd6E/PdAYYCWTia
	k9v6bnTSEo3IY24r9HBKTuoXb0LYc73vPGuE007yhrrDomVibBlK7FIwk+8kA+erVe+fKbDLzmI
	E1bEuoOd8miCkRzQ3cvTI=
X-Google-Smtp-Source: AGHT+IEOESIpSzas46jUxYDZXLiicWyoxGFZ51X/ZIxX8n/fWi5wNV9wtaFsyvpMDT/n0KzMw/ZuEA==
X-Received: by 2002:a05:6000:64d:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42b2dc9f1b5mr5675297f8f.43.1762786159884;
        Mon, 10 Nov 2025 06:49:19 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2ee2ed31sm15770160f8f.29.2025.11.10.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:49:19 -0800 (PST)
Message-ID: <e1b6d5d1fee6a6879d94d22d95a15fbdf5d47231.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: trigger: fix device initialization order in
 viio_trigger_alloc
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Date: Mon, 10 Nov 2025 14:49:56 +0000
In-Reply-To: <20251110035838.37029-1-make24@iscas.ac.cn>
References: <20251110035838.37029-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 11:58 +0800, Ma Ke wrote:
> Move device initialization to the end of viio_trigger_alloc() to
> simplify error handling. This follows the pattern used in similar
> functions like spi_alloc_device(), where device_initialize() is called
> only after all resources have been successfully allocated.
>=20
> This change eliminates the need for complex cleanup in error paths and
> ensures that the device release callback only runs when the device was
> fully initialized.
>=20
> By moving device_initialize() after all resource allocations, we can
> use simple kfree() in error paths instead of put_device(), making the
> code more straightforward and less error-prone.
>=20
> Found by code review.
>=20
> Suggested-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---

Have the same question Andy has... With that addressed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v4:
> - split the patch into two independent patches and modified according to =
developer's suggestions;
> Changes in v3:
> - modified the patch;
> Changes in v2:
> - modified the patch, thanks for developer's suggestions.
> ---
> =C2=A0drivers/iio/industrialio-trigger.c | 13 +++++++------
> =C2=A01 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 5baa83349e8f..760ae3e60639 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -562,12 +562,6 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0	if (!trig)
> =C2=A0		return NULL;
> =C2=A0
> -	trig->dev.parent =3D parent;
> -	trig->dev.type =3D &iio_trig_type;
> -	trig->dev.bus =3D &iio_bus_type;
> -	device_initialize(&trig->dev);
> -	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
> -
> =C2=A0	mutex_init(&trig->pool_lock);
> =C2=A0	trig->subirq_base =3D irq_alloc_descs(-1, 0,
> =C2=A0					=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> @@ -593,6 +587,13 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0				=C2=A0 IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
> =C2=A0	}
> =C2=A0
> +	/* Initialize device only after all resources are allocated */
> +	trig->dev.parent =3D parent;
> +	trig->dev.type =3D &iio_trig_type;
> +	trig->dev.bus =3D &iio_bus_type;
> +	device_initialize(&trig->dev);
> +	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
> +
> =C2=A0	return trig;
> =C2=A0
> =C2=A0free_descs:

