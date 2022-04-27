Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870CE512239
	for <lists+linux-iio@lfdr.de>; Wed, 27 Apr 2022 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiD0TQO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Apr 2022 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiD0TPx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2022 15:15:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAE56759
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:08:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w17-20020a17090a529100b001db302efed6so947087pjh.4
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHDiEZrHl9nH2N/zDBesAq/7lnCE6j8pHjNAhPQQfdI=;
        b=brwMDR0fSvlwHWM+/vstq5+R2gcLlXx8UtsNM74Y2bVh0VoFFjT/ct9B5zb0UAb684
         EkVOTHpAjgA9TWxHVmHFqgZ2K/jxt5OXaHUALZcKhcPTj/6HSAbNFncCVIy8w8egHC3q
         HF5qJ4JndX/xP0h7HE3q7D1NYTXzx+CSTvR3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHDiEZrHl9nH2N/zDBesAq/7lnCE6j8pHjNAhPQQfdI=;
        b=d7MzeIFdtL3PEFZSMXR79o6JBz0nWK7D0g+8LnCnH4GHZ3vHXC+gcyUUFqxBUMysTR
         AIz/5iCP8ut8yqKIqTCRmX263c4uuQ4wM36H0mAq9L6wA0YAhWWeeAa4qlCJ6j/29Qw5
         cLwij/QFMcu0MJvYx1XrT6RrexaT1XjlcTJqac72lUqCoPi/oh7pwq6Wg7/966OMQdzt
         3pAEsSV5CaoXoUk+tz3NOBqO9J8YY4zGcMDmBa/EyUl2CYCQDx/0E68nQKM73Xa106u9
         FvLVVx6+C2vZuaVwCgGhwrgLutbTbQm9oR8Wn3rCCK+LCeYaoSeBIdyY7Es2ghjFN+he
         XiaA==
X-Gm-Message-State: AOAM5324612Qvb6jKxrTx1bb7Lp+vDzv1FJNZJrixK5Bqo/KLw1ialK5
        SHfy8uyakjgFNQnrzvsuQekzMA==
X-Google-Smtp-Source: ABdhPJxtpPPkmBIxQlpoh2F3txapmusSSdcidX2DNysGdNuDpq2DCHguc9i9y565ffXX/VyYvJzlBw==
X-Received: by 2002:a17:90b:4a4c:b0:1d9:4c8e:8d3d with SMTP id lb12-20020a17090b4a4c00b001d94c8e8d3dmr23946734pjb.215.1651086494641;
        Wed, 27 Apr 2022 12:08:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e71:6689:b6a2:6150])
        by smtp.gmail.com with UTF8SMTPSA id m9-20020a17090aab0900b001d2bff34228sm7889925pjq.9.2022.04.27.12.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 12:08:14 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org
Cc:     bleung@chromium.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/2] chrome: Remove Custom ABI |location| attribute
Date:   Wed, 27 Apr 2022 12:08:02 -0700
Message-Id: <20220427190804.961697-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of using the custom |location| attribute, use the |label| attribute
introduced in kernel 5.8.
A new location is required for sensors located in a camera subassembly that
swivels.

---
 changes in v2:
 * Add "accel-camera" define.
 * remove |location| attribute completely.

Gwendal Grignou (2):
  iio: ABI: Add a new location label
  iio: common: cros_ec_sensors: Add label attribute

 Documentation/ABI/testing/sysfs-bus-iio       |  5 ++++
 drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 30 ++++++-------------
 drivers/iio/light/cros_ec_light_prox.c        |  2 --
 drivers/iio/pressure/cros_ec_baro.c           |  2 --
 .../linux/iio/common/cros_ec_sensors_core.h   |  2 --
 6 files changed, 15 insertions(+), 28 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

