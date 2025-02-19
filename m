Return-Path: <linux-iio+bounces-15760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60390A3BC0C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91E418850E6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323FA1DE2B5;
	Wed, 19 Feb 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnqEaXj7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A161DE2B7
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962286; cv=none; b=Vr92J8oasEnxsuFCruXv5fmHMTnM1gGnwqyyt3m5HOFE/R5wJGEFC0Fv/urK10gIeK3P9pYIOUAEgVC6CtSFSO3ptWXEL+a39v79W3jF7I6YmvQuE2y166ZLVsjyQ9t2LFlXZLUtcSlNQ0fsM08XILf4+ihNf5mi/8y8CHlcW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962286; c=relaxed/simple;
	bh=29nWSW9jily6WQ54TUR+Q2ZVUGgzAknko84J6O+xS3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhHWXyM/8CmxrUOATQaGONTnVGwQk00i/E7t12aOHtlZ1xVMsGWgxzUQ9vPBGN3WFEzLWpbw0tokoerM+ulXzgLwcwfSf4L0u93KUTXuTzh9wsaTkhV0LkRVxsl7k6678SOUpVOs3HJl6Fs4i7HkBVtLHzWPu7Bqo2fWXXap9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnqEaXj7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso997448866b.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962282; x=1740567082; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=29nWSW9jily6WQ54TUR+Q2ZVUGgzAknko84J6O+xS3w=;
        b=GnqEaXj7/LCs7au1hAtNCLth6jsvENhnbu6FAXblayfwYQAExWSlLeWskcTU1gSCSd
         neY4cqjaYk0lijT7xifXv3WjjXp33wps8BLuwiO/GM3mm+2kZg8fp7/4c34izBpt9FLe
         T6cp+LRuqGTWh0f+QxLxt7P2yuKMAyevR7QmbHHB3i8RKmmEwwAI0YpI1dCtzlfec5Hi
         nHMZngTMbgnewulPsuuRcGMdyDiaxWRdtWGDUEG4xg0XZGc17TLBirlwt63GTmqhAkrk
         bKMnVQMqjq0bvP524DPHYIXyW/2hm1uXaD4vVeOobPz64Un6cuykwN83ADr2EgWQg5jr
         txQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962282; x=1740567082;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29nWSW9jily6WQ54TUR+Q2ZVUGgzAknko84J6O+xS3w=;
        b=cp9R/77gqTmtknRe0XchqVTI8LQLD/t7lsEdeKwblxmBmUyNCGB5hngw3dQP9y57HI
         qlz7cZhK3eqqSQbKN3IwA8FVx0gz5PEbubK84IV+rKN9nezCXvr9iihTuE4DkxlrOSbC
         EgravL8dZ+p96ZhUa1ODKV/hrNCIqfiiN+xx3voBIGHe9UTXbHW0KdQhpp68X6dReorm
         oIBdewloC29G9slGgrNZwgJOGJvAsphV19WcB8nMt1fXQZW4Ldw5H2JSZgKB5hhEyGI/
         rGPN2jof1kEoJF79yy0OYuAoxxIkmtfTnVnRNMM8W2i0FNk6pxs7ZoIwzVL47peGov5Q
         90rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSnyOczV/rV0dFiz//49L6j5MdxCDoiNYiuFpns6KvsWXPDf5ksjz+iejwSZs1fhgkKVvaxnQbZs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOi6W9rU4AsLiY3ppVWqf0slDT0dN33fIH+h9lzykBpS0Rwn6
	Dnp6/oKjWn6pXPlG0tZAA05Am7FXchBYqUp+TfKzXFljLIq5TK1O1qS9YERdJnk=
X-Gm-Gg: ASbGnctFocuJB+//Pkl0BsrHkGLYaVhgOL0WQcr6U6s1b8YAOgQDm2C0lLYFY7qGv1s
	MsBlOw8CXHmbz52QxYu0dW+CKzInfOtx/OVenCmuJrMtj08+HqzBzN6elLNa3hcKDSQlwA9syCh
	5WYtKm4XDMlMiNhnXyeCHlnwLfX1ldRIWGAA5dQwhDEyTpVjyGSnnit+UxPUqZaNnRMqi96PhgI
	LkgCPzqaaTQ75w2QDpDFa8834bhmCyPW69WboKUa80vw4uR2u/J9pm7ZqtITM6G5ZLhRztIQNGc
	Ai5H/hJ1QfVvnPGv1qotf4liz1oCimQ7a9Co5cw/dO2Co3X0GHq8pGV/YVxlET0=
X-Google-Smtp-Source: AGHT+IH0xZO4JW/tk8LnfMdDgyJGvUS1SU0dI2wB7tnm9EIKwhe3Iuu6W6TT6R0MPytVHpLY6fKm3A==
X-Received: by 2002:a17:907:60d6:b0:ab7:f0fa:1340 with SMTP id a640c23a62f3a-abbcd0b2d3dmr328388666b.50.1739962282153;
        Wed, 19 Feb 2025 02:51:22 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba7c63162sm454107266b.182.2025.02.19.02.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:51:21 -0800 (PST)
Message-ID: <df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
	 <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 10:51:25 +0000
In-Reply-To: <ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
References: <20250217140135.896574-1-jic23@kernel.org>
	 <20250217140135.896574-6-jic23@kernel.org>
	 <0e17116e-6160-4920-83d9-086218245299@gmail.com>
	 <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
	 <ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote:
> On 18/02/2025 17:42, David Lechner wrote:
> > On 2/18/25 1:39 AM, Matti Vaittinen wrote:
> > > On 17/02/2025 16:01, Jonathan Cameron wrote:
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >=20
> > > > These new functions allow sparse to find failures to release
> > > > direct mode reducing chances of bugs over the claim_direct_mode()
> > > > functions that are deprecated.
> > > >=20
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > ---
> > > > =C2=A0=C2=A0 drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
> > > > =C2=A0=C2=A0 1 file changed, 6 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/accel/kionix-kx022a.c
> > > > b/drivers/iio/accel/kionix-kx022a.c
> > > > index 727e007c5fc1..07dcf5f0599f 100644
> > > > --- a/drivers/iio/accel/kionix-kx022a.c
> > > > +++ b/drivers/iio/accel/kionix-kx022a.c
> > > > @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *i=
dev,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * issues if users trust =
the watermark to be reached within known
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * time-limit).
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > -=C2=A0=C2=A0=C2=A0 ret =3D iio_device_claim_direct_mode(idev);
> > > > -=C2=A0=C2=A0=C2=A0 if (ret)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > +=C2=A0=C2=A0=C2=A0 if (!iio_device_claim_direct(idev))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
> > >=20
> > > Not really in the scope of this review - but in my opinion the logic =
of
> > > this check is terribly counter intuitive. I mean,
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0 if (iio_device_claim_direct(idev))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
> >=20
> > I'm curious how you read this then. I read this as:
> >=20
> > "If claiming direct mode succeeded, then return an error!"
>=20
> I am used to seeing a pattern where function returning zero indicates a=
=20
> success. I have no statistics but I believe this is true for a vast=20
> majority of functions in the kernel. I believe this was the case with=20
> the old 'iio_device_claim_direct_mode(idev)' too.
>=20

Fair enough... Note though this is returning a boolean where true makes tot=
al
sense for the "good" case. I do agree it's not super clear just by reading =
the
code that the API is supposed to return a boolean.


- Nuno S=C3=A1


