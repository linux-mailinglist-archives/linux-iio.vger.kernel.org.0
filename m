Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E612B441BC0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhKANdw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 09:33:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:42756 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhKANdu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 09:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=IQfU4FSgH++Wuku7k0Zmh7CpG3XmH/jrSyA51jqK/gc=; b=Bb+QP0ynKhfEhuIvFc7miqsNRV
        zNDyn3Nk0KB4WgRdNcnn1pWur/+Y4YWRH3NVD9XWy3DAjkSh6Y1oXt5WyZTU6nexUs9qhzruaTDg+
        IH/fyFxBESMPjutBP82Jq1L0ITQsaTdBSNfPs1EAAvhLybBo0I3uEdKpSJml7BZZjWMUZ9+V49fAs
        lbJU8D7hlsd7kBZX2dTWyxa9pNM12r5hDRNJoV9E1uewltZUp/Q6NzdfL3U5WqjxTm4C6tZb1AwAU
        X4qhkds9TE5PnGDKH9spIKzbjvw3q2QLasCu/+IrN/7V6+ON86OXIrBGvxVAhNlWoVvt8NYnoJ/ti
        KZXtsTyw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhXP3-000H1V-1K; Mon, 01 Nov 2021 14:31:09 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhXP2-000O3r-S6; Mon, 01 Nov 2021 14:31:08 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jack Andersen <jackoalan@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: dln2: Check return value of devm_iio_trigger_register()
Date:   Mon,  1 Nov 2021 14:30:43 +0100
Message-Id: <20211101133043.6974-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26340/Mon Nov  1 09:21:46 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Registering a trigger can fail and the return value of
devm_iio_trigger_register() must be checked. Otherwise undefined behavior
can occur when the trigger is used.

Fixes: 7c0299e879dd ("iio: adc: Add support for DLN2 ADC")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/dln2-adc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 16407664182c..846c92296221 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -656,7 +656,11 @@ static int dln2_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	iio_trigger_set_drvdata(dln2->trig, dln2);
-	devm_iio_trigger_register(dev, dln2->trig);
+	ret = devm_iio_trigger_register(dev, dln2->trig);
+	if (ret) {
+		dev_err(dev, "failed to register trigger: %d\n", ret);
+		return ret;
+	}
 	iio_trigger_set_immutable(indio_dev, dln2->trig);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-- 
2.20.1

