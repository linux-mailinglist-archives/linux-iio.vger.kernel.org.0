Return-Path: <linux-iio+bounces-26726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1750CA3691
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 12:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3EB63026AB3
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3301F2E427C;
	Thu,  4 Dec 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtAiamPb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BD2E7F00
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847171; cv=none; b=TTBgzlFb8qXP3m0jHhHZcM92LhvU+edah79gDOSlZln0HujB8ryXOqZ1RGW5Ls9d3cfhW460i2LqCCRr3vjiDUop12kT/QTvAJhM+uhjNvKcewMxKar0Ru0jXf/Vp8rLFEw95ZT+Nfw4g6PRjsuH3Samchqq6EeOSGV2N+B3FKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847171; c=relaxed/simple;
	bh=RxAsOfVFqnF8YpWMVPccqypkQ/8L/BJqZOYxm7d1VIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0s7oCf6wQM9nRhcxzC7zrcWFtLc7VU736rI6YOdXHb541dnSpRRw8oVUeMKDvlNMo+mU6dDSzNRHaX5Bwdqys7ArhZKMHvE+bQAUYADOlKS4QiysX6BhWN6CYqgim5Q793NBgBVhbSpPMj4iz5rKS2bz4EmZegqe1XiMQGbXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtAiamPb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e29739ff1so358446f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764847168; x=1765451968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RxAsOfVFqnF8YpWMVPccqypkQ/8L/BJqZOYxm7d1VIg=;
        b=EtAiamPbuADrBgWl6syTBYy2oR8FmxRK7xWNAkm2mNOj42VQPgR8u5pZCTOa1MPMi2
         yj3j5Y99vvuEpFJmr89dWz6P9wwheCTuBbr7+W+YWYJbF4QE3DKbXVx4yi0l0j20tKHx
         sT7Mlx9kbRWLx8mEobNHAinXuKE8dodkWVlLJuguDNGIjAMDeePrHC/knzlJbRwBTmVv
         2xUqMhPDnZL/lBKxLmWwxxhL0Fcksj8uCQTm/R5WeQj3zlhgqRAW9wwMngWngcV+qD+0
         FnxpdSWZTehLwVyBpE1SaW9+B+2ZLjCz6/4IhA/VF2VTnMJAFj9yZAtU70HTz/kbZoKR
         OP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764847168; x=1765451968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxAsOfVFqnF8YpWMVPccqypkQ/8L/BJqZOYxm7d1VIg=;
        b=rJQbwH1KouH4zBjVfKN74PXh9bZfTv5+ZhPl2AdkZjNgEK0KFDDuETlcncFABTonDC
         BM7Z2BOt8RAk61zK0X0cI/B40ci3fyrQ0rx8YYJMfwF7EQ+d1AeP1iB9JkOHT9fXv8i0
         4g8c74d3g0LwKZVO6noDnzfLt6OXnTOOSu7EtSwwHcijQMe69vf9adm8p5dhlwjrmT/W
         X+kGv1Mfny+vlo5sPD6jBBCNVWzYb2cQ99ciKeYBXrLU92d6Z23+7utDuvelndKXFwWX
         D3W1q7UkUZjD3OSQY/48r1NRlldDzytJ/0I3tAoOx55hIxoEmWtRjefk4R/p04qJYRIE
         x5Nw==
X-Gm-Message-State: AOJu0Yw7ycN6RIYVVuMZDaj07TljIRIdKHWSg4RzBZ69kissAlcaVoON
	ul4dpoYfn1eNwhJ9WaQ74nVi42XcFq/SGOcAfP1LeSQnmqQjrPTlV0Nh
X-Gm-Gg: ASbGncsL2+z9emR2XivUBVgkC1Fpiqg8yPlZ8MWmzceYYU8v1MYl/XlsDnARzzUlcfx
	ohc4SEDWGFX3B5dYPaEPtL+yxngisUGge7u8oIS79xCO9yOufudXqEhjU29c4xCbCGwv5p+zZUv
	+eEvz3Q5Qa8MIfuEXP8jasoB2DahwYN8RipAlLnI3rwI04EK9vGkuwOhyDkBr9rqVqNaunbb7/z
	Swqy6dACsND6LVMi3wqimIXbnVPEbKzBoJ34BsueeqVHw7MIzo3JBGYtaehjSqL3wiRxI4/aq03
	C3HgsW7o8f5UuaJDrbfJNCAPNOUUXmo87dq0Uobhv8PDjX95mct/AaRsnrvZYg4IjkwGuuMClWF
	2zKQvXK1XxkDsMCzpObx+Jh5SnUd8eE8a/Ge8h2QiClSqOL8PIybL86yVrE7Pup1NHvLZknEcE0
	gaLGxspNi1+/Jqu3SEK6w=
X-Google-Smtp-Source: AGHT+IFZOuqhOBH7TEqB2ZgMgio9JaOjrML+VkLRucOK/N5InzCIb/sqDk1W1CnnnfrroqYDhIfLxw==
X-Received: by 2002:a05:6000:258a:b0:42b:2a41:f2b with SMTP id ffacd0b85a97d-42f7875ccc2mr3581876f8f.7.1764847167479;
        Thu, 04 Dec 2025 03:19:27 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353be1sm2535053f8f.39.2025.12.04.03.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 03:19:27 -0800 (PST)
Message-ID: <e1225ea028cdaca2430a77f777a93ed0c99539c7.camel@gmail.com>
Subject: Re: [PATCH 1/6] iio: buffer-dma: use lockdep instead of WARN()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 04 Dec 2025 11:20:07 +0000
In-Reply-To: <aTBjRQ-FLZizHZn7@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
	 <20251203-iio-dmabuf-improvs-v1-1-0e4907ce7322@analog.com>
	 <aTBjRQ-FLZizHZn7@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 18:20 +0200, Andy Shevchenko wrote:
> On Wed, Dec 03, 2025 at 03:11:36PM +0000, Nuno S=C3=A1 via B4 Relay wrote=
:
> >=20
> > As documented, WARN() should be used with care given that it can panic
> > running kernels (depending on command line options). So, instead of
> > using it to make sure a lock is held, use the annotations we already
> > have in the kernel for the very same reason.
>=20
> Which also will be a WARN :-)
>=20

Obviously :facepalm:

> I believe the main value is a bit different here, i.e. to have code being
> annotated with the existing infrastructure.
>=20
> In any case I support this change
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

