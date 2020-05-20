Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621221DB999
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETQem (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQel (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 12:34:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44EC061A0E;
        Wed, 20 May 2020 09:34:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f13so4226316qkh.2;
        Wed, 20 May 2020 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0nQOcruuCe+I6JJK5BECCDmKUQ6rKpy28VBBPrbownc=;
        b=DL3F2D4KLPheZda48cG2S6TdXunu6Hqeqq97gvDMUiGWAEzDvwu3xe/a0Ck9iRujLR
         xIOpDzt88Ov8oNt80zr2fDzVA9LhRKMwh7k+2d1CqadmLPVaSD0v5hAzdD1MfuQ5zzeX
         58SDNiuAYMfTVNgLeu5GqEWqCHqAWMzw5LxA9eSor4wMyBAbw5FD23rbi13BANuEsfJD
         C9HmwOz5ztm/cIit3EB8qEsA31DoYJ0Bzt0VcCPdORGG0/Pl7QjzrnQORGwtk/+tjH1q
         wCwmjuva9nkq5dAObmFZ7fKpk0NzRSvxO4x1fT4kOXVugSdhldMgpZHDylUMCH5SBEUy
         RzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0nQOcruuCe+I6JJK5BECCDmKUQ6rKpy28VBBPrbownc=;
        b=fhObod3xNiv3+YibVrRzH+hsj5yJ9+MV7Cgtib+ChSDeN3fOLgs5B/ig6lw3vDbFRE
         9/Ocd1hLRCcLobWg0Y1Xn7AH+iAmXQc6sDledh9lG8HmUyaK46lOkzdJgTXyALVbJxNL
         vDN+J/j4pF75ZxQ8mdbRsDuDdKmMIEM8XOCgSTBkKUzsjPXG1L/6Pu90eA/9+jVLs2PB
         U5xGYN3Evt1wmEDB0utQEGlvBkE/ihmTPEV9w860ULdAWvleJGGXcau+IbNjitEjvRkQ
         jUu4ukhLcRXRmY+Ra5rh41p6V8qIisazlpjmbGih/TnyJFMWTrZMpH+2OYYk4hJNHJ6h
         MVLw==
X-Gm-Message-State: AOAM530zPEAjq6h3S30BHuGPdLyyVyF5xz/q1WIkLTEhWJ91JSUg8+yz
        /VL63H5P9xUeRv1M64thKGgQAoMlqJaKEA==
X-Google-Smtp-Source: ABdhPJz6YGPZqytqVuTMTHbOK7LpNwiSZ+mBPDroUHjdn42r2goTiVVdieuIjj/d8g1Oty4T5DI65A==
X-Received: by 2002:a05:620a:1131:: with SMTP id p17mr5732390qkk.248.1589992480395;
        Wed, 20 May 2020 09:34:40 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id q59sm2803261qtd.73.2020.05.20.09.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:34:37 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
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
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 0/4] iio: magnetometer: ak8975: Add gpio reset support
Date:   Wed, 20 May 2020 18:34:05 +0200
Message-Id: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v5:
 - add maintainer

v4:
 - fix some typo
 - use gpio's dt-bindings for more clarity in documentation
 - set compatible properties without vendor prefix as deprecated
https://lore.kernel.org/linux-iio/20200520073125.30808-1-jonathan.albrieux@gmail.com/

v3:
 - fix patch messages style
 - align reset gpio comment to kernel doc reccomendation
 - introduce changelog
https://lore.kernel.org/linux-iio/20200519124402.26076-1-jonathan.albrieux@gmail.com/

v2:
 - rewording of reset gpio comment and patch messages to better clarify
   reset gpio behaviour
https://lore.kernel.org/linux-iio/20200518133645.19127-1-jonathan.albrieux@gmail.com/

v1:
 - initial patch submission
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
  dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add
    maintainer
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

