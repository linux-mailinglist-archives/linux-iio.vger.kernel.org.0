Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65B580DA6
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jul 2022 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiGZHaZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jul 2022 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiGZH3E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2022 03:29:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB42B25B
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2022 00:26:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b6so8165180wmq.5
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2022 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21tro8NgQMF0BbQUJgmRVJe8ax8ac1ERKEmdP9EvkKQ=;
        b=ylwiRXDG+MXgpkQ+8qvtIy/jVkvcV26Aind4vPzrRQKOJsIqUfD91k7A/5VnUY1YTH
         Srt/ksBKFWb7bRM9Lk027hyLmXlVfVwDJSs1lhsIS+4eiKbG/VL5hlF8uu4ygOxumF/V
         vfZzT3YRqWFdPi2ruRCpKqAMzQIIspGmfFP78yfVGjnW6htOExG91PY+BHdIG3bQuyP6
         iBo5emAzGf8UJx1jmi4bgT+QdqsM/IW4z4jYMYPs/pnWhOOhkyXO6Ykb5gRyd3Y8uiNi
         /nQ0WmMr8qdtX9dzOL34p3SsLg5tRtzNm5ray2j3uQAzSeTsX7ry3xAi/kGsZsp0LshI
         eJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21tro8NgQMF0BbQUJgmRVJe8ax8ac1ERKEmdP9EvkKQ=;
        b=A/MHKyONJ/bD2mFueZj4k0JyGyfa9hcofhTQipxJEQtWVxvqr8NXJWN54UtKgqHdl7
         vUfjJwsHqcHDNeNiOJsgD/MRDPobXKesx2E+Kjglzm4JHhE2U7uCtAknV/s2Da6T9SX0
         I2ZOqwA7Xj2SFPi+5BCumuUiOAJWGYqArtrHixLr9bI/0XNStCDDHY1DJ/HesPF/Ig5R
         w0IhtXloXPe67bSihEEg2+/83wjN44zfC9WesyBQP+N4f+/z8gUW1oOemoqIPO5/07Dp
         PYnsgYM/AcigfQPDV+pb/o0u9CJel9Ra/5HymsrLSCrN9RHD/2yJeyCSviK8o2L6jviP
         jRdA==
X-Gm-Message-State: AJIora+PA8lHFEoWQWpF1s/jtJpRhsFNI+XHtED6cfgFXfcEyCUpBezr
        ZkfWJhx+cqPCUVDYaMyjuwcphQ==
X-Google-Smtp-Source: AGRyM1sHh5qAWVhfvM7wnsq0GmqaOJu07OuZf96mZZYu1OHSKoTlkATutMus4ZnRsSFeu21FHSt/0A==
X-Received: by 2002:a05:600c:a4c:b0:39c:6517:1136 with SMTP id c12-20020a05600c0a4c00b0039c65171136mr11181329wmq.12.1658820368647;
        Tue, 26 Jul 2022 00:26:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:77d:8cd7:621a:855b:69ac:c34a])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b0021b956da1dcsm9007835wrv.113.2022.07.26.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 00:26:07 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v1 0/2] ECAP support on TI AM62x SoC
Date:   Tue, 26 Jul 2022 09:25:51 +0200
Message-Id: <20220726072553.5136-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
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

The Enhanced Capture (ECAP) module can be used to timestamp events
detected on signal input pin. It can be used for time measurements
of pulse train signals.

ECAP module includes 4 timestamp capture registers. For all 4 sequenced
timestamp capture events (0->1->2->3->0->...), edge polarity (falling/rising
edge) can be selected. Moreover, input signal can be prescaled.

This driver leverages IIO subsystem to :
- select edge polarity for all 4 capture events (event mode)
- log both event index and timestamp for each capture event
Event polarity, event indexes, and timestamps give all the information
about the input pulse train. Further information can easily be computed :
period and/or duty cycle if frequency is constant, elapsed time between
pulses, etc...

Userspace commands :
	cd /sys/devices/platform/bus@f0000/23120000.capture/iio\:device2/

	# Configure/Enable data buffers
	echo 1 > scan_elements/in_index_en
	echo 1 > scan_elements/in_timestamp_en
	echo 100 > buffer/length
	echo 1 > buffer/enable

	# Set event mode in range [0 ; 15]
	# One bit for each CAPx register : 1 = falling edge / 0 = rising edge
	# e.g. mode = 13 = 0xd = 0b1101
	# -> falling edge for CAP1-3-4 / rising edge for CAP2
	echo 13 > events/change_falling_value

	# Run ECAP
	echo 1 > en

	# Get the number of available data
	cat buffer/data_available

	# Read data
	hexdump -v /dev/iio\:device2

	# Stop ECAP
	echo 0 > en

Julien Panis (2):
  iio: time: capture-tiecap: capture driver support for ECAP
  dt-binding: iio: time: add capture-tiecap.yaml

 .../bindings/iio/time/capture-tiecap.yaml     |  53 ++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/time/Kconfig                      |  22 +
 drivers/iio/time/Makefile                     |   6 +
 drivers/iio/time/capture-tiecap.c             | 532 ++++++++++++++++++
 6 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
 create mode 100644 drivers/iio/time/Kconfig
 create mode 100644 drivers/iio/time/Makefile
 create mode 100644 drivers/iio/time/capture-tiecap.c

-- 
2.25.1

