Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AF5E691B
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiIVREN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 13:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiIVREJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 13:04:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDEFF3C7
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 10:04:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n10so16497610wrw.12
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=22ItKu+Yc+EPpBvR747hieSTvpkCAZsO+AFU8nOrmZ0=;
        b=6D5gjpcOndcRJymquXw3oG1F9ugMijMBLN480S9xmCAqo75Ereh9Hxiu7O3sQRl805
         Ei4/PLyf/aJ1Oz1eIVYz3jhxm+Oq6zW74FANTipGNniX3+gEunZ3ZK7vdqrOl/FiUbVh
         TGXsBKckhu/Zzqx/yqA3oxnUtIe+YXe51MNpjYRpR1VPJpX1Qca6k46VftGnsblzha4D
         oDyrdzVDtZ/PX8sN38pvRD5AUG0baMCtrCWYuyUqzEQcClcZLzR6HvuMKKVXWdTgqgjB
         IOD0qIQIU12AsARM/MGRGFC7iLJRa26ULtEceEANR/XBG8GIg6ZcjcrGw98uhDAsmwSa
         I1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=22ItKu+Yc+EPpBvR747hieSTvpkCAZsO+AFU8nOrmZ0=;
        b=K3yr+Xxh8wKVRW+7Sl+csHE6DvSo3t+PrmpgRch0ivRh7SrK8zZVkbV57Q+WRH66BH
         gzfWxjPsdvEttaB3WopRPNsw7K5rfrNjy615HZkQgALsBalFgBu7DH1sWawIhp/axV7G
         jD6gsEsHzreP7gP7ZIc9dvXAjhLjnqkkH8UJuey03jKi571d9RYONJ9/sTJ3E/ctq3Bq
         Zi1HKJaq1SUhaL++rNHbmUMhr5ldEoniy8Jg6KgrAjfBPLqplQFeDFK3PzoT+T6UCT/9
         piGkYwFfOhhGG3p55adE0Op8sjPEmaZtE0BGk8RTUNd75E9SYcZ1uaGFbTfKJgCnRa7q
         +A1w==
X-Gm-Message-State: ACrzQf1NWdbjZxLyfkHBM1fDgjV9EZVoBjr9plH1dyS+xLRwdkIojDDg
        AibMvh9FGcKEQ5nKzdAauK3Tug==
X-Google-Smtp-Source: AMsMyM6vLuJRj0eMZBm+SnFY5N5J+h635HK3xKhWnH3+wwGy1WbBDQ3+lqBNvAW6pMkIW6+iSWeUaA==
X-Received: by 2002:a5d:6b0e:0:b0:22a:2cb1:6605 with SMTP id v14-20020a5d6b0e000000b0022a2cb16605mr2685229wrw.552.1663866244452;
        Thu, 22 Sep 2022 10:04:04 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003a604a29a34sm20334wmc.35.2022.09.22.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:04:04 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v8 0/4] ECAP support on TI AM62x SoC
Date:   Thu, 22 Sep 2022 19:03:58 +0200
Message-Id: <20220922170402.403683-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
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

Modifications since v7 :
	- Simplify ecap_cnt_capture_get/set_evmode() functions
	- Modify ecap_cnt_count_write() callback
	- Modify ecap_cnt_watch_validate() callback
	- Modify ecap_cnt_pol_read() callback
	- Add ecap_cnt_cap_write() callback
	- Modify ecap_cnt_nb_ovf_write() callback
	- Use DEFINE_COUNTER_ARRAY_CAPTURE() and COUNTER_COMP_ARRAY_CAPTURE() macros
	- Push COUNTER_EVENT_OVERFLOW to all 4 channels in ISR
	- Redefine time_cntr and related functions as u32
	- Remove ecap_cnt_capture_set_evmode() function call in probe function

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
 MAINTAINERS                                   |   7 +
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-ecap-capture.c             | 621 ++++++++++++++++++
 6 files changed, 719 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/counter/ti-ecap-capture.c

-- 
2.37.3

