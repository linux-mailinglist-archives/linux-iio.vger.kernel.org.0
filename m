Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A50BA372
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfIVRvK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 13:51:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37053 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388276AbfIVRvJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Sep 2019 13:51:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id c17so6563274pgg.4
        for <linux-iio@vger.kernel.org>; Sun, 22 Sep 2019 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0Jvq2gWf/yc3DKxkkbLAZjrOsRcmbm8R0ZFM96m1Ss=;
        b=CLGyJ8CjvFpO6DQOxgVu42i80iyo6IweyKYwfXgdn3GdBiOj+1DCVFqLwq8ReIOG/E
         WjJSnaJvrJzyOCM1bguzQT+ObydY8RbjHwfBSR7yaPHPpevZly8hGfu4HbYKJkl0CPZ4
         pLlVbq7U+4p2liJzXvsUj5ZlrHqrpK0+XkWqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0Jvq2gWf/yc3DKxkkbLAZjrOsRcmbm8R0ZFM96m1Ss=;
        b=Js2nojFMOn38nPnPhI/Bn3pcqucTo2qYSoksgyAqN8O6u8mqxvHQPsGAdlze1SVh3b
         lKOJubW5hHDSEfpwtbhgapg09VcmrN080YWhj4b07v8kT05aZa6kf7EQG4Ze38PwFUyL
         z9DTWTyrb6wYchbozRtZwTK4087ZUTqw8aPJM3Gx7qcyjwlgm7HrT+ZWcayvBT4ZZJld
         HKRZhHXpgPF+CN5h3tOSoc2u/e6oLHVNBCfNhvGzG+AxNziFGUZAxMh22ZJha1S2ihN/
         pnRN0qkkQ1ygKNbGGL6VlLdfSRlHtjiCH/4nAetQkl0Bei/khaXNKvFn5CDtmCWNut/O
         lfjA==
X-Gm-Message-State: APjAAAWhRgmq8Ts13mrodCUl8y/gCGw+peUR930EaT90KTq1q5hsbDb8
        EElqBDSa7nr9j6n0kXPQ1oKf3A==
X-Google-Smtp-Source: APXvYqwOuLPNBcsdGZoO3oSQzFhOCAEKES65yg8cyHFLtPjH+1lmOljfGpO9sgvuIW7MxzRoEqVGyA==
X-Received: by 2002:a17:90a:8416:: with SMTP id j22mr16513707pjn.39.1569174668730;
        Sun, 22 Sep 2019 10:51:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id w69sm11726474pgd.91.2019.09.22.10.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:08 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 05/13] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Sun, 22 Sep 2019 10:50:13 -0700
Message-Id: <20190922175021.53449-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@google.com>
Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index f49eb1d1e3cd..9c8dc7cdb2b7 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -146,7 +146,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(
 				dev, ec_dev->irq, ec_irq_handler,
 				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-- 
2.23.0.351.gc4317032e6-goog

