Return-Path: <linux-iio+bounces-27389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3DACE00E6
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D79CE301A1F0
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A732570F;
	Sat, 27 Dec 2025 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HST2yVMk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79159315D41
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858913; cv=none; b=AHSWHeybgeK3Crfyc7DxrtvE8BP4i7pM1GDhBV6h67wVL9HbfDj85fUGVwVX/AXcLHGwJiSGE9XTFgZzZaY/K9rtSgFQnDms4ZvPIeqevjpRJfcMSDwf4BY2aWxXz9DZlvaEkaJWXq3LnSfr8EJ6JHeX0ywdHTEG3EawlZRUzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858913; c=relaxed/simple;
	bh=b8VNWawuLEv2VOR0aC030ySiJTNbjx5/+mjSevhatXo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lPIpmZ9uUAECbMB48X9X78iKYN17Df2hQmQ19QVYXGb5dfjv9zf57g0DevzncG7ZUELXxoS0zAGeouMkv1IbkydpkAZAwz+BuuntgkSBIcC2iMfkcHbKGyvzVvqSWJ/lfHdtAAXc+7VCw5hCGxUD+ga1x6hj+BN25QPPwDKk4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HST2yVMk; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5eb8f9be588so2232779137.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766858910; x=1767463710; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7CS9a/UP1wGl2+5J10FtNTBbvnTiBPo4mSf3bNivDw=;
        b=HST2yVMkls/zTycsW/h9hQ6oFLgVauWSpOKIhZIgHlonsN+wOKfOzGdXlyePzttr7+
         ry3/Cw4hhAlo/kUJCpF6jOzQzytbTHMjPtaXJDtvQJeqhwNAeMHJtlQxPzOY26ijWn76
         lWLxbBzZJZr1iXzetl3un1BrQKWG3qhZAQB6+mIZ2+o/DETHGsaHpsI/5qvcUNwvR6SV
         Xmaz1OharUcpzNPHKVo+YbpQ4T7gCzHU1OcEJjTV4WmSrqLxfKJPc+sjffIwFbut0cnl
         Trd3QgEtXTL27+MOKkTjBihwGiO1UwCJxeCc2PP0FrUHteIP2oEo68UB84VRHeshNKG8
         0NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858910; x=1767463710;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7CS9a/UP1wGl2+5J10FtNTBbvnTiBPo4mSf3bNivDw=;
        b=Y6EpnvNCRWKQYS6XozvwI3DcZPem++MHs8cN77lhQshiQVd3uYKocXIy3SaCDawZ6y
         4/bPDZ6IPk5SmalxZ+qvcjpauWMGkVqBqopFpIy8yVJ6rxw3VyLlVVYg0mNUXGVk496J
         pBF0RHQhc212ulq3RWWCmtisasOPOHTUXEAYqLDD68oMELv8S10rSE901mISrNYi5JkS
         J7XmMqaHWWtEuENCeUv89/0Jdn58/ALmvijNAn1cc/17bWdKLxu/yhriHMO//CxWUA9Q
         esIAdHtU1Q5JwqRV8mgwv3hdg5NciVk01Y46XDJ65HM6P9YzV1zPgg0Of3Cc0Yk1KfOl
         4jOg==
X-Forwarded-Encrypted: i=1; AJvYcCU+910yYl/LPSToTWzh2r2RL/j/Nf+DtjpsSHCWQJPaoVS10p4PoYqJUhU4lCdD6tkaVpfMYC/uqhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6PBERrIMSEhQ3h6A38o9nsIi/iJ2HA94E/h1EE1rXn94+GuI
	uvnf/XKDl08WAEsiLO/h7fWvVhtu3mnDCTZhWgA9sS8sNU5+Cq4JlssW
