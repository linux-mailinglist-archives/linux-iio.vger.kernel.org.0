Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46D75E79D0
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 13:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIWLkv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Sep 2022 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiIWLkq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2022 07:40:46 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3AF10D0D8
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663933240;
  x=1695469240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0pHLsnOhRXTtY6E8HnvMVmHQLf69VuTSVtIB+/4BsB8=;
  b=PM6OCG6u7Vai2033MGE51FcNSs6Z1kCkUsOfamBmk04l52jLcfj8RRXj
   3r7TpRuSSI0Kcw2+vqYNsnhCbHRD0r0inEf/iKYmdrHc5ix8xbhS7Dj6f
   Ts4xoHmEFCpdlCd0Z/cage31U6+qbDWKxOKVTolPj98mI54X4rS5nzU7Y
   bzG4M3sw4v3QTcErVtJQauQQ4Kmw9+wnxCBoTvyBRbjmTGb/Ybo6+7Hny
   Kg8/MgEnI5cpHQxU7uujrufnDYjAzga49tQXaFXJjhlDk8lpZAa7Es5i4
   FNN+XJ+KjCwHDrH661NeDxTDT3Ioow0EEQitqbeKHuXY1LBv3l0CVMptl
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2 1/2] iio: light: vcnl4000: Preserve conf bits when toggle power
Date:   Fri, 23 Sep 2022 13:40:30 +0200
Message-ID: <20220923114031.757011-2-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923114031.757011-1-marten.lindahl@axis.com>
References: <20220923114031.757011-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As the vcnl4040 and vcnl4200 chip uses runtime power management for
turning the ambient light and proximity sensors on/off, it overwrites
the entire register each time. In ALS_CONF register bit fields ALS_IT,
ALS_PERS, ALS_INT_EN are overwritten. In PS_CONF1 register bit fields
PS_DUTY, PS_PERS, PS_IT, PS_HD, and PS_INT are overwritten.

Add functions for preserving the affected bit fields when changing power
state.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 54 ++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 3db4e26731bb..b2ecf8af1aa5 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -74,6 +74,9 @@
 #define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
 #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
 
+#define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light sensor */
+#define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
+
 /* Bit masks for interrupt registers. */
 #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
 #define VCNL4010_INT_THR_EN	BIT(1) /* Threshold interrupt type */
@@ -188,16 +191,61 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 	return data->chip_spec->set_power_state(data, true);
 };
 
+static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
+{
+	int ret;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		goto out;
+
+	if (en)
+		ret &= ~VCNL4040_ALS_CONF_ALS_SD;
+	else
+		ret |= VCNL4040_ALS_CONF_ALS_SD;
+
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
+
+out:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
+static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, bool en)
+{
+	int ret;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		goto out;
+
+	if (en)
+		ret &= ~VCNL4040_PS_CONF1_PS_SD;
+	else
+		ret |= VCNL4040_PS_CONF1_PS_SD;
+
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
+
+out:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
 static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 {
-	u16 val = on ? 0 /* power on */ : 1 /* shut down */;
 	int ret;
 
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
+	ret = vcnl4000_write_als_enable(data, on);
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
+	ret = vcnl4000_write_ps_enable(data, on);
 	if (ret < 0)
 		return ret;
 
-- 
2.30.2

