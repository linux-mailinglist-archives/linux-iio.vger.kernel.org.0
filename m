Return-Path: <linux-iio+bounces-15545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4EDA36376
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0F4170FBB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84805267AEA;
	Fri, 14 Feb 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAQePg0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5971519BF;
	Fri, 14 Feb 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551581; cv=none; b=uVc3s7BBkLX6D65sXFUwUZlx3uXNKwjdYKXMQU7dT8D1NKvCYA3vFulIULH3pNDM920RE5HJxxJvDYoLTyz0NuOxJxvRnO/BDrhKymoh3i4OncK6bbmRwZuMNbJyAAyNwxCvrjrtbwf8DZPqbVQcIoPWUG1IW9txv1PD3xvYgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551581; c=relaxed/simple;
	bh=zG4mJe4owvwGLwC906K8suHMoRJnspdnmPqfvRkK3NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2fLxbS2SVq9gN4TfngIvDohd4zSYDbE3mO6216v69p6DKZDNwjfMANEs2oE/TuJT7PNncCkKRhwrcErbUrrcSkly15dHqMRm6LFerjTpHXvnpHKq4BC8RJWeh+V4pf4oHGgUYrgUo6h4TuJk5sZGzcvVm6EkuGDg0Z45nqERuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAQePg0K; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so773553f8f.3;
        Fri, 14 Feb 2025 08:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551578; x=1740156378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEUK7M60lRQardXDr3rcqI3xJ8vpCF/l2APWaA9DFUQ=;
        b=fAQePg0KX/ovVhCMZ0a0eWgYfWs09N7n+zg5KUef6HHZyHU8w04QcvECStOaCR2fzz
         Es1d15DrFhH3leuNL6UgqVCS7KM4z9HhHOXeI0Q8CAUwxWYMv3Ft65K1T8dFqwUcJdwq
         DLvV3yQrlE3EUy6xjXz97sWNjcRqPAqYe0rwkHCDSYp+o8q2rXU3fjPNHPdyrVZmygdp
         O/6/e9IXBMKHVhat9MEvYqWp3z9WXlAiQVPGs5XokGF03VVav3LZWhJihP5fGt3CRUpc
         iTEXDr9wIorIOYtT51yyOPWqhVrY6pweF1xk5MER35qwSzTHD0pTo5k9PH1fxJ/UVSFV
         X8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551578; x=1740156378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEUK7M60lRQardXDr3rcqI3xJ8vpCF/l2APWaA9DFUQ=;
        b=k8jzEi6F56iJh0VK7/bS+3NajblSXXUBZwqpvwSzPuOuNBb67lVV3fpkLRTkeSjPb9
         SF52znbSRbyiUduT/yIHNxAm4wzBmPDZsEf4SLM/e2feyiTNfXig8G0PGkwZ2BO47jlr
         jqEDJrcy6//hwdIJ7fDYfx14ynzhFuazqatxQO0dJpW0Y8YPiFO8fCG3ke6vSv/dko9J
         OpFVlLUdcPtbmMynqkgTjJ8NScXFd5ukj5NyMArfYjhH2Hy9U7oNz4olPAA7Pio8OeIy
         B7e6nkySDaS8db+yPLxHAenQihBc6l+FdsEhxAcYHhplK5pzvZwQ+rZxC9o6hIIrhYDT
         9o7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1Zdf4fBVlHK4MWugJ3uWNrK/6LYsdisHmoQd/eQbGkX45DmvSmTAKKSYns2ZJCmYah2WA+9gD4rrs@vger.kernel.org, AJvYcCUCipk2X2XIUx4bwULHfKHsyg7BZ7jE2dopU0Mx76UNvPinPWVWokDfpkH3J5Ru5+YN45G3kDcj3GarSOk=@vger.kernel.org, AJvYcCW94QmidKbb4EAIYCxoJ6WFdFfphEZUWq1Pb48fxT2WnYYDdaAG8zCC/e5f8OwZDu46t1k8YUXycNHtugxc@vger.kernel.org, AJvYcCWUnYeT4YAMPkZk9iXPjUdD3dzYhibvKlEMhiCJvASijQpTqnm5CqnfW88vt0RpmhEOG5EfVYHiDxB8xQ==@vger.kernel.org, AJvYcCXcyrRMBaNkIj4TtTGTLNJHOU+JOldthbJCzqOmOCLvDhtrfFiV81q00Vu2/8lUscItKyn3/OqMfIxqarZC@vger.kernel.org, AJvYcCXp0hc5zxzMMiqpke7GnkmBF6fQkaGeNz77VgBNllSU5tOLcFJfg5ZVJLHzpIT2jR2AO6M4DaJAQ50=@vger.kernel.org, AJvYcCXxkXzKOxN7C5ZAjCGD+BEgf2MNITMB19al2ORgPOmX2voSMRPUTo1IahPD/kkOPzFCGsZ5HaGBR1DY5kHwKzlyFn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnjVNulkh2ccbDW1uzVPKGXZs9P508aO2X9SsbSOkHaJweMFy
	qnuMcwHBOkFw34QmLWcUlJeNCY5SEVk5ZBdIno1bJNDzNYQU4Ds6
X-Gm-Gg: ASbGncsH1SidTUEuD7ilwDGry6lKGCScU4XnhALYjwa1FsbszV4KCFH1vrewtWNxp7A
	0WdAsy9jz2Ts4xV5kkMgurcG+J27hJIev/HtNaqdELz49XkKKctQegj7p4x90PYO4lyZLEZycdM
	rTCxvSEzj1iDUDxRk8HvPw5CelTViuqSqq9uXP8SJ7PDAv+liyDFydAaRvTelK6ZryBZ90zScUy
	m2H8pLodAUFH/l7uNdztbI1C4ZgDvKXQAOMmU416y6yTdcwapRnEFdhqNQI/F8tuzPMV5EcUiaf
	k3v8fbD1R7+Y3uEZlKpKECCCpanVwyk8Rb8AsBJw3yprdlZqFRItMQ==
X-Google-Smtp-Source: AGHT+IG9iRvkwD2Pnjr513qQIYSAcwjpWUdTSopHyr3FX8/GpCTlATk6Kd4aSQlT7eXs7Bpa1c1skw==
X-Received: by 2002:a05:6000:1f81:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f2173b9aemr11306900f8f.18.1739551577421;
        Fri, 14 Feb 2025 08:46:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8217sm5125878f8f.90.2025.02.14.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:46:17 -0800 (PST)
Date: Fri, 14 Feb 2025 16:46:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20250214164614.29bbc620@pumpkin>
In-Reply-To: <20250214073402.0129e259@kernel.org>
References: <cover.1739540679.git.geert+renesas@glider.be>
	<2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
	<20250214073402.0129e259@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 07:34:02 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> > 
> > To avoid this limitation, the AT91 clock driver and several other
> > drivers already have their own non-const field_{prep,get}() macros.
> > Make them available for general use by consolidating them in
> > <linux/bitfield.h>, and improve them slightly:
> >   1. Avoid evaluating macro parameters more than once,
> >   2. Replace "ffs() - 1" by "__ffs()",
> >   3. Support 64-bit use on 32-bit architectures.
> > 
> > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > macros, as people expressed the desire to keep stricter variants for
> > increased safety, or for performance critical paths.  
> 
> I really really think that people should just use the static inline
> helpers if the field is not constant. And we should do something like
> below so that people can actually find them.

Especially since you really don't want to be calling ffs() on variables.

Much better to have saved the low bit and field width/mask.

	David

