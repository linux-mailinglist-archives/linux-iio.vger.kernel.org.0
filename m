Return-Path: <linux-iio+bounces-15537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E4A35F9D
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 14:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C53A7E29
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41288266182;
	Fri, 14 Feb 2025 13:56:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094B264FAE
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541391; cv=none; b=UgJtUasZfhubFz2CqI2RYsdSpdgQus+sqUyZ9O3YbiAXEfL8ADTfXkh0KaiIeEvSVztEG/nTF5HOZPPZnWlLimIMT/7DGlePzEjgVg6lPi9ahsPSdIenqYLGbqfoWCULG1kIc8BOxYvmGwdZLxojB4dYRg/X/er+J/CUUVNT16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541391; c=relaxed/simple;
	bh=FIIhzQS1EAgStkHx0YjUAf18XcC9KXBn7p0CA8qJI1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpz1pqcw40hZ3/sM3Ak+qfzUbm83ytG2abXfml4lUx8xHSEfvawegkFkwYWUQs8GeN4m9vT2X1eIOGx9WrmPlieKPJrZ1rFDKDa9utlGjknWQss+vQxZaDZYNKqOPq/9EkrO8GKEBnsXcuBbHWvU0vomTnTAG7XXj/io5MyafMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:6395:73cc:7fc4:4cab])
	by michel.telenet-ops.be with cmsmtp
	id DRvu2E00L1MuxXz06RvuMY; Fri, 14 Feb 2025 14:56:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAL-00000006p2b-0uwA;
	Fri, 14 Feb 2025 14:55:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAc-00000000qEh-1jsF;
	Fri, 14 Feb 2025 14:55:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
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
	Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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
Subject: [PATCH v3 1/4] bitfield: Drop underscores from macro parameters
Date: Fri, 14 Feb 2025 14:55:50 +0100
Message-ID: <ef545b87b3e3e48ec91ab4ad272d17334ab0569c.1739540679.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739540679.git.geert+renesas@glider.be>
References: <cover.1739540679.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to prefix macro parameters with underscores.
Remove the underscores.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 include/linux/bitfield.h | 86 ++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f1732230700..e8269f23b824c4a9 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -60,68 +60,68 @@
 
 #define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
 
-#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
+#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
 	({								\
-		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
-				 _pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
-		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
-				 ~((_mask) >> __bf_shf(_mask)) &	\
-					(0 + (_val)) : 0,		\
-				 _pfx "value too large for the field"); \
-		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
-				 __bf_cast_unsigned(_reg, ~0ull),	\
-				 _pfx "type of reg too small for mask"); \
-		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
-					      (1ULL << __bf_shf(_mask))); \
+		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
+				 pfx "mask is not constant");		\
+		BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");	\
+		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
+				 ~((mask) >> __bf_shf(mask)) &	\
+					(0 + (val)) : 0,		\
+				 pfx "value too large for the field"); \
+		BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >	\
+				 __bf_cast_unsigned(reg, ~0ull),	\
+				 pfx "type of reg too small for mask"); \
+		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
+					      (1ULL << __bf_shf(mask))); \
 	})
 
 /**
  * FIELD_MAX() - produce the maximum value representable by a field
- * @_mask: shifted mask defining the field's length and position
+ * @mask: shifted mask defining the field's length and position
  *
  * FIELD_MAX() returns the maximum value that can be held in the field
- * specified by @_mask.
+ * specified by @mask.
  */
-#define FIELD_MAX(_mask)						\
+#define FIELD_MAX(mask)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
-		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
+		__BF_FIELD_CHECK(mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		(typeof(mask))((mask) >> __bf_shf(mask));		\
 	})
 
 /**
  * FIELD_FIT() - check if value fits in the field
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to test against the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to test against the field
  *
- * Return: true if @_val can fit inside @_mask, false if @_val is too big.
+ * Return: true if @val can fit inside @mask, false if @val is too big.
  */
-#define FIELD_FIT(_mask, _val)						\
+#define FIELD_FIT(mask, val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
-		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
+		__BF_FIELD_CHECK(mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
+		!((((typeof(mask))val) << __bf_shf(mask)) & ~(mask)); \
 	})
 
 /**
  * FIELD_PREP() - prepare a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to put in the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
  *
  * FIELD_PREP() masks and shifts up the value.  The result should
  * be combined with other fields of the bitfield using logical OR.
  */
-#define FIELD_PREP(_mask, _val)						\
+#define FIELD_PREP(mask, val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
-		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
+		__BF_FIELD_CHECK(mask, 0ULL, val, "FIELD_PREP: ");	\
+		((typeof(mask))(val) << __bf_shf(mask)) & (mask);	\
 	})
 
 #define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
 
 /**
  * FIELD_PREP_CONST() - prepare a constant bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to put in the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
  *
  * FIELD_PREP_CONST() masks and shifts up the value.  The result should
  * be combined with other fields of the bitfield using logical OR.
@@ -130,30 +130,30 @@
  * be used in initializers. Error checking is less comfortable for this
  * version, and non-constant masks cannot be used.
  */
-#define FIELD_PREP_CONST(_mask, _val)					\
+#define FIELD_PREP_CONST(mask, val)					\
 	(								\
 		/* mask must be non-zero */				\
-		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		BUILD_BUG_ON_ZERO((mask) == 0) +			\
 		/* check if value fits */				\
-		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		BUILD_BUG_ON_ZERO(~((mask) >> __bf_shf(mask)) & (val)) + \
 		/* check if mask is contiguous */			\
-		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
+		__BF_CHECK_POW2((mask) + (1ULL << __bf_shf(mask))) +	\
 		/* and create the value */				\
-		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
+		(((typeof(mask))(val) << __bf_shf(mask)) & (mask))	\
 	)
 
 /**
  * FIELD_GET() - extract a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_reg:  value of entire bitfield
+ * @mask: shifted mask defining the field's length and position
+ * @reg:  value of entire bitfield
  *
- * FIELD_GET() extracts the field specified by @_mask from the
- * bitfield passed in as @_reg by masking and shifting it down.
+ * FIELD_GET() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
  */
-#define FIELD_GET(_mask, _reg)						\
+#define FIELD_GET(mask, reg)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
-		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
+		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET: ");	\
+		(typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));	\
 	})
 
 extern void __compiletime_error("value doesn't fit into mask")
-- 
2.43.0


