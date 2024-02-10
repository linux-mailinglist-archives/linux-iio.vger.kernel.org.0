Return-Path: <linux-iio+bounces-2382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE812850645
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B8D1C22BA6
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32865F84C;
	Sat, 10 Feb 2024 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYqsvMYN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF3364BA
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597806; cv=none; b=fDWTJ3Q5/wPrUDDfCYtULHwcROZ2CANb1pUACplGkqv1vhxzTmYa8d8LdjCU9GIyqVkVJOIikpK2pFKF6rA+Qtbd4WlrlSXqktM5Vlzl5F3aLV4r1U71yfgqj+fPoUu4RPYAchAGbre7XxoP3ImrtZ65+SHuESSrMLGEsE+ChMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597806; c=relaxed/simple;
	bh=NanzrUPahvG7yrocFNuERzj+vDeatPv1joL6kUeNy5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctoGPAlU7MSXKFE2GEfYsF4PQcRj/xvZ2Y/NcpicTYVo28QYGM0UQyKV+k1YR7KVjvSn8eun2LxufxDHWamVYk2/cICOdgWMB4h+vGi8tFiCMHQ8wtOYE1+aTGi/efORbOf8hfW5bebYoPX8hxm0tenj+aPjc4XiubpgJxLYf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYqsvMYN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d72f71f222so17856455ad.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597804; x=1708202604; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1BpWqYzss3dbN51/lA+tOPH+KqCgrWYrhuHXPK08Tk=;
        b=KYqsvMYNLEF+/BSk47UnStH9Y8vRpTMEkni5GHV8VQ25hjyNSvLQITR7mwd27ARjq/
         qR7dGvuhMI+uTIfb1TrMAPZ974XuQROrzyRMDE7wthUbjFK7z0e+ntMotYH7zVQuQWX5
         CrKHFgIWBZS7KAwIN0l6XdFGkvj2WdyCSdzvMTUR4Uq/csVhl0UEgn3WAZtYiLy135VL
         TzUtak3AvWjpT+TcZRtUUGw3IeZ2c7VoMb84n98nUB6DpFitqj1qPBhteIT+Znq1L9pE
         X6CeuXK4sCv+JYwRP0smIJAlJUJpyQSk2mMtBuc4kulQ3yfvr+HoptWU1XupFvt12sP5
         DB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597804; x=1708202604;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1BpWqYzss3dbN51/lA+tOPH+KqCgrWYrhuHXPK08Tk=;
        b=LhCsJVdncbz6JTTNfRf4MO0uzD97zTaQh5h5t9EU0CJGhRjCsAWYV+WYOyrLOgfPQS
         43e9Los8vJRXFh4eNFf3QzVgMLJfSYoFurAQDi4TMQJI1wjEEolpMt54extTVpmJToew
         VlFQUXZ2H3FkAtHR7ZMvvSgBr1/uNZk6gHvlk3Vc63xWvHXBUN5F+jCY4AvQBHFU4/Sj
         Z/kGF5uYBYxCA1MRaryTBvo37yUJUBFIEKb4guyJ2zDAnicVtK1IaM+aK+0vnCx+WEgo
         p5XHBRiE1GzHDewSkFXh25mvUCrXlmxFkZt9sE3FpZXGjn4LJEAvuYzRldtGib66j4a8
         +Gng==
X-Forwarded-Encrypted: i=1; AJvYcCV92iGnnUqeDXuIy9Vi8allO+XAvXyqwtJj45baZo/iIK66L6KAzFC2yvkRnLPN7bgtrUXM3BLEB98J64xegFoU+btov1p5xHyk
X-Gm-Message-State: AOJu0YzUWBcHDL6xZEhn/cfxaCjWxcrN96NW9UY3i5dGTESDr6HflW2b
	r0SRWD2CkK3DEIujjvlZiMMcqEkghZ9ReYC02/7QTTqCosj12jwg
