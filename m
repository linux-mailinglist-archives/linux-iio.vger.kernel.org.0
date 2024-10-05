Return-Path: <linux-iio+bounces-10184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26152991888
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFFEB214DC
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A7158558;
	Sat,  5 Oct 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh3A3nBj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC52F5B;
	Sat,  5 Oct 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147384; cv=none; b=KPyDuewNDPCVE3kb0KIPhB9nxMR5JNcq29V+izaOY69udgpKkbomXZqCQqPrrYLZX12EhgLT8bntneR1L6ly3UZm+23OB/dGe02LHuTeX3Pn39I2iUB8aXRunR0PWutqoGo7C3kb6t7VywXFO9AEf5RZeYcO30ENjuWf981zwnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147384; c=relaxed/simple;
	bh=fWd6p0uW3RY2ko3T7S5XirHw5QwEXfeDYE0Z4Sd0P/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXujYPdASQ9fvZZlTgEnUeXX2nz1q1dxEebwNe4mddOGh36+zhSBdZ3jQY3xLa2IznEZgEhUQNDomnviHeZfdDC5IiAWCKZGqLU/buy/GToEUFp1md3WvmMWn2334CtZ3vxk95c+K5I7xpGOQwnuXdHD7ygv5qYjojNVRX/7bJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh3A3nBj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso33069331fa.3;
        Sat, 05 Oct 2024 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728147381; x=1728752181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ylKNLAvNwsO2ttA4i+GZf2R8FUA0B3NBTmfOn2Rroo=;
        b=Dh3A3nBjy4iwKFrJL4WcYf45tGLPd2Ep8BK5L6C6by+Vbgjry605ZYGYNoIJ3v1mJG
         OXZlsX0VzRRO4jhRuVISvP4HSSxtQ/ksjSZIZU2tbXnpM5SSiqvdTmGpbpjBJlnwmCYE
         GuT2tSaYDG1lwDuwjBJfL9cRN9PX0GDiCaQFzep0Jp4o6rrfs5rwHoMhgvgr4vdTbWC+
         eXDMYhf4uzPNGR70CiE2oD51hzdE2xltymGw5C9in9t0CgUfe7btrt7Ylx+YbNHwUSEr
         EwFwzJ26PvsfNZb0w9w4aPu1bT/O23GokfBMgODOw2qzMtsoX6Bms6nEBFk9d2lpT3+x
         Q+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728147381; x=1728752181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ylKNLAvNwsO2ttA4i+GZf2R8FUA0B3NBTmfOn2Rroo=;
        b=uYUjwpl7z5bcOI18muGu4ZyCE3773O5ntArTbnZovIpXI2M3TpUFfBCz2JIU8Es6MW
         eaXCGmqxDqRRgVFVZaNh6UCjoAhe7B4Gajt2N0sgeVGEi56eYiFyVnJHZXZxjmU09YUz
         i3BwEgKezmc96IJp5sH5aReH4yzU7+1Cxv940HD5rLbpMdCRkQlT1NxqtMuF6wwGyMyA
         /Iyjqt8YITdYCng5mkjWAs9is2YwbcbIkrRAnFHWCSGUyvCCdNfWHfCG6OASS1fvfQFu
         mS3aiGupY07A2pRZ2Oi49sv5WmqFS5nnyfURp70D1n1EM8EaeuHW4yomBSLRS33fHx0q
         nQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkw/zWfDZ7+ExI13lGjTWx01E5Zi/ldfCJ/2fqbMj2CaBSL6kVk7vGl62sU3wygt8VHXXsyKqH+FUg9oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdsg5uPgpSdNl3oRZOZg3/8a7F3Jy3KG73q2hgItO8PM65CwM1
	m/99AVwcBUH4GqbQ4Xss7rE/JY/FaFMA7k1+xnA4WQro4jdrgyXycIN0wqBIma3au4B1JEuUGt5
	/W9J+o5ADojZKRTAqKMhOSTrK3ew=
X-Google-Smtp-Source: AGHT+IH8ovGo/GOdNZNOetAgADQ2UZFmgZ2um3Y/SyWfXkrsdDvkuWhIqOJGC6x8oHNk5PD36xpMLHJzaudZYKvaIW0=
X-Received: by 2002:a05:6512:1307:b0:52f:413:7e8c with SMTP id
 2adb3069b0e04-539ab876decmr3185141e87.14.1728147381044; Sat, 05 Oct 2024
 09:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
 <20241004150148.14033-2-abhashkumarjha123@gmail.com> <20241005174151.4bcd55f6@jic23-huawei>
In-Reply-To: <20241005174151.4bcd55f6@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 5 Oct 2024 22:26:09 +0530
Message-ID: <CAG=0RqKM8HJ-rV54mCjo1-J6FOsed8zoHSWaVJ1YErSNNZDX1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: vl6180: Add configurable
 inter-measurement period support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi Abhash,
>
> Sampling frequency must be in Hz and reflect how often the channel
> is sampled (not just the inter measurement period.  So this sounds wrong.
> It is sometimes complex to compute but we have to stick to the documented
> ABI.
Got it. I thought of skipping out the complex computation in the
driver and assumed
the user would give me pre-computed ms values.

Just one thing, Is it better to just use IIO_CHAN_INFO_SAMP_FREQ for
"inter-measurement period"
and get the input in HZ (converting HZ to ms in driver)
Or
Define a custom sysfs attribute like `inter_measurement_period` to get
ms values? for this driver.

Thanks,
Abhash

