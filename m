Return-Path: <linux-iio+bounces-16408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73849A4FB18
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADB83AEFF8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14693205E16;
	Wed,  5 Mar 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6hAhl49"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A28205AB0;
	Wed,  5 Mar 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168902; cv=none; b=XMgDClmZjc0YvG8yupyvvbdVfQuOVpZziKzBqPCLf6E+DFR6qNbDjRJvVPjOb5wp6gEKnUYlu5zh0hVZR7kGaP1CQbI+tGAqYtzA4Cek7IQikaOzAE+nvLnmZu3+7OHqGmXYlIJfiEaGKmOGAtNGgpXNqB+MAZ8cYTwXx2gxQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168902; c=relaxed/simple;
	bh=1nIsRNc3Lh78MiadvQxVA9dZBYCTinDpe9nUk8DVt+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gbHqY+Xm6QrcBJFTNkeQEiSkPoGxH+kBu/bmE9t5/saAnYDhwVMuYlEpXCymFgmBGr+2BQagvW0ZxZ4oRLqdY4byqyKv6fKdMRgUNmqbLFgPFkDGtXxi3q2lJaMmJAmyFMdlnHlopFNeLu+RaHji8zGLg3q7AVgulE71Xue0qWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6hAhl49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203DDC4CEE2;
	Wed,  5 Mar 2025 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168902;
	bh=1nIsRNc3Lh78MiadvQxVA9dZBYCTinDpe9nUk8DVt+g=;
	h=From:Date:Subject:To:Cc:From;
	b=X6hAhl49+hDCpkMEOjmGnpsNm4VU9eLFAEo3RPawtan9YFA9ZrZ8ycCxQ4+GERR99
	 qLZgiiJsnJ/IkxmALY+uBXBA53+mDJRfqIrKQ/57GCLv6Mn25Tb+TRm4ZHXxn74c7v
	 SrMlAZO4QdKfc5sf0txRVsi+CTrtZO9GNnJdAwLoTr1bSsjMveoOvp9vGWX2f1TR7n
	 RyQdUv2f8p+ogv8ZVC1zHDPMpY2cwkigS/wPI8X3KaqLAkN3dZCtIVNU4BpzV8Xavu
	 Oxv+nTyyH3WHQptgqe9L7oeZQjtepHBpFUNj9NEFIz7C+9QIWixEllvf76ZFX3yNbY
	 5kEf+DtqXcH7w==
From: William Breathitt Gray <wbg@kernel.org>
Date: Wed, 05 Mar 2025 19:01:19 +0900
Subject: [PATCH] counter: microchip-tcb-capture: Fix undefined counter
 channel state on probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAO4gyGcC/z2NsQrDMAxEfyVorsBJqqH9ldLBVeRGQ2Mju6EQ8
 u8RGbocPI53t0EVU6lw7zYwWbVqXhz6Swc8x+UtqJMzDGGgMAbCYlKlIcfSvib4yZOHsmWetWD
 j179KceyJgiS6XcH33Ez6O78ez30/AL3L2DN7AAAA
X-Change-ID: 20250305-preset-capture-mode-microchip-tcb-capture-fa31550ef594
To: =?utf-8?q?Cs=C3=B3k=C3=A1s_Bence?= <csokas.bence@prolan.hu>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137; i=wbg@kernel.org;
 h=from:subject:message-id; bh=1nIsRNc3Lh78MiadvQxVA9dZBYCTinDpe9nUk8DVt+g=;
 b=owGbwMvMwCW21SPs1D4hZW3G02pJDOknFFkcyyYYzr5cwv16hz/rr9W/2cuLw/m6b1WFHOhr6
 vunLDS7o5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZjIGQ1GhtYdH04vfRIT6LrZ
 xPL8/qqTaTa2yrcTwloUEk29TeP/cjH84WCdeXSnU+Rs+YrAmUdfTtjGxygTz1P/weeDVJpIfmo
 WHwA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp;
 fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B

Hardware initialize of the timer counter channel does not occur on probe
thus leaving the Count in an undefined state until the first
function_write() callback is executed. Fix this by performing the proper
hardware initialization during probe.

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Reported-by: Csókás Bence <csokas.bence@prolan.hu>
Closes: https://lore.kernel.org/all/bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu/
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
This should fix the issue where a user needs to set the count function
before they can use the counter. I don't have this hardware in person,
so please test this patch and let me know whether it works for you.
---
 drivers/counter/microchip-tcb-capture.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 2f096a5b973d18edf5de5a2b33f2f72571deefb7..c391ac38b990939c6764a9120a4bd03289f68469 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -368,6 +368,25 @@ static int mchp_tc_probe(struct platform_device *pdev)
 			channel);
 	}
 
+	/* Disable Quadrature Decoder and position measure */
+	ret = regmap_update_bits(regmap, ATMEL_TC_BMR, ATMEL_TC_QDEN | ATMEL_TC_POSEN, 0);
+	if (ret)
+		return ret;
+
+	/* Setup the period capture mode */
+	ret = regmap_update_bits(regmap, ATMEL_TC_REG(priv->channel[0], CMR),
+				 ATMEL_TC_WAVE | ATMEL_TC_ABETRG | ATMEL_TC_CMR_MASK |
+				 ATMEL_TC_TCCLKS,
+				 ATMEL_TC_CMR_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable clock and trigger counter */
+	ret = regmap_write(regmap, ATMEL_TC_REG(priv->channel[0], CCR),
+			   ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
+	if (ret)
+		return ret;
+
 	priv->tc_cfg = tcb_config;
 	priv->regmap = regmap;
 	counter->name = dev_name(&pdev->dev);

---
base-commit: 8744dcd4fc7800de2eb9369410470bb2930d4c14
change-id: 20250305-preset-capture-mode-microchip-tcb-capture-fa31550ef594

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>


