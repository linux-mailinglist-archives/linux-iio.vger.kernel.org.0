Return-Path: <linux-iio+bounces-17778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1BA7E705
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6250E427490
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD29209F58;
	Mon,  7 Apr 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUiHVXtV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F520C033
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043841; cv=none; b=caI5fzjaWq2VRE//k6F2IpezjL6XOmOtXVNwxa07iaR6YImHEVEdlJ0V9B3Upeb3Wkq5gkldxhTw4Kr7zD2wafUuZM+CgNLKRvS8FhJZIf6LDziiApxqt4HdB9Otfq2aOoeU4PuWXPMNZmdxe9P4ZJGDm0vrxDS8uujyKxHrDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043841; c=relaxed/simple;
	bh=gq3DDgD92ZsTPt1ueTw7FmKGHgBCFZs58YvBbWwOSto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hrDvxY8cqXBQtrPzckXMssRTkDsKiMLRxyns6GeAopb+xnmSgs2s9qUhQkN6vjKBZob+d3QMLsabolJ/r9s2c1h4yx51/aTcxMLf3PGRmdHsa1uR62OYCuqJxuZrWVPYryf1gEPSFvFiURPVepvixLhSYPoVRcAky+R7OS4kYYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUiHVXtV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f391864so2556933f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043837; x=1744648637; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=le4Q5BjP6zbfEcr8rlr5Z1kjBAX/LL50bEOz0NXZ8/o=;
        b=BUiHVXtVzZZKSy8DSKvMLl3eh0050LCEtHlXtT28eh/cx0FKfVP9KZhpGNJ4a6lT8M
         UKNvPRusAyXCjVpY8Jw+6uvC8WrOqqzQWPhrPyDWYkiooiKJ8zId5b73Pku9tAWkioi/
         8gWBwVHoqeoJQujVtxsWoBpRynFT4HtijrpxsZW5ETtxZy2F/Av9+fBRFqi5ZpSeslzY
         icIjqoWh891fasZ/Dn+NXVVxX+HA2qkOoKtxkbMyl8Sv9Q1tuRq+BGtk0s2V7ZqvlIiP
         e/YSpdOnw2mxsL5pYrLv26Qrc/6JKMRPUZVB0cAU/9+Tj3lNSTxdEWXbHSianeYfun4G
         j/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043837; x=1744648637;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=le4Q5BjP6zbfEcr8rlr5Z1kjBAX/LL50bEOz0NXZ8/o=;
        b=NaVqhDkWXA+KLw1wPEJ26BsR6zmPfXPuyIYWISHpnytX0iLa0Cr5rzdsaTRs90WQ/d
         W0YLSk+HZFc4ZraIo7CPdth68Q229hrEFLVXe3inV7HhJq4IHvI0pFlPdjbOrMh1EaJV
         pCQn8v+ew/cD72T5UXxfV31WOMkaQUX2F3ZTD3r3/pThcPQsB2nzPltmwvRNv7epvBzZ
         q+bE/EjpJKe2ITlfYawDQXQ01csjwqOI/95/hHpziCz/3xgt65GtBvCtuciw3IEgaieT
         9IzVyVF4IodQsHrKr72zyhucysQmmfNoGJqhsyEkTsg2561hSPaPo/VEg8XTZiHmnMBV
         JspQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC6Xj2AhqAS8/hlHfgvk0CcMxp5Fb1HiDZs6Bx6OZeqodrkolIC5sCbwXLIF55BJ6vfgsXb3rszCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV54X05GZaMITz9yMutwdXss1X0V8cv5IHuc25AEb0ckvVNt1f
	V7iieq0xxdNg5Bq8oRZWT0PyVlnI0XHrBrQHECPAkfH8c9XuzugXZAuC7Xk5mY6MGA==
X-Gm-Gg: ASbGncsNgrIT/sJcOFspUjhCp+C90LWdaZAf8R2Xp1C0loVHgXYKsFHLD0JcWhBEQ66
	9gmp+sW2TGFczeo1pBUGIcyjIHKGgcwmp4aNxG2ZwZhRaZ9T8h8sl4GfWWpUUfgud0wv31BJy7e
	MrEdq32l9LCxwuKT90RKGjjOHdofd2SBgTlQCT1TjC7HBa5+Ffq/JPuWzQvlykvBoFgWyylnS4p
	plqnH4KeCSXHWS8AjTsodM7gBc+6qPte/8xddsFhEt9DVCtNgZDbUZTG9dqmatNHEYpuX46LsvE
	ZNGJ67MMlEDdwzLhrqVeKL2J2sJhdynBgggNGajTUJ9r25uY8kb88oCuH0YIas/BvB2H/RomKMR
	TOvkVpm4NeKj361UpYBf751F4QqI=
X-Google-Smtp-Source: AGHT+IGQtNMQr7Y1jtM5nLdXoRW90ure8OiZz/jDu0B8syNRTmr0JvaDURJqFPy9OwDdCuKx8Ia69Q==
X-Received: by 2002:a5d:64cd:0:b0:390:eebc:6f32 with SMTP id ffacd0b85a97d-39d1466220fmr11008006f8f.48.1744043837588;
        Mon, 07 Apr 2025 09:37:17 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226cf6sm12416571f8f.87.2025.04.07.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:37:17 -0700 (PDT)
Message-ID: <1a199f11deecdbd692573dbea20860764a29d38b.camel@gmail.com>
Subject: Re: [PATCH v2 07/20] iio: dummy: Switch to
 iio_push_to_buffers_with_ts() and provide size of storage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 07 Apr 2025 17:37:17 +0100
In-Reply-To: <20250406172001.2167607-8-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
	 <20250406172001.2167607-8-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-06 at 18:19 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Provide the storage size so that the helper can sanity check that it
> is large enough for the configured channels.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index eca5f0652d23..7b5adbb4a422 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -74,8 +74,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, =
void
> *p)
> =C2=A0	iio_for_each_active_channel(indio_dev, j)
> =C2=A0		scan.data[i++] =3D fakedata[j];
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> -					=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Tell the core we are done with this trigger and ready for the

