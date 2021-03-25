Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10A03492C5
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 14:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYNL1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 09:11:27 -0400
Received: from www381.your-server.de ([78.46.137.84]:34694 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCYNLK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 09:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=i63std+381VTYpjwZPoYj00Y+dfonnocRdL3NydfZso=; b=izvkBB/E5New7D4q7kJAaSEdiF
        2+Pd2H+bcf8L55P9N9dOk0YJTImffpLZRba/JvZMZocSVJdQUFjQU5uXTLjvRrKqIEp2XCKx844RJ
        G0fiPEGTUhPcNpW7Ieu5v3NuU+hmU5u7IzQyfAn5Gr5CRTSvk02ZavIAox0qWbD3CwT/D2RDRuIfz
        8cYisMzX3kr2eGBj25khL/5/KRV0IuCXPRzQqpEZi9S3fmLG6Wed0EDycKvUZrxZ4csp4s5th9T07
        Q4pO08bwAD5Q5GYLg/LB2mQIdi3vIhkhsZnKzAvLTTNh1CYNLPdduMmfqkGDGj6A+ZzmISqsr5Uz6
        B1t/iv6A==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lPPlK-0007fW-Kn; Thu, 25 Mar 2021 14:10:58 +0100
Received: from [2001:a61:2aba:2d01:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lPPlK-000Ol3-Gy; Thu, 25 Mar 2021 14:10:58 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: inv_mpu6050: Remove superfluous indio_dev->modes assignment
Date:   Thu, 25 Mar 2021 14:10:45 +0100
Message-Id: <20210325131046.13383-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26120/Thu Mar 25 12:15:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The inv_mpu6050 driver manually assigns the indio_dev->modes property. But
this is not necessary since it will be setup in iio_trigger_buffer_setup().

Remove the manual assignment.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 453c51c79655..99ee0a218875 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1591,7 +1591,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	indio_dev->info = &mpu_info;
-	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
 
 	result = devm_iio_triggered_buffer_setup(dev, indio_dev,
 						 iio_pollfunc_store_time,
-- 
2.20.1

