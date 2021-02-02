Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ACA30CA6C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 19:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhBBSsY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 13:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbhBBSpQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 13:45:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D95C0613ED
        for <linux-iio@vger.kernel.org>; Tue,  2 Feb 2021 10:44:36 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id j2so13817343pgl.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Feb 2021 10:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqYAJ+nDIkVEKnS+v7ZhHGM7/OU8LF5OYhbV8HTOckE=;
        b=EbqJ0Eurb13i9Kw7vv82CpFT7VlQSyoOtUH5W4u37wAbfax4UUXya1SmKJ0iwKaSfl
         VxqsOSzQDWUmkiJI4xt6F6HBcRKZy5gKku7bXr0dp7tUWLHFYIvMJDmUXHVs0bRIGASq
         qFzeb8ioYMyL4PqV4ZhFRHd8THUyK4izEz8XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqYAJ+nDIkVEKnS+v7ZhHGM7/OU8LF5OYhbV8HTOckE=;
        b=j6dD7Jb2GbXZeEFEZnJ77FudsTNUUTQP+a1gAEGwhOQQkbdkhGVl1TOPVB8DWzrUaS
         FqXbsHNGcB/s6l6i35G6N91O8gL3NdS515t7gkxk/0cS+vxOeNaFSWfVBIjsTBphdEIe
         cN8WLNFNbQ+ep19DQqBXP1ffBclHMAKdeBM46xjHFXcT5xO2EfeOkFiEipLq0aIqbiiG
         hvPidwvkKBPWl/BEWpj847XWcuflcPaTI5pzmtNaUZg3A7NviPeitRSq240vzycJVk+H
         aJN9kaZ83sMXXJrMRv0/USuTYXqG+Wz4xifabVCW6YnaPkpHK9uhDrsSPhMEbGhbr+OM
         fTKA==
X-Gm-Message-State: AOAM530JhkFo/6Vc1KY7Phm+SmzAP7qjK2r5dIjE1HpIboHBOsRodKYU
        CLtDbCiYeX3+WcKLNDJiz/IGxA==
X-Google-Smtp-Source: ABdhPJx1CNpkVUy6oY3ybTfZeELGCkt9kxOASEb/AynyM8HGSLE0OxMZky3E0lP+gxQBbqJcpAo5xA==
X-Received: by 2002:a63:2009:: with SMTP id g9mr23088703pgg.219.1612291476245;
        Tue, 02 Feb 2021 10:44:36 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id b21sm23159859pfb.45.2021.02.02.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:44:35 -0800 (PST)
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
Subject: [PATCHv4 0/3] iio: Add a ChromeOS EC MKBP proximity driver
Date:   Tue,  2 Feb 2021 10:44:31 -0800
Message-Id: <20210202184434.42644-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
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

 .../google,cros-ec-mkbp-proximity.yaml        |  46 ++++
 .../bindings/mfd/google,cros-ec.yaml          |   3 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 .../iio/proximity/cros_ec_mkbp_proximity.c    | 242 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |   1 +
 6 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
 create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c


base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

