Return-Path: <linux-iio+bounces-14754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD3A23E9A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF543A9128
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED7CEAC6;
	Fri, 31 Jan 2025 13:47:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50C1BBBC0
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738331256; cv=none; b=P7xmdmQVXZ829xcjikoPe58OfhYSQA5JWMue7Ss5+qEdJixxijyz64d6Sh19+TvxOqWVJRMe/VRwX4cOLoAy6d9IlqWMyegxEwDNp+rLgU/771KI85bu6qJdcFczWMagOuzYMjgfaphzEJqoEHNS/lkPGgx0Mw7gfj93AcoqdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738331256; c=relaxed/simple;
	bh=RUzAHuSg5kb0I8eWtHDvCtXlRyFitEVUQddmb7BMrlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRr2CB2ypuocHXJVdsV2Jh+LnC8k/4LMSvboAXjW12rqHI9jxKfeEsLxAjyIKv1nXRbTurAltLM3MeW3XSn56AlodqGfQNyRlG/nwoV930joxjU/Ipo06OA3lQkvSoDQwCDI8q4yRPiPESv9WNvfR6EILoVwwcOwkJ8ykZIj7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a916:3147:9f19:c260])
	by michel.telenet-ops.be with cmsmtp
	id 7pmw2E00F0naHe806pmw9p; Fri, 31 Jan 2025 14:47:24 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tdrM6-0000000FHy2-2GRm;
	Fri, 31 Jan 2025 14:46:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tdrMG-0000000DFVY-2Fc9;
	Fri, 31 Jan 2025 14:46:56 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Elder <elder@ieee.org>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/3] soc: renesas: Use bitfield helpers
Date: Fri, 31 Jan 2025 14:46:53 +0100
Message-ID: <cbec042a7e7fd12673b2d20cca325b096421fc83.1738329459.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738329458.git.geert+renesas@glider.be>
References: <cover.1738329458.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the field_get() helper, instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC, as a dependency was applied.
---
 drivers/soc/renesas/renesas-soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index df2b38417b8042fc..8030b9a62ec46668 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014-2016 Glider bvba
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -512,8 +513,7 @@ static int __init renesas_soc_init(void)
 							   eshi, eslo);
 		}
 
-		if (soc->id &&
-		    ((product & id->mask) >> __ffs(id->mask)) != soc->id) {
+		if (soc->id && field_get(id->mask, product) != soc->id) {
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
 			ret = -ENODEV;
 			goto free_soc_dev_attr;
-- 
2.43.0


