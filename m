Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E81413E0
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2020 23:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgAQWBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 17:01:02 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38364 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729972AbgAQWBC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jan 2020 17:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mOA7amCzgZnFtzXH6mRck7K1hhyXvnqJjhfchoHEFK4=; b=Bz1vhflTBMSKPImT96JNn4p0M2
        vs4LZ9pEqTlwAx74/yyKNgjbDDv7fFkBBj0Qd6VXRRIfGcc451CZMftOZ9I/DK+SdRpeKP87Ye6yK
        4egqd7X3kO3eBr6R+QMNTq2sL24N8dfN1mjyCvRORvt9KJdZ3+7b5guHOztlO647vYQc=;
Received: from p200300ccff371b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:1b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfh-00077D-Gd; Fri, 17 Jan 2020 23:00:53 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfh-0003yT-4F; Fri, 17 Jan 2020 23:00:53 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: [PATCH 0/5] mfd: rn5t618: add ADC support
Date:   Fri, 17 Jan 2020 22:59:21 +0100
Message-Id: <20200117215926.15194-1-andreas@kemnade.info>
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

First regmap setup has to be fixed because there is a register
wrongly classified as volatile.

I tested the driver only with the RC5T619 but it should work with the with 
the RN5T618 as well based on these facts:
- The corresponding register definitions originally went into the kernel
  for the RN5T618
- Public datasheet sections about the ADC look same.
- Out-of-tree code for these chips look same regarding to ADC

I marked these untested patches as RFC, and IMHO they require a Tested-By.
Feel free to ignore them if the whole series would be delayed just because
of missing Tested-By for those.

Andreas Kemnade (5):
  mfd: rn5t618: mark ADC control register volatile
  mfd: rn5t618: add ADC subdevice for RC5T619
  iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619
  mfd: rn5t618: add IRQ definitions for RN5T618
  mfd: rn5t618: add ADC subdevice for RN5T618

 drivers/iio/adc/Kconfig       |  10 ++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/rn5t618-adc.c | 266 ++++++++++++++++++++++++++++++++++
 drivers/mfd/rn5t618.c         |  49 ++++++-
 4 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/adc/rn5t618-adc.c

-- 
2.20.1

