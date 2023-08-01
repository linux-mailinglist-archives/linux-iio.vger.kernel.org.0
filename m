Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D5876BBA1
	for <lists+linux-iio@lfdr.de>; Tue,  1 Aug 2023 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjHARtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Aug 2023 13:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjHARtW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Aug 2023 13:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001F72134
        for <linux-iio@vger.kernel.org>; Tue,  1 Aug 2023 10:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735B261662
        for <linux-iio@vger.kernel.org>; Tue,  1 Aug 2023 17:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1388BC433C8;
        Tue,  1 Aug 2023 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690912158;
        bh=nuVuge49yIDhKSqc8iiA5iJ8AUYTzA61vJb3X/LYK70=;
        h=Date:From:To:Subject:From;
        b=XjNjavar7kSLMyB5xdDLOpKmWytxlyI+jv2vLJ3gWI+lqxxeAjf2KPtJtzPbNhGPn
         TbgQ7i2YPu8x/cVfaqOnAdTTrzHJbZMjZsd9rKR9eG0gocT8oerZ2PX9hjSJn2zPgb
         kTupno1NvvEAxTnSl8gTbY0epb3Np+QrQ/GobxwaELULitSRtS+/uv0T0grNqWfx6S
         +SuHz0X9dxViMiHLxYg5hH7ORdMNYFaOobu0ZPIa/dyqvus+hmkxqjpSFbleWhC1hc
         NOKZ2861Fafj83lbAQErQi3pVdiP5WTLgRZu2JGgtlOPxQWrd+rgTqaMAEEBymuFID
         3KaIps3ei96fQ==
Date:   Tue, 1 Aug 2023 18:49:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 6.5
Message-ID: <20230801184913.40a1cdde@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.5a

for you to fetch changes up to 8a4629055ef55177b5b63dab1ecce676bd8cccdd:

  iio: cros_ec: Fix the allocation size for cros_ec_command (2023-07-29 12:=
21:21 +0100)

----------------------------------------------------------------
1st set of IIO fixes for 6.5

Usual mixed bag of fixes for recently introduced issues and ones from way
back that have recently been noticed.

* core
  - Avoid a device with no parent issues seen on the dummy example device.
* adi,ad71145
  - Drop ref now that dt-schema supports -nanoamp.
* adi,ad7192
  - Fix wrong bit set for enabling AC excitation and exposure of control
    on devices without the feature.
* adi,admv1013
  - Don't ignore errors from regulator_get_voltage().
* amlogic,meson-adc
  - Make sure clocks enabled early enough.
* google,cros_ec
  - Fix undersized cros_ec_command allocation that resulted in a buffer
    overrun.
* rohm,bu27008
  - Fix truncation issue with scale format that prevents smallest value
    being set
  - Report intensity as unsigned. Previously large values would be
    interpretted as negative intensities (and odd concept).
* rohm,bu27034
  - Fix truncation issue with scale format that prevents smallest value
    being set.
* st,lsm6dsx
  - Return an error code, not false (which is 0 and hence success)
    to indicate ACPI mount matrix retrieval failed due to no ACPI
    support.
* ti,ina2xx
  - Avoid a NULL pointer dereference if fall back compatible is used.

----------------------------------------------------------------
Alejandro Tafalla (1):
      iio: imu: lsm6dsx: Fix mount matrix retrieval

Alisa Roman (1):
      iio: adc: ad7192: Fix ac excitation feature

Alvin =C5=A0ipraga (1):
      iio: adc: ina2xx: avoid NULL pointer dereference on OF device match

Dan Carpenter (1):
      iio: frequency: admv1013: propagate errors from regulator_get_voltage=
()

George Stark (1):
      iio: adc: meson: fix core clock enable/disable moment

Krzysztof Kozlowski (1):
      dt-bindings: iio: adi,ad74115: remove ref from -nanoamp

Matti Vaittinen (3):
      iio: light: bu27034: Fix scale format
      iio: light: bu27008: Fix scale format
      iio: light: bu27008: Fix intensity data type

Milan Zamazal (1):
      iio: core: Prevent invalid memory access when there is no parent

Yiyuan Guo (1):
      iio: cros_ec: Fix the allocation size for cros_ec_command

 .../devicetree/bindings/iio/addac/adi,ad74115.yaml |  3 ---
 drivers/iio/adc/ad7192.c                           | 16 +++++++--------
 drivers/iio/adc/ina2xx-adc.c                       |  9 ++++++---
 drivers/iio/adc/meson_saradc.c                     | 23 +++++++++++-------=
----
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  2 +-
 drivers/iio/frequency/admv1013.c                   |  5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  2 +-
 drivers/iio/industrialio-core.c                    |  5 +++--
 drivers/iio/light/rohm-bu27008.c                   | 22 ++++++++++++++++++=
---
 drivers/iio/light/rohm-bu27034.c                   | 22 ++++++++++++++++++=
---
 10 files changed, 73 insertions(+), 36 deletions(-)
