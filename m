Return-Path: <linux-iio+bounces-23450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA41EB3CACC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229FA1C2019C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B326A1B5;
	Sat, 30 Aug 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhwgoYDx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5F255E53;
	Sat, 30 Aug 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756557452; cv=none; b=uGgeXNvEC3+TaUZJC9vmSTgB1Iz8my+VSLhM0SNLzsIbyRInk5XE0HFmK1eWyNL07CcJppgk4jj/Dj1MH01K17Sk0mKDFGPCSg+I1rcY4yiWCxzP4uXjqqMvIHI343lAlxOH0LltlGdNh92jG1OGctA0r97sAU39Vu2Mfb/HB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756557452; c=relaxed/simple;
	bh=Llw4kGBdBkSXrlhSEW329tME2J85arER9MQA9h+GMg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i22dpM5IlCyZPda4B0dRKJLNGvX9WoI/Ik21Fv8+MovslV8K2Sf9ljnxu4phlyOcQnZ54wlj8y45SAzy8+VcZdQdiHWNa4MgLlJVlgckP20gmcef3G/QCprYKXyoHZBwWMVoyOVsmX4qe/6eEz9cTqqueaMhwmqdur+r+rrDjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhwgoYDx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aff0365277aso234564366b.1;
        Sat, 30 Aug 2025 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756557449; x=1757162249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Llw4kGBdBkSXrlhSEW329tME2J85arER9MQA9h+GMg4=;
        b=PhwgoYDxiZDOo/Ow7J2psEb8n/o10jIH/U+sZMZwW+E05+jiLorlT1xRFzWJ0l/qX+
         I90NR1GdyI2jFFnMTMI2h2Ep253D760gOf8TPvxOPmphfloY+laM0NsjT+Ahu5baFFSp
         gNoFXJEvUvj199k63+ummYO6PxpHwGXKXMMm4MAf5QMNfVGP1LMd9QydMxAjbwis2/IZ
         57VT58trlVqi4Sw3SfcI2N+zFvVOvStPbbP8owK65K4wEehjCfVBaihUb5me54bZ0KAA
         dpAIW11cLK+pCj2tVqMSWvgyODY4jyWWSTm+47IHKKpVdtVgj9AkmU+nq40DMpqHIXc7
         xFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756557449; x=1757162249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Llw4kGBdBkSXrlhSEW329tME2J85arER9MQA9h+GMg4=;
        b=dxSGg8qPK4HusHNJnJkXpoh6/Ng3RfUVXaphUfkgyoRnJyBtMgwSyyV6bRzEZTbHa1
         65amCAPBsLlXBBTp7WyevvB+JXtuLAV2tZfC8Rv8dURQw0egP85D5DAnXMWJb5ukqwdy
         wBOYWpvtYzCLtj2W4MQK//doS1qKE9kKv2LOGoCnt3Y4E/N+QA799/E7tOMcsZnHg1W1
         BW8668IVHPVwpqwcuE8phjKNthgJhsTQgmoSPWJtuNxqyHUyYgW6gKqvhL1BMnLqK3Hj
         J0iPHeNO65RFWjbLon43dbfGA7FpDoNbUGSs1ttvRhLkbrWOR+MCACnvFPqY6S4y2wFo
         daWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHCznAnnQAYz48eTgFYLJvdpVfiUuX0DBbnjgt7+2YKNFjrrANBwvpq+EI5JjGbQUC829v9nyrtBi3AVQN@vger.kernel.org, AJvYcCW8PRA3zCmYOaNJg3IyruMMTFn+DS+L7BDZzLbAlqVk7wJWGzJBZdwfptR5zs7IuGcxkYcSs7T+Ymo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bayq+H/jxxxvM6dh8xomEFOvEyUUHjPPnVp+1I/LT+9hIIr8
	jnSFKhrW34eLZZvDfhCXsGanuZ+ft5e48fQuWMKfeNjjYEosAy8OAK5qlkwGbzFNSubpJU8QuD6
	WeJBMdGPuE5RfGx5HRbYwIrwtd5jW4O4=
X-Gm-Gg: ASbGncuFhsQW5cufpAgJXT7Xggpg4DuFiteA8ZhCDY1Caxvb/9wCTgK1TFTevOTTOHN
	TNvta1G6EkVpx5qzm9pW0GCSe1kKyIEaq2/icKaEpRwDwpMAe6vrlbDcTSCTLEvi8Ez7weSIpJs
	VO9U20TGta6GuOc3ePAFAJwCd5y991a7s6MQJTn+wvJg+Towxv8/yRSTNuL9gNVNS34URSJWlKA
	r4d2Kk=
X-Google-Smtp-Source: AGHT+IGR1GF1ks6PBauuHZfP5PEgVhe7wupe9olXa+YwpUunXnsXzW28eIeIWcB8raG7qn0xzARNZocboPuAkeqeSE8=
X-Received: by 2002:a17:906:794f:b0:ade:4f2:9077 with SMTP id
 a640c23a62f3a-b01d8a52f42mr181903866b.5.1756557448764; Sat, 30 Aug 2025
 05:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830115858.21477-1-gustavograzs@gmail.com>
In-Reply-To: <20250830115858.21477-1-gustavograzs@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 15:36:52 +0300
X-Gm-Features: Ac12FXzzu1BAIYvDIb15ywIAtYS34qrZrypq1lMRRbfdGPQPbnfDc0KT0hYQiOY
Message-ID: <CAHp75VeyuVVNAipi=a_xKtmvJ5fW6xsrLcVkfOLTf=9VW7yFsw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] BMI270: Add support for step counter and motion events
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
>
> This series adds support for step counter and motion events using
> interrupts in the BMI270 driver.
>
> The step counter can be enabled, disabled, and configured with a
> watermark, all from userspace.
>
> Any-motion and no-motion events are generated by detecting changes
> in acceleration on each axis.
>

> Sorry for the delay in sending v5.
> As a reminder, patches 1 and 2 were already accepted in v3.

Right, and this series has confusing patch numbering. Please, make
sure you send all the patches that are mentioned in the numbers, or
correct numbers. I even don't know if `b4` by default can handle this
(yes, it can if one manually passes the numbers of the patches to
take).

--=20
With Best Regards,
Andy Shevchenko

