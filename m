Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A48733EAA5
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 08:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhCQHk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhCQHkS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 03:40:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D332C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z5so361093plg.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSvXzJs99Z3djcci+lDNs+LoX5RDvwImH1YIdeY5Qfk=;
        b=TaQhzNJIVLDuWzOFwMb2XxWj6qmf7xYX9ZOz/OAzj0QZIXLI1rMmoyAwd3zmJCJ1rG
         0AjaET+zbMq7G+FSIy0deQHIksPAHcc35KKAe2x2tPXptYrLPn5iiXcO/CPl3U2BbgQS
         XdlWMJEfwiGzVBzAlaaK3AuOGHdFrK8lp9IN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSvXzJs99Z3djcci+lDNs+LoX5RDvwImH1YIdeY5Qfk=;
        b=ctrewsFcWDF/x+PDvSZJLUoEzEZVBFSSUQrVjDOXSVrYh750Ptz9R1/t82vo0wng7q
         mnNqEdSVZxZzqrAukGX69jYkW7F1FLBmtCz30mQwGMJdZQZEV36k0fdQkvdg/fVgAOQF
         U5GzXUpL14eQ4KEy/YV/i6qwLgzG3UPmhXQyZvO8E4PgD9uHXWnNkc9dfNQHqDh6nEw3
         DQthcwg1M4P+MMgXdv6aVgCyVt829DHCXeHjJOTav4EsMpCqXcCavaNaSroqsSZyFYME
         xxxETfyhYi4/lsVODmRernbbl8LsbVNYrqNQS60cu+fGywCS1l4A5LLh86ZAvkTIA4R/
         dQAQ==
X-Gm-Message-State: AOAM531FZ6IjvMjagzMvBqAWdjCM8ZeY7T0Eip8ivuvacL6QgZ5/YOKb
        ksSq50u1yrFOmY1Sr7xKZ78jrA==
X-Google-Smtp-Source: ABdhPJxs+lDlTYw30cEp1dwjn9CBn7Cf0Aq2s23JidK4tJg1ZJERSttruzr3BdX2uRoH7a62q2vqIQ==
X-Received: by 2002:a17:902:834a:b029:e6:b6bc:f58c with SMTP id z10-20020a170902834ab02900e6b6bcf58cmr3216388pln.85.1615966817780;
        Wed, 17 Mar 2021 00:40:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:bdd3:3391:be74:f7be])
        by smtp.gmail.com with UTF8SMTPSA id gz12sm1650499pjb.33.2021.03.17.00.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 00:40:17 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 0/3] iio: acpi_als: Add sotfware trigger support
Date:   Wed, 17 Mar 2021 00:40:09 -0700
Message-Id: <20210317074012.2336454-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices (chromebooks) present the ACPI ALS device but do not have
ability to notify when a new sample is present.
Add support for software trigger (hrtimer/sysfs-trigger) to allow
retrieving samples using iio buffers.

The first path fully adds timestamp channel, the second adds a local
variable in probe routine and the last one adds trigger support.

This patch assumes the patch "iio: set default trig->dev.parent" is
applied.

Changes since v7:
  rebase on iio git testing branch.

Gwendal Grignou (3):
  iio: acpi_als: Add timestamp channel
  iio: acpi_als: Add local variable dev in probe
  iio: acpi_als: Add trigger support

 drivers/iio/light/acpi-als.c | 113 +++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 37 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

