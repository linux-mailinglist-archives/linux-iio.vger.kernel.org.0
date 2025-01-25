Return-Path: <linux-iio+bounces-14585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B81A1C526
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 21:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB39166AB2
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8B18C034;
	Sat, 25 Jan 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzciC3uI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2D7082A;
	Sat, 25 Jan 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737835984; cv=none; b=rnJ9RfY6E8PSAfdELoFhXUR24cJ9xKNAynwHYUJADrXMc4AiuYeFK/+W613n3TYGtfwISsdBrZrwq8n1Cnh6fNU9pNkc7Esn7AucLGHE18bhozmmtRdgeTtkiQDeFhm3L5rIIrnTVDQl4d4/A/GqIH7s/kQNWrqIaCTi6z/tSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737835984; c=relaxed/simple;
	bh=oIE/luzggSg+SV5prRIKuRXqTwWe806A+JTOcPgwTIw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dXMNGK79mHbxpMOCiq+mGCJFWMmq8W9rAYyx4a+49lf4x8hAEE20B+fC5c+m2ttsD3svqN+WmebDg3qDkszHO/b36XzciL/D2nIgLRSS9Z5wp/m78gwtrl1PBMDfaapB927J0gHsYBt7N0KA5b1xcpmOWHyQk8NvvThmFOg7ybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzciC3uI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43675b1155bso36087565e9.2;
        Sat, 25 Jan 2025 12:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737835981; x=1738440781; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13YJcVc1LolRgU0/GI+Bm9q9rkELlwRfXFynSYlwLgc=;
        b=QzciC3uINFStsyNu0CWetUKVFHm5M01SuMoOrGhSSt0TPr+bpo08CeAXRyhiV834/Z
         WuQQC2nfYgci11xLL8lDpV6wIh7cvvoPisUQR0GvEO7zZjYKe9Fl7fGbTmnblZUujjeU
         oKoBPi3aJsSbvl3edp2aJE50m3m/t3wKnmYB8bM1oFMnKADLAiakPeSxr3evlgmMVObj
         Sw6AIDtIg/RDNYT00IAqf7yRghsDZu1ydWQjosaQWusk2DS/6FAeJrs+MV2ufKwY0lyx
         JyJ6IbDBSU/FwzIpafIJeARqzfolaJk1mNxXH8ySlSbHqa9xCrxlZAwF0oKAvTjgVVBp
         zXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737835981; x=1738440781;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13YJcVc1LolRgU0/GI+Bm9q9rkELlwRfXFynSYlwLgc=;
        b=ZS0ceYhn23kzvbv1GGq0mrV9L88GobaGdqVXLOlplSbsgHsZIFKLxNOmofDvIyA0CK
         Ho6wv64iOgx3WQSypjZeYxTcYVoxKFtFkWU/s3S0MP6U1jEiIQuqD42Vrh00MG3mfVrm
         w5zx1P2LGJVZ4S6TFonN1C/HST5Tg+HLt1HZ1+I5FyV58wRH0vB7bY50pLRlK0fvLv4J
         pX0pg/m8i3VIqmF5B2hLymLAnL+yFjZ20PIRwWslqyeQugasNaUZQTrvAOm2vGpTCyaj
         nZhbSc8nugq3GEMYDtQHpUgbAL/trZ2C3dQlN7IHHbI0H+ySoNKpkz2T2lB+dxzwjZby
         Gb6g==
X-Forwarded-Encrypted: i=1; AJvYcCWTIO8lxgKQQnUuDMBcV8VLTtxq/FYfpsI2EV4YlRbX78Qms2eBS8hQQeiZIAelwBX4jCwP5pidUzg=@vger.kernel.org, AJvYcCXK3JpUG1xuq3LMH2OzjmYsnmKLXfh0XmJs/AB5zlzWAu1iapRVkonL0phHyfcLcFtlsSWHPQlzOedNHpPY@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4gQ7yHgzv14j1Gd/euzwsUD4HINKf/+p9HiOMwnNtCfAM88e
	p1lQMhg3JfPSCtXkCKqqs7yTCTnJSQoBJiKh8wam4pipNsT0KV9p
