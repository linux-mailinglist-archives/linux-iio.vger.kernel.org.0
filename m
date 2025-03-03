Return-Path: <linux-iio+bounces-16248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F5A4B733
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 05:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB718188790B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 04:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FD101C8;
	Mon,  3 Mar 2025 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx1JSfvJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE533FE
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 04:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977255; cv=none; b=RhlkIt7FG+qW1zDO8uhI1VzdeJyJMyE0lM8RZ+QR57gpEMq9vEURTdzyizvtH4XjO73+NxaSk/xREIekLQGmQF6Iw361Q7UU5A4VzAqZ4xcVA0EEIWKNlOR1O6qwhCD7oxvgicyBPc6IhMOha3FS5+uncR1NATCS9BboOzkaTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977255; c=relaxed/simple;
	bh=v4pu6KYZ0AST/W1zlvzkOGCdP3A5ajHTL1zJv1eninU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4B8ZQHvEdD60hOVwK5ZOyFrNJrtOJ/C7B/eRabMbj3HuivU1I63zAMYaB68RJF/pJXbBooaO9Az/CDITSKtY9DveTt+MPMekq8CYixsLov6zuZod6k/yLGc/r102QaUWfu8yJ4MlOMTu2xL4hStMvuOUHiSONqSmgMVnmoWwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx1JSfvJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22359001f1aso87903045ad.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Mar 2025 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740977253; x=1741582053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lqvgbVZKJt9mTZyxRNia2jURGug2GCJSRClPk2UFVWA=;
        b=Zx1JSfvJiFyFgHNVEVSbpRHBHTmckximhjeE9c1pzIipNO6PyKMGc2r2GtieW4XyT9
         sVmJQOgRCE1Pr3uxvmYhr/P4M/h63Q2FnryKuWmnFxa60Mv3CbtjtK2teHeZW65x1uI0
         7AzhqyLf7rPF0aKNmi2DtPdTu/igdvaS4hgqYwkVOM3ulRXKIkYweM7H/0Y+QfRO03Bf
         OrsMY0vEdjpJn+tKwErvRK7rKURcramwjK9j/0W0GVxL4zvGTgFEC8crcyh3SCyN61NT
         fcm6gp0a9zcvhkLh15anRDNIDF4LaqndYSkeGhV30+oZnN2hUGjdLA14EG7tHMeOf5ao
         aa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740977253; x=1741582053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqvgbVZKJt9mTZyxRNia2jURGug2GCJSRClPk2UFVWA=;
        b=iaasOLuC8B0QuKPjNF3lp2bIRWV7/W9p3eAP9gjBzdkV32koHDt//sh/0U8JDDoBQp
         kErUekohugQkvdE3kjFwl+EstXxiZbrQmvao7lLKDqDtQLonLbKd+Pl1ZtZiw0CY+FAe
         VVdhmlSSI4QPNSkY6xWfjNbHPHi3aX8v0tw0zWr1YSBLW951/0wX9H4WS1JCzDJ7GRIb
         KKlyKJ2mAmGFeh4kYRpy/H+H82lAywj0J93mzRyQLTJqH4WkDBuNAe+YFZe9MByj4uRu
         j4C21+cpTj/U6olzBxfsSvcWzb1kkSeUM/408EGlDAzwLGsZ5rWlSIzNoVnXo2YEdpHF
         ko3A==
X-Forwarded-Encrypted: i=1; AJvYcCU0h+AkerKtmpQ7QtaUs11meDya+0toOKcgUlZ9XEphTZMMYwLwhJ8jdzcc4gbS9BDgm5XN/S5ZNbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywc4C2u16/DWozTir3dyh2IEjGMquedvzc6GZ2tLQrSNtvNaCc
	Bbs2r7i5bocZ2khJBo5QmfahsUnv7XqwGUlopTSNfmwONn/o2D2FE/a3jLw6
