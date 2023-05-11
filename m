Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5154A6FE8E3
	for <lists+linux-iio@lfdr.de>; Thu, 11 May 2023 02:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjEKAnh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 20:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKAng (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 20:43:36 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A7E42
        for <linux-iio@vger.kernel.org>; Wed, 10 May 2023 17:43:35 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C581D84660;
        Thu, 11 May 2023 02:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683765814;
        bh=vsk7JOntJUfBvxKSFLzbKaCSpelHso+8ym4sgsy+tfw=;
        h=From:To:Cc:Subject:Date:From;
        b=jakoS3sCvfRXb8rb0+ZTd1VFKOxOdCmq9oG9BN0b6oTogp5YtoQt1hbNmcpK3tnYR
         51YLldWMnNGJWdY72EUCbbcAeI6s1ZYZKP3b8SF93GqcakBG1fktRblPEGdc7zimHw
         XQSLtj3AEBp3rFk4lcfDbSpTiVN+1Z+2GpxlNFUQykHxsQRvBr3y/GmwW3mlM9H+s2
         mJiFluubfjWciFroMtCv+kBtur1p84+sR8qgH60MTFNYjU/2WXbLJIbT+g+znnTcn3
         8YlAltpUAMCwOlHPYuqspPXuSbgdQHAh1GDWvX9ddMorRkk7J0H7xTPogvJmpoLSd6
         yPOAH8pL7ix4g==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] iio: dac: mcp4725: Fix i2c_master_send() return value handling
Date:   Thu, 11 May 2023 02:43:30 +0200
Message-Id: <20230511004330.206942-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The i2c_master_send() returns number of sent bytes on success,
or negative on error. The suspend/resume callbacks expect zero
on success and non-zero on error. Adapt the return value of the
i2c_master_send() to the expectation of the suspend and resume
callbacks, including proper validation of the return value.

Fixes: cf35ad61aca2 ("iio: add mcp4725 I2C DAC driver")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Marek Behún" <kabel@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/dac/mcp4725.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 46bf758760f85..3f5661a3718fe 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -47,12 +47,18 @@ static int mcp4725_suspend(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = (data->powerdown_mode + 1) << 4;
 	outbuf[1] = 0;
 	data->powerdown = true;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 
 static int mcp4725_resume(struct device *dev)
@@ -60,13 +66,19 @@ static int mcp4725_resume(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	/* restore previous DAC value */
 	outbuf[0] = (data->dac_value >> 8) & 0xf;
 	outbuf[1] = data->dac_value & 0xff;
 	data->powerdown = false;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 static DEFINE_SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend,
 				mcp4725_resume);
-- 
2.39.2

