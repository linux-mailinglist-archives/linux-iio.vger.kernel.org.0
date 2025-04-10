Return-Path: <linux-iio+bounces-17908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB36A84179
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F819441EFE
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A528136B;
	Thu, 10 Apr 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7QQRRW+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986C21ABDD;
	Thu, 10 Apr 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283395; cv=none; b=mxf4YC1jUjjZ1yzjiDQeRejHKYq9ozaydZw8cwTnp2DTTWmZ5R2zv06SdVQnClJAsVcIK465+rHn8jFdIreNcEFLc0Li+GyBr/prpgyFVBGYDDYKceWkXNyQ4+vsIMnaujL7tHbM4Ou3ZIUnZNqMRngWma2XUz6Qh2g+SFikloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283395; c=relaxed/simple;
	bh=MpBqDValHr2CSUHutlF5cCsPOXNMQ+yA0JfuD3qn/8U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpgYFnD+XyJcnBdphntye15L2EzFG2tY8pL/IAta8zt80vmP6+XmvZRlh5B4VTV8uQDEsQpyPeMhz9MP7Btu2Uuz4p8ReQ3op18BUHbvmcLydQggqYqh05VJvcEc8zQWCm2i6Ph96nmU+T6XiRJ2nc7NiCVPLHhtq7TZF3Bkliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7QQRRW+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so5736365e9.1;
        Thu, 10 Apr 2025 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744283392; x=1744888192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MbDe+EbLr5OyfnaFcs8M7gYax2PYGkoxb0x00OKFLW0=;
        b=G7QQRRW+ImIdh3TtrUpUKSXBkj07guDRnGLVr292FyGVMx8GKdZvi6FUA6SxsUDhYP
         iDlM19QiPc5mGmtgjdEaoqzOFwlDCP+RY6xkQo+3Qvld+bSuitNXsMdHFSLcQJ3IJ3u9
         7AA1cVpiBqJog3yS26bFkXHoXlIeTR55RUyhYd97iLW9REnQ/8x2EBAUBsop9GM7ok3P
         H/BYXkBmWBYsvILa3lMpeQft12p3FdtXvohe5K6s9jn5XjGV/6pXmPPMgcSSsD6f+lvv
         kkhjcW2G+Ul45vd1sUwEtaxGK5nv+W9kXhPwKba2IAXpdhEucPp634sTf2weJW+yAqWZ
         fDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283392; x=1744888192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbDe+EbLr5OyfnaFcs8M7gYax2PYGkoxb0x00OKFLW0=;
        b=f9ObU+/CqTlylMQ/NUnYcGRbd44Y7gTXpGJl5nkeLnIOTHXjiwSets4aHI/tVo4q4Y
         bprh/620l5XToHPAS/uIaLCZnr87X+MSlEVWNTg4pPIAKN4zr48jPVWjp/k+IU5ZuhFK
         wenasp+orFjtEj8SZBz+TaoKwi7EEC/wKOjScSwRWm47EhR/SQH+Q1VAykPRveWzw0wh
         jABnAT3I0/wnjD+39d0BiK85kMOG1oLRomnHzOrRV0LlTA3VRKWPccEwuQRQwRemK7Iu
         e8eWddnVWGlVZVwlLJHnSD44k0XU8+5StnKD/6VE8qeHYWTrfGbG0cMoJhscAOW5suc2
         NpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/0/0B+l1IlFl8sTEOAcKPGiKJM158XkhkkDV7srf7UjMvnwopLewP10ZSrF6TB6qF4Ev222+TNcRLjno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6eMOknQXdS3HSwKUDsCcHK0glMmuu7zKpwivBzJXXGc4onCYi
	dqdoPIedVLz/WPndyc+o18e1e2VIdTgqjU0eRvrlWhGzn3QXZo1W
X-Gm-Gg: ASbGnctaH9kYN0Mo8DZgrlb0UXpiXGyvfk4sXigMjFsPQtne97fZiC0sXMwUA1ReB1j
	XWHHv98mvAjvfXbwphwYv+qfwUM8lRgu3Py1runZxPFnCAt3VAo0fdrJxfSyS75TNMtF0IHz82H
	zNsX4GWli75iEwOJD1uo6RJ7QWod/nuIA2DPMjVcguWj1VVv4JP4JDeJ/MEC9KVYIJHJ87RCBzM
	XjBfZ4PvvyN0Xl/1WoJlQsWcgFC/3tExALtG7dY+TBpffRxAo+qJrA58/GUtk+598gwcMR/e0fe
	NiDeq9efu89qXh0AsYVIN25Sjp9shwWmOcuCo4c8mN88U6qP1JC4I0trpxgHDWRLXFGGvH0b89B
	/hPr5hfsPKp38LGWrIzMc/Us=
X-Google-Smtp-Source: AGHT+IGXicWffcw8M39J49w3jd7iIxYiNcKX82U0HLXCO9NcqiFD4gVIG+kJvxdz3XZqhzVhtvmJlg==
X-Received: by 2002:a5d:5f47:0:b0:391:253b:405d with SMTP id ffacd0b85a97d-39d8fd8c45dmr1957609f8f.41.1744283391864;
        Thu, 10 Apr 2025 04:09:51 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20626c19sm52998355e9.15.2025.04.10.04.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:09:51 -0700 (PDT)
Message-ID: <3ed7564cf2749ee207da8ddc5ef06b54d8aea881.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: Fix use of uninitialized
 variable status_pos
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Apr 2025 12:09:53 +0100
In-Reply-To: <20250409200151.201327-1-purvayeshi550@gmail.com>
References: <20250409200151.201327-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Purva,

Thanks for your patch... See below
On Thu, 2025-04-10 at 01:31 +0530, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/iio/adc/ad_sigma_delta.c:604 ad_sd_trigger_handler() error:
> uninitialized symbol 'status_pos'.
>=20
> The variable `status_pos` was only initialized in specific switch cases
> (1, 2, 3, 4), which could leave it uninitialized if `reg_size` had an
> unexpected value.
>=20
> Fix by validating `reg_size` before the switch block. If it=E2=80=99s not
> one of the expected values, return early and log an error. This ensures
> `status_pos` is always initialized before use and prevents undefined
> behavior.
>=20
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index 6c37f8e21120..d3b59d90b728 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -568,6 +568,11 @@ static irqreturn_t ad_sd_trigger_handler(int irq, vo=
id
> *p)
> =C2=A0	else
> =C2=A0		transfer_size =3D reg_size;
> =C2=A0
> +	if (reg_size !=3D 1 && reg_size !=3D 2 && reg_size !=3D 3 && reg_size !=
=3D 4)
> {
> +		dev_err(&indio_dev->dev, "Unsupported reg_size: %u\n",
> reg_size);
> +		return IRQ_HANDLED;
> +	}
> +

Use the switch case for this. Add a default branch for the invalid case. Yo=
u
should also use dev_err_ratelimited() and instead of 'return IRQ_HANDLED', =
do
'goto irq_handled'.

Thx!
- Nuno S=C3=A1

> =C2=A0	switch (reg_size) {
> =C2=A0	case 4:
> =C2=A0	case 2:

