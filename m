Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44C1528F4
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 11:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBEKRF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 05:17:05 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:34063 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBEKRF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 05:17:05 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 99B9D1010E5;
        Wed,  5 Feb 2020 11:17:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 99B9D1010E5
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH 0/5] iio: light: vcnl4000: make some settings configurable
Date:   Wed,  5 Feb 2020 11:16:50 +0100
Message-Id: <20200205101655.11728-1-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

series adds enable, integration time, duty ratio and multi pulse
settings for vcnl4040 and vcnl4200. Only enable is also for ambient
light sensor, the rest is for proximity sensor.

The second patch allows you to switch sensors on or off. This is
required for the rest of patches, as the settings should be changed on
disabled sensor.

The duty ratio (the fourth patch) is available as extended channel enum.
I've chosen this approach as it is more straightforward from the
sensor's perspective. It will be a bit tricky, but it can be
exported as sampling frequency attribute. The sampling frequency depends
on the integration time and 20% of part to part tolerance needs to be
added. In this case, only the available frequencies for currently
selected integration time should be listed in the available attribute?
Please note that the sampling frequency -> duty ratio mapping is
ambiguous. There are more frequencies which map to different integration
and duty ratio pairs.

The whole series is tested on vcnl4020 and vcnl4200.

The series is based on fixes-togreg (e19ac9d9a978) and two patches
already posted to iio mailing lists (series 'iio: light: vcnl4000:
update sampling rates' [1]).

[1] https://lore.kernel.org/linux-iio/20200108155852.32702-1-tomas@novotny.cz/

Tomas Novotny (5):
  iio: light: vcnl4000: convert to regmap
  iio: light: vcnl4000: add enable attributes for vcnl4040/4200
  iio: light: vcnl4000: add proximity integration time for vcnl4040/4200
  iio: light: vcnl4000: add control of duty ratio
  iio: light: vcnl4000: add control of multi pulse

 Documentation/ABI/testing/sysfs-bus-iio-vcnl4000 |  39 ++
 drivers/iio/light/Kconfig                        |   1 +
 drivers/iio/light/vcnl4000.c                     | 545 +++++++++++++++++++++--
 3 files changed, 549 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-vcnl4000

-- 
2.16.4

