Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CD645EBB9
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 11:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhKZKjU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 05:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377247AbhKZKhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 05:37:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CFFC0619DE;
        Fri, 26 Nov 2021 02:23:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z5so36940630edd.3;
        Fri, 26 Nov 2021 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jre/oDqDL38Az7gfYZIbvMV38bQ5mA5ntNTe8RxlVbo=;
        b=d39t2u+737mjAU7Z/Ugq+pMgIUWuLf2gTDfncwmtUC/CMmwViJQy4u/dF/vPD8TZIT
         MtVWic5heJY+w6IvKYzlAN8tUIM0ScnndbGujkH6wGRAco7epOYCQkEzhk7mLZSALASP
         R6uTd3Okw914zp5fnxOcIMtyy6Uiw96MXEDNRtytJcmIJqknZoizzI5AziHTmd65kpmL
         cOo+MvReZ8pG1dTs1x9Y/rTuQse6likbZONyXDmbFSVJivGP1TVmPUjgT3ujKlNKUAPX
         pe4Ygtwt4Ho6CKfI12Wy7JM8xu8IP2CYBYsYdLHIBYznCFqC/WVyivYKU3la/PEDZ7jg
         5pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jre/oDqDL38Az7gfYZIbvMV38bQ5mA5ntNTe8RxlVbo=;
        b=5TzmhKVsjX7AFSZVM7vOP+KgtmdPUEKk5ybIiI1kscsqgh2+KH2yJrXjfD+2jMlfxp
         2QGgeBzIGKQWLNcCdJRZUFLxtccJTIhiQGGX11GuQoxvEgkogT0ShvLZVQ1ihw9zKf8k
         lh/wtpltoMVmJhdJDNmv6hWFuLxyLd3ABMZnyjRQtm47Beo2Li+B7NWj+iWgTqhf7J34
         RfM05swR8iNKUz6pbbr3fD0BUqTkF0feZSZQGvdgM4iRYk3g6nbFl2Q/xQoAWqWO8J8x
         cPtN7wVo/WL6HgUYPcv0ZzSCKpKpRfyXY4PQZ3YvhxPHuW+OsjXrq0sP0/Jj85k4xMON
         fKQA==
X-Gm-Message-State: AOAM532RTHS/XqvEYtaXMazjk/p6UlbhGHX2ID11OCP8hNvnqzydE4vc
        ZTGJNdDqJr8fYuzBPSJ5XrY=
X-Google-Smtp-Source: ABdhPJxknotDcTg5n3aVu21j35W55dieaPwLxEsUxuRc6I5GhswBhgmlb3OEyCFhgYHrvGpNsgW81A==
X-Received: by 2002:a17:907:a42c:: with SMTP id sg44mr37388974ejc.335.1637922184876;
        Fri, 26 Nov 2021 02:23:04 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id w24sm2866019ejk.0.2021.11.26.02.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:23:04 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v5 0/3] Add AD74413R driver
Date:   Fri, 26 Nov 2021 12:22:43 +0200
Message-Id: <20211126102246.289491-1-demonsingur@gmail.com>
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

