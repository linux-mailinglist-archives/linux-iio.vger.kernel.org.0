Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F122224A2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGPOAb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGPOAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2DC08C5CE
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so7163892wrl.8
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8klAYyQO0XUjk+Uaf4FLOiJI4lE5n5MAvDNv6XD4s4=;
        b=rWWjgp5yi06+2DXZJxAsdNxCG5tnt2dYAi2ahRNYwJCTEx2h7BaK0uNb3OI+uFFNyh
         rW0mcah5d6ueSxyqHunSJApOSDMbOw8svgfMysK+ef56M57UZEWyiERgsTCLoeZ0I4dL
         0i9nCcefv3Kcv3GZ0/FXR4XgsNlcllSu4RtbhWzs8ev7swk9RY1WdQxAefYUvFLdyunL
         im1eWm3xazGIKw8hNGzSpqXKJId1ZLKkXuk1ORJZfvGHIVF8IpAGH+iYcGDfWnAdVluG
         T2jmNNFhJrOgkDRBXKvZYHj46aRArO9pzKt2YQOiFuLF+8GAj9NDN7Sxbrae1ISzy+Du
         XLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8klAYyQO0XUjk+Uaf4FLOiJI4lE5n5MAvDNv6XD4s4=;
        b=I3CSMCfo/n6SIV4RlZMjmgRFCzBf12/wyE7o66JkslBrUuPB/VT0RqyObuJJzUKZ5B
         OGX2O/iedd4cCxiYTybS+0u2j3yZXBx/hCUO/AgMCAUfD+hdDosY+3XSx+XGVNfKPk1U
         y3aRveYkQFO7d9nIHIjgPZcmxrNGD+WplVKkQn24xuGhACGKT7dOGF6W84lrmPrm67JZ
         WW5QjSqtsdcj7Up6KJi8XsuhNY7yt8yWvXvpVhDjVCzhEbtp7KlZm7q/c5E8g64jvDfk
         KTPnYsm0lQCMxNxICgev3J419f7F80xjxYFzg6gH8YA1dauWq6VJlJwTYiKHotRopnMy
         diIg==
X-Gm-Message-State: AOAM532NzO+5ha+m817+DTLkby5BoTsC5PAi6k/2ymYStVI00eOQ7tFQ
        NEI6o3NnLqPrY29LjWdK8HF4yg==
X-Google-Smtp-Source: ABdhPJweGCB6iQJoMayzb0bRmwsZwfnIpzosj+nfPpw9Qop4m4IZjfYVe4ImGbZKXoNiKwe+O00u3A==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr5036571wru.88.1594908006570;
        Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 28/30] iio: magnetometer: mmc35240: Fix function header formatting
Date:   Thu, 16 Jul 2020 14:59:26 +0100
Message-Id: <20200716135928.1456727-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All lines in the header must start with " *".

Fixes the following W=1 kernel build warning(s):

 drivers/iio/magnetometer/mmc35240.c:304: warning: bad line:                             compensation for output value.

Cc: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/mmc35240.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 1787d656d0094..19e46b1f4ee81 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -300,8 +300,8 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
 }
 
 /**
- * mmc35240_raw_to_mgauss - convert raw readings to milli gauss. Also apply
-			    compensation for output value.
+ * mmc35240_raw_to_mgauss() - convert raw readings to milli gauss. Also apply
+ *			      compensation for output value.
  *
  * @data: device private data
  * @index: axis index for which we want the conversion
-- 
2.25.1

