Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1741301073
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 23:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbhAVW6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 17:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbhAVWzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 17:55:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA8C061793
        for <linux-iio@vger.kernel.org>; Fri, 22 Jan 2021 14:54:45 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i7so4805299pgc.8
        for <linux-iio@vger.kernel.org>; Fri, 22 Jan 2021 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89gw6YvNATURTK9LTqx+RBcivfIy7/zRAMs6G4Hk8A=;
        b=PsvLEMzbpQV8uTWCDWCZe12J/6HFr573xVJJKHzUv9sGJufSbhhY5mVyf/kYxLTpC9
         8hyHGdZmMDFRxly2ZNJ8oCCxRpayaUrJ3H9+LdezSpGIK+mxuEv1bgelLzyyaOVspW5z
         hUl6/enhunBTGLj+zsCufXjIVTeBwkMUQn4so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89gw6YvNATURTK9LTqx+RBcivfIy7/zRAMs6G4Hk8A=;
        b=mIbJkzmUx9MFSavwjIXOLgGBZB7AAFUqqM8YmHTfrl3Tn36zTSgSXbCxgkFk1wGMvH
         SjWSxw87RCfrp2NDvAZEeTi2EWeKh9Yx+aZzmcwD0usirN2U9vuUkXobCLce7KiLpPL0
         v0tEwSuTS86vOH6k9jyDwD1zOdIIkl333SvJzqymq5t7RXq8Ua+PWgrMB6rPofl6EHnJ
         XnSnSSFzzHafHtrVT/bVjjjrth33VeFOdq2mymOTmrhzan0+epT/C32dSvzxu8m8FwRc
         gk1acgn87ViGl7hDvQ+TOhqYmUM8t1UiIeSXL+NcmwG82zr9VcYSU0OAS0ObK9n4Qnx8
         HAfg==
X-Gm-Message-State: AOAM5319G2e9vImZXPMayaILyYoftJddYXlRebwg2sNWP3acp+eO5C59
        FjQEwA/Z/FW1ELdIVOfwtt9vcg==
X-Google-Smtp-Source: ABdhPJzr0zZEMTiv6i0Pk6M0VCXjUpl8GGjXkZL3oXFmtA2iioxrMcptT2U+p+0okuzjCesuPlu4ZA==
X-Received: by 2002:a05:6a00:2296:b029:1b6:6972:2f2a with SMTP id f22-20020a056a002296b02901b669722f2amr7012104pfe.69.1611356085048;
        Fri, 22 Jan 2021 14:54:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i62sm6433509pfe.84.2021.01.22.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 14:54:44 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/3] iio: Add a ChromeOS EC MKBP proximity driver
Date:   Fri, 22 Jan 2021 14:54:40 -0800
Message-Id: <20210122225443.186184-1-swboyd@chromium.org>
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

 .../proximity/google,cros-ec-proximity.yaml   |  37 +++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/cros_ec_proximity.c     | 252 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |   1 +
 5 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
 create mode 100644 drivers/iio/proximity/cros_ec_proximity.c


base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

