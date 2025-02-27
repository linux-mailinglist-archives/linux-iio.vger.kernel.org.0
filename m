Return-Path: <linux-iio+bounces-16152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52835A4884E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 19:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A56188E985
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247391DE3BA;
	Thu, 27 Feb 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="lTXaJgDL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B425CC6E
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682336; cv=none; b=R9GcXHfrPtLgzD1AjGPLD/1GTY/v61TqMapgAQ7Su5JJIqDS6KEp/tF+mLAb6vLS1xcOupRJPW+vwdyj0K7fdwwHoBevMWDqSCBDlyndzlJZ7IB9oTE8mukmXPedzqV2wII6EaCa61AH9IuBzu9taf+tGN/rj2GRcQK+VL6wwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682336; c=relaxed/simple;
	bh=VrMIIw7LPPZy4RoPyOn/553vZWV0shlRFnyQkIIqvFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txbcFS55iJmEDN5LAkNhv6ibuFWlmIs6ibfJ0poU2F97HHga6+p9m5bcqz+Da6q2UxUeH5mL0OBC7m5G9/dcObydhaT9WgVf0bkFJfhgIVdquu8U7/GCG+ojhJ65MAJySTWNCfOiYEAsPLKWRV9AS4zLz5AyqkKz+rnDGye0x1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=lTXaJgDL; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740682334; bh=pMcozivu7dJDqecE4ZqBly6aZRxhwM+QCDCIXaMvZo0=;
 b=lTXaJgDLPUApqfZ2L8XwwIlWU2v0fPQBNO1HqV29P9awHkZdSuMfhhT+ypXAjtsUF2SC4NwIB
 C5S7gqo3dxirwrwO6ou2pr0oSjUEELbK5mYi87FnOVmEIhBRdcyk+LlMcY81LRIJTJK3MBAzQ/6
 j6qFxBamHKpgKNCGOiUPTlyOrR/8WrmScLe/4aKNk9YO2+kb76wBCqhFQqKV7mc3hJfQE1Y8nC3
 KcmzRaOmgv+xccJvOnRRO3RPQXDGWAmFgFJD6v/BraV/ub/R7kn+EYskK2+dzAKR2foGxr7Abgc
 oQysiwITTIVKqMJD9Rpdk287hL9LZAUkM8tdMC8RjnQA==
X-Forward-Email-ID: 67c0b1d2bf572996e8621499
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] iio: adc: rockchip_saradc: Add support for RK3528
Date: Thu, 27 Feb 2025 18:40:51 +0000
Message-ID: <20250227184058.2964204-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227184058.2964204-1-jonas@kwiboo.se>
References: <20250227184058.2964204-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Successive Approximation ADC (SARADC) in RK3528 uses the v2
controller and support:
- 10-bit resolution
- Up to 1MS/s sampling rate
- 4 single-ended input channels
- Current consumption: 0.5mA @ 1MS/s

Add support for the 4 channels of 10-bit resolution supported by SARADC
in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/iio/adc/rockchip_saradc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index a29e54754c8f..2619547d5d6f 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -275,6 +275,21 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.power_down = rockchip_saradc_power_down_v1,
 };
 
+static const struct iio_chan_spec rockchip_rk3528_saradc_iio_channels[] = {
+	SARADC_CHANNEL(0, "adc0", 10),
+	SARADC_CHANNEL(1, "adc1", 10),
+	SARADC_CHANNEL(2, "adc2", 10),
+	SARADC_CHANNEL(3, "adc3", 10),
+};
+
+static const struct rockchip_saradc_data rk3528_saradc_data = {
+	.channels = rockchip_rk3528_saradc_iio_channels,
+	.num_channels = ARRAY_SIZE(rockchip_rk3528_saradc_iio_channels),
+	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v2,
+	.read = rockchip_saradc_read_v2,
+};
+
 static const struct iio_chan_spec rockchip_rk3568_saradc_iio_channels[] = {
 	SARADC_CHANNEL(0, "adc0", 10),
 	SARADC_CHANNEL(1, "adc1", 10),
@@ -324,6 +339,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
 	}, {
 		.compatible = "rockchip,rk3399-saradc",
 		.data = &rk3399_saradc_data,
+	}, {
+		.compatible = "rockchip,rk3528-saradc",
+		.data = &rk3528_saradc_data,
 	}, {
 		.compatible = "rockchip,rk3568-saradc",
 		.data = &rk3568_saradc_data,
-- 
2.48.1


