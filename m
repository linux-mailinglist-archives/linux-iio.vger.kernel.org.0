Return-Path: <linux-iio+bounces-14932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E5A25F11
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD16162A71
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA69209F5A;
	Mon,  3 Feb 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E6vkO1BK"
X-Original-To: linux-iio@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065951FFC69;
	Mon,  3 Feb 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597411; cv=none; b=E4ol8BjCZ++pH0XU+LATyRNx7zA74PuHbbvcowhVoaV4thTvph5jT7zGh5EE8wvvHGgPjrUcPqVVe/CbkeAWlHp8jjOWcyMLIFDrb3aDfEimImu0gR5pSrHmCIixPUf2t0ULtiUa230Iny8avodK8xR1i18i0KV47H4tVIjyjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597411; c=relaxed/simple;
	bh=jOOv4bWa7lwO2nXyPXwBxnGGClSHOQVZio/1vYoQaLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVVT5muqfgwed5sQG7AlvcfrFtlamOkEKVtWN9o99V9akx7wVfX4JEfdXu+FMQZd/tgabbiHh+kpTd+UPyNxzqv6/mhwRxBCf7xjTyoISH6KatftBUvPjKz02vgXresTCN2Fyzsj84DnLHZKt6aVG9fMXCpx3vtlWMSmEZtGTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E6vkO1BK; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eyaCtfZi6inFieyaHt4JBP; Mon, 03 Feb 2025 16:42:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738597339;
	bh=RZsvS79FyvH7npVg4P4SWlQ3ou2VaFduLz7By9FNQMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=E6vkO1BKyl9ZpZ/TIQbXnlfLL271wV2srdURu+fgQIsPEjIDixSMulc1y5cgOUdvQ
	 iU0xocdrubJQbaGqdM4S1eETa1X3VnmbyIlCpIe+a4qtacRIMNgrbIBohfYQ/Cbs11
	 4XcRUGo4AdWzSsrodY9VqO3xRb+ccURkqfTphOk6wf42jjzptRkf6Ew7LUPb8/7xmB
	 4nxFwkSmDXyg1SOWrja+h9uckxzLz1buRrs02RmLyeg90pT9qhR9xDfFtDYVrbgxVL
	 8i8tQrSryz9UIKkC0YPWmVq5f1paxeJQ4qhOnmIpEQ2eQwpF8/yY2k5burgk4+LioO
	 cQ9XcwAjHlJHA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Feb 2025 16:42:19 +0100
X-ME-IP: 124.33.176.97
Message-ID: <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr>
Date: Tue, 4 Feb 2025 00:41:55 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Yury Norov <yury.norov@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
 <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2025 at 22:59, Geert Uytterhoeven wrote:
> Hi Vincent,
> 
> On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
>> On 03/02/2025 at 16:44, Johannes Berg wrote:
>>> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
>>>>> Instead of creating another variant for
>>>>> non-constant bitfields, wouldn't it be better to make the existing macro
>>>>> accept both?
>>>>
>>>> Yes, it would definitely be better IMO.
>>>
>>> On the flip side, there have been discussions in the past (though I
>>> think not all, if any, on the list(s)) about the argument order. Since
>>> the value is typically not a constant, requiring the mask to be a
>>> constant has ensured that the argument order isn't as easily mixed up as
>>> otherwise.
>>
>> If this is a concern, then it can be checked with:
>>
>>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
>>                    __builtin_constant_p(_val),
>>                    _pfx "mask is not constant");
>>
>> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
>> any other combination.
> 
> Even that case looks valid to me. Actually there is already such a user
> in drivers/iio/temperature/mlx90614.c:
> 
>     ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> 
> So if you want enhanced safety, having both the safer/const upper-case
> variants and the less-safe/non-const lower-case variants makes sense.

So, we are scared of people calling FIELD_PREP() with the arguments in
the wrong order:

  FIELD_PREP(val, mask)

thus adding the check that mask must be a compile time constant.

But if we introduce a second function, don't we introduce the risk of
having people use the lower case variant instead of the upper case variant?

  field_prep(incorrect_const_mask, val)

I am not sure to follow the logic of why having two functions is the
safer choice. Whatever the solution you propose, there will be a way to
misuse it. Let me ask, what is the most likely to happen:

  1. wrong parameter order
  2. wrong function name

?

If you have the conviction that people more often do mistake 1. then I
am fine with your solution. Otherwise, if 1. and 2. have an equally
likelihood, then I would argue to go with the simplicity of the single
function.


Yours sincerely,
Vincent Mailhol


