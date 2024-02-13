Return-Path: <linux-iio+bounces-2501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A5852792
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 03:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D74928575B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 02:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36F479D9;
	Tue, 13 Feb 2024 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsq2wRKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E0847E
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792452; cv=none; b=GoMxPtkA75PiM08HciZOTdhvcViBdvx2WjzP/snyt4MD4k16PIB1yZdFfiH0xNWApRUxB18j0eoqpm/2N7f12yyzjNFohhkPThoe4dHwr4tbh9kHGSLTuwVQSm1zD0wv38DtF+HDsz+nqML0IgNrGMiRDFRkEnCmj3lB6zpzqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792452; c=relaxed/simple;
	bh=UCoqta9plgJMa486MJiEouO9QizZAAFMUBnZAAH6NBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F87+0+TsulVLAmkYmy1hJgxQBQXO81McV4jOkQ9+kT0AUvYiRroep1poK+uLFCbQ+lYsNJWEL5LWihzzPtW2gheJ5dfjuajO33XbOthchB3CQMn7LohqkdOznbUHrsQ6jHPQIYh8dY7nVqNb9u7YDaCKcrSjymBQh2EksXCKLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lsq2wRKa; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59612e4a21eso1597660eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707792449; x=1708397249; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCoqta9plgJMa486MJiEouO9QizZAAFMUBnZAAH6NBU=;
        b=Lsq2wRKa1NO+EN2VNpGBH2+7XgN3kpzqB51Yw+5QYUdY9SiJ+E1CfAsPYFsrrwY1lR
         cE84bsKq4YmWn4maR01gJngR9xCFHjpw8UzwiklWt2/TOJ8uOpshRQloxcAJmWO4+kdv
         wacE6FAsRYRJ8KyaDaKjMaXfjxKtUEMR7NtFaSs0kkoD/bpAgyT6cNm0T4fp69BK82LZ
         INiG8GNjjPl60kBbYW1to7O6aAy0/P80KpajoC2cALzbc3M2Atfc4FJDb8VzzLnn9kRG
         3DExbfo7+lD+Fau8SqzIAi+fJ+bv6xk9P/P6SDj6kLEwtbRSoWmNW05vjKrU5FPM/UKu
         kY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707792449; x=1708397249;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCoqta9plgJMa486MJiEouO9QizZAAFMUBnZAAH6NBU=;
        b=P2QStoL+S0dVuGM3JhPd+cfLtdjtwQ6jFGubW0qHzxynRVnDe7N0ur9WWOQg4lZ42e
         SCK5rOIdd9k9/cA0WelpQ5jdgSmBYRKnNpf2QvyskWyFqGWYezBLyQQWPTa0LLlleCeW
         F4CnSV+bflw44AjaSeSBuhh55jy5ESfnoQjpVoOqiIO7MlQZZ5ZfymrUg/N7mPfzZQtq
         b4nBkeS+axq/8JsRMHougBghwS1Xtan9Ozc9lHjH/ql5SKos8lb/RCkqatIZ2bwI1RLM
         XL3kY5D3b0zEfFQ+bt7tB0YJ4Efb8b9IhfYqlI81OsXEf7eCktUqWyq3Ie+zVQiwBKza
         vcmw==
X-Forwarded-Encrypted: i=1; AJvYcCVNzNQDJKWpho3MVAHQ53UyZ8aPabXrKCZBZ0GbbIW9qiSYcaMjZPyUZuQXMzJPBdv3tv8r+W0SH3ww+M7/XXXTWitjfY/909sZ
X-Gm-Message-State: AOJu0YwBsKxunKEG6f6UsqkPD1kJOcgqAoYl6v/OvM4YxhOrRPQlqP2V
	tz5M2n+SEDjXjDxy2ykFLD/eED8nAxoA9qVNW3r0CxmM+rlUvBAx
