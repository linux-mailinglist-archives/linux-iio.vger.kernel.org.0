Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79695E9D65
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIZJW2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiIZJV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 05:21:57 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C346DB9
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664183965;
  x=1695719965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VItS/tzEWmvYWkCsTYhxZdba6LoMXOr46yW2RLLU+9E=;
  b=YubWukfJp0M3ws1aNQ0wGMvpp4nKH+Q8RpLgWsG7oY+NewqcGvlGusx8
   3beZyr6H1reE2NjKu3jCulzdLG8A6Bfiyr4BaA71mVer60T2WppnzLzer
   JG1f0KjFGrX1sx1e81Aa+fwIOeSd/rJIp/ceN3TxCqG6ylkRfH07VdGt7
   KNhXie3lnHhh1KdSlkrNR166o43WSZU6zy1oStFWaOE/i7hWuHGoT3oqi
   GPPXO8YuB6QygXKDZN/F2ZU608zOObSo/2NuJgsK1pDMuHKOg4S5+8nxf
   6ifdtGSwcA9zOSPvraniHrNIW+Oyc9iJCphJaXuApYQUcbefNSuEdl510
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3 1/2] iio: light: vcnl4000: Preserve conf bits when toggle power
Date:   Mon, 26 Sep 2022 11:18:59 +0200
Message-ID: <20220926091900.1724105-2-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926091900.1724105-1-marten.lindahl@axis.com>
References: <20220926091900.1724105-1-marten.lindahl@axis.com>
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
index 3db4e26731bb..208539ad50c2 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -74,6 +74,9 @@
 #define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
 #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
 
+#define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
+#define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
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
+		ret &= ~VCNL4040_ALS_CONF_ALS_SHUTDOWN;
+	else
+		ret |= VCNL4040_ALS_CONF_ALS_SHUTDOWN;
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
+		ret &= ~VCNL4040_PS_CONF1_PS_SHUTDOWN;
+	else
+		ret |= VCNL4040_PS_CONF1_PS_SHUTDOWN;
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

