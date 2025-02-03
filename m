Return-Path: <linux-iio+bounces-14923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2DA25B1E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902B0165041
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A5205AB3;
	Mon,  3 Feb 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XwYwJD9q"
X-Original-To: linux-iio@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAC20551A;
	Mon,  3 Feb 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589916; cv=none; b=C8AYm79wvMPc/83kQbnKigvTQ0zz+U4UIiD7qMOK007Mm6WMZD3kevDYkjEawY+aJtppNjs5Y4aHnP6lZ0ujc4sE+gj5ichl2Czr2+Knf7Vv6rY5XqzWNHhGaf0ER7QiObdndCPU+AOPlDcAUf03+s4QFYAzhiZvHqZd0ffci18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589916; c=relaxed/simple;
	bh=vxVOoUrEMpOIpnFj54sWmKsuUYbIQUlu2hobKUo1VJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et+6QpfO6QkU+//3kYTchf99MV8z+fIBfDQUjZVmYauJGrqnpmOIL3njGgRov7ecIZrPWnDK18cD5AohXk2BGR61RQ3J3lYNQ7gpO6xH7mrzEV4f1w4RjCVze78RPFEiZO66VftUOzpkmNiwuNnLulXhWsj3j+128H/Udjy/TwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XwYwJD9q; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id ewd2tOy0dEoZKewdIt5Ip4; Mon, 03 Feb 2025 14:37:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738589839;
	bh=/g4W8zsNjOkB4DJtFhM/WsfKs6gE5EsQ2w79HWI72oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XwYwJD9qo2zk974igNaK7YRqOSOeQpGfDoLCz5WdqzVZVaQCeXRz5fRwVtek4nccr
	 IIPachRHSkoVTOEAWF+Q1RzHqSOorzh7zXI195lPeh6rI9NWNNeXuWFRvNezWJTw3p
	 PujsqHiaXsnhXn4ml0tu+soSLAwHQx/2ykUaxgbrj/FrCgmqj2lH181uuMut8tBYuy
	 aja0FJrJQgnw/6NiWOYkVZxNTWgTqVbG3qy26HXJ2+cOUzaAglixyIojvdf5gfQ1kK
	 saeXLw4BQa+dsq1UxBUW8SPV6tQMuEPXP5HvV9PLKQ6hwtsv5+NhzubCQc+XQUYX3M
	 ZF/4/IEW0rvcw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Feb 2025 14:37:19 +0100
X-ME-IP: 124.33.176.97
Message-ID: <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
Date: Mon, 3 Feb 2025 22:36:43 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Johannes Berg <johannes@sipsolutions.net>,
 Yury Norov <yury.norov@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
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
In-Reply-To: <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2025 at 16:44, Johannes Berg wrote:
> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
>>
>>> Instead of creating another variant for
>>> non-constant bitfields, wouldn't it be better to make the existing macro
>>> accept both?
>>
>> Yes, it would definitely be better IMO.
> 
> On the flip side, there have been discussions in the past (though I
> think not all, if any, on the list(s)) about the argument order. Since
> the value is typically not a constant, requiring the mask to be a
> constant has ensured that the argument order isn't as easily mixed up as
> otherwise.

If this is a concern, then it can be checked with:

  BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
                   __builtin_constant_p(_val),
                   _pfx "mask is not constant");

It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
any other combination.

> With a non-constant mask there can also be no validation that the mask
> is contiguous etc.
> 
> Now that doesn't imply a strong objection - personally I've come to
> prefer the lower-case typed versions anyway - but something to keep in
> mind when doing this.
> 
> However, the suggested change to BUILD_BUG_ON_NOT_POWER_OF_2 almost
> certainly shouldn't be done for the same reason - not compiling for non-
> constant values is [IMHO] part of the API contract for that macro. This
> can be important for the same reasons.

Your point is fair enough. But I do not see this as a killer argument.
We can instead just add below helper:

  BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2()

But, for the same reason why I would rather not have both the
FIELD_{PREP,GET}() and the field_{prep,get}(), I would also rather not
have a BUILD_BUG_ON_NOT_POWER_OF_2() and a
BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2().

If your concern is the wording of the contract, the description can just
be updated.


Yours sincerely,
Vincent Mailhol


