Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFFD39E4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJKHSP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 03:18:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHSP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 03:18:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so8772457lje.4
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TW+PLt/pSUV2wrGRLdYwDBIkex2L7z52jP43eXVTR34=;
        b=jEOOV3DVO2jCert2r72y6DLmdhDZ2n2cXjcE8dJACddUatD07EUupXLiQ49/76/nI/
         ba2dinCCbMJYywHugscz7LQ9GAVb657oPqZCaPZ2tJ+DamsadENsQhCgdHFE8SVrrl0C
         o4Qf3Bk52uqzr2qz0SIf00yz78IsmuK7uGg3Vk+DibywP64MujYUejGw6NmUCS6ceqLr
         P40zeO+1YyFekVs8k0f7ZC/YCt69WWo1gUEXMomKAhnAesJF4WGQw/aLsG1qQZ/eb4yA
         hDonE6Yc3rHWjmS6JTRmQLJSFI0IDYwcQwA1HZjmK7Kec/7g10Uc18VgPNZsKzp/UVmM
         4zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TW+PLt/pSUV2wrGRLdYwDBIkex2L7z52jP43eXVTR34=;
        b=C/xb0oZncQcjq+I9S/dEqFQ78hNWP9PvJCPjNB8ZdNVRkBij1JFnRkPWOmCdCB6Lyy
         53pZtbPO4OwK1Un8oiZNLG02c/Mntc5m7wZlULirpEaqvVw/1kG16DnxQhAeeq14dgge
         mR3mjBdO4jA6Dgp8/Kw8qv1OTDKWFaIS6dl+kx01GMyisUBJU/UrbzAJHutlSE3JpdCh
         G+QUuMuOfSTi3F4cLD536afQ1z+yqoyQ/5HeFGPwz1t8yXNoAaQgHY0Ak16W8ExsDqX2
         hfw1ZJ/plKGP1n78wxivPVp/XD1jgvLkr2+ri0NxCmHkDNXVAiU3nv3N8IrP5Eizn3S2
         wuoA==
X-Gm-Message-State: APjAAAVFxwVyWHRI4/AzH5kAoY8K1oyGS1Wfwrkub3YAGbHCUoDBwSJf
        s5XrVuPm8VgW/nfkB32jeL6Ee/hFR6M=
X-Google-Smtp-Source: APXvYqwr2Ha+jgW4UcgbLRWjSC1DDQCjbMn4OfruPaq0/WSgOjNcR4arIQiaItmX4Zl7UNXCAlO1IA==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr8765224ljn.49.1570778291904;
        Fri, 11 Oct 2019 00:18:11 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v26sm2047343lfg.27.2019.10.11.00.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:18:10 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/7 v4] AB8500 GPADC MFD to IIO conversion
Date:   Fri, 11 Oct 2019 09:17:58 +0200
Message-Id: <20191011071805.5554-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This version should cover Jonathans comments on v2,
and Rob's comments on missing DT changes in v3 and
be ripe for early merge for v5.5.

Jonathan, do you want to queue them in your tree?

When Lee applies series like this he usually puts them
on an isolated immutable branch that he then pulls
into his own tree and offer to other subsystems.
It's a good idea I think but maybe you have other
ways of working.

Linus Walleij (7):
  power: supply: ab8500_btemp: convert to IIO ADC
  power: supply: ab8500_charger: convert to IIO ADC
  power: supply: ab8500_fg: convert to IIO ADC
  hwmon: ab8500: convert to IIO ADC
  mfd: ab8500: augment DT bindings
  iio: adc: New driver for the AB8500 GPADC
  mfd: Switch the AB8500 GPADC to IIO

 .../devicetree/bindings/mfd/ab8500.txt        |  119 ++
 MAINTAINERS                                   |    1 +
 drivers/hwmon/Kconfig                         |    3 +-
 drivers/hwmon/ab8500.c                        |   65 +-
 drivers/iio/adc/Kconfig                       |   10 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ab8500-gpadc.c                | 1218 +++++++++++++++++
 drivers/mfd/Kconfig                           |    7 -
 drivers/mfd/Makefile                          |    1 -
 drivers/mfd/ab8500-debugfs.c                  |  715 ----------
 drivers/mfd/ab8500-gpadc.c                    | 1075 ---------------
 drivers/power/supply/Kconfig                  |    2 +-
 drivers/power/supply/ab8500_btemp.c           |   41 +-
 drivers/power/supply/ab8500_charger.c         |   78 +-
 drivers/power/supply/ab8500_fg.c              |   23 +-
 include/linux/mfd/abx500/ab8500-gpadc.h       |   75 -
 16 files changed, 1495 insertions(+), 1939 deletions(-)
 create mode 100644 drivers/iio/adc/ab8500-gpadc.c
 delete mode 100644 drivers/mfd/ab8500-gpadc.c
 delete mode 100644 include/linux/mfd/abx500/ab8500-gpadc.h

-- 
2.21.0

