Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D55ED075
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiI0WyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiI0WyK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:10 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397B9D33E6
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127dca21a7dso15173568fac.12
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CASul9xD5hbR16hfyabPe4DssXGCvdhANQEzN1uO2aU=;
        b=lLC0mISCXqkmcF2cq00mcBUcVLE3is7bnBMh6HG5uDGz9PKT2E+e6p14KLL5npZXWE
         Uu9Gteo1jaIwu0yAO5yollSG5pvGhFWOxnDZqFyVl45sAltIh1nzKXv7k3QmXkI+Ls6D
         LcxiO13rdyYG5iOEZ08j8BUWS9NhFHcNa1uO5RHPqAivr1kqumYx+QP1KL1812Wc3iF7
         vJpvzD9Rjh9I/pKpPhl4Qu9Jyhoy/9VvCRXF0S/P2vfMOhxaRxUbBQA4cb8H9MAGxQAP
         3yT6fMhoQStH0bA+mGrXQi6NBzI3mHqtouZPST9t+S3H7WcWfJNRGCRAIYRi1G/zOVZh
         XYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CASul9xD5hbR16hfyabPe4DssXGCvdhANQEzN1uO2aU=;
        b=MrW1PFioYJFCMtwJKXT+pi/rcBSMKgSzvcRwu+GkO7TjoaGc5LUCPu0NDj3TiyjooE
         BlfBTXN5qaMjGCxU9E61A78O3jSbtxOcFhycp/ov6NbIRSCj+vxCbV4TpE0C0yGsUsRT
         FgvByvwc9cLQDfPedFIOWCeR+uxZm3A2d3oXV/c5J6fBu2aqyC9Sw3QB+Agnn+pUgl2D
         GYt1XEQ6M5hBNDGdEAYYnhCgR6kX7fDuaK/V/BWqsqLmFf9fywaGRIqQM0TEChnjNjvE
         Y3CjYncuJMN4vOjuQpgefH3LTHHXKRCrC4nPBc53hAToE/7F4HK4BNn9y/VytqWupYmj
         Mwgg==
X-Gm-Message-State: ACrzQf0r7l/Kut02ShCYSbCa2VHwbfp4Nd/p/FX7sY7c7CXhSM1UqcQg
        CM/f0vqzV0ZyAT0PRdaTXMFt/w==
X-Google-Smtp-Source: AMsMyM5PfY0Qpv11R+4yzxhnqq9pMVxuPT73uJ8j0dgfS3QWO9kv+1MrP4qzrncv66RyTVgN3z69dQ==
X-Received: by 2002:a05:6870:ecab:b0:131:8c96:a1e with SMTP id eo43-20020a056870ecab00b001318c960a1emr2485114oab.122.1664319248511;
        Tue, 27 Sep 2022 15:54:08 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:08 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 03/12] counter: interrupt-cnt: Implement watch_validate callback
Date:   Tue, 27 Sep 2022 18:53:37 -0400
Message-Id: <c50b5eede7d3f523de8dc3937dc44680f2773e1d.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interrupt-cnt counter driver only pushes one type of event on only
one channel: COUNTER_EVENT_CHANGE_OF_STATE on channel 0. The
interrupt_cnt_watch_validate() watch_valid callback is implemented to
ensure watch configurations are valid for this driver.

Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Link: https://lore.kernel.org/r/20220815225058.144203-1-william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/interrupt-cnt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 5a11b65fc0e5..229473855c5b 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -139,12 +139,23 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
 	return 0;
 }
 
+static int interrupt_cnt_watch_validate(struct counter_device *counter,
+					const struct counter_watch *watch)
+{
+	if (watch->channel != 0 ||
+	    watch->event != COUNTER_EVENT_CHANGE_OF_STATE)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct counter_ops interrupt_cnt_ops = {
 	.action_read = interrupt_cnt_action_read,
 	.count_read = interrupt_cnt_read,
 	.count_write = interrupt_cnt_write,
 	.function_read = interrupt_cnt_function_read,
 	.signal_read  = interrupt_cnt_signal_read,
+	.watch_validate  = interrupt_cnt_watch_validate,
 };
 
 static int interrupt_cnt_probe(struct platform_device *pdev)
-- 
2.37.3

