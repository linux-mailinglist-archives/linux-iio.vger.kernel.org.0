Return-Path: <linux-iio+bounces-27124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCEECC51EB
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 21:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFE1303C9C4
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E16285CAA;
	Tue, 16 Dec 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGKVs8b4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6A18AE3
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918167; cv=none; b=tmJKrncAlL+aZuqkK/OoKafQfIO4lV1qZLZC8a3M4udePQTwFmvHTimbwIPwQXm8Z6lfjmsNf69SJ4g+3mvNVzivT3dW+ggIZL7Ae4Jzybh5ny0FYecIUaR0E/aYFldndiAogS5yiKc7WzC7S8geySPJrj0GdiXA7x6rdbJtXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918167; c=relaxed/simple;
	bh=R7S5XBixF3uYt2ltrMgrPEDqaR/EhDDXEQ41SJyHdbs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GzR54m35tq5VoBonGpreis/lT5z65l85ypY25RrFdlusOXAJGUteM+0Npkc3skItrXhs1LE1Nbo/oZ9VfrqJU+1GiMItPk6yAy4ziBzysvAvP3LhaOtgbdpKhq/AW84Srm6NzupCj8PkGpx1RB5LKIol8MPiaDA90TB3/5KkFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGKVs8b4; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so3313925137.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 12:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765918164; x=1766522964; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dxKHiLj7ErsPLc8qt6gIwV3RiYG6xR2jl3i32WC7oI=;
        b=kGKVs8b4CQBMWy8QamnEBYsJSYi6Xq+KkqjVKWmDqdgWEQInOASuVyrLfne1aFXMqV
         DMgQrYSoExKQAvAQUNq+VdmfyZ75mkuyG1ece8kn7WCS2H/UxqT7ItAP+O1DM5s+CNHB
         cC4BQ3MhBq3Y+9k6vKdlT6fe2yYd82PpcAc91PR2Iw6QUkE1arQK/IW9smodsFOcmRXg
         8tsQsCDNFAtnADUNg1iJkHbFHaIco0wFf+2b3fbU8xvDk1pjarOFR1oQxIdnXpZEG22G
         U/0+5cr+oHlH3Ec1UW41cr7LC3CYhct6ExXA3Wk2eUqvDUkj4HrITaqfi4bgTdLYi8LX
         Moxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765918164; x=1766522964;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dxKHiLj7ErsPLc8qt6gIwV3RiYG6xR2jl3i32WC7oI=;
        b=MR1BJQGWD93j6v73b4muaUHArS7rJ0o6fK5UpzIYVw8j/psRVAxnn3iI5aym/3pwRo
         Q71Oc1WkLLLLjXclQv6JbjUVkMm/qqij962liCeGVn+2OcpEui8grtsIbdxL0ZgJwths
         OmuwNjsyBmf45WMt6l4S9X5d7MbijW9pxqSdSdxzXsTW68IE5x2tFsaTMH4uGN7IfVKx
         pe3HdNT9JvD9yKJpESA0K0wZk67VwCI7G8ggKl1vw6yJSLguVZGrwrmQG+rTLIK9Y+qk
         Sz3P1WEKwEqtUc0YmPM22ugSokU1582rdzd+3yK1HOI0YHOnjUOyG5YNaB4ff2tjhOAu
         cwzg==
X-Forwarded-Encrypted: i=1; AJvYcCWbA0FJg+jrOmhrZvzzQRQ3jzDx3H+0xnOlNxd4FNJJQHVUZawYvJBLATGtylIPoQR99kh8c/VzZg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cR2SzIcdYUvw9u/7okN5LMW+GSHs++aJEwu4J9mqihCOD6w4
	YolL1zaCyHbuKQE7MyVZchv5YTxqqRqrs4DRfyOyURQxO3VpHyUMRfHO
X-Gm-Gg: AY/fxX7mosl9uZvx7qqECUYFVZXxjtOKB1E6YuUSNaQOOZojMwNjSUcPjn37IfP+wYi
	gYCrUg7+zCIsRH2zwgC3sn8tfETuw3ZoXI1kKIDGnpt71oBz7/d5bg3iBrw51ijL/tdX+QgF5A0
	6tWcCmRULcFj5DObklTPPYvV29JZbxjsJZdKqb3PldTAh/luY56rjT6JW1O61DXETJ8yIs81sCw
	kJkR5WSJbJEINDRs2sTQQdDCvNxlghKM+dWtkGXjSuN0+I5eBnhoIpXPonKZGLvN3st+0I83iiM
	KXTCmDR3rjp6IPRoQt6U9DzZ1vqcnY+wg8Xf76ATmXYypf3f1nLOTim4cfUpOtogQFLHMR+7YXS
	Gtq5vRpkh0lxPD+yBP4SzL1y7drx1X4BO94gLAptgd58F+160ovyBdhToFjy9Un9v5pO08Rqt3S
	SHSYfk6A==
