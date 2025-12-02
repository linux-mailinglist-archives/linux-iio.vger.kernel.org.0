Return-Path: <linux-iio+bounces-26645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C988EC9C76C
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 18:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D98D34821A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895872C21F8;
	Tue,  2 Dec 2025 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URILl8/V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD032C0F78
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697766; cv=none; b=KCisg/H6FBLKNnDkT1i/CgAGvp8FnkTpe0YIlRNTbb5TMFqjZKlwV/Vjmv/M08OWJWR/bCVuQSAR0XK4b2K1Fm7QgQVjLm0udTXabGSoH156JpMzNbcQRBY5n6N/yNjYbC8WXNCkRnYT4YXTlcZNmxgBIZLsVPQ42wtRNqWhhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697766; c=relaxed/simple;
	bh=lFD7YqZqIOM9zNsrKDqdar20gGVc1+ve8YCHIZohhpM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Vx/JghEZCJbK/nCh5OgJfOcThp1Cgqt25FfMo52FiZbFZkZlW8JFe06hfX1QwXvsVjx9oyAEoSHmvfcd9gnKMVnBDb9FqEmMaYjZchJlfvaDag/+DgyyGwOanAUzIepOoLmfC6YH8EYjWbWQa4YBadRhr1QrmGLyTKOW6WEPG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URILl8/V; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso4971503137.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764697763; x=1765302563; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFD7YqZqIOM9zNsrKDqdar20gGVc1+ve8YCHIZohhpM=;
        b=URILl8/VJruojCS6f31vNbZIiVbeMhvow2XTLdM+aRSUgEbYITrpCJdqmzRqSPhOKi
         +Xr1DOivvb/Ez4kdeM3/a0Nlyg+qf2FwZOpYGjmPfZEnJnQ3m2MN7w0TvqcQgl24ULZc
         IbJsLnbqKFBgT+DuDrg3t+pSYrtl6naxOkFs1Nk965BG4WBPV4P+aVkSTiYmrI2vK8Mj
         byZ6qg7frR6de97B87+sA6e2uy5O4cx0NcPE9G49Xq7BU8a0dKiAAdGYH5T4jhYSJmjg
         AyJ1/U14rBuFaWLuy0BuzGZHc6WJ5fcMas0Mv5hw6UZfsNkaHldWJKCWayQlWq77AuEn
         6uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697763; x=1765302563;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFD7YqZqIOM9zNsrKDqdar20gGVc1+ve8YCHIZohhpM=;
        b=jNErz4s3lNcKl25vW4qNKMvIXSgVUHuZFx/LrjO7y2SxuQrzi1LLDuthazZPNfvc12
         B1XsYkuSO1rQ+jdSs2fkTHb04ttFRVrtVYG1am2pxibB3yAriiJj1P9UvZHryLMsOyil
         FJ9Gk25UkaHqwRamBpznhslOUAS9E7Vft2l/7vrjcPC6oWKopKp/jAyounmAiGSVhk7v
         sKYGgIda97Cqy+VQB7aLCSpADBbdh1o83k9zOprYVQyaZwwavxlAeY41B71UaXlNWinV
         UBrZ1ajcBCPUZh35ZkOpARvzOz6YnIPOh/zuwgjo+EAZDqEuoykvQMcuanCBrz2YXyTb
         AISA==
X-Forwarded-Encrypted: i=1; AJvYcCXgCnCnE29toyeoldCjZ9qggIdL2KdqEG077b4vmrEzLxW+KUZmeKrBNEWdgyCrfdRiMMWhq5Erc0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHMpZIIdG5WrN/O2DYhSjQ5yQufa+w4MUBW/DdHQv8M0nMa3ms
	QR4AhFopOkuVNKMjRWeuEOT1CGk74vUQO1e0VPjum8xZELLd0RqYeBlc
X-Gm-Gg: ASbGncvjnujX+Ah5e6NlSYCIMKwKbzfOsQpmaZDel9dY9vbfJPYME1FSip7D2OKYihv
	oN5868f+6MSolVYxTHcjvREy9oF/zCgYJXrokHqLiZWk8loVOpY66C0rHkYizfWckVdu4CN6l6f
	MaXA3LtFlGuJkaowb8E68GvijwKDB/Z9ah3bt7Rq59R16aNB7tWnmRLXonZ7EiZD5VFDzBpcXDh
	9vPCjmuUJ4hY8uEmALdWUVafGKUeLM6avuuW6edNuYPkL5g1xpZ6UvOUFfRpP4iRZZoyDHnzoEn
	Dg5kr8Zo6MCogUV7hI8VYGvJRP4hJbOy7fhR1+4CTB8i7GoOAK98rmZF/R2b7TRs8PxBJrMjjVU
	T7w7lUE2UhHTa9pjN8nklAbIKRWFIvQa51PGa9xUAU1poJo5Yl4bnDs0HXO49idGgXd86HW204B
	lrDB404m6gfCft8wUd
X-Google-Smtp-Source: AGHT+IE1CcIiiEo8CpEWTWXoBBMghBqvdzUH0ukhewnvrLWZreULDTL/mlRBc0qJBYu4mG8WzyOq3g==
X-Received: by 2002:a05:6102:54a8:b0:5df:c10a:6683 with SMTP id ada2fe7eead31-5e2243e1470mr12768970137.35.1764697763507;
        Tue, 02 Dec 2025 09:49:23 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24dce4a6fsm6362031137.9.2025.12.02.09.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 09:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 12:49:21 -0500
Message-Id: <DENX5BPCUHZO.1H0XL6I8M5EJD@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Tobias
 Sperling" <tobias.sperling@softing.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Kurt Borja"
 <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <a01f95ba-23c0-4c4b-a6bc-31b316bb04ef@baylibre.com>
 <DENT40NRKH0V.3UD0JBGRUSCDS@gmail.com>
 <aS7-yml5a2yjM28D@smile.fi.intel.com>
In-Reply-To: <aS7-yml5a2yjM28D@smile.fi.intel.com>

On Tue Dec 2, 2025 at 9:59 AM -05, Andy Shevchenko wrote:
> On Tue, Dec 02, 2025 at 09:39:34AM -0500, Kurt Borja wrote:
>> On Mon Dec 1, 2025 at 6:09 PM -05, David Lechner wrote:
>
> ...
>
>> I agree, this naming is a bit confusing.
>>=20
>> Andy, are you okay if I revert this back to __ads1018_read_raw()? I can
>> add a comment on context.
>
> Only if it doesn't start with __ (double underscore), just find the best =
suffix
> (or prefix?) for it.
>
> TL;DR: I'm against functions without clear semantics to start with __. Us=
ually
> this means unlocked in terms of spinlock/mutex/etc. Is it the case here? =
IIRC
> it is not.

It is the unlocked (iio_device_claim_direct() mutex) version of
ads1018_read_raw() which is the .read_raw callback passed to iio_info.

You might be thinking of ads1018_read_locked() which is an
spi_sync_locked() wrapper. I will rename it to ads1018_spi_read_locked()
to avoid confussion.


--=20
 ~ Kurt


