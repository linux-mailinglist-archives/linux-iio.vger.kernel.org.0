Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D261E64F4
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403812AbgE1O5r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403787AbgE1O5p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 10:57:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CAC08C5C6;
        Thu, 28 May 2020 07:57:45 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w90so249078qtd.8;
        Thu, 28 May 2020 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xh10qpgo8ZBw04J26d6TmP95SZB7leV7haVSlHLd2KM=;
        b=buvCKmjhmmNh95OXQOYAHAM2JXnioPPtZVlMoCCsXWBaJ3npB99IVwgHzFzJtc6zSP
         zDjcxjevo3MiKIzQ9qD2q4UN54h+GgmyrSayNYjdsKD0gqkbwgsmER+rP6mJd3fHzcRd
         5x01uE9OP109aSO+MJbm3KtnapOmJqn4wx2SWY1EPUOUJQTXW/88KJFjmZdBpEx+HfF5
         ij8wcGSaSrH8O+zdmKr1AxorBSDOh/iFZm0o9Dxtm9KxvsVj6+cz7QttVQnGSbyYV/d3
         AXZgy+kakANhfFsMRviQYQKjBwivSIHY0XkbNd7VFw2ELV/m7bMgGxgPRM3hpFmCr/Vh
         jPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xh10qpgo8ZBw04J26d6TmP95SZB7leV7haVSlHLd2KM=;
        b=uc2qwrgR7Q0npWB5pasIU6+oXyNh3xbIj0tbUFxODaEx9SOPBzNRhYYDHR2ZNUfEwM
         Lr0PupT84Oi/LazVKLKLYJBTMqOYj8+YJvHhqzWBntEpc5+SlnhhX8QaILi8XIoVSPqf
         eoIywXB4nV95MquKmgvgxqhHEer46ty9vcsHnRALhEc8On+o9kVindIFgCc9E9LtUHQI
         W7xEdWbad3TKLxnmGUMXe7n/4oy+L+IdG+JDj87+xLsu39v0pga3W9FumGPp4yBzK7vp
         hBz0zhWZim005gUUdCvrcgspZFXiAVlMbvUyV5b3HtKLW3mdmqxZy49PiU1Tar5atoet
         ND9w==
X-Gm-Message-State: AOAM531avRyRSXf08HwS0gcLmD3e8jhRgbwmacCRCmm/KDnC2kJNMNqz
        0TzN8MqPX3o5neBAydhdZg0Jub1W7ic=
X-Google-Smtp-Source: ABdhPJyWo3QAAo1dPoftO2PinkN6bcnQYbJ0FqVZ+8djxEm/X53BTqJcBHwILXOjtO5Ln5D/WVF+5w==
X-Received: by 2002:ac8:e8f:: with SMTP id v15mr3413836qti.391.1590677864325;
        Thu, 28 May 2020 07:57:44 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id s74sm5116876qka.54.2020.05.28.07.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:57:43 -0700 (PDT)
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
Subject: [PATCH v7 0/5] iio: magnetometer: ak8975: Add gpio reset support
Date:   Thu, 28 May 2020 16:56:03 +0200
Message-Id: <20200528145631.11608-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v7:
 - fix documentation style, removing documentation unnecessary parts

v6:
 - reword documentation for gpios, add interrupt documentation
https://lore.kernel.org/linux-iio/20200525151117.32540-1-jonathan.albrieux@gmail.com/

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

JonnyMe (5):
  dt-bindings: iio: magnetometer: ak8975: reword gpios, add interrupts,
    fix style
  dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add
    maintainer
  dt-bindings: iio: magnetometer: ak8975: add gpio reset support
  iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
  iio: magnetometer: ak8975: Add gpio reset support

 .../bindings/iio/magnetometer/ak8975.txt      | 30 -------
 .../iio/magnetometer/asahi-kasei,ak8975.yaml  | 84 +++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c             | 22 ++++-
 3 files changed, 104 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml

-- 
2.17.1

