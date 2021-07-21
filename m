Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE13D071B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhGUC0p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhGUC01 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8FC061574;
        Tue, 20 Jul 2021 20:07:05 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ay16so282612qvb.12;
        Tue, 20 Jul 2021 20:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxRWxmUWooh8K8wECdDWjv2qMB1v7LjacHyh+1GZlIs=;
        b=jG7T/o6af+b1FGPAiPh53sHSINRFk6kcIBKwTZ6RDWSgRqEclxkI42G6t3wsSgKDBX
         /BQpGNps3TOb34oUWrmOVluFYccEAxAwXY6jFypNvMmYtnOQJI1i1I59xoOWGLWHAaF6
         31NnBl60aMIw382WEozMGYQLpqvaNmJOGTDgKZQzlSlAnhpP1e5lC0e9/kQSxVJgFlcg
         +wGtNMGRX6jXdV7sveuDZ1a8Nm//i6RqnPnLO/Cvcdm0DMuCGYXlxbAzCu0t2ye3tELi
         BS6IRR6d3+BxwBODc8fQCciRaQ2g8yvP3UxSYO/rbZTVXTcvt7yVTjn6J/rcivk2X/Ro
         8uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxRWxmUWooh8K8wECdDWjv2qMB1v7LjacHyh+1GZlIs=;
        b=WPRw3TD1zxpdGNCW/RFHZnjM/AWFOYB0LyQsjBNQ6H61IE8pra64eVZTWmbRjHoeiO
         aPC375ZHB7ekCOg03oQY/OnNjCGI7qSmFql9cu1k6jV5Xx46dwqU7MDs3jUL7RclWh1E
         1OjakvIB7QKSmz60v2saN7pjBb+xXhJvGwzppnMMAV6meZtIVWeB+xd48jeUSSiM9Wut
         peYezumePPVwHrXf8ElXYm3TlVuYS+AKzxJT1ysReZGqSwvZyulzRCDpq57LmJSl7fmF
         otnYSco75bRBoWtttBWDfLrKKX5I9w39qhS5AHjP2lQXarn43rHQi1lsqjryzabCum31
         4APA==
X-Gm-Message-State: AOAM533he1zcpCO9P0sp8ga9p2z4a1JneYTKOqeU7G9lf4CPKGtHDpxz
        lU/tVc5aySlmf0XmwjDDMY4=
X-Google-Smtp-Source: ABdhPJyxBk5XcHK1Px5RdTIVQ8bYgzv5M+hgxwW6B8rp4MVoE9vKbmq/+LEk/8m6gMUfVdjU4MG2OA==
X-Received: by 2002:a05:6214:242b:: with SMTP id gy11mr33839017qvb.9.1626836824487;
        Tue, 20 Jul 2021 20:07:04 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:04 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Tue, 20 Jul 2021 23:06:05 -0400
Message-Id: <20210721030613.3105327-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
Add support for these to allow using the iio-rescaler with them.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index d0669fd8eac5..2b73047365cc 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		do_div(tmp, 1000000000LL);
 		*val = tmp;
 		return scale_type;
+	case IIO_VAL_INT_PLUS_NANO:
+		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
+		tmp = div_s64(tmp, rescale->denominator);
+
+		*val = div_s64(tmp, 1000000000LL);
+		*val2 = tmp - *val * 1000000000LL;
+		return scale_type;
+	case IIO_VAL_INT_PLUS_MICRO:
+		tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
+		tmp = div_s64(tmp, rescale->denominator);
+
+		*val = div_s64(tmp, 1000000);
+		*val2 = tmp - *val * 1000000;
+		return scale_type;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.30.1.489.g328c10930387

