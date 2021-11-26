Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B833345F16F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378538AbhKZQRk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 11:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhKZQPk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 11:15:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C2C0613B1;
        Fri, 26 Nov 2021 08:02:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so40752496edv.1;
        Fri, 26 Nov 2021 08:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dI+lMja+jGti/SnF5owFEZllst2L4ChAuUwddK8NtgY=;
        b=Mqq+10/IPjXe9peZgl7PLgOFhtjpXU1wLidHxG1ESsiEJBCLcTTvIdLtIgUmWjr6do
         x15PGJN1Jw+Pl8lawIJkfmHW/Xk7zYp9lVZd5Iyl/+mr5YGCurbeVCBtrToZ1PXdf0Wi
         Ncw6qd0DTMsUi/gg3jMuWt5CvqiODtWcpbMHzRNlY8oy3HkwoxPIOEbMDbBKYZBg9dOS
         f1nnQChHbvFxMmdlRI7tVbnwIMknfqbat/78YduVNXoX5E4t0qJSlgtwWdf/jqoicg6m
         awGYZTBJHhf5NI9qs/ZBY2Tdzu6f01T8CQOzqt1O6LQAF26PMf02bVdEX5tpO2uyYsG7
         eU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dI+lMja+jGti/SnF5owFEZllst2L4ChAuUwddK8NtgY=;
        b=I2Z+CZs84n0d9HmV0LYLgdEMR69HS4HMy3ad+z8FKHap2t9ZHNMP7nN4t+VKOzkstU
         D7XKGe0bLBNU5iqlYPwHOncf3fsSZ3Yn4DDSViPjENIIZ985ggPMDhSYCgWkK45JKdtB
         q2MhCtIdwK/A42A0zJdQ2+ZDDDlMxKYfHybq4MHL3XXEHOlYT7IxuqrQSIkGZhQpGfOA
         xtbWnxtoYWwJXx0zKAlMK1BeKMw8xyabs+jiUlm7NidSHiimXhxgQcDvDwkDI08nPrlN
         wCWD/+Jd5CIQFsRr/S4UDlyZ8e4e3UAMsUYHCqnt8E8vNhExZRQD7p3qysYwoCxwbShg
         6ITw==
X-Gm-Message-State: AOAM532l5xMUh7abTmPiHrwjgfifCeO2fvXt1ez6+OHE0YVO8P2EWZ0e
        9f/bdO+G+y2SIpVQ6OINON9wVAbU8/8=
X-Google-Smtp-Source: ABdhPJx9jX4Py8Z78pgCEHWCYDcFd6+OnJDZ4525BbKIOIIIu+22in4vRAhC0j5hV5ahUm6DKJtQxg==
X-Received: by 2002:a17:906:6b13:: with SMTP id q19mr38744807ejr.221.1637942577674;
        Fri, 26 Nov 2021 08:02:57 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id y15sm4188324edr.35.2021.11.26.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 08:02:57 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v6 0/3] Add AD74413R driver
Date:   Fri, 26 Nov 2021 18:02:16 +0200
Message-Id: <20211126160219.674665-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


The AD74412R and AD74413R are quad-channel software configurable input/output
solutions for building and process control applications. They contain
functionality for analog output, analog input, digital input, resistance
temperature detector, and thermocouple measurements integrated
into a single chip solution with an SPI interface.
The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
four configurable input/output channels and a suite of diagnostic functions.
The AD74413R differentiates itself from the AD74412R by being HART-compatible.

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

Cosmin Tanislav (3):
  iio: add adddac subdirectory
  dt-bindings: iio: add AD74413R
  iio: addac: add AD74413R driver

 .../bindings/iio/addac/adi,ad74413r.yaml      |  157 ++
 MAINTAINERS                                   |    9 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/addac/Kconfig                     |   20 +
 drivers/iio/addac/Makefile                    |    7 +
 drivers/iio/addac/ad74413r.c                  | 1473 +++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |   21 +
 8 files changed, 1689 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile
 create mode 100644 drivers/iio/addac/ad74413r.c
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

-- 
2.34.1

