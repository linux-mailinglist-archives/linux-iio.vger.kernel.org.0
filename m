Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5144B3C0
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbhKIUMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 15:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244155AbhKIUL7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 15:11:59 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC52C061764;
        Tue,  9 Nov 2021 12:09:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n8so614670plf.4;
        Tue, 09 Nov 2021 12:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jHOBwgk7CygldU9JMNVpuRaDAV/j7iK1C6bIJrdBx8=;
        b=ajfJrf22Dke3yVXyY1X9U/IubgRPx38qzfp/Z5fWd/u1oP1+6Sr3Gs1hfr2DuXXsSA
         jyP4hvFSqMJKCmChAUL6V5V4EHiw0jxiSX1VR/vluDqGjHyIw8k7ok2pLBfh37VcSGuI
         bF76rpDBw7ZNo1zm16MU36V3LPsdsPuuUcmnk1Y72GvtgARZ+YPAmwKOVX4EJog9YRG0
         U8ti2ELr09ZiubL7lQ8FvjAy1HZ6Yb9Vuma2pwftEqjZyFOnAZQd9+sdWJL/evPipapP
         zfvco6Q6kfIqorJ1viyImyV5zYp1LVFTcMbK4alwI8rvxcXu9/WfKqPstVDI4GcI4oQj
         om5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jHOBwgk7CygldU9JMNVpuRaDAV/j7iK1C6bIJrdBx8=;
        b=AdwXAN4YSMjGi7hxh2OMH5RuzT8dvZBj7UNxwmt+ttGu8okxsVQL3Ct6BOyXLDwduH
         sL6wmRnxqjheJilHN+PCa+jeXmacBnZRi122/Z9evppJrHtjWqhwsgdTKFerdbjYH5O3
         RfSPd6m7ZGyFADdmQkz4vrQAFsc4HNcKoxYFc378YJs822yiDdJl+msA6nj68Vb3Yhjt
         1fnz/NTFEApqrLe0YyAVf+GitwGO2/c7PphgA1BKAjNxRnChiiXNBz2S4PPbOlJxfh6U
         FGxb6iQmbM5HnO5A5T1O+9jQlmvZx2vAkQtDr+6wFByvyqH+4mGz0Vl8pRhlz77O9PUB
         XGzg==
X-Gm-Message-State: AOAM531jg4HvDTE7+/5v7/Vh0e02zSYIma0EvruiqgMwupiv+qYKEfRz
        kr1eHVsfTqnCksYurrF2IUY=
X-Google-Smtp-Source: ABdhPJwhIBc/8jKwd7nFGat0y4KPvl8W1zNVSMY7appSq6oFnOX2aMWxa9mBtnA3U/dZa2yNe7C4YA==
X-Received: by 2002:a17:90b:38c5:: with SMTP id nn5mr10079324pjb.220.1636488553080;
        Tue, 09 Nov 2021 12:09:13 -0800 (PST)
Received: from localhost.localdomain ([27.255.248.134])
        by smtp.googlemail.com with ESMTPSA id q10sm3103095pjd.0.2021.11.09.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:09:12 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        kuba@kernel.org, saravanak@google.com,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 0/2] device property: Adding fwnode_irq_get_byname()
Date:   Wed, 10 Nov 2021 01:38:38 +0530
Message-Id: <20211109200840.135019-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The first patch in this series adds the fwnode_irq_get_byname() which is
the generic version of the of_irq_get_byname(). It is used to get the
IRQ number from name of the interrupt.

The second patch in this series uses the fwnode_irq_get_byname()
function in the IIO driver of the ADXL355 accelerometer. The driver has
been tested after applying this patch on a Raspberry PI. The ADXL355 was
connected to the Raspberry Pi using I2C and fwnode_irq_get_byname() was
used to get the IRQ number for the "DRDY" interrupt. Earlier this driver
was using of_irq_get_byname() to get this IRQ number.

Puranjay Mohan (2):
  device property: Add fwnode_irq_get_byname()
  iio: accel: adxl355: use fwnode_irq_get_byname()

 drivers/base/property.c          | 23 +++++++++++++++++++++++
 drivers/iio/accel/adxl355_core.c |  7 ++-----
 include/linux/property.h         |  2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.30.1

