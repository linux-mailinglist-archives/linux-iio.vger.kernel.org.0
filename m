Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059961BFE43
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgD3Oa2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgD3Oa1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 10:30:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6D6C035494
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2020 07:30:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e26so2107615wmk.5
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2020 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfudZeo3HGr1pCOVetloJ0RAjhpaWYeFOa8fAjA33QM=;
        b=KlVpPYIADUHPbqt9shjM1hL1h0m6/HL9wANDgP/5lq1/6X77lcRv7XxN8AZUxy2hCN
         obktnoYXeE9bgtP7kuTPgsTawMOD3G9qvJ0FzxNOomjWwZvmEQL00nW/6PHupHSEh4wM
         18BGLePJ1mOwzzW+sePkQdbIYQRImoZdNCnnVVhSaO816IYfl7Tdoqvikt8E418JFGGi
         w+v59cXVCOIQwAvFYQ6K61VzHbB4Oll1FwzFWV4fSI7KyzcOpvmZ06cc03kiuQaYRORn
         SdfXL1jWzcCPA/Ne+QPj0ClMG+C6atvoClCmSj1Z4WHoMSwK9eyr9tzGDwyvKqRReX/M
         7J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfudZeo3HGr1pCOVetloJ0RAjhpaWYeFOa8fAjA33QM=;
        b=JbQjMQkR7sYTR1wg0nx+j9C7rmRZQkUp5dfEbLIqDuPX3D6M3ZANSwQwNNZu9eSN2v
         GUIYG6YINhqrbd+4FIZt06+u0jZa+1igK8paD4l9YsvjIoh52vJdjV92SHgemSW0k5TL
         18R2eObInj+AgqgHzHXEl7K/G/IWSMfNvYH7htGHLxG7ByriTLOAbmr1jNYpqAOdZvF6
         gOSltWtHco5zKWTdfwWh3wNoYWSL4O9sI70hdF4m+l9pueOPQKCWHJ8lYVp0t2qAGs2k
         wUoI2zodoOgjtjkrmsyTCtqn1X1WM5up3Ym2eZs8G8/prqr7jXexnNejIyR4p6IUR2Uj
         s8NQ==
X-Gm-Message-State: AGi0PuYmIepoOix+Ct4nmGG2a+OGTwcP3AbfEhxY7Z2BUB8ZhvDeBOEH
        XRTrOQgk5GtpfO1lr5h2IabPxQ==
X-Google-Smtp-Source: APiQypIu8dzyh+cuEFg6C1CXM9ZEE3SyLPblTVNX5zwOgyyT8PDCmH+4oTZeswIAKp6j2KaBwCiPUw==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr3380221wmc.145.1588257025153;
        Thu, 30 Apr 2020 07:30:25 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h137sm14696626wme.0.2020.04.30.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:30:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/2] irq/irq_sim: try to improve the API
Date:   Thu, 30 Apr 2020 16:30:17 +0200
Message-Id: <20200430143019.1704-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The interrupt simulator API exposes a lot of custom data structures and
functions and doesn't reuse the interfaces already exposed by the irq
subsystem. This series tries to address it.

First, we make irq_domain_reset_irq_data() available to non-V2 domain API
users - that'll be used in the subsequent patch. Next we overhaul the
public interfaces - we hide all specific data structures and instead
rely on the irq_domain struct and virtual interrupt numberspace.

The end effect is that we limit the interrupt simulator API to three
functions (plus one device managed variant) and zero new structures.

v1: https://lkml.org/lkml/2019/8/12/558

v1 -> v2:
- instead of just making the new data structures opaque for users, remove
  them entirely in favor of irq_domain
- call irq_set_handler() & irq_domain_reset_irq_data() when unmapping
  the simulated interrupt
- fix a memory leak in error path
- make it possible to use irq_find_matching_fwnode() with the simulator
  domain
- correctly use irq_create_mapping() and irq_find_mapping(): only use the
  former at init-time and the latter at interrupt-time

v2 -> v3:
- drop the controverial changes to irq_domain code and only leave the
  changes to irq_sim and its users with the plan to revisit the former
  at a later time

v3 -> v4:
- add the Ack from Jonathan
- remove redundant parts of patch 1/2

Bartosz Golaszewski (2):
  irq: make irq_domain_reset_irq_data() available even for non-V2 users
  irq/irq_sim: simplify the API

 drivers/gpio/gpio-mockup.c          |  47 ++++--
 drivers/iio/dummy/iio_dummy_evgen.c |  32 ++--
 include/linux/irq_sim.h             |  34 ++---
 include/linux/irqdomain.h           |   2 +-
 kernel/irq/Kconfig                  |   1 +
 kernel/irq/irq_sim.c                | 225 +++++++++++++++++-----------
 kernel/irq/irqdomain.c              |  24 +--
 7 files changed, 215 insertions(+), 150 deletions(-)

-- 
2.25.0

