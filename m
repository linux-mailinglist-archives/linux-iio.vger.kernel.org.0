Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5CC3092CD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhA3JBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 04:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhA3FFK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2021 00:05:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32837C06178A;
        Fri, 29 Jan 2021 18:37:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id f63so7376869pfa.13;
        Fri, 29 Jan 2021 18:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5UTE8MGehAeLSDJJuM/ANL9sawXrZcl3KgAUdky82w=;
        b=mXXUdh9LDUOdYDBM3Vo6Gi/gG974DY6z1uBtJe5YmvQ2MpNVcVJ0bJhbqKFdvnaHc8
         5uRHP5KBzQB888HEg4MkF3fnYbeBCUOEwLU0STyGrU6/5Jy6GhkDhUL/NwxIgc3NafBq
         2xJ0J2DGztIBEAOn9xdRhkhj5/DVVvFakq+VQDD1h/PIZPlK3evcFtRKpRfMLNRALLsb
         hFi0sjk98YtrfdMnFGfazQXPyLSgSx+FvsK2ekegb5uKfNb6t9+dg0jTfzhE2dlV6XI3
         kqum1b3+tdfyXjKUQ5OMdAcDTdokF7Dd6wk9+ZEp0vVGHWIsDlSzgMKKLFi5O8XPVkQM
         2Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5UTE8MGehAeLSDJJuM/ANL9sawXrZcl3KgAUdky82w=;
        b=AnqC4qg8Pn5dXn8x3uC+2dADPfe4hNRdgVxa+a7Q06fZKEfzh82wcUGwyy6lUxgYfa
         y/VB3ig+yibT2fwsYGTmoGWXnlsmyxHv2Y3CFWe7rLyvgYCzwatU5hg5vKYh6Gw0IbX+
         i6BRlGVKyQJdhcQ2mmRAalAHYa7SFYopJS0PrQfJk4XSVvQCK2X0u0mrHKkTSlBn5VFE
         vHmU3gXMMaDrVTO7kkeMSlziA+2va8HHpqBEQvYcTv5hNheBcwpDLychYIAaEAQ/5Kz9
         JBbU7Jz3GjQmIzYdYYgJKuy4ZxROGgTuATaINN1ECV5PQNfPTFq4FTJN+sp6nGWDFfFP
         g3lQ==
X-Gm-Message-State: AOAM5308A2wHebak0+ciZ+AaPAcpoVcKm2RQeJ6Yu9v0rFjZa2FTcNwZ
        cZziv5XxDZtFpDxeIvM6ffw=
X-Google-Smtp-Source: ABdhPJx+8G3vs7Jv/xcliAxAeooCUbGAN+bIk+/u5lkzzzjIUC8R2pCiKBmK8wEtGES/eNRdlMopMA==
X-Received: by 2002:a65:6547:: with SMTP id a7mr7268812pgw.50.1611974235000;
        Fri, 29 Jan 2021 18:37:15 -0800 (PST)
Received: from localhost.localdomain (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id s21sm8872169pjz.13.2021.01.29.18.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 18:37:14 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org, fabrice.gasnier@foss.st.com
Cc:     fabrice.gasnier@st.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, benjamin.gaignard@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 0/2] Remove the IIO counter ABI
Date:   Sat, 30 Jan 2021 11:37:02 +0900
Message-Id: <cover.1611973018.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v2:
 - Add missing argument to devm_kzalloc() call in quad8_probe().
 - Remove superfluous 'err' variable from quad8_probe().

The IIO counter driver has been superseded by the Counter subsystem as
discussed in [1]. This patchset removes the IIO counter ABI code and
documentation.

A patch to remove the IIO counter ABI code from the stm32-lptimer-cnt
counter driver has been submitted to the list separately [2]; if you
would like me to combine it with this patchset, please let me know.

One final user of the IIO counter ABI code is still remaining for now:
drivers/iio/trigger/stm32-timer-trigger.c. Is this driver related to the
drivers/counter/stm32-timer-cnt.c driver? Can it be migrated to the
Counter subsystem ABI instead?

[1] https://lore.kernel.org/lkml/20210119104105.000010df@Huawei.com/
[2] https://marc.info/?l=linux-arm-kernel&m=161192667926697

William Breathitt Gray (2):
  counter: 104-quad-8: Remove IIO counter ABI
  iio: Remove the IIO counter ABI documentation

 Documentation/ABI/testing/sysfs-bus-iio       |  40 --
 .../testing/sysfs-bus-iio-counter-104-quad-8  | 133 ----
 MAINTAINERS                                   |   1 -
 drivers/counter/104-quad-8.c                  | 653 ++----------------
 drivers/counter/Kconfig                       |   2 +-
 5 files changed, 65 insertions(+), 764 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8

-- 
2.30.0

