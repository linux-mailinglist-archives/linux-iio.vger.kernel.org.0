Return-Path: <linux-iio+bounces-22407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA72B1DE64
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C053A2D11
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FDE2206BC;
	Thu,  7 Aug 2025 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZd+UGVo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE741AAC;
	Thu,  7 Aug 2025 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754599013; cv=none; b=LIRLKZIzehqVHVbfoedTTL2/0j7yDxerhXPSLsLCdPED83ZiZNYW5z5eDeUvg96gKknVAgysNNzT8VgN6FAznDwC9oIfRUbivX1i9EAev6U03At9AovXoTnlp+6R2G1xoKAvEDb8tAfdZeGr3VeZkkfsaWTe4zLMql2C6EKptKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754599013; c=relaxed/simple;
	bh=q9nzQPCdilIH3nC0DLfLlialrtWwvTDepS04+etaGOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPHXfqZUbszCHh0HTaTwJmwDwUGHLuTAUhqtpf9Jm8RUiN8G0P4ue7TOdpGHQoAxeRHw19PM0IsmG+1QgPaG7YqF0fLtR6eILbeue4gxuDmmeFZXgJT3VIlR8wK5H1tL5e88epIKQOvU3ktqJ7+0N2YPT9cCa/ZiPL+7yoSTy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZd+UGVo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af967835d0aso216349566b.0;
        Thu, 07 Aug 2025 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754599010; x=1755203810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9nzQPCdilIH3nC0DLfLlialrtWwvTDepS04+etaGOI=;
        b=fZd+UGVo1AQ3+Q9rftUMHlO2lxANrEOb7Uap38SM5HlW+nqVksHdYGu01EZ++jbnc2
         PBxsmGmAAG6k9Wqf9oxAhF8TAMQay9P7Z4OBGiodeKKEbnk6JPgaLznf6RYeKTluMjfG
         3QzR+7kAXSMcYcPEfcwpxxOjOYXSxQ4P+sSM4QPo5lwsmgc9Ju5TGKcrCqX4nebn1PPb
         0TYPaOQ2cyqEgetwem6b9n7bu8f2z8pKo/doq8UTP5K6piNCyo2EuioZNS6LOMvpuWx7
         BtRSBS8ZeoaY4QmHHqhT7E3L7WvjNrWezO+Jx2K8vMOXgK4pJj4eLuzCd5Y9Jyp31qZc
         /lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754599010; x=1755203810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9nzQPCdilIH3nC0DLfLlialrtWwvTDepS04+etaGOI=;
        b=VYIz301OwTVlslz+JggP4tNquRIjrwmxLCkcY8f9tqYzNY263umnpMuRBk47aSwQ9R
         lRSFvM05aM5i9wsxNX8oQ/83n57YqTh+jzF8ykoVlfTbCiJW2wEJifzflTgObjZDtAU9
         VQSWgYvmeJmozVd4ahxfsJiv8YN3DExKGYXJgVwi05ihnJl7EVnIan6VFi/mI9ydROZD
         I+vcJFw4XBFs3fw01Res6oVBS3KxqmozlvcfSipEYKWP/rMxJOioNT/T0BxaRV0gjsPj
         Hk/mu/3WouxvjD4WlTYiNyRYiirwB5Nu3GBYL68X+LUngD07ABi2finQ2rO3XvPajT4h
         7k3A==
X-Forwarded-Encrypted: i=1; AJvYcCUCiYFXDhxz8wu72Jlji9veLlC3MOtJbdHt/xN65/Kz7gJzOsEF+fZzxBaMEMOHLs9iW2okl4rnF0k3RiJ0@vger.kernel.org, AJvYcCWr6BEe7XCYWg2gz+mpVOzXeINEydziBuVSp1FcdTjhq3Hlj+QCw5Pv26T+DAUPUPSqhctqcJbUAqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aLvwgRVu8FMa600xvTDEK3wBTz5gOO7RT0SXBm9zV/GHcA1n
	gNL+prwtdN2g43L0+A8wwQS/U10pd8cpXAU2u4WI4MbCCCt4A1Rvc1GHs83eK5PhNSns4i6oejm
	BqXfAvCIHpS0lciM1ZktaifdqEsfIXpk=
X-Gm-Gg: ASbGncspa6ItL2xxsvfLs3YVESfVUr77D+TFe1lbBabr93K9Dv00YH6mzSuteAm4Qsi
	RXO9pUaItHmGTL2SmKs/J9ZXg7OqrXuFQDfbLFj5SavsMF0gVk9JXoqUDviGdmHfdh9crEEgW29
	uCqCS79LQSBaxn/5bHfDDAhBcjdmFcbuquSYsIVoLmCH4bokyBe9RXmdjsMXZbmftAae+BH+LPF
	VUFwWeVFAhXjjNCenv1LzJ0tf1NmvC+2PuNqbjEMQ==
X-Google-Smtp-Source: AGHT+IESK+SuVqbPuRAGwRMZbAXPWstgP7YRSko/qRsBOh/LyezwGlZkjMjfTpdFhRDvHD4QlNZ2laiGtCoEQ7RSJ2U=
X-Received: by 2002:a17:907:6e94:b0:ae0:c690:1bed with SMTP id
 a640c23a62f3a-af9c64f900dmr28204866b.51.1754599010020; Thu, 07 Aug 2025
 13:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJP44mH0AXQGCFFR@pc> <b7288d5e-8dc8-4ee1-ae34-52904a3f989d@baylibre.com>
In-Reply-To: <b7288d5e-8dc8-4ee1-ae34-52904a3f989d@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 22:36:13 +0200
X-Gm-Features: Ac12FXwPEvzJsYILJiSkJhSS6pbsOQf5VaM40fw0mSI6WqMCMIokOCoAAic27iE
Message-ID: <CAHp75VcD8nKdcEvQDnASfhF3a1VK71wjk55TeX6kJSC2UQQZoQ@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: Use IS_ERR_OR_NULL() in bmp280_common_probe()
To: David Lechner <dlechner@baylibre.com>
Cc: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:24=E2=80=AFAM David Lechner <dlechner@baylibre.com=
> wrote:
> On 8/6/25 7:52 PM, Salah Triki wrote:

...

All what David said I agree with.

> Also, gpiod_set_value_cansleep() would be more
> appropriate. This is not an atomic context.

Just note that the original code doesn't have it, so it may be done in
a separate patch.

--=20
With Best Regards,
Andy Shevchenko

