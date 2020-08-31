Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8B257604
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHaJIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:6893 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgHaJIR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:17 -0400
IronPort-SDR: QcIESwMunFHjd8Ci0JdHKphmYHBQFEBwqYXcSjSHHrwzpyM5XbCexUB9YVHPSeZqwdVeusQMr+
 1VW5zNjoEOLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="241747285"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="241747285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:16 -0700
IronPort-SDR: tldvvm5KGn7kdStVNrs5Xh2X1lbMXeTBd7NaKBD+IUzwStzb37JRJsZ4NwOvJct1meEz6B/ADE
 D35evcZgRZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="330630268"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2020 02:08:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4D894302; Mon, 31 Aug 2020 12:08:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/8] iio: accel: bma220: Use dev_get_drvdata() directly
Date:   Mon, 31 Aug 2020 12:08:08 +0300
Message-Id: <20200831090813.78841-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of using to_spi_dev() + spi_get_drvdata(),
use dev_get_drvdata() to make code simpler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index cb634a3a995d..529c88fc2949 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -291,8 +291,7 @@ static int bma220_remove(struct spi_device *spi)
 #ifdef CONFIG_PM_SLEEP
 static int bma220_suspend(struct device *dev)
 {
-	struct bma220_data *data =
-			iio_priv(spi_get_drvdata(to_spi_device(dev)));
+	struct bma220_data *data = iio_priv(dev_get_drvdata(dev));
 
 	/* The chip can be suspended/woken up by a simple register read. */
 	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
@@ -300,8 +299,7 @@ static int bma220_suspend(struct device *dev)
 
 static int bma220_resume(struct device *dev)
 {
-	struct bma220_data *data =
-			iio_priv(spi_get_drvdata(to_spi_device(dev)));
+	struct bma220_data *data = iio_priv(dev_get_drvdata(dev));
 
 	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
 }
-- 
2.28.0