X-Gm-Gg: AY/fxX5NCUEKaAf++4+ZS3c2CXx2jtc+VYrvLqrNzmM2aS2w3+jZBHg/ZgArK7WH/sd
	nmmbRoc1BrW1Mda3BJm2rKys35o7ZXXC0nbnOpXdb9PC7YGVSum6x8EiTaf0vbMjOYfIGx9/IaP
	lKyHauRypDyHRxGMdHwzqZ/LlA4U0g71GTgaincn5g0B8siFYDCAYCwVHGTTRgc8YoQ9SFcn/Qh
	K6n2DDJIQXlB+S6EKtHmsA1p8hMsaXHPUKYfmHHeLI/Zm18Ve46+XsXk6v88KiUeuEiAvP3KEQs
	axvicBye+vBy5q7pFcIN3ySz8GD+wnGQs/N7PBS3O2Q49Mz39ZiZvYVCvCB8gxQDpihYA7NS8M2
	OdRxuTXg1YMuxn+MgMjClmB/gdVtIgCkn5/XtVaM771Jhtl1xWR52TpzOxShE8qpObS0/MnEKWN
	eHeTjjlEfW/15s
X-Google-Smtp-Source: AGHT+IHW7mZTpijQh1W0Vlb08EDOefDM9YQfhnD645lciF5cqOP+tlMO2IiZxFXvLAGGhdfgkwosEQ==
X-Received: by 2002:a67:e702:0:b0:5de:31b1:1ffe with SMTP id ada2fe7eead31-5eb1a827522mr10343377137.32.1766858910355;
        Sat, 27 Dec 2025 10:08:30 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9434176c1d3sm6868920241.9.2025.12.27.10.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 13:08:27 -0500
Message-Id: <DF977KU7WNXA.2B1WDUTKS7NRC@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Benson Leung"
 <bleung@chromium.org>, "Antoniu Miclaus" <antoniu.miclaus@analog.com>,
 "Gwendal Grignou" <gwendal@chromium.org>, "Shrikant Raskar"
 <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-4-6fb47bdaaf24@gmail.com>
 <f5ef483b-12d8-4ed2-9637-af993c3f8b7d@baylibre.com>
 <20251227145312.0f1c5f87@jic23-huawei>
In-Reply-To: <20251227145312.0f1c5f87@jic23-huawei>

On Sat Dec 27, 2025 at 9:53 AM -05, Jonathan Cameron wrote:
> On Tue, 23 Dec 2025 11:23:24 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 12/11/25 8:45 PM, Kurt Borja wrote:
>> > Add guard classes for iio_device_claim_*() conditional locks. This wil=
l
>> > aid drivers write safer and cleaner code when dealing with some common
>> > patterns.
>> >  =20
>>=20
>>=20
>> > These classes are not meant to be used directly by drivers (hence the
>> > __priv__ prefix). Instead, documented wrapper macros are provided to
>> > enforce the use of ACQUIRE() or guard() semantics and avoid the
>> > problematic scoped guard. =20
>>=20
>> Would be useful to repeat this in a comment in the code.
>>=20
> Given David did a much more thorough review than me I've just
> added a few comments on top.

Hi Jonathan,

...

>> > +/**
>> > + * IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) - Tries to acquire the buf=
fer mode
>> > + *                                           lock with automatic rele=
ase
>> > + * @_dev: IIO device instance
>> > + * @_var: Dummy variable identifier to store acquire result
>> > + *
>> > + * Tries to acquire the direct mode lock and automatically releases i=
t at the
>> > + * end of the scope. It most be paired with IIO_DEV_ACQUIRE_ERR(), fo=
r example::
>> > + *
>> > + *	IIO_DEV_ACQUIRE_BUFFER_MODE(indio_dev, claim);
>> > + *	if (IIO_DEV_ACQUIRE_ERR(&claim))
>> > + *		return IRQ_HANDLED;
>> > + *
>> > + * Context: Can sleep
>> > + */
>> > +#define IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) \
>> > +	ACQUIRE(__priv__iio_dev_mode_lock_try_buffer, _var)(_dev)
>
> This one doesn't actually have any users I think?  Do we want to introduc=
e
> it without them? I'm not sure we do.

I can drop it.

I would personally keep it for completeness, but you're right, the
buffer variant is very niche in general.

--=20
 ~ Kurt

