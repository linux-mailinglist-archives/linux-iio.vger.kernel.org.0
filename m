Return-Path: <linux-iio+bounces-12781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAE19DBB81
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90294282338
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E71BD9DA;
	Thu, 28 Nov 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU/wSe9V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821017993;
	Thu, 28 Nov 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812615; cv=none; b=suwvFkloKq6bpegiW/VHftCm4bkP6FPh62Sw3mJhsFjYth4odLemDlGKIAnnWsuZADkwXX1iPeE1Gla27Co4++vxI0eUwM+9J1mt/WMKRfJJ9GNeS2ARgtesYZEHVwSVCUuUsOzaDAg5a0QtDnnHbCdgFjy2eCh/KAn/CJLPlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812615; c=relaxed/simple;
	bh=B9LamEltLM8NY+TE/NuniKqlhE9bekMD3/4hlV+wzsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RxTUqDzXT1LXMq4aPKIyVohBFFpEAwnqIV3uOC6G6Zbfmf0AoQ/ghaFvAzcFp9EyJPMMOmWEHHn8DZ89+QaW6YPUrUIUv685Gdt2rMRwXCcgNAf4RcW9fGAmYiUvcA9lRS7aaoNgrvq92I15tcG/lFCzLr+LwNwQA8DAT17ZlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU/wSe9V; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de101525eso2008131e87.0;
        Thu, 28 Nov 2024 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732812612; x=1733417412; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+gB49SvqY2KKegn6bE2TSnN4kHXMwlmd/Hme74r99w=;
        b=MU/wSe9VTQynLA5QxpmxOTFMlr2H1vsos1pFdz5OocFxNI5mEZV1EUBm+tjo0vIRWg
         VFCVKcqV+qBfRtXWXFxhgSUzYtsdiRAbyoCizrW6zMlbCWJ1CzvYxG3iOf3DWvHHOg0+
         T03OLt3Bn4tpnPAnkiYQp4RwnZMcrqO2bJmxVR5WVMNzTH1oUQafYw4QbU9QDOOwNfkC
         cgBGwWYGvs/PdtQWd8SMWY7+g4S4k/6uVXlcQo0ekRGJs92Y3NoO1yPFwYQjhKS3Ohh3
         wBayXgmYcY7lWjpjTFt86k1+Jl8YY12uIXqs1j6Xm/EN3UpOKcymdRJc8i5I7KYQZmdy
         h1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732812612; x=1733417412;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+gB49SvqY2KKegn6bE2TSnN4kHXMwlmd/Hme74r99w=;
        b=mi59lDNbLW7mgrDdIQ4wYlPzhwDwRqOkvXyqXd9uPhKWpJUUFpUjuOT47KHyRvFg30
         12DLgWCd+hsA3E6Mgfl1dlU8G8SJG5Dwirx2KQaBgdSBFEaF4+ofsChhhMZpva3FTJd5
         mWTsGtDEUHdGxmyg2st6LA1Ad+sZF16tJTCoCad1kHeDEhC3DanVNwdmjCeeVMdl30Qw
         lZAxeyI7VFEjiyaywpfaf2Ri6iWP5k+VGM3dOONopUwAhvE0jHMHhYcvyhK4ce83Acmg
         9+FQx4DyOM13cCnY+gyr7/NT2j0aeMGXMUA3FA7JA40plavSF4OVjliUjQQtvqkWBW1U
         Vq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAYLG+Sma2uys078JCXakzH91cOJsBe4EplkiT/vNpEOz/92u82PD0amvBruPlHMrN2ofUVGXgyX0=@vger.kernel.org, AJvYcCWnmLEZhk0Mbu1EGV78LErm3ZsIWpMEjunoQ6LJ10QV03DKT2S3ER7siPpezi6jAp14BAaw+AjKRlUHAC3S@vger.kernel.org
