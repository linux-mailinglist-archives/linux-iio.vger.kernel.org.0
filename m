Return-Path: <linux-iio+bounces-21647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D5B04CF6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 02:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5755603FC
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 00:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963317A31C;
	Tue, 15 Jul 2025 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MI77X64Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA704400
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539471; cv=none; b=XJm/IwP0swFgQJTmPt/YRKP7mUqr1jcLsjXJGB9btoah/h12mtOsEhRDEdYfdIr4eJCDCth+KYn81S/gKUvHuGdDsG3Jo/K91ZBYFVBKjBLj0vNDjcXP8vJfAkDH8kGT3l0MQo0AC+2gD96KtbeStbhu2gNrXcu/kQCXTCkj2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539471; c=relaxed/simple;
	bh=KHBShwx13Brlud17Z84sprTSDgu/vR45VEn53e6CKaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SJqwpHk4MkF3VJ5+WX1UzF40LjkuFZ0I/fY6Ek24sMQKo/nJr7jFZz09WEebKULclYKg64Zw16IP+qp5kh2w60IE8e29R5RMxnRixY1JDJQhIIFdZPpImmO+iVPsoh6cVWGcWOH6A0HTT5ZOelWmyPqzQY0nnRbFbehr22myjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MI77X64Q; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752539467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=STz3NT6y6RagnMrWHCWQVdhmEkfEks/Zf/QqC5h+S6I=;
	b=MI77X64Qk12m0jlXaX1oaaVF57JMt0SPnnWdfBwKx21W3OGkYlad02xZbas7370vNOuoKm
	wI2DgPZ/K3H+XspGMc96jx89bdm/iqLhCIrQ36SdL6/kSNLr/tMdrDd/EkZUlQPiTSQpJ3
	h2WdTAQ+M2KTf2DHuJTR7/4NdB97+kg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	David Lechner <dlechner@baylibre.com>,
	Manish Narani <manish.narani@xilinx.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
Date: Mon, 14 Jul 2025 20:30:58 -0400
Message-Id: <20250715003058.2035656-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

AMS_ALARM_THR_DIRECT_MASK should be bit 0, not bit 1. This would cause
hysteresis to be enabled with a lower threshold of -28C. The temperature
alarm would never deassert even if the temperature dropped below the
upper threshold.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/iio/adc/xilinx-ams.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 76dd0343f5f7..552190dd0e6e 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -118,7 +118,7 @@
 #define AMS_ALARM_THRESHOLD_OFF_10	0x10
 #define AMS_ALARM_THRESHOLD_OFF_20	0x20
 
-#define AMS_ALARM_THR_DIRECT_MASK	BIT(1)
+#define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
 #define AMS_ALARM_THR_MIN		0x0000
 #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
 
-- 
2.35.1.1320.gc452695387.dirty


