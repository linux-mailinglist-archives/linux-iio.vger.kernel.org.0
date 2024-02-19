Return-Path: <linux-iio+bounces-2759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291C859FAE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 10:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EB21F20F23
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B101323753;
	Mon, 19 Feb 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO0Z8/NN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1D23765
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334869; cv=none; b=pugCIMZjegHEQHWeVEZx8bIiwHQOAXn6dd/vGKW4D+5vKvcdl+4g9AogWWNHX0G1G1TejihjD6D20zVfH4gnyl91YABrggjJdsb8qqLu/Mn9ObcvxqY5LEte/ynxvQxOnLKSObqhot0ZBFiZiZEwM8QbfJ492RKTkJK5TjUAN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334869; c=relaxed/simple;
	bh=VlGGIkVp3QtN08yCqORUViDs+yHLNt6uj9h5UdBpl08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=naFFDWprU4nGkG6znUiW8a24d9QIyZhShYKdITVIuNRC36IMgFyqHvmK2209kB1dU78CxSe8+MsIwJ7/h5UYd7Okkjix4Dt/pFZ7k9qa6jWftZ+srucs9wT4n/ayYmMdI9TPvnnITvqn8iFH6lo8d+9H3YY/jdhCp6Kx1R7jWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO0Z8/NN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so5521206a12.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 01:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708334855; x=1708939655; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VlGGIkVp3QtN08yCqORUViDs+yHLNt6uj9h5UdBpl08=;
        b=hO0Z8/NNao1q/wL48VSfCO1dQtQka6f6gWpAhsIXOO8GnKV55vJq+obvmBNXH3YqzG
         lWQj6i2L0xJFjHoYY8KtYg0C+2UpfEiXOPZAkQ995wQm9xbvu6iVOK0Ied6z84uWZ7rH
         ZtE5jWIwNP+eVNdFMFrJQRYdlpXR5Y2HmTEM0HwRwsFnv8q3oGCeTRfckFEOgNgRDJJW
         TzXH9nI0VcxPKa5q39BQT02uzmnoaaxGwv/kpy+HHX8PypytnDaUDLpmK9PoioHyhR8j
         0nSnXBaLAapjp9lyKZAIz5TrXmVGQRxp7YkNLF0ywkm6qtR8WA/hpoF/gnXjXfjvJ7M+
         ZWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334855; x=1708939655;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlGGIkVp3QtN08yCqORUViDs+yHLNt6uj9h5UdBpl08=;
        b=WQZyfaIIL7nEzIeG6kFd238w1SBzv5L5ozxxhhKsUyUBPTzGgWKBhnK8ty5DzBhf8m
         cAwyWbaV9v5ri2Ry5O0xBqTjKQtA+Uxw1F8YSgE/Ph9y6f2Gk1eJm87hzjDisfSWQyK6
         ohaSuG+VrKuSKuThAD2dTSI9JOG4mKB3Ml2O1tuJTUJHpVFQvyYmZMI/qvUNoHUfe8li
         f7bkh7yDeCCpfxPOwM27P8NETXFAEfdQBwqUEGEWkxK9MszJXtHwjItrfmV1ssDJOOGY
         P9BQNYi2251Fmbu/CKSaHH7jFtOEDH/AOOCfuaQPfJUmrvbtXc86a5UxuHsRsIC2GpZ8
         +Spg==
X-Forwarded-Encrypted: i=1; AJvYcCWQUBYQbF0aUcbywqrUkfiIFn20kKdz7hUsYFAbB/9lGx9nQ+BUcPxLGYLLSvrh+z7i2wB5FOmrKSMxFrcswMWbdLsS7NkRVgfH
X-Gm-Message-State: AOJu0YxHJMgNk2sDGXbCu6eOpWSCB438FinaP+NumvZYKGPZe1tK3h3l
	RVTRmxW/RnX66skC8F0Wudfxk7sa7PViRMNaELqItDWIYddClEIo
X-Google-Smtp-Source: AGHT+IGNtqVSl3KSrAhPvr0/P76baPVbf6PLapkKKLAYQJONPROVcnsnUmGLnhOxnXoqhYwbYZQL6A==
X-Received: by 2002:a17:906:3387:b0:a38:51c2:68a5 with SMTP id v7-20020a170906338700b00a3851c268a5mr7185416eja.7.1708334854840;
        Mon, 19 Feb 2024 01:27:34 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id ij26-20020a056402159a00b005621bdbfdb0sm2535022edb.75.2024.02.19.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:27:34 -0800 (PST)
Message-ID: <8d0f90356a5faa44dbe2d0f2e26cd7c8ea061572.camel@gmail.com>
Subject: Re: [PATCH 5/8] iio: adc: ad7192: Convert from of specific to
 fwnode property handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Andy
	Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Alisa-Dariana Roman <alisa.roman@analog.com>, Haibo
 Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 19 Feb 2024 10:30:56 +0100
In-Reply-To: <20240218172731.1023367-6-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
	 <20240218172731.1023367-6-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-18 at 17:27 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Enables use of with other firmwware types.
> Removes a case of device tree specific handlers that might get copied
> into new drivers.
>=20
> Cc: Alisa-Dariana Roman <alisa.roman@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

One minor comment. Still:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7192.c | 38 +++++++++++++++++++------------------=
-
> =C2=A01 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index adc3cbe92d6e..7bcc7e2aa2a2 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -17,7 +17,9 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/delay.h>
> -#include <linux/of.h>
> +#include <linux/module.h>

Seems unrelated... maybe mentioning it in the commit message would make sen=
se.

- Nuno S=C3=A1



