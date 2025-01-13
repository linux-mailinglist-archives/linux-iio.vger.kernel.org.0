Return-Path: <linux-iio+bounces-14273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F545A0B501
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 12:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90D5167871
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E522F159;
	Mon, 13 Jan 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju1UQiXv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECB22AE5E;
	Mon, 13 Jan 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766183; cv=none; b=piu8A6ynIjq+6yV0IpS+Du9o+4DBGruN7St2ze4gv0kBzHR6Lq8ba+E9zJsHDPHXaDDPoMVNvuqnSQcVf7zrRRiE8OyEg1kYSHnyEnkm2COnp+NXnxteaYROaNs6u6nzO6gJDHVyCpYtj0CAKPDWEgwMnpYx+U8otkX4SwVAtrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766183; c=relaxed/simple;
	bh=Wr2LRE/pmrYAVG0jbKHh4afociWhY2Hx+KPsaAnAA7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BVeTOjIlLs7cQpF8NfjGNYBglYI4g3XqgRGCsBoG81DwICR0DYUp/T+adnybUxZuDXxId/2XsIRx1wkmyKmlKvWlt6Mo6uIpDXX9siPW2ZiDTha5Ttjjx9RrNa0uYDNWgndnOENGAZKF6DtQjhfQ62oNebhr9PVjNiRNKN1upYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju1UQiXv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso43596875e9.2;
        Mon, 13 Jan 2025 03:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736766179; x=1737370979; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OO0Vmppvf4EcSCM4ye8lfOWM/qiRf6EIEwUmakPgPS0=;
        b=Ju1UQiXvy9s99kmmhT2kCpV75pGZlcqNCTFubk8H2AXE6kW6m+m0T7goCkYruihq2b
         Y9ldSeepOBuuli1+TvqEtfu+lIct9O3201s1C5lcgb7WXUW7s/NMRKbIdhIueehqx9Z7
         1AniIPv7h/YYoFuW4YhKFvJwsOlJuJM1mmlBk0m3Z0dcvh0BbYRVSt6gAcsb5MhiJWnY
         fiq5tFOOn7C6w2l20AKrqn5dWfjsEvjwb/72yDL0YGnp91ucUe6sgVnyEAEgRcyckmLM
         iHAsGuEkrX7pgsonfdwxxsSs+cbrj/uoWCm5FUHv2OSoVmi4sE38PGfsjHDudIvbhFHZ
         cHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736766179; x=1737370979;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OO0Vmppvf4EcSCM4ye8lfOWM/qiRf6EIEwUmakPgPS0=;
        b=k+dxp2nnV0Pq0mWWlqIAwE1i3k8WQQA9g5RDn41a2yT1sLgl70kJSxaddKortlc/ti
         VGmc2EDDD+C/ShZmXRyqBmSSFj8VFb0Vke+ag18iXx29MTGf3xEJ3+/biMmCAIpVrBUP
         SN8uqFCX8T7c3HAJX3UmJEIk5nXYbX15a8y56Je2TTZje6XwmmV4XJOZBUVDhaBNyv5/
         xV+XjoGyON5dGZiZUHBCknMZ5zb606v2BOk+Lz9havAqYh8rQbEazaq8v+9jf1Hm1gzU
         a19xTLnmo4zIddM55C41yv0d9FrFJ1NnqGk5H0UmSW+WNxKK6QDeI81o/CZRYm6Aw5EZ
         HtGA==
X-Forwarded-Encrypted: i=1; AJvYcCV1R2X/k22E9l0yRXi/qDfu1qWKZNWucbwZQU6CpklYgLiq5WXK3iR36aARjfoCjuL3Z3uW8OpavRblzoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ecqs8oFiqpM963tNwxN8wuhuuqMKe07ajb1/R5O2q94mS6hD
	Rp10DSmOSptCQaXRukSSQuLxnlrTolQKNxbGYLcfHBqHJ9ljaCYT
