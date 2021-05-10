Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1298A378E55
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhEJNJT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351214AbhEJNDI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF92C061362
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d4so16508451wru.7
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjOlhmCbAbyUbUH7pil1I907GgA6nAM7F2t7vQHJi14=;
        b=f9lveGxFe9Pw8WYVlGxIEgVuO1mnm7e2GgPSpQGuhH/T2sjSEST44fTvFD+tp/lIzi
         l12Qf+xSoCOYm/RxYEcaz6XwDoOsuAG+UUBpPK8nX+aGhC2BBawQOU2ZDUT3RnRJUzDh
         uucUDHJuS5NOdIvek5tQEBO3Z5BbpLO/m/QQ4PLJieBfwdpZJom4VnQDZHpQ59S1Y3Jn
         AuZJEIRF5iOmaDEyonyDmEcSSEBEnoIWLsnndskhAS9exaxVyKIIYgmJddbQEdFejIFu
         8iDI+MQVHXyShSpy0aVLKNwf47BfbRU6I+p02s9D9aYLqW+kikf+eAmxiWUR3dfIkzWr
         f6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjOlhmCbAbyUbUH7pil1I907GgA6nAM7F2t7vQHJi14=;
        b=YimpBdLJcV+MfXXcD5AthsgIzlQ/WJv/hx/zyIVz8X0uekBStdRv0aR8fi1sostjG2
         CZ7jF3K511ImBk+6dOR76Os26eV2Ai95o7xWA4p3xnMXpwkIrkWet49AU1mWxjdpWZCA
         efRrE+RvED46FCRRUShufQ+ZacidL+AEvERm3RJ38nSQcg8GTezq2nCYyg4vLmIXkfok
         ntMTnQ7n6AMHCpyRHHHSgdzjnycwigaQ+2Ei6/pyWTHHD7DoFcuFnq9FNMlnY3Ga3LT2
         EJlevm/rwBM5dPgHyAen3Xzx78Lo7vckxRE7Vp6CogHU1YUZsOpbXi/IVqWarq/KyZpA
         9gLg==
X-Gm-Message-State: AOAM532bDlbSNu+4TjvzgFxAp3rbYE678Lc2UImm2uImFwSL1p9P8uRw
        TkC/5oIiNtsx/odBs/paDML/Qfo7KBOfqQ==
X-Google-Smtp-Source: ABdhPJyAXSIWebWDF2S3D1eLFeO0OlxyJoRD3nHZbVLU9Hc5ZKi7lZjH0aZy9cWQknjoFHOmhKU0TQ==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr31894907wrk.244.1620651359564;
        Mon, 10 May 2021 05:55:59 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:59 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 09/11] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Mon, 10 May 2021 15:55:21 +0300
Message-Id: <20210510125523.1271237-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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

