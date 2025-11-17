Return-Path: <linux-iio+bounces-26264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE5C62EAD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4F83AB25C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048231D744;
	Mon, 17 Nov 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8F73YWr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79B31D390
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368621; cv=none; b=cDAUsOiQ76arXTxbYvf/e8/u3WiLLmljaAvBFkCRkAsNYKgC5nD/NDSkBMzFuxSIomRXyMx92rbji9NqaCmlBYXosjBKjbvVuNXRzL4wlTAtQzfAglGf2iQb91IQdy1Bx6h4QOfubj8R1Zf/05wKN8+KvtxYTL0A8MFPlAFqJkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368621; c=relaxed/simple;
	bh=jEs+PHPYbJw7U8D6uJYIzwCTNaKJLPOsD13HrSyQVcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EL/j+J3DMiSs89SNV1e7hYhC17Pk41zkUZxvc7HutrZlgJrM1i1/7Yfh7ptYbAI5xZMbF9ipypkQ2/wGY+0bd00HAxcOL2bNDhPQQ2ar4HUIVF6FLEDHSYGj0VON/13rKY7e058eSQb4Z5ZZsLRr7FIkAtxSbaEkYTIDBSPWk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8F73YWr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so16981605e9.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 00:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763368618; x=1763973418; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jEs+PHPYbJw7U8D6uJYIzwCTNaKJLPOsD13HrSyQVcM=;
        b=k8F73YWrhIGHL0elago5POwDwQZn+mUaiid5y3j2qijqDAbM5qLv++swCI+hJo+RRw
         jq/A6KY6gSSDYO8rTi4D5nZ22wRfKjr2JMlDm8WSTFwsJ6/3g9G6RdyKcyfSI11xk284
         UsTzAqZejnX96XIKOvu/mCPvy8t/Znm0nXcLUtlp1W3GeoxXndSEJsFv5+wi/GKI7sVW
         dsp8ajXuNgpu7VwNapN7G5DJ47OLj4Ueg0DojdXygVeyM51YYZd3uJOoh8B5XdPYdycA
         NGLMWt8Zo1jaItdRnxIHNNELxJ1x7Gx5Cbc/aMIDAKdOsUFWeFIQNKvj9PENFC11o15/
         T3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763368618; x=1763973418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEs+PHPYbJw7U8D6uJYIzwCTNaKJLPOsD13HrSyQVcM=;
        b=NAvYAYWRn3p0t7SdgZlQzmETaJhMWn/Vxh9yYEFOSr3CI+ymNQQKtmG6t/AKgQSUA1
         9hKIXBmg3w2XFgLR0nHYZyZ0Xj42oflQkzmNLZNO8DHSK+U0FEn39M/GGN/BPfbU2Vef
         FWBVOMZYmloXvBdWNBTYZglSD7nqmqxIioCo0SWAILEzyYov6vYaN7oyOYu2JOxvRVWu
         QycjPH+LxXURgMXsxdDSHaDnfLvMN1/napEjGOB/LLpCZqf+zfA/ElMxH54vRJ1kSvA5
         CVOGVp5gRoN1EKTAi5Ur4Y+eOwM/Yb3wvGQjBNQDcQQqWJ1ofCNpu5EysCAwcMqZk3Vd
         +Nhw==
X-Forwarded-Encrypted: i=1; AJvYcCU9gyJ6vWmaaoVGTkPAH8EWVwa9DpogO911h6rbgLCYXrYkxsOo6W/Eyzw7HQjfNetp+k45reAQTmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3smgvGrcsyGOcbcAd8YnScVHkk+CF9cR2h3pcQmZay7K/4xo
	QuDx8zdFBGO2Bg1uQO/S/pkBe+QN2JghWx1CAaNdlyc5M4ctMzGt0dDJ
