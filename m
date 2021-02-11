Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF5C3183AF
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 03:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhBKCqp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 21:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBKCqo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 21:46:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBFC061756
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 18:46:04 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so2749464pfk.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 18:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=behYvwONvNWFO0BGED30xvXT529p8IBkLrJcULUF2I0=;
        b=gTovJbGO32f9reHLqsnZKKg+eJsr1qnXr4h8Spqcjj2Qu9kXB7vdRUcX+3tSERCuos
         Lgvzv2qSOgEn2z9jv9HMIgTpKHXSZzrb7rRiny27qbLzn3r3ZyXsKP0pnYPjabRXi6k/
         LBRKsHbyShsmzFtbLEvqVkDfc889+VTeqWKbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=behYvwONvNWFO0BGED30xvXT529p8IBkLrJcULUF2I0=;
        b=apOa6WvT5yB9RTMLHjZ0nR/lMCiulKYznoPDut2viW//Hp6Q/WuyruzPAl/bUUwFix
         /7BAiEi5GsEemPpodyc1UDtHwnVXFtDaMKwiGMeHUqBOyu1qbOgxRGZ1ojjv+xN6qi/H
         INp9I4MmSN3YIS1tI08g0AXD+2j3hZ10K2OiBwrdijgw+4ytYgXP5HClvz8BozHL3JpZ
         Mtfz/8HlAP92XC6E6RSYUxMXjsW5lcmKJNYYbZPIzaEKWyOy0/WDep63yROygsYh7nrf
         pYk/jHbqFGmyoV140oRehbpm16grC6OMA1FLeBYcZbxMrR8OU7JtHnl76eapirdSh02v
         2emQ==
X-Gm-Message-State: AOAM532i8wSassISP9zdeVI3HZV9qfAMdu7xN+zyIVQIUr957bViNORF
        G4SZk30zlbBRQTHV4DIJ/YlMzw==
X-Google-Smtp-Source: ABdhPJwiP+8cmp0W7n/wtZKZY07d6DNvZMQchsVlOh0pEskVP6V5a5B+8wZWRmiab08dD0MJ5uIE5g==
X-Received: by 2002:a63:4f1e:: with SMTP id d30mr5888611pgb.203.1613011563990;
        Wed, 10 Feb 2021 18:46:03 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5533:1106:2710:3ce])
        by smtp.gmail.com with ESMTPSA id o185sm2615920pfb.196.2021.02.10.18.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:46:03 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 0/3] iio: Add a ChromeOS EC MKBP proximity driver
Date:   Wed, 10 Feb 2021 18:45:58 -0800
Message-Id: <20210211024601.1963379-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a different approach to [1] where I tried to add this proximity
sensor logic to the input subsystem. Instead, we'll take the approach of
making a small IIO proximity driver that parses the EC switch bitmap to
find out if the front proximity sensor is detecting something or not.
This allows us to treat proximity sensors as IIO devices all the time in
userspace instead of handling this switch on the EC via the input
subsystem and then other proximity sensors via IIO.

I propose this is all merged through IIO subsystem. Please ack
the first patch so it can be merged that way.

Changes from v5:
 * Picked up RB tag from Rob
 * Track state of switch and only push event if it's different

Changes from v4:
 * Reduced binding and moved proximity node to mfd spi example
 * Dropped of_match_ptr()

Changes from v3:
 * Added SPI and cros-ec wrapper nodes to yaml example
 * Ignore notifier registration return code that is always zero

Changes from v2:
 * Check iio clock and use IIO time if not boottime

Changes from v1:
 * Driver moved location
 * Put mkbp everywhere
 * Fixed up DT binding to not fail and make sure is a child of cros-ec
 * Simplified logic for sending a message
 * Dropped CONFIG_OF usage
 * Sorted includes

[1] https://lore.kernel.org/r/20201205004709.3126266-1-swboyd@chromium.org

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Stephen Boyd (3):
  platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
  dt-bindings: iio: Add cros ec proximity yaml doc
  iio: proximity: Add a ChromeOS EC MKBP proximity driver

 .../google,cros-ec-mkbp-proximity.yaml        |  37 +++
 .../bindings/mfd/google,cros-ec.yaml          |   7 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 .../iio/proximity/cros_ec_mkbp_proximity.c    | 271 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |   1 +
 6 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
 create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c


base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

