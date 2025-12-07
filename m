Return-Path: <linux-iio+bounces-26898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6086CAB720
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777803019BEA
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401227B352;
	Sun,  7 Dec 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7apaoMR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE34230BF6
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123182; cv=none; b=flH9jW0K1Y0UaX6jYI/Y0dT5uo1laWgTH3em0vpcUp7BAAxi2AXLOA27OiAbCTBJGHUUT8uviZgLDAN58PH5/FvwLFlqwpl5bsQIo7OUsIfOtnSMOd6naBT0BDTYmG6fLJ4zk2ytTSgscA2L+uTLtAWARvmF33BBd/UXhSJS7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123182; c=relaxed/simple;
	bh=yyNUlROQCvKp4HOi2SP71/oqKu0yWaC+JHckQnMu9DQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version:
	 References:In-Reply-To; b=C0Y6CP2MQA3rHU9LEq10LULF58prIsy8uo34tc66z9pTcaMkeT2V9kHr9J3aV9QrWPgfKTz/oI6MN0+6SbMif/8SEbMkQMECeAJZ9VDzy4yL+5xmxJBxDbnNByax/PTt2nGVeZjuUCPZGJ0WVjxc+xmC3vj4AHTTT/WHWbwg/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7apaoMR; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-55b302b8369so2254660e0c.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765123180; x=1765727980; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version
         :subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1tqJEH0nvtzunebE0gFQ9Z6ukbX9uGV2B9981sp0bk=;
        b=Q7apaoMR8IQXj/ugax8lNuArcR7ygGwodTrfhDEIeVtEdgORzkx5l9K4+1xKXv/zzQ
         gbiZLuVOLHa1HxDt1+Vv02v27u5CdOSDojovSrWUObZAYFGHlga+3sU7XUnW3zQ+odDJ
         U2YBGQM6jmfMl02sv3p2vb+Bj2LagdxuIiwAl4kTbrnX5zLYa+DgutDWLYXSBS1hOaCq
         Cu6lZKmzMfiY8eLzuGXujNuyxFlIzjLRWNNfo+gvpNGtLyX/N8ZU7QQlXK246dWJglNr
         MMT/fkNwvMlg7XsuQ1YfLApPyzoowJvmv4WMuspmwAEy3LsDpi3/p1YbrEaipQd3c3NL
         CGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765123180; x=1765727980;
        h=in-reply-to:references:content-transfer-encoding:mime-version
         :subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1tqJEH0nvtzunebE0gFQ9Z6ukbX9uGV2B9981sp0bk=;
        b=pSAvDAOTaXAhV3K87ZCVhQ7rV/6w/aZYQwEjRdsZMWy2Ckv+qt91URYUeK1dfiqzzJ
         ap2w8BoPadap3PI01A0WmLqUDFDt6F06j3SyZv/0a/G35cqegolygBOkQHF8OvbuO+FO
         aIkhDSm9Dwm8vZ7DWyIfpuXbl8CpyZejA4H0zJHne5+gdvjeUeu1m8jI42cug8SzzDFr
         iBZTb9uMJHTidM+hmizKpZzGH6sitoVEOm12bjCWGMR47L6GGEi1nIgHgp16nkyBppoH
         3qDs5e9H+oXZUe3jSGqQ2hDz19p8fqNOILhZIBZtw1Q97YjQqmn+FL2X7iPd4awM8aUD
         +UNw==
X-Forwarded-Encrypted: i=1; AJvYcCUizwMgExZFe9oZEWtFZdST6DcpXtd9kE0LD/mca9uyabTMH8QxZiNA3OS6Koq12/nIwu/pQ6haGgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UHkNsVEyVXXoxQEmx1gsjvJc5D+TuVkvZqRvcndCuUsQqlkU
	Y9/PFIKRbjcabb2pebNasA9eYO/KLmdtsjQwf7/8oroCpwh/CDp+uQsI
