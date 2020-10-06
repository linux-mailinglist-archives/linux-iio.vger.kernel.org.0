Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48B7285430
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJFVzO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgJFVzO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 17:55:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA8C061755;
        Tue,  6 Oct 2020 14:55:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 22so82834pgv.6;
        Tue, 06 Oct 2020 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=41YT6TynwC5ufFrllX6VSGwwbv2gFzlUh+XiHKPl8Cw=;
        b=E/mD8rmbsDDo0cpmH1IH4aR36Q480W6RiT1EjMo0xNVCmJCrLqkyefbsVcFAPQ13wW
         rfp6ynKON679HDFU5wV/6U9Kzspa4gC2XrcDlm8Wr88QtINQ3b/LZC+gj8jE6Zpb9ZZW
         Gm9pFXYJOEIftZ+rXnxLlxWa0kJDsMxEuv6gFmUUDrHRY5RtQ0pSyDwLQHCYw1ge8q6D
         gEtoBFyo9tpOjtAR935+wSy+zRHM9Y4yf9Na3O2rTcPMvH2DlMJUxZ4+cVaGvkvW86dI
         eOIOenLZrUQ9bGrIWIYth6HNzmvbJYkWERKz98YDguzDrLpF16MWQhqQKo4MG7UrBpP9
         JLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=41YT6TynwC5ufFrllX6VSGwwbv2gFzlUh+XiHKPl8Cw=;
        b=negntRDU7oPY5/8C0Y3kbIJSfswdcQKVkgZYnCG00HgxCPDG9MohDNSETKu0qh8XKu
         RwiKOMBFWg+RCVwPM0AW37iVmHnxx2zlOv6yCvMoIVWhfbI992mlkZNlh3fI/8IzyVzU
         Dn6ip33EdBbsRRPQhHQYwkxqhrkWfqq6iXZWQ3Q1fv7cWTUvn+kXhOfmdqHwvAHqTJJ1
         yL/I4gQnVlDGWEmePPz+MjO6mEJejaWbLT+YO9iaBXbo33vrp31KAFbpJEIw/7w4YxhR
         BjE6H8XeAxT5A9a5ZU5ROqyEtGJsMNV34zvM0E6hqgaGCpK2QJ008t6cQjxpe0hkl++t
         zIdA==
X-Gm-Message-State: AOAM531fLSwaxrwj1sLULGQfobXNZqTFDwFWZUF9ZdhmENnCHVNRl2+H
        ayXNmcW7gZbUHckDXqTtU3w=
X-Google-Smtp-Source: ABdhPJzpyBKLQjvXEkHl4oYJaVQUu5wfHAeN9KmD8z/Sqd3e/fEN1+fU+i4L5I0H2iYxucDQe9nn0g==
X-Received: by 2002:a62:7749:0:b029:152:9d3b:c85e with SMTP id s70-20020a6277490000b02901529d3bc85emr35858pfc.16.1602021313034;
        Tue, 06 Oct 2020 14:55:13 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id c67sm148242pfa.209.2020.10.06.14.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:55:12 -0700 (PDT)
Date:   Tue, 6 Oct 2020 14:55:09 -0700
From:   dmitry.torokhov@gmail.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201006215509.GA2556081@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The order in which 'users' counter is decremented vs calling drivers'
close() method is implementation specific, and we should not rely on
it. Let's introduce driver private flag and use it to signal ISR
to exit when device is being closed.

This has a side-effect of fixing issue of accessing inut->users
outside of input->mutex protection.

Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v3: fixed typo in exynos_adc_ts_close() per Michał Mirosław
v2: switched from ordinary read/write to READ_ONCE/WRITE_ONCE per Michał
Mirosław

 drivers/iio/adc/exynos_adc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 22131a677445..908df4b9b93c 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2013 Naveen Krishna Chatradhi <ch.naveen@samsung.com>
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
@@ -135,6 +136,8 @@ struct exynos_adc {
 	u32			value;
 	unsigned int            version;
 
+	bool			ts_enabled;
+
 	bool			read_ts;
 	u32			ts_x;
 	u32			ts_y;
@@ -633,7 +636,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 	bool pressed;
 	int ret;
 
-	while (info->input->users) {
+	while (READ_ONCE(info->ts_enabled)) {
 		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
 		if (ret == -ETIMEDOUT)
 			break;
@@ -712,6 +715,7 @@ static int exynos_adc_ts_open(struct input_dev *dev)
 {
 	struct exynos_adc *info = input_get_drvdata(dev);
 
+	WRITE_ONCE(info->ts_enabled, true);
 	enable_irq(info->tsirq);
 
 	return 0;
@@ -721,6 +725,7 @@ static void exynos_adc_ts_close(struct input_dev *dev)
 {
 	struct exynos_adc *info = input_get_drvdata(dev);
 
+	WRITE_ONCE(info->ts_enabled, false);
 	disable_irq(info->tsirq);
 }
 
-- 
2.28.0.806.g8561365e88-goog


-- 
Dmitry
