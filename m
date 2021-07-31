Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E453DC826
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGaUgY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 16:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGaUgY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Jul 2021 16:36:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6FC06175F;
        Sat, 31 Jul 2021 13:36:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so8650906pjb.2;
        Sat, 31 Jul 2021 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1y9z1Gcpr5toD46lkoHxrAj+/wYO1cQnlyyQe8NAnkQ=;
        b=GyuTcD5yH1ES5KAB9cVdQR4A1atqBJGB3bmpNA0wLrda6LCRxUN7y0HFhfdlPp9zSE
         lE3Yw+4N/ew2NoZvtViMo6XIjF+R7KJ5UGuMidyL75EynFGYwXCgDmmZTam10cGmjhAs
         2FQFGPrr912Qs86A5bUaSeSsyax2Ipatk0t0MdNv7u8NIeyS+d46b9vF2ze5wGSvHTxp
         oRL1LQQECZyuWTCjrW7DUO453Mwj+bfSivSGS84ek79IpkGt3j9PHqSVAJjme/KJ8kin
         lE/A4XmXKZMxA2xfN4LinARRgfkU0P0kb2XjRILK0YTlWOOFfdIs5FqXcSPSZwfMLald
         mDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1y9z1Gcpr5toD46lkoHxrAj+/wYO1cQnlyyQe8NAnkQ=;
        b=INtD3gzdg8uWe8Z9pjOIpkgwhWvCLMz6M9nJ0RCyKF7QjAiwgVZZhNHwje3D0zjCJz
         jf7CyPzZRHWwmOxhT/C+7p9Pa5ratAzWoBkqqRfSDnGtcb0fawkIc+mdO5HntsXxYJEE
         DFHUEkwpi5X/6ZQrZDQJpviBQxBMlRVU9gkA8hWf0inxL744w9Ko5M+C1nLdjmtqQ4fx
         lMMVKBJ4OkaNuNN3AX1Cm0SnjCsSKpBNH8nwmh7GJib61Ow3pruOWlKYGb8vI9ExKdbS
         kGs9z0A1mBajzBRaQsIKeymEa3xaXnVLGxoaEXis08peBbYrXucaTD/TqwvSqNHdya5m
         CpoQ==
X-Gm-Message-State: AOAM5323yePghpAeM1cRLRrwFCqX2aXjGAeEcGCXD45gREek+YsMtidT
        NHt0mdioQYfWaMU/S7b/wEY=
X-Google-Smtp-Source: ABdhPJw8WjDHO7HWW1qPGQc1kQ0RHHfT7AND3bKl3CRKpEdMzDiGE7jq40Cqz1OmP67PA4+I9DDF8g==
X-Received: by 2002:a17:90a:c7d7:: with SMTP id gf23mr9881358pjb.38.1627763776448;
        Sat, 31 Jul 2021 13:36:16 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1000])
        by smtp.gmail.com with ESMTPSA id m19sm6752922pfa.135.2021.07.31.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 13:36:16 -0700 (PDT)
Date:   Sat, 31 Jul 2021 17:36:12 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: accel: Add support for ADXL313 accelerometer
Message-ID: <cover.1627709571.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver support and dt-bindings documentation for ADXL313 digital
accelerometer.

Lucas Stankus (2):
  dt-bindings: iio: accel: Add binding documentation for ADXL313
  iio: accel: Add driver support for ADXL313

 .../bindings/iio/accel/adi,adxl313.yaml       |  75 ++++
 MAINTAINERS                                   |   9 +
 drivers/iio/accel/Kconfig                     |  29 ++
 drivers/iio/accel/Makefile                    |   3 +
 drivers/iio/accel/adxl313.h                   |  60 ++++
 drivers/iio/accel/adxl313_core.c              | 323 ++++++++++++++++++
 drivers/iio/accel/adxl313_i2c.c               |  65 ++++
 drivers/iio/accel/adxl313_spi.c               |  74 ++++
 8 files changed, 638 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
 create mode 100644 drivers/iio/accel/adxl313.h
 create mode 100644 drivers/iio/accel/adxl313_core.c
 create mode 100644 drivers/iio/accel/adxl313_i2c.c
 create mode 100644 drivers/iio/accel/adxl313_spi.c

-- 
2.32.0

