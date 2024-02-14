Return-Path: <linux-iio+bounces-2568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD4855654
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 23:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48E31F2BC09
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 22:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE824B33;
	Wed, 14 Feb 2024 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b46/9Bkt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74778182DF
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950935; cv=none; b=ATQum6cwYv9nGhLpH7Dy0OhfXlBiamPDzVs2chBoJWFi7NdSUoVQtDxCrmex2VY3U1rfv92xeDvztJ45/iZxljfNktQEwGj5/As0yRHTpYH2iEqaEXmwvco6ZfyFOrsHi5ZU5tSx/63N2RSHPAuAL/TyP9siBDg2CDpJnedhyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950935; c=relaxed/simple;
	bh=QUH75UAWXag4XqH7f19hhZwMuKI32rgg4O59TKM0EjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uy9jpQpMg95O6mPOTQYdR2zRahwqxaYQmSAS9e5j8rtgSkkFptOBnuxh41HmPAL9taOzX8exAz6nZZHJ2d6DRp8WkD4g3RBap2LBnQY1FmN/sZTJDZMJQ5nmhliyxAXS5LZL70BfvZlSE0i5Sa5oYe1HptEMgGQzFYVQaW1XXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b46/9Bkt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db5212e2f6so2216655ad.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707950934; x=1708555734; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YHqfJXROfNkr/yo2YIWzvA3nYzkncBbkXu7trhyJXmU=;
        b=b46/9BktgihbpbumToNnvrjqYiAatdwaRKjCydu+5rFODOh6veJJ67Z601PYzBGff9
         aEEM2EBZdlhfNbViDnAfp1KQW0A2+MAwTI4tN3yBDPMS7spwQqXY0v4OwnkHI/KexFkW
         gwEWWviZLlIx5wY2Md2V2tgOZolXfShszhLq9IfWHV8GHicnPtEm5LAIn/CyLfXf7d+p
         0B3fJWKqRTAbjy5XtKE0gFwwbGO3cPNHlrXTuUH4gQehxrdlkRV5NDQ8Ox5//aoRuvx+
         HA1VLzzsVlqUlC0+ImTJjPLx70FA7Lj99NrhFrnXuYAWU4e7JPEpr+OH5mf9pVDODWzp
         3Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950934; x=1708555734;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHqfJXROfNkr/yo2YIWzvA3nYzkncBbkXu7trhyJXmU=;
        b=DwgTePXihWzr/aZ084xHbAFGNLd5cRFvX1/S6uiQsVZa3YOICmPVf19IPXvWbXRxor
         V8Jzu/wOuEmneuwdFf+ktqSy3qbfaGjfATUTzLETKNdHd7J4ulf2E0l07X/vzURTRf5y
         xDxwLc2hgZwgh/3JvgzRq2a+suvhtS3c7M2vRKTTImyfu/3XVWOOq0YEfHluBKKjdwXR
         KwzQhHba1B7ph9ctodlbAXPCC9I/+Pe3sldPhDKcG8ZwtSVsySwHEC54WhCwET59DCOD
         5LM0qzDcoeQ8Q9pKcSx2LYWcBimwmTPrKjDvB9CI1PIBkW6yWQULEbiwxEgGPb8N92QD
         fRnQ==
X-Gm-Message-State: AOJu0Yze35+1/LSlubwaNzA6QOpPHNo2Ph0KRfRqz/L0IEvXXSwz/NWc
	4tWeK2/6h6qdIj1tdZPA999cITGDZRR+yu4ZRDHBfxr2cn4Wkm5I
X-Google-Smtp-Source: AGHT+IGAOEwZGffgQ7azOGYeayTKPYr58KRYkIQ/rxUtjy8bJmJYmUnGDd17GqbIcVYvANGfPZlHEQ==
X-Received: by 2002:a17:903:41c5:b0:1d9:a15:615d with SMTP id u5-20020a17090341c500b001d90a15615dmr4330066ple.1.1707950933751;
        Wed, 14 Feb 2024 14:48:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzztr4RlIQ8vzgkXLXefmp/apDreXJ+eX+M5unqgpwo5bvOaVpC6XOoLdQKXjCuaKTBhWefHvgyA3ttfyx0nY98OIgp8Jem8NyAR4jVzjd4bI42gTSai13brOyVCniB69dbZb/DC7XL0C5TlonSTcoyPA//NWzdWNXK2KzeD7FiUCs7CMPXIRyu4eTounuPuVMvdRV0LqvJQRXWxiNihsVvphXORKIOWz3AUmKwV8C95TMkZwzsgQ98pJpUwicuT9RN+UNVsn+RxyuiX8/EQseuZime1CDf7/qmE/uLUu5omEzY/bK6gL0fXD+urTn
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001da105ddf65sm3056225pld.232.2024.02.14.14.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:48:53 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, andy.shevchenko@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jagathjog1996@gmail.com, luke@ljones.dev,
 benato.denis96@gmail.com, lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: [PATCH v3 0/2] Add bmi323 support for ASUS ROG ALLY
Date: Wed, 14 Feb 2024 14:48:52 -0800
Message-ID: <12397335.O9o76ZdvQC@nobara-ally-pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5771555.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5771555.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v3 0/2] Add bmi323 support for ASUS ROG ALLY
Date: Wed, 14 Feb 2024 14:48:52 -0800
Message-ID: <12397335.O9o76ZdvQC@nobara-ally-pc>
MIME-Version: 1.0

From: Jonathan LoBue <jlobue10@gmail.com>

Changes since v2:
- Updated comment wording and locations.
- Formatting fixes.
- Added reviewed by line.

Jonathan LoBue (2):
  iio: accel: bmc150: Duplicate ACPI entries
  iio: imu: bmi323: Add and enable ACPI Match Table

 drivers/iio/accel/bmc150-accel-i2c.c | 12 ++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)
--
2.43.0
--nextPart5771555.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXNQ1QACgkQ4obKiQwb
1x1sVAf8DjDN/pLke7vdmOkujAYkO0RYgbl/w+tqGsz8cjH55ujT8fpSR7lThL+w
EUa+jx4ZyabsTWoKwdPjtfOowjZ5uiF8gxWQY4P47fwHPq5wKyn4aMD/Uv7me46N
1ROmCofuX/GKXZgzh1ty8B7bZBllb9bb8SEfUPqq30CVmVQBXWLBl2hQ0qMlLFx2
YxttxElASY42lwq5vsgcufOiCZbc3k7a7NSuAvzDf0fVypqPpU+J8EVnft20/g5H
7sf6wp6RcnVxZI6rYS37QI9MO52GZvjGTZD5LpwW4MKKa6/OTGDwd72GD2yN0/so
0qHyokvdr9uiPSofm4Gv/pYAhMKjkQ==
=Zglu
-----END PGP SIGNATURE-----

--nextPart5771555.DvuYhMxLoT--




