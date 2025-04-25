Return-Path: <linux-iio+bounces-18660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FEBA9D033
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 20:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC8216180C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892112153C8;
	Fri, 25 Apr 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaAt62NS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33011A2545;
	Fri, 25 Apr 2025 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604526; cv=none; b=F/t+l0EjVs/0kSjj5lABJejHDLmtxaY8CDx96LVyCdEhmBFTk0xneTgWhr2/WbGZpRFnX32gcCh9dtbu4Ia40NJ3qGtU99lhUWf9acwHE+IR81ysLtGYW+pE6I8P4QSk5DI0QKLUJWXmKXjlU4/j6v4HT7EP6DHSIqajDxXKHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604526; c=relaxed/simple;
	bh=mxIIRoUKUip7kdGYkldw/Ddl/8kVuZoZEj2BPQ5UWIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqnIUFnUmjAjSwYpI9u6TFSh7vqiuKNwuCJ7sVFsZuoZcY52FSqcC+tiYztPXf51tnprUTJdimQUmTjJg3yUuSpmBknSzwrhoSRrHh+JR+g4g59ZnlTeU0M42HmOSjkyEXnO5YXrEabelWodz+HWvRauOupN5kwj9kMy0JTXiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaAt62NS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso4240681a12.2;
        Fri, 25 Apr 2025 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745604523; x=1746209323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxIIRoUKUip7kdGYkldw/Ddl/8kVuZoZEj2BPQ5UWIs=;
        b=MaAt62NS53Jn1QNaiyskiDZYuCyj9bHrP/Tvuso0gVpWP9q5K9Yo6FaoY2e94cqFFw
         +r6IOWxk3BDuPhJ1HYSTtIUaIYC3n3LXwRP6z8xBG2gkUO2TDEPB6fTvyeyReaBzSgO0
         NdN2t3CCqjTW5Lm4xGDqHHtw7ceL978aEh8H/ok16hU0LRfokMdXo00pMco+P1VpuTRY
         4l0CLNIXnlJ3um611x7bFv1mZtSfr8yi7XwO98JDe6Q8Hh4+YZu94ln8Flns+1BpU/v/
         DEx7j8X0MLUXKDb5NVc6p8I1YflJCcXnLJ45gKpxSn4GhLisHSIFNm2jYNY+nmI8h49y
         QfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745604523; x=1746209323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxIIRoUKUip7kdGYkldw/Ddl/8kVuZoZEj2BPQ5UWIs=;
        b=w2Q8oOUnOJu5ynG/F+FLPsJlraLzThlVOcotDAQbeqhF7IolU0CCozM4BlqzP5zL25
         FSqOHSvqSNw6VuFI2H/MANmre0s9Rp2XhjqhdA4m3CBTHWXDjD1riu62a8jtfKhoxoUD
         O7DE1VDCwi6Lfssb57rkomlQRvZwj/cGmJQCJwyiCSh1NURQZrGY2s/uEqCcJDutSEF0
         XuzunqDWLVuxv9kJbLQZ7KvS1xG3tCWcxo69WrSiC5ojRzuM26FKNasIwJpQzTs+pXVt
         nRv/4YOPK+P+su2drJ9mFrbhtBrmXb3YL1vGyCGkNryX8ydXUUYK0xCJNknJQ45Ga/hn
         voNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsLfgr4Jru0MOy59/lt/xNlc4VsRKLaVbufa+mSWVifdSwlVvxQZuO4ejF1Oijk3M2icds1ZD6FEUe1HzJ@vger.kernel.org, AJvYcCVnBpXrqx2ejpXie0IRBpbNK7t8PxrZo6/6EbQnr50y12O3MSm8IgJRFPSIneJ5RZkFolnBcshHFwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPw2RAWo1Jtz92uweIMvCjOdFwQa7+NadF2OCh6u9Q+enETbUH
	DUTNteKn/z3Rpy6ShTKMWY6BQcZ0UGhNhYKh9XfY3PielihVDymoMXkcJjnpz+pOCTZQC9sIKL5
	YiNT+41A/fbQkfL+QMT/vKnAADDI=
X-Gm-Gg: ASbGncukd7HGTvyvwA00PaZJHY8NNdK1/wJezLVZ55dotmFRvnhKQ6ZtdWP1gPXoOgJ
	zt9pTZ4sdhGsGIpo7bVrk+J4tWvV0C1RIu49dCc0p2N+aYA5zKhMq0/Ypm5sEoNoULCETbMv3D9
	5pG+3ncEt5mGkL3KjDFWox/blOs22g+8HWOLU=
X-Google-Smtp-Source: AGHT+IG2/QrV9Q7UUJuXl3dcOxL6dx6R358d0ZswlMA6nN4DaR5wF2/FlYtAQbu/NWX427+xy/ZM5XQJj84uWvnFMoQ=
X-Received: by 2002:a17:907:9493:b0:acb:5583:6fe4 with SMTP id
 a640c23a62f3a-ace7104e803mr291216966b.6.1745604522766; Fri, 25 Apr 2025
 11:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
 <CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com> <a06a5b07-8b99-495d-8e84-200923b277c7@baylibre.com>
In-Reply-To: <a06a5b07-8b99-495d-8e84-200923b277c7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Apr 2025 21:08:06 +0300
X-Gm-Features: ATxdqUFeC_NFn9YdtNzOp_S3srDTg1hDYwJnG87Fwqul6I2W5I1tPh7_5OHzsX4
Message-ID: <CAHp75Vc4L3NukGriXHUu3=XjU_d-V1qL6tQcFtgcyC7A8WKPSw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Guillaume Ranquet <granquet@baylibre.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 7:55=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 4/22/25 4:03 PM, Andy Shevchenko wrote:
> > On Tue, Apr 22, 2025 at 11:12=E2=80=AFPM David Lechner <dlechner@baylib=
re.com> wrote:

> >> Fix compiling the ad7173 driver when CONFIG_GPIOLIB is not set by
> >> selecting GPIOLIB to be always enabled and remove the #if.
> >
> > I'm not sure we need to select GPIOLIB. If you want it, depend on it.
> > GPIOLIB is not a hidden symbol, so why "select"?
> >
> Since this parts of the driver unrelated to GPIO provider/consumer rely o=
n this
> being enabled to function, select seems more appropriate.

Hmm... The current state of affairs is 177 for select vs. 231 for
depends on. I dunno how many of them are historical, for now it seems
like 40%/60%. So if you think so, go for it!


--=20
With Best Regards,
Andy Shevchenko

