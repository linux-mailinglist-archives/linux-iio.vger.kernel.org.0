Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FCF6EA92E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjDULfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 07:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjDULfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 07:35:23 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EDE44A5
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=C9OIXHKoxJiLF9g2Txj4+bFVodwDJzn88JiDF+haznA=; b=JcIyrrQDKP7E6oLEhP/y2R/SSQ
        xXCqhRh3DKYmpD50Ks6waE905wRwbt63LT4uDKji2qFb602PF/0ukOZ1rQ6QRgpLA4feGSCR2Bsed
        k/wFgX3Tr/Y3qIWUgYDXogNSU2Rx26NSElhH1SUbOPNv6A85h0vDlGncmbAjFX23uixovpbN7sb0X
        xVEJaWJYzC3RiP+Lj/7KbZggWM1RD7ZzT1flSyN9pHtC4Yj5XNfzjUHAJ5dhWhjoxH5T6k9Pue2+G
        9yKDHHeWVbp6HOzOhqZWtmWfXlfCWrL4zUjR9+0b6juxkEsy8B4bHHkT9pfJLkBhM8pbIj5MnSckd
        U6dBgKaA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1ppp2t-0002Vs-0u; Fri, 21 Apr 2023 13:35:19 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1ppp2s-000MPW-KY; Fri, 21 Apr 2023 13:35:18 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, olivier.moysan@foss.st.com,
        alexandre.torgue@foss.st.com, nuno.sa@analog.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 1/2] iio: adc: stm32-adc: skip adc-diff-channels setup if none is present
Date:   Fri, 21 Apr 2023 13:35:15 +0200
Message-Id: <20230421113516.2710454-1-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26883/Fri Apr 21 09:25:39 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If no adc differential channels are defined driver will fail with EINVAL:
stm32-adc: probe of 48003000.adc:adc@0 failed with error -22

Fix this by skipping the initialization if no channels are defined.

This applies only to the legacy way of initializing adc channels.

Fixes: d7705f35448a ("iio: adc: stm32-adc: convert to device properties")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1:
 - None

 drivers/iio/adc/stm32-adc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index e179b6611e4d..14524c1b5583 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2008,16 +2008,15 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 	 * to get the *real* number of channels.
 	 */
 	ret = device_property_count_u32(dev, "st,adc-diff-channels");
-	if (ret < 0)
-		return ret;
-
-	ret /= (int)(sizeof(struct stm32_adc_diff_channel) / sizeof(u32));
-	if (ret > adc_info->max_channels) {
-		dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
-		return -EINVAL;
-	} else if (ret > 0) {
-		adc->num_diff = ret;
-		num_channels += ret;
+	if (ret > 0) {
+		ret /= (int)(sizeof(struct stm32_adc_diff_channel) / sizeof(u32));
+		if (ret > adc_info->max_channels) {
+			dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
+			return -EINVAL;
+		} else if (ret > 0) {
+			adc->num_diff = ret;
+			num_channels += ret;
+		}
 	}
 
 	/* Optional sample time is provided either for each, or all channels */
-- 
2.40.0

