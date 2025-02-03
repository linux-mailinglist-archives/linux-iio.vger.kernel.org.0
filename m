Return-Path: <linux-iio+bounces-14869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC06A2532C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFB51633CA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB31E98EF;
	Mon,  3 Feb 2025 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mRvKnnWs"
X-Original-To: linux-iio@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF41D86C3;
	Mon,  3 Feb 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738568683; cv=none; b=d4OeZ2MhM/TckPGXCMnSkBjYUxgNjYUZgZ3EztGHbwxNQd6eauZRp+Q5AcoJd6P9+Sr6iRGVYyMjqyWrlHCrlMKWvT9KH1OCzcv0isc6XkPFVh1DL8R4Btc7wASI9uJN8iMuahG5sNHWJcX30LH4VXdI6aTSQQLjtd6mjMpkIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738568683; c=relaxed/simple;
	bh=x1beuisn9wdEKP1QdS1UhUe3+GT+LqGgI15rKS+Adds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PBS2W+TN9NlQUKii18bmNWAbfkPBQpDxslQpEHeQp9R60UqvcvZmNqQqIMIWRffTblPrQG1vKLU4+2UP2bERaMJPCfcVatVfKnh6Nlz2Q50PpxLdjr+BixYxcJkHPaiAkeGB7877gCvVexgexycPSjaNtRrIO0gWhpUivML+/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mRvKnnWs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x1beuisn9wdEKP1QdS1UhUe3+GT+LqGgI15rKS+Adds=;
	t=1738568681; x=1739778281; b=mRvKnnWso7bumZit+yviqahz/44SggGsn0LU225JzCFCnWw
	qkExAMOaXIxp9bIgjunoUdpGVPXuqaSpv6kKrcwJ22yC89lKYgaUf8r5naJrAAAh4uPi1GsG4ML6l
	Bf4IeLdDPUx7i7vW+7d+uoSuG7PeJgajncxQQczZwRL6T68UKKpSBbrb2cMIh9hNpcDJSak/dcJ98
	Ounk7o4ivaH0UXjG3gCeNc0LUBfysnYlK1C4Q8SDEbTw25DCm67kkUUSI1me78ACOpYCYUTs6jc77
	O2XNSB4qygsj3h82m/1sqpafeLlUH1wb8LjgegC/oLGHGfFBpcTnyhY/OFtBi+Xg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ter7q-00000001RTp-38Nc;
	Mon, 03 Feb 2025 08:44:11 +0100
Message-ID: <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
From: Johannes Berg <johannes@sipsolutions.net>
To: Yury Norov <yury.norov@gmail.com>, Vincent Mailhol
	 <mailhol.vincent@wanadoo.fr>
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
Date: Mon, 03 Feb 2025 08:44:06 +0100
In-Reply-To: <Z5-xMUqrDuaE8Eo_@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
	 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
	 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
	 <Z5-xMUqrDuaE8Eo_@thinkpad>
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

On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
>=20
> > Instead of creating another variant for
> > non-constant bitfields, wouldn't it be better to make the existing macr=
o
> > accept both?
>=20
> Yes, it would definitely be better IMO.

On the flip side, there have been discussions in the past (though I
think not all, if any, on the list(s)) about the argument order. Since
the value is typically not a constant, requiring the mask to be a
constant has ensured that the argument order isn't as easily mixed up as
otherwise.

With a non-constant mask there can also be no validation that the mask
is contiguous etc.

Now that doesn't imply a strong objection - personally I've come to
prefer the lower-case typed versions anyway - but something to keep in
mind when doing this.

However, the suggested change to BUILD_BUG_ON_NOT_POWER_OF_2 almost
certainly shouldn't be done for the same reason - not compiling for non-
constant values is [IMHO] part of the API contract for that macro. This
can be important for the same reasons.

(Obviously, doing that change now doesn't invalidate existing code, but
it does remove checks that may have been intended to be present in the
code.)

johannes

