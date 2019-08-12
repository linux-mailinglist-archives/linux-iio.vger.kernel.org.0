Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3989ED3
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfHLMxE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 08:53:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35001 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbfHLMxE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 08:53:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so11675529wmg.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Aug 2019 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbDB6JFS0IFPkYF4fl0nqbXR16d37yVxlPN08CwT4oU=;
        b=OaK1uWNkYBTnkyqRDeDUdTQBsgC23gwVtMC4iKGuof8O4PZDBlaeLwIJOJnKurvNE1
         AuawtYfXVgsuH5DeSPIDr7kNWi/+MFbtigLkgi2oKVwkL5v43Oa9DKRfDMHBLhGstPyT
         fZWqmyN5Ch6WyXEinLQCAOmpmrn6uHVWRyFjt/YDaphpuCigkkZPQxDd4D/9ArRtqqzm
         u/D7S6h+fPtrio3kd99RVEaVeKdz7BBXC3Ga3gnw1qQZ4i2jasMyELTS/LlpZL+/nsjO
         MhllbK3/tAgqeoEJob1N4HV+YGndyEo3ciPkLDDDkqPUJIUkXjDzknRuGL5/V30+bCpZ
         9HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbDB6JFS0IFPkYF4fl0nqbXR16d37yVxlPN08CwT4oU=;
        b=WgrEWMaSqaopOe2hJwbo78kyoRpZZb/1S2Ny8Xx14TcVR4a3oeWnoeFJO6v5DgqKHx
         jsld4Qcpj/qtPmGZyfG47tnHd9KTyFsrxgWpHAnoIK2HiHH9E0izwrFZdAwV6OzPJefB
         Kx1fU2RfmgV15DkHaJ++3///tYV3UfJ1rW7utXyBIdbco8HFjZm2XV1iHh1XBccEDF2g
         gKbCO8+pGj6FV9h5Y73+0p3o3D9Fel9oJacFhl6fLiPnqWlKRbQHjZUUMrmRIiMu2i0A
         /2/BhobUKkfiR6uQRAr1isA7u1sWxxMJGcb4yeYle34gPCwLnBzDE/sSyAMleL4p53hG
         qFdA==
X-Gm-Message-State: APjAAAVyOfoTTYqmaNW5FqoCZ4Doqd/eFn6Bh7r52n0WP3rYMM6fBTnw
        kAKHx0yx+fRd4XCZM9EiTpoSdg==
X-Google-Smtp-Source: APXvYqxUJYUKGKzgKcM/WXnrMlZ63SVZ1QErY6mY/juBb/K5JySfVxSAQz2izQo9zbIX9xm5e1uQlg==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr27057657wmj.144.1565614382150;
        Mon, 12 Aug 2019 05:53:02 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r16sm28288431wrc.81.2019.08.12.05.53.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:53:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] irq/irq_sim: try to improve the API
Date:   Mon, 12 Aug 2019 14:52:54 +0200
Message-Id: <20190812125256.9690-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the interrupt simulator exposes structures that don't need
to be public and has a helper that manually maps the simulator's irq
offsets to the global interrupt numberspace - something that should
be preferably handles by an irq_domain.

The first patch addresses the public structures: it moves them into
the relevant .c file and makes the init function return an opaque
pointer.

The second patch adds a linear irq_domain to the simulator and removes
the irq_sim_irqnum() routine. Users should now use the standard
irq_domain functions.

Both users of the irq_sim are converted at the same time as it's much
easier than trying to transition them step by step.

Tested both the gpio-mockup module as well as the iio_dummy_evgen.

Bartosz Golaszewski (2):
  irq/irq_sim: make the irq_sim structure opaque
  irq/irq_sim: use irq domain

 drivers/gpio/gpio-mockup.c          |  21 ++--
 drivers/iio/dummy/iio_dummy_evgen.c |  34 +++---
 include/linux/irq_sim.h             |  29 ++---
 kernel/irq/Kconfig                  |   1 +
 kernel/irq/irq_sim.c                | 177 ++++++++++++++++++----------
 5 files changed, 152 insertions(+), 110 deletions(-)

-- 
2.21.0

