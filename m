Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D312D6905
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbgLJUnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgLJUnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:43:42 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E2C0617A7
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:34 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so3390376plr.7
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQCmL9CEGtjCHvQ1YCoS9503FiRLG82FOEJ8bL/K3Rs=;
        b=I/43om/D0wlbRn2MiEcJo5pc5JLldMHZ09AVU5UAJtLDY+4n5Wz6NuRgbGx+FUldN+
         LNgmoQ/S0ZdCineQApqe/h9MWdoPXhh5m/oGVon7+yHEaYFKFem7hS7uLrijROnQjH+M
         2zcQIcUyZKbXuwyDQ05CULDW1/uc1QkXMnyOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQCmL9CEGtjCHvQ1YCoS9503FiRLG82FOEJ8bL/K3Rs=;
        b=Fz3w1yYVb3uKmqGFxqk4yRByz8kMa6FxphxCuU0h5iM8qS9hsN4qmsHTQhrl+M22DB
         c/TLmYmD8KhgI8U3UagDasg/uRvbrHool7ltmBg7zN6HK/b6SJLgHbYrkAALbMe3/Ps4
         QWbb6bBdgB2TqCGCYbvGLiX4fVOn4EG9Y7fav3m4VyWzlAPLJoPEQCgTjkt1ENS52fXg
         iNB/hqmPvA1m653yK3huGcZ2vqOrTSn5iNyGDp9OXPPLFs5BA800j1PQk52Q4LtWxAul
         vWPlaN4tPHBIp3GY+SR9NoSVao4YaTLNN7/pGWRSYo5kyQVvVHirgzIqgRlv8X5SHbUt
         jbXg==
X-Gm-Message-State: AOAM533/Nz5+1XJgswNHEgYFaHppmaTDB/gIdQQJRSZaJQiRLiHpR4S8
        V1CibCGEaDhdKUzeipv6Bw09rA==
X-Google-Smtp-Source: ABdhPJzCDiV4pxEZ09H8wPcSND8P3VKjSgcNzV3nD5m1NcKRAudiR8xxmF5/bNuiJd3XMpvJyjUW5g==
X-Received: by 2002:a17:902:7606:b029:da:246c:5bd8 with SMTP id k6-20020a1709027606b02900da246c5bd8mr8004552pll.27.1607632953619;
        Thu, 10 Dec 2020 12:42:33 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id a14sm7435925pfl.141.2020.12.10.12.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:42:33 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 7/7] iio: as3935: Remove code to set trigger parent
Date:   Thu, 10 Dec 2020 12:42:11 -0800
Message-Id: <20201210204211.967018-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210204211.967018-1-gwendal@chromium.org>
References: <20201210204211.967018-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Already done in boiler plate code

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/as3935.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index b79ada839e01..edc4a35ae66d 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -411,7 +411,6 @@ static int as3935_probe(struct spi_device *spi)
 
 	st->trig = trig;
 	st->noise_tripped = jiffies - HZ;
-	trig->dev.parent = indio_dev->dev.parent;
 	iio_trigger_set_drvdata(trig, indio_dev);
 	trig->ops = &iio_interrupt_trigger_ops;
 
-- 
2.29.2.576.ga3fc446d84-goog