X-Gm-Gg: ASbGncuth+MIm6qRJ9UEd897v0Pt7tMtvcuXsK/EyTLXFHt6SkQY32bfulmtdV0UnHT
	ifopJXcDLNnsMy4/DNNxQsdN2+hfOP8eNM5WcliguZzM3MIrxBGqMuI1OCdnehLBHCeA8EEBfwS
	s0h2ZCok498yw302jpVOn5rD1PTGAaEYUSbaqjymfZPWrYIhFVOWlCsnjLCslmg3uEDf5P4E+k7
	6UCup8pIgzXHozFntM0rWvBHCWDNPt28m+s0/7aqwCMroaFE3Rp8JM58hOJkSuZ5EfIfkA5tZ2a
	eF2zyWrV0E274LMjQmq5YbjbIkOIP8VicsWESKsTOKm4f5KbNI5So7NmnUouknI6i1oAFBp/NjD
	DRI+r16oiygMbM854In4ESFEk
X-Google-Smtp-Source: AGHT+IHTWKQZWwUDeNAxaBfQhn+envCpJ1DtECbFfi/4BdptPWdWb06D6ivAjpMEQ29H/y6udAaV1A==
X-Received: by 2002:a05:600c:46cb:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-438913bebe7mr331817225e9.5.1737835980758;
        Sat, 25 Jan 2025 12:13:00 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-30ed-5dd1-b777-da06.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:30ed:5dd1:b777:da06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd575848sm69322495e9.37.2025.01.25.12.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 12:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jan 2025 21:12:57 +0100
Message-Id: <D7BFFUH97D61.25C1T8JHA8WES@gmail.com>
Subject: Re: [PATCH v2 0/4] iio: light: fix scale in veml6030
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rishi Gupta"
 <gupt21@gmail.com>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Jonathan Cameron" <jic23@kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
 <20250125123331.646e8cf8@jic23-huawei>
In-Reply-To: <20250125123331.646e8cf8@jic23-huawei>

On Sat Jan 25, 2025 at 1:33 PM CET, Jonathan Cameron wrote:
> On Sun, 19 Jan 2025 18:31:57 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
> > This series follows a similar approach as recently used for the veml323=
5
> > by using iio-gts to manage the scale as stated in the ABI. In its
> > current form, the driver exposes the hardware gain instead of the
> > multiplier for the raw value to obtain a value in lux.
> >
> > Although this driver and the veml3235 have many similarities, there are
> > two main differences in this series compared to the one used to fix the
> > other driver:
> >
> > - The veml6030 has fractional gains, which are not supported by the
> >   iio-gts helpers. My first attempt was adding support for them, but
> >   that made the whole iio-gts implementation more complex, cumbersome,
> >   and the risk of affecting existing clients was not negligible.
> >   Instead, a x8 factor has been used for the hardware gain to present
> >   the minimum value (x0.125) as x1, keeping linearity. The scales
> >   iio-gts generates are therefore right without any extra conversion,
> >   and they match the values provided in the different datasheets.
> >
> > - This driver included a processed value for the ambient light, maybe
> >   because the scale did not follow the ABI and the conversion was not
> >   direct. To avoid breaking userspace, the functionality has been kept,
> >   but of course using the fixed scales. In order to ease the
> >   calculations, iio_gts_get_total_gain() has been exported to avoid
> >   working directly with the scale in NANO, that would require 64-bit
> >   operations.
> >
> > To ease the usage of the iio-gts selectors, patches to support regfield=
s
> > and caching has been included.
> >
> > This issue has been present since the original implementation, and it
> > affects all devices it supports.
> >
> > This series has been tested with a veml7700 (same gains as veml6030) an=
d
> > a veml6035 with positive results.
> >
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Whilst we might consider a backport eventually.  This is a huge patch
> to do that with.  Hence I'll take this the slow way for next merge window=
.
>
> For now I've applied patches 1 and 2 in the interest of nibbling away
> at what we will need to see again ;)
>
> Jonathan
>

Thanks, Jonathan.

Could you please tell me where you applied them, so I
can rebase onto that branch? I did not find them in linux-next/master,
iio/testing or iio/togreg. Or should they show up in one of those
within the next hours/days?

Best regards,
Javier Carrasco.

