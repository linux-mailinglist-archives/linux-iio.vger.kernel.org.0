Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6365FEF5
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jan 2023 11:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjAFK33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Jan 2023 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjAFK3K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2023 05:29:10 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12077ADB
        for <linux-iio@vger.kernel.org>; Fri,  6 Jan 2023 02:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673000633;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xXWN0JLNNWC5aqdxD0XTD77v4zFe1nWhTAQPGVQl0mc=;
    b=Crkfh+w8xTNgwRhC1g+uzLJ2978goN0Tvh6d5qOHVp+NNw/+SAX4sz1Um1z2CUSNLn
    SCtMzvKH4BSK59ubavQ9M2ONVZF/KUfqFKRaP0LSliS2wpDIsBuvfxFO0AOr32PnHMV9
    JFsdFdt5eTzD2eipEvbVGLYqukOT/VmsuL93DeASxQTQFOJjj53qZ1s33TTO9FBZkFik
    7hXzd0rFYiNfSXtTrhukAmXufI26OFMU9h2RlAO1/iZN2FW6H7A9Cd8Ik0ze2Rwhyz1r
    Jzq4uLILjpNdTkvZsh+OBbMzgRbE4fU9Iqndt6/DpbRmN8VgwUD3mrcBqKCMvE5As2h3
    AE1g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIRvweFeMkcg="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349z06ANrqz5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 6 Jan 2023 11:23:53 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/3] iio: st-sensors: Add LSM303C accelerometer+magnetometer
Date:   Fri,  6 Jan 2023 11:22:36 +0100
Message-Id: <20230106102239.9647-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the ST LSM303C [1] accelerometer and magnetometer combo 
sensor in st_accel and st_magn. LSM303C seems to be more or less
a combination of LIS2HH12 as accelerometer and LIS3MDL as magnetometer
so this series just adds two new compatibles for the two sensors that 
are already supported.

[1]: https://www.st.com/resource/en/datasheet/lsm303c.pdf

Stephan Gerhold (3):
  dt-bindings: iio: st-sensors: Add LSM303C accelerometer+magnetometer
  iio: accel: st_accel: Add LSM303C
  iio: magnetometer: st_magn: Add LSM303C

 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++
 drivers/iio/accel/Kconfig                                | 2 +-
 drivers/iio/accel/st_accel.h                             | 1 +
 drivers/iio/accel/st_accel_core.c                        | 1 +
 drivers/iio/accel/st_accel_i2c.c                         | 5 +++++
 drivers/iio/accel/st_accel_spi.c                         | 5 +++++
 drivers/iio/magnetometer/Kconfig                         | 2 +-
 drivers/iio/magnetometer/st_magn.h                       | 1 +
 drivers/iio/magnetometer/st_magn_core.c                  | 1 +
 drivers/iio/magnetometer/st_magn_i2c.c                   | 5 +++++
 drivers/iio/magnetometer/st_magn_spi.c                   | 5 +++++
 11 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.39.0

