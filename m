Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21923B7E2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgHDJjK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 05:39:10 -0400
Received: from smtp2.axis.com ([195.60.68.18]:17802 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgHDJjK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Aug 2020 05:39:10 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2020 05:39:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3621; q=dns/txt; s=axis-central1;
  t=1596533949; x=1628069949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ur+3d5KYc/6ZODjpCmOML5mGvcwU68NauvMIWuR/6Zw=;
  b=NFjOP9z8Ec2EwW2IcXwM3ZaFk+3aTrUCM0gW2ltvVak7ycUYFKDYj73q
   0qLhCP8FV84TNbtuhHsFm/vfHURK+e/MeJbT5zIP/PvZ1dY8MZR61N2KJ
   MSfaRVhKZmsZ8jQwJvpOgX4BXqerx0DITgQRayCwEmQjaJVx7MLDxiYu+
   Vzb1y/P7XPIW8az4A3Z0z8THv4glct1fUBRAI5Ha7PQar8UbGeD5iAYiX
   eZbkkHqxCE4vsSfUtt4oGychFA3i1aSaGFGIdttB5QHR2QbCWqmNW24Mb
   Qo72rBZF4J6Cr+mfzwi4f+YCAEAgbQOfH3r8Yox/Pg+GkeBe9V95DQjUc
   g==;
IronPort-SDR: W/ZhIggQ9sgXnQlPxeMjJeFMuoWE7tNFPVpMn0u4KtQ2/dd1yF3x94QqeWqXbDhk9eXjREClru
 TRtAOlNYCZmXQnZZlqMwTMN4U04TRGm8FKH2Thx7f8pZIvg8IpVahLXt6rwGZbQJPhaV3JkOhx
 YCEwz3FGHwgvF6qnqNBTRwcJwepn+dDgRscD/nyheQyfmPh0k7qDgIRJSiFBKJ/sxpSQmdcvkx
 IG/q0ccxMJNahsU9PloYmpmP+OxbtXG1AXQm9iPR6SFvvAxr6Skyc+/qR7NR1A+zBONhNw1wJ4
 blE=
X-IronPort-AV: E=Sophos;i="5.75,433,1589234400"; 
   d="scan'208";a="11151079"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     <kernel@axis.com>, <sean@geanix.com>, <linux-iio@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] iio: dac: dac5571: Support powerdown for multi-channel
Date:   Tue, 4 Aug 2020 11:31:38 +0200
Message-ID: <20200804093138.2114-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver currently only allows channel 0 to be powered down but the
multi-channel variants of the hardware allow each channel to be powered
down separately and with separate power down modes.  Add support for
this.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/dac/ti-dac5571.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 3a2bb0efe50d..ce8c3d646fb1 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -47,8 +47,8 @@ struct dac5571_data {
 	struct mutex lock;
 	struct regulator *vref;
 	u16 val[4];
-	bool powerdown;
-	u8 powerdown_mode;
+	bool powerdown[4];
+	u8 powerdown_mode[4];
 	struct dac5571_spec const *spec;
 	int (*dac5571_cmd)(struct dac5571_data *data, int channel, u16 val);
 	int (*dac5571_pwrdwn)(struct dac5571_data *data, int channel, u8 pwrdwn);
@@ -125,7 +125,7 @@ static int dac5571_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct dac5571_data *data = iio_priv(indio_dev);
 
-	return data->powerdown_mode;
+	return data->powerdown_mode[chan->channel];
 }
 
 static int dac5571_set_powerdown_mode(struct iio_dev *indio_dev,
@@ -135,17 +135,17 @@ static int dac5571_set_powerdown_mode(struct iio_dev *indio_dev,
 	struct dac5571_data *data = iio_priv(indio_dev);
 	int ret = 0;
 
-	if (data->powerdown_mode == mode)
+	if (data->powerdown_mode[chan->channel] == mode)
 		return 0;
 
 	mutex_lock(&data->lock);
-	if (data->powerdown) {
+	if (data->powerdown[chan->channel]) {
 		ret = data->dac5571_pwrdwn(data, chan->channel,
 					   DAC5571_POWERDOWN(mode));
 		if (ret)
 			goto out;
 	}
-	data->powerdown_mode = mode;
+	data->powerdown_mode[chan->channel] = mode;
 
  out:
 	mutex_unlock(&data->lock);
@@ -167,7 +167,7 @@ static ssize_t dac5571_read_powerdown(struct iio_dev *indio_dev,
 {
 	struct dac5571_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", data->powerdown);
+	return sprintf(buf, "%d\n", data->powerdown[chan->channel]);
 }
 
 static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
@@ -183,19 +183,20 @@ static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	if (data->powerdown == powerdown)
+	if (data->powerdown[chan->channel] == powerdown)
 		return len;
 
 	mutex_lock(&data->lock);
 	if (powerdown)
 		ret = data->dac5571_pwrdwn(data, chan->channel,
-			    DAC5571_POWERDOWN(data->powerdown_mode));
+			    DAC5571_POWERDOWN(data->powerdown_mode[chan->channel]));
 	else
-		ret = data->dac5571_cmd(data, chan->channel, data->val[0]);
+		ret = data->dac5571_cmd(data, chan->channel,
+				data->val[chan->channel]);
 	if (ret)
 		goto out;
 
-	data->powerdown = powerdown;
+	data->powerdown[chan->channel] = powerdown;
 
  out:
 	mutex_unlock(&data->lock);
@@ -209,9 +210,9 @@ static const struct iio_chan_spec_ext_info dac5571_ext_info[] = {
 		.name	   = "powerdown",
 		.read	   = dac5571_read_powerdown,
 		.write	   = dac5571_write_powerdown,
-		.shared	   = IIO_SHARED_BY_TYPE,
+		.shared	   = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &dac5571_powerdown_mode),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &dac5571_powerdown_mode),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &dac5571_powerdown_mode),
 	{},
 };
@@ -276,7 +277,7 @@ static int dac5571_write_raw(struct iio_dev *indio_dev,
 		if (val >= (1 << data->spec->resolution) || val < 0)
 			return -EINVAL;
 
-		if (data->powerdown)
+		if (data->powerdown[chan->channel])
 			return -EBUSY;
 
 		mutex_lock(&data->lock);
-- 
2.25.1

