Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD999761
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfHVOwj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 10:52:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43911 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbfHVOwj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2019 10:52:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so4735373lfm.10
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2019 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZ4yg2CqQWFZ6u9v2GeaK3WZzj4t516jSQ1lmsTEkhc=;
        b=tVwWc0nMesN30p/71w9mUFS25/37yvAh9objNeIKfHmuF9s8rZLEmEi63P65OjU9kA
         4M7vr46pdzjrL8QNsSk/fRfUDJiYXRx24ltXTKYnG58oMdqGlulZyegBF4BqhVxevmms
         C2gQwUlfQmdrNwk38d37a6qbuZkVi+dDzTv3Et516tfU20nhODYZQ+X4iyTGXEXdGzeR
         UsZgw4LZttEF1SMSwv5kP1Y/2PqFmjxtDg/1K3pxgLa2GMyP5iUY+jAeANrwDqWFkmBD
         y9vcQ+J5W4nO/I/d9RFRL4LyHl48wfxKqJdTL6Vp+1GfKZfWGMMuNK8WLnGv09PPFZzk
         O9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZ4yg2CqQWFZ6u9v2GeaK3WZzj4t516jSQ1lmsTEkhc=;
        b=dKgJHGIcZyM+RqRFArTk+zhwPbcuDm9LlnWEQq2ajamI18zVjND0IRpWG0elRZ4Au7
         q6dM6d1+MFPt6cRuO2T1AJ+qIAgvxGhYxoFBNskwOSWOOe5qWYWmsy09MfqNM/UJoLIC
         uFGYrK9p32e/spkdG7jIgJQwlB1+3qw/S2Yp+VFYw5CrZBcuyF42rqqNPHV9QOFWdtLd
         ioY68H/ujFLNb0s7x3zw0n0AeI9BkKHuIeGlbH5MQwmOIJsjSMtHvZhH25S3UBnB6Sxz
         7TZKzvujyS1iCUbnTrrVRpu9eVKBLb+xu+M+QlTHcjXAxQ9mmASyDEyD2KHcpNjUinP8
         fp/w==
X-Gm-Message-State: APjAAAV9AknmOzC1fWzusTQ4qn8rAsjb7hV84ozXhuiUzmx951F+Vlc/
        MmEGHsTLNwGCpQLP1YLizqZxVg==
X-Google-Smtp-Source: APXvYqxI3ZuHO6gz1ebpVGfqXWCcECauBFCXFP7KaasIc56mFtOYP0yCpx0Py2r1p+88lH2dzy61mQ==
X-Received: by 2002:ac2:5181:: with SMTP id u1mr21540759lfi.42.1566485556645;
        Thu, 22 Aug 2019 07:52:36 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s3sm3959374ljj.85.2019.08.22.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:52:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/8 v2] AB8500 GPADC MFD to IIO conversion
Date:   Thu, 22 Aug 2019 16:52:25 +0200
Message-Id: <20190822145233.18222-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a resurrection of the patch set from two and a half
years back fixing up this legacy driver to use IIO to provide
ADC instead of necessarily different interfaces.

I split the new driver into its own patch to make things
easier for Jonathan to review. I plan to only iterate the
IIO driver for further comments since the rest is pretty
solidly ACKed already.

Linus Walleij (8):
  power: supply: ab8500_btemp: convert to IIO ADC
  power: supply: ab8500_charger: convert to IIO ADC
  power: supply: ab8500_fg: convert to IIO ADC
  hwmon: ab8500: convert to IIO ADC
  mfd: ab8500: augment DT bindings
  iio: adc: New driver for the AB8500 GPADC
  mfd: Switch the AB8500 GPADC to IIO
  ARM: dts: ux500: declare GPADC IIO ADC channels

 .../devicetree/bindings/mfd/ab8500.txt        |  119 ++
 MAINTAINERS                                   |    1 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi             |  102 +-
 drivers/hwmon/Kconfig                         |    3 +-
 drivers/hwmon/ab8500.c                        |   65 +-
 drivers/iio/adc/Kconfig                       |   10 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ab8500-gpadc.c                | 1240 +++++++++++++++++
 drivers/mfd/Kconfig                           |    7 -
 drivers/mfd/Makefile                          |    1 -
 drivers/mfd/ab8500-debugfs.c                  |  799 -----------
 drivers/mfd/ab8500-gpadc.c                    | 1075 --------------
 drivers/power/supply/Kconfig                  |    2 +-
 drivers/power/supply/ab8500_btemp.c           |   41 +-
 drivers/power/supply/ab8500_charger.c         |   78 +-
 drivers/power/supply/ab8500_fg.c              |   23 +-
 include/linux/mfd/abx500/ab8500-gpadc.h       |   75 -
 17 files changed, 1618 insertions(+), 2024 deletions(-)
 create mode 100644 drivers/iio/adc/ab8500-gpadc.c
 delete mode 100644 drivers/mfd/ab8500-gpadc.c
 delete mode 100644 include/linux/mfd/abx500/ab8500-gpadc.h

-- 
2.21.0