X-Gm-Gg: ASbGncvcIcJavCoTTlPCsQxxTlTth4+t0muF8xK+lNf0Wb4zZ9FSVHaUkXFLRwjznXm
	gcPJ+gjoJWsUKQ9SIXeWBvZxKv5NVKcvR18fdLxV9aE/Jf4jXhUd1jhFducmL+ao2gCpdMnk6E5
	YbjDZb5zki4L/lCn9UmLClPOB80E9l3pZa1CYTrfVedEXhwMOfj314QKCr4kE0zW2DWG+JaF0gd
	Bn9uQR95CCg3ZKyPGnXJGopAcJTtVJ4G9ot+VLFj2rHszv+hPjK05AFCswwAkvwzegZp2bbMbUA
	MCx6TGQsikzSVQGiYD3V1tIXTE3HiJT7aZrLW00rcpcTP5I+A30PN7K5wkbhKdGnAXqzPiA5QDK
	U8t2ePby5xkAr/XxjYndqzaIMnG2UijM5UNlFdTTIxmrqYaJLf+1hl8ov9jgjcPExTQPAZ1RcwF
	wGr6TkKeRHZADCsL5lkxzwCa5Dw063SAZ24uU7cHUO2sv4RdTd
X-Google-Smtp-Source: AGHT+IFqvqIxI3ITQD5zAT/7ZzMljZHFUVUN0MqCI6bwlrhpUcItCKNOlBNAb+KExRAYyeuF5CjMag==
X-Received: by 2002:a05:600c:450f:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4778fe4a05emr117954545e9.16.1763368617743;
        Mon, 17 Nov 2025 00:36:57 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779527235esm154459915e9.8.2025.11.17.00.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:36:57 -0800 (PST)
Message-ID: <8c81552eefe30cf191d1d422ab9a5d949284e7ac.camel@gmail.com>
Subject: Re: [PATCH 0/3] ADF41513/ADF41510 PLL frequency synthesizers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rodrigo Alencar via B4 Relay
	 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org,  David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet	 <corbet@lwn.net>
Date: Mon, 17 Nov 2025 08:37:58 +0000
In-Reply-To: <20251116161023.7a4b1b6e@jic23-huawei>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
	 <20251116161023.7a4b1b6e@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-16 at 16:10 +0000, Jonathan Cameron wrote:
> On Mon, 10 Nov 2025 15:44:43 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.o=
rg> wrote:
>=20
> > This patch series adds support for the Analog Devices ADF41513 and ADF4=
1510
> > ultralow noise PLL frequency synthesizers. These devices are designed f=
or
> > implementing local oscillators (LOs) in high-frequency applications.
> >=20
> > The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41=
510
> > operates from 1 GHz to 10 GHz. Both devices feature exceptional phase n=
oise
> > performance and flexible frequency synthesis capabilities.
> >=20
> > Key features supported by this driver:
> > - Integer-N and fractional-N operation modes
> > - Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-=
N)
> > - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> > - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> > - Programmable charge pump currents with 16x range
> > - Digital lock detect functionality
> > - Phase resync capability for consistent output phase
> > - Clock framework integration for system clock generation
> >=20
> > The series includes:
> > 1. Core driver implementation with full register programming support
> > 2. Device tree bindings documentation
> > 3. IIO subsystem documentation with usage examples
> >=20
> > The driver integrates with both the IIO subsystem (for direct hardware =
control)
> > and the Linux clock framework (for use as a system clock source), provi=
ding
> > flexibility for different use cases.
>=20
> For v2, provide a little more info on why we need both interface types
> specifically what you can do with IIO that you can't do with a clock
> driver.=C2=A0 Also +CC the clk driver folk and list from MAINTAINERS.
>=20
> We have evolved to this dual interface state drivers, but I'm not sure
> we aren't in a case 'If we were doing this again we'd never start from
> here.'

Yeah, in some devices I do think that we should likely only have the clock =
driver
(for devices where we only control the channel frequency). For others, we d=
o have
offer more control through IIO which adds some value.

- Nuno S=C3=A1

>=20
> Jonathan
>=20
>=20
> >=20
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> > Rodrigo Alencar (3):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: frequency: adf41513: driver impleme=
ntation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: iio: frequency: add adf4151=
3
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 docs: iio: add documentation for adf4151=
3 driver
> >=20
> > =C2=A0.../bindings/iio/frequency/adi,adf41513.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 268 ++++
> > =C2=A0Documentation/iio/adf41513.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 377 +++++
> > =C2=A0Documentation/iio/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 9 +
> > =C2=A0drivers/iio/frequency/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +
> > =C2=A0drivers/iio/frequency/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/frequency/adf41513.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 1435 ++++++++++++++++++++
> > =C2=A07 files changed, 2102 insertions(+)
> > ---
> > base-commit: d16d1c2553248f9b859b86c94344d8b81f0297cd
> > change-id: 20251110-adf41513-iio-driver-aaca8a7f808e
> >=20
> > Best regards,

