Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7E1DAC28
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgETHbp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETHbo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:31:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76339C061A0E;
        Wed, 20 May 2020 00:31:44 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g20so876006qvb.9;
        Wed, 20 May 2020 00:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gaIm9s4mEnVH3V4H05vGC7PBgBmldd3HetRyrOGTO80=;
        b=L189PUp3M27waln66S1LOQ6RpRED5ip+iNlo+6Ir6BBRAqKKduEN9KAazXm+1sStZi
         NS34SUYl4XnZj46lv3a1W8N5DHpJPGw7YLmFOcn7SG32MB6daHmhJWtRJJAHjZi7jAxl
         fFgns6fyavA9TXenwre5zXrPSZ9rRaDsZHIlw/CkgbO2MJ68ETS/dapucXgLeo3u+SNv
         ZmwArlEI4Kzblw07mdn3FAyrUfRAMH6SuycJRNcre5rNGITQYSelHQcFBTTluS6xN6C6
         a+ADVlumVmrqNKkV3lJdbtYi+KIsdlUnUeNQc0dtT//JepgPRLMb/I7tHlSKwBRnQeiu
         4sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gaIm9s4mEnVH3V4H05vGC7PBgBmldd3HetRyrOGTO80=;
        b=hzjX0lRaQAMTJasA4c8cy6H9KoA0rB63lKhJQb1YDpaeQj5UPKJ9Kf/JPymqk21o3/
         DSnOf0lzMY4/ew1jmlDbCV1AeVghrwe+Wkv2Tpi5L4Sjrs9ZE2vviecrBW7hScyT7RjH
         8vhRyKth5yRoibSfisZFqYpvlNaqV1Yp4Ggxipqb1E361WnXSXZtrevAOpjT4A58i4Wo
         RkhlvprT1mq8nkVIcvZ2mhqhXOBh9UHBFcea+5/l4a9FJUur8rsgsUvHSu2BV5OgvXE7
         HGE4MDCdAUi3o1mBypa5B5PwXZxEbT1UEo2ERNIrDivyCZGd3ir88G2wRASyiLt1yrPv
         vMow==
X-Gm-Message-State: AOAM531iumxRLr5PC+uiERO8r+aS6K5mcbKf00QrTieCFWmr+fI5lMa+
        8t1k/R6bctKLQUXyzKFVDJa6iEVxb9+lkQ==
X-Google-Smtp-Source: ABdhPJx7KDZ/cCn0kDH5eo1sxLGrfcympYeUIlyP1sLo07ELMWIpOYrAfxUorYSkK5wgsHqFgOYr0Q==
X-Received: by 2002:ad4:5282:: with SMTP id v2mr3362063qvr.167.1589959903328;
        Wed, 20 May 2020 00:31:43 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w9sm1702540qtn.29.2020.05.20.00.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 00:31:42 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 0/4] iio: magnetometer: ak8975: Add gpio reset support
Date:   Wed, 20 May 2020 09:31:12 +0200
Message-Id: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v4:
 - fix some typo
 - use gpio's dt-bindings for more clarity in documentation
 - set compatible properties without vendor prefix as deprecated

v3:
 - fix patch messages style
 - align reset gpio comment to kernel doc reccomendation
 - introduce changelog.
https://lore.kernel.org/linux-iio/20200519124402.26076-1-jonathan.albrieux@gmail.com/

v2:
 - rewording of reset gpio comment and patch messages to better clarify
   reset gpio behaviour.
https://lore.kernel.org/linux-iio/20200518133645.19127-1-jonathan.albrieux@gmail.com/

v1:
 - initial patch submission.
https://lore.kernel.org/linux-iio/20200519065749.4624-1-jonathan.albrieux@gmail.com/

Convert documentation from txt format to yaml. Add documentation about
reset-gpio.

Deassert reset on ak8975_power_on(), assert reset on ak8975_power_off().

Without reset's deassertion during ak8975_power_on(), driver's probe fails
on ak8975_who_i_am() while checking for device identity for AK09911 chip.

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheet says that, if not used, reset pin should be connected
to VID. This patch emulates this situation.

Jonathan Albrieux (4):
  dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
  dt-bindings: iio: magnetometer: ak8975: add gpio reset support
  iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
  iio: magnetometer: ak8975: Add gpio reset support

 .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
 .../bindings/iio/magnetometer/ak8975.yaml     | 77 +++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c             | 22 +++++-
 3 files changed, 97 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml

-- 
2.17.1

