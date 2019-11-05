Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0FF0951
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 23:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfKEW1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 17:27:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41019 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfKEW1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 17:27:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so17090261pfq.8
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2019 14:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXg/NZjH/hD7TX6jGqJIEb/eBe/oXUCzE/oQZad6cbA=;
        b=LFfLw+MBKreN1Iof4xXyoEYjmtrVkMT0JjgV7qXaDAW5UICiCD8RRjQpU8T/boKuPX
         LdsecS1zbVezUfZs8hg0Et+d6l6pRX65Udig3mGmFDgmg2iRnssTxG4FR0sEsJcUjz1w
         C3MPcrGWVsKZsMXC1MDm2QgpOU466o+NxGzwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXg/NZjH/hD7TX6jGqJIEb/eBe/oXUCzE/oQZad6cbA=;
        b=A7Hbi5OArmu5MGoNrutXKXyCWC/kUlGzbc43iKuOoa3szlnQOrBwg9BK0QP/+9MIEm
         bfx1011J0gVMcTrlPsltpyldEWcN8kD2qZByRkFwKAN8dfBSBmxPUW5LPIk35s0Adzfx
         9q5EYJ0n0nN4x5pFmHR8bR547MnccCJVOJms7h9f9sF3/TMFU66WkHsoaEo3fVmrjCNP
         xvpMDnFQ76CVnmqVABWSfiIqGj1+jpzzyYxGqvYEb254LIc8FAKK/E55k6D+7AnBjLZU
         1TzAM1QErjPIl3p1k8VOGl7E48RVIwqi7JPzJUtY2XctwP2Wk64WuSSEBM6bwJF4bLOP
         UAKA==
X-Gm-Message-State: APjAAAVZMa25yAktmRMM9o+9sdMd4txi6F1lPOdKKBQNQfavl2+bwZwA
        bOLUZJhm5SXOl+8vKqR8u7LUCA==
X-Google-Smtp-Source: APXvYqwsu6CpMgRQEtw0FjUj56O/BjNVUox2OHY+SuYH5Kjpvitqm7JjoNSHEgbpdxdoGQRMuzsUhQ==
X-Received: by 2002:a62:1ac6:: with SMTP id a189mr40204637pfa.96.1572992826306;
        Tue, 05 Nov 2019 14:27:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id d9sm20415695pgc.80.2019.11.05.14.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:05 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>
Subject: [PATCH v4 05/17] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Tue,  5 Nov 2019 14:26:40 -0800
Message-Id: <20191105222652.70226-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v4, v3.
Changes in v2:
  Remove dual Enrico's signature.

 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 925f84dbf621..d3dfa27171e6 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(dev, ec_dev->irq,
 						ec_irq_handler,
 						ec_irq_thread,
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

