Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4777315D8C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 03:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBJCwb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Feb 2021 21:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBJCwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2021 21:52:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41344C0613D6
        for <linux-iio@vger.kernel.org>; Tue,  9 Feb 2021 18:51:45 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o38so267740pgm.9
        for <linux-iio@vger.kernel.org>; Tue, 09 Feb 2021 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwl4AIvKpyIFMLBw7LDOeCksDs1vdX1B/QNTm5+YpAI=;
        b=iAe7aowfXV35hNjR6SBxn+JgXoLuvo2nMCriAfF5K2UqJgw747/Qb8uUQKU86MhLRj
         sxDbhbnEK3+IsgFUyjsCC+AO424MeJ6OZ3i+peWHP6t/TugXIyZrP1YxYceRAw4U4m3p
         1GmQHtxq02l8PardyRJqgUTyOP3XXSe9cxpcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwl4AIvKpyIFMLBw7LDOeCksDs1vdX1B/QNTm5+YpAI=;
        b=GoliWFtoanTdAmDYUAIklyxPdoCJVL+0NosGaf8lC8coMHoa79Y/RrCDwknyJB55Nb
         0jiQnB29qX7lgs3QSqpK+AlfqsJXBAtpOtRfdAOLlDsIBR5Ji0yzQYc4/DUyC7oNqsTo
         FgQneEe3HUZVszRBodQGFU0xncY3xf8egQmXd38DmtnbXl1RjmXq4kDL7FnfiMmy/a2r
         W2oPTBSvgSXX0iUlPWgcn9BzjJTYkwuAIDZMoxEPC2PwFJtUu9qWjrRemWCvrVjMtwN3
         WXw3Eyf2HX/WoFv4Ax+fPxahPgyY8AU4aG4ElpFli+a4KdbXjmeYBMtgtthG5Eimo9VR
         YBzA==
X-Gm-Message-State: AOAM530pOblDpYr1GcINiVHmdD/R8xdSYHJDMZMRiKTxeK4w0BvZ8dLL
        3A0KzjDfxTfv77OZuSW1jZPlJQ==
X-Google-Smtp-Source: ABdhPJyBVGEtnQ1qiHz2bQggXgYt7eHaM/a/x47kAS2J8CwUf9814cQLT4Jt5GPKW6LFPRVcQydCqQ==
X-Received: by 2002:a63:4521:: with SMTP id s33mr1037741pga.16.1612925504585;
        Tue, 09 Feb 2021 18:51:44 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:58e2:748e:a316:9823])
        by smtp.gmail.com with ESMTPSA id r13sm139420pfc.198.2021.02.09.18.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:51:44 -0800 (PST)
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
Subject: [PATCHv5 0/3] iio: Add a ChromeOS EC MKBP proximity driver
Date:   Tue,  9 Feb 2021 18:51:39 -0800
Message-Id: <20210210025142.3609708-1-swboyd@chromium.org>
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
 .../iio/proximity/cros_ec_mkbp_proximity.c    | 242 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |   1 +
 6 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
 create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c


base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

