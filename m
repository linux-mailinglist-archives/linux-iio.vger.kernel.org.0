Return-Path: <linux-iio+bounces-28012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB7D3B9C7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0DAA3078BC9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4A32C929;
	Mon, 19 Jan 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcXMqybq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45E1C84C0
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857699; cv=none; b=R1bJC0VMXUmtfRCvnKqHPzW9bOkz+l3FzJUPSpjxOV6I53H4uy4lKROLCCU/DOoOuCqUeR4saJUQYIMVPdE0lA5B3MBD+WhSQJfSjo8FLJp23yytysLPwmfY5ughwVCyh4jdO4gDwmNRmqkvzdbmk5RgTaOf8VzhAai73MeP0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857699; c=relaxed/simple;
	bh=p2hEOJwdeOMQlq09wSYdqwdqG2AsHB774O70qihisAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA7TeJ/azhf5T/5qzZpGOKE0TggdczeFzECLEqUc3MaN0gWh+tcC7MUIonhQH7W0rGSwuCPL/3obdmSQ7i3Jpig/8Ihsv1EGfG2MnKEOKqr6XMi4/+DGsKphTiQIOZy2QXcp6v32Vg6CV7Wyya2ht6OUQAYsxwDn0WsiVdzWSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcXMqybq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4203AC116C6;
	Mon, 19 Jan 2026 21:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857699;
	bh=p2hEOJwdeOMQlq09wSYdqwdqG2AsHB774O70qihisAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcXMqybq0jX5PlPkJD5bH5EClRRYhNczrjDVQpJ9gvOtmGgcTAetp6jZ9vn8CjWew
	 uRUCB8o4kiVvpspmEaUkvJqnIYHTvDMqqt9Jn8LwqgrCq8WeC7LTBUvSm07IxqE3Pl
	 DhRh5PN9yLecHrr9oAQgrq2jaeCZe1SmI/quLmHdMqI41padKp4/nkysNaZl9mVWkv
	 Wf2rYJk+wF6GMpHYcECGJFF6Xc4ChifiJlTgMlrCuQa9R8F/DF9TYYHJvzIho+zKGa
	 P7l2xzBYPN0nJ7WgXwwYYe1Ef3f1gn008WQHQZLtlm9pHBLgvhUFRS8hhnzAPufpEu
	 6NN+UItRGKIMg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/11] iio: adc: max1027: Reorder headers into alphabetical order
Date: Mon, 19 Jan 2026 21:21:02 +0000
Message-ID: <20260119212110.726941-4-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119212110.726941-1-jic23@kernel.org>
References: <20260119212110.726941-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Only delay.h was out of place. Move that before adding missing headers
highlighted by iwyu.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 7e736e77d8bb..913665b52cea 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -12,11 +12,11 @@
   * Partial support for max1027 and similar chips.
   */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
-#include <linux/delay.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-- 
2.52.0


