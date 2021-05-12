Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F162537D36B
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbhELSWB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350519AbhELRvK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E0C06138B
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:49:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id s20so30731413ejr.9
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=ARiwzjzixi6kh5+4cwI0MVWB0GweYEnmFJ2+cGNn+FZTzgODruNy6osicsuDPE3nE4
         4rjOlH2wXakFQgZyYyO7Yn1lgsTLMIKgLQYVsPfi4N2z2pydUd83fC78WrcA0NZPJRx5
         HW6NAS2hVe4/dlf0qSQsoscJZ3UQ5x2lxG7S+Y0N6Q/whgA7CALQn52psQ3AfPM8QSbE
         /zS6RNtTWyDdlhVzd5Aa/8nYX7/Ksr+VfUZcBDXkS3B+mGfqbhJIlpsie7wfGxSzAANA
         xhxVI4O19Oa/Scyk3vDeTMBFy2dL+cbUG174pRmWdYPnD7WSon1Cz0QeHCRcQx/e+hSl
         fZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=An3eLH21an083I9qo2654rbbkM365iDFINQGAkj68hGDTjm2o+9SZjXL7GfW3JmZpC
         +khz4b5nrk0eF5tZ5VOy7ww1rrBWIpu6PqWBXkz+cQhezD97KT0J5DwR2IxCSMF2yy/1
         bICrFxwLtosrhemRBbpjWX5gdMd3T+orJQ19KoeG1jEM6RJ4PYbWkt1aazzR2m1e1ugk
         vPziQc/SXmPLtPwsOtRCRhtzqoZf7qxRrpCizws/1kVGNoDZe4ZOF3AaVbT7CMoU1fBb
         cj0MbD3/1ikRwR6+IREZBXIx+ZGPB+g+gGo/eBqSL59x48x22xKkfj7ETBpT2RxV6SXk
         vO6g==
X-Gm-Message-State: AOAM533jxcXHaP81kZcYzXoWfwzxGjtJ6l2CjXxDFtgRmY3BfC2kyRDS
        SKzazThDpQvoqqLLzzHhJ/aiU8lJKlb0SQ==
X-Google-Smtp-Source: ABdhPJzo7tmImWNPOb4Lq7Z3+yra7hePoowXdeUssxDVr3PJD3+Y/BkCZA1BuGocp2anTSOX9BNOfg==
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr38201476ejc.308.1620841797674;
        Wed, 12 May 2021 10:49:57 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:49:57 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 02/12] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Wed, 12 May 2021 20:49:04 +0300
Message-Id: <20210512174914.10549-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Channel numbering must start at 0 and then not have any holes, or
it is possible to overflow the available storage.  Note this bug was
introduced as part of a fix to ensure we didn't rely on the ordering
of child nodes.  So we need to support arbitrary ordering but they all
need to be there somewhere.

Note I hit this when using qemu to test the rest of this series.
Arguably this isn't the best fix, but it is probably the most minimal
option for backporting etc.

Fixes: d7857e4ee1ba6 ("iio: adc: ad7124: Fix DT channel configuration")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7124.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 437116a07cf1..a27db78ea13e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -771,6 +771,13 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
+		if (channel >= indio_dev->num_channels) {
+			dev_err(indio_dev->dev.parent,
+				"Channel index >= number of channels\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
 		ret = of_property_read_u32_array(child, "diff-channels",
 						 ain, 2);
 		if (ret)
-- 
2.31.1

