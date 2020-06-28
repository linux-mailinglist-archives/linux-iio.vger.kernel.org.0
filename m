Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3A20C7FB
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgF1MjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgF1MjA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C6B20738;
        Sun, 28 Jun 2020 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347939;
        bh=VwrAZjQJNNVu89JxAzrpztx+ssvfnpIaIRUZ+Eb+zwY=;
        h=From:To:Cc:Subject:Date:From;
        b=L4llOQYQINM2fioxC245V4VZaergw+BaDalAJ/p7znhzD4FI+BToGmrQU//fYZAOv
         sbjoNcO8Vh3++uVXl9kFu5EvNgjFNf2/8IAJxYZAQKhdXdknnyZu11Q9NHlJHn0m6j
         WHTLvO1Twjjy0ZKglEU9S9LsiqGzM+EThz6xWVB4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/23] iio:adc more of_match_ptr and similar removal
Date:   Sun, 28 Jun 2020 13:36:31 +0100
Message-Id: <20200628123654.32830-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Continuation of slow process to try and remove use of of_match_ptr
to supress asignment of the of_device_id table when !CONFIG_OF.

Usual argument that it prevents ACPI being used with these drivers
via PRP0001 in DSDT.  Perhaps more usefully we are cutting down on the
number of places it can be cut and paste from into new drivers.

This is just the low hanging fruit.  I'm not yet sure if it makes
sense to expend the effort to use generic firmware properties etc
for some of the remaining drivers as it is unlikely they'll ever
be used with anything other than device tree. There are 4 current
ADC drivers in this more complex category.

Jonathan Cameron (23):
  iio:adc:lpc32xx: Drop of_match_ptr protection
  iio:adc:axp20x: Convert from OF to generic fw / device properties
  iio:adc:hi8435: Drop unused of_gpio.h header
  iio:adc:hi8435: Drop of_match_ptr protection.
  iio:adc:max1363: Drop of_match_ptr and use generic
    device_get_match_data
  iio:adc:max1027: drop of_match_ptr and CONFIG_OF protections
  iio:adc:ltc2496: Drop of_match_ptr and use mod_devicetable.h
  iio:adc:cpcap-adc: Drop of_match_ptr protection and use
    device_get_match_data
  iio:adc:ltc2497 drop of_match_ptr protection
  iio:adc:max11100: Drop of_match_ptr protection / add mod_devicetable.h
    include
  iio:adc:max1118: Drop CONFIG_OF / of_match_ptr protections
  iio:adc:mcp320x: Drop CONFIG_OF and of_match_ptr protections
  iio:adc:mcp3422: remove CONFIG_OF and of_match_ptr protections
  iio:adc:sd_adc_modulator: Drop of_match_ptr and tweak includes
  iio:adc:ti-adc081c: Drop of_match_ptr and change to mod_devicetable.h
  iio:adc:ti-adc0832: drop CONFIG_OF and of_match_ptr protections
  iio:adc:ti-adc084s021: drop of_match_ptr protection
  iio:adc:ti-adc108s102: Drop CONFIG_OF and of_match_ptr protections
  iio:adc:ti-adc128s052: drop of_match_ptr protection
  iio:adc:ti-adc161s626: Drop of_match_ptr protection.
  iio:adc:ti-tlc4541: Drop CONFIG_OF and of_match_ptr protections.
  iio:adc:bcm_iproc: Drop of_match_ptr protection and switch to
    mod_devicetable.h
  iio:adc:ingenic: drop of_match_ptr protection and include
    mod_devicetable.h

 drivers/iio/adc/axp20x_adc.c       | 10 +++++-----
 drivers/iio/adc/bcm_iproc_adc.c    |  4 ++--
 drivers/iio/adc/cpcap-adc.c        | 22 ++++++----------------
 drivers/iio/adc/hi8435.c           |  6 ++----
 drivers/iio/adc/ingenic-adc.c      |  5 ++---
 drivers/iio/adc/lpc32xx_adc.c      |  5 ++---
 drivers/iio/adc/ltc2496.c          |  4 ++--
 drivers/iio/adc/ltc2497.c          |  4 ++--
 drivers/iio/adc/max1027.c          |  5 ++---
 drivers/iio/adc/max11100.c         |  3 ++-
 drivers/iio/adc/max1118.c          |  7 ++-----
 drivers/iio/adc/max1363.c          | 11 ++++-------
 drivers/iio/adc/mcp320x.c          |  5 ++---
 drivers/iio/adc/mcp3422.c          |  6 ++----
 drivers/iio/adc/sd_adc_modulator.c |  5 +++--
 drivers/iio/adc/ti-adc081c.c       |  6 ++----
 drivers/iio/adc/ti-adc0832.c       |  7 ++-----
 drivers/iio/adc/ti-adc084s021.c    |  3 ++-
 drivers/iio/adc/ti-adc108s102.c    |  5 ++---
 drivers/iio/adc/ti-adc128s052.c    |  3 ++-
 drivers/iio/adc/ti-adc161s626.c    |  3 ++-
 drivers/iio/adc/ti-tlc4541.c       |  5 ++---
 22 files changed, 54 insertions(+), 80 deletions(-)

-- 
2.27.0

