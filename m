Return-Path: <linux-iio+bounces-14582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9BA1C421
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 16:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4188516512A
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A528E37;
	Sat, 25 Jan 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ck/nyQDK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828C38DFC
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737820600; cv=none; b=gSzV1x2CJRATluKdQcu1cO2uZitgAYe4KkNLS1IJckRKtR3GxUmebuy9sxx6qzfF9u8eBxGoTY/01f5Ij56VsKdcIpzO8plTCrCL0uVLGXwh1XY/2VEDBClTgoBrShi7/WaCYz5Tn+7U23Hi587JZ+/5cDWXWtwPdHTooFLG0Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737820600; c=relaxed/simple;
	bh=dP9BrzRmup6vmEESrWHdMagSr6mAEpu62UFaq1L20rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFf1Y+G42eY6NKDXPvgQnG6hi6QJkkIfbd1D3ecAwC4szdawwJL4HuNTgjLGdR/FKS5X0pE0YFYmYGHi09/NFtICP5yVRKTS6qMto/QD+L6JJp6DPCkj/vYdOZidpp8hRjDmGBIfJG5uAthT1QeEVsdCem7jj4MzxI/QdxNbYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ck/nyQDK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso19762555e9.0
        for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737820595; x=1738425395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1y+1oy5ZwbLR2t2S5KCQkcw82+x9fn6RVPCZAoT8u0=;
        b=ck/nyQDKdJCGeQ+eVAIWHRlMepjmCSqGppZ4L6l8rRSq+fJcVxHdg/fhn9IeoE6c31
         WqOM1kYtUHB4mRgXwRTlwW3qpMAaQHZoMB9LoPb2MVR9vDGDxCJjR2LGeWXLyNo+QhnZ
         X6gfnn5Myd7NVjYhdK0tpr+bLDxQ/8/MmwjHayqdtZEaCP7k2UJTwYb7hjVbwLAn56h7
         8Nwe+HM7+Ubrw0jgRhzLiK/TvaVhMhuNnRmNOh89TStNHgQtAwE/W9POnVH3Xoc9Xou/
         3jAbtz3qEZSdY+/O5Ms9BvFvuKpzrO9waLZBATOsOl9uBlifMsHwglneG6ABPriKtJQU
         oE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737820595; x=1738425395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1y+1oy5ZwbLR2t2S5KCQkcw82+x9fn6RVPCZAoT8u0=;
        b=h+OQwZFuegb0e/BbZ27r2d2LBQSm3xzXVDT20VObp3fa25rU8crB+VeAE27RZKmcmq
         YJ7xbpAFz+vJjf/TvREb/sQcn8dueNgiQ1iFxItzjf6a/DlD9WO4/J+dH1sBx4IRS4uh
         70RSyp6bBpYnS7MNfefnVLuCfgEL1tbSpxB1A+00jywMDDs0HRrRFPpPCiLo96YeXbqe
         hfGNFjUYlyVtMUoU6kAVRlC18vxA2hFjkEEFRgvagW78tWTxCdKOnpXqIwCvNfLof3TV
         GH2NK3qvZRDPLuExDgZNrWcjE9cQjKgsNnnd6Cxs0DXC93DgDLWcKkVm8xKHXVLetY63
         Edlg==
X-Forwarded-Encrypted: i=1; AJvYcCWVL27ZC57mQbdyJ1igauOqpb2OiMKcmPDJ7g9eRSkSn8brISo33mbSSadUw8Q0DV8JGyuG4CwXO1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTu9CiHkXv6OqSx3zfhWgdyB6XIJkbVwfE//z7HCeBfbsXxkH
	emf+wIANm0GfFf+suTi6Da/4ElgXnR2z/JctYegiKH8Zw4TB97KcNx4wwgV+hvM=
