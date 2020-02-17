Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E11613C9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2020 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgBQNoz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Feb 2020 08:44:55 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:39754 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgBQNoy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Feb 2020 08:44:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E533BFB05;
        Mon, 17 Feb 2020 14:44:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uI-uJxWnMmcJ; Mon, 17 Feb 2020 14:44:49 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 47D3640FE5; Mon, 17 Feb 2020 14:44:48 +0100 (CET)
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
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: vcnl4000: Export near level property for proximity sensor
Date:   Mon, 17 Feb 2020 14:44:46 +0100
Message-Id: <cover.1581947007.git.agx@sigxcpu.org>
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

[1]: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/merge_requests/298
[2]: https://lore.kernel.org/linux-iio/20200210154153.GA26903@bogon.m.sigxcpu.org/

Guido Günther (2):
  iio: vcnl4000: Export near level property for proximity sensor
  dt-bindings: iio: light: vcnl4000: Add near-level

 .../bindings/iio/light/vcnl4000.txt           |  6 +++++
 drivers/iio/light/vcnl4000.c                  | 26 +++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.23.0

