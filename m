Return-Path: <linux-iio+bounces-2571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2F855670
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 23:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D9428A311
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5155E63;
	Wed, 14 Feb 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4+rjoEj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB41420A3
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951506; cv=none; b=h0OwGB6A0i+dI+iiQUXMYTqMQW16ePLVqBV/QT3/t+euAeyRcAV05WI22iTxROnXjaOamArNd/NQqPVdt41FsC28BpY4ehTZiQ+fnY/rgMPE+kos785jTRmsndHCrgIjL7YNGmez/tPwjaeR530UW27rrujaVIG7uhmQp2NUmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951506; c=relaxed/simple;
	bh=nHDYxuJzDZzUExkAmva8SO34ZMf6jqhtrRlqDR9Y3PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AKfWgrxa2yiP+nI8tEcaL31UflUsaczdy2g4v5KvetnGa9/d8R3zjchhmSC8FPCNrarIgOWUpA55U57KJArrth0oX3Wl/7WcdJIvAJqqVrvHOVfYrZRGqm0jCEGCiJSwXHF37tOc56rLvhpyleclqzbO3xzLjsj/zJFX2cP76sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4+rjoEj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d91397bd22so1876065ad.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 14:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707951504; x=1708556304; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVS68OiApOOyfI1PyYAy4HH++SEE/fZ4CseAWhKfD8s=;
        b=m4+rjoEj8gASrk8wsf4UhS1Tr7EylM39kGfwErOAXqxbKCCwLZ0jLp16AKnaUjctNL
         TtaEFM5Pg6MDbMhRY8NDgKun+okX6dPunhB3TbWJTd6LvIPc56oFUTrxHdNIUWVUl15/
         izyVb0jJjnrs73KxNdSS4OqJD2ZunDkvYcxFgo9PwKIgoRO5DLnp/bFC+2w+K+t5Gnyb
         L5Aav3gvW6J48iQM2CsBK7RWu5GtoH+8G5L7/PtWJCw66+3XDhkvfa5ACZwhOr9FvEJy
         2wvqwUjwELGs6Oa4YEgqtuWtx/42udpWV4khCm8FZbMrVA9AQMTgpXmSu3skYM7BdQm8
         QDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951504; x=1708556304;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVS68OiApOOyfI1PyYAy4HH++SEE/fZ4CseAWhKfD8s=;
        b=Gp1xyng4rXTcwXG8XlIfReExpf24rZZM1T08EckXekwrQTuh4bXmALUPfSmIccY1f8
         ZjH85eR40yjOt1PR/pkouTdnayNt3E3puzJiQrsRVaCb2X8V8tBeQCLa/+dG92sbH2FM
         dJ/vLm8Y0+KR59AC2A4FUcw1W4sZctaud3DAKl3CCsN+2Ze1ui8iEEL5DcRaixIOVhFF
         xUhZGtsLtb0p9b2MUiME9wihs3m+CClaR3jFzS2uULGrvoiOGWL5ASaN+zb9MMGKSjsR
         VXQxctBOxXxhqFrLJPMmGnq3qjfYJpmk1OGNzZqoY85xl8cuHPQHiYZwV1TGnqHpWZ/j
         AH2g==
X-Gm-Message-State: AOJu0YyNAXqdmREYJpVk+WZ6Yrm4TOHRZdMzdch/GN10JEBO5NmgS9M4
	PmSvzSbvghHJWAtWpGJPp4uVP7V/fjC3xw2TlHBd+v8XBwLmzp17
X-Google-Smtp-Source: AGHT+IENOeG33hMO/im0QDeBLM545e7napwS3uz9X8tjvvZWAD6V0Jn9/eW58rLC5fBVhNjEKpeX3Q==
X-Received: by 2002:a17:903:984:b0:1db:57e6:431 with SMTP id mb4-20020a170903098400b001db57e60431mr62204plb.17.1707951504425;
        Wed, 14 Feb 2024 14:58:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWEHc/o7nysTnLSwr8xUAgXOHeoOqorWf+BUBN904+/cgJQAmlh0hHEgJXHK/gm/pO1eOSQld5IxcrFdpdbQP53DCVUtqloDQj4GWmcr9dTB73n8Rf3IZq8Qwcr6cQEzmFvGSZfUoQicJPw1Oyc+6Gh8GBxTvnMu5srlozW6uI0CEoVGyjgWO5aFF4oiK6A/8ruxQOB/9D/L/1XKaPedimF959exohDNRKqgB4LWA0Ul8bV0fXLl/HrDoyb/iFoepUvtYHeYrkvchmYImqXE73f4EOMbOG7XGOuWk4mp3NeR/G2cXzcQFv75wZeJTS
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id ku14-20020a170903288e00b001db5ea6664asm1574584plb.21.2024.02.14.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:58:24 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, andy.shevchenko@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jagathjog1996@gmail.com, luke@ljones.dev,
 benato.denis96@gmail.com, lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: [PATCH v4 0/2] Add bmi323 support for ASUS ROG ALLY
Date: Wed, 14 Feb 2024 14:58:22 -0800
Message-ID: <4563303.LvFx2qVVIh@nobara-ally-pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2332044.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2332044.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v4 0/2] Add bmi323 support for ASUS ROG ALLY
Date: Wed, 14 Feb 2024 14:58:22 -0800
Message-ID: <4563303.LvFx2qVVIh@nobara-ally-pc>
MIME-Version: 1.0

From: Jonathan LoBue <jlobue10@gmail.com>

Changes since v3:
- Fixed missing summaries.

Jonathan LoBue (2):
  iio: accel: bmc150: Duplicate ACPI entries
  iio: imu: bmi323: Add and enable ACPI Match Table

 drivers/iio/accel/bmc150-accel-i2c.c | 12 ++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)
--
2.43.0

--nextPart2332044.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXNRY4ACgkQ4obKiQwb
1x2azAgAng95RkNvpB8rLk3FRzWB0lyF4nZ26KLkCcd7HomjgJL5PiTmJ/4+SlsP
dfAUXSlEmsy/tFVT4OJV3d1L0fni4+E91ACE8gENam0BLV7w1Dca0Qv7EpTkdqAy
zgtHTgmsLkW+ney/7pmggCfAJb1KE56xbGriIfc1rRN0VFg38RCxjPieQM8gLww7
Q8n3B0+TYP3ZpFwtyk+w0BzVh7DAhhT4BAmkLvifaUDgLxiBwfhSlbkmfNnk54Mu
Wb744YQu/QnOgWEclgbiNAlh5Tqd8pqFHw16WIUDALo/HT0vIa7XON7JXxMUdL/4
y9/4Uf6oGGOaK4eWOQpn93vAVOCX6w==
=tCnH
-----END PGP SIGNATURE-----

--nextPart2332044.ElGaqSPkdT--




