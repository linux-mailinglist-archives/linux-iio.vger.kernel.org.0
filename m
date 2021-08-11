Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2BA3E9A4A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhHKVRU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 17:17:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB205C061765;
        Wed, 11 Aug 2021 14:16:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so11731280pjn.4;
        Wed, 11 Aug 2021 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Gu2s9kfYjWx5VvZpneLbt/TocH7EZH7MNnLkQP4L/BE=;
        b=GNzcHjbzo3FWOD3TdgfItGECTFVmWM6U7D059liyPdMXG1BuNRrqT7m4WCPRCQzf/6
         3GbioR2yzpyLo50nl53PnxBdnAXUVVbfQPyDQjX2F5n43zciw06PYmCSeBZ5oTETPCIs
         L2v0NNmJYUX6G+FmR+IUBaUeN4MxE9geZPH0/1PmJXUhagmPXFf7cip4AqVgmUFBUQwz
         y5wF+i1bcET/N0IrBRX83FNAtFq9o0TJGKDy/JDCrVJnFTC/17Ro7wFn/PhUzzYYi6av
         rSM648o75NFpiQjLDaAzDGjYRWtTbb+07cEbQti0M0qiV4s9aXrw7W89L3Os5D+DKk6a
         zkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Gu2s9kfYjWx5VvZpneLbt/TocH7EZH7MNnLkQP4L/BE=;
        b=TdBM88EtL7w8XqB68Da4bpooDc4TFkQ1xiTJPGIz1THGdcPyskmgTC3nz4C5Ayw0/o
         rxHhEFvvymJ8T2VuRK6/pB5gnPpPpAHxNpeJwaSK1yyceCo79kBd5GcCKH3hwa7yzD7R
         zptrT98cpaURAftmCoJboIcsGZ9fU6pPFqfhuyXMbEMy3FOnmlKmMXh7dRYA3Ed9TliR
         iukC03HxiQ+QK4uq354Y93HfPIcu221jRzfdBd42JCgbW8aGthpUcOWZpPS5bin790Yp
         Q+Iyp3FH8+PAyd9Ep/MZw8T7puc76VU0ubPicd7+rspyPEz3xQ1pODuyotGrB8I/lilp
         EWUQ==
X-Gm-Message-State: AOAM530wus5XeRbgMyhbVSYnpmxX1I+KsBkaZcfMsnEjQ/HI9rXrGb4c
        pejNf5NBC3osy2UPOwEhrpE=
X-Google-Smtp-Source: ABdhPJzDEOJ5Fb5sRfggjyJHcfK0t27IOZaaenLseREh3x7gJG2SrjPps00RmMEZfMdpTztAj0+GMw==
X-Received: by 2002:a17:902:c946:b029:12c:3cf9:36c4 with SMTP id i6-20020a170902c946b029012c3cf936c4mr627408pla.84.1628716615301;
        Wed, 11 Aug 2021 14:16:55 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1001])
        by smtp.gmail.com with ESMTPSA id dw15sm375132pjb.42.2021.08.11.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:16:54 -0700 (PDT)
Date:   Wed, 11 Aug 2021 18:16:50 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: accel: Add support for ADXL313 accelerometer
Message-ID: <cover.1628713039.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver support and dt-bindings documentation for ADXL313 digital
accelerometer.

Changelog v2 -> v3:
- Add minItems to interrupts and interrupt-names in the dt doc
- Move spi cpol and cpha configuration from the dt doc down to the driver
- Use wild card for adxl313 files in MAINTAINERS
- Use acceleration scale directly instead of defining a macro for it
- Use clamp_val to check if calibbias input value is in range
- Add comma to the last fields of the regmap configuration structs

Lucas Stankus (2):
  dt-bindings: iio: accel: Add binding documentation for ADXL313
  iio: accel: Add driver support for ADXL313

 .../bindings/iio/accel/adi,adxl313.yaml       |  86 +++++
 MAINTAINERS                                   |   6 +
 drivers/iio/accel/Kconfig                     |  29 ++
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl313.h                   |  57 +++
 drivers/iio/accel/adxl313_core.c              | 331 ++++++++++++++++++
 drivers/iio/accel/adxl313_i2c.c               |  65 ++++
 drivers/iio/accel/adxl313_spi.c               |  91 +++++
 8 files changed, 668 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
 create mode 100644 drivers/iio/accel/adxl313.h
 create mode 100644 drivers/iio/accel/adxl313_core.c
 create mode 100644 drivers/iio/accel/adxl313_i2c.c
 create mode 100644 drivers/iio/accel/adxl313_spi.c

-- 
2.32.0

