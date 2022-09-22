Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F232B5E691E
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 19:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIVREQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiIVREL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 13:04:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6CFB317
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 10:04:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay36so7233173wmb.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aZ9inPx/SpVp/+EGUIHCzXQtKEo6kGOnnJXHLc8UgwM=;
        b=qoNSKQMejX00EtTaTz0JNlc0S+M1KbIjAJ0TSBb5XkNtZ+0wU2Nu3/Y7+2cBJMRmrA
         8v4nhvIjM4eQV4QPuE3cuArfYi/OUff+q7GHHLd37yhF8J9wJaHQyZPuQkzI24dCi5Bf
         PdxQj+ki8kGvMPwaobfraCZrSCDHGjgmSCskmrn/nnC+2maPkdsJwE9yLhW8hHI5burL
         xP4grPNFx7zAW/McwSAeQGAbRTcNwrP4DY4/pPEVX/cDXTvaJrKV1DOo4WmxkRzg98qO
         4r/9t5ipFD4Bm4yBaclIR2rRmYON44bJhC8A1+rBNVbXBCNGAJlplfEpRB1bC+iHg8QF
         rPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aZ9inPx/SpVp/+EGUIHCzXQtKEo6kGOnnJXHLc8UgwM=;
        b=GTfl0ylUaB8jY/TwCb87jjFG7E8JhP2jF9GfJq+E4VUiCh4y2Xu9BfX5MRyXkeD+B4
         qiZj+xlYjuWZKBwn7oEomG3s2BfgGj4NGzKcOJsT1cy40P3P4fUXbxHFYs2oO4u2Pj0S
         0086BRuqhYAk0Lg6ByvzJIUQ8EhxrZLg3tar4npySRcjDUpZLduFA5Q6e2KTDIJnDXmO
         AqhOUEHZ3oZ4pjkj7VvnRDBNJ/PL1FqqLoPUdvglYZVER6LEsTAYq79BUYea6VozdAad
         vsS+ONdUV472OMmK4nLdaA9/Rfak4lj034HgbDZyQNp75Bv+kdXFP0vC1DhkwpfGRrne
         9uIQ==
X-Gm-Message-State: ACrzQf0r+Lnezrnt9nx5A2Uke3OfzA7YRzVzYuRt0a2f9tAS+BO+ANEl
        s80m2HlDjBhBg2ji7cAdJ4i03A==
X-Google-Smtp-Source: AMsMyM4Z+RZJw5g2dvKC/JXo0Pp2/JiTnLr5XTIjBhyqBu9eEZKsrPFc0ztHabMZj98mru6u4v0EVw==
X-Received: by 2002:a05:600c:2949:b0:3b4:85b2:c1d7 with SMTP id n9-20020a05600c294900b003b485b2c1d7mr10111807wmd.183.1663866246979;
        Thu, 22 Sep 2022 10:04:06 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003a604a29a34sm20334wmc.35.2022.09.22.10.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:04:06 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v8 2/4] Documentation: ABI: sysfs-bus-counter: add frequency & num_overflows items
Date:   Thu, 22 Sep 2022 19:04:00 +0200
Message-Id: <20220922170402.403683-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922170402.403683-1-jpanis@baylibre.com>
References: <20220922170402.403683-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds frequency and num_overflows items to counter ABI file
(e.g. for TI ECAP hardware used in capture operating mode).

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 30b6e1faa6f6..e177c6128236 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -209,6 +209,12 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute indicates the number of overflows of count Y.
+
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
@@ -219,11 +225,13 @@ What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/frequency_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -364,3 +372,9 @@ Description:
 			via index_polarity. The index function (as enabled via
 			preset_enable) is performed synchronously with the
 			quadrature clock on the active level of the index input.
+
+What:		/sys/bus/counter/devices/counterX/signalY/frequency
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the signal Y frequency, in Hz.
-- 
2.37.3

