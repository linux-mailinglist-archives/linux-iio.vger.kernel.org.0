Return-Path: <linux-iio+bounces-7313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361899274AF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 13:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2891C21241
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A31AC23B;
	Thu,  4 Jul 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn/RqVcS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E871A2555;
	Thu,  4 Jul 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091559; cv=none; b=IUDp2er1OSQ6EqsLDH+KnR79vos2tcOnzFcsm7C2xwlwWwJ3fJKg94xdqCGKR1ykLgyj/hfxd4TMmuEF2z3JrygKiH1HBxHt5ZkK5bR/9+uZ4hoNIq+c+BjffH9cpNawWa9fg1tTxLpWzJ7i0zuePFygncpwA7Y28wOMBNF/dv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091559; c=relaxed/simple;
	bh=BnBRTBk9+SJHSF1mQcVfRDaxS2dfZurj/v37IwkL+p0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J4vbD7jbPNPJxHNmIlcoIjYJKDcusLnPj83pYYYRoqQjXbaKL2m9wSdWDdxPbZu2FmUkD379eFRHgRIxYChVZ79Fnzk1eNbQTiPIqqfvvMW0fhJowPrHHFHsLvpgSXjUiXWG0ur4Uy5m3Kf+PsSErtTxOO6ZpLMUiXUnwMqr8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn/RqVcS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cc30eaf0aso343840a12.2;
        Thu, 04 Jul 2024 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720091556; x=1720696356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnBRTBk9+SJHSF1mQcVfRDaxS2dfZurj/v37IwkL+p0=;
        b=Yn/RqVcSW/GkpXmRNxL9CDAjLNeranaqhiGBHHx2e3fe1xpOV3+r6nMdXnfvScIxzW
         XPVBHZwIGj54EvnGF7GQvBQr4TE0jTPxFBAZVzBv49frD1Sux0KgGFRes2eVgUKtrXTi
         toV1RVuma8Dr4pvrNxebdLgtbnU2Dl3832Uxmn0F0u4lnV7rzmFL/WgBd/1UqAYa6xab
         7F1bCpjrU5l97pfXusNUrgcfXrD1VuP0MKMfTvQHVpu3rq3/kYUuiNggZ8YQemKv4MrI
         RpsNkKeSDbvaDDep/3epdkLX+j8dKd81JcWJTVZ/tEMUSzHhuiZmXoJAH/CuLJ7+BkBw
         YiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091556; x=1720696356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnBRTBk9+SJHSF1mQcVfRDaxS2dfZurj/v37IwkL+p0=;
        b=FuGjRaiH2CUy03wfoIJ+/PoRSf1YYEVf5Sjk1u7ZUJado0T4gWQz4a518XPEGligUn
         4OtD3xBnZX8rVTIWaWr2TlKSYy96sIWJQUn+ZSChj5mG7WslDRvB/kFYFjSEZp78FTBq
         icHM6xTTJgGWfhyuXqUqiEXDnmdb6i9YvXWce20/FrVbrw0OO7DTnd7X//SSUSCQjSiV
         a32ov0bGDCnAa1m+3LGgbKDPEPMVYGXh93eYIXena125hY5vBFcbsqV4X7gGBzBhrO1Q
         V6pY/GFEnjQRvJlKxX+0Kg57rto5WmXPY6X+8BNexO+YsXPJgCIzpP2RUV79tLNnLU0T
         UApA==
X-Forwarded-Encrypted: i=1; AJvYcCWj7uWIIro15O9YCzM/M6spwzNCBOdH8IAMCyjJBl+8p/7z8dFZlWWMunhgsD6c+hngqMnM1pou3pbr4CTZ5V87PkrZm4/tEN2vaghX
X-Gm-Message-State: AOJu0Ywr4YOlc0vcge6iTw+AeNdT6Mh35B8lB2iUQI5T5uaAItW968LT
	+b+aJWQRpq7SWLskAnbfOwcGPmlIRBhCXYS4WmXxxgy1HhTXzWCj
X-Google-Smtp-Source: AGHT+IGsH406YtT6ofg0bm00Lbm6uPc7tvsMKNj57uHp/K3zGu5KpLHW0DtPO9SChhDMSaF8w362vw==
X-Received: by 2002:a05:6402:354b:b0:57d:3df:f881 with SMTP id 4fb4d7f45d1cf-58e5994de19mr1587321a12.3.1720091555885;
        Thu, 04 Jul 2024 04:12:35 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d503b1sm8252921a12.67.2024.07.04.04.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:12:35 -0700 (PDT)
Message-ID: <d74451d360a2d629ff08ef541ae48141a7f5b0e5.camel@gmail.com>
Subject: Re: [PATCH 04/10] iio: adc: ad7091r8: Constify struct regmap_bus
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Dan Robertson <dan@dlrobertson.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jul 2024 13:16:29 +0200
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-4-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
	 <20240703-iio-cont-regmap_bus-v1-4-34754f355b65@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 23:04 +0200, Javier Carrasco wrote:
> `ad7091r8_regmap_bus` is not modified and can be declared as const to
> move its data to a read-only section.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



