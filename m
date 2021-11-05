Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F191F446509
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhKEOjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhKEOjL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 10:39:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69091C061714;
        Fri,  5 Nov 2021 07:36:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b12so14077004wrh.4;
        Fri, 05 Nov 2021 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvMjGcobnBgLs7ZPSv8hX0I0/4KkCNQdWW3Z/W7d/b4=;
        b=IB25lQ1JPmF23njjHdeiU6z1mNDbFN6QEZH54rKox/jHMRLTohC1oewAkk/HCoXwr1
         f/Xw4G2k/ESLpOWF/XSkRULZZra1jBpoSxnv7xZZuroh+Z5mI4JJes8OD38/9Qqc0uF7
         ZZkS7DS4aa9qpR9DfjMujEsfZsmZDBTqvbJB7CC7tHRhToDMmQXaF1Gyazr0KBT1Xb6Q
         /+YeDNG2q2RaMq2Jl9W1k6sJH4UNxOW9AdQiswxawhq/g//vOdfKkUhRBeObrP8c4xIr
         J/UQr0JfjxbAqR0Awourre10x/eJULBPmHUjyS7ZgNGXGF/DnudTUIkXhFkgplqCi20E
         AS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvMjGcobnBgLs7ZPSv8hX0I0/4KkCNQdWW3Z/W7d/b4=;
        b=f+UYJiGSDS8EyfHe4N5iBNAujVIZO8ZCgDon7fPsb+vemwfjrolEigHgzh5Sa3zmk1
         S9Go/B2MnzAuJSYZ54APgYALfCfsn31lnVxaUKOCOSuDzNjTy1AAGIf9u5Z1WDfYuXhf
         4K/FatL76gM61/3Zfehn/qf8p4XoFaqKpCqSh463jITj4uJqzmzuaqwYJE7iqsqq2MB8
         avRYTJaSVwnvBqOVkklOHN9PqfhxHjLxrDSwFUj0UkmNg6A4tITFxWQOyNa5S7748wpk
         9Q1oqD/eejfnVFXDmrk84w0615treJBB/U6RuWvvKF3zLsJTRFljNTK5AmZ6o8Xckmtz
         m7iw==
X-Gm-Message-State: AOAM532QxFhBXtHx6RCAHhfWTlpJLlNqKQfWSfwUfr7Jpbdqs7g49Buw
        mrQY/uWRoW36l/tjt28O8W3qj7rNYenJyw==
X-Google-Smtp-Source: ABdhPJyeeJKJvHRvpLq0b+2TdSjZvOz0j8oKTFETeEWsdESJjCTyNXfeqK0D8zGKC3Q6zi3OVRleHg==
X-Received: by 2002:adf:dc0d:: with SMTP id t13mr73158647wri.158.1636122990015;
        Fri, 05 Nov 2021 07:36:30 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id z5sm15140839wmp.26.2021.11.05.07.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:36:29 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v3 0/3] Add AD74413R driver
Date:   Fri,  5 Nov 2021 16:35:47 +0200
Message-Id: <20211105143550.1783528-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
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

Cosmin Tanislav (3):
  iio: add adddac subdirectory
  dt-bindings: iio: add AD74413R
  iio: addac: add AD74413R driver

 .../bindings/iio/addac/adi,ad74413r.yaml      |  153 ++
 MAINTAINERS                                   |    9 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/addac/Kconfig                     |   20 +
 drivers/iio/addac/Makefile                    |    7 +
 drivers/iio/addac/ad74413r.c                  | 1492 +++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |   21 +
 8 files changed, 1704 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile
 create mode 100644 drivers/iio/addac/ad74413r.c
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

-- 
2.33.1