X-Google-Smtp-Source: AGHT+IHnI074nkAfTRAn5OxoE+tAO50ZVbMQq7Mdcid+//YOp+VtimViek7ktdj+8lmjxFeBC8ti1w==
X-Received: by 2002:a17:903:1104:b0:1d7:88de:cffa with SMTP id n4-20020a170903110400b001d788decffamr3481300plh.19.1707597804401;
        Sat, 10 Feb 2024 12:43:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXh5CFnQQmvzM10Y4Y05O3ZQkkku1FP1j6kW9zJK91b2GOFQpcaMt4xyEqzJyUbui0YYJF+dfZsqO6Jf33VVKDayQofEv+qq0x2cd9L6qM9TfC8VpNwwwCDymNWQFMyd71QEdbmq7L72fN6iSvAaa1LjxFfJRQmzhC/IAam8aT9czeeKGBbrpKDn1tAO8ydYXLtWonXQPfdBmi/6suwX1B5iA==
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170903290f00b001d923684323sm3400141plb.195.2024.02.10.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:43:23 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 lkml@antheas.dev
Subject:
 Re: [PATCH] iio: imu: bmi323: Support loading of bmi323 driver for ASUS ROG
 ALLY
Date: Sat, 10 Feb 2024 12:43:23 -0800
Message-ID: <4923946.31r3eYUQgx@nobara-ally-pc>
In-Reply-To: <20240210164956.3d29e3ee@jic23-huawei>
References:
 <5769241.DvuYhMxLoT@nobara-ally-pc> <13464735.uLZWGnKmhe@nobara-ally-pc>
 <20240210164956.3d29e3ee@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4572599.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4572599.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 10 Feb 2024 12:43:23 -0800
Message-ID: <4923946.31r3eYUQgx@nobara-ally-pc>
In-Reply-To: <20240210164956.3d29e3ee@jic23-huawei>
MIME-Version: 1.0

> It needs to be a compliant ACPI ID.  BOSC is Bosch's valid manufacturer ID.
> The code after that tends to just be allocated by someone inside the company
> who keeps a bit list of IDs  (I have access to the list of HiSilicon HISIXXXX ones for
> example but no idea how Bosch manages this.)

Understood. So if there isn't already a valid and unique identifier for
the BMI323 chip, then BOSCH must come up with one in that BOSCXXXX format.
Then ASUS should update the ACPI table with a BIOS update to use the
proper code for the BOSCH BMI323 chip. This is certainly the better long-term
solution. As it stands now, this proposed patch will get around the current
problem. If and when BOSCH and ASUS update the identifier, then the first
portion of this patch (unhooking from bmc150) could be removed. Then the
ACPI match table added in the BMI323 driver would just need to be updated
to reflect the proper code for the BOSCH BMI323 chip.

> Sure. Please also wrap your emails to the mailing list to under 80 chars (roughly).

Yes, sorry. Thank you for the guidance.

Best Regards,
Jon LoBue



--nextPart4572599.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXH3+sACgkQ4obKiQwb
1x2/JwgAhw+lJdZSofS8BW7Fyd6IkkHUyS1Nno1Xmu7iLhvfMOqjRQgqwiIFVuJ2
LPAvl2Ou/Cl9tU+Ajgvck2RIe170Nro7IKPAuNkpCUhd3seOBj/gX2RGXy5QwAbu
3+X8mMDuug6zY/tamYwvRBdVWh5LCUvdSquYWcxcpX9Nl+/alkD5ydW0F2Dj/+cJ
maFLiHv307JsHpvzTAwFh1oj2Tt4pOwStMY8kohjRgJEGsWHFXQcEMnGlVg5uKLs
1j8hd4vjg00Rji3aYFyy9CJdgONjwD9b7ahqN38/SPk4CSnSXBoa435FN63Blgm8
blAk/S8PF5KtjOPDmYTeni+AQLv6+g==
=3awB
-----END PGP SIGNATURE-----

--nextPart4572599.LvFx2qVVIh--




