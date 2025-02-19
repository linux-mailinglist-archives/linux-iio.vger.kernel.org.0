Return-Path: <linux-iio+bounces-15770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2368AA3BC4C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064A33B173F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC31BD9DB;
	Wed, 19 Feb 2025 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa5VY8jn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B7286291
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962870; cv=none; b=Z7YxQ5MdhvqMUBLSq4OFkQFY2aLKf60iS5r8PPxu1UY//EKgL61SXj+MslSRo/zbDuTW8em3ObfoEiLbOf1aYJXsQjLmT1ihPur3AT384rwASpXPS1Y26iy/niHUngD9B5i8Bml7t3ZkjW5c9k10kNfwHxi3EVfEO/bPmHijIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962870; c=relaxed/simple;
	bh=E2ZgJ9oZ2t1maMhtKDyNusIAbVVRjqKBtQiTDIFLRAw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBTbeKZ9UQYBsIflVzMYIjtlwRGFmTBBKDJnbiJreGqZgGGHpaDB3Cn2cWkDj7CYmUOdJhUsqwFlbI9qmXqEUeG9xQaV8YWGNuR6pGPASV1U0aMRhWb11Jj3TM1DTYwQtY+E8058LLAhc0nAWBKP8IeIjJIKy5xqiJhJLBtnt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa5VY8jn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so21035895e9.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962867; x=1740567667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ELlfzTA8gqu7bXglOMCc79B791ypec9k0Uv3IevFEA=;
        b=Fa5VY8jnmDYiQ5LXYxNnGXCs6LcWDC6Apj4IIU14fcntI+/BX9AF7SR0GqfMSAJ4lA
         O+XM7cFLuN2OZq4h4uWlxmlFp3VrOjVQbaqnIIN1G0S6mxzD9bGMB1KoJZv1HP1DRh0C
         eZELsbB2OeKwHZiSLOm0FxHaAMuaqpE9lnm0B8SxSzzpMNB4mFE0fjM/PRnhT35lcLDc
         9OKzKd5nY3wfokRhdDoD0UwXp/hHOJTYDrCOhMPhI7b7pAlmRrlQqYtal1dxbveJeLHR
         rZNMK+qOymZBRFpfj7EFGaNw5BzsfEHKJGfbeuwqfqlVuZPSPnYweJMUm9dQVEWVBfzG
         9Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962867; x=1740567667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ELlfzTA8gqu7bXglOMCc79B791ypec9k0Uv3IevFEA=;
        b=mXAuF81dqXkNaWEER5OnlqQ1dw2FQW0KYJChPk+QYabooB4FNousBhKeBPdBdfOQAP
         eV1xXySfGrzP+whVl+ybPMe5B7frMtAv0Dd41b63gYprFRo3QU0ASP5pk5+jvB3Surc5
         7aLuQUzhrxtZRyh46a0+7SY1jqrx/elv11O/MFzRlyKApFXpj85cbQj2tj8rbffrILRC
         r4MZvMxVY9ufgi9F626HKBe3TqBv8Ky4X7VmBTy2gGhCt5s+5/T537ym36mWxqgh/JSg
         rMSeWy7v0/a8pRd1jqBeDrDJ2AybvcqKKknt88wAbph3NxnYDxT/rcPwggTmgm8AL+ni
         QKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq9napytpI3aiRBrpMC3TpJzbab4Af2R3ZcCpid0CcZO6nRvS6IMES/Ty8cYA7D4SYx/AX+YbWgPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIft2Lv6GPxy6SgNiI3Ec5As7kkAK8okpqTyXzYGBYZZZnUul
	I6o32yQtReByIUeJmV2q782ihhzrbhvQfgeRv2pJdzPYSuf2oFz/
X-Gm-Gg: ASbGnctvg3uN1dxXwAVPWtuRLJlaJzg3x031KLB00g+1g/7SgMxorSI08czX9PpPrGp
	X9Il7E2A9AOiccbLt+sb4Gpvfx/ibzaW0Z+sfnLC7kkIc6+C2p+hBuhuc1xUEffRNZ+ywXkELoL
	8iv6iQPJUlGZMAJ/0ZGZ49TBlJY1wwPMaCATYPWQkIVGh2XFcJqnwVckjAUthjM3ba5DNUOrdSi
	stmh7d7PYYO33gvhCZIsMWfGOSF/F+q2YxrFPgAWcZ2Z0T52ugJ5eFHdKOICU6DmFPgk6R3ii5C
	pLGf+9CyPGwQhhPSNc1qB9cQAFE6DePgUPDhNpB0mP6ewbQedbCe8j38mh4CoZg=
X-Google-Smtp-Source: AGHT+IGWbnZiD+maEsqw7Y8zTDB1UqV2Uv5R4I8eXTULxo4At/7gduFNjbH7Cn7Y99SoaZFTHq/CIw==
X-Received: by 2002:a05:600c:cc3:b0:439:8185:4ad3 with SMTP id 5b1f17b1804b1-43981854bc6mr101758905e9.27.1739962866534;
        Wed, 19 Feb 2025 03:01:06 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43984924201sm86911075e9.6.2025.02.19.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:01:06 -0800 (PST)
Message-ID: <c55fde275edd15ef3040fa9f03fc2790ace24dc9.camel@gmail.com>
Subject: Re: [PATCH 18/29] iio: adc: ad7793: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 11:01:09 +0000
In-Reply-To: <20250217141630.897334-19-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-19-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7793.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 861a3e44e5ad..ccf18ce48e34 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -517,13 +517,12 @@ static int ad7793_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ret =3D __ad7793_write_raw(indio_dev, chan, val, val2, mask);
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}


