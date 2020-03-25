Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628BE1926D6
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 12:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgCYLJY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 07:09:24 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:37656 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYLJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Mar 2020 07:09:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3DC47FB02;
        Wed, 25 Mar 2020 12:09:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K_x7j6K_rbDv; Wed, 25 Mar 2020 12:09:09 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 546CA401FD; Wed, 25 Mar 2020 12:09:08 +0100 (CET)
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
Subject: [PATCH v3 0/4] iio: vcnl4000: Export near level property for proximity sensor
Date:   Wed, 25 Mar 2020 12:09:04 +0100
Message-Id: <cover.1585134362.git.agx@sigxcpu.org>
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

To: Tomas Novotny <tomas@novotny.cz>, Jonathan Cameron <jic23@kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,"Angus Ainslie (Purism)" <angus@akkea.ca>,"Guido Günther" <agx@sigxcpu.org>,Marco Felsch <m.felsch@pengutronix.de>,Thomas Gleixner <tglx@linutronix.de>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,devicetree@vger.kernel.org,
Andy Shevchenko <andy.shevchenko@gmail.com>,Nishant Malpani <nish.malpani25@gmail.com>


Guido Günther (4):
  dt-bindings: iio: vcnl4000: convert bindings to YAML format
  dt-bindings: iio: light: vcnl4000: Add near-level
  iio: vcnl4000: Export near level property for proximity sensor
  Documentation: ABI: document IIO in_proximity_near_level file

 .../ABI/testing/sysfs-bus-iio-proximity       | 10 ++++
 .../bindings/iio/light/vcnl4000.txt           | 24 ---------
 .../bindings/iio/light/vishay,vcnl4000.yaml   | 53 +++++++++++++++++++
 drivers/iio/light/vcnl4000.c                  | 25 +++++++++
 4 files changed, 88 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-proximity
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml

-- 
2.23.0

