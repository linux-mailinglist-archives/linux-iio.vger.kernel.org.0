Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF128562E
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 03:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgJGBRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 21:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgJGBRj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 21:17:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE204C061755
        for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2020 18:17:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b26so385330pff.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2020 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3yYB0EHwEWrP2fjO5tTxpwU3iz+XBA/J7IzQ9l34LE=;
        b=Cc/RyzcfY7N1uH0NrbyKcMJoNSDvgRmLb4ILDISwzb64iioQGhMAbv8YatwVFE5zTe
         YSPAEHwvKxwVGjzBtJwLpnk6FONK/g/XmKF9PFUQQzbEHTmxaYOvg/NUdmlUp22HkPaN
         UXh07oheL9NP+kgJGHxFmdJOE1fxhxkm1R10o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3yYB0EHwEWrP2fjO5tTxpwU3iz+XBA/J7IzQ9l34LE=;
        b=dsVnzJbX2XsRKdECoJ+3ZglWD56YLZqdXXQE6reYCQcQLoW+d55hsnOVvQfLO9s4Bw
         QCa3KpVyAemluQw8jRaSwyZahHX8Wl4RdzryoOjJcjvxohW0DoDuHVbCYj+AYoAx59Nv
         dn3sfg2J8eExs96bZPORaBQOArcwsndtFfKRsA7i12RctSmI3aTShSzIsrbYszG2dfvg
         SyhpX++jiGjHGlqw+rBnZEMUCoxdHBmk1salbecHmlakXgbjMG/YDxJr6AnBpho2eo95
         Ig7sO8tfAO7W2rSdTLmGBy44v/HnEggSiX6YCif0bxTZDArs8YQp53F5g1hbDAIWyz78
         olbA==
X-Gm-Message-State: AOAM532lGrdl6w2VtBjZcncs5ViDbXxdM0RNgqcg/A9cFqc3fsumFB+Y
        ToZ1pKAXVcVlonhpuqrYX6ouEQ==
X-Google-Smtp-Source: ABdhPJyvkMM+fdSw7224IGBytnYwurIh8nkJhXgkqu8xpRZgB6wh8w67m8cQWGmwY99Y4NZoYt97QQ==
X-Received: by 2002:a65:5a0d:: with SMTP id y13mr824246pgs.436.1602033457282;
        Tue, 06 Oct 2020 18:17:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm482654pfc.89.2020.10.06.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:17:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] iio: sx9310: Support setting various settings
Date:   Tue,  6 Oct 2020 18:17:29 -0700
Message-Id: <20201007011735.1346994-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I need to configure various settings such as thresholds, gain factors,
etc. on this device. Some settings matter at boot, while others can wait
for userspace to configure things. This patch series adds support to
set these various bits in the registers of this device.

Changes from v2 (https://lore.kernel.org/r/20200930075728.2410327-1-swboyd@chromium.org)
 - Rolled in a fix from Gwendal on last patch to simplify if-else logic
 - Fixed binding and picked up Rob's reviewed-by tag

Changes from v1 (https://lore.kernel.org/r/20200903221828.3657250-1-swboyd@chromium.org)
 - A bunch more patches for userspace settings
 - Removed body thresholds as they're probably not used
 - Removed compensate common as it probably doesn't matter
 - Moved thresholds, gain factor, hysteresis, debounce to userspace

Stephen Boyd (6):
  iio: sx9310: Support hardware gain factor
  iio: sx9310: Support setting proximity thresholds
  iio: sx9310: Support setting hysteresis values
  iio: sx9310: Support setting debounce values
  dt-bindings: iio: sx9310: Add various settings as DT properties
  iio: sx9310: Set various settings from DT

 .../iio/proximity/semtech,sx9310.yaml         |  63 +++
 drivers/iio/proximity/sx9310.c                | 508 +++++++++++++++++-
 2 files changed, 565 insertions(+), 6 deletions(-)

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>

base-commit: 1bebdcb928eba880f3a119bacb8149216206958a
-- 
Sent by a computer, using git, on the internet

