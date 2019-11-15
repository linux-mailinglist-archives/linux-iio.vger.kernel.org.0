Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203C2FD9EF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKOJvh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:51:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41117 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOJu1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so6360315pfq.8
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00TE3UjkilRir+eBZdBUQADWxjiLoIj6o72iA3B1Sak=;
        b=g+iOhcZrs7UHvseKUzS7H3Gpvuf+nZBEoWW8rYkkCFWMInk9W59sz0xitzhao5Txsi
         WrUHfnBCjiQRmDJ3EAACFoIQ78JL3NwHz6QWOXGmrjik1Fex0wwvpOo4JlBeAboBLH5Z
         O89w7p63Hp9pEwQ3GHEpduv0T3LhEn0JEmdsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00TE3UjkilRir+eBZdBUQADWxjiLoIj6o72iA3B1Sak=;
        b=Tu1VGqdj1nUKOKi6J0Krq0pUaKW1KUQHjjQWgARLGcHcd6cNaLtBIpAD6j7EDFHC1R
         j/+ZJnBH+LcDWNXkrxal5o0UBQfQzaHsxS5sAbZvIGk0/b5FSBwZQ6DRaKm7CKRUWQ0Z
         V2UyGjZlVzRZrOTHrp5ccRiJ6zAKygzKH5CBwGipsMGPBIdOn/fxwRLfRBpnbxy8clRF
         LEVLiZnNnSa/qfDjIyEeLxBVWfmz3DyGH2VU6XACupey1uX4UlTkvNRNAgYVCxOSxxBU
         33cSiPlsayVJsq9GCD26sOLSgHOLaVVg1TxUfx8POSjrY92KBOOaJ2TfuWdyKhOu3ggU
         CVEw==
X-Gm-Message-State: APjAAAVt6W1T4rRaqQ8VE0nVJStFeLFJB2ITZ2m0qSFPsdKGTft1LYkv
        f4julUABZ0aKEeayK5ZjTMbx5g==
X-Google-Smtp-Source: APXvYqwSf7X2rW+Bxb5/bsjJWmQV2TgPWw6OX5rnxCqpAbf3+Ggth6PILQOMBFyXwlyMU5+ZUMuJjA==
X-Received: by 2002:a63:1f08:: with SMTP id f8mr14240497pgf.145.1573811426996;
        Fri, 15 Nov 2019 01:50:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y14sm9792409pff.69.2019.11.15.01.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:26 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 05/18] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Fri, 15 Nov 2019 01:33:59 -0800
Message-Id: <20191115093412.144922-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
No changes in v5, v4, v3.
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
2.24.0.432.g9d3f5f5b63-goog

