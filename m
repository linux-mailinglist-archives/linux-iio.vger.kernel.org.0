Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1F5BBE73
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIROgz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiIROgq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 10:36:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E36F220F8
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 07:36:45 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w2so15457810qtv.9
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=tI4tD8RPl2oob7yS7B2rTMvy9BfpBPxt26bpNWOxmk+Jxjv5UZ5hKkeNKeA1JlCBmS
         RaWvy44lCyTBVEd4mqV0UPYBPkvY93OXsfhRtnJbrrRnWK3XXUPQjdWNELgZoLj4MNSY
         /U7qo6P3YmsZZM1upYOGWKrdVK4aNPsveS0vq6qocF/DN98h1Y/09NwK5fYr7I1kzLTC
         kb0LfPNejxd/oWertlmtVAVO54vSGSDgj9W89MhienXl9HJ54FGWA/LQ1obCBVAuuSyS
         dxbMCIQOtWxltwgc1CuHSy3irsOpWWMVVGtPoraVi8q777s5Z4oLo9JEKOIGrxjWMJn/
         idiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=5Ru6LwCmNOu5uVZbcxVFxUYjghmfpo2Q+0oCOmxcqEh29kINf7jeSYuN2ePzaQkXbp
         VlLrXUUYF9uqCODjE1NOKj4EBpJHT/KbIyTXCwOd21d+F+rhpw8DONdIpTo5RwheWLzw
         wOk+mxOR0FwX321Eo8ZJQOtDrvHRFJM0H/fzDRUNPhncxu0WaUgZ55BH6LmGMLP3rHuo
         qpF2wHH9DTgr6pa4KVwRltL3QAgUU6xnQIVWNrHO6PUKlC6ExfBi8oPhwJgK4USTfW75
         1TAZdEvhhvEVuvPo9hFAZIPOXaYXPi7vbMXR82LHeXwklS2FnRKDMo7M5cSTh7zGb60l
         BBfQ==
X-Gm-Message-State: ACrzQf1lG1AbUpJ17sNZBeKPGoNJkePwjpFp3ZGa+r/IDycj/RyGFFVw
        iXotQLgb1Nr6OifqH+Ygz8ezssn81D2n1w==
X-Google-Smtp-Source: AMsMyM5MBRfQkd6UUPXXffWdULTSWQ473xld1ESHt0BdfxXuh39fdB8/vqoCgjcWZN0WiAc1Vy/PeA==
X-Received: by 2002:ac8:7d0a:0:b0:35c:be89:fd65 with SMTP id g10-20020ac87d0a000000b0035cbe89fd65mr11847663qtb.99.1663511804373;
        Sun, 18 Sep 2022 07:36:44 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm11456215qkp.85.2022.09.18.07.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 07:36:44 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 2/4] counter: 104-quad-8: Add Signal polarity component
Date:   Sun, 18 Sep 2022 10:36:32 -0400
Message-Id: <574b16ebbf993abbe9bcf1833e2cf74098486258.1663511054.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663511054.git.william.gray@linaro.org>
References: <cover.1663511054.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 104-quad-8 driver provides support for Index signal polarity modes
via the "index_polarity" Signal component. This patch exposes the same
functionality through the more standard "polarity" Signal component.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1323edfbe40c..2a9d8259ed4b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -549,6 +549,32 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	return 0;
 }
 
+static int quad8_polarity_read(struct counter_device *counter,
+			       struct counter_signal *signal,
+			       enum counter_signal_polarity *polarity)
+{
+	int err;
+	u32 index_polarity;
+
+	err = quad8_index_polarity_get(counter, signal, &index_polarity);
+	if (err)
+		return err;
+
+	*polarity = (index_polarity) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
+		COUNTER_SIGNAL_POLARITY_NEGATIVE;
+
+	return 0;
+}
+
+static int quad8_polarity_write(struct counter_device *counter,
+				struct counter_signal *signal,
+				enum counter_signal_polarity polarity)
+{
+	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
+
+	return quad8_index_polarity_set(counter, signal, pol);
+}
+
 static const char *const quad8_synchronous_modes[] = {
 	"non-synchronous",
 	"synchronous"
@@ -977,6 +1003,13 @@ static struct counter_comp quad8_signal_ext[] = {
 			       quad8_signal_fck_prescaler_write)
 };
 
+static const enum counter_signal_polarity quad8_polarities[] = {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
+static DEFINE_COUNTER_AVAILABLE(quad8_polarity_available, quad8_polarities);
+
 static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_modes);
 static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_modes);
 
@@ -984,6 +1017,8 @@ static struct counter_comp quad8_index_ext[] = {
 	COUNTER_COMP_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
 				 quad8_index_polarity_set,
 				 quad8_index_pol_enum),
+	COUNTER_COMP_POLARITY(quad8_polarity_read, quad8_polarity_write,
+			      quad8_polarity_available),
 	COUNTER_COMP_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_get,
 				 quad8_synchronous_mode_set,
 				 quad8_synch_mode_enum),
-- 
2.37.3

