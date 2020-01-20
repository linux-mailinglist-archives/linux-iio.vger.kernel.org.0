Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A85142734
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgATJZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:25:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:42830 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgATJZx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jan 2020 04:25:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 01:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,341,1574150400"; 
   d="scan'208";a="274635744"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2020 01:25:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C395723D; Mon, 20 Jan 2020 11:25:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: accel: st_accel: Use st_sensors_dev_name_probe()
Date:   Mon, 20 Jan 2020 11:25:50 +0200
Message-Id: <20200120092550.39427-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use st_sensors_dev_name_probe() instead open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel_i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 633955d764cc..8c489312f668 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -147,12 +147,9 @@ static int st_accel_i2c_probe(struct i2c_client *client)
 	const struct st_sensor_settings *settings;
 	struct st_sensor_data *adata;
 	struct iio_dev *indio_dev;
-	const char *match;
 	int ret;
 
-	match = device_get_match_data(&client->dev);
-	if (match)
-		strlcpy(client->name, match, sizeof(client->name));
+	st_sensors_dev_name_probe(&client->dev, client->name, sizeof(client->name));
 
 	settings = st_accel_get_settings(client->name);
 	if (!settings) {
-- 
2.24.1

