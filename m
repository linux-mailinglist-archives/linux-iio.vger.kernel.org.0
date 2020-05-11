Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDC1CCFC4
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 04:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgEKCcX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 22:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729220AbgEKCcX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 May 2020 22:32:23 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B3C061A0E
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2020 19:32:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h4so7742397ljg.12
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2020 19:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt9DC6beLMtJXhLa86he9PEK95AdZPBXDpzUIeyyC/Q=;
        b=YxWqMJilIknI002HOBPlOvzl8nDgFWeqBconsWgwf6dkoleqyA1JWO/Azccuma8A4H
         lxzZieXwLFeJQYjqqeDkzkdkdvVAtHB4YHkzsIIjcKlvaau06ybtcPmtVJr5ul8fYp03
         Mb+A7qScCBw5OKRAUIEx6xoz8+9LA40WfGWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt9DC6beLMtJXhLa86he9PEK95AdZPBXDpzUIeyyC/Q=;
        b=cxXSFqni7twTaa5mIwDeUOVscrgGvW8SaQXvcXS8UNKDbrMVmT/2lwkhyhNqzkm3T+
         Sr0qb51HWQPj21+U3cslr9rSjPWSEGUFRU1lR3qIomzSus7f+bnMf+a2tetg7IZ4l8Uz
         ZSKS2UC0EK2jtDzfluL5P+74vmlSPabVCVa7+yckiTwkLDs/s+V3XqEkzaAHMMLdJtQS
         Tsxn6X2SomUAv4X21I8sMTgt9Yo0MLXkl5L9ssWaVk10XIPwJLaWgep5ugyz7Xt5DxKZ
         bP83PgDA06O0+OdLiH8ZLlfGm2rfgBIEPtTK/sd643BAme5D1zZ01/ytmTft0dMG+lE4
         7hSA==
X-Gm-Message-State: AOAM530ZQrda2ka/qUzM3vewyvUI5eeswWKwRw8YyRKHphPCBD5RzrTh
        lewUNoPNo1+4rezCrCIuOvwfgZ4wO9U=
X-Google-Smtp-Source: ABdhPJyxzX7GBZ/zF9HAqo7hFG2Jx4pkgtia93bl+1PNVr5nMh/Ltw1jpFtp4XFLeSg0U0aR2u7jpw==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr8488418ljl.235.1589164339070;
        Sun, 10 May 2020 19:32:19 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id p6sm8624051lfc.15.2020.05.10.19.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 19:32:18 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 0/2] iio: chemical: add atlas-ezo-sensor initial support
Date:   Mon, 11 May 2020 05:32:12 +0300
Message-Id: <20200511023214.14704-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver for Alas Scientific EZO sensors with initial support for CO2
sensors.

Changes from v1:
* add comments to mutex
* change IIO_CHAN_INFO_SCALE return from IIO_VAL_FRACTIONAL
  to VAL_INT_PLUS_MICRO
* fix return path atlas_ezo_read_raw() to EINVAL in correct locations

Matt Ranostay (2):
  dt-bindings: iio: chemical: add CO2 EZO module documentation
  iio: chemical: add atlas-ezo-sensor initial support

 .../bindings/iio/chemical/atlas,sensor.yaml   |   6 +-
 drivers/iio/chemical/Kconfig                  |  11 ++
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/atlas-ezo-sensor.c       | 178 ++++++++++++++++++
 4 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/chemical/atlas-ezo-sensor.c

-- 
2.20.1

