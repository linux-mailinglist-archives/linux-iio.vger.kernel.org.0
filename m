Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C64BD046
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiBTRaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:30:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiBTRap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:30:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CAC2409F
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:30:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F7A3B80CE4
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB531C340E8;
        Sun, 20 Feb 2022 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378221;
        bh=xPO+JzAGWtBxy2jKAvmBGoJrMFw8Dloe3tF7ZdZ3RE4=;
        h=From:To:Cc:Subject:Date:From;
        b=e8opyMk0//6scYBXoPlMS5mnB8Dv2bwADovOsxyIE8QiZKb9l1wVzjsk+H+9p/K7I
         DbfNVMKphphj2F6I2s0p2I50MsNoAsDXf3hgisHiA/Nqp5Iltti8CnkOoEVCUNQdL2
         HTd8sl42dSBr9fOuxR2NsyERSCiGqRfFX0YQcIvlYgNX9jOP9076byCoPB59h99Qp9
         6AantVhItB4NB2XFaSV9i/XQLgBM08aTOM2mCWtRgnHZgxVAaDog9STHCxIVLlZWqR
         ZWvlvKAmo8brLk1EJpCZXs2zqQWWmXzDamBLJdR+pDKb1fdFR9V3vp91DDAIrhSq3S
         dWc8aWA7pM3NQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH 0/5] 3rd set of IIO export namspaces.
Date:   Sun, 20 Feb 2022 17:36:56 +0000
Message-Id: <20220220173701.502331-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Several of these are old drivers so I'm not sure the original maintainer
/ author will take a look so if anyone else has time it would be
appreciated.  These are fairly mechanical so hopefully easy to review!

Another set where we are moving symbols intended for local use
between a clump of related modules into separate namespaces.
These are of the multiple buses + core module or library module
plus users variety.

The remaining cases in IIO are more complex so will be handled in
future patch sets.  Typically this is because of interactions with
code outside of IIO or clashes with the dev_pm_ops cleanup that
is also ongoing.

Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>

Jonathan Cameron (5):
  iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
  iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
  iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace
  iio: adc: adi-axi: Move exported symbols into IIO_ADI_AXI namespace.
  iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC namespace

 drivers/iio/adc/ad9467.c             |  1 +
 drivers/iio/adc/adi-axi-adc.c        |  4 ++--
 drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
 drivers/iio/adc/qcom-spmi-adc5.c     |  1 +
 drivers/iio/adc/qcom-spmi-vadc.c     |  1 +
 drivers/iio/adc/qcom-vadc-common.c   | 16 ++++++++--------
 drivers/iio/chemical/sps30.c         |  2 +-
 drivers/iio/chemical/sps30_i2c.c     |  1 +
 drivers/iio/chemical/sps30_serial.c  |  1 +
 drivers/iio/imu/bmi160/bmi160_core.c |  6 +++---
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  1 +
 drivers/iio/imu/bmi160/bmi160_spi.c  |  1 +
 drivers/iio/pressure/bmp280-core.c   |  2 +-
 drivers/iio/pressure/bmp280-i2c.c    |  1 +
 drivers/iio/pressure/bmp280-regmap.c |  4 ++--
 drivers/iio/pressure/bmp280-spi.c    |  1 +
 16 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.35.1

