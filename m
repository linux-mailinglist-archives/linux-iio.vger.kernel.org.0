Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133D0E6A0F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfJ0XJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:09:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37035 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfJ0XJ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:09:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id u9so720833pfn.4
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTdKfrLaZ8h651voQL2XDjEiqFz4XHidi31jv2eQb/8=;
        b=cPOgXS/fG4NXLZ+t447zk5ZLIMYffgBBy+cNDMwQhf2zyWy8+wxvgo8flYKxNgKAGf
         jafroM/A0lMeh/BgTtSiXwMWM1k7ZU7p3GhYtJcW8ow45AROASJayz3it3GblvF2fTLT
         4+ANY/QTWcO/X7VrqklyhPm4gU9GhpHQVOwnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTdKfrLaZ8h651voQL2XDjEiqFz4XHidi31jv2eQb/8=;
        b=VRQN3oPdxavFbteu8o43tjjwgjDz8B0KyEC1GNthMI0xookBu3Rx31JFFz4bohJp1t
         WNTtEWdAAW1j0oxhY0qTmflEw4X7zjl2vDOcmFBQAIzpDDj3CsWcEEnvHCfwkbBeVYtQ
         bTW7bzJutmmpzUdmC3LpnE1bdpSTpsrBYtPFjwQbbD1j6KzjccpZmtuI6V5DYuI6zUbw
         bscIB00Vb7usxbP2+bwQu7Q+VmZDUNU+GTH5VepuugDh2dnLOWewW0Wm6B3GxGVzrt9D
         M9Z/zzMzvjURUW+G4ActNLDkudnIIvW0PpA2BvMTJiUTgL/FHXGpMa/5SQvhowYAdIc0
         Oazw==
X-Gm-Message-State: APjAAAV9UurXh+rCRxvRp8L66gD9tOF0R9BfKzPiRgJ2VuHIBrPzucj2
        JSAbVZz3O7lQyC1mo7rjUnsi+Q==
X-Google-Smtp-Source: APXvYqyK7sN9XN6YUV1OXI0ZPMAZ2IMJCrVNlled2K1XGwtk3vPjdfMCREUiYbtUJqhuUgpAE+rDsA==
X-Received: by 2002:a63:4081:: with SMTP id n123mr8617326pga.444.1572217797813;
        Sun, 27 Oct 2019 16:09:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id i22sm8755307pfa.82.2019.10.27.16.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:09:57 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 06/18] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Sun, 27 Oct 2019 16:09:09 -0700
Message-Id: <20191027230921.205251-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v3.
Changes in v2:
  Remove dual Enrico's signature.

 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 739f3cffe26e3..9b19f50572313 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(
 				dev, ec_dev->irq, ec_irq_handler,
 				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-- 
2.23.0.866.gb869b98d4c-goog

