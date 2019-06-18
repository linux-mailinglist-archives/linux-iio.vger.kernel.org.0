Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50D49CA4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfFRJHa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:07:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60046 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRJHa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:07:30 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AEB3A285312;
        Tue, 18 Jun 2019 10:07:28 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] iio: common: cros_ec_sensors: add sysfs attribute for frequencies
Date:   Tue, 18 Jun 2019 11:06:38 +0200
Message-Id: <ee20a9b8d1700a3987570d2edd28fe9ac9e73123.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Embedded controller return minimum and maximum frequencies, unfortunately
we have no way to know the step for all available frequencies.
Even if not complete, we can return a list of known values using the
standard read_avail callback (IIO_CHAN_INFO_SAMP_FREQ) to provide them to
userland.

Now cros_ec_* sensors provides frequencies values in sysfs like this:
"0 min max".

0 is always true to disable the sensor.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 22 +++++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 2ce077b576a4..8df82b675752 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -10,6 +10,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -86,6 +87,26 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
+static int cros_ec_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
+			      long mask)
+{
+	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = 3;
+		*vals = (const int *)&state->frequency_range;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      int num_channels,
 			      bool physical_device)
@@ -161,6 +182,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 	}
 
+	state->info.read_avail = cros_ec_read_avail;
 	indio_dev->info = &state->info;
 
 	/* Timestamp channel */
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 89937ad242ef..5fa9ba5332e0 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -140,7 +140,9 @@ int cros_ec_sensors_core_register(struct platform_device *pdev,
 	channel[idx].scan_type.shift = 0;\
 	channel[idx].scan_index = idx;\
 	channel[idx].ext_info = cros_ec_sensors_ext_info;\
-	channel[idx].scan_type.sign = 'u';
+	channel[idx].scan_type.sign = 'u';\
+	channel[idx].info_mask_shared_by_all_available = \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
 /**
  * cros_ec_motion_send_host_cmd() - send motion sense host command
-- 
2.20.1

