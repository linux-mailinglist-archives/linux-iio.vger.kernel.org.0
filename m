Return-Path: <linux-iio+bounces-11563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D8B9B4B8A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 14:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94420B22EC2
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705E206965;
	Tue, 29 Oct 2024 13:57:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF7205132;
	Tue, 29 Oct 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210257; cv=none; b=YeCoKGeanagFVgkKjZR5BoGv6wG4qhCJsXkmBwlx5i0OyDQcyunTWJK9FlDXPldhms1a9jA42NaKxMwN2pYMv9RdEygPF7mpfsmZTpMESpLDgoa4slN+h0Y9qK78KQHWLqP9oPkUGuaZ0hSiKbw9myA/h+c3xhlK0j9znc8in7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210257; c=relaxed/simple;
	bh=QMT6f9Ox5H3aspFcQj99XAbFA7KbFQQoBtLwimMN2VA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drp3adqDBs0gGpWBlSNqSW35rZgz7gyASdjMYrboij4BT0nbCqJ4wHkK9dnnmnB8DGVjrBOwUsHK8IRk2uuJITp0dcoL4K3PrtwfS+4vck142SWWAwSBHyosa6dWL7JURcwhEaFIu+T17UmidaviOvSx90PKrj2xbiRnHQymhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdBcG1NYHz1jw2q;
	Tue, 29 Oct 2024 21:55:58 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 075CF1A0188;
	Tue, 29 Oct 2024 21:57:29 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 29 Oct
 2024 21:57:28 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <jic23@kernel.org>, <noname.nuno@gmail.com>, <nuno.sa@analog.com>,
	<lars@metafoo.de>, <Michael.Hennerich@analog.com>, <djunho@gmail.com>,
	<alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH v2] iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer
Date: Tue, 29 Oct 2024 13:46:37 +0000
Message-ID: <20241029134637.2261336-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028142357.1032380-1-quzicheng@huawei.com>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200012.china.huawei.com (7.221.188.145)

The AD7923 was updated to support devices with 8 channels, but the size
of tx_buf and ring_xfer was not increased accordingly, leading to a
potential buffer overflow in ad7923_update_scan_mode().

Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nuno Sá <noname.nuno@gmail.com>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
v2:
- Fixed: Addressed buffer overflow in ad7923_update_scan_mode() due to 
insufficient tx_buf and ring_xfer size for 8-channel devices.
- Issue: Original patch attempted to fix the overflow by limiting the 
length, but did not address the root cause of buffer size mismatch.
- Solution: Increased tx_buf and ring_xfer sizes recommended by Nuno to 
support all 8 channels, ensuring adequate buffer capacity.
- Previous patch link: 
https://lore.kernel.org/linux-iio/20241028142357.1032380-1-quzicheng@huawei.com/T/#u
 drivers/iio/adc/ad7923.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 09680015a7ab..acc44cb34f82 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -48,7 +48,7 @@
 
 struct ad7923_state {
 	struct spi_device		*spi;
-	struct spi_transfer		ring_xfer[5];
+	struct spi_transfer		ring_xfer[9];
 	struct spi_transfer		scan_single_xfer[2];
 	struct spi_message		ring_msg;
 	struct spi_message		scan_single_msg;
@@ -64,7 +64,7 @@ struct ad7923_state {
 	 * Length = 8 channels + 4 extra for 8 byte timestamp
 	 */
 	__be16				rx_buf[12] __aligned(IIO_DMA_MINALIGN);
-	__be16				tx_buf[4];
+	__be16				tx_buf[8];
 };
 
 struct ad7923_chip_info {
-- 
2.34.1


