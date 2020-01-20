Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4974414335A
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 22:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATVVT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 16:21:19 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38594 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgATVVT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jan 2020 16:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:To:From:Sender:Reply-To
        :Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yowO245pK1fSPCH+v7F/Y9isOjxDC01NKbLnFHqZKTA=; b=C5MdHt6miaWlSzn5w7Sc2Hmz5t
        EeVtYDD5IdhOIwcsBDUXG5KASRYRjdvS00TyaV57KVhoijprzd1tT8/uXq9XFZo0PH7bL8KFxiwTk
        ur2OIh0Vs9gjhl4aFnoahkfBmk9nxTcdXgxzbVceuvMN+Xjod4W+7VvpQp+v61/wU1TI=;
Received: from p200300ccff0880007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff08:8000:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iteTn-0006vj-92; Mon, 20 Jan 2020 22:21:04 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iteTl-0007W9-R6; Mon, 20 Jan 2020 22:21:01 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH v2 0/3] mfd: rn5t618: add ADC support
Date:   Mon, 20 Jan 2020 22:20:53 +0100
Message-Id: <20200120212056.28806-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
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

Changes in v2:
- got an "Applied, thanks" message for the first two, so I do not include
  them anymore
- some cleanups for the ADC driver itself

Andreas Kemnade (3):
  iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619
  mfd: rn5t618: add IRQ definitions for RN5T618
  mfd: rn5t618: add ADC subdevice for RN5T618

 drivers/iio/adc/Kconfig       |  10 ++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/rn5t618-adc.c | 253 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/rn5t618.c         |  47 +++++++-
 4 files changed, 309 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/adc/rn5t618-adc.c

-- 
2.11.0

