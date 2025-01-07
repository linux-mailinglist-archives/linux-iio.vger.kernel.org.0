Return-Path: <linux-iio+bounces-13953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23125A03A3C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 09:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B6C3A3775
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34361DFDBF;
	Tue,  7 Jan 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G2cCdtbj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312133CA
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239897; cv=none; b=s9YVExMHU9Kvj9VZXEeXEf0ThgQhDf4IQBau863MXTl/sWq27Bdw58MWA0c3gNPBfvBaGsOVfHEEs4ipFO6RZFoIczwWbhWZIWfPGvpH48UhzqIAp4O3bYU5arn5uyi/O/vH7uS8447xGeJduXWMfj4dwYYsVKHkMPBEqiXSF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239897; c=relaxed/simple;
	bh=FmBULqY9alLp8d+GTGqYk0NziFVxOyBNAsCFJrTsjus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7yIJJp2i2Q478azCA3w/eX3ZxOokWV3pXhnzJlHD+5HzcAyDejDnRm386Lh4yQt0H5QqopIoWGR0ESt2/XAViTVOCqoiwFc63e+L6QJqsj3XaYUHGOWpO5jJmWQNOb2vdB9+VC5HQmKNSubdOe77oYhhSAS8L1jmZyyCwbL3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G2cCdtbj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso26752241a12.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736239892; x=1736844692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhlC61/Vg4ptYrQVqTalA4DHgqPi+NyL1l7e0TmM9w0=;
        b=G2cCdtbjdJIC3KXUCrWuv+idkDf6JiObXwEXbOPjAiuA3W0bVSx0nlcdy0yInmWObs
         GwAElsHb0l3lG2OiK2Th8DrFweJIRjmWFDeMdW8czeDDi2q7rMiXgG74eHxuopf8XHuL
         bBZwpCq4Y3WIxGS8AUAx4eUgZYtJseu+BeHnswFQsLfswAT8TWd8/yCLPrIi1NCYEYKl
         BYuR8uILUF3o3RFfYErAL13oMBKTpIlX1k2isLJnfEyAaNIvqlTDGD+ikyZV4R6IoG+f
         k/i7k+yOM1HJ0kt8sqiesUeT+5tg2A6L5CJyyLTzvhXyr2dlXugnkTsspzVpbgafEIkD
         rWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239892; x=1736844692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhlC61/Vg4ptYrQVqTalA4DHgqPi+NyL1l7e0TmM9w0=;
        b=Yk3VdMdmVgzBsh9uMmoQpScCvzkjX4a0DXdQ1s+lDiANEbDcRXlNSxVw8bq9SUOu1n
         WI1L4bDcJ/BiEjsy3yUBZhcNtZUFNXogVx6mkgQGOfsf31dZrALaGCCweUyrVzqGFvsJ
         +8tXxMNa/WIOWtuD70i8quISJKLszof3kA2oehqHo2YC/8ZZ7H54MJOdG4Lt+BwFxe1U
         6TONGIU6790LKuwCvhzNi9K3UN9CL5nB4KvqlAXCH5VqHX7ovM/JnirS8sQuDZuQ/KEN
         SXfA3ra29x/j3GTWktseKdPkRQHyBNNfhiqoXP38M8CElfdV+191fch4UszLn947i4Ap
         h7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXjhLgdKAw2M6bHXETX9ZW8asysLG0N57fYOsbzawwDX5rD90Npn1Wa5fNQ0ZHZckrvPZzgDgYCTuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPTgGNubAYEQZE5B6p58qdAlayznhLhxhjfYhdmvqoGlk+oPw
	1ZHC9fiLqgLheJIKu4FTprrLW+nNsHLnxbHI8qLVHZj7VMDTkOaWdE8oVwZKAJJ2b6nD8mMte96
	DZiL+J9zvptwyYhy7PGcYVTX8zvEg7f8QBnQc4Q==
X-Gm-Gg: ASbGnctpZ/zPO1knND8Vt0IFAFzazW46wlo394L+bb7YEaDDTcIkXJfDNREikUuRqCF
	ePG4OeOJynqPuYEY11wJSoa6Lto3wuFidoE1R
