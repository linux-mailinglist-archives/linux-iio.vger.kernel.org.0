Return-Path: <linux-iio+bounces-20325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D8AD18F0
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 09:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21653A92BB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 07:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8D17A2F5;
	Mon,  9 Jun 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRwKzN36"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAE4C8E
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453497; cv=none; b=F5R2I+rm0gLqZpjQTzTdXNll2WGn6GipRQUsnGC6Oo6GkLCQRvkFhV7FllcY0lorOQCZ1tMaUH3K1ILdXTLmq+4bxe40FeJce5hlx5rBMLnQE0UIDNm3dXTxrypC2Q9Xp86NuoUg81U5WHM1uO7lYSYsqm9RJ5oWcfZtkNPDn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453497; c=relaxed/simple;
	bh=K85GqHIfkio1/ThzJ2kZ3DG0V+wjG9AE435nYzNsQow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDYc/p3UxJptNWuIjY7AwtvU6amQIJLuO9DB4jhN9pEOVsqQgxlYAr2AI3G2AzgTGHYmXDRHlhWa8jkq+KknHqjMbqWBdFotKE32ubyc59S5kEtJq6E0ujU4o5lP2NFe4rXhSKYqzTbUc1WVTsAjukFSddTsAznFkk2ZTkpxsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRwKzN36; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so2330636f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Jun 2025 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749453494; x=1750058294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K85GqHIfkio1/ThzJ2kZ3DG0V+wjG9AE435nYzNsQow=;
        b=dRwKzN36RpVT6PljHiHrtlIvLUOzTLCBEfexe4Z8LM9LiQmF6+Ojr0CptL5SNB85d1
         blV7bwDWp2TY44ii2U2pZ3ujl2CKYos6P+idUDXlVL4UjuU23bslRQYUsiulwV3FVte7
         DysxTOdSrVvg+Leni1XIZAanzWj+e08rDLueHUrMBbut1aa7usUbJUWrsLqDAl6libeC
         67d0w+1wiGOlqk7b+1SK61ODFhZ4WxqAftC7cGo5mWmRpe9neJkebO53cg7jm0zGZt5U
         Jopar8/oyU2aXqxVXElEKjyVFRbxxG2jTj6KLOHHbuU0vPq+goAyL2tVj5pmI4w2heW7
         0KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749453494; x=1750058294;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K85GqHIfkio1/ThzJ2kZ3DG0V+wjG9AE435nYzNsQow=;
        b=hRRPKdYnHd221hYA1yavA22Kqy3bn0HyU8/PPFiiHFwjc7Ex13ST76VVxNOvXxLEtt
         FYJtjugx+ajzm4Tk0K0fyqd4aSkAy65C25TIb8YMk9SDIy8G2oOVcphEgN1icGzvgavY
         vC64H/f6xY1owx5QlF3x/1GoAfDQt457gO+8dx1iTb5KemzQgvzIFXYap0eaT/N+CH18
         /HzJdbLwgt8l+KHKF7MikW/Dw9fxNtRd0EtyARmtyCaqqLY6IrzAAdCwklle7uWri1P6
         KOWqb+V0M5/8S7Mt5LtGN3h4ulwLE9iVFT90uY+eS+jcfSyqGl0aoVEP46fEakzJAYad
         /jbA==
X-Forwarded-Encrypted: i=1; AJvYcCUixh/64qLjd6DAUUjHTVMSXY8MZEldRXr+L2/36zKI0wEaUIMLNu8QR7U6lmKds57qun6+gx6kOU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVRwGz3utM+nz1C4WH9SSS8FJB09rSkfy38jMGPocbCHeQ4J/
	TH3tOUVHDLQHZhqI+ZQEk8jEuLSGV3LLxoFqVqH0dDhVCRzsjDlGFJ/mCXcZzQPw
X-Gm-Gg: ASbGncup726Ys79nG9fJA8raqldAYPHJgLnXVsKl5xHtL2ScTg5mh0kyd/874s3T03S
	xGtKcPlKA7vFoCFLCB4AAmD6Tv87uiyrJEXIbivij/Lb7yQ3JuhKFlhMnnfeMZ9/pOcv62O+aak
	/sq/Y0GtRvIif8xFOril3J9uAY/Yc273l10Rybb9j06FMy3Jzq/J1ScnH/DCRirq0S6QqNKy6IZ
	c+xu+/JYTvJj0BRKE6Z6jIVS2qpcXoKWbAAHhtovwqCpNSuzRz62YKUV2Op3khVlm4I09YW5ckd
	ctJ8x+YL3PYSFNswZXl9dxiGCOUK7PJ+4W9ASyBNOu5mt8tcEkb3U4GtA7I=
X-Google-Smtp-Source: AGHT+IHZ36vjA8WCOk/DirmThGS+EMZtxWrcm5I0st1VAcu0cMVJGX2sGFQxnfhnqH8w+0ACnAOyvw==
X-Received: by 2002:a05:6000:40ce:b0:3a3:6b07:20a1 with SMTP id ffacd0b85a97d-3a531ce1d4emr10610474f8f.40.1749453493867;
        Mon, 09 Jun 2025 00:18:13 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532131df6sm8659168f8f.0.2025.06.09.00.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 00:18:13 -0700 (PDT)
Message-ID: <2522a30dfdb4b4321e77c6cf20caab2b02064e44.camel@gmail.com>
Subject: Re: [PATCH 0/2] IIO: Drop some unneeded export.h includes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 09 Jun 2025 08:18:19 +0100
In-Reply-To: <20250609070616.3923709-1-jic23@kernel.org>
References: <20250609070616.3923709-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 08:06 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> 7d95680d64ac8 ("scripts/misc-check: check unnecessary #include
> <linux/export.h> when W=3D1")
> brings some new warnings about including export.h where it isn't used.
>=20
> There are similar warnings where it is missing and should be present but =
more
> of those than I'm going to resolve this morning.
>=20
> Jonathan
>=20
>=20
> Jonathan Cameron (2):
> =C2=A0 iio: potentiometer: Drop unused export.h includes
> =C2=A0 iio: dummy: drop unused export.h include.
>=20
> =C2=A0drivers/iio/dummy/iio_simple_dummy_buffer.c | 1 -
> =C2=A0drivers/iio/potentiometer/ds1803.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/iio/potentiometer/mcp4131.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A03 files changed, 3 deletions(-)

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

