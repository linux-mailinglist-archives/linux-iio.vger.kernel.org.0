Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD122D691F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404511AbgLJUub (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404489AbgLJUub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:50:31 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838AC0613CF
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:49:50 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w4so5321884pgg.13
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRV2vHYXpx/oHVY1KXpSlteEw0CMJYgqhCowRb3VusU=;
        b=WC4oDY4eoicLBybHEUxQOpZ9Bpu6Ofqhfr0sB3yfRv93Xy4j6eo9LVpfrxis+/d5Ab
         0p8E2j7azsDO+hNtOBfvVVTPcT4NVJRtwre+6baeS1W2+q6Wa3gUrPsQwWNA/rr/DaGh
         tBZKa1BFMSFOerCxlLstpbQsA0W2iNTDp0e1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRV2vHYXpx/oHVY1KXpSlteEw0CMJYgqhCowRb3VusU=;
        b=WdxwdfmOB8AjqyGj1ruT0YC7JMwtuDpxWQqI6SBvWpgch6jh4tcC2Sbxf+OGVOZDJm
         8i/9l9jM2wc0Ot2lBKWqDeXlIRKeAUUgRbg00PFqrRCEvekoYELE8dl3/2OIF5laF8UO
         pX0dQ7/GKLhdJZRozZuQgDRPblAkig/z90k6aErE9zXsR/6vccZq/5sjFN8nJzoWtCtG
         ln8RJzm+P0jZjUP0x2tt48Y9TZFsew7f3iSzOPGqED+cY44Zcok7XfIkaQjcwNyXBwEt
         6IuMItwn9Vc3B388w4Fvc7L46hheej7aWoaX4Ow9PInsZmzlHmWMvPc5g2wwQaD7n0eF
         GM8A==
X-Gm-Message-State: AOAM5321zoNuV2k30O6q5xnNhyw94nnQkaDj1THbF2g5FA7WoJTeDjyD
        WnAKZPbAy5FNL5/L0klEx4GsEw==
X-Google-Smtp-Source: ABdhPJzpJ+mk7i/bOvm94ASV/xzm5xFnGjitdEzcuwmVFqOt36W6Id+rdIIuMT69iBRn8DeJ4FmWfw==
X-Received: by 2002:a17:90a:6842:: with SMTP id e2mr9457369pjm.190.1607633390539;
        Thu, 10 Dec 2020 12:49:50 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id o2sm7157475pgi.60.2020.12.10.12.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:49:50 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/2] iio: acpi_als: Add sotfware trigger support
Date:   Thu, 10 Dec 2020 12:49:41 -0800
Message-Id: <20201210204944.968290-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices (chromebooks) present the ACPI ALS device but do not have
ability to notify when a new sample is present.
Add support for software trigger (hrtimer/sysfs-trigger) to allow
retrieving samples using iio buffers.

The first path fully adds timestamp channel, the next one adds trigger
support.

This patch assumes the patch "iio: set default trig->dev.parent" is
applied.

Gwendal Grignou (2):
  iio: acpi_als: Add timestamp channel
  iio: acpi_als: Add trigger support

 drivers/iio/light/acpi-als.c | 103 ++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 31 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

