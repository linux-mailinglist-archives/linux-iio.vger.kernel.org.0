Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569D519EBA7
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDENuk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 09:50:40 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44776 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgDENuk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 09:50:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8DA5DFB08;
        Sun,  5 Apr 2020 15:50:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m8aQt_F5d4QC; Sun,  5 Apr 2020 15:50:33 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id DD3DC414D7; Sun,  5 Apr 2020 15:50:32 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v4 0/5] iio: vcnl4000: Export near level property for proximity sensor
Date:   Sun,  5 Apr 2020 15:50:27 +0200
Message-Id: <cover.1586094535.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


If an object can be considered close to the device that has the proximity
sensor built in is hardware dependent. Allowing to configure the property via
device tree allows to export this device specific value to userspace via
ext_info. This is useful for e.g. iio-sensor-proxy.

This came up when adding proximity support to iio-sensor-proxy [1], [2], it is
not meant as a vcnl4000 thing but rather as something useful for other proximity
sensors too in the future.

I've not converted the vcnl4000 binding docs to yaml but can do so as part of
this series in a v2 if the approach makes sense.

Changes from v3:
- as per review comment by Jonathan Cameron
  Fix patch title and description of sysfs patch
  https://lore.kernel.org/linux-iio/20200329102705.0a69000c@archlinux/
- Add Reviewed-by by Rob Herring, thanks!
  https://lore.kernel.org/linux-iio/20200331214330.GA24010@bogus/
- As per review comments by Rob Herring
  https://lore.kernel.org/linux-iio/20200331214517.GA24128@bogus/
  - Rename property to proximity-near-level
  - document proximity-near-level in a common file

Changes from v2:
- as per review comment by Lars-Peter Clausen
  https://lore.kernel.org/linux-iio/c787921f-c412-4986-14ea-e31b531d3d5b@metafoo.de/
  Switch sysfs name to `nearlevel`
- as per review comment by Nishant Malpani
  https://lore.kernel.org/linux-iio/f5ea512c-d427-94c7-cf5f-f1300cbd4aa3@gmail.com/
  Add manufacturer do binding document name
- as per review comments by Andy Shevchenko
  - Drop superfluous blank line
  - Check return value of device_property_read_u32 for '!= 0' instead of '< 0'

Changes from v1:
- as per review comments by Jonathan Cameron
  https://lore.kernel.org/linux-iio/20200221120519.43b72007@archlinux/
  Document new sysfs file in Documentation/ABI/testing/sysfs-bus-iio-proximity
- convert bindings to yaml
- bindings: fix typo in near-level property

[1]: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/merge_requests/298
[2]: https://lore.kernel.org/linux-iio/20200210154153.GA26903@bogon.m.sigxcpu.org/

To: Tomas Novotny <tomas@novotny.cz>, Jonathan Cameron <jic23@kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,"Angus Ainslie (Purism)" <angus@akkea.ca>,"Guido Günther" <agx@sigxcpu.org>,Marco Felsch <m.felsch@pengutronix.de>,Thomas Gleixner <tglx@linutronix.de>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,devicetree@vger.kernel.org,Andy Shevchenko <andy.shevchenko@gmail.com>,Nishant Malpani <nish.malpani25@gmail.com>


Guido Günther (5):
  dt-bindings: iio: vcnl4000: convert bindings to YAML format
  dt-bindings: iio: Introduce common properties for iio sensors
  dt-bindings: iio: light: vcnl4000: Add proximity-near-level
  iio: vcnl4000: Export near level property for proximity sensor
  Documentation: ABI: document IIO in_proximity_nearlevel file

 .../ABI/testing/sysfs-bus-iio-proximity       | 10 ++++
 .../devicetree/bindings/iio/common.yaml       | 35 +++++++++++++
 .../bindings/iio/light/vcnl4000.txt           | 24 ---------
 .../bindings/iio/light/vishay,vcnl4000.yaml   | 50 +++++++++++++++++++
 drivers/iio/light/vcnl4000.c                  | 25 ++++++++++
 5 files changed, 120 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-proximity
 create mode 100644 Documentation/devicetree/bindings/iio/common.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml

-- 
2.23.0

