Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2F3071CD
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 09:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhA1IlA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 03:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhA1Ikz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jan 2021 03:40:55 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B638C061574
        for <linux-iio@vger.kernel.org>; Thu, 28 Jan 2021 00:40:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q20so3546031pfu.8
        for <linux-iio@vger.kernel.org>; Thu, 28 Jan 2021 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJIAwStqssO4qlrJsU+DZexmUlk16AIgSgJEzjOLeeM=;
        b=dhqfKN/9w8VsgNPrc1AXQXAmZwOdSjzVEaYFJ8O1aFkPq3+yVdEn2hzOaOmaJWa4AB
         dykJLKZqrjHP9erkYh5RmFmxjAWrNe9ED1y1n8OH+8/iLZJkzURf4IEbru3xADFMN+2n
         cq8CbP6KSQSRCAgLl4qZkcOhE0F75C8nHEBXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJIAwStqssO4qlrJsU+DZexmUlk16AIgSgJEzjOLeeM=;
        b=YW7vJZQsNuWSdluyd+cihOHWmA3O91j08A2H7w3B+yPDmh3f0fcPERgDkUacMpIwzb
         cnH5/KcOfscF6N9k9yVZkR4FDjbvA9CtQDPP17gPAHgXMvl3HYa/79UJ0ee29JRSEOWN
         HJyxsQfDS1AgeY5Y8wbzpv3wpi8aU9qSUdSGXObSCteAFhTtIc9iPKDvSZMLA9wZurOr
         8hqKzo5vac/NbfAgEMmNAAwHao29oSw5Dfu6tSD/Jyh3IG7pGCMt/OdkTOdy+ZVWhrd0
         sakEff044hGZU78lqJPfHjXxupnsI4dMivhQpzAj3vhhyrm0QI3ZGSnZcOO9DKMGSaDA
         h4vA==
X-Gm-Message-State: AOAM531KM8VS6K0pZNKbx87Qjp2IpibIvGZ0rP9BsxluwAJWi/9Rf9eT
        PpaLk9SBjdioJvZNKdpxaRcaew==
X-Google-Smtp-Source: ABdhPJwdTxInMeMQs7wJ0rshDGS+Vl3qWenVzQEcjNEcW2sCGquJ2dqyyBLsunFSKhTq0+2R1e+D2w==
X-Received: by 2002:a63:7051:: with SMTP id a17mr15299011pgn.26.1611823213816;
        Thu, 28 Jan 2021 00:40:13 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:304c:5453:303a:8268])
        by smtp.gmail.com with ESMTPSA id y22sm4951757pfr.163.2021.01.28.00.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:40:13 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCHv3 0/3] iio: Add a ChromeOS EC MKBP proximity driver
Date:   Thu, 28 Jan 2021 00:40:08 -0800
Message-Id: <20210128084011.3270281-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
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

Stephen Boyd (3):
  platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
  dt-bindings: iio: Add cros ec proximity yaml doc
  iio: proximity: Add a ChromeOS EC MKBP proximity driver

 .../google,cros-ec-mkbp-proximity.yaml        |  38 +++
 .../bindings/mfd/google,cros-ec.yaml          |   3 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 .../iio/proximity/cros_ec_mkbp_proximity.c    | 245 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |   1 +
 6 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
 create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c


base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

