Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D27C460120
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 20:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhK0Tas (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 14:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhK0T2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 14:28:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A1C061574;
        Sat, 27 Nov 2021 11:25:33 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v1so53345796edx.2;
        Sat, 27 Nov 2021 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XoR+5hfES4Sf3waEASDz1tegRhwgDTjNje17dfcjC4=;
        b=MiTBdnqJ0fUyZvNdElgSsf0AyL7eaykwIPFI2vsn/DNWs8DCScXus46QE4ok5R3r7J
         t080CV7XxZP/EtAea8vDs/LzvpvzNjdiP37t2CJsECoLAUHCoMffc9iEThLE1RPZrbaI
         zcbyQLpJN+Qkp/RWxkSbY2+HXcTedHoyuMgYmCoUGQ5xKG3QbDWvJj9XjZlbRjZz/UyS
         SNYskV8lDEVvQMuJHpp6P4EBknm4vjDYfiApIiVOrsIQa+1l5iQfFRKBzr+DpYCBt9Gj
         ATOJV3MGMIJlNxE5DIYxrEZi7zCCAiZt1knf8kTUA0f9j9nAAy9gvAVgVEmB+EQ7uD7K
         8sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XoR+5hfES4Sf3waEASDz1tegRhwgDTjNje17dfcjC4=;
        b=D4E9obEtEZf9uFMlzhCzKydJnCQtSWIGS+5l5ho9b8DTgzBXzHPeH2sqhXy6iw3LV2
         5GMFU1gtsrkrfcqgeDfen5eathmG7sqsVpofF/KwZoMme3ryvV9XohtHxJiWyDNM9KsC
         XSeUAMEE0p719rxWaF/BhP6onkCgdMNEz6lJLuvLyS4FqUFCEDkoWiA1NXyau4r0l+jx
         an35OdbO9Z+J4Olq2Xiv9BWRQYK1ApMxgkTspdwH+c9YG6t+hVA9i9qfs1lArNzdNlZ6
         /+MOHTAkLxXM8qKMGbUDf28hhQoW2EKFe+Iw9rYOsdk1RemFXibXTK8RwVB5eaGoW+Oo
         D5ag==
X-Gm-Message-State: AOAM5330IsJWaG44x5phZannL5JWTOnAyEPcTceismJVwv4FQML3usmc
        VPZEhaac5Azt7LnVYUQabw3tZTtUUww=
X-Google-Smtp-Source: ABdhPJyCUQDzawyP+7J6MLQAF5WifeN/nLnMKCxpZCGIPnHme+tbJkFANHZI8izGWU5A5iRK2/2FJg==
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr58704762edx.244.1638041131892;
        Sat, 27 Nov 2021 11:25:31 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id d18sm6163126edj.23.2021.11.27.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 11:25:31 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v7 0/3] Add AD74413R driver
Date:   Sat, 27 Nov 2021 21:25:07 +0200
Message-Id: <20211127192510.35723-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

V1 -> V2
 * sign off using company email

V2 -> V3
 * replace gpo config firmware flag with one flag specifying whether gpo is in
   comparator mode
 * create two separate gpiochips, one output-only for GPO pins not in
   comparator mode and one input-only for the value of digital input channels
 * wire up all gpo functionalities using pinconf
 * keep number of characters per line under 80
 * rework locking
 * do not invalidate other chip revisions
 * do not set indio device parent
 * print probe error for refin regulator
 * move conversion from range register value to range / offset / raw offset
   into separate function
 * module.h -> mod_devicetable.h
 * use generic firmware interface functions
 * add comment regarding cache alignment
 * add comment regarding ADC channels buffered read setup
 * un-inline comment regarding 100us delay for conversion start
 * inline return statements
 * remove assignments to val2 where not necessary
 * local_channels -> chans
 * index -> i
 * channel_config -> config
 * IIO_ALTVOLTAGE -> IIO_VOLTAGE
 * .info_mask_shared_by_type_available -> .info_mask_separate_available
 * remove unlikely probe error messages
 * use an array indexed by channel function for retrieving iio channels
 * count iio channels while parsing
 * move HART rate rejection outside of setter
 * move channel function validation outside of setter
 * use SPI messages for read and write
 * validate DAC code earlier
 * simplify switches to only handle existing iio channels
 * pass indio_dev into functions needing access to it
 * pass spi into devm_regmap_init
 * dt-bindings: sort compatibles
 * dt-bindings: remove driver word from description
 * dt-bindings: remove refin supply description
 * dt-bindings: specify channel function default value
 * dt-bindings: remove maxItems from scalar value

V3 -> v4
 * remove double gpo from macro name
 * reset at probe
 * config -> chip_info and store chip name inside chip info
 * cacheline align every DMA buffer
 * simplify generation of adc samples message by caching xfer, tx_buf and rx_buf
 * use mask itself for writing the value of channel enable and gpo data
 * move reg read and write transfers to the same buffers and use local
   variables for transfers
 * merge the two for loops handling gpio configuration
 * let firmware decide irq edge
 * remove INDIO_BUFFER_SOFTWARE already set by iio framwork
 * do not set trigger device parent
 * return dev_err_probe for regulator error case
 * do not set cs_change to 0 when not needed
 * do not set spi device drvdata as it is not needed
 * fix bug regarding wrong channels being created for resistance input,
   digital input, and current input with hart
 * use voltage input channels spec for high impedance mode
 * put () around macro parameters
 * merge AD74413R_CHANNEL macro into its uses
 * remove unused switch case scope
 * inline return IIO_VAL_INT
 * use {get,put}_unaligned_be16
 * use proper types for reg and val
 * move default case handling into switch statements
 * pass driver state into regmap functions
 * use genmask for generating a 16bit max value
 * alphanumeric order for part numbers
 * dt-bindings: remove $ref from ohms value

V4 -> V5
 * dt-bindings: include headers necessary
 * dt-bindings: add IRQ_TYPE_EDGE_FALLING to interrupt flags
 * dt-bindings: ohm -> ohms
 * dt-bindings: spi0 -> spi

V5 -> V6
 * fix warnings regarding overflows

V6 -> V7
 * remove extra cache-line alignment
 * adi,rsense-resistance-ohms -> shunt-resistor-micro-ohms
 * dt-bindings: add product page links

Cosmin Tanislav (3):
  iio: add adddac subdirectory
  dt-bindings: iio: add AD74413R
  iio: addac: add AD74413R driver

 .../bindings/iio/addac/adi,ad74413r.yaml      |  158 ++
 MAINTAINERS                                   |    9 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/addac/Kconfig                     |   20 +
 drivers/iio/addac/Makefile                    |    7 +
 drivers/iio/addac/ad74413r.c                  | 1474 +++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |   21 +
 8 files changed, 1691 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile
 create mode 100644 drivers/iio/addac/ad74413r.c
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

-- 
2.34.1