X-Google-Smtp-Source: AGHT+IE8dAAPByPZ1ICsZb09vPa6RulR3AkN+SEZ3EWISmJKgqoMt6BVW0u/OXnTgEZt3uRnqtYTJ9jNbbAFWYpEBQg=
X-Received: by 2002:a17:907:704:b0:aac:23db:af61 with SMTP id
 a640c23a62f3a-aac2874937fmr6090693266b.3.1736239892555; Tue, 07 Jan 2025
 00:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
 <20241224-ad7380-add-alert-support-v2-3-7c89b2bf7cb3@baylibre.com>
 <20241228142457.576f47d4@jic23-huawei> <4be16272-5197-4fa1-918c-c4cdfcaee02e@baylibre.com>
In-Reply-To: <4be16272-5197-4fa1-918c-c4cdfcaee02e@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 7 Jan 2025 09:51:23 +0100
Message-ID: <CAEHHSvb_BRB-ygksULL4+o4eFEPSC4zOs1yBptFd8QzZtS0Dhw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] iio: adc: ad7380: add alert support
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 6 janv. 2025 =C3=A0 16:29, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> On 12/28/24 8:24 AM, Jonathan Cameron wrote:
> > On Tue, 24 Dec 2024 10:34:32 +0100
> > Julien Stephan <jstephan@baylibre.com> wrote:
> >
> >> The alert functionality is an out of range indicator and can be used a=
s an
> >> early indicator of an out of bounds conversion result.
> >>
> >> ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to a=
ll
> >> channels.
> >>
> >> When using 1 SDO line (only mode supported by the driver right now), i=
.e
> >> data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
> >> used as an alert pin. The alert pin is updated at the end of the
> >> conversion (set to low if an alert occurs) and is cleared on a falling
> >> edge of CS.
> >>
> >> The ALERT register contains information about the exact alert status:
> >> channel and direction. Unfortunately we can't read this register becau=
se
> >> in buffered read we cannot claim for direct mode.
> >>
> >> User can set high/low thresholds and enable event detection using the
> >> regular iio events:
> >>
> >>   events/in_thresh_falling_value
> >>   events/in_thresh_rising_value
> >>   events/thresh_either_en
> >>
> >> If the interrupt properties is present in the device tree, an IIO even=
t
> >> will be generated for each interrupt received.
> >> Because we cannot read ALERT register, we can't determine the exact
> >> channel that triggers the alert, neither the direction (hight/low
> >> threshold violation), so we send and IIO_EV_DIR_EITHER event for all
> >> channels.
> >>
> >> In buffered reads, if input stays out of thresholds limit, an interrup=
t
> >> will be generated for each sample read, because the alert pin is clear=
ed
> >> on a falling edge of CS (i.e when starting a new conversion). To avoid
> >> generating to much interrupt, we introduce a reset_timeout that can be
> >> used to disable interrupt for a given time (in ms)
> >>
> >>   events/thresh_either_reset_timeout
> >>
> >> When an interrupt is received, interrupts are disabled and re-enabled
> >> after thresh_either_reset_timeout ms. If the reset timeout is set to 0=
,
> >> interrupt are re-enabled directly.
> >> Note: interrupts are always disabled at least during the handling of t=
he
> >> previous interrupt, because each read triggers 2 transactions, that ca=
n
> >> lead to 2 interrupts for a single user read. IRQF_ONESHOT is not enoug=
h,
> >> because, it postpones the 2nd irq after the handling of the first one,
> >> which can still trigger 2 interrupts for a single user read.
> >
> > After some of our recent discussions around interrupt handling and
> > the guarantees (that aren't) made, even disabling the interrupt doesn't
> > prevent some irq chips queuing up future interrupts.
> >
> > https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfr=
s3rz2a2@orquwgflrtyc/
> >
> > I'm not sure this alert can actually work as a result :(
> > I am struggling to come up with a scheme that will work.
> >
> Would it work if we change it to a level-triggered interrupt instead of e=
dge
> triggered?
>
> Since the main purpose of this is to trigger a hardware shutdown, perhaps=
 we
> could just omit the interrupt/emitting the event and keep the threshold a=
nd
> enable attributes if we can't come up with a reasonable way to handle the
> interrupts?
>

Hi Jonathan, and David,

I think this is getting very complicated for something not that useful
in practice.
If needed we can go back on this later to find an appropriate solution.
I sent a non RFC V3 version, removing the interrupt handling? Does
that work for you?

Cheers
Julein

