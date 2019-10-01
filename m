Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7435C4394
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 00:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfJAWQE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 18:16:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40620 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfJAWQE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 18:16:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so15027869ljw.7
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2019 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX5dumfZXbnJM/pbPwsXy0aXb6e1Dv5PjPVNi4e+D2k=;
        b=T0hplppuitjlFugcdaKnji+YNZ7VypN8Wf0Juu7fpYtToPzaCAJNEN9oYbKIYmgf16
         xf5waOX2ZVVTiIKo+4nOrqGVW92X5SWMFgqThehJG8w4iFO3JaJbp244XpZ5HSxSI4BV
         RoThQRBR74PfwwBY2Ywe/uLphkYbZZ5BdLGC0/e8cS4a8mJxJS2f/T5tyhgxqesO6MPV
         4KHoqoTU0eaYc73e26/xAAm3W6lJ0+avdzPM/ma1bIsFc9SRn7ZcgUKXIHdmkU3Nkh93
         gxLk7VLy66efgB6aO5UHp5hqpa8TDFDOD2E6Qp6r7KxlrZG6aiV6yEhlYXxFBmUwjLtk
         RG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX5dumfZXbnJM/pbPwsXy0aXb6e1Dv5PjPVNi4e+D2k=;
        b=ACfecghXvNKsafpsBn6eL46Wq/9Ib8KbqFrdAEMhsrRhnNtthypwB7EyPjehYz2R9O
         /xD+kv18p77k3RewBZ2+NfoYYsWDufzAh5+UmOBTSCw8IcYTZYDqVZm22HWq5eJ/85eu
         HhbScke8d7BLaQ3IVb7Pm6JPdOrYklL3lwtWBhFWFDtUYeqDkfCKMVyUrNhdh56+E/HT
         mWAmLde+nYpvQHn2gu0krri4ZSAs4Ji1SOSa0wPl3pVAtpsIvx3JcnGYDk14+PaSQMQd
         XDtcKJXJYlLWMtNZFw/C++ACrCFgtSldajFxlGTyRqdcR11v4ZMXAM87lMEOSTtSxkcK
         8vtg==
X-Gm-Message-State: APjAAAUjnn8QH/GY/oHdHcXMAeauE0mYnLzGHOXgj3wxbMy7fXU0dGYq
        A6L5Tbh9+fiIQpki8E6MU7k7edZyxTEZ1Q==
X-Google-Smtp-Source: APXvYqzp5X1yDUnlTVUFYQrqwh8EnEblpnz9nw40ammiQ+8vXokR5Ql6IXZZg+fGSSR0Dhfi9i+u1g==
X-Received: by 2002:a2e:9186:: with SMTP id f6mr87065ljg.223.1569968162486;
        Tue, 01 Oct 2019 15:16:02 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id z14sm4287855ljz.10.2019.10.01.15.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:16:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/7 v3] AB8500 GPADC MFD to IIO conversion
Date:   Wed,  2 Oct 2019 00:13:49 +0200
Message-Id: <20191001221356.19317-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This version should cover Jonathans comments on v2 and
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

