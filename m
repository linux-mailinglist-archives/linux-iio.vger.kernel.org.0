Return-Path: <linux-iio+bounces-20717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D01ADB3FE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123A03A3E2A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08881EF39E;
	Mon, 16 Jun 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL+W6iUS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FB35972;
	Mon, 16 Jun 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084476; cv=none; b=FZSbWPeTGC0KLgoXoY1MlyFeg4Py7xYTsm6uAr8/y8ButCvSsJmNbENTkB47Vgh4ymJXXw/e7S04gtRj2J4UjxT/6PUtZV2q1nECiiRsy0jvJAKlNQnrVQDJAg4+RiuxKJlmvvdTk1Sr9esP+CqfflcIruwkoOQiIvk+oH9jHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084476; c=relaxed/simple;
	bh=DFEXvJMtFPiUA+aGNpImiZasR8ptYJA6aCBipSdg4vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMODWONIKTFw2oP6bxm0fMzGZYGXxYaojLevy+40oJ5uk8qtjkuuS9Qh1YhACr4YPQo+Y/Zls6W4Zc+vAzF7OUKfrSfVsRvV1Q+25ate0diX4BSyMldHFRZnIr57pL+KamZp0RiTr5P9JBcJzYdZNaJoWBvt8O0PH/CZ+KlY9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL+W6iUS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so705470766b.2;
        Mon, 16 Jun 2025 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084473; x=1750689273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFEXvJMtFPiUA+aGNpImiZasR8ptYJA6aCBipSdg4vQ=;
        b=BL+W6iUSJBl63UvCBPkHzN8AoNmXwrgH53qNqK09Eq+neW/qdp2C68cA4ZP4oRM8Rl
         PwVOe3LsiXRjwZxeJTuZKi9ABhgHV/38xfr1nZ1t2r8f2mX0aIyeE5qTzOBm9OVlYbAn
         snS+SmG9mYDyF1w4+zQYux0hqnadIoPiD4eQyYgCEgc0ABhOtowmA4DcLzYEbwxXaogC
         /w1Kb9pFL5ZZxo0tl1EfMePGNDhIwtmQBdTTwTSew8ICBZnLrtI5vKznnvW+xVKBjb84
         qlh0bcR/qqALNjqpjiVP4KzKU8svSa6MxbXCeqTqLGHo7P7OLqGvKsJEEh6dUCigb4A2
         +t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084473; x=1750689273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFEXvJMtFPiUA+aGNpImiZasR8ptYJA6aCBipSdg4vQ=;
        b=gw/jEpJT9M3ybyZUCsRTZAz0wSYkinULE0z5/eeQmG85WiZ9S2hu0MxKodQCMrAkzP
         VdQbV85ED1RcPveJCpR+JuYUmVkTKdZack6QLffNxq4mQH/KlCs3dbabM+A4ogXgcDoO
         JeX0fraJewGWpiLpTShvs0l/AjhdpmKUeR3XKW4JVX5m4BiyiEXkbOBrK0K60E/MfspW
         fn+xzMAZFJM1Qi3bcTrscpJ19qNRZC5ubRXJb33Gbc8nTF7Vw1+H+jWk9iuANWbwwrN1
         pT6KqY/xWpwBd/LeB18pg/Y89xkf5xbLPDI/WR5H0JrM495i9oihhfFVIU856MtGXyu9
         nAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBF9BQiHzelCiYCrjiatDtLlL1UTuO3cmtGQuOuww2+7boQWNvGX0Ilrlx8kQ7kdLJmtNOIxHJE9ultjnS@vger.kernel.org, AJvYcCXPTU98vOsv7aq51WGRZfxXBdp5RkYnkz6nxnTZvd3+gDjdG5tcNcZpyp/wLecXO7GVss7vIDiwFrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5TBVXtIKAhdslSeU5emUbBqfo0c3unVTYHl36t6AWug9cojg
	MUUymxGRfAZ1PAD2/A5HdQAY01tU+FMznK2PcqjKXFVg5YpRHORXMWUvPHvvPDza9+yi2Qcg5bR
	oQ/13h4Q1EQ93ldYN6pHQVWl8DgdsgQM=
X-Gm-Gg: ASbGnctvd3A71LNmr/9GHV+QJ1ILX9q2tke399XPEAp8sFFWMUIwYmszSXm7qNJRPaZ
	KghgQRywFWqGgoD+T3prJr3GR8lUJ0/Jq3aNFLWeTpd1aBn/xsaYsWIY39Uq7jY2WQzcrdh3Eni
	UI+pGVduGv0SSv2Kd0TgimnvNjqg9zcAPhySLKQU161V+jzA==
X-Google-Smtp-Source: AGHT+IExi7rlu4eVG9zpxRbZ1THysuegiIITJYtBdFpKDFG2wGo7gG26X02JFiwRtTaboWxl+UKcwdmPYJBC/gNcfsc=
X-Received: by 2002:a17:907:9491:b0:ade:348f:384b with SMTP id
 a640c23a62f3a-adfad32be97mr893727566b.20.1750084472996; Mon, 16 Jun 2025
 07:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616090423.575736-1-andriy.shevchenko@linux.intel.com> <FR3P281MB1757C6A610D39EA737A19EFBCE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB1757C6A610D39EA737A19EFBCE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jun 2025 17:33:56 +0300
X-Gm-Features: AX0GCFuIWjdQL_-Qmm6mFok5HZqwKNNtREbEjPA3yJABbs35ebxLxjCIJQd2S8k
Message-ID: <CAHp75Ve68H448v3Tgv930yoMYCCKVC3kefuP+Rermj7SaiP41g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:16=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:

> thanks a lot for having done all the work.

Please, avoid top-posting!

> Do you think it is possible to add a fixes tag so it can be backported to=
 ease automatic backport of further patches?
> Otherwise for sure all further fixes will have to be backported manually.

The idea behind the series that it may depend on some kind of
cleanups. In such a case (according to Greg KH) no need to have Fixes
tag on a cleanup, because it's confusing. On the contrary the
infrastructure for stable kernels will catch this up. You need to
follow the Documentation on how to submit for stable (basically the
main hint is to use stable@ in the Cc line _inside_ the commit
message, as a tag).

> The driver code is full of intXX_t and uintXX_t types which is
> not the pattern we use in the IIO subsystem. Switch the driver
> to use kernel internal types for that. No functional changes.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> As noted before the pattern is used in less than 10% files in IIO,
> So it's safe to assume that IIO prefers uXX/sXX types over C99 ones.

--=20
With Best Regards,
Andy Shevchenko

