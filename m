Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5D45E7CD6
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiIWOYq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Sep 2022 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiIWOYn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2022 10:24:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB4192AB
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 07:24:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t7so220762wrm.10
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uvXNmgxQugKAaPoHg/fy7Oj8V6F9lJwQQFf+Kpi7X0k=;
        b=lfDiDKmKIVsmlhM8Ttm8J2QxpmSVKKBuJNEz8jRmLyNggJwsQSG8Dooy6GtJ6NYjDN
         ljcyjg/c46ZFYGQGbUW2DLZ4NIz4GZUKjo8J6ffUW8excUGWmsO5iVAvgqKLtAqGld4J
         qm8FPJzdRFfdDeTJe1ZQ/SJ0i5IWLdInOzxlvk4T/dyxNNZ+4IBf4chlgCaY9tkdSMBY
         u30BxLd+47JdI5Qt5imUJa6SNVpyus3qgeFWXk8PDC30JKvKL4AtMCOvCoTziDkVZ9kz
         XFJb9tXIdU/zdG+q5q7eWBbAIk0yuxIFl1/NtY+v+YUWYWsTTtR6lkqHFUVT6VGR2S/6
         /cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uvXNmgxQugKAaPoHg/fy7Oj8V6F9lJwQQFf+Kpi7X0k=;
        b=OFZ86t19ZuS9VN0Hkl7ofcSbtOqV6Ww9chOWH0tPcLHQUZXgwVmzhxggqpkWZsYAlQ
         R0MVBjER8xe4t+iTImsAT0YupnyUZ6lttHPpB4VeixNO6hM5cNB/0SvMEQGXLsBYA9vH
         FUjp2AWgD0ND/Rn8i9IyZbFc03/HlPhouquesx3gR/xmN9ySa0vQi9tyuSo8bhZeSWUW
         p0LdHYu/M5+DnXbUYcG9uUqcOc84leeUE4qHSp1xKW7+3SrQtGQkD6jz1bhKDzpxhVE8
         IfSI3Lu5whOZ/no7/XZZT3wiLIw77CHOZoJ8+FtNdqwQg+kIN2LVYiFDWbDOng2rITxh
         goBQ==
X-Gm-Message-State: ACrzQf0F2CAOgFUj9UEXa2Hyd8mjXBuf+IKSKANXd9cone+Tv1qZjNCZ
        pduExKp9WbU0IPUumE0oakcsRQ==
X-Google-Smtp-Source: AMsMyM63P8cmfnFpvAQgjydHupELO9Ure/jEkpXhGm80BMNZ3/s33pvMNL7Hg6lnVVicyvMqbw+KdQ==
X-Received: by 2002:a05:6000:184:b0:22a:cb6f:bb52 with SMTP id p4-20020a056000018400b0022acb6fbb52mr5287755wrx.500.1663943078767;
        Fri, 23 Sep 2022 07:24:38 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0022878c0cc5esm7444627wrw.69.2022.09.23.07.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:24:38 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v9 0/4] ECAP support on TI AM62x SoC
Date:   Fri, 23 Sep 2022 16:24:33 +0200
Message-Id: <20220923142437.271328-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
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
edge) can be selected.

This driver leverages counter subsystem to :
- select edge polarity for all 4 capture events (event mode)
- log timestamps for each capture event
Event polarity, and CAP0/1/2/3 timestamps give all the information
about the input pulse train. Further information can easily be computed :
period and/or duty cycle if frequency is constant, elapsed time between
pulses, etc...

This patchset must be applied on top of the following counter subsystem patchset :
https://lore.kernel.org/all/cover.1663693757.git.william.gray@linaro.org/

Modifications since v8 :
	- Add documentation to private driver structure
	- Add mutex to prevent IO race conditions
	- Stop counter before disabling interrupts in ecap_cnt_capture_disable() function
	- Remove returning of status in ecap_cnt_count_get/set_val() functions
	- Remove unnecessary 'return -EBUSY' in all callbacks
	- Remove unnecessary '.id = 0' in ecap_cnt_counts[]
	- Modify driver info in MAINTAINER file

Userspace commands :
	### CLOCK SIGNAL ###
	cd /sys/bus/counter/devices/counter0/signal0

	# Get frequency
	cat frequency

	### INPUT SIGNAL ###
	cd /sys/bus/counter/devices/counter0/signal1

	# Get polarity for each capture event
	cat polarity0
	cat polarity1
	cat polarity2
	cat polarity3

	# Set polarity for each capture event
	echo positive > polarity0
	echo negative > polarity1
	echo positive > polarity2
	echo negative > polarity3

	### COUNT ###
	cd /sys/bus/counter/devices/counter0/count0

	# Get ceiling (counter max value)
	cat ceiling

	# Reset number of overflows & current timebase counter value
	echo 0 > num_overflows
	echo 0 > count

	# Run ECAP
	echo 1 > enable

	# Get number of overflows & current timebase counter value
	cat num_overflows
	cat count

	# Get captured timestamps
	cat capture0
	cat capture1
	cat capture2
	cat capture3

	# Note that counter watches can also be used to get
	# data from userspace application
	# -> see tools/counter/counter_example.c

	# Pause ECAP
	echo 0 > enable

Julien Panis (4):
  dt-bindings: counter: add ti,am62-ecap-capture.yaml
  Documentation: ABI: sysfs-bus-counter: add frequency & num_overflows
    items
  counter: ti-ecap-capture: capture driver support for ECAP
  MAINTAINERS: add TI ECAP driver info

 Documentation/ABI/testing/sysfs-bus-counter   |  14 +
 .../counter/ti,am62-ecap-capture.yaml         |  61 ++
 MAINTAINERS                                   |   9 +
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-ecap-capture.c             | 614 ++++++++++++++++++
 6 files changed, 714 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/counter/ti-ecap-capture.c

-- 
2.37.3

