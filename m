Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A4B23B166
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgHCX6u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgHCX6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DAEC06179F
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:34 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w12so26785825iom.4
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsVqyjHcA1iKwUDBxCp9up0hP+cWrDA1sHvlf/BCc1I=;
        b=AiShUQSXnB6sCwZ0hjrv/cNhWcDpdxOe25FBTj9xmqPNXeVLzAbER2ihz09Fw2BE/h
         YCyLmXGXXdiSiLOx1Mrvd3H1roH+ItiZNmy7HKicnANGt6drgrndXYPcgDL3giO6mb4K
         JLMaHIv8CT3pyKRiMubXM+tZUjlW8GFAoAfy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsVqyjHcA1iKwUDBxCp9up0hP+cWrDA1sHvlf/BCc1I=;
        b=fkFO9hi2MZhwU2wgPVvGPfv9u3VxIAi7ORw4Ms/00ea1XPjYuagjhngtaUEx0WBtLn
         U+8AQFc5dgrfAawly+YR0kRFseLnKDzdW6CJp1/VvGeA7YSyeQrrWOQ2SwVx0tlG5WvA
         V87Yyt81Wzn53ZTvMQIwInQE9Y+vSi4Hduu7rDA5gLX2KyxjaOrh7ezmYa+NdZgJnVA9
         lWkZ0lbg5d2BeLdrrvojEGt7cWiXl6H/epfOk82njTTcm2a5knpvP13714nDR7p7oSYl
         I2ys3QrHKp0m7a489NxyHKlBc8+7aHkvAq4Kkzy0KHc8TPbPeG6W5uId/NyklPEpfgH2
         1vug==
X-Gm-Message-State: AOAM5310PXKbeiOfEs1XoVQFm1d6lbyLj/Y+H2aUrp9SQPUpOMjacavx
        lGQEHx6VtZkkdawIfOebgUfZ3Q==
X-Google-Smtp-Source: ABdhPJxDqAh8c8N6NwS66oD3lSYhKYcAZzbzw5XKTWBN5KQaQPgLB22TF0PmY9OHGTOqtWAiSzHV+w==
X-Received: by 2002:a05:6602:381:: with SMTP id f1mr2386096iov.193.1596499114281;
        Mon, 03 Aug 2020 16:58:34 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:33 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 15/15] iio: sx9310: Use irq trigger flags from firmware
Date:   Mon,  3 Aug 2020 17:58:15 -0600
Message-Id: <20200803175559.v5.15.I4c344a6793007001bbb3c1c08e96d3acf893b36b@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

We shouldn't need to set default irq trigger flags here as the firmware
should have properly indicated the trigger type, i.e. level low, in the
DT or ACPI tables.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
 - Added irq trigger flags commit to the series.

Changes in v2: None

 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a68766708fb304..db97b5339d0eff 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -948,7 +948,7 @@ static int sx9310_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						IRQF_ONESHOT,
 						"sx9310_event", indio_dev);
 		if (ret)
 			return ret;
-- 
2.28.0.163.g6104cc2f0b6-goog

