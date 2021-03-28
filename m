Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1C34BA8C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 05:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC1DhY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Mar 2021 23:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1Dgq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Mar 2021 23:36:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAEBC0613B1
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 20:36:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j25so7602878pfe.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 20:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g55s+qGud9ob/EhXq7vN0WUXspe2A0tB4UDs0xkj+cg=;
        b=oEbZdEBz5EveLJl9AS35lLDorko7es888fvu2VP9/WP4UTblzQYx1OfKb/P/MK03u1
         3ISsIC0AAspY+PuSgZ2X4Ak05DbNGC/UnU8ywoddQNQxEY21fNHWY4fSPUImO3+Z2QXa
         ArbbL0uycLSiWLmGuO7lhgPfqDgV/VcEU87oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g55s+qGud9ob/EhXq7vN0WUXspe2A0tB4UDs0xkj+cg=;
        b=t3YM66nJflibDf4yZhn0bEFV52yLaV3EU4xS8XLMFBHJ4j9WygQzyiygwYp/74GtBy
         NY4E6iPRFAi32b9a3nx/Zipyln02WFNIFProF+D4YY/B8tuMNgmQvyTMK39ZiyKpAtf+
         oITocuO2CiZcyWlxpc9UKbEFyRENh96Z4az3uDIOQ44ktcC1xynN77xEY6jOKSEpNIZ0
         e+DDUqlJ9H2LbMhaaH4/7Bb/tsll9554r/nEYpxpbtzthppkvZ3mTHGmYUUlZne6xytm
         dx97Tds7RbW/2d/ksTkwmTnFkoLOWNKVEBcpId0wCujq9DCsKhcu+2eYYxtTW31UXo5f
         WJsQ==
X-Gm-Message-State: AOAM530hTIZi0D2jhwLmdoojncUshBTNKqmWP2Cxa2jlC+FeSkNmZNn/
        xkYw4WmMZ36db+S3zya2d5HJLsbnVUHyZA==
X-Google-Smtp-Source: ABdhPJw/O7R9adXH3IH5bLakCDoptxyHNqfrJtZ8x+kxzRMv53WwcjrCUk/iyH9h9nkWxdAYi4l4jA==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr18222132pgj.451.1616902606147;
        Sat, 27 Mar 2021 20:36:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5993:d227:a897:4c2a])
        by smtp.gmail.com with UTF8SMTPSA id gb1sm11845283pjb.21.2021.03.27.20.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 20:36:45 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] iio: sx9310: Add debouncer-depth parameters
Date:   Sat, 27 Mar 2021 20:36:37 -0700
Message-Id: <20210328033639.1021599-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Semtech SX9310 SAR sensor has a debouncer filter: only when N
measurements are above/below the far/close threshold an event is
sent to the host.
By default the debouncer is set to 2 events for the close to far
transition and 1 event (no debounce) for far to close.
It is a balance speed of detection and false positive avoidance.

On some chromebooks, the debouncer is set to a larger number.

This patch applies on top of commit 103d6ec82676 ("iio: sx9310: Support ACPI properties")

Gwendal Grignou (2):
  dt-bindings: iio: sx9310: Add close/far debouncer strength
  iio: sx9310: Add debouncer-depth parameters

 .../iio/proximity/semtech,sx9310.yaml         | 18 ++++++++++++++++
 drivers/iio/proximity/sx9310.c                | 21 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

