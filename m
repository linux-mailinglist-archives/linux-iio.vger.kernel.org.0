Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BEF3511BE
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 11:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhDAJRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhDAJRB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 05:17:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA0C0613E6;
        Thu,  1 Apr 2021 02:17:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w10so1186138pgh.5;
        Thu, 01 Apr 2021 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u6qJZVH5i4Q7j4O++ZrOAMtKLGfb9nrQNFF7+p8Qy8o=;
        b=Z0t+6RFl4ECTrFAKZGOtG32BqZRM61gwjFWCWkSoEzX7+u0s/qZAm664nkX+69daLe
         K688KGPwuT0c1FarKnszPcFiEfCFYW5teYI42TkjGPIcf50yQ1FAGlbWM472eT91WOx2
         e9hEG5KSwlbvGAwL5dOWe8Rk7KN6OXynalYKRDPr3sJNsDlpzkrONrDjF2gIEiobJ3MC
         wEItWY7KKL3Pcy69IkzXwhyEyeF9nYU7PxoBPH0Lr8ZkEkqLedsRajg8fcrm936mKNas
         KVsA9wUqseYQVagX5JYizSVv5Z86gJBA8BhaZNHsE4yKpMLz5f883n8jK+WbIevp+gFY
         OIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u6qJZVH5i4Q7j4O++ZrOAMtKLGfb9nrQNFF7+p8Qy8o=;
        b=j1gouBibKD14NwCj4EE5I4gxNfxXwYMI4EvhTE1O3KVK210zbRMBo0rNQZwtnWAawc
         B++raY7uTy9gLA24hij1XUgro/shlz0rXAwDwwHW+dB+rw+t5oTtRyGP5DEgEKEY3oIC
         GL6RBSTfrP3IV8YWtD0f55lDNysIqzUFocoN3PV5I95GCQc6AOjf7e8Fe1SDyowLoqfh
         gxTQTBT0e2XH8l8rBArJ9RXQHm2QnVBMr5hVENiJN044olRTtwsv8PdtLRGarNXHF+rU
         YHrsWND/je2ZgRUHFnxoDiBGo0BQT7yA7COBJNR6tOpl/ebrzwRBbLA9v8oDOliaipho
         ERCg==
X-Gm-Message-State: AOAM5304fpSczQ/NvR4jpMQqZnCMrMIlBcFXxiVa2ISksBqeyhlrMbOT
        rIhdYoYcdT2awmQBPBKD4ds=
X-Google-Smtp-Source: ABdhPJzGxVglJogtffkeRZNDNT4BXwCQyg+Sd1zZxEA0te+g4Wa3RSjrNqvmdYT0++JlDUpeDGGuUg==
X-Received: by 2002:a63:504a:: with SMTP id q10mr6591261pgl.188.1617268621034;
        Thu, 01 Apr 2021 02:17:01 -0700 (PDT)
Received: from localhost.localdomain ([49.156.72.145])
        by smtp.googlemail.com with ESMTPSA id q8sm4897044pgn.22.2021.04.01.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:17:00 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 0/2] iio: temperature: add support for tmp117
Date:   Thu,  1 Apr 2021 14:46:46 +0530
Message-Id: <20210401091648.87421-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for tmp117 sensor.

Changes since v1:
1. Remove unused headers
2. Add error checking in i2c read/write.
3. Correct DT bindings.
4. Correct implementation to return tmp in milli celcius.
5. Remove unused mutex lock.
6. Modify MAINTAINERS.
Changes since v0:
1. Correct Yaml syntax.
2. Change IIO_CHAN_INFO_OFFSET to IIO_CHAN_INFO_CALIBBIAS.
3. Implement IIO_CHAN_INFO_SCALE.
4. Use devm_iio_device_register().
5. Remove unused headers like delay.h

Puranjay Mohan (2):
  dt-bindings: iio: temperature: Add DT bindings for TMP117
  iio: temperature: add driver support for ti tmp117

 .../bindings/iio/temperature/ti,tmp117.yaml   |  34 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/tmp117.c              | 179 ++++++++++++++++++
 5 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
 create mode 100644 drivers/iio/temperature/tmp117.c

-- 
2.30.1

