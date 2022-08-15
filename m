Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B64595243
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 07:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiHPF6O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 01:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiHPF6A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 01:58:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF529D664
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 16:16:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s11so7008100qtx.6
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2NHSu+WR71bWEHouMtYEYWTZ2k/kphqS/Xaa0m4gsqo=;
        b=RdxioX6rfZpldJqhwhtPJeZPySZfy2kj3BdriChWQwfUY6NXW7Q1VLICRE9Zqweb+r
         gwrzBdCRX9ofe59/sA+Er7wcZ8SfrC0yQr0qZB22kyXtTztAb7qfOQwR0BTKByvh2Xrk
         joGRbfm86wLLmTtUU7TYwtAh69+AuDDC0o0eBUeR6TMH8wLqlg1V+dx3+aoGzIgRzlM3
         4vd6VJyB8xZYordFoEIVcdJqW/Kx15ZctZTc3e9XPPcF4WE29vwD5iiFCcDa4M2e8ZRw
         6+zq8dzDFJ3sjxrvzA3MdARDyvfTOgJk+l9X0HGfcVt/BOEO685/Yfth3PuOYL0AbJbb
         Ebiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2NHSu+WR71bWEHouMtYEYWTZ2k/kphqS/Xaa0m4gsqo=;
        b=JJv8cScjASxYolZs2632BTzgDVZ5MPKtQV/Dx4/No751YpKf/6KU4XMDbk2Ep2Zgcs
         XfQeOjuCjRL7NyllvU8YMqyWjInJGjohrC94x6J6BWeBRzHaNO31j6yeDZejiCEMCGhn
         DIgaBzv9k3Sn4f7olL0406/JPNaRJoopn8YEmJFZvVaZNmER5oa+S67pvFLAMenRLAQC
         k3uqImg7HuBx1C0kGGGqTAY9MUr0LJ7KX48h2YQl/83yoSWfUZ2vWTxAhhur9tdiTqaj
         +4AH5Y1CjNhyglb/ui+EhVruc+B7dd5o5lsHC3erpl9op7K03cPgSbpYG0zrr0jxdd0Y
         LTzA==
X-Gm-Message-State: ACgBeo00BZ67Cz7zmHKpUQDuO29GPHuTcMPsmN0w8mEWHlf5+mzAkEXv
        Kf1/iASAzMtdIhCrAdUkH4Ae2A==
X-Google-Smtp-Source: AA6agR5IQPzo2LnMl+iKR8S7dBMSEVPE5W7Xd5TxJPOPIUXUs6m6Q/yoaSd/tKdtwwHfQLCUx6+Wtw==
X-Received: by 2002:ac8:7fc5:0:b0:343:681d:c3fb with SMTP id b5-20020ac87fc5000000b00343681dc3fbmr16179373qtk.157.1660605392431;
        Mon, 15 Aug 2022 16:16:32 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a430b00b006b99b78751csm10441188qko.112.2022.08.15.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:16:31 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux@rempel-privat.de, kernel@pengutronix.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] counter: interrupt-cnt: Implement watch_validate callback
Date:   Mon, 15 Aug 2022 18:50:58 -0400
Message-Id: <20220815225058.144203-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/interrupt-cnt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 3b13f56bbb11..05a5d3e2d2b0 100644
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

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2

