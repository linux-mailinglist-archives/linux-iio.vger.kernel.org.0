Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34345DAB9
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 14:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354957AbhKYNKM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 08:10:12 -0500
Received: from box.trvn.ru ([194.87.146.52]:43913 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349627AbhKYNIM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Nov 2021 08:08:12 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 74CD640519;
        Thu, 25 Nov 2021 17:57:11 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1637845031; bh=sgrmM7Ln+ky2I46p33Yv2KpJD3kkLM7KXUmHNEwxmhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNbGtOm5ZReb/wxIxwLt1zbe+SHHUtp0gNS2X/ZookImGbT6xO8bGBQAMQlbDf9S4
         Yt7izcHHEmDHFvdKFyvW/Rn9YlqnHrTVvo/V4hSleFbskeEkUSQcVFVvL1xZ9hEA0z
         cJkBSh8cBRcNE0ZI+q6SwWFRBB+D3ynzKMcYcIlVlDoukYCRZAsxEdkE2rH4puLkXa
         0HuqtObLyogSGtYiQQIiKJU3JT9SjcA48ysXBNTKINrc+hKjOMZsIh7AGjOm6dxYwW
         ktygKy6JW3QyraFYXTZD2Td8C8yGyMO4bHvkRcx9iu9ePM2MHlFYgQyw7PHhnUd+ix
         7CGyotdQvrOoA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 2/2] iio: ltr501: Export near level property for proximity sensor
Date:   Thu, 25 Nov 2021 17:56:46 +0500
Message-Id: <20211125125646.54831-2-nikita@trvn.ru>
In-Reply-To: <20211125125646.54831-1-nikita@trvn.ru>
References: <20211125125646.54831-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Userspace tools like iio-sensor-proxy need to know the proximity level
that should be considered "near". This value is hardware-specific and
can be defined via the devicetree. Allow the driver to export the near
level.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>

---
The changes are mostly copied from vcnl4000 patchset introducing the
property:
https://lore.kernel.org/linux-iio/cover.1586094535.git.agx@sigxcpu.org/
---
 drivers/iio/light/ltr501.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 64ba04c275e8..47d61ec2bb50 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -166,6 +166,7 @@ struct ltr501_data {
 	struct regmap_field *reg_ps_rate;
 	struct regmap_field *reg_als_prst;
 	struct regmap_field *reg_ps_prst;
+	uint32_t near_level;
 };
 
 static const struct ltr501_samp_table ltr501_als_samp_table[] = {
@@ -525,6 +526,25 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 	return -EINVAL;
 }
 
+static ssize_t ltr501_read_near_level(struct iio_dev *indio_dev,
+				      uintptr_t priv,
+				      const struct iio_chan_spec *chan,
+				      char *buf)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%u\n", data->near_level);
+}
+
+static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
+	{
+		.name = "nearlevel",
+		.shared = IIO_SEPARATE,
+		.read = ltr501_read_near_level,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct iio_event_spec ltr501_als_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -609,6 +629,7 @@ static const struct iio_chan_spec ltr501_channels[] = {
 		},
 		.event_spec = ltr501_pxs_event_spec,
 		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
+		.ext_info = ltr501_ext_info,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
@@ -1531,6 +1552,10 @@ static int ltr501_probe(struct i2c_client *client,
 	if ((partid >> 4) != data->chip_info->partid)
 		return -ENODEV;
 
+	if (device_property_read_u32(&client->dev, "proximity-near-level",
+				     &data->near_level))
+		data->near_level = 0;
+
 	indio_dev->info = data->chip_info->info;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->no_channels;
-- 
2.30.2

