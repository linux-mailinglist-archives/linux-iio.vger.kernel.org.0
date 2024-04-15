Return-Path: <linux-iio+bounces-4280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E48A48A7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F741F23270
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A5A1EEE0;
	Mon, 15 Apr 2024 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyGm1I8y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3651171C
	for <linux-iio@vger.kernel.org>; Mon, 15 Apr 2024 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164801; cv=none; b=NxV92n5teh3dzKbqvNvVh/zwX2i746L2n0mMrZJKX+zbSoCyddUrWIE6hrHWc7c0WL8WFwYGbyyhvtMsS1yiSHYfUkgAApgnn69ctno48ZKO00gkETpzaBWp8oXtDY4k7IjL49ccSTkFQkMUccLe4MlTdo94/PDfwMuNr2m4Afg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164801; c=relaxed/simple;
	bh=LoEI/t6qRuDt5x3T2TU+MPh3QbZkQi2d+LFgFrElQNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaXQZhL0wW2RKVuXQhYaR7hW4ghi/7E6zJ4l/D+TU1v8uzS6vUxh/kjhh0keOg8rcOAvVpbjUlzWDhBG/sNrM0uCLwBGx/PA+Ehm62yZQ+9iPY1HlRo1vXoW5If1BgmqGjvdCC6cZ68RsaE426ml+WsN1XJJjk+EpU1DNjg3ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zyGm1I8y; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2592414276.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Apr 2024 00:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713164799; x=1713769599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuNWkejVw9nhLJYunyRi4ctYhQ3TUOgiqRoKyrlen1A=;
        b=zyGm1I8yYvMo2DavcVl7itR/eq/aESSpNITc/trfxz3SCwICOc2qxQHjdqoSVl7Pf6
         2292ZTMrPd6Ci3UMDFjy6bNgRHTJLjHaisVnMl+FLAAgJbjn6DPodyxgUVaovhDXG8cd
         g9U2iAvvgl+qEPYD6z7FkLpqU1U2U1jR086KUxY5Z/PNBPBmFIUuoYal1YXXOmXakDgS
         bovgeftZ4ePJzdm8YrRFcbBLScf3u5uAygAXKVHmTZWbFan/J5yXI4nxKkBtVXgu1QFV
         ioOtm6OzkA5CAGKeuw0qSEZ6n8KdZJy8UyScw2ScHKv5iqCrKDNZaoEuXQjiopV90VyQ
         m/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713164799; x=1713769599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuNWkejVw9nhLJYunyRi4ctYhQ3TUOgiqRoKyrlen1A=;
        b=VAYUdnXlkiWwM3rBFWgpcalarETQlg/eqwSTgP4dYW9F8vO1WFie+bXOT3V1fxDfQq
         lDTQJ50cUoNyGgw0gGhS72WLrN7sQrgUxhK8lTLlPo1+B957xX/0Amsq3mjYSawYa+RA
         wU77US7rgEQC1GHsxXOn+/MDaRRwJ61gM3NfQ9bBTqHdql2eN37Bepk9DQ7b0EEF0HSN
         +SFEts4KTXPbLMFVJC7TeR6nQZjhw7LceefLPi2B5qslejHhK4T/lGoBxVig699QRFMr
         WVyK+X7yO30BZJfjCMW+dWcwvNnvLCIuq+wIp3Z/jQ7bj8fRIPCWdKYp0K1Tgvt/OaPi
         Cc9w==
X-Forwarded-Encrypted: i=1; AJvYcCVXTS7OLR8Y8zU4iniBc2/I0nucJ1z7hjF+Z/R79Bxz+1EX8doSK78Ckgu3QHjJ6K7HpUYCNDkcR+ERDuRdUu3fXtqCP1hamJWF
X-Gm-Message-State: AOJu0Yw3Rg30pFoQso5YSy6fP8Bn+aMKZ5t11y4/nMhkY/mDvsp6hyNf
	VKAnZXcFvRpADYXiQJHhxillqgGZ76Z9K/1e3GVo1XkeBP0YOb/fGm7VsZH7FXK5xOiFTCrfPSq
	mxXaSo5uF+BpOT1B4O4K8CF/MTDo1oOreM2Wn6Q==
X-Google-Smtp-Source: AGHT+IElDvWL2LCkOz4RjkaFUwcYELFFJYOX9m1GxoA9BfJdWoIedX9cxxBXW0WJfK9EtYYSsZD5fiWV5mgRDS4FCVM=
X-Received: by 2002:a25:53c6:0:b0:dc6:a8c6:c9e5 with SMTP id
 h189-20020a2553c6000000b00dc6a8c6c9e5mr7748059ybb.26.1713164799122; Mon, 15
 Apr 2024 00:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330190849.1321065-1-jic23@kernel.org> <20240330190849.1321065-2-jic23@kernel.org>
 <CACRpkdZzOi5vv6yxqheqGZAZYBLTEL-uB=dt-i6ByDEhF6H0Kw@mail.gmail.com>
 <20240405113622.00000896@Huawei.com> <20240406112744.64f53089@jic23-huawei>
 <CACRpkdbJ372YEuGOQOFNA9r_Xnbh4SdUvRiX-ExF1mxhP9tAkw@mail.gmail.com> <20240413105722.74490765@jic23-huawei>
In-Reply-To: <20240413105722.74490765@jic23-huawei>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 Apr 2024 09:06:27 +0200
Message-ID: <CACRpkdZsU9sWvjiaG3Xc+ExKOREiT=Js=VKWp4uWK90Seb60EA@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	Marius Cristea <marius.cristea@microchip.com>, Mihail Chindris <mihail.chindris@analog.com>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, Cosmin Tanislav <demonsingur@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 11:57=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:

> > $ git grep abx500_get_register_interruptible include/linux/
> > include/linux/mfd/abx500.h:int
> > abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,
> >
> > No stubs! I think there is just some other Kconfig stuff bringing the
> > AB8500 MFD core into
> > the build at any attempt.
>
> ah got it.  AB8500_CORE isn't needed, but ABX500_CORE is and that's indir=
ectly
> depended on by AB8500_CORE.  How about I change the dependency to
> depends on ABX500_CORE && (AB8500_REGULATOR || COMPILE_TEST) instead?

That looks like it will work!

> As ABX500_CORE doesn't have a horrible indirect arch dependency that
> AB8500_CORE does via db8500-prcmu.  I can build it on x86 but obviously
> would want to hit this with a lot more build tests.

Actually I want to drop the ABX500 indirection layer because that was
as the name says intended as an abstraction across a multitude of
ABX500 chips whereof AB8500 would be the first, however the others
never materialized.

But that's for another day, this works right now.

Yours,
Linus Walleij

