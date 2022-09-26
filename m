Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D85EADEB
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIZRRK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiIZRQ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 13:16:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A99F8EF
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 09:30:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x18so4432117qkn.6
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=Kdp/uoGK85fu6tyAZORbR83uMplOEXpivdA4PlcKM2vAMe1HBJrTBjQcEAYSmFirxY
         cBD/UAb2YSQh2itUDdQjIT64Q66GO8YjsJ86WB3+3cJKQH7b3Slm/qqnaTMzdhNgz6rM
         pkFpOZlpEowzWgRQ2/OMGI6dZeGVUeWzAKdf7Ghvnt98XglvTNMIjWn12prg/zmoC3Dg
         Qth82yewYn0RIdErtFZ+9MTzK/c+Kuk1qeW26nwqAks7I3v9ED9ABT1U9oxb+zevgiS8
         /J/7Le2uhn6AB4rJkkgQcs6JdlRAWki6j6Q4pMCNgF7jHqACGQ7dvK/uzXR0hBo8JOty
         /N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=Vit1OqeI/5yuyF2rCQ9nFxAT0Ha6FPTE4cL732ZrNAjlQ6U7RhfYxBTjWNOb0XbgZS
         wEj8lrNf25tzQlaKtnLfCh7gDuXlcq7rRbVFkeHhQNCMbA6KnQwb3p2ZTRWl3ovqTZ9Z
         TnFFY1PbiFMSOn7tfc4IM3vQV8vCDeytGDCN4Wb0qI/PcVDVe/VpmG5M9RFzQ8oXUZBi
         tcOfxEhNN7vu2RcrZMa15Hf/1h8FdsjeAC6yI7rLqYm93Q+ZB+H0k+un5qQ1jM05ceiW
         duAV/OlG6QYXctbkZMN4WNhoXzQe6ZD4nTIeCUndBDkH/gERVIMs6xlmcmW/UB20XjYY
         RR0A==
X-Gm-Message-State: ACrzQf2e1y1Xo0Vt1mFMHUKQVt7f8IvYmw4qAkhugZYnhdLAaDC3Os0Q
        q7ZXUDHMlhf3K+HiMYaCTwhP33E8KbjZKw==
X-Google-Smtp-Source: AMsMyM4WWWpTa1NyaV/TwmTsBOeWt448hcD9kbzwgcv3dtDpgXl36AaRVDMlJzT2UH/FEyOG4DYcNw==
X-Received: by 2002:a05:620a:1b81:b0:6ce:b222:a46e with SMTP id dv1-20020a05620a1b8100b006ceb222a46emr14705885qkb.126.1664209814959;
        Mon, 26 Sep 2022 09:30:14 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 139-20020a370a91000000b006ce60296f97sm11542146qkk.68.2022.09.26.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:30:14 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v6 2/5] counter: 104-quad-8: Add Signal polarity component
Date:   Mon, 26 Sep 2022 11:16:35 -0400
Message-Id: <01d00c21873159833035cb6775d0d0e8ad55f2ef.1664204990.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664204990.git.william.gray@linaro.org>
References: <cover.1664204990.git.william.gray@linaro.org>
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

