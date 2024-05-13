Return-Path: <linux-iio+bounces-5009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D18C43F3
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 17:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3479F2872BE
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8856B9D;
	Mon, 13 May 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vg2uyfnY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A956459
	for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613369; cv=none; b=jMgveiVgkfefX/GJWxt3eU/tXqqQE1ENmV2kRU9Kix4NB5ZzJi/zX/+ax+XysTrIPJ4XWSk+7dQj90NT8dtiVAVCc71uoIlGFkuPbaUXQvRt8bwNVPd25lZ1c9PYfRX+bp/w2e6V9I4H28Y3GrjfCMOW48EP/f88vAIfViKOpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613369; c=relaxed/simple;
	bh=/v6zZK8vC1iWKChJg5ELITID+E0oYkoNv1bfMOqpejI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZ6R0Ai7TIGYCXXehhohQ0N0VDKgdUONZc7HwgaNZGE23k/S7fMRKYwelbty04Jd5K+QQdbp4pvH8oFzjhwae5YHbq1Oxd2FwzHiH1937EBKbPRDYN5mWsthrspY8+/3MIw1G3V4umckCspJjm3VMw1sL5X2V4XsjZ3KvyCrloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vg2uyfnY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e271acb015so58151971fa.1
        for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715613365; x=1716218165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXHSyWB6fJ4bI4UOzHNSJAK2n7Pmu648dfIJZfg2RtE=;
        b=Vg2uyfnYQWnV59dji9In+wfBSNsCejh0Z+Dw96/imVYb6ssAlSuNPPuEnqJJpmzOcj
         PldL5hSFA749LMtYihYpsZsiF0SImByQCLesVZAdDZPnz/qKgWcEGdwjwIdOgdFCjLuP
         dvf3RdlWtCxB3iLnCkYqSYrbvzSKq/NISW+A+PidRQzUWTgElcQZ/HnKzaiMBIrV8zx3
         /1EMAUMpgKk/VgKZXLE3uW+cZSCeuX51Ra6yGSqNPWAfeLWi8iHs/9UX721/QqA1ReoA
         mC3HTpXFI9kaDY8sI47OjqjxjoLDpcoTaLwqePegOBFb1XBAmB9evtB2qm+QcepFICkA
         2vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715613365; x=1716218165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXHSyWB6fJ4bI4UOzHNSJAK2n7Pmu648dfIJZfg2RtE=;
        b=cePpdTjRJXJx4g+BTQADBy3fWNqbtJa3Y4pu+AlUb35zvHZ0+A+pIz+k7oIPCiqYWa
         a3LVySnSTVi7z5jyNP6Q4jZwGWbWMZDkaFAAAVrhLidxAgfaktZRPh54I38QPbNAV9lF
         Lrh0NQCJhdx+T9FynaxT/z/xc1xH8u4C0iuKDntwutqXdXztzpiTV4p1ojKeCMh5zQag
         WmsU3nq/pIT9F9aWMzWou4NUFG/ebb5tYTGJTKeOJCIwZnAz9sraPuHQBODFtA8QJXlw
         UltubgHVr0/CU6yosRsqA/2A1aTR1syxYwxUuUDFEW34Hxunroo0owxXRPale4XOn005
         X0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnH49pQnPTy99mAUYZLL2QtpsbL01SH3pXQQz/9qa256L71ra88Yk6rgt10RGfj2xIUdUGa16+vR7TkBFuSCzwVnm3dysdgNPt
X-Gm-Message-State: AOJu0YzlFTz5QhqSNGg8uagO36oMM3k/Iy+0AuFe/0B7HeNU9YyNscE7
	KZBe5CHuIKwXTHoCoy32RyjS8pnY4Q0OO70rmbPso64A7zc5eRk8W9DFZq2FoW0ZTA7gBfcoX8F
	c9PGcIaPHNsXPLAXKxFIerMVq8DnMNTpypXqHYA==
