Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74824F703
	for <lists+linux-iio@lfdr.de>; Mon, 24 Aug 2020 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgHXJHP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHXJGr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 05:06:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D1C061575;
        Mon, 24 Aug 2020 02:06:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i13so3344351pjv.0;
        Mon, 24 Aug 2020 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kp++64cFXoszqvdcGzZqbmMOiF0qCRzrPOcwqiRIH6Y=;
        b=TzrIr48FY0zex/ejY2gCW04OU2O1usoehaBy5gcEmmrUyUYbvqvI+3oKvhhZQp4kyQ
         mFTrCkSopwsB8H6TmtQZZFOpZmn282T/LKYkvzIZVfw3qherpuAR4bBMongjVlmYG+FK
         cXP4C3lgSid/wpWk8JJnip1Rh0EXubRSbPzTETF0EjBeJAq/SrwPiKzQ7pBBdf6Qm3Mm
         RHR+/V+FtgiCdlXbrFskyFGbtmiaJgZq3VAUvXokr3qrlYD2J9o/Tnpi5U/1GXTf6IG0
         zoKDxyPlRjXLC9/zrfeIMABcsYZ8a2d829BOikzJpw0MzVUBnyLgBxpd0FW9y7s7uF5s
         CDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kp++64cFXoszqvdcGzZqbmMOiF0qCRzrPOcwqiRIH6Y=;
        b=QGwzCqge6nL1cIDaUMMGkQnkp0mKYRjZXKLug7kelJaykUAJDqBbwFW9kFzZv3xdyy
         dIoo6PHE69H/rQgTF5PxaYnC0lhnKnUU7HdGFfdHZvUcseCjB0FHKseWZhG4Wq8CA+fC
         EaZHaA0TmuH8ztuRs6p/BDYHUv1dv2pYOawhQJQQyXiJzRiA/e6/Qw2t6AMHgfboUg4Y
         3hv3Uh5zOWAS1Xpy2T8EwCYBmlmV4ZT2K1Dj8tmVnUhTuOuHPjLOgp84/14hjLXa4Ezr
         g1Ur56OI0HVIGjXZvTEFztUiLrMFEgR8q38wNGmAZ6XeCLOjlbA+xkQUSex97QWXiRP7
         ZMsA==
X-Gm-Message-State: AOAM530UnBhblQIO60BGVtcO+0CRI6JLFbEMGvaq0KCBGCSkK+Hi8XoO
        7NQSTP1jjQgFlAWhRxDKYkCJrx1qagM=
X-Google-Smtp-Source: ABdhPJxc8UQkEFUD/7cHQQdo6BbNeb0PLjrl+ad28GepWqs3Ps+4ZyL+XjvIJB27Fk9NwthuMX9GJw==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr2939439pll.299.1598260003543;
        Mon, 24 Aug 2020 02:06:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:484:931d:1b34:35e8:fe10:8c7a])
        by smtp.gmail.com with ESMTPSA id c20sm9220988pjv.31.2020.08.24.02.06.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:06:43 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v3 0/2] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Mon, 24 Aug 2020 17:06:23 +0800
Message-Id: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In-Reply-To: 

This patch series add MT6360 ADC support contains driver and testing document

Gene Chen (2)
  iio: adc: mt6360: Add ADC driver for MT6360
  Documentation: ABI: testing: mt6360: Add ADC sysfs guideline

 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 |   83 ++++
 drivers/iio/adc/Kconfig                            |   11 
 drivers/iio/adc/Makefile                           |    1 
 drivers/iio/adc/mt6360-adc.c                       |  359 +++++++++++++++++++++
 4 files changed, 454 insertions(+)

changelogs between v1 & v2
 - adc: use IIO_CHAN_INFO_PROCESSED only
 - adc: use devm_iio_triggered_buffer_setup
 - adc: use use s64 to record timestamp

changelogs between v2 & v3
 - Rearrange include file order by alphabet
 - Set line length constraint below 100
 - Add Document for testing adc sysfs node guideline
 - Set compiler 64 bit aligned when handle iio timestamp

