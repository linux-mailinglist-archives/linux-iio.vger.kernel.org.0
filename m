Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05E725C41A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgICPDx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgICN60 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 09:58:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF7C061245;
        Thu,  3 Sep 2020 06:09:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so2273984pfg.13;
        Thu, 03 Sep 2020 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yX/ZjF2stJ6zUIzoHq+EMwZnUipKPIbfJHG6QJz9JI=;
        b=JMwsTCzvrDQwLOmw0ccOnaZRQRTV23TxWHlyGWHxhGyNOvv90fQ59WY4fkFveHVDAe
         sOAQy6zWgkUVpfRBNhWJNLz3p1njhOR/qhontH61eeeoafNS+jVRsV0Ftz9v5q+TO9sK
         mcMuljRxqvLjJw4lQa0YgCsAGyQ3Mm+DDWh4SehY/Z0D91ozKvnAgoqLhGfx8q7f+51H
         AFREE4dBDL1ndnOQuAnDfgHi+4/d7ArS4cpZ9SA1egc9P2RP9u60TwLpKeTXsYlZQBTe
         166I4cx1yDGBlm3V7htEnicJfpUrxKJ/ZxDh0gKMmbyBZi/ngFXDCFl3Q8FPxQmcH665
         yvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yX/ZjF2stJ6zUIzoHq+EMwZnUipKPIbfJHG6QJz9JI=;
        b=MHQZlCfnwidSCEFEQYT5G82q5JeBp8eJQnzirUl8Eo9GTeh13hoVtxpBtkTCD7XRt0
         QDXr2nKiSkKve+0BVqaw9dQGAzbHH2RJz61/Zd9S2mBlENvUZsij6zqMUOgcgeC5aF5z
         ah99JBUHw0/W0wd2z5GKkIg4hKbN6MgrEWKeK3xwcborGnrUiIJIYvwR1z/nMgKrX59p
         TRKdEr6mSa5eQgBt9jsKXOEANRPKIG/EBiEWSHRQUstBQ/T5K+kBs2NCzm4UHOVuXJvk
         Qmq1SrOcAhn7B3+rDYH1F0nILTKU2X+qQBouyCtXdfbpIu2xydaM1AY6tYKqKbO/MpoD
         fLyA==
X-Gm-Message-State: AOAM530xfk+QIcN+cwdexuwsE1sB2YiLH6U8nyMexW1ZjlVCpZHZ9OMu
        7fsj2nUtml7jAutcy2qLsrs=
X-Google-Smtp-Source: ABdhPJx1bWyYPq8pBWWBnVHh8UHHaCZRjqVBVgevzkBqhZX8o6P0nKReuy0aotNxP7BMmgS8hNP1rw==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr3763933pfh.125.1599138596606;
        Thu, 03 Sep 2020 06:09:56 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6085:e35d:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id x22sm3145297pfn.41.2020.09.03.06.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:09:56 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v2 0/3] iio: gyro: adxrs290: Add triggered buffer & debugfs support
Date:   Thu,  3 Sep 2020 18:39:47 +0530
Message-Id: <20200903130950.6274-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
data capture. Additionally, add support for direct register access using the debugfs 
iio interface. 

The device-tree bindings documentation illustrates an example of using a GPIO irq
line to trigger a data capture.

Nishant Malpani (3):
  iio: gyro: adxrs290: Add triggered buffer support
  dt-bindings: iio: gyro: adxrs290: Add interrupts support
  iio: gyro: adxrs290: Add debugfs register access support

 .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   7 +
 drivers/iio/gyro/Kconfig                      |   2 +
 drivers/iio/gyro/adxrs290.c                   | 284 +++++++++++++++++-
 3 files changed, 279 insertions(+), 14 deletions(-)

-- 
2.20.1

