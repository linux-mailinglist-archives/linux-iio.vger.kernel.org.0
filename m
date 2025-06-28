Return-Path: <linux-iio+bounces-21098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C97AECABE
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 01:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F15918993BF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2E22156A;
	Sat, 28 Jun 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aB+VBA84"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334CF41C63
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751152167; cv=none; b=nDFpNzyeR2SoAqkas2Osz/Jk5fC4sL9uv2uT/TXLPzFS054QA2gKA76F9uvvJZx1usCclCNzGFOXuy0LLeO3OquidnXYpy4rxbT3uqF6aHNo3DR0vbaP/iyI77BtCUyaE7DarIwCic8wyCYT3GupNZtrxdY5UAPFz32T3xTTApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751152167; c=relaxed/simple;
	bh=MRVUCRgUFnRXsc4X+ViqiuHCZ39s/cTZH9WQss8R5oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC3MwS3kLGzVaLEf4omUkTG0C/P8Lan5H5qN2ulGzm1boFn8vdLQYCH1XF2qRDUtb3cSrnhFCErfRfyyTEJtcA8dzev+z2zfFOvWRgYRZJQzaU66ATK3qbtcTQxh9AD//zEhmjQD9ToM8Ufb2AGa8gxwpok+Qbw9/Q9Cjiauasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aB+VBA84; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso952800b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751152164; x=1751756964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RghmK7bwNQ0kQhbtW4wZXNGWIk0IsY2NIzalhOt1CU=;
        b=aB+VBA84RtbtKhyqUkWegdf7BAmKr13bI4PrAxXtcsP04iHe3QzGOtq4uzS9n//fiG
         yOQ8zYK3EUw5b1evRDMBl+D5wlGFOafop9Fq/Qs1VVMR26TeaqPG+ur7x0cpGJfECA/q
         lpyT7wTx1jiP9HufZySfmk+XzOIZBFZykzjUqTUaN8b0m/GMhrxs+WJvJ2r+I9ICV2vl
         IpAcgvX74ysMJcgXL6C4AGg/lCvtZytsBL6gMXY9iGNZuCa+6d+dg+w/Iufn9rCaM1dX
         gg//InLgNl6pMfNOpvAwUtvZp1TcmiQ4hvmqTsSSqqW0ogbf2p1DxQ2NlHI0kNTZ8znU
         6Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751152164; x=1751756964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RghmK7bwNQ0kQhbtW4wZXNGWIk0IsY2NIzalhOt1CU=;
        b=KQDbAYcCtBK4Z4CeLr4kc/9o4kU7z9AGsf8Bu5HYOEq70CYlQ46O5mupm5RcxNCn6W
         Qb2tPuTiBXPpA0GelHua885SWb1SVZfYwkGbdvwW/lQgpg3+POO7MhbzkDJjahEBO0yp
         mTdPc5bl1zEKBqJLAUhclKTBvKWFnGHJz8azncHjD7jPww6J0LaV+MiTO9Hq9EVNzU1F
         lZHz4CyJp3HTINQ/8UObTDDbnUsguLGEDVekPkSulqiSqunqVOuP+0TM9oB6H2G6794J
         h+UganeL8eoGlCs7bZo6gM07AiieDALUUJTWr5Tzfqtt71e7sNAVjIs3UKkD5UW50X2U
         PtYw==
X-Forwarded-Encrypted: i=1; AJvYcCUiJDVtIocqoZkxx7xAitEezffmFfBQzHF6jeNBJsrHAE+eqGiA6q/cmQ6PRv7L9YC4s0T7lJQavIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cXJ10nGkLrz4F/7Xya/+6SNcpTk/FbUURc+0a60SEadYyhPT
	1G/ptoEljDQ/RlHXpmZUPQTpncebER57m+dbFt43uXZyrsNaVnmcpTNurAV9SJprSg0byizdrto
	tt3pY
X-Gm-Gg: ASbGncshjY67ddn8uypnuC3pzK9tBzp6AXLqREP2hjUHx3HXsv3UqGJ7bk0jC503np0
	xvoUEr8cqWXnfGRc5rejO2xIPgOQzARQPEszJUR0SQKw1ZZh5sztuWoke8h11DvqQ2Fh2Hy8l6m
	WS7u8Dr+vvb/t26ITlz1B4ymPvHULfgX5wxveA4vnnj5lI3xheO2r0XfwBOpq7krBGOhrNKRw8m
	x2Upbzc1w1N/kZpcRPY3HBpKNasAcBQ/GzcQYVz+EPXvbjvr2cM9UzIg7eO70hjnFeGcFG8I5v5
	JKit3mOTmHc0FHRoMyKBYDs3kmwAPLrcxCFBh4t8Nx8lxINM5djtdEyRltn8c9oRPXbXjM0Ozfj
	ElHGBeErtZqvrqCCLXFGTxg==
X-Google-Smtp-Source: AGHT+IEkgXTCk2sJOs74/1zzhIFRegzigXwVLQh/vGpG3wmqlsyEARN48cwxen3DleajyDV5uKnKgQ==
X-Received: by 2002:a05:6a21:6d87:b0:21d:fd1:9be with SMTP id adf61e73a8af0-220a12d79demr12927327637.12.1751152164483;
        Sat, 28 Jun 2025 16:09:24 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31beab2sm4612049a12.47.2025.06.28.16.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 16:09:23 -0700 (PDT)
Date: Sat, 28 Jun 2025 16:09:10 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <aGB2Fnv797Wrenza@dev-linux>
References: <20250614091504.575685-1-sbellary@baylibre.com>
 <20250614091504.575685-5-sbellary@baylibre.com>
 <CAHp75Vf=zQ+pdo5V1fAq2qWEpdUfNfWdO+_iW0wETWSniXisyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf=zQ+pdo5V1fAq2qWEpdUfNfWdO+_iW0wETWSniXisyA@mail.gmail.com>

On Sat, Jun 14, 2025 at 09:45:43PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 14, 2025 at 12:15 PM Sukrut Bellary <sbellary@baylibre.com> wrote:
> >
> > The adcxx communicates with a host processor via an SPI/Microwire Bus
> > interface. The device family responds with 12-bit data, of which the LSB bits
> > are transmitted by the lower resolution devices as 0.
> > The unavailable bits are 0 in LSB.
> > Shift is calculated per resolution and used in scaling and raw data read.
> >
> > Lets reuse the driver to support the family of devices with name
> > ADC<bb><c>S<sss>, where
> 
> I believe it's incorrect, i.e. it's something like ...S<ss><?>, where
> <?> is something you need to clarify, and <ss> is definitely a speed
> in kSPS.
>
Thank you for the review.
I am not sure about the last s in <sss>.
It could be TI's silicon spins versioning.
I couldn't find any information about it in any of the datasheets.
I can drop the last s or mark it as <ssx> and specify the first two <ss> as
maximum speed.

> > * bb is the resolution in number of bits (8, 10, 12)
> > * c is the number of channels (1, 2, 4, 8)
> > * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> > and 101 for 1 MSPS)
> >
> > Complete datasheets are available at TI's website here:
> > https://www.ti.com/lit/ds/symlink/adc<bb><c>s<sss>.pdf
> >
> > Tested only with ti-adc102s051 on BegalePlay SBC.
> > https://www.beagleboard.org/boards/beagleplay
> 
> ...
> 
> >   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> >   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
> >   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> 
> Forgot to sort out in the previous patch?
>
I will fix this in respin.

> -- 
> With Best Regards,
> Andy Shevchenko

