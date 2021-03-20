Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB26342C1C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCTLYu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCTLYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:24:33 -0400
Received: from www381.your-server.de (www381.your-server.de [IPv6:2a01:4f8:d0a:52ac::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F7C0613AE
        for <linux-iio@vger.kernel.org>; Sat, 20 Mar 2021 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=a2k7Tef15KNEFbNgZ8UGRt5exOo32PKWMSrYmzhz+w8=; b=jMCUKWp7MqZO1ONOnVlINm04dW
        vk35KBlUeI5l7ciea9yFzGdGhaaAxg+plvWNVSOwQ0S6Gu2hZ+u/7IO5wQYA3wPxXfXHZUFxP35cz
        pzFDhU/VPu9sB84LR9o777PyuTP8/2dp4+/G9ZpNQlBJAWixjiKY2dHCaaAlLUCKZp7BIiyY/z0Mt
        LEKRLxkPJOqVpzaQ2FpiNNqHI63CvqD7RALUiqeh0bjeW56/LtO6fYMw3B0mGcvXaKKUTyBFJYUL7
        5iPXwgG1YVZmk4QeNjW5ccGdmZUkN0ZnR6LsHYVvNxAYHCu6duvdAXDTLH3cMh8WLZbwzXB4VUhwz
        7VCmq2Nw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNVok-000AyT-5J; Sat, 20 Mar 2021 08:14:38 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNVok-000Vc8-16; Sat, 20 Mar 2021 08:14:38 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to sysfs_emit()
Date:   Sat, 20 Mar 2021 08:14:05 +0100
Message-Id: <20210320071405.9347-5-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210320071405.9347-1-lars@metafoo.de>
References: <20210320071405.9347-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26114/Sat Mar 20 04:43:32 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update DAC drivers powerdown attribute show callback to use the new
sysfs_emit() function.

sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
knows about the sysfs buffer specifics and has some built-in sanity checks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5064.c        | 2 +-
 drivers/iio/dac/ad5360.c        | 2 +-
 drivers/iio/dac/ad5380.c        | 2 +-
 drivers/iio/dac/ad5446.c        | 2 +-
 drivers/iio/dac/ad5504.c        | 4 ++--
 drivers/iio/dac/ad5624r_spi.c   | 4 ++--
 drivers/iio/dac/ad5686.c        | 2 +-
 drivers/iio/dac/ad5755.c        | 4 ++--
 drivers/iio/dac/ad5758.c        | 2 +-
 drivers/iio/dac/ad5770r.c       | 2 +-
 drivers/iio/dac/ad5791.c        | 2 +-
 drivers/iio/dac/ad7303.c        | 2 +-
 drivers/iio/dac/ltc2632.c       | 4 ++--
 drivers/iio/dac/max5821.c       | 2 +-
 drivers/iio/dac/mcp4725.c       | 2 +-
 drivers/iio/dac/stm32-dac.c     | 2 +-
 drivers/iio/dac/ti-dac082s085.c | 2 +-
 drivers/iio/dac/ti-dac5571.c    | 2 +-
 drivers/iio/dac/ti-dac7311.c    | 2 +-
 19 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 82abd4d6886c..dff623b65e4f 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -277,7 +277,7 @@ static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5064_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->pwr_down[chan->channel]);
+	return sysfs_emit(buf, "%d\n", st->pwr_down[chan->channel]);
 }
 
 static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 602dd2ba61b5..2d3b14c407d8 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -255,7 +255,7 @@ static ssize_t ad5360_read_dac_powerdown(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad5360_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
+	return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
 }
 
 static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 37ef653564b0..53db5b4e4c53 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -85,7 +85,7 @@ static ssize_t ad5380_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5380_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->pwr_down);
+	return sysfs_emit(buf, "%d\n", st->pwr_down);
 }
 
 static ssize_t ad5380_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index d87e21016863..488ec69967d6 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -100,7 +100,7 @@ static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->pwr_down);
+	return sysfs_emit(buf, "%d\n", st->pwr_down);
 }
 
 static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index e9297c25d4ef..c12ae91d8843 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -170,8 +170,8 @@ static ssize_t ad5504_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n",
-			!(st->pwr_down_mask & (1 << chan->channel)));
+	return sysfs_emit(buf, "%d\n",
+			  !(st->pwr_down_mask & (1 << chan->channel)));
 }
 
 static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 2b2b8edfd258..9bde86982912 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -117,8 +117,8 @@ static ssize_t ad5624r_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5624r_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n",
