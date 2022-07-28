Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E52584544
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jul 2022 20:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiG1Rvm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jul 2022 13:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiG1Rvj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2022 13:51:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C274CDC
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 10:51:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so1448040wmj.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRglWFr4DTWj8W0OlEgwT2U+TB7+T+ug/9NREhYgClQ=;
        b=2a8KnT+wEv/LQYe1L9vxUSd6YePQZGg78VnMEwFZPOOwMIm05BJMJTv+a5E0pLMzUT
         FfX68p2a9++nXOP6D3JrKBeFsgr8M3KnrTsbp41ycnoLEVeQy0G5O3+VwEzE8UjDxf8j
         4UESLOOiKh9SRnwhPWKO0+lnUR0NRynHbYQO2fknvBm2H/86AtAJOYrguLqn9TYHWnJq
         NrYo0rXe2cfiCaZqpFLnuWIWWGcih4c7w/0n1D6IMBzpuMQo/x295e+uI0doasO6KqQR
         Zjk68J9aAy4ZliKhIR4gSZ5vNAdkpJGmg+AJ5L33wQwqCKk3LdnKJmtZZlEyeYapt4i9
         R9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DRglWFr4DTWj8W0OlEgwT2U+TB7+T+ug/9NREhYgClQ=;
        b=haP0sGoL5xnV3HED35iwPXbC9sS4fotzp9IgHM7m+iceZ9nwLdYEJVRZJj/9NIDoqB
         cnoZ4vFWeCgu3bzG9ei/bH6AV1wkwGh8fZHhUHXwcwsfrYePUp3V3SMXm2r6ufgnQDNA
         3agb+7aaWlU+Ekseiw2uzsvs0dP0jZ/BHzgR9nGxZOPc78Wd/Lc47vJMCX/ualakKvcm
         ld52vOdBfYrhQE2gnxBsEZUc9TNl9NN8SD86sXoZSyJkLFpUK/L46ki2ZylqqR9aAdMx
         pj54JEvt5R2SpoOkXmaWZGXwVmMFyFBpyIdhwnO0Fcd/qpFzDg6udSA470ww144+XdRb
         vX4g==
X-Gm-Message-State: AJIora+2sIFszHv0RE/K9tnjzC2rRHGDSPWgGJ2SqbeGFGUMcOcxBMoI
        J3t+n0WzLzdobOfqa8Hpyv5fGg==
X-Google-Smtp-Source: AGRyM1tuM+lYq5TgHTKJ5iYFPZRPwmXdTjOFOxn1iT6jEyOBu1VwJ1R9H7NC6R9lj+2puxxsmD/t7g==
X-Received: by 2002:a05:600c:240a:b0:3a3:5452:4262 with SMTP id 10-20020a05600c240a00b003a354524262mr25238wmp.86.1659030693374;
        Thu, 28 Jul 2022 10:51:33 -0700 (PDT)
Received: from localhost.localdomain (33.169.185.81.rev.sfr.net. [81.185.169.33])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003a3442f1229sm8274027wmq.29.2022.07.28.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:51:32 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v3 0/2] ECAP support on TI AM62x SoC
Date:   Thu, 28 Jul 2022 19:51:22 +0200
Message-Id: <20220728175124.468461-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Modifications since v2:
	- Fix yaml file name
	- Remove unnecessary node in yaml 'examples' section
	- Remove unnecessary error messages in probe function

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
  dt-binding: iio: time: add ti,am62-ecap-capture.yaml
  iio: time: capture-tiecap: capture driver support for ECAP

 .../iio/time/ti,am62-ecap-capture.yaml        |  61 +++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/time/Kconfig                      |  22 +
 drivers/iio/time/Makefile                     |   6 +
 drivers/iio/time/capture-tiecap.c             | 517 ++++++++++++++++++
 6 files changed, 608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/time/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/iio/time/Kconfig
 create mode 100644 drivers/iio/time/Makefile
 create mode 100644 drivers/iio/time/capture-tiecap.c

-- 
2.25.1

