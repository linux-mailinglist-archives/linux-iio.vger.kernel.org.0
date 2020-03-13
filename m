Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69818410F
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 07:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgCMGqK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 02:46:10 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:55942 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMGqJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 02:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yQkfOLNuqw0s/C4iIr73jm/g+t03fJKekg1eS9M/yZg=; b=MQ8zVt1jf+3E8VFEr9vHXAwzRP
        EEpNOjG0j9PXkkpwioOIl1s3ss5UcmCWbUmkf3Lu2/xhN0+0ruZHagfHuVB+NaQVla6w5oLLiutBU
        QIbBfQv1x+4Q5mzzzwC1GAgSEtF9O3syxxI/jfsgzlEy8/kSht1I7X3a1yCv0EclzO9k=;
Received: from p200300ccff096400e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff09:6400:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jCe4u-0002p9-GB; Fri, 13 Mar 2020 07:45:52 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jCe4t-0008Cq-SM; Fri, 13 Mar 2020 07:45:51 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND v6 0/7] mfd: rn5t618: Add RTC/ADC support
Date:   Fri, 13 Mar 2020 07:45:27 +0100
Message-Id: <20200313064535.31503-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the variant RC5T619 the mfd has an RTC. This patchset adds
support for it. To do so it adds the missing register defines in 
rn5t618.h and general irq handling for that.
It seems that the IRQ definitions are the same except missing RTC
for the RN5T618 but due to missing ability to test that they are
not added here.
It also adds support for the ADC, it is available in both the
RN5T618 and RC5T619 but due to missing ability to test that,
the subdevice is only added for the RN5T618.

It was tested on the Kobo Clara HD.

Changes in v6:
- put together with ADC series
- also added cleanup i2_device_id patch to avoid merge
  conflicts

Changes in v5:
- static rn5t618_irq_init
- PLATFORM_DEVID_NONE
- added some Acked-Bys

Changes in v4:
- use macros for IRQ definitions
- merge rn5t618-core.c and rn5t618-irq.c

Changes in v3:
- alignment cleanup
- output cleanup, remove useless toggling of alarm flag in rtc probe
- updated bindings description, so patch 1/5 becomes 2/6 and so on

Changes in v2:
- no dead code in irq code
- various improvements and cleanups in rtc driver itself
 
Andreas Kemnade (7):
  dt-bindings: mfd: rn5t618: Document optional property interrupts
  mfd: rn5t618: add IRQ support
  mfd: rn5t618: add RTC related registers
  mfd: rn5t618: add more subdevices
  rtc: rc5t619: add Ricoh RC5T619 RTC driver
  iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619
  mfd: rn5t618: cleanup i2c_device_id

 .../devicetree/bindings/mfd/rn5t618.txt       |   4 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rn5t618-adc.c                 | 256 ++++++++++
 drivers/mfd/Kconfig                           |   1 +
 drivers/mfd/rn5t618.c                         | 119 ++++-
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-rc5t619.c                     | 444 ++++++++++++++++++
 include/linux/mfd/rn5t618.h                   |  26 +
 10 files changed, 862 insertions(+), 10 deletions(-)
 create mode 100644 drivers/iio/adc/rn5t618-adc.c
 create mode 100644 drivers/rtc/rtc-rc5t619.c

-- 
2.20.1