X-Gm-Gg: ASbGncsqFhbW5dlBr72wG7JTnm98LPq8rSJBqcFkv1JtxDp61lHF/jdrSrhsc8W02vm
	JQ6d26jG2ZOctn+wunOpG7Pdr15yeJQ4tpsWUfOtR43pf1yFbjhqIiTmJW2KqK8M5u/6PlW/vzh
	M5oV8QxlIs5jfV430f4fI+ljGH0WxKI97J5o4CagTWaqz47M2FD/wVCnpswL8pvjM5lEn/3DpDk
	A6Pt185hkPYyhn+Ze4wZauGnNUzupMzJLBW5xS+uF6xmNuzCg0PzRrUeJnm/MrFMp9BSrmWoCNJ
	saUk/KhBgYd8UGgJbEt85YY3YE1QCv3EViOZzeYFxyzw5VCWpUTyirBw11JJT6t4i2ZGk8Pxhk1
	1+7WIay3uOpzULP7mTxhb32y1yF1y8VZw76XEA19qgXflm4C0jSaa4RNyrkBq2xGygDZTHYbfSy
	oT0Fw=
X-Google-Smtp-Source: AGHT+IH3R7zodvMeVJJJJ7fn2S6JQ+o/S6MOmjVgK3nMnTwxe+33R4LGyRZImJUof8loaB4NiZRB9Q==
X-Received: by 2002:a05:6122:6598:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-55e84587aeamr1556249e0c.4.1765123180107;
        Sun, 07 Dec 2025 07:59:40 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c972414sm4860987e0c.15.2025.12.07.07.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 07:59:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Dec 2025 10:59:37 -0500
Message-Id: <DES3Y1DXTLGR.38DNWI7NC291D@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Benson Leung"
 <bleung@chromium.org>, "Antoniu Miclaus" <antoniu.miclaus@analog.com>,
 "Gwendal Grignou" <gwendal@chromium.org>, "Shrikant Raskar"
 <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 5/6] iio: health: max30102: Use cleanup.h for IIO
 locks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
 <f96694db-2ad5-46d3-a380-cba3eaa2de2f@baylibre.com>
 <DEPLIJFBZQ36.20XX5DCMCJVB3@gmail.com>
 <c9efd563-9d52-4761-a5f1-be0df0222dff@baylibre.com>
 <DEPMCPWLO4FO.2B2OXMF2CZ1G@gmail.com> <20251206181758.2bfefde1@jic23-huawei>
In-Reply-To: <20251206181758.2bfefde1@jic23-huawei>

On Sat Dec 6, 2025 at 1:17 PM -05, Jonathan Cameron wrote:
> On Thu, 04 Dec 2025 12:47:08 -0500
> "Kurt Borja" <kuurtb@gmail.com> wrote:
>
>> On Thu Dec 4, 2025 at 12:35 PM -05, David Lechner wrote:
>> > On 12/4/25 11:07 AM, Kurt Borja wrote: =20
>> >> On Wed Dec 3, 2025 at 4:52 PM -05, David Lechner wrote: =20
>> >>> On 12/3/25 1:18 PM, Kurt Borja wrote: =20
>> >
>> > ...
>> > =20
>> >>> I would write the whole function like this:
>> >>>
>> >>> static int max30102_read_raw(struct iio_dev *indio_dev,
>> >>> 			     struct iio_chan_spec const *chan,
>> >>> 			     int *val, int *val2, long mask)
>> >>> {
>> >>> 	struct max30102_data *data =3D iio_priv(indio_dev);
>> >>> 	int ret;
>> >>>
>> >>> 	switch (mask) {
>> >>> 	case IIO_CHAN_INFO_RAW: {
>> >>> 		/*
>> >>> 		 * Temperature reading can only be acquired when not in
>> >>> 		 * shutdown; leave shutdown briefly when buffer not running
>> >>> 		 */
>> >>> 		guard(iio_device_claim)(indio_dev); =20
>> >>=20
>> >> AFAIK you can't guard() inside switch-case blocks. I don't know the
>> >> exact reason, but it has to be scoped_guard(). =20
>> >
>> > You can. You just need the braces like I showed in my suggestion.
>> >
>> > The reason is that guard() is declaring local variables and some
>> > compilers like LLVM don't like declaring local variables in a
>> > switch case. By adding the { } scope, the variables are limited
>> > to that scope and the issue goes away. =20
>>=20
>> Ah - You're right. I dind't see the braces.
>>=20
>> Now it is overly complicated. In this case I see why guard() isn't
>> really an improvement.
>
> This bit of guard() usage is fairly well known and I think people are
> getting familiar with it.
>
> So I'd prefer the form David suggested. It is nice to get rid
> of the mode claiming dance in here.

Ok, that's good to hear. I'll take David's suggestions for the next
version.

>
> Jonathan


--=20
 ~ Kurt


