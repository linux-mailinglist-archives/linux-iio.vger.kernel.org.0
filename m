Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB9837F77A
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhEMMJ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhEMMJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E736C061760
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v5so19614832edc.8
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=j/pXCq7yyKY2f3i6cvIOBs189d76MN7wr/olH2qy9H1hTBYAcVTHQcKa/pAa+1yG2W
         CX9v59oLtDFskHC8wxRmy1SvnGLLcMA+Sw8etHN0ynspW5m/I3p8vYC0a9YYcc8eM8Tz
         zpFeZ/O/btnvhlQCqlw/vRa18JWZi8QYUCTkrjHXBdqNnFBEpPyHU1+MUBxyepj2rGnU
         fnlNflUysjK70JdP0wIH1MWyW5xmyGMShICoo8YPQs49x3erVZ7KOb/bZDTJDS1maw9g
         AliHKRjfuieLfpAUTRG+nHYl6YqwKrZ9y5PDTmtcgx4Uf6VVLSq58lRKKOCpuTwvoxzW
         OZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=feY6eUEzECVXHLiMPutPKCphzI8kuM7upYqaya6tLhwaolerYjNbh9fv7X+zYbHcKk
         hiRcLjm175BmOewzjH71a7GvEuiIOoHS5EnhqP/sjgxsJ7YOtgYYtD9X6K0YsJiPgo3r
         udyU2A+Oal3Tpl5K/x9/NtqknsP+0WluOTGStvBku+S0mRsfASZYQqsaThJ6vEyzHFjW
         TlWJcMYHx8JjLuly6DMBW9NGLxDGMIO3ZxWClr8ey78XfyevF3mQbt9ChfHJ2DshZknd
         1B2Lb4j5HIJGylNluKLf7XC54D1LtzYIo14bgE9c7zrj4pGfZYdZYqYdpXsj+YxyHFI8
         rYGA==
X-Gm-Message-State: AOAM533bf6wgqjkBttdNp4dIzOFFDlUWSphLj+B7994WtVfwxvDf14LG
        HnloICA+0COa6LORuZOyUKN6YWbsBFKJOg==
X-Google-Smtp-Source: ABdhPJwNq7I8jELq7dfbQ11I6wg8a3GyeI0wPZA/knJ9SF0Qv+Uhj7wnbgGccesdRxFEKOqjXow5bw==
X-Received: by 2002:aa7:d6c6:: with SMTP id x6mr49115549edr.193.1620907680776;
        Thu, 13 May 2021 05:08:00 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:00 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 02/12] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Thu, 13 May 2021 15:07:42 +0300
Message-Id: <20210513120752.90074-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