X-Gm-Gg: ASbGncv/2iNg0hKf4j/4jVdbpk66voibgWMbgKmH0//aYGFqSO5ZJUsVPA42WRME5BT
	pNMF5EB0gXtSMjkEyleSBsds+dseomvU6eZvVbrefI0es4rEctV/xf8K0fKiS4WY6X+DjmMYK+E
	zfkeDe1LGja3j2hH6xgoznd0HhpXFNLVE8dCcjMZRdS5SuZHCfuJitr35ZSVsRoCIfbwFpPiVFW
	M9/jUPg8je7U5kaEKiW0oM6ZtREAdzlQBlo08r9Mz3YK6/BtaGh8MMVS0o5yZW5WGW+hXDJQST5
	5uQKBiI5Cw==
X-Google-Smtp-Source: AGHT+IEbIPwc42f85Xe1g6+pGv8nBGxCIVwlM6X1VMfGypmj2spH5usXWHxF2VFaVyiK0JjCIJInxA==
X-Received: by 2002:a5d:584d:0:b0:385:f7a3:fed1 with SMTP id ffacd0b85a97d-38bf57b6717mr34390271f8f.44.1737820594747;
        Sat, 25 Jan 2025 07:56:34 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1766d8sm6061794f8f.14.2025.01.25.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 07:56:34 -0800 (PST)
Date: Sat, 25 Jan 2025 16:56:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: adc: ad7124: Fix comparison of channel configs
Message-ID: <shcuhdi5a4fgb245dgrm2wj2bwq57xt235pitiuiimurtvjoib@susaigfddn2w>
References: <20250124160124.435520-2-u.kleine-koenig@baylibre.com>
 <20250125144828.1518a7f3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zmy4fjq6a7y5abcd"
Content-Disposition: inline
In-Reply-To: <20250125144828.1518a7f3@jic23-huawei>


--zmy4fjq6a7y5abcd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: Fix comparison of channel configs
MIME-Version: 1.0

Hello Jonathan,

On Sat, Jan 25, 2025 at 02:48:28PM +0000, Jonathan Cameron wrote:
> Fully agree the change makes sense.  Though the floating point example
> is unlikely to bite us in kernel!=20
>=20
> Did you see an actual failure to match?  If not I'd be tempted
> to take this for next cycle rather than as a fix to rush in.
> I'd be surprised if current code doesn't happen to work.

No, I didn't see a failure, I noticed that while working on the driver
source. Also in this case nothing severe happens. The check might only
result in failure to detect that a setup could be reused and uses a
different one then. In the worst case that increases pressure to rotate
the setup configuration in a timely manner.

David also pointed out in a private conversion that the bool issue
probably isn't relevant because the compiler (at least gcc, didn't check
clang) only uses values 0 and 1 and the padding ideally should be all
zero.

Anyhow, I think comparing the actual byte representation is a bad
pattern that shouldn't be used even if in that case it might work.

So I'm not aware of a problem that would justify getting this in early
as a fix and the next cycle it totally fine.

Best regards
Uwe

--zmy4fjq6a7y5abcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeVCa0ACgkQj4D7WH0S
/k6PPAgAsEkrSsH+5/Ea+Hwl5jF9BGb12kEN4GPxAjSou7GFWJPZ9NjxVu+VbgSx
XhTQsgfXlZ8LzvOWdbdwb68PtZH8e0X5gY/8Eo/zeZKeF5WhOfWQFSUYmuaMDtY2
jImcJSENNbZL8esF+BZGYpkPAxQxn3PHGHfOkvJJZWkMM8JvfHqB6KltKiEoYcCA
T5JBrByeJl8Q2ImwsNXn/34bZf3bkFWUwpUuunAC1xaAV3PiznReD2BqbzzLPkZb
wVOA5eA3/mPTaP+jswUDZqTusma5+mSsM/uhXvnZv2wTh8ZR3zAKO5qKkx8Sg67y
7VsfSFU7wO5W8kuveE7MJA4g1CZ1WQ==
=vUON
-----END PGP SIGNATURE-----

--zmy4fjq6a7y5abcd--

