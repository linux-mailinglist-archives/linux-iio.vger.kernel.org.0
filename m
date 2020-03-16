Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2261B187172
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 18:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbgCPRq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 13:46:27 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54068 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732140AbgCPRq1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 13:46:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B61C4FB03;
        Mon, 16 Mar 2020 18:46:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AzjLZ3JXf229; Mon, 16 Mar 2020 18:46:21 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B8EB640D86; Mon, 16 Mar 2020 18:46:20 +0100 (CET)
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
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] iio: vcnl4000: Export near level property for proximity sensor
Date:   Mon, 16 Mar 2020 18:46:16 +0100
Message-Id: <cover.1584380360.git.agx@sigxcpu.org>
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

Changes from v1:
- as per review comments by Jonathan Cameron
  https://lore.kernel.org/linux-iio/20200221120519.43b72007@archlinux/
  Document new sysfs file in Documentation/ABI/testing/sysfs-bus-iio-proximity
- convert bindings to yaml
- bindings: fix typo in near-level property

[1]: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/merge_requests/298
[2]: https://lore.kernel.org/linux-iio/20200210154153.GA26903@bogon.m.sigxcpu.org/

Guido Günther (4):
  dt-bindings: iio: vcnl4000: convert bindings to YAML format
  dt-bindings: iio: light: vcnl4000: Add near-level
  iio: vcnl4000: Export near level property for proximity sensor
  Documentation: ABI: document IIO in_proximity_near_level file

 .../ABI/testing/sysfs-bus-iio-proximity       | 10 ++++
 .../bindings/iio/light/vcnl4000.txt           | 24 ---------
 .../bindings/iio/light/vcnl4000.yaml          | 53 +++++++++++++++++++
 drivers/iio/light/vcnl4000.c                  | 26 +++++++++
 4 files changed, 89 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-proximity
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.yaml

-- 
2.23.0

