Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3271E1D9686
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgESMoS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgESMoR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 08:44:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B90C08C5C0;
        Tue, 19 May 2020 05:44:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so15688618wrp.12;
        Tue, 19 May 2020 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ILSGLr4PTG4hHuLbl/jfVaGJlNauWt/s2JzJ6o43rnE=;
        b=tZiIm4xm9TCzSwfdVSICyGr+S5PkpwIVdBUJRglkqoZ9CHvvYvtR2JCKWLfHtkKGrQ
         sH0CRkKLO29EMlLw2GtfqeFSNlNtJJjQpw4qwOryphHyk64d+q8RuWM2R+OIlTw2HXZ/
         utDXRmcOG8DRjOttVA2z4kRiQ+ceDB+fkWIBY0Pw85QVqOJ/q//CLKV7ylZ9X6GB5+Sb
         TmvHhR5dtqooI5I39gZHNPdopov7EIHksQcXlz60JdKRPTGJdCIapoSt2JWZJwo4aZa7
         R/rtl/NMS0FgndZ/s3A558DyDkB7i6jU43GExsBUeAwwn3EgNdYxGlhGKeK7acEpekmz
         86Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ILSGLr4PTG4hHuLbl/jfVaGJlNauWt/s2JzJ6o43rnE=;
        b=hk73Zj9G1/BX0ZGD1+bTBR1Tt4zHjPyjTtgg/P1XNErvj5WQNYKXI+5priZvoyZyx9
         tN93Djex1pwS9COHyODrKUdWN8mP/8o2XtShiR4wIJoTx+IPzZaOGyeFob9Tc3FFaMBk
         cIWJc0ScJ60Zk0K88ZQfgwG7mdVmW2yeA7LAxtEGgcoO4ocuLjxbEjKuX5WiHPdb2R5C
         1QPEWqS0copIg2FxTSrPLUQdL7EQm2XlxxtUZl37bQwwRd8CCiYQS//KkqpAdS5eEM19
         EdJG2MH5hJIFTHlD7kPMdMakgGAbKqX+dWel5H3OSkXwlcSOLfjpnlFtYEksQwBGmncR
         uD7Q==
X-Gm-Message-State: AOAM532oDv14km4Zgg/g76f4wy0Am/IQGynUT2g04xn+rWWb+ZM0vOxO
        O5dNKIS1Q05GlEufqPPRaHPe5FW1lQyO/g==
X-Google-Smtp-Source: ABdhPJw629rJE6pDTM+0ibqZS6vtE2fHVU9WkEg3ZszeBcuEB3Gh2NrbKzz43KhI7veIk84LWchXAg==
X-Received: by 2002:adf:a285:: with SMTP id s5mr28241564wra.60.1589892255688;
        Tue, 19 May 2020 05:44:15 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id b12sm3953870wmj.0.2020.05.19.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:44:14 -0700 (PDT)
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
Subject: [PATCH v3 0/4] iio: magnetometer: ak8975: Add gpio reset support
Date:   Tue, 19 May 2020 14:43:50 +0200
Message-Id: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v3:
 - fix patch messages style
 - align reset gpio comment to kernel doc reccomendation
 - introduce changelog.

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
AK09911 datasheed says that, if not used, reset pin should be connected
to VID. This patch emulates this situation.

Jonathan Albrieux (4):
  dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
  dt-bindings: iio: magnetometer: ak8975: add gpio reset support
  iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
  iio: magnetometer: ak8975: Add gpio reset support

 .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
 .../bindings/iio/magnetometer/ak8975.yaml     | 70 +++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c             | 22 +++++-
 3 files changed, 90 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml

-- 
2.17.1

