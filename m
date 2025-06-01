Return-Path: <linux-iio+bounces-20111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB58ACA030
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FE7A2D50
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494023370C;
	Sun,  1 Jun 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnN3GJ3s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4217583;
	Sun,  1 Jun 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748804936; cv=none; b=lK1zjZGSgHiDVEAlzfpWktND5gRlFwQ4TYeiXhwS1Lk3dLsLbTYjYnmTCZOxHTB/rQJ7BtkNtqk3xI6hmFtf8Ls1K9b9VNsTvoknisV5lobI5vGnsTnhoXkJcmPJPU7Ymfp0/WNK+aticEtFvcKQvXzZNVLngp5yDGb/eQrBXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748804936; c=relaxed/simple;
	bh=mhfvh/QtAfQRrZiRLrdd+JvctKjg0sxsXb11Nzud8N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibLYRMm/Kz3TlVU3KTsKQaIBrhDBjrvFDCPs5IwBJJh/kTELGxmarC/XM0Jc6YgbMz+osH0P+VpSIO+IsFcVp4iwrT3sWvSUrFre1iN4M4iP+w9OHU8yQjvLAoJG79qo8Wx8ekQssV4I+POXkgn2qt+OOKGQATdtoychraAF98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnN3GJ3s; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad88d77314bso669879766b.1;
        Sun, 01 Jun 2025 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748804933; x=1749409733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhfvh/QtAfQRrZiRLrdd+JvctKjg0sxsXb11Nzud8N4=;
        b=lnN3GJ3sDMXbnn0txE7GuH5NW4dxwDpCReLDzjtQhzI7Wj+4fuhvQOBLL1MHLqW4cz
         bhwQ3Q2PY+iOZ3Rp1sOeI7c+et1+ZOK+VGrt5yKjLJck+2a8xppQOGRqjB6DfXMXnD7h
         N4sfJrR7ryafeVgAkWYW6FGr/hbm0c2KTp1p1AgjjmHUiiMtnqO2T92vQeV6Gpuvojyt
         KZNDPlow/wSGflqtmjtNotkm1iJqZVCRDKEVenf2fgTYgh+ymTrAuORBRFfVsVUZ17wp
         hKQF4WVyP6P+B4H+FoILdiaIsV+iL2ap2E+baeIkEEQ1sSRhTDD5QmrW6C3nrIaUl38u
         RlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748804933; x=1749409733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhfvh/QtAfQRrZiRLrdd+JvctKjg0sxsXb11Nzud8N4=;
        b=TQbSA3dhy7ubrxHHIZCULtGA/l0jMxjwU5sNSeGJitM8wgkWAckSDu8llMzwN5J0dX
         5QuPyFsK9/cyy1kKDFSHPwVu1jpJ00pOA1NS0Uio4ux5CRjKoM92lVcqEWhiIdMNx5d+
         aoIn3NFyUijRvxgv7zsLjkqZk4GZJEbWSPYn/g/54mwsNRKFaaQHrJW3RPwmMMeRQOUU
         F8YchlscG6TGq8zfje1kKnKkkE5z/jlalu+BYBhXbBVjgedQWEekpksYGZySQKhW36zx
         RWUJyOP55+zAoZ5ihXs8HJI5Ct0pRWTsDkcTpv7etMnGXSFhPOe4afscF8s166t54VLA
         fuzg==
X-Forwarded-Encrypted: i=1; AJvYcCVJZkGjJ53aLaQGvk6Qwg5yOtPf4gnZKugZbY5C/Q6Lq+JPOssqlLnrDodQJnsdXcucEhkQrFTpDIzy@vger.kernel.org, AJvYcCWD5jnSvTfbTtDS8+zsvgRNaQ2f1JEvDbFZg3ykH6mZ13kdjYBPzpbqRPWpGfRtxB8DYlASzAKQs8s=@vger.kernel.org, AJvYcCXbWoG5a4WQE9/yMu0VkjQaH9CvXXvByXtD3pY08mMKdLQkK4Tb6tuDwgzjDQbSoclMuOkYt48nCwttCu94@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2bqoIsLHAGCASg9D1ff1z4OgkCj9yGMRMk1K4T0stzQWR3xS
	hIprMtVBUj+5JEjQk07kKZWWwrbpGQNX595nzvsvt10LrLoODKbBRB160uyEPgFcU1LzQYXTNYK
	ZVQGDrm/nIBGVUaFp4/Ho2x8N685LZxs=
X-Gm-Gg: ASbGncufg6UaSq2RSaQbWGvust8bj70t4892V+YEfcb1ZoCn17x/0JRWC/5JcSBNBqm
	mE2gH/8ZJjK7ay3/6PYRjQMq90Lg2CiAdaU4a3h7dculHjHvn+uhTseQcatQNmjElwzRSubIqd5
	VKcQytlC0MkjcEhiUWNUO9QFK0dUfctFT2
X-Google-Smtp-Source: AGHT+IGFHJ5HoJkyR54evTw6J/I3oBCCjNWMi49D9+cgMoJg96VFzVShvDwYslwOKz6pFijtYZeTnhiLmMtW4uIndUk=
X-Received: by 2002:a17:907:7285:b0:ad8:a9fc:8146 with SMTP id
 a640c23a62f3a-adb32305084mr995548566b.44.1748804932704; Sun, 01 Jun 2025
 12:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-3-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-3-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:08:16 +0300
X-Gm-Features: AX0GCFvaeUQ3c8TRiO4H1VMAij9hmOSmW_8xYwWsyvW1H7Hl6fe1vt5jehTSOxM
Message-ID: <CAHp75VfitLPHZ=SUS-ME_fhJqCAwuDAzzN8yt1gq5Drvk7ySow@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] iio: accel: adxl313: introduce channel buffer
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:21=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> Add a scan_mask and scan_index to the iio channel. The scan_index

IIO

> prepares the buffer usage. According to the datasheet, the ADXL313
> uses 13 bit in full resolution. Add signedness, storage bits and

bits
...OR...
13-bit wide data field

> endianness.

--=20
With Best Regards,
Andy Shevchenko

