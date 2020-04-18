Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5459B1AF2B7
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDRRNK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDRRNJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 13:13:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B5C061A0C;
        Sat, 18 Apr 2020 10:13:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m2so4393377lfo.6;
        Sat, 18 Apr 2020 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLjKI5kt/nz0FED/E5fKjEGru5J5mggpxkmQ2KMue90=;
        b=CWaWe+CWfqXHgxGpDddr3tkH0nm5YD9jlSvzsSoZ9cnPG6nw1jLYE6GRnYoQ9xC7Eo
         G+ckb9pJtEb26m4jS7yqgTxzeNS46vdQ8Xa1uxJm9EOv/eKztTh+36lYlB7e/DIUCoeX
         RrWfkpQoaaDxOlKFkX2xz56oW4uE21NTh16IvzxWDb15pQFlUvFtS1RGAuVyDOwOFdGB
         wiWP7cpSzt7Q9vFFlCvyTrmRftJ19NXHvgMNPQLBw3RvSbveYsCVBKmYzeQQz1b12Z/I
         XCEtzndP/7UNqRz/AR9HMUSEeUqhyisxl8XGhp6NWj2InJozDkzv4zJnnLj5k8H7oxRn
         C+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLjKI5kt/nz0FED/E5fKjEGru5J5mggpxkmQ2KMue90=;
        b=hyWzTXQFj55jHGMkPy77WIZVqJpnndoJmWrNjjRVTwhsW9EfdyPOtXVj/iEN3xc3Wi
         jH+EmhvGwB/Y6FM1umERcg6abbWBwProLcOWw9qax/DspOEMrS6L++8SpPR7t5klHx6h
         pYYECNpxf74l3ca4IjyiGcLOyTnPgcA+eZ+xBkG0mdeDO9Zjg7KiEgHdbAukSq8FjRuR
         72QRgoMm7Dct3PWDM5WyaXOuUlyI+1XjEIfco5fbgJCst9rhSU1f+ZAqwspcOlZnN+Iw
         yn6xfwHnjJq3ydZJ8uyhxB5miNuttUgfUQOEsB/27XtNUOVK4ukw1NAgMXF971nYw0so
         SDJA==
X-Gm-Message-State: AGi0Pub/59xRgGPBPLkvEe9TA3Nkk1xxJwSt0DYUdZ6yDgJzvnquoCf/
        xLHhzsyV8CSw0Kb5sc3/xeA=
X-Google-Smtp-Source: APiQypJjd8R+7O0NwKgkpwn//Wp2XNZZdWoGXKroo34LXL/Br7hRxmsA7Vudy2CLquqr0blRBE3VfQ==
X-Received: by 2002:ac2:4248:: with SMTP id m8mr5513826lfl.211.1587229987737;
        Sat, 18 Apr 2020 10:13:07 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id b2sm16465198lfi.14.2020.04.18.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:13:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: magnetometer: ak8974: Silence deferred-probe error
Date:   Sat, 18 Apr 2020 20:12:44 +0300
Message-Id: <20200418171244.2320-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's not uncommon that voltage regulator becomes available later during
kernel's boot process. This patch adds info message about unavailable
regulators in a case of the deferred-probe error and also amends the
error message with a error code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3: - Replaced dev_info() with dev_dbg().

v2: - Replaced dev_printk() with dev_info() for the deferred-probe error,
      as was requested by Linus Walleij in a review comment to v1.

 drivers/iio/magnetometer/ak8974.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index d32996702110..372c80c25dd4 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -746,7 +746,12 @@ static int ak8974_probe(struct i2c_client *i2c,
 				      ARRAY_SIZE(ak8974->regs),
 				      ak8974->regs);
 	if (ret < 0) {
-		dev_err(&i2c->dev, "cannot get regulators\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);
+		else
+			dev_dbg(&i2c->dev,
+				"regulators unavailable, deferring probe\n");
+
 		return ret;
 	}
 
-- 
2.26.0

