Return-Path: <linux-iio+bounces-14931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38DA25ECB
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A92162BCB
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421E420ADE1;
	Mon,  3 Feb 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WPKbYP2m"
X-Original-To: linux-iio@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDD205E1C;
	Mon,  3 Feb 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596711; cv=none; b=pUydIgHEVwqqR9jueXcX+NLyXh4jMjBqdpGRYCUE/G6P1ahSCyhhh2JMBtlIS+t/6oDEPhQT3+1sHZSmjzrwo7EdH09XGE+FsgKtdigppbVmprMU8HQpDaIa49rzhrY/XPmeGMjtjM8r2wkRrqAkg0e5pjm4R07aW9vJstW8MbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596711; c=relaxed/simple;
	bh=3v8EFM1T7G9E1gQyrUNrG6m+aM4+dQyCmq/iSZIDY4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eo5Ixx/pNVXyfC1uRonGX6K+v2pA9zXlWB1C+C1/jEbjLLRLKHHISXkFCltHIjnc4n9rjIB0KaZjBcyenYA0c1zzbfczIOdb6skOaHm0PAio4FDCGwWYSp9i4Ykvr7NYCSkkUQvonU56W1m5ETd1yqJ28nkXZfrThp7lx00qkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WPKbYP2m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PAvOtJHsIMS59RfRzFfMyl8id23TWAECc7EwAHrUKlY=;
	t=1738596709; x=1739806309; b=WPKbYP2m554oV92ofNHXgmK4f5Kczfmx2KPMeDJ7kzv1Sml
	y1H3j1+rZ0GesRwgqUY5RZsVVrDmBPHmpxMcL0DNzmIvmAikxh7BFhj4iy4ABbQ2g8ZExVnUlpK2C
	GsK61+rWhqpm1tth0kgHRNRp0cpkz+gwtfAwc5g/rHbQANNEruTT4Pf1Xq5CSlWhnCwiIbxYfzKP9
	IEm9aMR8rkQBGczMUdSCY7UdN6VS75As6bv/VjRl6H11vZbLpPA5zN6thqtKcpAp2rOXzjCmPbLR2
	lQ1sulqkjKmvqann1uS8o9cDlWWI/at8loLohsF6z7VllXRMpRr8sIgJtkM1PmVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1teyQE-00000001gus-0LFB;
	Mon, 03 Feb 2025 16:31:38 +0100
Message-ID: <2904baea9188a4707d4b5a9a6bfa517a54323f8a.camel@sipsolutions.net>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
	 <yury.norov@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
 	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, 	linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, 	linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Turquette	 <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre	
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu	 <herbert@gondor.apana.org.au>, "David S . Miller"
 <davem@davemloft.net>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>,  Lars-Peter Clausen	 <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung	 <schung@nuvoton.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Jakub Kicinski <kuba@kernel.org>, Alex Elder
 <elder@ieee.org>
Date: Mon, 03 Feb 2025 16:31:36 +0100
In-Reply-To: <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
References: <cover.1738329458.git.geert+renesas@glider.be>
	 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
	 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
	 <Z5-xMUqrDuaE8Eo_@thinkpad>
	 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
	 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-02-03 at 22:36 +0900, Vincent Mailhol wrote:
> > On the flip side, there have been discussions in the past (though I
> > think not all, if any, on the list(s)) about the argument order. Since
> > the value is typically not a constant, requiring the mask to be a
> > constant has ensured that the argument order isn't as easily mixed up a=
s
> > otherwise.
>=20
> If this is a concern, then it can be checked with:
>=20
>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
>                    __builtin_constant_p(_val),
>                    _pfx "mask is not constant");
>=20
> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> any other combination.

There almost certainly will be users who want both to be non-constant
though, and anyway I don't understand how that helps - if you want to
write the value 0x7 to the (variable) mask 0xF then this won't catch
anything?

> > However, the suggested change to BUILD_BUG_ON_NOT_POWER_OF_2 almost
> > certainly shouldn't be done for the same reason - not compiling for non=
-
> > constant values is [IMHO] part of the API contract for that macro. This
> > can be important for the same reasons.
>=20
> Your point is fair enough. But I do not see this as a killer argument.
> We can instead just add below helper:
>=20
>   BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2()
>=20
> But, for the same reason why I would rather not have both the
> FIELD_{PREP,GET}() and the field_{prep,get}(), I would also rather not
> have a BUILD_BUG_ON_NOT_POWER_OF_2() and a
> BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2().
>=20
> If your concern is the wording of the contract, the description can just
> be updated.

No, I just think in both cases it's really bad form to silently update
the contract removing negative assertions that other people may have
been relying on. Not because these trigger today, of course, but because
they may not have added additional checks, or similar.

So arguably then you should have BUILD_BUG_ON_CONST_NOT_POWER_OF_2() or
so instead, so that all existing users are unaffected by the updates,
and similarly that's an argument for leaving FIELD_* versions intact. Or
I guess one could change all existing users to new ones accordingly, say
FIELD_*_CONST_MASK(), but that's pretty annoying too.

johannes