X-Gm-Message-State: AOJu0YyaCUBbMRUcJMtL629afpMW+wE4SdgC4Bx+QZ32rd8eU4UB2RAk
	gminmVHWudqw1EMYAQVr3qllpUKx3AdtzJXa25vOhGCq88INQxbl
X-Gm-Gg: ASbGncvmxLDBaFXWUqR/BTR2k+iNaYpLDzmQGXAjUitUAeS0uz2O8DWALHYhCobJsSr
	awEUjSb+dTIhMJ8P5/P2HKp+vk/SEw6b/SVlAJKY8Vt+7PLPo2nXohfcrAbkhsPp1CR7GoX1UNS
	oYiweyOVmM3pI62o2qSHaOt7Hiwh7YPkIZXUon38ptUZ4tHZxMcCqdJ6QFySMhBwZrBv1jzVkgT
	EYEt5npK00bXmsYwdACInWXXL3OBPs3GQ1l7vC34mSD1WjWU2mY58ng
X-Google-Smtp-Source: AGHT+IG3fqEGilwsEMzAT8ZyPFxvylsDTw/715Q1i5YL6BVxdS4SDuxEgu17EB9RbpY9qCl30xlHdQ==
X-Received: by 2002:a05:6512:3f0b:b0:53d:f63a:e428 with SMTP id 2adb3069b0e04-53df63ae481mr1116850e87.27.1732812611306;
        Thu, 28 Nov 2024 08:50:11 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f2dasm227411e87.158.2024.11.28.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:50:08 -0800 (PST)
Date: Thu, 28 Nov 2024 18:49:58 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: gts: Simplify available scales building
Message-ID: <cover.1732811829.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TJFT3yMwNgPVaYaM"
Content-Disposition: inline


--TJFT3yMwNgPVaYaM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify the available scales building.

Building the available scales tables looks confusing. It has also been a
source of a few memory leaks.

https://lore.kernel.org/lkml/20241016012453.2013302-1-ruanjinjie@huawei.com/
https://lore.kernel.org/lkml/20241011095512.3667549-1-ruanjinjie@huawei.com/

Attempt making it a bit less error prone by simplifying some error paths
using __free(kfree) from the cleanup.h. Try doing this without
introducing variables in the middle of a function while also improving
the logic of the functions. This is possble by splitting the long scale
building logic in a couple of different, well purposed functions, and
finally streamlining the logic a bit by taking out one extra 'total gains
to scales'-conversion.

Inspired by the discussion here:
https://lore.kernel.org/lkml/2d16bf36-57d3-4c54-bbee-2e7d93399f29@gmail.com/

Matti Vaittinen (3):
  iio: gts: Simplify using __free
  iio: gts: split table-building function
  iio: gts: simplify scale table build

 drivers/iio/industrialio-gts-helper.c | 171 ++++++++++++++------------
 1 file changed, 91 insertions(+), 80 deletions(-)


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
--=20
2.47.0


--TJFT3yMwNgPVaYaM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdInzIACgkQeFA3/03a
ocXC+wgAyFL6L2BsUx796J0g4VapmCrPzJhdTVJUQuYIwTOMo7zfV+9AM+bXhu7k
fDLW5fR0eG2Rr/dDbIA8XC8MAthgPJVdDYfT90N+Wc5bgxgA9LKCaVCikCpbhFhx
TEO7B/vyV7EM5/asDhPJQ/0xDdlyfO2WhQlsoMqJWfBZuNNwMUSaIuXzhW1Nfvgs
UM1spBkYxWnAi5Fomm3JQzWHRy2YKl0f8K4TkN+6RulgKdksO4oyrYC1vJiB3sNb
vQJg6pHXNuTvgPDWABqjD1AAdxc3TiOv0RfHtT2zqIhW+emAweD0UbowJOkhPxU+
7rL15wrleMOpSx4t441JlhUyfeUXeQ==
=Vrz+
-----END PGP SIGNATURE-----

--TJFT3yMwNgPVaYaM--

