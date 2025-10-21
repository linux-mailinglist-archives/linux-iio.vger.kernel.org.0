Return-Path: <linux-iio+bounces-25319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92DBF5C99
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A4FA4EDAF2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8622EC54B;
	Tue, 21 Oct 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="aKxoUAsO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD42D8DA8;
	Tue, 21 Oct 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042747; cv=none; b=gseiA7548ojoDdQMFaUbBsz3k1KQby7Sy21GBmlMwcDycp08Qd4dGdArrz3/8esZtnzlrHKVtHGZyt7hUcQwSNNCZ4Q5HIIFABDOFAPjrwSt2Ouis/pSdFy2TPnERNchsuvAahUK34gjSq47AR+w7KCFeE93MIbBsJsKvXQIyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042747; c=relaxed/simple;
	bh=x0+M2VBbyWHomw39G87rAcn3LPaa0F+XajfBshSRNb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VDOzSHNxCzassRWLy8JBxjsQGC7EaWDYIfImy5RGl0toPtcNugWPVnGd2aOh1sw2rTr2tRGTWGzH1xvo3YD4O3pYH38egtKEKwVOTyzhTbVMzlR3DiRHbmOTWCqL5V5mC7jEPsCMqkhdU3XmkV8o2VS8Rv0eEcwH4xxldTvUBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=aKxoUAsO; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id D7B8B160209;
	Tue, 21 Oct 2025 13:32:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1761042735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C69VDEnlJ993i84MSUP5xOSxw8IPxfTpITkaE/qkMso=;
	b=aKxoUAsOhPFRZPWtC5nbONXg/JSoF0KHrJa75CiO0FHPOSpE0tZtR0H84SGDITnbxGKIND
	S0xmXVu37KvaeKjRqjrQrla6SnyXcUYnZbRgnD/qWADQ9zR+rz7OugxXzp9/8Muz1W6Gy6
	U6AhXB3TaG3ns7D5q7Nsx/kygOXeQhOaC8cM05mkCD5k0Z5Km81DsaYAW5L3GCWdRG8/T8
	2w8lZFzMNLn7OC61QzHOILXp6kYsm0QPHIEPT8mBv5WyS+GPrf4bu5w3RgGAEMyubOWJAx
	fEnDS8zKneR4Vfv7W1JefgiFh4OP9ufxvkUg5rwn+G7NroidCaQIwp4ZKoWAYA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Tue, 21 Oct 2025 13:31:49 +0300
Subject: [PATCH] iio: accel: bma220: move set_wdt() out of bma220_core
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
X-B4-Tracking: v=1; b=H4sIABRh92gC/x3MQQqAIBBA0avErBN0QImuEiGWY83CCo0KwrsnL
 d/i/xcyJaYMffNCoosz71uFahuYV7ctJNhXA0rUSqISU3SI0mY67e1PG/eLhDRam6CNcnMHtTw
 SBX7+6zCW8gEyXmq0ZQAAAA==
X-Change-ID: 20251021-bma220_set_wdt_move-06556f561ac8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5325;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=x0+M2VBbyWHomw39G87rAcn3LPaa0F+XajfBshSRNb0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ozWVMxeVQxeDRqSi8vSE9IdkVBUFRUaUY4CnVXYk8yZGhqL1dNUWFXUHhq
 UnZkdUlrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzkyRXR
 BQW9KRUhRcko2ZGpPa2xqMStvUC8wMGp1d3M1YkxOY3ByTklyekZhWVpybGE0dkhMb0Vsak9hMg
 pCYmdrd3habG9pV1VoWjN6L0pUTnYwQVRXWC9PL0lkN2J0QzZqbkM0OVpvcWwwWWJMRE11aFgyc
 2dKY2VNNllxCitjeHJIajNLWit5TDVUenlVaytFYVlKRmg1dGZxNEVyN1oxZTBkMnZUVU0wQnUr
 SkU4OGNhV1l2WVZDVEF2dFkKZDJ6U2lkT0ZlTnlGOHkwSHhRcTNibjBwOGN6MGNaZ0RMa3FvdFQ
 xb05GczJFL2Rxb1JtSUJORVFRVUxWTWlBOApFQ0F3OVIvQ21QTTg4a0xKcGh4TWJ1eHVkemJTM2
 NtWUJMZFV4N01VOStaSElqWjV6d01lMmJjcFcxajRaN1RGCmlIS3VqRjBFdWY4R25QSi9ieTBqQ
 TlkK1JPdjR4ZFhNU29EbW1UcWwxTVhkTkwrM2tSTEVnVkdWVjRKUWJMY0QKdmZ5dkMrelJsRzdC
 a0N2Y1htTzdDZEM4Vklyem5qQ3Z0ZllTWjZ5dXk3aUY2MS8zTHBsbzU1WFNwR00yR1VvcwpiZ0F
 hZlVDVEhXcG1VZlZPWE1ZKzE3STJSTFpHbjhkcnFSRnlyb1lNeTVweWlsNGxzYi84aTVlRUZBbT
 hWOW55Ck92SzBmYW12SGtBYzFaeG5XRVFjYXlvRjEwcDNpdlovMWJzcTdFMDRJZHByY2dWY3owN
 Td4NnpmNUhKdklJZjcKNWMwWEVEOVlhV3VraitQdlpVdTJFazNybmcyK2p3enNURmZwbHZnVWN2
 bTZXWUFuK0w1OUtMUm9jc09tRnVsRQpzdi9aRTJDTjFiUFdlam50YVV1YWVXdyt5Wis0Ykg2RzM
 rQWIrU0JqaEYzd2MyWk5YZG5DRkZYWGJnWktxUWd6CnRJUFo3TUVSeHg4by93PT0KPWU4d3kKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Move bma220_set_wdt() into bma220_i2c.c instead of using a conditional