-			!!(st->pwr_down_mask & (1 << chan->channel)));
+	return sysfs_emit(buf, "%d\n",
+			  !!(st->pwr_down_mask & (1 << chan->channel)));
 }
 
 static ssize_t ad5624r_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 99a95282ac57..fcb64f20ff64 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -57,7 +57,7 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
 				       (0x3 << (chan->channel * 2))));
 }
 
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 0df28acf074a..cabc38d54085 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -399,8 +399,8 @@ static ssize_t ad5755_read_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n",
-		       (bool)(st->pwr_down & (1 << chan->channel)));
+	return sysfs_emit(buf, "%d\n",
+			  (bool)(st->pwr_down & (1 << chan->channel)));
 }
 
 static ssize_t ad5755_write_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index bd9ac8359d98..0572ef518101 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -574,7 +574,7 @@ static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5758_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->pwr_down);
+	return sysfs_emit(buf, "%d\n", st->pwr_down);
 }
 
 static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 84dcf149261f..5e901fe48023 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -433,7 +433,7 @@ static ssize_t ad5770r_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5770r_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->ch_pwr_down[chan->channel]);
+	return sysfs_emit(buf, "%d\n", st->ch_pwr_down[chan->channel]);
 }
 
 static ssize_t ad5770r_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 615d72cd59bc..a0923b76e8b6 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -177,7 +177,7 @@ static ssize_t ad5791_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5791_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->pwr_down);
+	return sysfs_emit(buf, "%d\n", st->pwr_down);
 }
 
 static ssize_t ad5791_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index dbb4645ab6b1..e1b6a92df12f 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -65,7 +65,7 @@ static ssize_t ad7303_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad7303_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", (bool)(st->config &
+	return sysfs_emit(buf, "%d\n", (bool)(st->config &
 		AD7303_CFG_POWER_DOWN(chan->channel)));
 }
 
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 4002ed0868be..53e4b887d372 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -135,8 +135,8 @@ static ssize_t ltc2632_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ltc2632_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n",
-		       !!(st->powerdown_cache_mask & (1 << chan->channel)));
+	return sysfs_emit(buf, "%d\n",
+			  !!(st->powerdown_cache_mask & (1 << chan->channel)));
 }
 
 static ssize_t ltc2632_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index d6bb24db49c4..bd6e75699a63 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -84,7 +84,7 @@ static ssize_t max5821_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct max5821_data *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", st->powerdown[chan->channel]);
+	return sysfs_emit(buf, "%d\n", st->powerdown[chan->channel]);
 }
 
 static int max5821_sync_powerdown_mode(struct max5821_data *data,
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index beb9a15b7c74..34b14aafb630 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -167,7 +167,7 @@ static ssize_t mcp4725_read_powerdown(struct iio_dev *indio_dev,
 {
 	struct mcp4725_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", data->powerdown);
+	return sysfs_emit(buf, "%d\n", data->powerdown);
 }
 
 static ssize_t mcp4725_write_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 12dec68c16f7..a5b0a52bf86e 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -210,7 +210,7 @@ static ssize_t stm32_dac_read_powerdown(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", ret ? 0 : 1);
+	return sysfs_emit(buf, "%d\n", ret ? 0 : 1);
 }
 
 static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
index de33c1fc6e0b..5c14bfb16521 100644
--- a/drivers/iio/dac/ti-dac082s085.c
+++ b/drivers/iio/dac/ti-dac082s085.c
@@ -121,7 +121,7 @@ static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
 {
 	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", ti_dac->powerdown);
+	return sysfs_emit(buf, "%d\n", ti_dac->powerdown);
 }
 
 static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index d3295767a079..2a5ba1b08a1d 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -166,7 +166,7 @@ static ssize_t dac5571_read_powerdown(struct iio_dev *indio_dev,
 {
 	struct dac5571_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", data->powerdown[chan->channel]);
+	return sysfs_emit(buf, "%d\n", data->powerdown[chan->channel]);
 }
 
 static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
index 63171e42f987..9d0b253be841 100644
--- a/drivers/iio/dac/ti-dac7311.c
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -110,7 +110,7 @@ static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
 {
 	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", ti_dac->powerdown);
+	return sysfs_emit(buf, "%d\n", ti_dac->powerdown);
 }
 
 static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
-- 
2.20.1

