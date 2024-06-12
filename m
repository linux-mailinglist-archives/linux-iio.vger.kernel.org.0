Return-Path: <linux-iio+bounces-6214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36CA90562E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF86AB25FB1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE017FAA2;
	Wed, 12 Jun 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUA+Xytk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9061DDF6;
	Wed, 12 Jun 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204495; cv=none; b=e7A9gMgnB8lnMlIPfvSUne6K+BWSfyKc+vQP8qyYrOVu3UeQgN6P04PTAxJyEpEjnZn8ijmFbmJFXo/eqfK87yhlj9BgkqwabgmM7oQ/90Nw5oE+Bx3pQs/QjUUVN/KEYEN2mc41FJmkbrnRNdl9t2z7aipcHVwqB0H2Meu8xsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204495; c=relaxed/simple;
	bh=5gh97F4lmMTKjYGn4RJTGhAQsduqmkqK7gLhFlr0UQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwSSeJgIqmBiUI8WkpyUHWpgc/tZ5QwbcG40mccNeAYI8Nz/U7vZYYTGS+VZVTu/1RmsIP8/NCS3C2YR+QeEIv2fYZAo3QEaubIUOXhg32AM7WSo87qJApOAb2o3Z4c462KNYwuvJ+JnaSPqkiBZPQBsII0klK75j8916y7ZxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUA+Xytk; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c82101407so7519914e87.3;
        Wed, 12 Jun 2024 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718204492; x=1718809292; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5gh97F4lmMTKjYGn4RJTGhAQsduqmkqK7gLhFlr0UQM=;
        b=hUA+XytkSAfJyiIooCRkAx/OYbIxlLC8zes5HHc//tZ5xYXBs9hVs+k2EaM7U3Gxyf
         kCz4JZMDJzDLDWXiV+3HAamOQ1JQuRuhkhsxKMx/E3KvzUnLoJhWAbgVcOw4tkppQJPV
         JZxFiTC94Y22cotNi+WUPGzhJCurZWpbE4AgtmYGbTDcYtRtkNR8ArfNomLG+qFcuhIg
         z7wZ9v7r8K0YYPlGuNU4vKRR5MBRbNSD1Cp4hUj88szDFQAea5CvbVN/OVgIePaG0wh/
         0fUrzxZxknpy1Um3k91J1P2g3PLCeLqCFSmuLnIS3Egym3cKfBbsKoCTusonHqy7RYil
         o2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204492; x=1718809292;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gh97F4lmMTKjYGn4RJTGhAQsduqmkqK7gLhFlr0UQM=;
        b=ud9C3XhRfhw/U0LLC7342InwBS4BkiKqezTqaAxlKLa5PdZsuRZNbsYnVToGaus7pJ
         0ZbR6KTjvXtZbU1Z5MKT19tw1hFMlw8OgKSVve3/rb9GShottFCh6PXRDZfoAnOs8BSL
         JmgfPcyn4xPO/znfL1OnWaqTYZgmQzO7AoDpRzz8VS6l429IEi5DDz3wF85AoPhIeb0v
         i3zoh2tTgDiF2vUeaAbxfvfY3Hzh5DGMTpC2kNI6Qn7GcCElwPIjyOzKkiZexLToKyws
         C74Snsmw++VNOkwaN/dWWZ1wKbacMoWqXv9RthLiblS7NUMn4GXaRIjIN+D6tYl8s4sx
         Xhiw==
X-Forwarded-Encrypted: i=1; AJvYcCW13xFAwZPSrQ8rdqHJMtD9RjFRKAtrivkXESCEX+diyfv+d8J/raepeSP8pq47+ha40PlI4vOARE9WVThLjNGr8StwYhR3xEBecSeno94KigMJEGz9l9E2v14vET0JAMuwFQbqgEFSPiADQFfx6NC14HAdjquMnkwTNEGA3oBIqkZgyg==
X-Gm-Message-State: AOJu0YwCSGxbLqPbdH9jYm+pehlm4UYZ/6a2K1kyobQ+zVOGNKbSlUSL
	yB34wQoJ9RtAU0JxmL39tu7xaLdpzMD7u9qS/KyGgEZEPKRrL8XL
X-Google-Smtp-Source: AGHT+IEL6ILLYP49R4ixZXZKEIh70NZQEod0jSyEsz1U18tuPac2Cy9eS3MUOZTZTH4S3xwUrcs66Q==
X-Received: by 2002:a05:6512:281a:b0:52c:9f9d:d55a with SMTP id 2adb3069b0e04-52c9f9dd6acmr163290e87.51.1718204491285;
        Wed, 12 Jun 2024 08:01:31 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d200820sm570859466b.181.2024.06.12.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:01:30 -0700 (PDT)
Message-ID: <26b29525e41aad25e144f98994640585c4c8b705.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ad7192: Fix clock config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Date: Wed, 12 Jun 2024 17:05:18 +0200
In-Reply-To: <20240612141637.175709-3-alisa.roman@analog.com>
References: <20240612141637.175709-1-alisa.roman@analog.com>
	 <20240612141637.175709-3-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 17:16 +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>=20
> Note that the fix tag is for the commit that moved the driver out of
> staging.
>=20
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---

Hmmm, I did not looked at the datasheet but looked at the older implementat=
ion
and I'm not sure this is an actual fix. Can you elaborate on that?

So on the current implementation I can see that we have some properties tha=
t are
not documented:

adi,int-clock-output-enable
adi,clock-xtal

So, I see in your series that you're documenting adi,clock-xtal using clk-n=
ames.
I do think your code is cleaner but I don't think the older implementation =
to be
buggy. Am I missing something?

I can also see that you're ignoring AD7192_CLK_INT_CO... That's also removi=
ng
functionality from the driver even though the implementation is not as it s=
hould
be I think. If I understand that mode correctly, it's just about having the
internal clock in the MCLK pin. Effectively this would then be a clock prov=
ider
with a fixed rate of 4.92MHz. So I believe that exposing it as a clock prov=
ider
would likely be the way to go.

- Nuno S=C3=A1=20