X-Google-Smtp-Source: AGHT+IGKijrN67shG2KPnM4VRi/Q9YI0q+7SOQY6GvY0EJC5mkeXMC97pzJgBqg0pSAdaBuhfs6XNl1xEroVw6ed6J0=
X-Received: by 2002:a05:651c:d1:b0:2e0:c6ec:bcc1 with SMTP id
 38308e7fff4ca-2e5204ac486mr60438181fa.45.1715613365410; Mon, 13 May 2024
 08:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-8-8707a870c435@baylibre.com>
 <20240511175832.6c2f6517@jic23-huawei> <CAMknhBGG9bYwzPw8woaR_YaVRW+wpT4W1KpHzG32nWj9Qi7fig@mail.gmail.com>
 <20240512125202.312d0576@jic23-huawei>
In-Reply-To: <20240512125202.312d0576@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 May 2024 10:15:54 -0500
Message-ID: <CAMknhBHMz2OEVGC_e44zoKz6+WLgP07KkOOMbxb6_bidXRm2Bw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 8/8] iio: adc: ad7944: add support for SPI offload
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 6:52=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 11 May 2024 13:41:09 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On Sat, May 11, 2024 at 11:58=E2=80=AFAM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > >
> > > On Fri, 10 May 2024 19:44:31 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > > > This adds support for SPI offload to the ad7944 driver. This allows
> > > > reading data at the max sample rate of 2.5 MSPS.
> > > >
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > ---
> > > >
> > > > v2 changes:
> > > >
> > > > In the previous version, there was a new separate driver for the PW=
M
> > > > trigger and DMA hardware buffer. This was deemed too complex so the=
y
> > > > are moved into the ad7944 driver.
> > > >
> > > > It has also been reworked to accommodate for the changes described =
in
> > > > the other patches.
> > > >
> > > > RFC: This isn't very polished yet, just FYI. A few things to sort o=
ut:
> > > >
> > > > Rather than making the buffer either triggered buffer or hardware b=
uffer,
> > > > I'm considering allowing both, e.g. buffer0 will always be the trig=
gered
> > > > buffer and buffer1 will will be the hardware buffer if connected to=
 a SPI
> > > > controller with offload support, otherwise buffer1 is absent. But s=
ince
> > > > multiple buffers haven't been used much so far, more investigation =
is
> > > > needed to see how that would work in practice. If we do that though=
, then
> > > > we would always have the sampling_frequency attribute though even t=
hough
> > > > it only applies to one buffer.
> > >
> > > Why would someone who has this nice IP in the path want the conventio=
nal
> > > triggered buffer?  I'm not against the two buffer option, but I'd lik=
e to know
> > > the reasoning not to just provide the hardware buffer if this SPI off=
load
> > > is available.
> > >
> > > I can conjecture reasons but would like you to write them out for me =
:)
> > > This feels like if someone has paid for the expensive hardware they p=
robably
> > > only want the best performance.
> > >
> >
> > For me, it was more of a question of if we need to keep the userspace
> > interface consistent between both with or without offload support. But
> > if you are happy with it this way where we have only one or the other,
> > it is less work for me. :-)
>
> So inconsistency in userspace interfaces can occur for many reasons like
> whether the interrupt is wired or not, but in this particularly
> case I guess we have ABI stability issue because there are boards out the=
re
> today and people using the driver without this offload functionality.

FWIW, the ad7944 driver will be landing in 6.10, so no users to speak of ye=
t.

> I'd not really thought that bit through, so I think you are correct that
> we need to maintain the triggered buffer interface and 'add' the new
> ABI for the offloaded case.  The multibuffer approach should work for thi=
s.
> Will be interesting if any problem surface from having two very different
> types of buffer on the same device.
>

In this particular case, I think the issues will be:
1. The hardware buffer can't allow the soft timestamp. Otherwise, the
buffer layout is the same (on other chips, we won't always be so
lucky).
2. The hardware trigger (sampling_frequency attribute) will only apply
if there is the SPI offload support.

