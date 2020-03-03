Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4231C17828D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 20:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgCCSji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 13:39:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50327 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgCCSji (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2020 13:39:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id nm6so1323434pjb.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2020 10:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xnf0NI2/B51uk0B3K8Y5Ue/rYl7PH7wq6tazzg8etpk=;
        b=o41zjHXRMwWLInppoZq9nKOFbXjndU3IELvyEtzRhT5/u40bug7YIy0iqv4113hl/T
         g5caHKAt5EAlwhyZ+jMXEHUwmAXeMNo4qizkEyRzH0ZFWlkLn8IGyBvfprXLqpVOPty3
         X7XoKw03MhZTvvjtCLc7ENqb6Ycy7jt8xshVaqDjhHMP2U3CLX7D26tXQfPJ3P6rR+jF
         fRE8iNwYisB0+FZoto8TNX768cuXihmHJE9JQsLh6xf+90jshIDCuYi0oelXcnpvw0j7
         C+O5uR+M1x/HsqcEMX/R2aUafeyHPLUeK+HYwpHeXQ9W626tdAp1DKXVZQKcil74SC/I
         Wufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xnf0NI2/B51uk0B3K8Y5Ue/rYl7PH7wq6tazzg8etpk=;
        b=iAJgwS/4UXMYKGwrLmgwJunuAljIWphjeYt5vsn172UEDtw19dPvac5TXj45DvpBVq
         7N1XTFn4tKIrCzI27ENE/m+pC5a/wJzK1oOtWHcH2H01yssa6qcJDL4jxAAqFFbgaPrS
         xqv2jwU/gvqv66TH9jhcUy/3In1TWf0EQfgI3LmaEPNNdbe1HRptuxPL/Dta9KUQ2a1n
         aGGutrMMWxL+eGNq2URn1y6HfB2YuJjvI/DCsinpf8C7trPth+mVWSNA9NVHQdJnY1th
         w7kfLtslfIiXlmZcUf0HQ5Mnh48JhX4bY/ZJ2YcqTW2b7C7zX2+M0BZpJhKzTruzgbCk
         FhFQ==
X-Gm-Message-State: ANhLgQ2ok7V8SDBawwgh/ctuu61Y9BG7DeFdoWYbHx84kWV2Sh48xKaI
        tb/J8R8/yFcj3263/6zFqOQ=
X-Google-Smtp-Source: ADFU+vs4meEItvw+yprlIhr2eH+z7mYrPFCc8mdOqcGoxHq3P1Ck6MIovTiJN0IptWk3j9iKZD3lWQ==
X-Received: by 2002:a17:902:b28a:: with SMTP id u10mr5532832plr.1.1583260777414;
        Tue, 03 Mar 2020 10:39:37 -0800 (PST)
Received: from nish-HP-Pavilion ([113.30.156.69])
        by smtp.gmail.com with ESMTPSA id d14sm3474291pjz.12.2020.03.03.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 10:39:37 -0800 (PST)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, stefan.popa@analog.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        nish.malpani25@gmail.com
Subject: [PATCH] staging: iio: adc: ad7192: Align with parenthesis
Date:   Wed,  4 Mar 2020 00:09:32 +0530
Message-Id: <20200303183932.7051-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch fixes the checkpatch.pl warning:

CHECK: Alignment should match open parenthesis
+static void ad7192_get_available_filter_freq(struct ad7192_state *st,
+                                                   int *freq)

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index bf3e2a9cc07f..20fe7464da7f 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -477,7 +477,7 @@ static ssize_t ad7192_set(struct device *dev,
 }
 
 static void ad7192_get_available_filter_freq(struct ad7192_state *st,
-						    int *freq)
+					     int *freq)
 {
 	unsigned int fadc;
 
-- 
2.20.1

