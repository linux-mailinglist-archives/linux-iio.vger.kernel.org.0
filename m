Return-Path: <linux-iio+bounces-27535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029DD01FA1
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 10:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 315EE3000917
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C0342CB3;
	Thu,  8 Jan 2026 08:41:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39170279DCA;
	Thu,  8 Jan 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861695; cv=none; b=lIJeb4nJKEObWUFaFXq9l87q6TIiIT41YfZHDUaPv4b+G1oVBZ8LDIqHJI3QAWMBsCAMNJG+dvZECElq+fR/7f0mLGvPjdQ53mcY581vamQDC4kWq/iUGROtgkUOYto7feK7uQ/mOX9mXDG0lYqCfIxMngBSS6DcKo8YNtOOBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861695; c=relaxed/simple;
	bh=VHn/pX8B0r2xgMeONvegJf13IGeipGnx1l4MJJFmvPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZSuIg2YYzXdEDkjqHbWXCYkj6HsB7/2vRf73AKkFlJAxNfDVuVksN7+RHtdDg9v1JvH5GIO514T1h9YxD4iTUZBnigPx9jMXuPxWE6DdjWEZICpUtQi9fmyE0fm4vIf+Ev++5JK4TdiUensHmYMaCLk6DLQlC11YFFqhsvdOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXZMupbV9pc0QcBA--.38873S2;
	Thu, 08 Jan 2026 16:41:14 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: mazziesaccount@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] iio: adc: ad7476: Remove duplicate include and sort the rest
Date: Thu,  8 Jan 2026 16:39:24 +0800
Message-Id: <20260108083924.2579676-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXZMupbV9pc0QcBA--.38873S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww18Wry7KFWkArWrAF1rtFb_yoW8Jw18pF
	4qkF4kJrZ8Aw18CF17uF12kF9xXan5ur1UtFy2ga4UZ3y3tFnYgw4kCrn3tr1kAFZFgF4D
	GFW3Grs8CrW5ZrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_XcC_AcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRCCJPDUUU
	U
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate <linux/bitops.h> and sort all headers alphabetically.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

- Alphabetically sort all header files.
---
 drivers/iio/adc/ad7476.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 1bec6657394c..51bd81b2eb0a 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -7,21 +7,20 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
-#include <linux/gpio/consumer.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
+#include <linux/sysfs.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-- 
2.25.1


