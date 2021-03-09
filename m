Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCC6332F20
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhCIThK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhCITgi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:38 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CACC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q204so10023086pfq.10
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q27ui3vtggJS6aa7+pXF2RghV/xtCrXY028DX4cNH6I=;
        b=K0yJpdViYizwuPlJazXdSBSsLeuUQhm6XOY8EZAaryDGCd0/J7BQt1HbiOTVd8q9ew
         3whnXl6ZfLFcNt7wklHSIiXMkSw53bqJ2VFpZ9BfgQEkPmvJ7WvoRECXkr5tMs7Ht8tk
         zahV6YDXpxd8/dUJHrTtNYVTKwetuD5gd2q+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q27ui3vtggJS6aa7+pXF2RghV/xtCrXY028DX4cNH6I=;
        b=Bx2S34Zwjfb7ai6TW643dWNwXjm3dASqMWeuFuL+40ER0Nz8DM/x321FSgPn0nIU6d
         S6VDFa3yMNOWmEDyZEQz4tfsNed58HR8W44Q1rnZe+9+M39x28S7jdm/yrNFCONXYYxZ
         D39uKMK9txDo/RmAXQhNOFltM2wQ1F/oJlNinayPTQ6xGlMulUtUEMw8JeMjDIc1exN5
         kX+23cqQCY5pxISOUO18x358zckk04eWFmGiGa35tGj5hKo4GONirMTtycijp1y7brNm
         3+ME31z+YH7DuJGj5W+lWYx+lNBxiu+dlawrsLDaHcb6jaw3tv8MzXHw2wdLDTbJSGRG
         e1Ig==
X-Gm-Message-State: AOAM530kPyCx0dc7t7PwhHlXfPT24CZBTFhOuMu9Z/0EKRp4Mbrvd1BZ
        U1YG5MkSalEVGnhsx0jVJQiV/g==
X-Google-Smtp-Source: ABdhPJw93xyTCySxr8eTECy0HYLb9s/5361nSQuIqYbV8SzsVq1isYW3zHVkaCPAfvP5vJanb33lXw==
X-Received: by 2002:a63:410:: with SMTP id 16mr9853665pge.220.1615318597823;
        Tue, 09 Mar 2021 11:36:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id i7sm3674816pjs.1.2021.03.09.11.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:37 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 8/8] iio: xilinx-xadc: Remove code to set trigger parent
Date:   Tue,  9 Mar 2021 11:36:20 -0800
Message-Id: <20210309193620.2176163-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309193620.2176163-1-gwendal@chromium.org>
References: <20210309193620.2176163-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

iio_trigger_set_drvdata() sets the trigger device parent to first
argument of viio_trigger_alloc(), no need to do it again in the driver
code.

In xadc_alloc_trigger, given dev is indio_dev->dev.parent, and we call
devm_iio_trigger_alloc wit dev as argument,  we do not have to set
data->trig->dev.parent to indio_dev->dev.parent anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
Improve commit message.

No changes in v3.

 drivers/iio/adc/xilinx-xadc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 34800dccbf698..6914c1900ed0b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -747,7 +747,6 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
 	if (trig == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	trig->dev.parent = indio_dev->dev.parent;
 	trig->ops = &xadc_trigger_ops;
 	iio_trigger_set_drvdata(trig, iio_priv(indio_dev));
 
-- 
2.30.1.766.gb4fecdf3b7-goog

