Return-Path: <linux-iio+bounces-19248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E31AAE597
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798934A6618
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449A28BA8C;
	Wed,  7 May 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMH/7GGO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37C35280;
	Wed,  7 May 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633346; cv=none; b=dO0pcEfHZGvhK+9+Uf5WDD6ta64utaxis4tegMEIcR9wX/ERa5p4Y4uBBFMUNl4rpOfOhGJW3xpFmwEgV3hoFepsPoTZSjYEcQP2KPt4cBFbF72KlwDei4CIWMENs2sMiBo5w3h20MtG6PbqPXk69AvVGN/Fq4RuF8nIHiDsHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633346; c=relaxed/simple;
	bh=Z4fQvV7zezeHfycJsfh6wCxmtWY4lou+a1O/Gu2oekI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+amCV8blvFswMpih7bs8NvGjOhBUVNuHuSZra7DOLID1OGUY4VEzr0BO40BRcVvJTNQ93NqzaxfPLnvTcrgsXzo3goNj17O5C/vGk3hgQ/ElRzAcSeaq8IVB+0ZqEAW6CLDZhzjmwIoeyck2MDW0HtiSJZTihbQYE+Wsc1YIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMH/7GGO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c062b1f5so119684b3a.0;
        Wed, 07 May 2025 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746633344; x=1747238144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J+6P0/W2PtnIeQklrtsaIQt1IvAWvL+QcuunOlVT+g=;
        b=RMH/7GGO7gP8Aq6CpahEu62pE8E+dPHnVI8Go5aygeZKfpdf+4EN/yez8vyZB3oTWQ
         tR1+LIJbz5uwmq1zKcY+TfnaAFxV+pslbLHC8h2r3+gujcV6q8TwNwG7SM3OzSyqXQ5s
         /eChQdEn5HhRVZsytQjzH29hYAwc6uC3rd0C5PBlZJYV2pQ1rAeziCpnkckOHOSkhYRf
         Xqxzh+8EZDgyNRwX3Yvk+H3P5UJxZ7ImRduLbdhZKrwjLZeC9smN0HzHMu9f0bJbNUz4
         9Ib4Tq0PB58kk8M0i5/+TLwf+m+MeOmSNaPOCA3QQl+8kf8JLcXp10rBivOA2UMd+6pj
         mG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746633344; x=1747238144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J+6P0/W2PtnIeQklrtsaIQt1IvAWvL+QcuunOlVT+g=;
        b=q8/IuP6iN32ygwQ7fKDOsIZT85XUVCqg3R1rfS/9Bqru4qZonv//s/6985UEPOqGUF
         sm+fXi8O9hWozkvCA2wUfYTXkeDWVSc7t4zvA03EXkIx7qpnYkTbbSYAwNp9/xHS1keI
         4vTvgROcMxhmNxBvWvOy92Az/N56DyAEBk/H3E7pE2zH/CMNrXxx/cih3BmNfHV6v3Yj
         y1TOeva1gSQF9LDkCg8BKu6XkXE+Kh95ZIcytnmEw9Ficu8KJSmMyxt2RubiRjbTmgKD
         wYm+Il6i8m31xfPhpE936Cb8scxU8boHyviWXWcKJ9+YlbautDBfQMyqTiFAPY0HTGE1
         wyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd5AFZKAtsV1eQCC2TEcwgW2pR4MywZKmhT05a0hBnQlmTLMwmH315tR+hNTOIuOLt5wNkS0506ShfhyDp@vger.kernel.org, AJvYcCWZmDEyTkuEmmieMexGt5HlPr19+dQhkjAUF8ikjXNcYkivto9uQhvjUodeDciun/Uh4P0H5kkZ0epM@vger.kernel.org, AJvYcCX/T5xfwefUxkM4OjHQcaEO4TzqizEx46hwkeuVzsOlBANyyRm+ILVB3QWXsNlgXseELa/N7gdVVPfkelNFd7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd16UM1d/UxO5mlBwuAvcyy6QSSoK4AhCOp6NHwsN1Kwa9hg6f
	mAGYEF/XjrYafAXKRhrS3yJeP6IL96B1T8AsNk3VrU+4O+GFoLZuHTxQBlipYmHjigL9dt9jMej
	eEcobBLmzm+PzsiSimISt489qsmQ=
X-Gm-Gg: ASbGnctQ7PpNQIAj6RBYgJFEwebZAGTUlHE+J+VhDZ7pIftJP+n/5+Ta2dGG9OGacOZ
	F1KUZr0WpPlfEUFaJsU1oewg7855mkdGzozwSDts0E+BWYyYbY0av9Bh3XVex/UUs1SRNo1/RLj
	qYegTqezEmFmP5Xk3t7Jm25pk=
X-Google-Smtp-Source: AGHT+IFFMkn/R9L4nCo4z35Kpikbtn3CUO8rkl3sHeyVF6TcYFb5B1vcS2HKUvJV8otqPiLKe0iyeiZSe2hc+9vurHI=
X-Received: by 2002:a05:6a00:410c:b0:73f:f816:dd7f with SMTP id
 d2e1a72fcca58-7409cfd9dc8mr4242607b3a.15.1746633343639; Wed, 07 May 2025
 08:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBtZFLFlr0slcYSi@stanley.mountain>
In-Reply-To: <aBtZFLFlr0slcYSi@stanley.mountain>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 8 May 2025 00:55:32 +0900
X-Gm-Features: ATxdqUHlwff0xDQnDUy2qyTLeOnosqcRlN4DKZfqoeV7iLCnewEnV1wpLavy37Y
Message-ID: <CAKbEznv074pBjgYUAwe4CFBv8=qRVUOp+1NrasGDqH6vyDJOgQ@mail.gmail.com>
Subject: Re: [PATCH next] iio: chemical: mhz19b: Fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 9:59=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Return -ENOMEM if devm_iio_device_alloc() fails.  Don't return success.

I missed that devm_iio_device_alloc() can return NULL on failure.
Thanks for the patch!

Acked-by: Gyeyoung Baek <gye976@gmail.com>

--
Regards,
Gyeyoung

