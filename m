Return-Path: <linux-iio+bounces-2653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBFC858327
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6269EB23F76
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4EE12FB0F;
	Fri, 16 Feb 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZF4rzskE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3F130E44
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102669; cv=none; b=dqF28lVBuxWgjqGs8eKSXG4ij8iiZTRHPyjkMM6rIUXxfsaQuqM/zNSkqAEzeff8DoVrRP2oAX14h6Fa40MJR6gXJIv8PAidgpup/HuvNz0svcqNCwXKqtYfmzTMq1T2+F9gPqGuuNR5SG5g+Z7p4hBIDm5csmsd+MdyujexN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102669; c=relaxed/simple;
	bh=f50Ux9IuBr7dCSB7nZOcygZHY/iK7N+6o1P9XTqmOcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cfaxey930agNDdUqK5vTFIf7MMLyZTAgznGrGQuyRv0JilftMDk/28y1AaYVW1zvMRhcnhq1xgnXwH4kpcbQgt5QFo5CVaSBGcGS60Rzst+OJyDtQw3cFUbfjYYjDil8YnR0CT/bD2RhqW1hfZ4rkTUkcs2mfAEI8dqEfGuENZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZF4rzskE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d11d17dddeso13432511fa.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 08:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708102665; x=1708707465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvSr9zjWa7fQMP/UFKRcpAsYPoeiWv0Pm+Syuyc+j4w=;
        b=ZF4rzskEfyiaDpkn7uapcfrsP7LrbjWoQyuJuKMTkIdJTd8TqZP8ZAgiebthxSCk8D
         lam8TpBnIG57OJ6YxKBnYQOtCVgbu8iRe3YsPtrbK/KbgwFxazm2Cpokbi0te5AQbq+s
         W+tX1CyMPkk23Kxw6CQAN6ML/eSibhD/YdWP0d0G4bPhmz4IpWXRiswgbSW5qc18baD8
         GU71MW8uH64OfcmYe5LOF2I6VDor2WsyyUHg/v12DLuQVb5/GZ2nt1XC8ml5TWVoFDBd
         dmQHjp3+IB47kgLq1cMSbpTLJczwczXXB3zdwMtr77Wws5OdumxQp40rGqNU4XRYLi0Z
         /IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102665; x=1708707465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvSr9zjWa7fQMP/UFKRcpAsYPoeiWv0Pm+Syuyc+j4w=;
        b=RhSN4bR1FWFrRa0rPcd27i7/v2R8AtRYtFD/ZK3Hig4ccj+T3Kv2SQWDJLh0EyMkLG
         JxlvfpxH6AVeEpNIthWm3QaG3KCBE4Q9CQwlk1+7my72pYomjaUX99BfKpm0/0iyP7wj
         j4L6o2ESm7bBa4XkJ4CImx1EYaH4P3DIQpyttOxG9pkscFs8B28J60i5Ovv+qG/+CKwj
         ZTskLErTEcNYTQ3fs/LMmBIDUH082Gc/qLya1kzR8E7IY2VfyNCPIgEDVpYXGeDsqdWB
         /EWKGBppQAyNcj+bq4PseUgJzdJpJDiEOY2qEbHtzVgjpaNwsdCNiVSyspojvheVGBSy
         6xng==
X-Forwarded-Encrypted: i=1; AJvYcCXzr3axlHz6ZQrIi/ZUu+xcxhEEj8txaNjKohayt3o8+H1z7JCgF9e0HUGQGOAABaUaqMYwTTUtcQ0svWsixrXMC2prBkBuY5/C
X-Gm-Message-State: AOJu0Yx6QNf4ewwOWtFJ38OiWhKN0DG6LVaVDK/h3YrTVrPkOedSBehb
	OJjujgkP6H4gdqeFcJXxTks4wyhS6O9g7lOCnja0nNbH4+6NMpUcCzioLIXNsgV9+cyZlJ1xQmD
	MPVcvoo9XQF9sJfGMlUAwYtyAXn+/493IuEZylA==
X-Google-Smtp-Source: AGHT+IE6mpfUgny/NVj+ulwChjEqySrNgCFsvkorHDfu5dOig1qIFaY2Zg0Xp3aqVxFfMRZcUwx2C0EWj1Mp416o/6U=
X-Received: by 2002:a2e:8812:0:b0:2d0:99b7:e68c with SMTP id
 x18-20020a2e8812000000b002d099b7e68cmr3178940ljh.15.1708102664765; Fri, 16
 Feb 2024 08:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208172459.280189-1-alisa.roman@analog.com>
 <20240208172459.280189-6-alisa.roman@analog.com> <CAMknhBHU6k8J_PLCmGYF48S1q3uXByiCwzcd+B3q3Cd-02CUow@mail.gmail.com>
 <84546728-f0cb-4b38-a71c-e053b9b9278e@gmail.com> <CAMknhBFp-4s+-D8kD9rh0-OCc3gBs3hFX1EZ9ZmOifQOyGgUug@mail.gmail.com>
 <20240216142158.30e96c53@jic23-huawei>
In-Reply-To: <20240216142158.30e96c53@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 16 Feb 2024 10:57:33 -0600
Message-ID: <CAMknhBEtLR1QNEv6HhcW35jiGEkx=srzy41NXt8bJ=gokzoemw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad7192: Add AD7194 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, alexandru.tachici@analog.com, 
	alisa.roman@analog.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, robh+dt@kernel.org, 
	Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 8:22=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 15 Feb 2024 11:13:19 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>

...

> >
> > Tables 22, 23 and 24 in the AD7194 datasheet show that this chip is
> > much more configurable than AD7192 when it comes to assigning
> > channels. There are basically no restrictions on which inputs can be
> > used together. So I am still confident that my suggestion is the way
> > to go for AD7194. (Although I didn't actually try it on hardware, so
> > can't be 100% confident. But at least 90% confident :-p)
>
> You would have to define a channel number for aincom.  There is an explic=
it
> example in the datasheet of it being at 2.5V using a reference supply.
>
> I wonder what expectation here is.  Allways a reference regulator on that=
 pin, or
> an actually varying input? Maybe in long term we want to support both
> options - so if aincom-supply is provided these are single ended with
> an offset, but if not they are differential channels between channel X an=
d
> channel AINCOM.
>
> Note though that this mode is described a pseudo differential which norma=
lly
> means a fixed voltage on the negative.
>
> So gut feeling from me is treat them as single ended and add an
> aincom-supply + the offsets that result if that is provided in DT and
> voltage from it is non 0.

Calling AINCOM a supply doesn't sound right to me since usually this
signal is coming somewhere external, i.e. you have a twisted pair
connected to AIN1 and AINCOM going to some signal source that may be
hot-pluggable and not known at compile time. As an example, if AINCOM
was modeled as a supply, then we would have to change the device tree
every time we changed the voltage offset on the signal generator while
we are testing using an evaluation board.

