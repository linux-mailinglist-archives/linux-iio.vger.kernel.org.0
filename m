Return-Path: <linux-iio+bounces-5430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05C8D31AF
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 10:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC161F278D7
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63D16191E;
	Wed, 29 May 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmuBd/Yx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318871E86E;
	Wed, 29 May 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972005; cv=none; b=C9Uoal2BaN9WJ7soGtYKVwC9Rl2Nyjh+EYRA8pN8VEHzcHMRYjijNgK9lEHuGVqujOnJrtq1kBvv6nAC8CCF5PwYYUUagzTZaXx3RCc83fhLaCboO9e83VNGU0IvduXcPQr0ySaDHmbRjd2ZMtRy4tEoqZB6Nj1ZAPFi+MYNK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972005; c=relaxed/simple;
	bh=IBIWN3y6HrxQcUYk94qOtt1qzHvhNsQLMYeEF+vClC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXSKTXeQgfXMvTidRts8Kh+aLx673KDf7SDYUqFU1zt5DF/5tCzBH9G5Aa1y16mModRBV98f+v50FNdeWQsX3XGBLgXq+DlXxye/oyUAo1P0v8aiUNESuVHUU1gGSrxdq2HQZIJR2t3YUxxJ2xgslsm37hZNk+pCcJe3O3D3HcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmuBd/Yx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1176121a12.0;
        Wed, 29 May 2024 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716972002; x=1717576802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IBIWN3y6HrxQcUYk94qOtt1qzHvhNsQLMYeEF+vClC8=;
        b=hmuBd/YxyCGIEwa6F/c+Vy3lOpCor1yHoWfyMvJCaNvAsWyQ6FAqE5RjQCZbyXzLOK
         W/WQZkJlM5fh8Nqd66DmEOL6asy03h0h4RqhOR7s+lb22FtjQptcw75go95ZYnt13PFU
         4g1JVK53mFLBMamAvfh7aXZxR2JmpYLe+BXGjrBMuS34xPr9KPWnYJXllbDMqMlOojO+
         X2g/tlO63AYUArzXoL8zKegRkUYM8uMcnfLBs7ZZSLVy2ctSvx/FqyUp5Fo8N6wunaqS
         rGg9Fn1lHxlo9di+c+mYXot0JjVzrw0B2x0lkPJoQH21Cu9SWjiKbvqeAw4GoU7ogE/N
         LbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972002; x=1717576802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBIWN3y6HrxQcUYk94qOtt1qzHvhNsQLMYeEF+vClC8=;
        b=uVeEnyK0DpistHm/FyvqsSpD1rNJKqjKe9XYJOPodoSrk+s49qVjnKjFE77rSA1eU/
         BP9gsCRJliTgLrZ6Gd8FSD1VfVFtx2/abUrTliVo52FkZmuFu1+MkLeAvRl8MLfOL9K0
         qWYFRYxuIxq8KZ3C4N1tRAPHaB0/cVjIGEX3ByJPNXSX97FSwyWsHD2LJkR6ItEM9gMi
         CEpilzy9HYCuVdSEGrpmFWyR+xHpbVOSNemOm8pgxHPfJCxenUHIH2TcmNpGOxDXYy7N
         JW6lAAZ9lVEbCX2V+EmXs8OUQ4/HXWdOpNhlTqlxh5whLuMCd3ZV/r7gXEgqZOKvF+VM
         fkJA==
X-Forwarded-Encrypted: i=1; AJvYcCXeAcPzBFYDjp3CUhw75E0WL6HGrsICSzNyV7c0l/MWFvIY5z3JuXLFcfff2N0P9yyXPDoKuJMKLf5+HqnUQfmkxyCACR/Qv0BM7nHh+5EN1Yn8QOm1cn+Zp/eUEZI1Ol/5bCrEf6TnrHh5TBloOgFmUDnRfG6g2MeFCo/ywqSxZ89pjjo/4fEyvwRt929aKGvo2sZ/hE4dUVYoLWUr7w==
X-Gm-Message-State: AOJu0Yy9L3dAM3J9gpYwT1C1N2Oh2LqSIN308ZeFgnbugaNXe6zLfu0k
	8otRszPQLQEEeEphx96u6JuwngMC4Zl6G/K0YDsT3QliDPOwwNsP
X-Google-Smtp-Source: AGHT+IEoG1XCFPO7I5pv5unHDJNwv/gI3G3CJme48aiX8TK/JVVfJ7G8nGB6aPnYE6WuRVKyZq8RYQ==
X-Received: by 2002:a50:c313:0:b0:578:6360:aa11 with SMTP id 4fb4d7f45d1cf-57a03f2dae1mr1108414a12.5.1716972002216;
        Wed, 29 May 2024 01:40:02 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57861b4ddefsm6886535a12.60.2024.05.29.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:40:01 -0700 (PDT)
Message-ID: <5b002e3b9df0da1a81b248a4e4dcb82464a61cf6.camel@gmail.com>
Subject: Re: [PATCH v2 0/6] Add support for adis16545/47
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Date: Wed, 29 May 2024 10:40:01 +0200
In-Reply-To: <20240528142409.239187-1-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 17:24 +0300, Ramona Gradinariu wrote:
> Add support for delta angle and delta velocity channels in adis16480 driv=
er.
> Add support for ADIS16545/47 devices in already existing adis16480 driver=
.
> Add documentation for adis16480 driver.
>=20
> Ramona Gradinariu (6):
> =C2=A0 iio: adis16480: make the burst_max_speed configurable
> =C2=A0 iio: imu: adis16480.c: Add delta angle and delta velocity channels
> =C2=A0 dt-bindings: iio: imu: Add ADIS16545/47 compatibles
> =C2=A0 iio: adis16480: add support for adis16545/7 families
> =C2=A0 docs: iio: add documentation for interfacing tools
> =C2=A0 docs: iio: add documentation for adis16480 driver
>=20
> =C2=A0.../bindings/iio/imu/adi,adis16480.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0Documentation/iio/adis16475.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +-
> =C2=A0Documentation/iio/adis16480.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 445 ++++++++++++++++++
> =C2=A0Documentation/iio/iio_tools.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 ++
> =C2=A0Documentation/iio/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +
> =C2=A0drivers/iio/imu/adis16480.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 393=
 ++++++++++++++--
> =C2=A06 files changed, 825 insertions(+), 71 deletions(-)
> =C2=A0create mode 100644 Documentation/iio/adis16480.rst
> =C2=A0create mode 100644 Documentation/iio/iio_tools.rst
>=20
> --
> 2.34.1
>=20

LGTM

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


