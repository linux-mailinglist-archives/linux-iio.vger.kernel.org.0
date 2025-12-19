Return-Path: <linux-iio+bounces-27210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A723CD072A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B0730B2133
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26B33A030;
	Fri, 19 Dec 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2BRbNrr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6922213254
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156602; cv=none; b=q07XiEl48lVrXk+ukD1Dq8qjk9trEtcu8QfqaF1k2zmXXMFI3+FotIebnBYrAP1O/I1Jd1jBOtfitopKaoCdR0dsWCMz1XO7Fbz3QdZc3BR4NP5Og5e47xly88BckxL0SdK8VGLbZj2GpkUj1v/cFPApXHVjvQwURTIDqlBnWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156602; c=relaxed/simple;
	bh=n22d2txH7wo6U025+Kr95FcHrE764h9Y09W1efLLMNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbZpvw+Ipcx3wkjMDTzQ62ic3wr2+rODz7sWvE183v7fpm3nAI828yGbdEAYLk/vXiIFwFcPM0VcN2RCcNAjbk5lL2OvhRncFTFI8/3AxQpixcqtpKVQIiMAQwog+2ulJshU+ZaUeejGfW9w5wzX5n+TpBycMZlm4EWHfeYT5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2BRbNrr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbc305882so1002316f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766156596; x=1766761396; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n22d2txH7wo6U025+Kr95FcHrE764h9Y09W1efLLMNQ=;
        b=C2BRbNrrI4KTyC5lilFVvoxDsxhP1YU6r3g9aGRjncIr22k5KqDSiFXk+5s6+maHjb
         RTz78KftqSRosPJOBMtEQ+25rUMiR0s0YOunflMvUPNlvvd+7cCPfUPvFsHuwQ/zVXy4
         5nW9iDc9NrztxFku9CqUknmU/Gj0Ca4iSDubdEnffI7ThFiUx/PTVvyEHL9TE2HdVWsC
         r9E+N22TsRgt7TBo8UUn0NvEqOhw4UEbI8MiJxT6JuUSabJ+Wl5yUGKBBMM+HoiBl951
         bFsA8E6Lchr2bisKScF/CFLs6bC+h4yWYo9P2r16erjmWJCUfU/7DGz5wkxbJvmhbpPd
         VDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156596; x=1766761396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n22d2txH7wo6U025+Kr95FcHrE764h9Y09W1efLLMNQ=;
        b=unZ7XdUOpM+nF2jtkcegTXeS/kteSjdTNR48CrCD76CG8a2ES6OxhnZBX5QiWdc6bd
         vUcjgGZh86gInUeRkcYhybiw73SzV9F4CkHKNfaWwR8bz1NFTl8cezBaFDt8oUswViFc
         kQaEreYlZ9+IY99xtlIqHOnKIqnjxDrRhLFk+7ql8JbpkfqEeWWO4o41bA5SoFCWOkvg
         LpWV5hJVNVZlbO5/dkdBh7zFJp48fTnishNBIpwA+/hpPLP5KAYq7u2zKAnkfwplSPaf
         zY56nq6zLhHpLLGdyOas670BKInU/8jL8fsuTV4kM6ML+HQutjLMAuqXlUMas7Z4NhRh
         xlng==
X-Gm-Message-State: AOJu0YzdF+fL+ooAJEZ0evwQ1AqQBey892RXA7oj1bccAiqynan3ScgK
	pxjQ0fWE2cVce91CZAfMiQIb55nNebr3QezlxgNyHLjPdi9p66tJVQRt
X-Gm-Gg: AY/fxX68RdQZuLcHgCXnPKeOtctyagy8IWLDv49uBV4bTWCkIgES5oxMUe2bA4aO3Qa
	WWum5+IgfY1BnHTHnO9U+/N2dd/0vMECDyH7eGdhbvFyrn49YvgC22agbuHs1PLo/biog6jdqfK
	EqY4A0jWhjBY5yU9tWhJGVOYcaXK5FeUCHP874MylmMXdgzn4SmcQBtxWv6lM2eMkoXVVJzUqRF
	2pLjuA9XjYsXO39Ys1VGcXOy9TttGYRyS4c5X71Y5aot7/4kJThcGV0/Tv+PkJcbenSRtBcUEsG
	HckhiQUpp73JLr85CMpU/eceR04O921OaWJEXhBLXbQLa9CTJcdrN1gRe0eL1kbXRLa/dZvxYKI
	oqm8iS9jH61KPI6E97UrjPOkbChIMQylvtTW8yVsVM9aV5VC9u9JypAsu6h7j//un86aRE3+5Uv
	xcwJBMj3qk1Jjx5nlIH94=
X-Google-Smtp-Source: AGHT+IFcU3WiI5k6PLKVvu1TLKGeoZ6aj+Aj3KpbVK8kqiT47sNxqvwMrsudjyeu9+PEZmHGQeZCKA==
X-Received: by 2002:a05:6000:200e:b0:42f:bb9b:9a82 with SMTP id ffacd0b85a97d-4324e6fa0a6mr3567106f8f.60.1766156596326;
        Fri, 19 Dec 2025 07:03:16 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm5008078f8f.2.2025.12.19.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 07:03:15 -0800 (PST)
Message-ID: <760dce5b5721ae6e46daeac03b96df7b009db3ce.camel@gmail.com>
Subject: Re: [PATCH 3/6] iio: buffer-dma: Turn iio_dma_buffer_init() void
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 19 Dec 2025 15:03:57 +0000
In-Reply-To: <aTBmriwVrMwlKiXX@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
	 <20251203-iio-dmabuf-improvs-v1-3-0e4907ce7322@analog.com>
	 <aTBmriwVrMwlKiXX@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 18:34 +0200, Andy Shevchenko wrote:
> On Wed, Dec 03, 2025 at 03:11:38PM +0000, Nuno S=C3=A1 via B4 Relay wrote=
:
>=20
> > iio_dma_buffer_init() always return 0. Therefore there's no point in
> > returning int.
>=20
> > While at it, fix a mismatch between the function declaration and defini=
tion
> > regarding the struct device (dma_dev !=3D dev).
>=20
> So, all others use simple dev?

Totally forgot about this. What do you mean by the above? If other function=
s in the
header use just dev? If so, the one I changed is the only one that uses str=
uct device
(in that header). It is also consistent with what we have for the devm_iio_=
dmaengine_*
APIs.

- Nuno S=C3=A1

