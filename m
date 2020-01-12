Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0113883E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2020 21:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbgALUda (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jan 2020 15:33:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44469 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbgALUda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jan 2020 15:33:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so7708590lje.11;
        Sun, 12 Jan 2020 12:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IrLDzyGfd9Y65dDT7UGMmoZnTT7I7zow/6QfstVQ1DA=;
        b=PR4yTzhWStLUhH3DAX7PztJkvplbspQP1sh3ZPkIxh99aUo16NYjsw1SkMtWfI4QQN
         1Mr8p/lm6LQjAR4Hf/SWSPJ+lwa31z/0hEylxaAVjvBCV/yQLo0/CxixjrPt1/x07Mj/
         9NBM8h5sfAVUvaWcyhwiPx5+qOyq/eEhubGuJ/8Q2phD2xh1Dk/kgX7+g4RUp8iFM1V8
         4LVMop1fLxL8F4T7uv/JKAUI37X+bXeaCVsS0eqsdT3DRSycvCS0xS0O3uZRx5xxIlFA
         UHtWrys6/cCmbWju3qjsu+jC1bKSbbJl7V5pdtt2pjUjJY0qavSoS8M7uyoWYwuhSGuG
         KLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IrLDzyGfd9Y65dDT7UGMmoZnTT7I7zow/6QfstVQ1DA=;
        b=tXLG6ns9J8n5VpPsu7T5XrEukKbqnjOTezrcfBEt7SKZqyrETvseEnOC2TtOiGeRX3
         Y/YyK84Ce1uHcksqIwTV420wDRbd/nUl4BC8Hgw2KsjF+9m1LIPw9UNUFWKX8jpPm042
         HBMyw/k4mn0mJqyE/25wSevp/UKynTeC3eSML+HhAN75FH/3P/EpzSKf3yLXjzG8zSfd
         770SpxIqJkEMpClM7ROvfmnMBnflxTMFopcXg3WU5I+kri0PRi6fTKpasF6wUI/7XASh
         uROrcPsdNZz2Nz+f25y4Og3j8PhJsl77dMxgbfzRupW5/AGIocq0KQ3jzxenGRbjbA/k
         MM2Q==
X-Gm-Message-State: APjAAAWz+fD3VKoluFyigalzVJ6NZZPb4nkA1C+Yu18mHO95aDHII+Wl
        pTJFzT9KBrKrX6KRCN4i1Xc=
X-Google-Smtp-Source: APXvYqwBfFAR8OQmBDBjCB3tz+Dj8/kUMmk3fxUvn9wOopBq3+C0Rda9DnZGFOZcSEMrlFNwxHgDKA==
X-Received: by 2002:a05:651c:1045:: with SMTP id x5mr6601786ljm.266.1578861208532;
        Sun, 12 Jan 2020 12:33:28 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u16sm5255192lfi.36.2020.01.12.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 12:33:27 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] iio: accel: kxcjk1013: Support orientation matrix
Date:   Sun, 12 Jan 2020 23:33:00 +0300
Message-Id: <20200112203301.30235-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hardware could be physically mounted in any possible direction and
userpspace needs to be aware of the mounting orientation in order to
process sensor's data correctly. In particular this helps iio-sensor-proxy
to report display's orientation properly on a phone/tablet devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c       | 27 +++++++++++++++++++++++++--
 include/linux/iio/accel/kxcjk_1013.h |  3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index fee535d6e45b..c9924a65c32a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -130,6 +130,7 @@ struct kxcjk1013_data {
 	struct i2c_client *client;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
+	struct iio_mount_matrix orientation;
 	struct mutex mutex;
 	s16 buffer[8];
 	u8 odr_bits;
@@ -983,6 +984,20 @@ static const struct iio_event_spec kxcjk1013_event = {
 				 BIT(IIO_EV_INFO_PERIOD)
 };
 
+static const struct iio_mount_matrix *
+kxcjk1013_get_mount_matrix(const struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan)
+{
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info kxcjk1013_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kxcjk1013_get_mount_matrix),
+	{ }
+};
+
 #define KXCJK1013_CHANNEL(_axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -999,6 +1014,7 @@ static const struct iio_event_spec kxcjk1013_event = {
 		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &kxcjk1013_event,				\
+	.ext_info = kxcjk1013_ext_info,					\
 	.num_event_specs = 1						\
 }
 
@@ -1267,11 +1283,18 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	data->client = client;
 
 	pdata = dev_get_platdata(&client->dev);
-	if (pdata)
+	if (pdata) {
 		data->active_high_intr = pdata->active_high_intr;
-	else
+		data->orientation = pdata->orientation;
+	} else {
 		data->active_high_intr = true; /* default polarity */
 
+		ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
+					    &data->orientation);
+		if (ret)
+			return ret;
+	}
+
 	if (id) {
 		data->chipset = (enum kx_chipset)(id->driver_data);
 		name = id->name;
diff --git a/include/linux/iio/accel/kxcjk_1013.h b/include/linux/iio/accel/kxcjk_1013.h
index 8c3c78bc9f91..ea0ecb774371 100644
--- a/include/linux/iio/accel/kxcjk_1013.h
+++ b/include/linux/iio/accel/kxcjk_1013.h
@@ -7,8 +7,11 @@
 #ifndef __IIO_KXCJK_1013_H__
 #define __IIO_KXCJK_1013_H__
 
+#include <linux/iio/iio.h>
+
 struct kxcjk_1013_platform_data {
 	bool active_high_intr;
+	struct iio_mount_matrix orientation;
 };
 
 #endif
-- 
2.24.0

