Return-Path: <linux-iio+bounces-28014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639DCD3B99C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7BCB300A91C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86532E752;
	Mon, 19 Jan 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9X4VrMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73831065B
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857708; cv=none; b=TOLKlWXrDbRL/xi1U6fI9RtLiLynY05wZhvi285YqJX3KYxHdkADMb5XKuZn0md8IlidjzRqnFhNYcEaODvClrr0kf+DhxFFZK8kMHc+y+81RffScyvk7ZfWcplfwBeXUfV47VZEt3b1nOvyCpjCAy2A6mJfgynEGhxFHMe2Ato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857708; c=relaxed/simple;
	bh=3XugZIoI+oppjdx9JrYyR++viWQCU8JCAPwzFxVt0GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2V8EUQmoD0D6NsKYqqDBzcf/SAUoFI7RUWPb745GGRe8juusCWuDPVFDee690cxtgf/hm0nByWtYi9DGyxaobjcFTzDWeXK0cqAg9uBMNQn8gVkEig5FGL1ugKXkyirvci6bgNiVq6g7hzlg1nbI4z93qtITuVK/120HG88a/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9X4VrMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C3C19424;
	Mon, 19 Jan 2026 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857707;
	bh=3XugZIoI+oppjdx9JrYyR++viWQCU8JCAPwzFxVt0GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9X4VrMWW5rQ/gV+VR/FXXSc1VgDySS52wrdIqsp68SetqRBdrxTsS5MRHrnPnc7w
	 pTFN3t1YkxKIgICz2Qt5SzDjNnYvW0XJdkjg8cYcyjnkSvBBofBjTXqH7qi0ORcIul
	 kzUH0+9j6qECZUU4ommYRmO6wRBFe4aaFaooM7La7AmsCV2sQIeMHOlMDyRYH3GuL9
	 Ba6A2hjoEmY/+NSaeno7kd2jLIcPWDd768vZdTkM5ZvvF7cFrsDlUX+ioOG+sFHUtM
	 sGJKfPlGnBxbGbnjfzWrRsQon1xDtrvEeeTRmqFxXYl3Gf9Nz11nqT7SjBbUBJ2ptD
	 VZOKzVUNfymDA==
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
Subject: [PATCH 05/11] iio: adc: max11100: Improve include relevance
Date: Mon, 19 Jan 2026 21:21:04 +0000
Message-ID: <20260119212110.726941-6-jic23@kernel.org>
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

Using the iwyu tool to help, drop kernel.h in favor of more specific
headers.
Also drop a delay.h and iio/driver.h as neither was used.
Add other headers that were relying on indirect includes.

Justification for additions:
  #include <linux/array_size.h>      // for ARRAY_SIZE
  #include <linux/bits.h>            // for BIT
  #include <linux/compiler.h>        // for __aligned
  #include <linux/dev_printk.h>      // for dev_err
  #include <linux/device/devres.h>   // for devm_add_action_or_reset
  #include <linux/err.h>             // for EINVAL, IS_ERR, PTR_ERR, ENOMEM
  #include <linux/minmax.h>          // for __cmp_op_max
  #include <linux/types.h>           // for u8

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max11100.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 520e37f75aac..f5adf7dba700 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -6,16 +6,21 @@
  * Copyright (C) 2016-17 Renesas Electronics Corporation
  * Copyright (C) 2016-17 Jacopo Mondi
  */
-#include <linux/delay.h>
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/compiler.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/driver.h>
 
 /*
  * LSB is the ADC single digital step
-- 
2.52.0


