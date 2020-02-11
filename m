Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A78158F86
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 14:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBKNNB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 08:13:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41796 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgBKNNB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 08:13:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so12341333wrw.8
        for <linux-iio@vger.kernel.org>; Tue, 11 Feb 2020 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=be2U1w8cWMwS1znOLLGvyu9gD3io+mzqfXIBluHdiTA=;
        b=GWfuVkDEtXOKWb5CKYVmrPobVMV94DGgOuRHpsqw2XWeoGhMbdxDxumKlK9Op5DeDf
         xN5P/aLKYPIW0lEAyt2mJCnBPsvzDGf1yt2NQ9KLtf4Qn0QjL67LUup7M21qw9ezHC9s
         7x1iOjCYu7lcLVLRSaHSTmL/fQF4ppIeaxJfYT7EtAHMYIb+Ks62eYtXQeMsGx4goji2
         273sZ3Bk1Yp//t6wamQJa2QMN559SRkp4uplHKlxyE6ghi7OL49znMiHs4fwNXiz51q8
         Gj7wusjiQmpRgseNqAXkIQvaWRFnMNDBPUxn6Qs2ct2BTCMuymaDWbnqaYhsn8a/QaNr
         onbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=be2U1w8cWMwS1znOLLGvyu9gD3io+mzqfXIBluHdiTA=;
        b=UJlL8m1cw7UjgHDP3uZN6ovlaJtrKYqQvjbn/h0fIUbvjZaxnfW2ZclxQVyIHHMRhM
         iENV2oZqzP1QjkOqusXTQMWVy1cZvt5JDFV55EnUBtb55tSvRGXgAZMAZkjTeuFkDbwj
         TQT8NSbOw0luqi1jgQF/P7B7UrJ1gZst77D/yrZiyawyEldI7fy45RX6tW/EMDeo4LZX
         aZbxIV4U9cxBNkRWpqQqlQ0QeLnHt2XPx+T6rwJbfvxShnFwZPahx5cOwdXDnzkKsIU0
         oOUAZhUJPGRJkN6Qrv4nT5ALLShrUOtXaUvQLB//pAEWziGtfSRFmP/sANI8UkJzI/sn
         LPsQ==
X-Gm-Message-State: APjAAAV4W16KXf+7pETGsgnTREQd9bOdqp6/W6Ees092n2+Sl222Sbso
        OyY2mf8YdJ5Yn/6C3lna2kNubg==
X-Google-Smtp-Source: APXvYqzpLaJmI7tDPA2tDGvz6dBZ9VXm3sif/kYnoWcVrXtWSXV8CQS0YhFVElrGpct/CZfo4eHAnQ==
X-Received: by 2002:adf:f581:: with SMTP id f1mr8638594wro.264.1581426778842;
        Tue, 11 Feb 2020 05:12:58 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id b21sm3873013wmd.37.2020.02.11.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:12:58 -0800 (PST)
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
Subject: [PATCH v2 0/6] irq/irq_sim: try to improve the API
Date:   Tue, 11 Feb 2020 14:12:34 +0100
Message-Id: <20200211131240.15853-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is my second take at improving the interrupt simulator interface.
I marked it as v2 but it actually takes a completely different approach.

The interrupt simulator API exposes a lot of custom data structures and
functions and doesn't reuse the interfaces already exposed by the irq
subsystem. This series tries to address it.

First, we make irq_domain_reset_irq_data() available to non-V2 domain API
users - that'll be used in the subsequent patch. Next we overhaul the
public interfaces - we hide all specific data structures and instead
rely on the irq_domain struct and virtual interrupt numberspace.

Next four patches simplify the interface even more, but since the change
may be a bit more controversial due to modification of the irq_domain
I decided to split them out of the second patch.

In patch 3/6 we're adding a new callback to irq_domain_ops that is called
right before all the other code in irq_domain_remove(). Next we use it to
remove the simulator-specific cleanup function from irq_sim.h - users now
can simply use the regular irq_domain_remove().

Last two patches show that the new callback isn't limited to the interrupt
simulator and can be used to shrink code in real driver too. We introduce
a new helper for a common use case of disposing of all mappings before
removing the irq_domain and use it in the keystone irqchip driver.

The end effect is that we limit the interrupt simulator API to two
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

Bartosz Golaszewski (6):
  irq: make irq_domain_reset_irq_data() available even for non-V2 users
  irq/irq_sim: simplify the API
  irq/domain: add a new callback to domain ops
  irq/irq_sim: remove irq_domain_remove_sim()
  irq/domain: provide irq_domain_dispose_mappings() helper
  irqchip: keystone: use irq_domain_dispose_mappings()

 drivers/gpio/gpio-mockup.c          |  47 ++++--
 drivers/iio/dummy/iio_dummy_evgen.c |  32 ++--
 drivers/irqchip/irq-keystone.c      |   5 +-
 include/linux/irq_sim.h             |  33 ++--
 include/linux/irqdomain.h           |   9 +-
 kernel/irq/Kconfig                  |   1 +
 kernel/irq/irq_sim.c                | 225 ++++++++++++++++------------
 kernel/irq/irqdomain.c              |  44 ++++--
 8 files changed, 238 insertions(+), 158 deletions(-)

-- 
2.25.0

