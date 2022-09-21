Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF775BFBF1
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIUKGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIUKGd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 06:06:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E1786E7
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 03:06:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sd10so4063770ejc.2
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tJpJDU4B7zTm1IDbN+Wwf2teRaSrleMvBtUbPdZs2+4=;
        b=2plFUUISFakn1Ftx8Hls4dKqZDalIIfYLWWRuVrrDjoDEt3Np2KJLSaF/wClIe6lSr
         U5JLnRKxPfM49rNBpvrAmqonDFgv4Q8Zl6Mw/T+Zn/p4VvNM2fE+6PpMcjRYK/IHX62Q
         PKj/vLswVrsjW41A5ZKYQnUnDh9WTLk1gugVj6veCEW4ZOfXctUNGAIQx0LTdAiAj0W7
         YGd7RybhS1NLu1hBRYPgvqyZkrjeWqe4j8Q5Oizsq21fNguM9eRbY/OUHca5oclMEhfV
         qZcVDYuqVW04OfZ7S8ro8tGk0Pj7/17Oot/cHrzo3sSanXewHVkhIBy/XpNRcipIACmG
         GuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tJpJDU4B7zTm1IDbN+Wwf2teRaSrleMvBtUbPdZs2+4=;
        b=yyM6e5E0oTO0yQB7oL8upT/S/746IcLQmz5vlM8FVLobIKE0eGJoCztqI5NKKXis0a
         EQUPvBinA6uPUBoBxkp0VZs217wWPd7oOR+rc+yA8eAyYdXUrStxA2F97Pb3+geBXTBl
         lxXBtJf9pLrdCzfD5iGNfN0rNCXjsQRUcMKuMDa9wtueyCztmIhP01zie0NqOSLrf3ws
         WcwYjAPEjtWj1ahRacQQtQdZQzu+9E1UHW/ztmGaiKOV+0ZU0vMf0d5fvdZz9y6tSl/t
         6N2+CwUYfNfjJ7LfI50FAY7Dk2e5VHj9a9RKA2KiORaqlHBRsFzryLa/oYO/2GK+Fvph
         klOg==
X-Gm-Message-State: ACrzQf3hkvpgYreR4rqAdgIMqSVBhnhwzA6AIx3ZalVgty63sMD/6eWT
        aPUfo8IXDEX3+ayIS9SqvQKADw==
X-Google-Smtp-Source: AMsMyM7913pl4CCoOxG4nLiedVtq9+e1g3l2xJ4+wpMJ1lycODdfCMtuNClKm5AlNo66MgvPNM5IFg==
X-Received: by 2002:a17:907:a049:b0:77c:1f27:1b28 with SMTP id gz9-20020a170907a04900b0077c1f271b28mr21720853ejc.20.1663754789798;
        Wed, 21 Sep 2022 03:06:29 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0074134543f82sm1087710ejd.90.2022.09.21.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 03:06:29 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v7 0/4] ECAP support on TI AM62x SoC
Date:   Wed, 21 Sep 2022 12:06:23 +0200
Message-Id: <20220921100627.124085-1-jpanis@baylibre.com>
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

Modifications since v6:
	- Leverage counter array components (RFC PATCH v5)
	- Remove the redundant doc of 'capture' items in sysfs-bus-counter ABI file
	- Add driver info to MAINTAINERS file

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
 MAINTAINERS                                   |   6 +
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-ecap-capture.c             | 614 ++++++++++++++++++
 6 files changed, 711 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/counter/ti-ecap-capture.c

-- 
2.37.3

