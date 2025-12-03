Return-Path: <linux-iio+bounces-26710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F53CA1669
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 20:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040D2306A048
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0929309DDD;
	Wed,  3 Dec 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcIiVkSL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32094334C30
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789591; cv=none; b=PvysVzlDSI+y34BgZJTJLh7lBB+dY0RRnJIckmMfgLidhbEBGMcmmdigwqhmz+bHeOvEQTGamczYLXuzzC8mLBDfeBmD4RjV4gn1rtUIfCMjL+yLoVjGkMOfpul4I43L37aEM4nhpS519WkJ97VAd+VgesLbG0Rdzkee+IcoCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789591; c=relaxed/simple;
	bh=5LWmoRG7H6ScrVOX1yqApC95YUrJNY9xx2uup5Dpa6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7Sf9fGcbuLvuEJ2zhzeqfvKyhSsQzecluevNqVj1XtWBlzivZFZn8J9pVceBVeZ4F2AaTG1nlwerAFEtrasduB+6ynCp0rjvtNNGYfnXGFO5gdRdhKAthKFz1UVJAqUFiR6vUWW6CH6gAV3/CY10aO364733Qzdnot1BCJuD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcIiVkSL; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-55b6a642a4cso59925e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789588; x=1765394388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCMSC4ZdX+c86qaeQmzzAFf+CmeFbnP3hRbbGI3Ok1g=;
        b=WcIiVkSL4S908496iQrupJxqJj8iVW96rOIzel2r9i+tdZojAlz6+5arSyC27SWRnQ
         1rrplHxwwTUIl7EPd51Y3eRQTcfG9C/vgKaoJ5kjtUlNr6gZndIJnNQAMf0wvau7yHnL
         wl2aYKuWjAKHKoWKTMiz7x84wid12PyncA9ZsQU+62q8Uxywe2BOWDlud5RMBC1DwkEB
         9ySsdY5BP52j2lKk7tR4KbOJRBd6GztvWMzD3kVuqC2wydqjlJQMgwydQx0xBozbrwoC
         tSMDvo/Jh6l2PvdIyZpgeO6fDROmyIEEq4qp4FLc1JGbRDogpb9UDwlPmEi7+q4SBx7l
         EYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789588; x=1765394388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCMSC4ZdX+c86qaeQmzzAFf+CmeFbnP3hRbbGI3Ok1g=;
        b=cZS0D4IXQAM/M3B64gYJkAqaUaoLVFreRD4VrmpsHMvOEXPQE27ZyydPLSagADwWYl
         1UlLsxlXTaD2B0LrRYgPDAC/jkOaBsJWu5B+6LM3F5lIOdhP2WQlmYX2NcAtr+4WY66C
         6VXf45h4B1fnVasnUwDuM/ylukEfD2dPTilXFyNRMRP9IHF6jiNweJtxFpx/0yJ11FRn
         THNePN3AeeFIU3MUX8dXnSC+EdyWJ3L1mUCR8NV+JXXZaIGoYuANQrHSsf936AcyEcbg
         FIfN9NJckEh2sSWj2YuQrYne1SQAJP3vB/Y5ybY5ZnWXKPVNHjnZaZV44uJneMh68RCw
         +n2A==
X-Forwarded-Encrypted: i=1; AJvYcCXXtzYewrsj7jnp8qNuBPIYTHtSdsxUjUQfjiax5+TxCIK/ricq2krBbpBB9Bxv5yTWvmTyc9jz0MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzVE4fnF2eBcV20W6wITYUru+Bn5jStK6r1vgmuLURQTkNFiA
	uHsZvgIDv27gASrwaauu988Rbn2yhhADNrVAAzBL6oEL2HbUGRscdRNY
X-Gm-Gg: ASbGnctTR5aedEIEsqiVY6aYUJ4Cs1RBQ2ZAOPoHzvPgOG1SovQFBjWsX+MuzWbZbiB
	wixIU9R0t71J/GYb9O2lSDe+ivq+gcm/iG3z/eUdD622pCfWJzK4trlC8JCuNjPhv7lzqQwuK0q
	3U5/hQjLhj8YmDKly8Izcn2BAXqAXKcN4baDt9F4i31/ss+vv/pCx1KMUtmLDBZWbmJGC8+9t/y
	hor9oK5J6ga7sHCg8959QC+Wxy+AyKMRO9mZpH7vRxk2hjpaQCQ8gfh9kl5NqJCIycr0af13wp9
	LnKadfNOLAUDT5+azm/TJRO/194h5RzzWepCFU+H7Uw+0qE0I9HkPXWfYaVsLxMNI12+KelmM1U
	pte/m0PtGOzqEmyGmb87c8cnD+SibtuYGxWxd2O6SW286zMsD7cPkvWV9XKe1+DGB9J5erhwDo9
	STpMfXwy7hYhCE
X-Google-Smtp-Source: AGHT+IFk8XZAOaH77q9ncYwj5ivBaMaGN004Yn3MrPEPkmNwBZ4+3rBREF9IL/COlAv/4FynqjfJ4w==
X-Received: by 2002:a05:6122:8b1b:b0:55b:305b:51b4 with SMTP id 71dfb90a1353d-55e69feb72dmr3679e0c.17.1764789587828;
        Wed, 03 Dec 2025 11:19:47 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf4e1d56asm8121346e0c.4.2025.12.03.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:19:47 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 03 Dec 2025 14:18:19 -0500
Subject: [PATCH RFC 5/6] iio: health: max30102: Use cleanup.h for IIO locks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
In-Reply-To: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=5LWmoRG7H6ScrVOX1yqApC95YUrJNY9xx2uup5Dpa6M=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkGva7viiOPzfhv71ypcyx8xVbh/zuu3q9R7Gx8te9Sk
 3/zjhdzOkpZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiJewM/71M0p6vjLdcv4vt
 V5Z7qcrq5dobGUtLuyPP/9wQ8NdD3pThn2XZnclxvY8j6pYseu6w/wXnqoCKtXlL2hxNBQV3H5e
 rYwQA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Simplify and drop "hacky" busy-waiting code in max30102_read_raw() by
using scoped_guard().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/health/max30102.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 678720102f2b..c642842cb5fb 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -24,6 +24,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/cleanup.h>
 
 #define MAX30102_DRV_NAME	"max30102"
 #define MAX30102_PART_NUMBER	0x15
@@ -468,6 +469,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 {
 	struct max30102_data *data = iio_priv(indio_dev);
 	int ret = -EINVAL;
+	bool direct_en;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -475,25 +477,13 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 		 * Temperature reading can only be acquired when not in
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
-any_mode_retry:
-		if (!iio_device_claim_buffer(indio_dev)) {
-			/*
-			 * This one is a *bit* hacky. If we cannot claim buffer
-			 * mode, then try direct mode so that we make sure
-			 * things cannot concurrently change. And we just keep
-			 * trying until we get one of the modes...
-			 */
-			if (!iio_device_claim_direct(indio_dev))
-				goto any_mode_retry;
+		scoped_guard(iio_device_claim, indio_dev) {
+			direct_en = !iio_buffer_enabled(indio_dev);
 
-			ret = max30102_get_temp(data, val, true);
-			iio_device_release_direct(indio_dev);
-		} else {
-			ret = max30102_get_temp(data, val, false);
-			iio_device_release_buffer(indio_dev);
+			ret = max30102_get_temp(data, val, direct_en);
+			if (ret)
+				return ret;
 		}
-		if (ret)
-			return ret;
 
 		ret = IIO_VAL_INT;
 		break;

-- 
2.52.0


