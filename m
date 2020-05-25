Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53731E115C
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 17:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbgEYPNg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390911AbgEYPNg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 11:13:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229C3C061A0E;
        Mon, 25 May 2020 08:13:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n11so12228347qkn.8;
        Mon, 25 May 2020 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2KfT83U5UrmH5/c9ZNzzt7t+rX5mJzkoTHiBpMUhpeo=;
        b=L8BwDn2q4FwRlUxf1RDbJR3EXX/pLTbuOD5u2eeZZ+lglSLD3cJk1KjNPCAjX3dJvI
         iJGr/z+ZUjmx2+fbsE2G5TNGsaqJ0TcRxUoAY9YeEngpku465+ENSzOonSKNJ9RM/w/x
         C2j2kZS6eIJjH+sNRw4Gh1HE4Keis3biw0FZv9QxUv+r+GbGsI1hGLhgbpRl8xXnX69/
         kq9tgHeNig0L2hADISXMeCvwl7FlTSwnpisWuNe5abnA0hU+jUlzofmIA7PJH7xYkZMt
         RrUIryEDd873+IFnCJnlCIxINNahOEtQ329H3tVoYObui+Zv2TnYsP454c9FMqypXfG+
         YwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2KfT83U5UrmH5/c9ZNzzt7t+rX5mJzkoTHiBpMUhpeo=;
        b=opodKjU5+hfE5pgkq2dbVvXSI/PLqBCl4nyGzevmVv7EZSm2sofaekMn8jxqufCpLG
         XaqJA12j7OrUSPkV8oG8DGnUSgV+HrsFh9+lMDWFLchO11INP4xFf3JXSJTZVdl2r9kI
         IZp2Mw88fu0l4CGfzJsh8mwq4KUQ8oFo1NeNf794N4c4z8tTxC21YXOQjQLX4Tk29yxB
         ljs83dFLd47AX0y6rasQBB+auMD5cR+G4ZIluf26BCkQSL6TY3nRgdCTuJZcyc9ogZOa
         vumpUxzPHplqVwv7Y76e6TdJJ3R04c4A0SHY/aM/oiJw4/DQ6uBuPhcLsRE+PnQ7eG6O
         4MMg==
X-Gm-Message-State: AOAM530XBPVAIAhTmGluvjBg3sxP4kNuu3IYRXR52omzidSYnM1sOUU2
        DtfAH/7IwesWhrd+DD6E39aCjg6RzQk=
X-Google-Smtp-Source: ABdhPJzATe0nDD/zJUz7eRatm3BCMdWEKTscEBVHEqEErm9IvxvcZkEgb+SeQ9dzNLrdJDxhvDzYVQ==
X-Received: by 2002:a37:6fc6:: with SMTP id k189mr381433qkc.289.1590419614903;
        Mon, 25 May 2020 08:13:34 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m59sm15161709qtd.46.2020.05.25.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:13:32 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v6 0/4] iio: magnetometer: ak8975: Add gpio reset support
Date:   Mon, 25 May 2020 17:10:34 +0200
Message-Id: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v6:
 - reword documentation for gpios, add interrupt documentation

v5:
 - add maintainer
https://lore.kernel.org/linux-iio/20200520163417.27805-1-jonathan.albrieux@gmail.com/

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

Jonathan Albrieux (5):
  dt-bindings: iio: magnetometer: ak8975: reword gpios, add interrupts,
    fix style
  dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add
    maintainer
  dt-bindings: iio: magnetometer: ak8975: add gpio reset support
  iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
  iio: magnetometer: ak8975: Add gpio reset support

 .../bindings/iio/magnetometer/ak8975.txt      | 30 -------
 .../iio/magnetometer/asahi-kasei,ak8975.yaml  | 85 +++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c             | 22 ++++-
 3 files changed, 105 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml

-- 
2.17.1

