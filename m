Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE5583F47
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jul 2022 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiG1Mwc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jul 2022 08:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiG1Mwb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2022 08:52:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A45422F2
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 05:52:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so2078171wrh.3
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nE5Wbbw3FCmHbdRkL3/U9XJ4GTjWt+9sof2h7I1P4Q0=;
        b=l3SFxh9+vhtVAq/aQ7loEmttBgZKNZDe/fbpd3JStBI87xFGV65Y9Ogw90e1ZdzIXD
         syKAmDMf+rLQEN0dhpDHlrkk0WPXZikMg8+Xr+af5nlDeZtQBWvk58VIANK6NMpt/gCi
         XlKS0UKp4b4YLIGBhbDBx4cR+aobSnd2BhaqChrAJh6lfttgwq+6vW0pwQm3DNiuv3b8
         HSuoEFk8W5KI8y/eWGM90sBGw7huPrbKEzy5plx9CSNkIgnuyyJHvm7UE65hAHi3kIvx
         gupjrTrXfJqz0rICbDGJQL3m2RL6lmjxjNDRgXsKJGIq38NgczyMzg1DjSJZNwashqek
         SVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nE5Wbbw3FCmHbdRkL3/U9XJ4GTjWt+9sof2h7I1P4Q0=;
        b=rKfxzUAHPTqpyiDgPaYLSWUTLwJ83fiE1W+zVlPml/84+Iz2neBBUZdU0X/C+FfXqd
         Vf2tQ7nA7LrsS2uglLLyLaEaAJ/WZ6lB4NdNFR1ytnMlURJd09bdjhWcSdhaO72bc8Ir
         piuNa8dIE9dFYirNUSQ4KwtHnQjzPg3X7wAiAO0/e3ew/APtdIyy5BJkycocvGR1S7tG
         xnMMdaH7I4qkydfIWFwKB0Qh7697Ws+SY32KxCaKVq9D5Iby6/JLML1GhPHkdGsibuvZ
         eN+hQE4WPQ03nSsghb2NPhhl1+A5gm7+ZgmqpaSkscYLCUG89Xuea4PJ7lkiLYW0CXDm
         7b8w==
X-Gm-Message-State: AJIora+JOZmIJ8sPmL0wx7VskHi6/SGQr/G9B252JpW+FjYTryYacifL
        Je/sCJD8DCyx9Jrq2hw50/Gwyg==
X-Google-Smtp-Source: AGRyM1vEfifki3JNH85cx8UL70SibB2O2tGlhwaerBu+gq6UHbZUL1P0wVkzth/lSS2Jzo6i9z7vrQ==
X-Received: by 2002:a05:6000:1f8d:b0:21e:83a6:cf87 with SMTP id bw13-20020a0560001f8d00b0021e83a6cf87mr13581521wrb.559.1659012746329;
        Thu, 28 Jul 2022 05:52:26 -0700 (PDT)
Received: from localhost.localdomain (33.169.185.81.rev.sfr.net. [81.185.169.33])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b0021eba590ad1sm977700wrw.90.2022.07.28.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 05:52:25 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v2 0/2] ECAP support on TI AM62x SoC
Date:   Thu, 28 Jul 2022 14:52:10 +0200
Message-Id: <20220728125212.76728-1-jpanis@baylibre.com>
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

Modifications since v1:
	- Fix yaml issues (id and example)
	- Use regmap instead of writel/readl
	- Enable/Disable clock explicitly
	- Simplify power management (suspend/resume)
	- Remove unnecessary using of ev_mode variable

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
  dt-binding: iio: time: add capture-tiecap.yaml
  iio: time: capture-tiecap: capture driver support for ECAP

 .../bindings/iio/time/capture-tiecap.yaml     |  68 +++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/time/Kconfig                      |  22 +
 drivers/iio/time/Makefile                     |   6 +
 drivers/iio/time/capture-tiecap.c             | 521 ++++++++++++++++++
 6 files changed, 619 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
 create mode 100644 drivers/iio/time/Kconfig
 create mode 100644 drivers/iio/time/Makefile
 create mode 100644 drivers/iio/time/capture-tiecap.c

-- 
2.25.1

