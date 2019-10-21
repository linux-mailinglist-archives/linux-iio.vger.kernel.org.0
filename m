Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA6DE412
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 07:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfJUFyX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 01:54:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43490 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfJUFyW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 01:54:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so7691506pfo.10
        for <linux-iio@vger.kernel.org>; Sun, 20 Oct 2019 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8emxxlyv0hfOTgOOWBUsQUpOlmvH2jBaXtEtprCbnfQ=;
        b=QEsYal5IjLMhnSvwqYnWTC1cGImeuZg5zYsuCBeORCFFYfeGHipQQiEWg6jKzClb+c
         MZTu3m9mT3MSVcuS3NJY3HI/kgL7aEOc1iuYar+t5pWRxe/9Pu75j56hWm6IhNHaFqAV
         E+g8aQdvYFktGh2uoqA/QpTmX9bA8cd0mR3Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8emxxlyv0hfOTgOOWBUsQUpOlmvH2jBaXtEtprCbnfQ=;
        b=RMfKczYs/4NMJSxH9+KMiQiYvtwo3fj7KQqIqIybJ1TtEiaE9nfSbeYzWeg7UqNBj4
         9ASfP7dkFfW6FpK5T2wM9zgm2FI2qunU91yaNOPoyD9vrDR5qRGwihct6BosGnS6Eu2w
         zfBnHO1QA8sNNWvwI7dbpneF5q8BWK3RIk1gHs8lArKWKFyNOLUvMCZKDC9P50ACWC1U
         J6s4uFOEh1Za1QZ9hEZhwSnrkwU8b8jlxsFpUPjLNYtJnQEY40HAovlunmUm4t9tDxYD
         0qXiGCu7++XtJlkjeLNLvpw2OSl1vkWpDb8nyDznP7Po0AujOJdyPz6c5MmiTIhnjJ+y
         F/GA==
X-Gm-Message-State: APjAAAX7nremdRtOvgc+wl1tYt7kpn/+N1siYALPXix/nnAi7fzFLiU1
        Ro0ha6ZGuQYryzs2CgeRQ0BQug==
X-Google-Smtp-Source: APXvYqx2iXs9sZJnmULUcwsogTtABgRk9/VAH8NymvwT5xOT+nEept4zrlkYzUNbZBVIoiwwZKFkrA==
X-Received: by 2002:a65:5541:: with SMTP id t1mr23450120pgr.39.1571637261616;
        Sun, 20 Oct 2019 22:54:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l62sm15062699pfl.167.2019.10.20.22.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:21 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 06/18] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Sun, 20 Oct 2019 22:53:51 -0700
Message-Id: <20191021055403.67849-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
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

