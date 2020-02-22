Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BA169224
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2020 23:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBVWqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Feb 2020 17:46:15 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:46988 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgBVWqP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Feb 2020 17:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fQVN1Sdm8ne/62EI+E621DP/kcvj/V1goR5+XSu89jw=; b=jfIEtAZEmNc9FCp2CrCrq5+HmH
        PYCktzJHUGSW56qL3Jw7/O9udGIFNVr/I86GglrDPnDA/l54sPp+ZcTUVeDjqoVgxJDdiYVAF1jVr
        Q9PKnzPklBUn09E2FL7cwTJ8IdA9VqdlerDmqco58AuqO3h6sl1hxcUbcgbd9hcMkhAA=;
Received: from p200300ccff354600e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff35:4600:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j5dXF-0007uH-Q4; Sat, 22 Feb 2020 23:46:09 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j5dXF-0002yp-78; Sat, 22 Feb 2020 23:46:09 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 0/2] mfd: rn5t618: add ADC support
Date:   Sat, 22 Feb 2020 23:46:00 +0100
Message-Id: <20200222224602.11413-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the ADC in the RN5T618/RC5T619.
It depends on the IRQ support added in the RTC support series here:
https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/

I tested the driver only with the RC5T619 but it should work with the with 
the RN5T618 as well based on these facts:
- The corresponding register definitions originally went into the kernel
  for the RN5T618
- Public datasheet sections about the ADC look same.
- Out-of-tree code for these chips look same regarding to ADC

But due to missing hardware I cannot test the patches 2/3 and 3/3 which
add support for the RN5T618 ADC.
I marked these untested patches as RFC, and IMHO they require a Tested-By.
Feel free to ignore them if the whole series would be delayed just because
of missing Tested-By for those.

Changes in v4:
- drop RFC patches, seems nobody finds time to test now
- added trivial change and Reviewed-By

Changes in v3:
- re-included former 2/5 of these patches, since it was not applied

Changes in v2:
- got an "Applied, thanks" message for the first two, so I do not include
  them anymore
- some cleanups for the ADC driver itself

Andreas Kemnade (2):
  mfd: rn5t618: add ADC subdevice for RC5T619
  iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619

 drivers/iio/adc/Kconfig       |  10 ++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/rn5t618-adc.c | 256 ++++++++++++++++++++++++++++++++++
 drivers/mfd/rn5t618.c         |   1 +
 4 files changed, 268 insertions(+)
 create mode 100644 drivers/iio/adc/rn5t618-adc.c

-- 
2.20.1

