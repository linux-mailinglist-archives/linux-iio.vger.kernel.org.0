Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3671400502
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 20:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhICSoX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhICSoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 14:44:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE3C061575;
        Fri,  3 Sep 2021 11:43:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so149284pjc.3;
        Fri, 03 Sep 2021 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tpi8gyFyj5VpTnZoBG4Oo2D6JwHdJqYw0FK7xkT/ZPk=;
        b=JjBjKf+w3FKVsYZRuWlFhfFGpyWxOPiFYdXgEKnUncRCp5gGVoYECZ9Vv1UuEj0IS2
         r2C+l56HOf3KoeAqk4c4EKvyckBiSdZ6Zw+VRLwkbY+L2mtXY4oAsvGYhG9+Io+s1bb8
         v1wQ1IhCE0isuTkEr9SoYtsFpTv6fo2NA6CJN2+SQbpxdw4c5n6ElVRae3Oefm+B+Jn1
         e2tZEbyrw0gHno+xfcjmVT1sYIWOIXhhfCz51U06eWSAXo9esjvBKxc1XIqtB6tGDASt
         4RAcPj24n0X/LNIs9belza6oIFSM0JzRSx0PX4mN8eyJ9/Tupmb4jA4qL4PZQ72l7M8g
         7x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tpi8gyFyj5VpTnZoBG4Oo2D6JwHdJqYw0FK7xkT/ZPk=;
        b=UYBC1zjuTdM8yICJc00Ay+GYdSwB+xL4fh2Mpo9oRUXUvlBx+QcZADKxa1RFbtq3A8
         AAeQlJkOHttz/NfGC1QDda/UStN+60uQW8DgMijP9TRavdHmXJqgigYSE1PE5DBzWPbu
         KBjP6vjOWRggmZeOWHcAuRSqmnZ8u5jjZNBqgw1hdBpPBDAivyiydSQonyxvjBN+JYNt
         Uco38+x7+E8oj8o1M7uPZARNK4GG6h59G+Z1gpoY2MdNvzlIgUtYwuAY+msA8dDRX0uL
         HiemaJuPt/aArrt7MGnQkiMuBoaTPhsd5ry77oAEv41UqpiOz4Um837TB46h+VyZpdlR
         OZxw==
X-Gm-Message-State: AOAM531Oe11/PMGd+Gj3zmBT5jv/G2CTtNMNaSSD06QBw9sl/85Jr+N7
        rgLtJhi5/ESe9MFQTB92ieY=
X-Google-Smtp-Source: ABdhPJwSWngReppB9noKfmUx5uhSGdCrVb0+HeHYDzWH1XlzZxNBA/Tr3zhDL0lXNzrLHaA82sBwyg==
X-Received: by 2002:a17:90a:aa17:: with SMTP id k23mr334913pjq.47.1630694601825;
        Fri, 03 Sep 2021 11:43:21 -0700 (PDT)
Received: from localhost.localdomain ([49.156.122.119])
        by smtp.googlemail.com with ESMTPSA id h4sm128186pjs.2.2021.09.03.11.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:43:21 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     jic23@kernel.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 0/2] adxl355: Add triggered buffer support
Date:   Sat,  4 Sep 2021 00:13:10 +0530
Message-Id: <20210903184312.21009-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds triggered buffer support to the ADXL355 Accelerometer.

Changes since v1:
1. Make separate patch for if(ret) change.
2. Correct spelling mistake.
3. Send irq to probe directly and not save it in data.

Puranjay Mohan (2):
  iio: accel: adxl355: use if(ret) in place of ret < 0
  iio: accel: adxl355: Add triggered buffer support

 drivers/iio/accel/Kconfig        |   4 +
 drivers/iio/accel/adxl355_core.c | 155 ++++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 2 deletions(-)

-- 
2.30.1

