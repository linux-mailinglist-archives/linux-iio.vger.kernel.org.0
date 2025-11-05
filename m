Return-Path: <linux-iio+bounces-25908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AFC350F6
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 11:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687DE189E545
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214CB2FDC50;
	Wed,  5 Nov 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2NNK6A8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAC2641FB
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337734; cv=none; b=sq6lOg8qzWhmlRWj366/uJa/6QZdvx8Gx+j6RRiq6lk6BYrWdg9+lXerWIhKEBFMMkKjzzM38p4G6eZJ6iaMgO6yw6IH0B1uaFu+KdinIfDgp8CZIGUBGJ2Rvi2CCOw25sjSTnMoK2BFUzWUqukeG+wvj5+du2mPgrj13vkCXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337734; c=relaxed/simple;
	bh=vKvXA1UTbQ92fIl4LlcrQgYk+HkGvnd2V0muGOxp17g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdSIHzhTpwDFLqCFSbtTPFNfF3pVqgWIR1ocrlBkH5boUsFr698rY6RI8KXuFrNPw7Q9bbVtLRvDY+49xCYQw6pGamj78/BTSgZpcMEmWI72uVj3we8aWOw0aTco6lFS8ZHA+KI1NvN73toSuSyM5qa0E79Pmb2kLLzWaG+DX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2NNK6A8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426f1574a14so3953325f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Nov 2025 02:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762337731; x=1762942531; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vKvXA1UTbQ92fIl4LlcrQgYk+HkGvnd2V0muGOxp17g=;
        b=B2NNK6A8E5KmSa422zsXDYgGlcT7P0dG9paQ6Sza01WbPGlWesgpCKeCrWv/U+nhEE
         M2xPrKV/6W2sH2YEXBW80IQTM3FhgjWmTATx7fCby+SlUwS5N3xK2R4bcX/0EtgHtSRu
         pTgk6VLKQydBJYW16HyT/wyCWolVmOqD0r4kiv5UVrCM55AVg0lFXi311xULyesFWuOa
         A9RBP5m2kpU25u2c1xMniVhEaMx8fhRkQODOkQeMY6BXd1zakQ1BPq5l4n67/99zMqnT
         q8XjI+UEWkFnEk1tHqJV8cg11kRzhw+/TVo6pyv1coHH4og9PU4jZ4SHgwpH/JvztAoV
         Hnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337731; x=1762942531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKvXA1UTbQ92fIl4LlcrQgYk+HkGvnd2V0muGOxp17g=;
        b=Z38ecex1jS2c6gLWXh0cW9F6FhYODms/W27DJurjH2z8q2bb1/3AWbtBpywWXNikZg
         8Mya1CTwGTpMCfU4GXAzV3sJhWtKxu7y7veEGxwahQqim4BwsAbzebUCdtcw2Fj+qCJv
         OcmJRRi3O79cA1GqWFsfzAbA2WDI4T5vdU6kKoih2oTbTwJ5dkG5KDqMeXY2FEbkvzg3
         BRje6/Brex76tW/+jBg95ngMy9QzFKijc3YTXc1UkL8ZKnfezdB5eQHi+i7nfhSr7mQp
         Zi3z9M5PJtQ+ZOt6LvRoBv0Q4nvsh+jLcStorIUbaXM0LU+DrhYJ6f5MOPlSx/U4eGVx
         ebKQ==
X-Gm-Message-State: AOJu0YxCZOb66eh1T55zgncGL+K305zpfgVj+vSt303L96J7xDUW+pla
	bVrHGNzGnLy6BUTf+pn+27qMS6u7dvp/zULpKZO+h/UJyKbW1QBbosSz
X-Gm-Gg: ASbGnctt4Pq439RblQKgnwfHbMetcFAJaBOoKDrYYo84KI604EBJbuyp75KKXaPtcTZ
	7Z5TikMX6FKRyQfWb7heWptq4qYx6FjRtfiFtVMAcsDF1WUmQa/Z9fQPsrbVuDr445b9+O5/uA4
	NNPF7ROL7s5zlQA1FBmOKgMXjQCe4whlbG6+GXgGdEEHG5CQ4XCUsBU1FZ9BXa9Z2JWyeN0euNl
	ZK9MkwBDbxw3RKy/EbKbAj69ILOWVMPi0JpuSojklImM1rkjf6JjKAm/Qzjx5q3BDcDIiilF0QN
	KifjAat5MdXtLlOHBaTcWCu+1eeyp6YYvLd4NkChzZeMUclZ0vsgiqrrBkop3aUC14UmaA4KOrk
	AqWD8FCdsvbQVFQ0BG/RZJTOCUqAPNkIBc81PNb6jElWkfQc8SoRMS/P+1yGab0SYX8sE1ZS/cT
	12nQgCktaG
X-Google-Smtp-Source: AGHT+IHg/WdqdSYGzAqgxwmDrZ4E5OPhTcBs3HnRRo3OubIxfZ7ReFBsy9w4NBpLGROiWYFUqWHvbA==
X-Received: by 2002:a05:6000:65c:b0:429:b9bc:e81a with SMTP id ffacd0b85a97d-429e32755ccmr1709161f8f.0.1762337731336;
        Wed, 05 Nov 2025 02:15:31 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9c8esm9651425f8f.33.2025.11.05.02.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:15:31 -0800 (PST)
Message-ID: <76274ec104107516fb5b2d4e07bf95ef7c41a4cc.camel@gmail.com>
Subject: Re: [PATCH v4 03/12] iio: dac: ad5446: Drop duplicated spi_id entry
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen	 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Date: Wed, 05 Nov 2025 10:16:07 +0000
In-Reply-To: <aQo0AKjQUNN9FCDR@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	 <20251104-dev-add-ad5542-v4-3-6fe35458bf8c@analog.com>
	 <aQo0AKjQUNN9FCDR@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 19:12 +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 03:35:08PM +0000, Nuno S=C3=A1 via B4 Relay wrote=
:
> >=20
> > AD5600 and AD5541A are compatible so there's no need to have a dedicate=
d
> > entry for ID_AD5600.
>=20
> Suggested-by?

Oh sure, that would make sense yes. Maybe Jonathan can do it when applying.=
..

- Nuno S=C3=A1
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

