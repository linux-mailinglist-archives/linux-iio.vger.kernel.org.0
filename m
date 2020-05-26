Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F541E1F0C
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbgEZJrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731826AbgEZJrG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:47:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC510C08C5C1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:47:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r7so3053275wro.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jV12W3UygClgnjI8OwJfqrVttfZE3ZiDDLZ9k2Y3cMg=;
        b=yZbleg6y3zSWwvAUhkU/8+05EwmWvvWWXpuA8kcTb+7i0zK3z42rIIMG2yiWyxc/Fd
         WonT3lYNUAZ68HyBLBai/O4qjOy2xXRby3N1OAxntnnlkM6NfEzNuq0gHAa2rV/cEWWp
         TKhWL+JVHx81ursRB6Ah7OtS7IG1mc9qj3oouGXMdyrIee1CPOLVDGX5C0eU5d4NGLd2
         wdI7diUX58sJjcRuKCjsINY3QrBcI+00CX77afoGFe+aOa/BUV0lqzB5Gj6NkKazPRyY
         y6zesexjQfrqDWCPI1AQnqbGVqavcv1BsJvi7BmOwSr6A9Y8dQTYO4InNaeE/eKYZ5ke
         y+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jV12W3UygClgnjI8OwJfqrVttfZE3ZiDDLZ9k2Y3cMg=;
        b=uUWXA0bqd/rEQ9DraPtnA2PWsm7A0kmLgx9sPIWcMkowFsfNRACh+1rn60jsd3ZYUd
         10N6JJfPCI3DqYEZuc2BKZ0olD1KGBkHdxNbSF2/YS2ECSNsvjvfH8/68cI2QxvPjIBV
         HmUqwL2l14qj4RWH4pZtfNXkRy5TuTboPVU1R4ymLafzYvNOwU7iPj1iEMLtAp6p+4fa
         RdqCw5BDrDQmL5ijeg14fUA39UzTG+irlyGRP/Iw5jfgM+PPCJ7MGYcNi0i2twpxI5R3
         T1jTV5Dc3fVhvZgWWGITKdonzSqVteHkXfap+FLDujDADJxnC4n1pe7vrIgafAoMvsG3
         PtkQ==
X-Gm-Message-State: AOAM532QbYIbaaultuW4O0cHQiuPo77b+2ViYDCsX/fHceCQGd/fEpdV
        zwBBX6Op/wvA4ggiyjdX6FrxzA==
X-Google-Smtp-Source: ABdhPJwPPB4HSrbD5tV/YFMBUSyZ3AoSeTkgGu3q0At6aP5K3uE37QavYsRcBe8x711cYSRumx26uQ==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr5973359wrm.248.1590486424573;
        Tue, 26 May 2020 02:47:04 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id b9sm1721101wrt.39.2020.05.26.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:47:04 -0700 (PDT)
Date:   Tue, 26 May 2020 10:47:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, IIO and Power due for the
 v5.8 merge window
Message-ID: <20200526094702.GN3628@dell>
References: <20200526090646.25827-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526090646.25827-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enjoy!

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-iio-power-v5.8

for you to fetch changes up to 904ac71f4b0c1c26ec47ff597cb3d3c7d36e618d:

  MAINTAINERS: Add entry for mp2629 Battery Charger driver (2020-05-26 10:42:02 +0100)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Power due for the v5.8 merge window

----------------------------------------------------------------
Saravanan Sekar (6):
      dt-bindings: mfd: Add document bindings for mp2629
      mfd: mp2629: Add support for mps battery charger
      iio: adc: mp2629: Add support for mp2629 ADC driver
      power: supply: Add support for mps mp2629 battery charger
      power: supply: mp2629: Add impedance compensation config
      MAINTAINERS: Add entry for mp2629 Battery Charger driver

 Documentation/ABI/testing/sysfs-class-power-mp2629 |   8 +
 .../devicetree/bindings/mfd/mps,mp2629.yaml        |  62 ++
 MAINTAINERS                                        |   5 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mp2629_adc.c                       | 208 +++++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/mp2629.c                               |  79 +++
 drivers/power/supply/Kconfig                       |  10 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/mp2629_charger.c              | 669 +++++++++++++++++++++
 include/linux/mfd/mp2629.h                         |  26 +
 13 files changed, 1090 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