X-Google-Smtp-Source: AGHT+IFA0ZxxYgAsVtA9i5elaqbLDSzPCkraW+M0I1/U7o+x0Y5JFSfqrO5PMnkRvovtXH6qMbPNsA==
X-Received: by 2002:a05:6102:4412:b0:5d6:218a:66bf with SMTP id ada2fe7eead31-5e8274895demr5093041137.6.1765918164559;
        Tue, 16 Dec 2025 12:49:24 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93f5acacc12sm6316965241.1.2025.12.16.12.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 12:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 15:49:22 -0500
Message-Id: <DEZXQS9JU593.3TJMIOOJXD1JL@gmail.com>
To: "Jonathan Cameron" <jonathan.cameron@huawei.com>, "David Lechner"
 <dlechner@baylibre.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Tobias
 Sperling" <tobias.sperling@softing.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
 <20251211-ads1x18-v8-2-5cd12ac556da@gmail.com>
 <064e059b-5c86-4c41-8de8-b6a728361fd3@baylibre.com>
 <DEYY46ZUJQ35.YBNYWLGZMRYA@gmail.com>
 <bef2e71c-fd76-4e73-9e53-422f9fa96757@baylibre.com>
 <20251216182106.000051c3@huawei.com>
In-Reply-To: <20251216182106.000051c3@huawei.com>

On Tue Dec 16, 2025 at 1:21 PM -05, Jonathan Cameron wrote:
> On Mon, 15 Dec 2025 12:09:31 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 12/15/25 10:54 AM, Kurt Borja wrote:
>> > On Mon Dec 15, 2025 at 10:55 AM -05, David Lechner wrote: =20
>> >> On 12/11/25 10:25 PM, Kurt Borja wrote: =20
>> >>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
>> >>> analog-to-digital converters.
>> >>> =20
>>=20
>> ...
>>=20
>> >>> +static irqreturn_t ads1018_trigger_handler(int irq, void *p)
>> >>> +{
>> >>> +	struct iio_poll_func *pf =3D p;
>> >>> +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> >>> +	struct ads1018 *ads1018 =3D iio_priv(indio_dev);
>> >>> +	struct {
>> >>> +		__be16 conv;
>> >>> +		aligned_s64 ts;
>> >>> +	} scan =3D {};
>> >>> +	int ret;
>> >>> + =20
>> >>
>> >> =20
>> >>> +	if (iio_device_claim_buffer_mode(indio_dev))
>> >>> +		goto out_notify_done; =20
>> >>
>> >> This should not be needed. It should not be possible to
>> >> exit buffer mode without triggers being stopped first.
>> >> (No other driver is doing this.) =20
>> >=20
>> > Previously I had my own lock here because ads1018_spi_read_exclusive()
>> > needs locking. =20
>>=20
>> What exactly are we protecting against here? I.e. give side-by-side
>> lists of possible concurrent function calls where there could be a
>> problem.
>>=20
>> Any call to iio_device_claim_direct() will already fail without
>> calling iio_device_claim_buffer_mode() here. And since this is
>> an interrupt handler, we don't have to worry about reentrancy (it
>> can't be called again until the previous call returns). And nowhere
>> else in the driver is calling iio_device_claim_buffer_mode(). So
>> calling it here doesn't actually add any protection AFAICT.

You're right. I assumed threaded IRQs were reentrant, which doesn't seem
to be the case. Thanks for pointing it out!

>
> Agreed we shouldn't need this. Given these comment and my lazy nature,
> Kurt, would you mind spinning a patch on top of this series that I can
> squash with it on my tree?  That should be easier to review than
> a full v9.  If you prefer a v9 of the whole thing, that would be fine too=
.

Sure! I'll send a patch later today.

>
> Thanks,
>
> Jonathan

--=20
Thanks,
 ~ Kurt


