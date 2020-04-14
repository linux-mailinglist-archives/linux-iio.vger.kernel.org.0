Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456441A8E8C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391952AbgDNW1b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391937AbgDNW11 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 18:27:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7CC061A0C;
        Tue, 14 Apr 2020 15:27:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m8so1595738lji.1;
        Tue, 14 Apr 2020 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLp0HygEu7GAg7oIbA1nV2W2je4E098v4ACpDylFIzM=;
        b=jTvRC3oZmu88HXsxGlEHPY1mOriSkUGFTmPPFIwXNtGPlHEe0j7GY6sdt+h2c+bS6g
         dmVay9zs7sypuuukxtcdkuYPsHYzcfKYb/VxO4NRhuAHQaDJrdfnSe/MGOEuzbvpnNak
         4sOCbCHlTd0IWMp1jOJPBAbIy/cLgNo6TJTId3a78w99dRmt5W2iy0YbvBz2cmddd9Aa
         DPohWeAY9MHygXGmA8OswQONs2SVjLlrCwHwuJSvTao+OpwgD0T94synKT/um+Sx8eBy
         7pfjd7t/s2FVun3z3xv8pRJ72hIgEKyB6RZAY/eg4dagXPCh0kv6ZA7HXf3aBJS4mZUJ
         kUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLp0HygEu7GAg7oIbA1nV2W2je4E098v4ACpDylFIzM=;
        b=ugxWfVrS4pK6TNUFabUwooxPls5geWWnbHzA1Ul/dKUu/MzOJfQeZoXrR+QiK+L20l
         dDfF8dkggdnIrHkF+3TT30DhXR2jtqGljSJTeR+ANDowa61lLAQnwf+m6svafnFBm38k
         oI7J6h1P4djUL5nhZgRuW/CpUHLB7fndxnfvOcLAesXAUPc36B8AygHzVy5/l9r7U3wK
         hsISUCkHYKWz20F3amntxBCjvG5Q7/iK3E7Qux0YDevJbCakycYKSmS1Z+bkb4TCiAW2
         MbcbJGwDxszkv0Dl7xMZZ9GuM7ViS+zaoqHQKgT0npD28+Jj93hvD2eQoLWhnYvmw712
         i+zA==
X-Gm-Message-State: AGi0PuadI5sea+33UQaYlelYCBiuPOIQYDxMZxj+cVjQCiE3BB9wx/6D
        2D5QfYz1mpwNakWp4eyBjWo=
X-Google-Smtp-Source: APiQypI4hypqmE1WZVsRt9dqJ0ppHkmo+BzzonvWd7fBadIG+jBzgCyEIgFkNq5zK26r0UJb6C9BwQ==
X-Received: by 2002:a2e:a36c:: with SMTP id i12mr1317201ljn.24.1586903245819;
        Tue, 14 Apr 2020 15:27:25 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f21sm11063528lfk.94.2020.04.14.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:27:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: magnetometer: ak8974: Silence deferred-probe error
Date:   Wed, 15 Apr 2020 01:27:13 +0300
Message-Id: <20200414222713.32660-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's not uncommon that voltage regulator becomes available later during
kernel's boot process, in this case there is no need to print a noisy
error message. This patch moves the message about unavailable regulator
to the debug level in a case of the deferred-probe error and also amends
the message with error code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iio/magnetometer/ak8974.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index d32996702110..cc3861f97d42 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -718,6 +718,7 @@ static const struct regmap_config ak8974_regmap_config = {
 static int ak8974_probe(struct i2c_client *i2c,
 			const struct i2c_device_id *id)
 {
+	const char *level = KERN_ERR;
 	struct iio_dev *indio_dev;
 	struct ak8974 *ak8974;
 	unsigned long irq_trig;
@@ -746,7 +747,11 @@ static int ak8974_probe(struct i2c_client *i2c,
 				      ARRAY_SIZE(ak8974->regs),
 				      ak8974->regs);
 	if (ret < 0) {
-		dev_err(&i2c->dev, "cannot get regulators\n");
+		if (ret == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, &i2c->dev, "cannot get regulators: %d\n",
+			   ret);
 		return ret;
 	}
 
-- 
2.26.0

