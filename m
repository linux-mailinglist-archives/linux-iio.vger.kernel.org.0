Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244895ED07C
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiI0WyT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiI0WyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:15 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C5D2D7B
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:14 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1318106fe2cso4056165fac.13
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=T28xl67JTcqzGa+zRCl34epQWllKYimbVGVDsx/ZVLY=;
        b=KOXOpIy2oQHrS08NBXl/Za99dtDOBx5CYz3RPm86J9fHly0eNgX9TzLwvTKFmbq2mk
         +BHhm29UdQVk2kWqyBXCIZqUqmx77BYv6203ceIAu/9ILD1Gg46rIvz74gZtnBD9pzQL
         H/UJ1JSwmXfEt+d1zJBCs7DFBvwqeJOWIR0qQ8mCZVzJHO3kIlabBzbU7bjsyl2PYH8G
         db7Cghv3kMrzKnaFqJKFR70ZftYPIBs1alYXoheZ8TJBCqIpyP3lvhvyXrvU6f22Bop/
         yLVB3VBMYMUNtpIKCsY91sZLd340FxxIzHwydmYUx7qpq/7qH/nXkTLlRIWR0YQ4spuc
         zT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T28xl67JTcqzGa+zRCl34epQWllKYimbVGVDsx/ZVLY=;
        b=4VqMwQIcLZ2ssiiij4bhQQskQMvuKdNWV8OtUM//Tyd/0uKYYj7BULHg4eUnSk8487
         1gYgeJCsmtSEfodKt2tLkVdhoks+KtD1UVHGxJ15edccoB88lW+AiWXYzuAii7doKPRx
         3tpJfxoXGiLE549mYJu7IZnPMalbMmEp1jIzI8aEWs/yCC5FQld7F5PIvDX2M9HauyAC
         L9OKcyGlqA1wO9XgfxFILknWfbvtV5LZeKckaSN6R0os3pUYrBiRAopQKJChBXXRj7Hd
         uzIlL4k0Ixsh59Nn18ucgS9VyWG3JOnDwWKe+SrJl4xlnxFHbpMKEiqro1M8P60cKREZ
         7OrA==
X-Gm-Message-State: ACrzQf1g+sb270STNvvbBWgNV6b2h3sRq5SHHMqsaOgmYkt+uhvzPVYU
        xbMF/PFQxjGS5pKmhWHnsEodogX9VrhRc+KK
X-Google-Smtp-Source: AMsMyM7WQTeaSTMTJkG54/z5mo6taS/5EQLRq8heCO4qVWz0jRYWcbDel8ADJ8pocWjY60W/3AJAIA==
X-Received: by 2002:a05:6870:82ac:b0:131:9468:b9b6 with SMTP id q44-20020a05687082ac00b001319468b9b6mr1805644oae.240.1664319254330;
        Tue, 27 Sep 2022 15:54:14 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:14 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 10/12] Documentation: ABI: sysfs-bus-counter: add frequency & num_overflows items
Date:   Tue, 27 Sep 2022 18:53:44 -0400
Message-Id: <467ae80e97c586c6bc9c453c6156ffcb5d4853d6.1664318353.git.william.gray@linaro.org>
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

From: Julien Panis <jpanis@baylibre.com>

This commit adds frequency and num_overflows items to counter ABI file
(e.g. for TI ECAP hardware used in capture operating mode).

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Link: https://lore.kernel.org/r/20220923142437.271328-3-jpanis@baylibre.com/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 3eb6b063970a..ff83320b4255 100644
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
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
@@ -220,12 +226,14 @@ What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/frequency_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -366,3 +374,9 @@ Description:
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

