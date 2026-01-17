Return-Path: <linux-iio+bounces-27902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6743D390A1
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 20:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38936300C6D3
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E72DF717;
	Sat, 17 Jan 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuWYeHx2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EB2DF138
	for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768679072; cv=none; b=uAFBxGky3WB1+Ofw/00WYLdn3KH5jB6pjhjC5KiJ+GC7helCLlRzwAeoDE8zHNkJ3fvrOAb/fkC6apqQZWBZQ9+IONdAnqfkA5Kc/2lTcZfow6t+fLkS+6FGKGiFeynpQ6+fsI7dhAcaO7nbRcR1C8xuZw0xTAaNtP+PZauZZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768679072; c=relaxed/simple;
	bh=xkKytNjeVcjDL10/GqrC/ZAsjwWotwsWzGLKnH3NAuc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qj6g/XwcNSCFPGSU/Q9PK1AFOQU0yXPebbxzVdhsWhXnWJuMuFtinLhS/C89HYOFxv6FieWsWYdonlql/+9aP+lyY0KYtT9kTtBbem9TSL7EIKxKhvw5VYrHsqMcVW/cZMXbPO7gyvQ4xf/waNzZgFkL3+RylCoq9x/2zfUCkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuWYeHx2; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5eeaae02888so888075137.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 11:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768679069; x=1769283869; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1uCAAMUi0Dl9Xk8gsU5DOI/xVq90HWLTJ/j/86WebA=;
        b=WuWYeHx2t0UMihtmfyebMkrK3vAFhMp8+3Egb3geZqgHHiXDCkYiD5zfQ6MWrGBou/
         7NHs8LJr432/WaGSJBxySFrl5WnZuED6RyI2Vm26Smj+ESykBYKvitk3tvkUmwrU83MQ
         KykAJWAm9lK2GtSMUlTW6uImzSXsHUkQ1G+YBf8sOzzE5sPJZkWCysA1uNnDc3sxGfiR
         Q+vSsGlRk9NSZWMrUPN+5L5bPutVDF9EyAZQKSU8tY/Il85dipU8E0zcUUY9NICSfdo4
         oNyBcTnoGIHL2YwDo1ggzMBIIdteu/ZYDsoxM+3N312Aw9kKRTNgJxvhHr05yDyxSBGX
         FrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768679069; x=1769283869;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1uCAAMUi0Dl9Xk8gsU5DOI/xVq90HWLTJ/j/86WebA=;
        b=kb0oShqxClbosMnvDEHPxeAbauwa6PeSvkM0yYlC0Qmp3XXIeJqp43Za9PTVHPa0Eb
         t/zIyYLJjCrupbUc+KiCKDINucuL8W2brMMHwGzl4sZOFFxGsSTebBYw+pJrlSGl9TkW
         KSGEY2ukvk+pfE9BF440mcQ7XgCCfeEaDZ9EtWfe79GyICznV/+5rfHdDAGDL+TV+2U6
         kceVz6CgfnEymrEe7ui1rd0ulgcOkABq3jgznD1oZSpJuC6YwNa73GUpN+Yw279C7kNq
         Q9+rqECzJUpbKv00POQIm/aLCnNwK4w/+Guur3SwLE3QDDhf4GbFLOzfKfDrIyLwDe3U
         FtaA==
X-Forwarded-Encrypted: i=1; AJvYcCVpMSRAgJ8F+gypiSls7oH7ZchgmuZz+sJRekolt3WlDF7H3xdGYrh7yt8GcHZef9ySSlLlxwE0TVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8x7WnHdAczyROcWReaz0ilD1gg9GbJS2taWCtkZowQz3hu9wA
	3axMRc9Mkw4PLsah5KJ3DSChc3bG+zCuEBlzXVNAW9ceuMvXUIZPxw5h
X-Gm-Gg: AY/fxX7C67NjhRLgrW82JqIdA3KJKu6tY6gq6r47FFKgE8QCOynfjNYwiqMB167YxlI
	WRZbOFqoYkbjGRn9hERiC7EekJfZpMqdX2qExYHts6qC9amH4PxUydoUWKM9rgMBavWa8+TNJaS
	+h04zPLmEd1HF+/iAzO4xumG3iDmO9Qa3qYPMga/zdes9GiTgGOrgDtb4dTRgk43hGtc2CWB/Fe
	D4kExc1Nh14eyqh3J+JB3pKf14FZg56U+HqLNp1QvdIEuBVQnrEKrXBDJqGQz8A6wW6a/KRRsyx
	l97HqWbdyq6UF1MdTiNbk2CIUOmDVYWR/1BEhq9ugL/2DQ7JssFK+MQ9Dq4f7V8lswcvcz6mgoH
	kxU5QMEhafhgMcqjgCr/c5CDuRfhlz5hOYm6eoUwdk+M9n8cCuzVJ0tvBJILTcqBlj2e+vsmDb3
	MgHg==
X-Received: by 2002:a05:6102:f10:b0:5ee:a309:6684 with SMTP id ada2fe7eead31-5f1a4dc26femr2032982137.10.1768679069122;
        Sat, 17 Jan 2026 11:44:29 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d04377bfsm1854349241.10.2026.01.17.11.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 11:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 14:44:21 -0500
Message-Id: <DFR4EFO39YMN.2B4GMZC3TPMQ8@gmail.com>
Subject: Re: [PATCH v3 0/7] iio: core: Introduce cleanup.h support for mode
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <4e77ebef-07b3-49ae-9d53-d24616569a74@baylibre.com>
In-Reply-To: <4e77ebef-07b3-49ae-9d53-d24616569a74@baylibre.com>

On Fri Jan 16, 2026 at 5:08 PM -05, David Lechner wrote:
> On 1/6/26 2:06 AM, Kurt Borja wrote:
>> Hi,
>>=20
>> In a recent driver review discussion [1], Andy Shevchenko suggested we
>> add cleanup.h support for the lock API:
>>=20
>> 	iio_device_claim_{direct,buffer_mode}().
>>=20
>> Which would allow some nice code simplification in many places. Some
>> examples are given as patches, but the last two are the biggest
>> differences.
>>=20
>> In this version I dropped the RFC tag, as the general feeling is to go
>> through with this after some modifications. Main one is the addition of
>> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
>> the guard classes directly. I also added comments on the forbidden ways
>> to use this API but I definitely still take suggestions on this.
>>=20
>> For now I dropped iio_device_claim_buffer_mode() rename, as this point
>> is still being discussed. My suggestion based on the RFC discussion is
>> to do it, but in a separate patch (using coccinelle) and while we're at
>> it rename the whole API like this:
>>=20
>> 	iio_dev_mode_lock()
>> 	iio_dev_mode_direct_trylock()
>> 	iio_dev_mode_buffer_trylock()
>> 	iio_dev_mode_unlock()
>>=20
>> Let me know what you think and thanks for taking a look!
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
> Like Jonathan, I just had a few minor suggestions, but overall:
>
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Hi David,

I'll add your remarks in the next version. Thanks for all the feedback!


--=20
Thanks,
 ~ Kurt


