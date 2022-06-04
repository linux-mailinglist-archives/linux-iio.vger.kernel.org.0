Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2E53D786
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiFDPoI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiFDPoI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 11:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DBC19C2D
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 08:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D7060DF6
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 15:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6821BC34114;
        Sat,  4 Jun 2022 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654357445;
        bh=Gen5nOgK5SFmjMzhPJHfLEOIUp0Libajxpp2b5BXXZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=NnXRmqVwhsqgB45jdHT96J8ZLhieFBL3ytbAPFt5uhg9K4Sn32BJerWXvt0VZBma5
         JYL5m2K5AN7eg0V9ZGsWJ545DJUKhPT6twvBI0en1dHX9gNf6waOGOkozwPvIlF99N
         xK6gPPKz4cYJL8FZpgoetAjjk1V6LfHZzYpcFcG7rPfmTmbMdwupH/+HBtFoMelslW
         2SDybIn1a/Be4/Kb9A5TYwuFxuyNceSWVSw5y6qOXx+QRdeZbY+AocN9VbQ2p6j9vj
         gze+pzE+6C5qLNDNO6hjo3lNFBK6NtySoTaGf5I+ec2VIr8/Xx3+2rfRHRclWFrzCK
         K3L0YlBZq1JaA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 0/4] 3rd set of IIO export namespaces.
Date:   Sat,  4 Jun 2022 16:53:02 +0100
Message-Id: <20220604155306.422937-1-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since v1:
- Rebase (bit of fuzz in patches 1 and 4)

I sent v1 out in Feb and only got review on one patch (which I've since
applied - thanks Nuno).

Looking for a quick sanity check of these 4 that remain from anyone who
has the time.  Whilst this is mechanical stuff, I've made enough dumb
mistakes in such patches over the years that I still like to get a second
set of eyes on them if at all possible! 

Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>

Jonathan Cameron (4):
  iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
  iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
  iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace
  iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC namespace

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
 14 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.36.1

