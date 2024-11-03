Return-Path: <linux-iio+bounces-11873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508389BA761
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 19:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E12281730
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E02A1632E0;
	Sun,  3 Nov 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv9dgrYy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80970817;
	Sun,  3 Nov 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658307; cv=none; b=UBHWzR0r3Wg/3083/SEiC4O+QCvVfRc+CxyPgUUprD8iWnW6OknrsrJjZqm6VsBRIzkO8o+6NqORB0vbdrv38GRIZ9rnbMiTLKtoK6tI/pfNHRjVUPSN78XJSaoQ5+8/gGOYOqvpDnilgUJalbPP8hRqCZwDMbu1T5Ho8zq7lVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658307; c=relaxed/simple;
	bh=gCIaL/JjG/wAmPugcC+kEJYrC4MCgm7tSb3DijSsJoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ew03V6t58x/Q/S1MkjP58ysmuPeF4cBmcvpydHRqFrSO+iq1gf1enxGUw67RqnrBlMTCBaidqkVjRPmR2ytqM8S761wm5PtZkx4axsuD7RqFn88ufTaeWeLJcksU47I9eiC7hGYt1CXt7I6nDfXGTM3OzVosMwmG4lfi2tTR5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv9dgrYy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46098928354so25625811cf.1;
        Sun, 03 Nov 2024 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730658305; x=1731263105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzgzMpcRdmKNSKal7H2bOhmkB/Lh3IDIXdJcfZ+Ojsc=;
        b=Nv9dgrYyI7Mju+5eFUwPElvn5pILtZ4vt19DchnEsKHb8elgThKkhGvIvJm3Jec1Wo
         Y820ShdoVp/16OpzyF34vPZZSmNuC1VNOkwKOBZWTN98OzlYOQQduMlaFOdHOv9+9ymU
         wf492m8P5b/VOuCaihJL7/FtQoLGjrNUh+gIGQyPulyZj7iGM2YglEcIZP86rtlfGvH3
         7NZJ18LPXJRl1NvxkBvBHlaPEfpHfKVl4mmVp2mv/AeY9k5Z0jfpqDDxa0DkYb3DdI6i
         bmsiXLJDuXP+UyoMmoWQ9W0pHMPdegwMNrwotLisdyrS1dRgzOiF+WtjZmlx5e6D8JgG
         jUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730658305; x=1731263105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzgzMpcRdmKNSKal7H2bOhmkB/Lh3IDIXdJcfZ+Ojsc=;
        b=UsK9QpLOYfsM7z5kDiv9hVTbKJ3bMO4s074SsYyTZEZzLMXgeJpKUi4qEYhOw7cLbQ
         eW7jZDXtHwwW1JsK9RKTjyIMxOSRtuFy5dUCxAuzThEkcpj0EOO7igMgUqRLozIdTxKX
         t2IcVy+RUzGLTuptFEP9XTQeNM44lE1htr9EGOQ4f7/pF6PbyyePfQo3hslZIBQKsp43
         TNtFeSsYCsIhL/jUVEyr+SQt3DpNrsI4E7PdfVIwTLSLRrXfQ0YPzZ0E0Lz1YZnAsxyY
         0E843QNsLw+LzBZ7DMR5lhhZiebTOOslpPNvYp1u/RPjAHnCogeEUhhS3jWV6ocMIqmE
         kl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq5MiJLRTdHOvuTVqHMdhlqQ/ncmLDccYkUSdjnMImUW6AZ3Sq/PPkhtDTh6s1ibA8rQ/qotuRS0S1j/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JnFkdPeoUeXNZDexIw1RKWsg8cUolE/my2qdiLpPBAVRg+6W
	tit0J3vMVe7rLXqAHU1ihhlAnRa56oMdYZBwipVWPHxWaUGH0c+K
X-Google-Smtp-Source: AGHT+IEaw3nGMJ8bhhqo73g756ybtLD42XoRl05nXL1wjuN+i1W03TlspIeQ3fHjcuKr936uMQ2V8g==
X-Received: by 2002:ac8:5a87:0:b0:460:8bb8:fd79 with SMTP id d75a77b69052e-462b8646bc9mr145956651cf.12.1730658305244;
        Sun, 03 Nov 2024 10:25:05 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad19b328sm39287511cf.85.2024.11.03.10.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 10:25:04 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: fabrice.gasnier@foss.st.com,
	wbg@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	Jonathan.Cameron@huawei.com,
	benjamin.gaignard@st.com,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>
Subject: [PATCH] counter: stm32-timer-cnt: Add check for clk_enable()
Date: Sun,  3 Nov 2024 18:25:02 +0000
Message-Id: <20241103182502.8384-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiashengjiangcool@outlook.com>

Add check for the return value of clk_enable() in order to catch the
potential exception.

Fixes: c5b8425514da ("counter: stm32-timer-cnt: add power management support")
Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
---
 drivers/counter/stm32-timer-cnt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 186e73d6ccb4..0593c9b73992 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -214,11 +214,15 @@ static int stm32_count_enable_write(struct counter_device *counter,
 {
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1;
+	int ret;
 
 	if (enable) {
 		regmap_read(priv->regmap, TIM_CR1, &cr1);
-		if (!(cr1 & TIM_CR1_CEN))
-			clk_enable(priv->clk);
+		if (!(cr1 & TIM_CR1_CEN)) {
+			ret = clk_enable(priv->clk);
+			if (ret)
+				return ret;
+		}
 
 		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 				   TIM_CR1_CEN);
@@ -816,7 +820,9 @@ static int __maybe_unused stm32_timer_cnt_resume(struct device *dev)
 		return ret;
 
 	if (priv->enabled) {
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
 
 		/* Restore registers that may have been lost */
 		regmap_write(priv->regmap, TIM_SMCR, priv->bak.smcr);
-- 
2.25.1


