Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15F618CBC1
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTKhU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 06:37:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35455 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgCTKhU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 06:37:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so5722887wmi.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2020 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPszMglBOJimcIW3CGPIRnktKkoaUbfqXLUjOPxG1lY=;
        b=iTpjoEgIFBppSqKaEGYC5Y5KUF9vNfxHkjDz6S4YcuswcY85T+s4OUvno9haOUCgWD
         HuGF1JcVzUrwsk6232Qf6BXNKl59PW+E2vdJdydJKmh/p4hvcWE4ZwPb9OLdh1y0fnTu
         4ZCrJdmn4titAm7iGgVil0W9A07djjEMc8CKWHBanOkMm/KenqgnMVRzOI6G9llQjLBr
         qmhM5hV4Nnfn44tMFulihVsrxxcthLWH+KbETs46ZbnJ8C7ORp+vDaJpJc1x3Wr0GQCP
         3ECtz/FdjkhBwtxwlIT1rXbITuvPmsf080oLtTHBz1/xH+stRmrLslwJ9/CBO3GhLFL7
         CuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPszMglBOJimcIW3CGPIRnktKkoaUbfqXLUjOPxG1lY=;
        b=kCY0X5kyhhg5hvXJMGGhdWhHDxMfk7oem5Lk3ETttvFL6mL0H564qV/SHfADskv6eN
         ulXBiHnPw6TuNib2AVBH3GcTcyZNTLQGbMhaJSdJIDWXcsH4DqF/+njnyZoELM1TQGW2
         KwHQCtOQXHm42kXn4JpAmTiLVJxqayOqc/94jwpG0od7w33dJhElQ+cRzyNOXNn6a9Kp
         uyM/v8iShLdCbmkXm9u+SacuGg0vEqx3cBgtxV84NzUUbN9PTd7K0oP7uqw4ZYQL7jjp
         JWI5ikfULlmgL23MOlD8P75HBYUF8ktkeHCvRfMRuxsJzBhkpB2srDNZlACUgJHl1P1m
         f9yg==
X-Gm-Message-State: ANhLgQ3r5MKQAR0BbHkGSu8b5Yx0oNznadIiALMzhsjgpmMX3GVATF17
        Dx2T7l91H5g1PJlIPYC55NjmfRnj
X-Google-Smtp-Source: ADFU+vv5tmv7VaGED6FqIUF1E/OAl/I0Lgs5L7/kxPZFucLLink8ON8Yc7qR1T3zR5ZzNNa8zWJHyw==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr8895593wmh.143.1584700638089;
        Fri, 20 Mar 2020 03:37:18 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id w67sm6881531wmb.41.2020.03.20.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 03:37:17 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC][PATCH] iio: buffer: Don't allow buffers without any channels enabled to be activated
Date:   Fri, 20 Mar 2020 12:40:31 +0200
Message-Id: <20200320104031.31701-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Before activating a buffer make sure that at least one channel is enabled.
Activating a buffer with 0 channels enabled doesn't make too much sense and
disallowing this case makes sure that individual driver don't have to add
special case code to handle it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

* Found this relic-patch in our tree, from 6 years ago:
  https://github.com/analogdevicesinc/linux/commit/6d680e49d459c
  It got moved around a bit, and this is the current form in the ADI tree.
  So, this is also a bit of an RFC, but if the idea is valid, maybe it's
  worth considering upstream. I don't know of any arguments against it,
  but I could be surprised.

 drivers/iio/industrialio-buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4ada5592aa2b..f222a118d0d3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1031,6 +1031,12 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		return ret;
 
 	if (insert_buffer) {
+		if (bitmap_empty(insert_buffer->scan_mask,
+			indio_dev->masklength)) {
+			ret = -EINVAL;
+			goto err_free_config;
+		}
+
 		ret = iio_buffer_request_update(indio_dev, insert_buffer);
 		if (ret)
 			goto err_free_config;
-- 
2.20.1

