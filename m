Return-Path: <linux-iio+bounces-14367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB07A11121
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 20:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40D3188A54C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FDD20013A;
	Tue, 14 Jan 2025 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDvgN8UM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401241FA8DE
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882845; cv=none; b=RP2Q15jjXUplHivZCZo/G+Xu5qvVgB5Ut3Dw+WjkMvQ+5ztOltu/nBA5gHa2jJMd3u7lsB+Q4YvRNVW5KG1dF4J/p+NwUy1AS1ebCPO2helsr44MaSv7BV65xaSnw/IRA4NASLCb91Hyq32FF/yYle8EUGuZCj1Yf8a8htPdEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882845; c=relaxed/simple;
	bh=mJi6GnXy4LDsOlCNbk9P6FF1C8Z0lp8SctmxZWGHlS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4e1Rk0UcIWXqLn8auObW3zpQo0Sl+NBhWcnVqnzMfCNPIEdNuNoE3mrfavVGmCODQ+rHl39KbLOMuqVt5gOATE0IayT0WYKi9yc562aUt9K8P+3at1z0vpRkXD9J16ZQzR5Wm2fmPjmRu4zsGDCPmUZHDmta0pvFYgCYTpDqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDvgN8UM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43637977fa4so6342415e9.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 11:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736882841; x=1737487641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPM5vD2x779JQ5NuhyYaXL78U9hXgGymUtmEf6+ZKWE=;
        b=JDvgN8UMu3cbKONzd/Wb3x0TwPjl2MXD7+OOrC5UJwZHcDdnRdMtEOymyHTaDrF/Jg
         fgJWYqJdoR/I8gl8KTT0b1WsyXX5qaxQtrhu0PgPPtGG/yC6aL+uexT+d4nW+yXBeyy2
         GSHMKyuNeNtQh/PPKCt0Fp3v8tMoUexf5g2N4/qATEwCfFbRwzHSfLYyqhn8baMnPkGh
         kKYe6YpaEWMrFyp1yfBo6ul8oj23Q6jHNvMo2EL4/R9thSQVYMEb0+ZGNAJ4kD/pvJj7
         1fKP1SpkE4h9Vkd8E+/jqSPWtMnKp3MAPQz2DzBetzAbaYV9MsZ3bDHle8t+BgGfC0TU
         MxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736882841; x=1737487641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPM5vD2x779JQ5NuhyYaXL78U9hXgGymUtmEf6+ZKWE=;
        b=fRvLWxp+0KFckMgowCpPpE6EsMPAGzoL5SwROjcC1Ln+MVJyFV3Au3I//I/aRH5yw1
         a7SMJ/4i0VvtvvhlZz3s5QKgchGMQjNCHiQNzf0IaltHalr4IQC1QlMP5LbDrW+N11ai
         wGQ2zfsdYMz6TfiAKTMrHAXum13hTUj37cr/aLiu0Xbp4bLtrtJoQUBMh6fJg8nn9F1u
         3LjuiIdC2Hd/6Kqh2iVxk5Ji0Wep3Q0Qv35lsIo3vuucYC9M3Xb9zPoOzCP+LJG9CvXE
         IbSs8H23jRKraHEMmoQ1F/FA1wI9nsPGql9dU41TEErMrXhikx6MVTbsJpAe6cVqCQ+X
         VKZA==
X-Forwarded-Encrypted: i=1; AJvYcCWEQmsUxmJ67vVQb4MAGUz5SgnJeKTMrMsSJ2sEPWmFGLV0/nLLTd5/Xdydf0WeD5iZY/zJCE4WJhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6y1v6MfoQrcbxNm4lWVP/pXv4/SPtug/xFygQnqGQJOx5OLZc
	kEhsM7+Vqz/dFF8Fay4CnOddkXJuznoWpOUWhAVywEQvvZTQJyMw7XXxBOcSNCizLo+UUfG9+S+
	d
X-Gm-Gg: ASbGncsXJE4Uh78a52Q720WaFb43vr7YWsHxl8Sm+WpT1DTtPL5mkEpzyB4+uSzk9Vc
	gRKQ/ow3CXd/gEqJM2t4UguBlNyBGebCthIAEvbSnF/rfnfD+8KFavSUyIJFQ3wy09m9KnShEUK
	9MT1xfAzMU5y5HAL63bfPNSGGeBVsakWVM51WATZOwLo2I8nH++esajGPrkH4zYdQ8HHjvumMuk
	3+YvB20bijaUzGoABBPn8FuYYiYGsxeBmHjSmTaw1biyHMnzgayzoRcSbL9DNymy23cemw=
X-Google-Smtp-Source: AGHT+IFtXsffWVvFqei1fzzHQaLxwIUzUZSKHYSUinUBEyVTxZbD2VDGLWTq9GRwHabTVKS1bHaOpA==
X-Received: by 2002:a05:6000:18a3:b0:385:edb7:69cc with SMTP id ffacd0b85a97d-38a87310a82mr8853782f8f.12.1736882841412;
        Tue, 14 Jan 2025 11:27:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d007sm15532253f8f.20.2025.01.14.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:27:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] iio: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 20:27:16 +0100
Message-ID: <20250114192716.912476-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/humidity/dht11.c    | 3 ++-
 drivers/iio/proximity/irsd200.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c97e25448772..48c59d09eea7 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/sysfs.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
@@ -99,7 +100,7 @@ static void dht11_edges_print(struct dht11 *dht11)
 	for (i = 1; i < dht11->num_edges; ++i) {
 		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
 			dht11->edges[i].ts - dht11->edges[i - 1].ts,
-			dht11->edges[i - 1].value ? "high" : "low");
+			str_high_low(dht11->edges[i - 1].value));
 	}
 }
 #endif /* CONFIG_DYNAMIC_DEBUG */
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index b09d15230111..b0ffd3574013 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/string_choices.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -783,7 +784,7 @@ static int irsd200_set_trigger_state(struct iio_trigger *trig, bool state)
 	ret = regmap_field_write(data->regfields[IRS_REGF_INTR_DATA], state);
 	if (ret) {
 		dev_err(data->dev, "Could not %s data interrupt source (%d)\n",
-			state ? "enable" : "disable", ret);
+			str_enable_disable(state), ret);
 	}
 
 	return ret;
-- 
2.43.0


