Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E116BA2
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfEGTpn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 15:45:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42843 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEGTpm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 15:45:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so23963389wrb.9
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2019 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9+aNuevY6ysCaeXbY0ptPO97o1COGGqj9O+2Kr0kGuM=;
        b=bp853wYXmllYwIKl2uEfFcUBqqjzy8fzydDrWMWngBMGpvKm9V80ii3B48SkhREJgj
         NjCMvPSQW4ofHIX6s7J3ss30mVzTS3dtSf5po9A+K5zKXQSuJjNe62k/dweokILTlIB+
         b1Bt2u21256W29wWlrcxna8EdDj3/xVUG5LY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9+aNuevY6ysCaeXbY0ptPO97o1COGGqj9O+2Kr0kGuM=;
        b=cUYTGOqxkuoIW0fhlE8wj/VYQoRdf2ZXf8zVSLUmbVkgLL+TKeGh5fVrxBT8dnMoK4
         tf/lx1Ie8n/Gxk5EmL/tCIiVFbl5UwunoKseYrwonuyoXJJZdJmM985qrKp9xicEZnBO
         BZM/Rf7/077+6yeKhoqcKte0PwJWotVIqn4GSrpqZN95JiaQCSw6ewAxvyigtIy6RVTM
         5WTuo/typHxVLe/Js80vDQ40VsZM/smIIyZpNLEXEH7rBgHcf9SDzzfbfOtWHByK7fV3
         55ESj40LVv9D2Z9ah7C25OuYsX+00FkGD//2Yj6g6MuUcBD31MHAT6g7205CvVSZJMrP
         1bkA==
X-Gm-Message-State: APjAAAXO1S865QkcBZW3Q/T3ZUh9au+SNDn959cOtkcFESnVMezvSgdy
        sMQ6MxD1qqOmfm1l7lpVq72NVkpa9Q+6Tg==
X-Google-Smtp-Source: APXvYqxUvkmZLgzkJymYxBHz0tADt0Ss8OSIvFqRXnvwozAmI9HmW67HeL3wp9hfxTA7qGgZWhKujw==
X-Received: by 2002:a5d:698b:: with SMTP id g11mr23480328wru.65.1557258341072;
        Tue, 07 May 2019 12:45:41 -0700 (PDT)
Received: from localhost.localdomain (host35-80-dynamic.248-95-r.retail.telecomitalia.it. [95.248.80.35])
        by smtp.gmail.com with ESMTPSA id a5sm103238wrt.10.2019.05.07.12.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 12:45:40 -0700 (PDT)
From:   Angelo Compagnucci <angelo@amarulasolutions.com>
To:     linux-iio@vger.kernel.org
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: [PATCH] iio: adc: mcp3422: fix of match table
Date:   Tue,  7 May 2019 21:45:35 +0200
Message-Id: <1557258335-9863-1-git-send-email-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to support all the chip variants in dts, compatible should
explicitly list all the variants and not only the base one.

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 drivers/iio/adc/mcp3422.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 63de705..91d6be3 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -410,7 +410,14 @@ MODULE_DEVICE_TABLE(i2c, mcp3422_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id mcp3422_of_match[] = {
+	{ .compatible = "mcp3421" },
 	{ .compatible = "mcp3422" },
+	{ .compatible = "mcp3423" },
+	{ .compatible = "mcp3424" },
+	{ .compatible = "mcp3425" },
+	{ .compatible = "mcp3426" },
+	{ .compatible = "mcp3427" },
+	{ .compatible = "mcp3428" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp3422_of_match);
-- 
2.7.4

