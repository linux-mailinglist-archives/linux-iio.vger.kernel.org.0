Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FC342BC6
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCTLMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhCTLMM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:12:12 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0FC0604DE;
        Sat, 20 Mar 2021 04:03:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d10so6339232qve.7;
        Sat, 20 Mar 2021 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZzj46gdosOLw0EL2LXzmG/fnO4cUgRGzrV+JP+y1fM=;
        b=hS8+mXA9LLv0oNv5zyX2DD/vzBNw05nWXWf/n2oSDDeMduQuHUGMOckBBym7QYov2o
         STv+9u6oo9DafazCisc/FCi9wuJsCUYMzN1NUsN/5vQTqoSxybXe8E++cI2BUU5tJIsd
         7jI1hMg4TdSmLiBhLGBs4YRfNGlRJCNZzLDpbVNCxczALopsk3GsOUyJ4aWT26eI3M76
         HCq6jamENEc0pYEV3HHAgqCZlPWX/VINNe0ogmt9hdmlsKsFy1SXfrRSnL43oIWx0uCc
         //cZXcGmKuqdo/lAi9WKAv2LY3HlFuTeT7gjpEgRCmncKK43bf5nuA9FCpY43bYCeWVa
         NeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZzj46gdosOLw0EL2LXzmG/fnO4cUgRGzrV+JP+y1fM=;
        b=VSAzbQXUxgYR7U5m5SbBzDo+d6VNx/F3iSSJeLPbLpS8ynKw2+cpzdBpA4LXJniEcb
         YYH8UKGyDLHo9KWIidE34JIIqLK6ldeqRkg4/I+2M3orBq/Y7VZJHgSKoy8TKkSLj6j1
         XBlSWoGnl3DjQS1eUVj0VnVpjdPk7sC5O+lTJEcutg1NBDjHMWWBKtOewdm7ynGsx6tn
         YstoJCJ4F6AlcTL+nXrbE1VKlF0m+WlLRUFt13Px83UwLscMyb20gxlzAPPJoEWDfkSr
         TyRrKL2y1DtTbgn86PSzmqAz+dqeBjcrNmWftHFO/fawDAjNZxUJjXJKPcoTVL3ap/7C
         1E9w==
X-Gm-Message-State: AOAM533vXKiCiqli/P5NGYO6ZdUcZ1fVW4gJo8MuBPZfVD+Og94VD+i4
        0RSkC9qe4PkeOOigfQS//sz+QVUgg6ksQw==
X-Google-Smtp-Source: ABdhPJyHK0OLD5WHbRtP9JD6DEV09FD6K7602/H71RzMgGxG6fZSesG5unV3EUBQ2XphYIE/iAMgrg==
X-Received: by 2002:a17:902:c20b:b029:e6:a94a:a865 with SMTP id 11-20020a170902c20bb02900e6a94aa865mr17519245pll.41.1616222718710;
        Fri, 19 Mar 2021 23:45:18 -0700 (PDT)
Received: from localhost.localdomain ([27.255.177.158])
        by smtp.googlemail.com with ESMTPSA id f15sm7237887pgr.90.2021.03.19.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 23:45:17 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v1 0/2] iio: temperature: add support for tmp117
Date:   Sat, 20 Mar 2021 12:15:07 +0530
Message-Id: <20210320064509.119878-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for tmp117 sensor.

Changes since v0:
1. Correct Yaml syntax.
2. Change IIO_CHAN_INFO_OFFSET to IIO_CHAN_INFO_CALIBBIAS.
3. Implement IIO_CHAN_INFO_SCALE.
4. Use devm_iio_device_register().
5. Remove unused headers like delay.h

Puranjay Mohan (2):
  dt-bindings: iio: temperature: Add DT bindings for TMP117
  iio: temperature: add driver support for ti tmp117

 .../bindings/iio/temperature/ti,tmp117.yaml   |  27 +++
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/tmp117.c              | 182 ++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
 create mode 100644 drivers/iio/temperature/tmp117.c

-- 
2.30.1