X-Google-Smtp-Source: AGHT+IEODb/smsLkMEFopBj549ETXGquaMrBQrVIFIMVyYGEopsM1amk3WTzpmfx5ZJamvbWi2zCsg==
X-Received: by 2002:a05:6358:b08c:b0:178:f47f:e5ac with SMTP id b12-20020a056358b08c00b00178f47fe5acmr7032756rwo.13.1707792449545;
        Mon, 12 Feb 2024 18:47:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVF6051a9jpxMjRnmwc7TrM1mIP1GeCjDOAOSs3UkgljTZnK5zR3WIJPVdQxYlpIXSjV4oAv8/N41w02KhYq/FTXdxyEQ+6l5CBm1RYRYrB1LekQXH/mIVXa1xQtKyMrutNeTGES6wKZtZTh2oQIgCpIUBObO/Kv7IUMpz0tl+dQHDdRRnC0Gbcev9VoX7twD0V8ys2i1hBpZfC+ZoeIAkTVO6VbRJ+ZJ8PO5UbkFsJkr8QJSfj1XP2hZx2eVXxonF8g1WMIBR7/U6TRibeQxaEzbl4L2KpuG/jhXQYLQENzRyZfhh5KP4n2G/3
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79d85000000b006e0cfe94fc5sm3806705pfq.107.2024.02.12.18.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 18:47:29 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Hans De Goede <hdegoede@redhat.com>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading
Date: Mon, 12 Feb 2024 18:47:27 -0800
Message-ID: <5794873.DvuYhMxLoT@nobara-ally-pc>
In-Reply-To:
 <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
References:
 <5769241.DvuYhMxLoT@nobara-ally-pc> <5292442.31r3eYUQgx@nobara-ally-pc>
 <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6058084.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6058084.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Mon, 12 Feb 2024 18:47:27 -0800
Message-ID: <5794873.DvuYhMxLoT@nobara-ally-pc>
MIME-Version: 1.0

On Monday, February 12, 2024 1:46:21 AM PST Andy Shevchenko wrote:
> Even if fixed (which has to be done anyway) it can be undone in old
> firmwares =E2=80=94 there is no solution to make all affected users update
> firmware. Do we have real products on the market with the wrong ID (I
> assume we do)?

After some conversations with other devs today, we retested and confirmed
that the DMI quirks to abort loading of bmc150 is actually unnecessary.
There was some confusion among us about why they had tried that approach
in the past. The bmc150 driver does in fact start to load on ASUS ROG ALLY
with a "BOSC0200" ACPI match, but when it gets to the chip id check portion
it correctly aborts loading the driver for mismatched chip ID. This allows
the bmi323 driver to pick it up properly with the "BOSC0200" ACPI match
table match. Tested and confirmed working on my end with the submitted
v1 patch. The DMI quirks and any modifications to bmc150 driver has been
dropped. Thanks all for the feedback and help.

Best Regards,
Jon LoBue



--nextPart6058084.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXK2D8ACgkQ4obKiQwb
1x1ihAf+NyGZfmDeeykxWo8RyAQ1jrYAYpFAhaU003nv6o1SsSWZqFqiRmbtdalX
dFzEISFGcEXjwbdA6/Io5qnl3Lu4mOctBo/P3XDSJlFROIN98pO/e7A9VEt1M6II
ukKGhC93/qLduudvZFuvCv/OO/2vxh4L7pzQyJXbpsy+mrR2UUuiMy/Ki3jHmNYe
4j/mqlGbhmjNTTJmAHJSEpVqQtLNkQRp2rpUG0QtWsafIb4HiIye3H6lvgK1NIOL
fO7r/7lHzsu6r8CZCJN/C/7y1scNKnSAKgvqy+pVSM6cWASDc7ZQC092wY1d76C/
tYytwSZ1ohvbQzxxKfoHPJlQ/jxK6A==
=60R7
-----END PGP SIGNATURE-----

--nextPart6058084.lOV4Wx5bFT--




