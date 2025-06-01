Return-Path: <linux-iio+bounces-20112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE8ACA032
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019821888446
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B123370C;
	Sun,  1 Jun 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAPCV/RF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646117583;
	Sun,  1 Jun 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748804999; cv=none; b=VEc3qRBN/KX4FbR4i5ETt4kc9ICME0+vZTXNeGm2sFzX7OUCgqmOfqIVt4ysXakNWC8cShtyWdFiqslOTnCTFewNfqjc4wyAUHzpGCEtBURw5x4og60C+plumLRwxKWKbV1hIl8nMbrZsluX15WUb0hbIgr4qzzTFWFkGLCOoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748804999; c=relaxed/simple;
	bh=aPm4M0xzN3/T960naFLhtfhpBGVmWbvGZvnYz6tiLL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKWX08hJqE9lSLcAfU0Q+WzMQ36Yfz82Xfai3eluBKEI+IPe3dut4iHp7mE39ceXAVBKBluFA4ZdWlvQI37FhqMG8UFipUML0ErKEzmzXfVlxKiErLMqgoIru5929NUoKbKG7CDsnTxsoSx3Wt1y4y+nrVyGnwfafF8tytbO/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAPCV/RF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acacb8743a7so690393166b.1;
        Sun, 01 Jun 2025 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748804996; x=1749409796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPm4M0xzN3/T960naFLhtfhpBGVmWbvGZvnYz6tiLL0=;
        b=mAPCV/RFryD8OJmEUAebMHwPtPaYvycEFDwokBaPI7CCJNTcZOguyMqeygl9ER++bE
         pgwin4ktrnPaF+ka893dNXo8/CL8YBfGT8+cJjo6TpJ4RSl3233b1Z7N7s4b4Va9OgXS
         Om8uMwhG2AIBDyOhVI03HtrIwaf0Qw5AKnM7YLj5tX35SUzgB7Sq8lPUU6HjgNoHrNk5
         aMDSvm3LO4KnDEVY2WdaSy5Xl6jwtqVEJhXuQXq7Dc/psyLuDcqVbysbAKjF/tm1nK3x
         ukNX94FksdzeC3b+eKbm5nxVdGoA7/5kzjyRfz9sK7v+Oq4qSl3j1hYrl2tS3ml0aYSV
         4WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748804996; x=1749409796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPm4M0xzN3/T960naFLhtfhpBGVmWbvGZvnYz6tiLL0=;
        b=Fsy42VWAnLRtgqpmU/f9KiKS1Zb70854C3FU1XbVIpMCs6QoheaqPzNKLbrU2nnrGU
         Apt6eo4qYxdpFxLWRORpXAZCHoRJCWL9ZUGZIxx32x5eNYg7tj5+mTx+PtmyWOV9sSnD
         xFiN696mwJ3P+JGRe69j3JESIjhB8fsPMOTow8V4bROkotKKWYdGay4p9+Gx9LsoN7eG
         E5BAg8/uSuNfwPyMn/VO/lKrZEjvIyCrUxXaKD2N0O28W0w0UBZKiLucPCB5S1Orv/4r
         MehhSI7qpXL2owVIOGgUvYGG0uOPzBVrf50Y4l9JcIWEkdHbtdhM5IlOAvQzEYzI8y1/
         6T1A==
X-Forwarded-Encrypted: i=1; AJvYcCU3TrmjWOAQM/0z187wAVlGoBSANDtshJpvzVL7fAXwIIFOD3wiTf5GD410npfG2UjdwDt1GqoSNrh8pUir@vger.kernel.org, AJvYcCVbtFhxld+fAKd0u4kGvGH0s5Ko6XTpE2asAtjj86iDip15rzkVLkSmjybgqKIWPsqG+mNoeHJYiZA=@vger.kernel.org, AJvYcCXdg9e8IucLO5REbnipvBBYCNtdXYlXewAwXreSuCF2JTnE4PakNtmrjmIV2BJwuB047dky88srzvru@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIVGqO5u9IBf9682FFqavI9wsGLz4KwLFS3kz5x8ILdaMfbX2
	T3ThFvD/rR2X94v4l5yZEgyaBRJw2J20jxqJmMV0gobjIfkYyRkGXMf4H4OgQehbDB1NETF4XA2
	gp7N/TJ5WRiETmB/SYvtdF0KtY7+HD8Md1/2e
X-Gm-Gg: ASbGnctqykRLliPheu5mmGKcnJkF6gXZO8z2dOXGL4jBf1Bs9XM2EUNOaM5mWv4faBr
	jTKKnbdAHUkfhbi30wW/+l/ZQGbbo+21yH9cT5wj8u2dZl/IDwRSXoTSIov2gzouGj6gYhXbJUD
	Eo25w38hzvBu/v9tgqETRAV7ZyWlAQmZxgDC2ITEDxCvn6tDpzTH58xQ==
X-Google-Smtp-Source: AGHT+IHMaAD+mQZDVeQx7MoBStjcIJzOf9ptC9VOUAZeitJRg4QH6p9ooCcU3PTBR8CFiT/SafpKdi9GtRAhynrzTSU=
X-Received: by 2002:a17:907:da5:b0:ac7:81b0:62c9 with SMTP id
 a640c23a62f3a-adb32ca4d4fmr1076853066b.20.1748804996396; Sun, 01 Jun 2025
 12:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-4-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-4-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:09:20 +0300
X-Gm-Features: AX0GCFuVwK-84UlKujvoF4luRAg0iRUNl-wg7fp6RP50DI_232wxdxf3_GWpz1Y
Message-ID: <CAHp75VeCefeqv67RH5mxO51w+pJua_Nas_CCaeV5u6iXqvHF0A@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] iio: accel: adxl313: make use of regmap cache
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
> Setup regmap cache to cache register configuration. This is a preparatory
> step for follow up patches. Using cached settings will help at interrupt

interrupt

> handling, to generate activity and inactivity events.


--=20
With Best Regards,
Andy Shevchenko

