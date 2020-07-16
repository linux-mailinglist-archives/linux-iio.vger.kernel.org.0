Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4779E22248E
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgGPN7w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgGPN7r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC4C08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so7137021wrs.11
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cb+wSympQ/t7mvjSrlchyDpaG5lOzmi7hZ5OiAi8Mno=;
        b=oumlQEnIha+gPZ486gfCpU6mSvsOEk0BcYWvK8/hsanQRyIRhlTtGw1XHd1ZKAntb3
         zDCnA15Semh4CaC/EsmkpiGdRQuSj3HgP1HhW3Qv/aHf5Td42D9Z4s/uVHYp4Fjz1XM1
         OCw8fiy1rDDE/qdrqb3Agd4WT/q9uKQc/RTWRkahnyGhccuQbTeTdywSX3gDFBt+N6RP
         DaFDmvWjnPap3vH8zCePAv8eTD5BA3XtcLMJHhOkJsJKl+VNjLZYQmU18Xd05QLMfFk/
         Y1tiTBVpPgEEjfvv8u3az3bSjHw7AHyPFTQ8fjW2rJ/PXcQiEzZfbNXbvkPrCkOxV1R1
         +g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cb+wSympQ/t7mvjSrlchyDpaG5lOzmi7hZ5OiAi8Mno=;
        b=jbRzfZfiKcO/Me2VkEL4QsOV2po7lxJSFfEC206cgll40tRNfo9iPIQhW0Ia4iMeK+
         O1X3PNiohdu4EZglgPiLipokmvL0wuxds6reS8TrGWYXZ34Mp/ymLZm05T/FS1w0u6eH
         y6dhwrLIgY74Uz06Exog209xHu75am0zuQgZGLaVgY815J0jSd+nj6MhDtiUMqczo/fi
         5kWqqqYKbzY8OEQsu1xBUKy71Gx93Z3+JQg9pPqD7ojl04xfDmHfsY3mhN05QUGD91H0
         Q86sa7XWm8PZhZ6gItVWH9qLyq00v9vf4l1JI+vhkQn5VdcC1ChPfv2fBBSkjsO04n1t
         esJg==
X-Gm-Message-State: AOAM531m3+gtOjcUUiMRhKZMYBaE6T4t4dtwJc6h7Q7Ua2kVezaIIid0
        yb9Jnh//0PRR1JOKKiy3ZicHFQ==
X-Google-Smtp-Source: ABdhPJzTCQ3Uui/xfkaXvBiqKU2DEubjel0BONeoSaNK/ek/9whacXXXBE4S96ii0ZuJ6/6OxW817g==
X-Received: by 2002:adf:81c7:: with SMTP id 65mr4973510wra.47.1594907984888;
        Thu, 16 Jul 2020 06:59:44 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/30] iio: dummy: iio_simple_dummy: Add newline after function-end
Date:   Thu, 16 Jul 2020 14:59:08 +0100
Message-Id: <20200716135928.1456727-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following checkpatch.pl warning(s):

 CHECK: Please use a blank line after function/struct/union/enum declarations
 #46: FILE: drivers/iio/dummy/iio_simple_dummy.c:690:
  }
 +/*
 total: 0 errors, 0 warnings, 1 checks, 22 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dummy/iio_simple_dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index be66b26373723..cc4335963d0cf 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -687,6 +687,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
 
 	return 0;
 }
+
 /*
  * module_iio_sw_device_driver() -  device driver registration
  *
-- 
2.25.1

