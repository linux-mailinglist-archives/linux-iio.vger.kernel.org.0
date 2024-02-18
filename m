Return-Path: <linux-iio+bounces-2731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE18859826
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66069281634
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0A6EB6C;
	Sun, 18 Feb 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buv6j611"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF26D1D7
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277277; cv=none; b=PpjecD9oV0UR5l/STKe9sNRra7MzgyPju1L3XVc4QMAwIgvm3jQY/3OlPr5Zkr2S1bI4sZcwo9Kj3cU/LXzDKgHIMEUgWWff1S1zXJV1isga+f9g3TjtUCs110k1CQ/2WCixS22Rey96zsWl7c8MLQI+N8LebisxEU0zYy5IauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277277; c=relaxed/simple;
	bh=Qbh3KQu1U1jvsDTiIMYm3P9ePXI/Bg3MgT1Zef7Qpcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGKTPliTc3IMh00toiCZou3ISCahdCI67BX+tisjKuwJjL1mTh39lxh3Eawt0voXhaOwRnTFPiD8F6ssdEb5zMCu9d1Orw3iT8MZyxUV84v5fC7LdQaEv4a10KU7jusV4UrQ+5zO04pNnLNqnvaGCrpaWVNhf2k8STRNOs9RSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buv6j611; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238ACC433F1;
	Sun, 18 Feb 2024 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277276;
	bh=Qbh3KQu1U1jvsDTiIMYm3P9ePXI/Bg3MgT1Zef7Qpcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buv6j611FbX9U8M+Bg5KQRHg7A8+Pp/HeRuDDqaZ0q6+raONCWDgc9s1dcMzCGHoQ
	 kQ2/3zVgdGdsdvm7harBUH2qAZFBPjAUAqoFHwOsfSy77CatGoed8v42ZM+FVkDvcS
	 zvKJ6m+rNWxQ0oEIK+QpDhzmyS7XVx2cfiLIB6DBDv6a+rrowRuCqMNPbxVs7KPqkr
	 u9dPpTOXFtP1uQSbW39xjOHf50srTePKnchsJDjIJGikV6aQKAgeCrFjlxvwve7Chf
	 ++4n6LLYx2fSIUPCOX3peBja9wOrtJ5NP83iLKPKR1TnfF+hqPvAWoVuUJOriWAkaW
	 TbWLK0OhxF5pg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/8] iio: adc: ad7292: Switch from of specific to fwnode property handling
Date: Sun, 18 Feb 2024 17:27:27 +0000
Message-ID: <20240218172731.1023367-5-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This reduces the wrong of device tree only IIO drivers that might
be copied by converting over this simple case.
Makes use of the new _scoped() handling to automatically release
the fwnode_handle on early exit from the loop.

Cc: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7292.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index cccacec5db6d..6aadd14f459d 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -8,7 +8,8 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -260,7 +261,6 @@ static int ad7292_probe(struct spi_device *spi)
 {
 	struct ad7292_state *st;
 	struct iio_dev *indio_dev;
-	struct device_node *child;
 	bool diff_channels = false;
 	int ret;
 
@@ -305,12 +305,11 @@ static int ad7292_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7292_info;
 
-	for_each_available_child_of_node(spi->dev.of_node, child) {
-		diff_channels = of_property_read_bool(child, "diff-channels");
-		if (diff_channels) {
-			of_node_put(child);
+	device_for_each_child_node_scoped(&spi->dev, child) {
+		diff_channels = fwnode_property_read_bool(child,
+							  "diff-channels");
+		if (diff_channels)
 			break;
-		}
 	}
 
 	if (diff_channels) {
-- 
2.43.2


