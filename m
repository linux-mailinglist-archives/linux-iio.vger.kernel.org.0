Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2773BBC607
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389971AbfIXK5q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 06:57:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406623AbfIXK5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 06:57:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so1137585pfw.2;
        Tue, 24 Sep 2019 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qlJPjtqwH4SH4+kSPRq33RCq3tnW7zeL3j/StA+vARE=;
        b=VAqeqQfs5vp8XcbvrzPXOHLl9wsuwAigfKHOkb7U0V2zK7BxUFOcXaPEps0+4Hf7gY
         ckR+vHTaPFN58C0YhPLLi9BJ7aGmt3IMSbFVt2MKyt7dA6x3U+RNV6AUydLpOksvcAvV
         hUiuKjMFRtNToW5jMRJUIEaivWgehDkCd/ftgXNa5VbnK7ZyNy/T8aynJ3N5HhPlzeRg
         u4mh8XwqP7cnPKP1lTz7zR+pN35/4Y/yBVbmDy5Diphwjrkc3TJhMcsXzwIhTnlquw2C
         DLF5Y03beyk5FVCSyB3qWWHi3qi1eHBCd4pn55fwCNZzc4lBasIetioc6jONHnuOJ53z
         7zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qlJPjtqwH4SH4+kSPRq33RCq3tnW7zeL3j/StA+vARE=;
        b=Er5qfXvIpVoUqbXDw/dM+JoA2GlHSUZFFY2Gx/NMCH3blPHwnRDHVmpd5dYfQ37T/2
         msgWNGmQomi6HF1aCNyG0cVB61eqBZKtPrTi/c4V4Fvvki45aMtQwAcdaHdOkkVNhGjc
         SpaCSkI2m4qrdFTCa27FnBxPNlXlKs2ZYescH8UELCRD3K88LjvLeKz5PGIchLC3Jw/p
         rRs6X5Q8L6QBWIkSTsYyL8V+XtLkngLiCP42VQSXT9fNkikt7uNBxTQwuP4YnMCejnQv
         DlPTShRoirz5vxFljksbTtssHcI9JE0nLjhC8OfSntTBWA/jwRfh43iZ4pBncdQTBFJh
         Y6Eg==
X-Gm-Message-State: APjAAAXUPZi1bVXSIGA/bxkwrOV+HeTyhjHBUjwCWYDqvmtQ6OiHXRcQ
        hninxGNpbxKkTWcrSKjDJm8=
X-Google-Smtp-Source: APXvYqycUMIsr6AV985kDVUj8M6zg9Zv8d9B6Ibt25Nd/KMxcvkkvEp7mqyYzEQ+8DvaQ3ihqSh+8A==
X-Received: by 2002:a65:5043:: with SMTP id k3mr2559662pgo.406.1569322665098;
        Tue, 24 Sep 2019 03:57:45 -0700 (PDT)
Received: from localhost.localdomain ([106.51.110.135])
        by smtp.gmail.com with ESMTPSA id c125sm1953886pfa.107.2019.09.24.03.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 03:57:44 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com,
        Rishi Gupta <gupt21@gmail.com>
Subject: [RESEND PATCH v2 0/3] Add driver for veml6030 ambient light sensor
Date:   Tue, 24 Sep 2019 16:21:55 +0530
Message-Id: <cover.1569321085.git.gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The veml6030 is an ambient light sensor from vishay and
is a different hardware from an existing hardware for which
driver currently exist, therefore this driver submission.

* All features; ALS, white channel & power management is
  supported.

* All configurable parameters are supported through standard
  iio sysfs entries. User space can get valid values of any
  parameter (xx_available) and then can write to appropriate
  sysfs entry.

* User space can get ALS & White channel readings through RAW
  IIO interface.

* IIO events are used to notify application whenever threshold
  is crossed. This uses IRQ pin of veml6030.

* Some registers in veml6030 are read only. For these registers
  read callback returns error to user space.

There are 3 patches for this submission:
[PATCH 1/3] iio: light: add driver for veml6030 ambient light sensor
[PATCH 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
[PATCH 3/3] iio: documentation: light: Add veml6030 sysfs documentation

Rishi Gupta (3):
  iio: light: add driver for veml6030 ambient light sensor
  dt-bindings: iio: light: add veml6030 ALS bindings
  iio: documentation: light: Add veml6030 sysfs documentation

 .../ABI/testing/sysfs-bus-iio-light-veml6030       |  49 ++
 .../devicetree/bindings/iio/light/veml6030.yaml    |  62 ++
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml6030.c                       | 633 +++++++++++++++++++++
 5 files changed, 756 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
 create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
 create mode 100644 drivers/iio/light/veml6030.c

-- 
2.7.4