X-Gm-Gg: ASbGncvXFTVwtke9JR8D5g2j2dLr06a2/etC3p3xfS1YP1ipABRltJJcsEDIyHI5d6D
	5vbpyVWBY4j81jAKi01ENKBbz9kxf8g/jOj6khyAJOJVunnc3tOurrA3Oj8ZZ1lgZaM/lD6UNpb
	EceYjzDoIr1dxDpjFmrQADtzIc/6LDV0Y2fwQ3VtJNU4UxrB/a0YH+QsaZkZbETdw8bYqhgsXpW
	8euL6b/8WtviiSGMa9vO1LPXNQqQpc/PyHYhHEehDuzZWIjKqnDsvwHnKhGT5RnvnIH0mx6TywA
	UVyeIxHlKfEiNpgUAxkDRtEtzcF5aA==
X-Google-Smtp-Source: AGHT+IFcLxs44/sDHAbJZetje//tTaFSPM9aAstVOCB93p11w28SiGoFL4wxLYruwp5df9BaVvxkgQ==
X-Received: by 2002:a05:600c:3c94:b0:434:fd15:3ac9 with SMTP id 5b1f17b1804b1-436e26e2563mr159330755e9.22.1736766179297;
        Mon, 13 Jan 2025 03:02:59 -0800 (PST)
Received: from localhost (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92794sm172475795e9.37.2025.01.13.03.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jan 2025 12:02:57 +0100
Message-Id: <D70W87IM1EWE.V84CD9QKDITR@gmail.com>
Subject: Re: [PATCH 0/2] iio: light: fix scale in veml6030
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rishi Gupta"
 <gupt21@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <25d5ff51-8a1c-4e34-9f0e-e11778313d8c@gmail.com>
In-Reply-To: <25d5ff51-8a1c-4e34-9f0e-e11778313d8c@gmail.com>

On Mon Jan 13, 2025 at 11:25 AM CET, Matti Vaittinen wrote:
> On 07/01/2025 22:50, Javier Carrasco wrote:
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
> >    iio-gts helpers. My first attempt was adding support for them, but
> >    that made the whole iio-gts implementation more complex, cumbersome,
> >    and the risk of affecting existing clients was not negligible.
>
> I do agree. If one added support for fractional gains, it should be very
> very clear implementation so that even my limited capacity could handle
> it :)
>

I am working on another driver (veml6031x00, I sent a v1 with the same
flow as this one, as it inherited the gain configuration) that will
probably need some more tweaking to work with integer gains: it starts
by x0.125 like this one, but then it provides weird gains like 0.66 that
prevents a simple x8 adjustment... I will try to scale up and down instead
of adding fractional gains, though.

> >    Instead, a x8 factor has been used for the hardware gain to present
> >    the minimum value (x0.125) as x1, keeping linearity. The scales
> >    iio-gts generates are therefore right without any extra conversion,
> >    and they match the values provided in the different datasheets.
>
> I didn't look through the patches yet - I'm getting to there though :)
> Anyways, I assume you don't expose this HARDWAREGAIN to users?
>

That's right, HARDWAREGAIN is not exposed. If you believe that it should
be exposed, I am open to discuss.

> > - This driver included a processed value for the ambient light, maybe
> >    because the scale did not follow the ABI and the conversion was not
> >    direct. To avoid breaking userspace, the functionality has been kept=
,
> >    but of course using the fixed scales. That requires using intermedia=
te
> >    u64 values u64 divisions via div_u64() and do_div() to avoid overflo=
ws.
> >
> > To ease the usage of the iio-gts selectors, a previous patch to support
> > regfields and caching has been included.
>
> I don't see why iio-gts would need regfields? (I have never been able to
> fully decide whether the regfields are a nice thing or not. I feel that
> in many cases regfields just add an extra layer of obfuscation while
> providing little help - but this is just my personal opinion and I'm not
> against using them. I just don't think the iio-gts needs them to be
> used. AFAIR, selectors do not need to start from zero.).
>
> Yours,
> 	-- Matti

For me, using regfields makes everything more straightforward: you
define the shifting in the configuration phase, and then you can simply
assign the selectors to the field, with the same values as the field in
question would expect for a given configuration (0 is 0, 1 is 1, and so
on). I see that easier than thinking about register-level values, that
are easier to get wrong.

Once you have defined your regfields, you don't have to think ever again
about their position. Actually, I think that iio-gts works perfect with
that approach, even if its father is not a fan of regfields ;)

Thank you for your feedback and best regards,
Javier Carrasco

