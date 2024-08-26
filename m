Return-Path: <linux-iio+bounces-8812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451B95F983
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9DB1F21C8B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 19:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692491991AB;
	Mon, 26 Aug 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMSoajMn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A47A15A;
	Mon, 26 Aug 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699857; cv=none; b=kBD9bISOz9G5QAFOpYmGySHwBnRcp1iY6nOOCYVkNBpGSW8USPdPsFChgjCKeBBnHbxw6fTtp6+Sk753kwlRAhRzh1hh6rcQKhjrbwPm6hv8AGu8YBut/0jb/WNjlI4A5AXnCcCspxKZoUJz57MubM4Lots2ZhwE2b815a55DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699857; c=relaxed/simple;
	bh=wiVlvgkqXv9AvtQSdNRQc3BgNCET19jA2zq8BNr3fw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj/7D3xWCo9lvXSTrgX2YMU7pHXpddTrJIWlGNlrQVdZPI5O7o1d6NREy5MpjbXdHV/fD0/730PQBSms75KV90Ho3ShUaJbV4RBveSuNhwJJGULo6bSxHvD0dactAdxE2oHv177vPPzYDhmz8LRHRcYArZQ84cIUl7ef14w02uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMSoajMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFB1C4AF0C;
	Mon, 26 Aug 2024 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724699856;
	bh=wiVlvgkqXv9AvtQSdNRQc3BgNCET19jA2zq8BNr3fw8=;
	h=From:To:Cc:Subject:Date:From;
	b=VMSoajMnxsG64CGNlouxP6pCOINpx1pm+/nS6FP8NvP9XVnaEwM3EgJTxU0bKPtSU
	 0Bndk2s7SdEKHzd2vJaX6d265DUxuD13z0M/FZB/fbF/efKHmdhqSDGqVC9qO6cQLB
	 Mvio2I+hDghnJ+LMHTsDeWfuevc5ooypOYIfeyoBFSQy/EkE/CacFdJr8LhXiFtJ+0
	 cILFF5MVCL4Vlnf8v7FUTl/IFXtyGITu0NaUPhfQU4oY14guOtdEL/Mja4E1JGqo3z
	 LhYqRjv19tuo0TAQgYU4d5ejGXiZ3doUEraeX/x5t6itrm6oJDNYpdv7KHultxRe0b
	 GBx/R9sz30PNQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: mcp320x: Drop vendorless compatible strings
Date: Mon, 26 Aug 2024 14:17:28 -0500
Message-ID: <20240826191728.1415189-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendorless compatible strings are deprecated and weren't retained
when the binding was converted to schema. As a result, they are listed
as undocumented when running "make dt_compatible_check". Rather than add
them back to the schema, let's just drop them as they are unnecessary.
Furthermore, they are unnecessary as the SPI matching will strip the
vendor prefix on compatible string and match that against the
spi_device_id table.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/iio/adc/mcp320x.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index da1421bd7b62..57cff3772ebe 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -459,16 +459,6 @@ static int mcp320x_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id mcp320x_dt_ids[] = {
-	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
-	{ .compatible = "mcp3001" },
-	{ .compatible = "mcp3002" },
-	{ .compatible = "mcp3004" },
-	{ .compatible = "mcp3008" },
-	{ .compatible = "mcp3201" },
-	{ .compatible = "mcp3202" },
-	{ .compatible = "mcp3204" },
-	{ .compatible = "mcp3208" },
-	{ .compatible = "mcp3301" },
 	{ .compatible = "microchip,mcp3001" },
 	{ .compatible = "microchip,mcp3002" },
 	{ .compatible = "microchip,mcp3004" },
-- 
2.43.0


