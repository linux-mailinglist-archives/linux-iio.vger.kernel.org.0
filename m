Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278621A376
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGIPWl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 11:22:41 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43865 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGIPWl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 11:22:41 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0CCBEC000B;
        Thu,  9 Jul 2020 15:22:34 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v8 0/6] iio/adc: ingenic: Cleanups & add touchscreen mode.
Date:   Thu,  9 Jul 2020 17:21:54 +0200
Message-Id: <20200709152200.10039-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

v8 of this patchset introduces some structural changes, which I deemed
worthy highlighting here:

 - adc-joystick related changes have been dropped from this patchset and
   will be upstreamed separately. Their only connection to this patchset
   was that they used INGENIC_ADC_TOUCH_* defines in the DTS example,
   causing trouble to Rob's scripts.

 - Integrated Paul's changes, which introduce an ADCMD low-level command
   feature. These changes affect patches 5/6 and 6/6, with the former
   requiring Rob to re-ack.

Cheers,
Artur

Artur Rojek (5):
  dt-bindings: iio/adc: Convert ingenic-adc docs to YAML.
  IIO: Ingenic JZ47xx: Error check clk_enable calls.
  IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
  dt-bindings: iio/adc: Add touchscreen idx for JZ47xx SoC ADC
  IIO: Ingenic JZ47xx: Add touchscreen mode.

Paul Cercueil (1):
  iio/adc: ingenic: Retrieve channels list from soc data struct

 .../bindings/iio/adc/ingenic,adc.txt          |  49 ---
 .../bindings/iio/adc/ingenic,adc.yaml         |  71 ++++
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ingenic-adc.c                 | 386 ++++++++++++++++--
 include/dt-bindings/iio/adc/ingenic,adc.h     |   6 +
 5 files changed, 426 insertions(+), 87 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml

-- 
2.27.0

