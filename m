Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5B1B1ABF
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDUAbm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:20088 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgDUAbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
IronPort-SDR: UAcz9cRvbSUQsE6mrrYM8RE5ulDD57wVFstnJOc8BKJjS9Iqpnp9mVwT2ndq4bl/Caq4ik7yNP
 Um6j0+aVStUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:40 -0700
IronPort-SDR: Y6jY1HYt0fG061j2RRqe7uANxyzoHPLMZZKfw+DC0VNl1writdPT2Mk5JIZ1rU4oJS9uOD0j2K
 3RxslXe5YLtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="255113824"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2020 17:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA976403; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/16] iio: health: afe4403: Use get_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:27 +0300
Message-Id: <20200421003135.23060-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes the driver code slightly easier to read.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/health/afe4403.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index dc22dc363a99..db44b53e9330 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -220,13 +220,11 @@ static int afe4403_read(struct afe4403_data *afe, unsigned int reg, u32 *val)
 	if (ret)
 		return ret;
 
-	ret = spi_write_then_read(afe->spi, &reg, 1, rx, 3);
+	ret = spi_write_then_read(afe->spi, &reg, 1, rx, sizeof(rx));
 	if (ret)
 		return ret;
 
-	*val = (rx[0] << 16) |
-		(rx[1] << 8) |
-		(rx[2]);
+	*val = get_unaligned_be24(&rx[0]);
 
 	/* Disable reading from the device */
 	tx[3] = AFE440X_CONTROL0_WRITE;
@@ -322,13 +320,11 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 			 indio_dev->masklength) {
 		ret = spi_write_then_read(afe->spi,
 					  &afe4403_channel_values[bit], 1,
-					  rx, 3);
+					  rx, sizeof(rx));
 		if (ret)
 			goto err;
 
-		buffer[i++] = (rx[0] << 16) |
-				(rx[1] << 8) |
-				(rx[2]);
+		buffer[i++] = get_unaligned_be24(&rx[0]);
 	}
 
 	/* Disable reading from the device */
-- 
2.26.1