X-Gm-Gg: ASbGnctosTwRGg+7RR1U++vRcCvU6amw6YVFCRm67B83IyIxBkdZslu4YjnkwbrOAsM
	GnpHylDjOz6lfxVtjuySUD+ZeK+JOKgPoafX/mL2W9QXkJeaQCI7ceWy+A/lbtAOWTUvwBp7VBu
	Rf8TRJd63dB9/OMceuTNaN01nNfY+D8UWPYLfyzy62FshyJI6UX+ZthJaG8PJohhO+dWCWNl9AH
	EszZW6KNlvTXxiotXZcHz0QCOxTaoLxWMLMGa6/gCvOi395Tgx8l6NIEsU42jskIGZqOA2iDqAd
	2f71hbblybxPKZs8Ij1xFQyxJ6twbDMm9VuoXwI6Pl+H+3hLamsfzmY=
X-Google-Smtp-Source: AGHT+IHQclYgGTNcrGkdQE6KHztHSEAN7EmxRMhIRUwOVR1PjCsR1dFXcmnyt3UkRc60/hMJWzQxnw==
X-Received: by 2002:a17:902:e750:b0:223:397f:46be with SMTP id d9443c01a7336-2236926f2eemr186491325ad.47.1740977252643;
        Sun, 02 Mar 2025 20:47:32 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe6cfd9sm7820224b3a.76.2025.03.02.20.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 20:47:31 -0800 (PST)
Date: Mon, 3 Mar 2025 01:48:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: GSoC IIO project: Siddharth Menon
Message-ID: <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei>
 <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>

Hello Siddharth,

On 02/28, Siddharth Menon wrote:
> subject: Criteria for cleanup patch
> 
> Hello again,
> I was going through some of the staging drivers. There are quite a few
> checkpatch warnings under rtl8723bs, but they are mostly styling changes.
> Would sending in patches for these be appropriate?

Maybe. Though, I think rtl8723bs wouldn't belong to IIO (maybe
drivers/net/wireless) so I would ask that question at the wireless mailing list,
linux-wireless@vger.kernel.org.

> 
> I had considered dt bindings earlier as they seemed like a more relevant
> contribution.

I did a quick look at the IIO staging drivers and here are some comments and
improvement suggestions for those.

drivers/staging/iio/accel/adis16203.c
Suggested improvements:
- Use include/linux/units.h
- Drop spi_set_drvdata()

drivers/staging/iio/adc/ad7816.c
Looks interesting at first glance. Not complicated, yet something to play with
as they have a "control byte" to select which channel to read and a CONVST pin
to handle.

drivers/staging/iio/addac/adt7316*
The device can communicate through I2C or SPI so could use regmap API to
standardize data transfers in the driver.
There was an old patch updating to regmap
https://marc.info/?l=linux-iio&m=154853847705361&w=2.
Aside from I2C related changes by and minor clean up changes, this driver hasn't
got updates in a while.
Suggested improvements:
- Use regmap to standardize data transfers.
- Add devicetree documentation.
- Check/change if attributes can use standard ABI and document those that are specific.

drivers/staging/iio/frequency/ad9832*
Suggested improvements:
- Use devm_regulator_get_enable_read_voltage().
- Use FIELD_PREP to set bit fields.
- Support for devicetree probing (struct for device match of_device_id).
- Devicetree documentation.
- Maybe drop platform data stuff.
- Check/change if attributes can use standard ABI and document those that are specific.

drivers/staging/iio/frequency/ad9834*
Somewhat similar to ad9832. For updating the ABI, might be useful to check out
previous patch set
https://patchwork.kernel.org/project/linux-iio/patch/20190225191731.5822-2-beniamin.bia@analog.com/
Suggested improvements:
- Support for devicetree probing (struct for device match of_device_id).
- Devicetree documentation.
- Check/change if attributes can use standard ABI and document those that are specific.

drivers/staging/iio/impedance-analyzer/ad5933.c
Suggested improvements:
- Check/change if attributes can use standard ABI and document those that are specific.
- Better test?


Regards,
Marcelo

