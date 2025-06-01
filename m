Return-Path: <linux-iio+bounces-20110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3EACA02B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D843A170976
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CAB19CC22;
	Sun,  1 Jun 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhmsKddl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AB17583;
	Sun,  1 Jun 2025 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748804827; cv=none; b=Pi8rAEdO9opfaXka0Gx5KUvDhZm/YfWUtB+24gyglhxSDBsz0IMj0unyfi9Bwv57Bmg7LHKk/8vCj7Vt5EcFBw/X4ccPwen94FspiW5YzB5OwRX0z1MHiVL9mEBRw0+Zw7VCJoCDD+WYsPNFkxmXFjlEZpsk6ORz6lHpHCtmLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748804827; c=relaxed/simple;
	bh=+bISaoTxpG00ZIiVyVdetJEbbFOvI3SFFSy5ulTTp00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aryjw6Tjk319+TPkNSvErLpYFN8ofu/Xq7ipezkdguPmBZMxkXGDsyobcl3s1ceIOoO0qgDWcs9mqa3guNjP+Pyd95fdYZ6gD5LK4yq+Ipl77+/mH/jBXbKsh4P/JVP1/QVdMxvfUl2kEGxIR8a0Zo2Uijqgcko1Alv20bFvTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhmsKddl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so6561708a12.3;
        Sun, 01 Jun 2025 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748804824; x=1749409624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bISaoTxpG00ZIiVyVdetJEbbFOvI3SFFSy5ulTTp00=;
        b=RhmsKddlBigSNECvjKfWRDgEEjV0O/irlAQcBV2hqywNunYNZmCG4HDzUsCBYu1eoL
         WoRA9ccSPY5FgHPUdWjPKKDhKF3eBcqRCSH3WWbN9r8fGergnuep3mJuX1sRzmBYamuL
         L57h6WeoV8oY80T/K+62D+i4xo/JxpdjO0c3sU7YYlrtp+B2I1770uC457pAFkxmHbfS
         gBCSMPaX02RNfadWF6PeuMiJJEHoJbvPloeZgDw5gZkIF9AsM+PU3Z2Aysm70QxOnlmM
         oZtCpxXXJHm7Ahn/1u0VbhS7LxdGGiAcyVQeZaXF/13yDbn5gEjiNbSCqzYeTF1G7KDJ
         KZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748804824; x=1749409624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bISaoTxpG00ZIiVyVdetJEbbFOvI3SFFSy5ulTTp00=;
        b=WvoE00cv4kGy4xMRJOgJ08daRYRj/0gD6Q2sOJn6iJdJxfnQ4hVzVjtGpEeEN40a7H
         EDJ0jaie5IhwB0Gb63yuauoNVKVLrxR89wuXAdsOxs+go3ymprZ5/ZYrcIwHtkznjoFD
         fx14sQVJNJxjZJPedkmq5taGvkTaoRoiRETPzYGX8YDEDA8MF88aN6Tm85MRILFk3blF
         aIWQzvSzW/8ab+tUVXL5KdQkkWRjHqgQk9qPPA5yjCSTvsjZNC4xoy8yj51J95acFsdh
         RG5TXUjho1C93uLMu5KFUF3NTOpzYuOHEr13w2NhRsqyjKKKa0RXHT+wvHw2/rs39sz/
         zpzg==
X-Forwarded-Encrypted: i=1; AJvYcCWXq/sDxDBZB7yxPcoybEanpP9h6TOY3GJBjBMilZM5Ty45G51sc/fUzvRc2xONDhU7r6JDWK+4VEWMPWZ1@vger.kernel.org, AJvYcCWhVu6rhJI4ddD+ORQ0dJk67bYuCERHqmVWmsHEBP3z6KOcM0PAcGGC3nnHE9lZfBx/PraX8m3EK6Y=@vger.kernel.org, AJvYcCXlKMNSkAGe6aDiWHMS4F/ekDqZMtTOvUGrCxVj7dH2HdEJtD4OuYE2yoL6TXEVgEWqq56NHW16bBV1@vger.kernel.org
X-Gm-Message-State: AOJu0YwgurnobfSbvkpKz6izzCGSaeHzWnT5JfZzf1yhNxOHq11ddTDR
	uKKoXRpjVYyXYL8KNcPZ1EheVcUcnWIKo8IIfGZm2U8zCIRKCSVoo4cpZ4ZnMmM1MupqCx1rY8y
	M6QX51Fc9QIhPBtXfVJy1kRGQJNHZrX8=
X-Gm-Gg: ASbGncsA1DS5fYpnZQs7gHi6fIUkzisTJ+f5Ty1+7czKBtbzOGoXOV7bevV3IWM+Igp
	0Po+fb9qObN9DqDzE2wxVcKDrLej5u9dc7vJT2/4krnfumhYPgyTNszQZPUpEOclVKRXoWWZEr0
	DjiFYqgzZxt5W6oew4BmaP0KKTaYFaKZhX
X-Google-Smtp-Source: AGHT+IEZIO8odCKWQh/FsjDa9VLfBY7jUEfa8OC2t/sieI+vXvBy9zXVPFzc8AaJVKqJxRMSLQSL9q4KMv8UXO0d+L8=
X-Received: by 2002:a17:907:1c1a:b0:adb:7f8:9ecf with SMTP id
 a640c23a62f3a-adb49512dfdmr548305666b.45.1748804823675; Sun, 01 Jun 2025
 12:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-2-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-2-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:06:27 +0300
X-Gm-Features: AX0GCFvlO0dhkwmWCPLizXBLxS-IsLrvmqlsoWfghKgUUhSiRCS5uwWSsI72o0I
Message-ID: <CAHp75VfxqmWAA+h4y85F=O2eg038yfmpW=p6P7ykDMKbCJ-bqg@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] iio: accel: adxl313: add debug register
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
> Add iio debug register for general sensor debugging.

IIO

--=20
With Best Regards,
Andy Shevchenko

