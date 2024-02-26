Return-Path: <linux-iio+bounces-3078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4048866E6E
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF9E287248
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71C5FEFA;
	Mon, 26 Feb 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETgCSRko"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79B5FEE0
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937359; cv=none; b=W1x6CMh+q7XQ4H2COJI9UWfi5sYaWuETYr4Zc7nV9q4eab1CVXh+HPyYRRsFJN9ihlyOwNu+wObrYC2m1hUYRWhe/xo7EKmg8wY1becShjI3GllwurtJgEYJzbkUTP/V44g8RZ1ppFDFFBFk1SejRkmgzTrT0+NTKYtcaaCs/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937359; c=relaxed/simple;
	bh=8d3rx5uTpmq9u8e9gSNvAI5oP73wSuUpDguuMq44uBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFN99gCixEJBcDBL+5NqiUcb1p7XwhDJqrBHc66tp7JTa5fkjO7SNx7sE/Cy5LLgMsyNeX0uXkdu8gNWFXBAMMRxzPS4PSAQ7yqfQYiTRBYVL2ifqGxdQem+9FpqdqRgZmjbCnK80qgh/SmfoqnQ17C3hvnmNDbJL82uS7pnqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETgCSRko; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so407617266b.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708937356; x=1709542156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmFMduQGP3TFkTFmztBvmZXlRxofvS4kk/mGnoUiPL4=;
        b=ETgCSRko+GDOThP9D9foJfYawnSExbf1dI1K06UtZrA5W1mCyZcbWn/g575WAMMDc+
         R8FbBHTuLYRU349Uoq5YKajoELeQ7WEjjiuvv04ppwdhzSZh7TSCDBW10kygjPzihLVG
         SNB59j3vcGy3iFLueh2QR3Jy3gegdKjhFJuK508FKgPkBF49GgNSHSpKhTAlIaYpJzy4
         AHBdFPB97BHLm76VuFpi0TZIKmfEcKp79Z5n7Lvz4wxk+YP0vaYMl3l7ls5sDle8AAVW
         szf2M3MXpcC/w5md2iL5pdTy7p+vbstk2SLEuE0hdpC1n/+MKJkfR63c8ckCyBvjAwDM
         wGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937356; x=1709542156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmFMduQGP3TFkTFmztBvmZXlRxofvS4kk/mGnoUiPL4=;
        b=lBU+GkDGSTEVIooOIXq/MknPwQIKu2eFuCN3EMDXyBjlCsx8Wm26nrCgDRc1qjE6Gg
         C60iFg1aMQOxAo63dBm6V8TabBCJDzdqUPRmZKDkzgdRk5+VN9+UxtERg1uRsp/v3q1Z
         rzx3hJ2zhD1QNc2Coogp4eq1mhfCAWyCx/L1DdvSPYRtDjYxHG0vfv4Q7MIApYbVJjCb
         LUXFm4zOf2Rk5BpeZIXDBlUUAOySnAD4ZKg8gG6D6nKPRD7UJWtVxfrZjW08tRWM7LFS
         fpyQ7xZic7XEM2zzmTM0Pt4tQxg9bmsdgD8oLcbNLvUVU4vHdUYD46iXHMrhIw4Y0hj+
         DxAw==
X-Gm-Message-State: AOJu0YycjULlScfrb6uE6vgmPkpuxlxK8xpJxQSivBFbvZ5bXmlKoETt
	sYtyQzTUpSsx5yVGnWzwRs/VlSMffzHxIBMb2SORK+JdT2l9s6dw
X-Google-Smtp-Source: AGHT+IEN49/vywLamOHkT2SPvfTjxo7PHeMIuySx1BUjV2UcVkdkt3eVONh9M9IT4aWN65P+TTycyg==
X-Received: by 2002:a17:906:1159:b0:a3e:feee:3a5b with SMTP id i25-20020a170906115900b00a3efeee3a5bmr5314190eja.3.1708937356032;
        Mon, 26 Feb 2024 00:49:16 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402320e00b00564e4debe29sm2155272eda.78.2024.02.26.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:49:15 -0800 (PST)
Message-ID: <cc6131b2a2da98a0546ea503f52bb87a549a45e9.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] iio: core: move to cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 26 Feb 2024 09:49:15 +0100
In-Reply-To: <20240225123600.301758b0@jic23-huawei>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	 <20240223-iio-use-cleanup-magic-v2-1-f6b4848c1f34@analog.com>
	 <20240225123600.301758b0@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 12:36 +0000, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 13:43:44 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > Note that we keep the plain mutex calls in the
> > iio_device_release|acquire() APIs since in there the macros would likel=
y
> > not help much (as we want to keep the lock acquired when he leave the
> > APIs).
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
>=20
>=20
> > @@ -1808,29 +1805,22 @@ static long iio_ioctl(struct file *filp, unsign=
ed int
> > cmd, unsigned long arg)
> > =C2=A0	struct iio_ioctl_handler *h;
> > =C2=A0	int ret =3D -ENODEV;
> > =C2=A0
> > -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> > -
> > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > =C2=A0	/*
> > =C2=A0	 * The NULL check here is required to prevent crashing when a de=
vice
> > =C2=A0	 * is being removed while userspace would still have open file h=
andles
> > =C2=A0	 * to try to access this device.
> > =C2=A0	 */
> > =C2=A0	if (!indio_dev->info)
> > -		goto out_unlock;
> > +		return ret;
>=20
> return -ENODEV; and drop initialisation above.

Ok, that was actually what I had. Ended up changing it because of the sligh=
tly
smaller diff on the patch.

- Nuno S=C3=A1