based on i2c_verify_client() in bma220_core.c that would make core
always depend on the i2c module.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510102117.Jqxrw1vF-lkp@intel.com/
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
This patch fixes a linking error reported by the kernel robot

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
head:   89cba586b8b4cde09c44b1896624720ea29f0205
commit: 3499375209ca839a741e775d579f8bb9b85529d5 [56/96] iio: accel: bma220: add i2c watchdog feature
config: um-randconfig-002-20251021 (https://download.01.org/0day-ci/archive/20251021/202510210604.mAtgE54g-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251021/202510210604.mAtgE54g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510210604.mAtgE54g-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/iio/accel/bma220_core.o: in function `bma220_init':
>> bma220_core.c:(.text+0x3f8): undefined reference to `i2c_verify_client'
   collect2: error: ld returned 1 exit status

not sure how to make b4 not send out the cover letter for 1 patch series
or how to make this patch a reply to the robot's email.
---
 drivers/iio/accel/bma220.h      |  6 ++++++
 drivers/iio/accel/bma220_core.c | 19 -------------------
 drivers/iio/accel/bma220_i2c.c  | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
index e53ca63de54b..00dfe275256b 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -11,6 +11,12 @@
 #include <linux/pm.h>
 #include <linux/regmap.h>
 
+#define BMA220_REG_WDT				0x17
+#define BMA220_WDT_MASK				GENMASK(2, 1)
+#define BMA220_WDT_OFF				0x0
+#define BMA220_WDT_1MS				0x2
+#define BMA220_WDT_10MS				0x3
+
 struct device;
 
 extern const struct regmap_config bma220_i2c_regmap_config;
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 871342d21456..f32d875b994e 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -11,7 +11,6 @@
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -78,11 +77,6 @@
 #define BMA220_FILTER_MASK			GENMASK(3, 0)
 #define BMA220_REG_RANGE			0x11
 #define BMA220_RANGE_MASK			GENMASK(1, 0)
-#define BMA220_REG_WDT				0x17
-#define BMA220_WDT_MASK				GENMASK(2, 1)
-#define BMA220_WDT_OFF				0x0
-#define BMA220_WDT_1MS				0x2
-#define BMA220_WDT_10MS				0x3
 #define BMA220_REG_SUSPEND			0x18
 #define BMA220_REG_SOFTRESET			0x19
 
@@ -443,12 +437,6 @@ static int bma220_power(struct bma220_data *data, bool up)
 	return -EBUSY;
 }
 
-static int bma220_set_wdt(struct bma220_data *data, const u8 val)
-{
-	return regmap_update_bits(data->regmap, BMA220_REG_WDT, BMA220_WDT_MASK,
-				  FIELD_PREP(BMA220_WDT_MASK, val));
-}
-
 static int bma220_init(struct device *dev, struct bma220_data *data)
 {
 	int ret;
@@ -477,13 +465,6 @@ static int bma220_init(struct device *dev, struct bma220_data *data)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to soft reset chip\n");
 
-	if (i2c_verify_client(dev)) {
-		ret = bma220_set_wdt(data, BMA220_WDT_1MS);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to set i2c watchdog\n");
-	}
-
 	return 0;
 }
 
diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
index 2b85d4921768..8b6f8e305c8c 100644
--- a/drivers/iio/accel/bma220_i2c.c
+++ b/drivers/iio/accel/bma220_i2c.c
@@ -8,6 +8,7 @@
  * I2C address is either 0x0b or 0x0a depending on CSB (pin 10)
  */
 
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -16,16 +17,27 @@
 
 #include "bma220.h"
 
+static int bma220_set_wdt(struct regmap *regmap, const u8 val)
+{
+	return regmap_update_bits(regmap, BMA220_REG_WDT, BMA220_WDT_MASK,
+				  FIELD_PREP(BMA220_WDT_MASK, val));
+}
+
 static int bma220_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
+	int ret;
 
 	regmap = devm_regmap_init_i2c(client, &bma220_i2c_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap),
 				     "failed to create regmap\n");
 
-	return bma220_common_probe(&client->dev, regmap, client->irq);
+	ret = bma220_common_probe(&client->dev, regmap, client->irq);
+	if (ret)
+		return ret;
+
+	return bma220_set_wdt(regmap, BMA220_WDT_1MS);
 }
 
 static const struct of_device_id bma220_i2c_match[] = {

---
base-commit: 89cba586b8b4cde09c44b1896624720ea29f0205
change-id: 20251021-bma220_set_wdt_move-06556f561ac8

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


