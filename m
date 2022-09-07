Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E65B049B
	for <lists+linux-iio@lfdr.de>; Wed,  7 Sep 2022 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiIGNDp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Sep 2022 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIGNDk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2022 09:03:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165AD74DEB
        for <linux-iio@vger.kernel.org>; Wed,  7 Sep 2022 06:03:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y3so30266325ejc.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Sep 2022 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=01WqW6OqBNhMmfAKnd2eWRm7YB0Rra4KiPfcMMDJhys=;
        b=jVbJi5BUHQNwajwJbogIhHhW5BoJou+46tUpfglhRre1AkqmIVssreIV3PXvqIJxIU
         e9QQMhq2HoySErlcrmKwZZR0Oquh15bD+eM3XJNu/Lqz0xYunEGuCumTzOsZZR8nS0F/
         f7CCrpupTgMiJ9qq3QarIVYbW2r1wQnIsJ/vyFn45IOkIbZLsV6Xmoi34HLWvUj5LUow
         IdSW0EmjYPuNGxoiohdNg3DJOrfcMmVH3CYqvOqJUnaWFdgyRYubHf3orUYyXXGGXH2h
         uXs8xUMt71qHUQJap7MNjDPogZM4Od9EfklR28wFJ6FD0pgWlobRNstgz7SoKVfrda1D
         Zfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=01WqW6OqBNhMmfAKnd2eWRm7YB0Rra4KiPfcMMDJhys=;
        b=5tt4ZrZkBjYXYzcqofKmKjz3pepGZBtMYVrrht2IczHPIvqDt/Q+QNdGV0Sv9n1gpv
         S/+wyYlpayBAfBQ1tHaxLn8nxrmUu8d5VWNrtuQ9TXcwyNzNGkLg1a/8pOqhyebSP7Xx
         9VZxvbVUBEq7YfnlnSOiF0nPNJSNB33k0yNcdkmLaKMqsFzpztXWagicDLkRJmf3/K9f
         ftxRjnRxJXxJwYZw/XS9dAOc/3jMcxA8Z826x/sexaawa0/pCOG+EyR+vQw0aMPoh+BR
         EkM2bjNOg9mhNIbnKy8iY71tYy+l1N/aTZ9L0ziXSViX76I3waBJb7iZw3il0T2lAKyM
         Q/PA==
X-Gm-Message-State: ACgBeo3bopScTDj5OETaHvrn+g3ynUp0ks9OZ989FtXdmh1dqvhhMDcl
        1fmfYI8uyJUfHc2D5vg9MoVq2g==
X-Google-Smtp-Source: AA6agR7A233chWPiAPMHPHvVHI/U14Hy6+aQKcvGKtg/NZqiQBK+1bPs6gGy/hDbXCWL78cNtsXcuA==
X-Received: by 2002:a17:906:cc50:b0:770:782d:486 with SMTP id mm16-20020a170906cc5000b00770782d0486mr2248821ejb.130.1662555813441;
        Wed, 07 Sep 2022 06:03:33 -0700 (PDT)
Received: from localhost.localdomain (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id r16-20020a50c010000000b00447bd64d4f6sm10785000edb.73.2022.09.07.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:03:32 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v6 2/3] Documentation: ABI: sysfs-bus-counter: add capture items
Date:   Wed,  7 Sep 2022 15:03:26 +0200
Message-Id: <20220907130327.139757-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907130327.139757-1-jpanis@baylibre.com>
References: <20220907130327.139757-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds capture items to counter ABI file
(e.g. TI ECAP used in capture operating mode).

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 45 +++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 06c2b3e27e0b..1e8f88f67a3f 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -203,6 +203,19 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		This attribute indicates the number of overflows since count Y start.
+
+What:		/sys/bus/counter/devices/counterX/countY/captureZ
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		This read-only attributes is a historical capture of the Count Y count data
+		where Z (if present) is the respective capture buffer element offset.
+
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
@@ -213,11 +226,15 @@ What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows_component_id
+What:		/sys/bus/counter/devices/counterX/countY/captureZ_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/polarityZ_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/frequency_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -345,3 +362,31 @@ Description:
 			via index_polarity. The index function (as enabled via
 			preset_enable) is performed synchronously with the
 			quadrature clock on the active level of the index input.
+
+What:		/sys/bus/counter/devices/counterX/signalY/polarityZ
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Select the signal Y edge polarity where Z (if present) is the
+		respective polarity sequence position. The following polarities
+		are available:
+
+		rising edge:
+			Low state transitions to high state.
+
+		falling edge:
+			High state transitions to low state.
+
+What:		/sys/bus/counter/devices/counterX/signalY/polarityZ_available
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Discrete set of available values for the respective polarity Z
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/signalY/frequency
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Read-only attribute that indicates the signal Y frequency, in Hz.
-- 
2.37.3

