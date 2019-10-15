Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE01D746C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfJOLMu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:12:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbfJOLMm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=M6mHFyVv5DErkBnDBiyt4o35Oc+T3BrvGXuI6UA9xVI=; b=EHw2Mb5QY4K8
        d0Uq/rhCXW9ytKqEMWjyvVYGiMN+mePiHBXNp9w/K8XgfpN++rBlLac3Tv8iSAKBJU9+Qj/YGeXrL
        KFhs1i5MVoiSXi8LyYhuM9zPOUFTwup3Q+apL8NngPWluZ7XW9sOOe319s9lpjIz5Ba4jjsZU/hqj
        MWraU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkf-00022v-5v; Tue, 15 Oct 2019 11:12:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9F7E527419E4; Tue, 15 Oct 2019 12:12:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()" to the spi tree
In-Reply-To: <20190926105147.7839-3-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111228.9F7E527419E4@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:28 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b2c98153f45fc17b9fcb241000f2d131ddea6030 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:30 +0300
Subject: [PATCH] spi: introduce spi_delay struct as "value + unit" &
 spi_delay_exec()

There are plenty of delays that have been introduced in SPI core. Most of
them are in micro-seconds, some need to be in nano-seconds, and some in
clock-cycles.

For some of these delays (related to transfers & CS timing) it may make
sense to have a `spi_delay` struct that abstracts these a bit.

The important element of these delays [for unification] seems to be the
`unit` of the delay.
It looks like micro-seconds is good enough for most people, but every-once
in a while, some delays seem to require other units of measurement.

This change adds the `spi_delay` struct & a `spi_delay_exec()` function
that processes a `spi_delay` object/struct to execute the delay.
It's a copy of the `cs_change_delay` mechanism, but without the default
for 10 uS.

The clock-cycle delay unit is a bit special, as it needs to be bound to an
`spi_transfer` object to execute.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-3-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 18 ++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7ba981cdb86b..7499a4efbaba 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1106,6 +1106,57 @@ static void _spi_transfer_delay_ns(u32 ns)
 	}
 }
 
+static int _spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
+{
+	u32 delay = _delay->value;
+	u32 unit = _delay->unit;
+	u32 hz;
+
+	if (!delay)
+		return 0;
+
+	switch (unit) {
+	case SPI_DELAY_UNIT_USECS:
+		delay *= 1000;
+		break;
+	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
+		break;
+	case SPI_DELAY_UNIT_SCK:
+		/* clock cycles need to be obtained from spi_transfer */
+		if (!xfer)
+			return -EINVAL;
+		/* if there is no effective speed know, then approximate
+		 * by underestimating with half the requested hz
+		 */
+		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
+		if (!hz)
+			return -EINVAL;
+		delay *= DIV_ROUND_UP(1000000000, hz);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return delay;
+}
+
+int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
+{
+	int delay;
+
+	if (!_delay)
+		return -EINVAL;
+
+	delay = _spi_delay_to_ns(_delay, xfer);
+	if (delay < 0)
+		return delay;
+
+	_spi_transfer_delay_ns(delay);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_delay_exec);
+
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 27f6b046cf92..8f643de3197b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -90,6 +90,21 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
 #define SPI_STATISTICS_INCREMENT_FIELD(stats, field)	\
 	SPI_STATISTICS_ADD_TO_FIELD(stats, field, 1)
 
+/**
+ * struct spi_delay - SPI delay information
+ * @value: Value for the delay
+ * @unit: Unit for the delay
+ */
+struct spi_delay {
+#define SPI_DELAY_UNIT_USECS	0
+#define SPI_DELAY_UNIT_NSECS	1
+#define SPI_DELAY_UNIT_SCK	2
+	u16	value;
+	u8	unit;
+};
+
+extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
+
 /**
  * struct spi_device - Controller side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
@@ -887,9 +902,6 @@ struct spi_transfer {
 	u16		delay_usecs;
 	u16		cs_change_delay;
 	u8		cs_change_delay_unit;
-#define SPI_DELAY_UNIT_USECS	0
-#define SPI_DELAY_UNIT_NSECS	1
-#define SPI_DELAY_UNIT_SCK	2
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

