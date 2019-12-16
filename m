Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDB1215B9
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfLPSTa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 13:19:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:64893 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731788AbfLPSTa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 13:19:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 10:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="297786606"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2019 10:19:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D688C12A; Mon, 16 Dec 2019 20:19:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] iio: st_lsm6dsx: Mark predefined constants with __maybe_unused
Date:   Mon, 16 Dec 2019 20:19:23 +0200
Message-Id: <20191216181925.927-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since we put static variable to a header file it's copied to each module
that includes the header. But not all of them are actually used it.

Mark predefined constants with __maybe_unused to calm a compiler down:

In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c:17:
.../st_lsm6dsx/st_lsm6dsx.h:399:28: warning: ‘st_lsm6dsx_available_scan_masks’ defined but not used [-Wunused-const-variable=]
  399 | static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.../st_lsm6dsx/st_lsm6dsx.h:392:36: warning: ‘st_lsm6dsx_event’ defined but not used [-Wunused-const-variable=]
  392 | static const struct iio_event_spec st_lsm6dsx_event = {
      |                                    ^~~~~~~~~~~~~~~~
...

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index dc55d7dff3eb..b3fbbae81955 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -389,14 +389,17 @@ struct st_lsm6dsx_hw {
 	const struct st_lsm6dsx_settings *settings;
 };
 
-static const struct iio_event_spec st_lsm6dsx_event = {
+static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
 	.type = IIO_EV_TYPE_THRESH,
 	.dir = IIO_EV_DIR_EITHER,
 	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 			 BIT(IIO_EV_INFO_ENABLE)
 };
 
-static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
+static __maybe_unused const unsigned long st_lsm6dsx_available_scan_masks[] = {
+	0x7, 0x0,
+};
+
 extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
 
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
-- 
2.24.0

