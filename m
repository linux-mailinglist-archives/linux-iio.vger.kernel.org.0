Return-Path: <linux-iio+bounces-25961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2063C3B829
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D89E84F7D59
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50080231858;
	Thu,  6 Nov 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N7QrAgMk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67C304BB9;
	Thu,  6 Nov 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437131; cv=none; b=Ui+A4itZUrW7eaWXDwL/iuuzywguWj82exmiDvKPMVrIAX/g5UpW6L6cx30rM8D27ZOUQNg2dm/ZH6ayIWv6y66hHqkfl5aHeFzLALyAQaAuKhn8Vvbp4wI4DJK35KKF8KRSCMBzk/XcUrHv7iVw1uUQaS/x6XYcZ8DYHN/n/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437131; c=relaxed/simple;
	bh=53bXnWtrnTsPldREUa+Lsxot9SVqLVmn/rFIO8nhXr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r97CQyjYSxeXn6BggivXaV3ftUngUuwnFe7Jr0CTPc2HzlNtaG7Pzwu9Xn0hdB3oOxRPq+Tc9Y5Mo/V1w1stHylH/6Bm48wb4ZvR/wNJVZbtZtFyTX2+Hh1vvWTWbP4h58zZHLQbRrB2C04mE/E9gfqG7uRwlyEktYLfgALRXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N7QrAgMk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8A67EC0FA8C;
	Thu,  6 Nov 2025 13:51:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C0A46068C;
	Thu,  6 Nov 2025 13:52:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E6E1118507C9;
	Thu,  6 Nov 2025 14:51:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762437123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jlA1rDTx6Lva7xxbNDSbnwmuIRj6XrFx8dhfkF20V3Y=;
	b=N7QrAgMkWFI6HQA3UOPNdJgTNfngqMabJGVtz4L+Z73P+g7Zy9UbJTU+6nw0C9k9RuS7d4
	0t10bFhDoUFVEGJ+Dg0SVEPlweQKe2PAXJr8Jz4p0vCtadpzf6O74ZnS7GqYOlZvfDaY6I
	k8zAULnGAfPT+lFjrdeN7WGH5nH4+yQEOKBvD68jGpg820Mlfz+H4dZozShrI33OjfvP+U
	M+bXMIHVwX6aB2riVG3gPYDkVh8w03xBzHKb5BrG3VlwReQesR+l62n1eXPZUVCqRHWdIc
	lXqhB86i08GEcs4OdPzXCoemI/MVE/PUPlPSH2kxSDqNCyBJvDcIaP6LQyRDCw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yury Norov <yury.norov@gmail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Nicolas
 Ferre <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>,  Herbert Xu <herbert@gondor.apana.org.au>,
  David Miller <davem@davemloft.net>,  Linus Walleij
 <linus.walleij@linaro.org>,  Bartosz Golaszewski <brgl@bgdev.pl>,  Joel
 Stanley <joel@jms.id.au>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
  Crt Mori <cmo@melexis.com>,  Jonathan Cameron <jic23@kernel.org>,
  Lars-Peter Clausen <lars@metafoo.de>,  Jacky Huang
 <ychuang3@nuvoton.com>,  Shan-Chun Hung <schung@nuvoton.com>,  Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Jakub Kicinski <kuba@kernel.org>,  Alex
 Elder <elder@ieee.org>,  David Laight <david.laight.linux@gmail.com>,
  Vincent Mailhol <mailhol.vincent@wanadoo.fr>,  Jason Baron
 <jbaron@akamai.com>,  Borislav Petkov <bp@alien8.de>,  Tony Luck
 <tony.luck@intel.com>,  Michael Hennerich <Michael.Hennerich@analog.com>,
  Kim Seer Paller <kimseer.paller@analog.com>,  David Lechner
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  Andy Shevchenko
 <andy@kernel.org>,  Richard Genoud <richard.genoud@bootlin.com>,  Cosmin
 Tanislav <demonsingur@gmail.com>,  Biju Das <biju.das.jz@bp.renesas.com>,
  Jianping Shen <Jianping.Shen@de.bosch.com>,  Nathan Chancellor
 <nathan@kernel.org>,  Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-renesas-soc@vger.kernel.org,
  linux-crypto@vger.kernel.org,  linux-edac@vger.kernel.org,
  qat-linux@intel.com,  linux-gpio@vger.kernel.org,
  linux-aspeed@lists.ozlabs.org,  linux-iio@vger.kernel.org,
  linux-sound@vger.kernel.org,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v6 24/26] mtd: rawnand: sunxi: Convert to common
 field_{get,prep}() helpers
In-Reply-To: <e1c879967328d8c1098aaa014845c2f11874d7c7.1762435376.git.geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Thu, 6 Nov 2025 14:34:12 +0100")
References: <cover.1762435376.git.geert+renesas@glider.be>
	<e1c879967328d8c1098aaa014845c2f11874d7c7.1762435376.git.geert+renesas@glider.be>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 06 Nov 2025 14:51:43 +0100
Message-ID: <87frar8e1c.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Geert,

On 06/11/2025 at 14:34:12 +01, Geert Uytterhoeven <geert+renesas@glider.be>=
 wrote:

> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v6:
>   - New.

Thanks for preemptively handling this case!

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thansk,
Miqu=C3=A8l

