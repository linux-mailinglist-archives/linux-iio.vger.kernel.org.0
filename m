Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E432D68FE
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392739AbgLJUnH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgLJUnH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:43:07 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F155C061793
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:27 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id i3so5249350pfd.6
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+cSdocwrQCE8SPCC6qgrwoAsqVYKoyLdt8uvvT/yqjY=;
        b=MxI+e6w2OANe1UkPtu35JC3A9vcQMC7Qr+R/yHSIskVqDZr4v+oOp+u4nGt5HyBYCl
         122fSrH1KCI+RucpLJQ0Ii/nM/yLC1gyG9ZvWgQimKkPIGquRoZsG/5llbO+uBac8jWd
         t2dzqbExA2+STu7oIkfRLTEDfBVhGAt/ghjVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+cSdocwrQCE8SPCC6qgrwoAsqVYKoyLdt8uvvT/yqjY=;
        b=HC0ZFPtADHLkYK0uLLD+3srhv9zbat8c/jdCz/uNZ9H/QTCzORzCAYZwakJ1EW5n4G
         IIKTgP1I/ZCO8V+VHGfbI7IaMkljuQAaNsv/GQdElHY8sl+BpCzcqGJOYZHjiXxj1B/d
         nXpSJCG99rRied/0jTbONCw4NWz4fIC/bGQpK8O7L2+PuUAnlJtpt3Dok6X1ly2ifSLc
         R4RClvKAkkSiguC8J4RWAz9BCDd8F9+QEgQ1l5ZO63kfY+tjbNoJ6HeRKfCDKwIwdQ0p
         kLOmMV8rzSo1kThC1Wb49451dVG2UegdSDmYONpDPMJF74wLSnxvPbiwFACxZex6GXDC
         p8sQ==
X-Gm-Message-State: AOAM530i6d7Z9emEmJtSMlGD8jkdF/VRyj3Nn709bJaCHo1+tDLFMdTa
        k0vJgZtP+GH+ccE0V7yVKQClWQ==
X-Google-Smtp-Source: ABdhPJzVEaf0H+VgRHiHc2ys2CX4MomX8oQNoWlOVM32yOmhtgArgJlD83V2Ip+4LmTl1gvuaEcUVQ==
X-Received: by 2002:a63:4566:: with SMTP id u38mr8343513pgk.423.1607632946779;
        Thu, 10 Dec 2020 12:42:26 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id z7sm7461492pfq.193.2020.12.10.12.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:42:25 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 3/7] iio: adis_trigger: Remove code to set trigger parent
Date:   Thu, 10 Dec 2020 12:42:07 -0800
Message-Id: <20201210204211.967018-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210204211.967018-1-gwendal@chromium.org>
References: <20201210204211.967018-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Already done in boiler plate code.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/imu/adis_trigger.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 64e0ba51cb18..0f29e56200af 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -27,13 +27,6 @@ static const struct iio_trigger_ops adis_trigger_ops = {
 	.set_trigger_state = &adis_data_rdy_trigger_set_state,
 };
 
-static void adis_trigger_setup(struct adis *adis)
-{
-	adis->trig->dev.parent = &adis->spi->dev;
-	adis->trig->ops = &adis_trigger_ops;
-	iio_trigger_set_drvdata(adis->trig, adis);
-}
-
 static int adis_validate_irq_flag(struct adis *adis)
 {
 	/*
@@ -72,7 +65,8 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	if (!adis->trig)
 		return -ENOMEM;
 
-	adis_trigger_setup(adis);
+	adis->trig->ops = &adis_trigger_ops;
+	iio_trigger_set_drvdata(adis->trig, adis);
 
 	ret = adis_validate_irq_flag(adis);
 	if (ret)
-- 
2.29.2.576.ga3fc446d84-goog

