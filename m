Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81E5BE467
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiITL2o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 20 Sep 2022 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiITL2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 07:28:42 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB26BD76
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 04:28:40 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K81m58025096;
        Tue, 20 Sep 2022 07:27:47 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jpn468r05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 07:27:46 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 28KBRjx6060583
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 07:27:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 07:27:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 07:27:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Sep 2022 07:27:44 -0400
Received: from nsa.ad.analog.com ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28KBR4UM021723;
        Tue, 20 Sep 2022 07:27:06 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>
CC:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: [PATCH 00/15] Make 'mlock' really private
Date:   Tue, 20 Sep 2022 13:28:06 +0200
Message-ID: <20220920112821.975359-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ctBCY4ybaJjBC-Xu6-vuJs0JpagJPQLg
X-Proofpoint-GUID: ctBCY4ybaJjBC-Xu6-vuJs0JpagJPQLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=524 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200068
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset cleans all the drivers directly using the iio_device 'mlock'.
This lock is private and should not be used outside the core (or by using
proper helpers).

Most of the conversions where straight, but there are some that really need
extra looking. Mainly patches [13/15] and [14/15] were a bit hacky since
iio_device_claim_direct_mode() does not fit 100%. The reason is that we
want to check if the device is buffering and do something if it is (in
which case the API return -EBUSY and released the lock. I just used a
combinations of locks to get around this (hopefully I did not messed up).

I was also not sure if patch [1/15] deserves a Fixes: tag but, to me, it
is really fixing a potential race so I added it.

Note that this series was only compiled tested using allyesconfig for
ARM. I ran 'git grep' to make sure there were no more users of 'mlock'.
Hopefully I covered them all...

Nuno Sá (15):
  iio: adc: ad_sigma_delta: do not use internal iio_dev lock
  iio: adc: ad799x: do not use internal iio_dev lock
  iio: adc: axp288_adc: do not use internal iio_dev lock
  iio: adc: imx7d_adc: do not use internal iio_dev lock
  iio: adc: lpc32xx_adc: do not use internal iio_dev lock
  iio: adc: ltc2947-core: do not use internal iio_dev lock
  iio: adc: meson_saradc: do not use internal iio_dev lock
  iio: adc: rockchip_saradc: do not use internal iio_dev lock
  iio: adc: sc27xx_adc: do not use internal iio_dev lock
  iio: adc: vf610_adc: do not use internal iio_dev lock
  iio: common: scmi_iio: do not use internal iio_dev lock
  iio: fyro: itg3200_core: do not use internal iio_dev lock
  iio: health: max30100: do not use internal iio_dev lock
  iio: health: max30102: do not use internal iio_dev lock
  iio: core: move 'mlock' to 'struct iio_dev_opaque'

 drivers/iio/TODO                           |  3 ---
 drivers/iio/adc/ad799x.c                   | 18 ++++++++-----
 drivers/iio/adc/ad_sigma_delta.c           |  8 +++---
 drivers/iio/adc/axp288_adc.c               |  8 ++++--
 drivers/iio/adc/imx7d_adc.c                | 13 ++++++----
 drivers/iio/adc/lpc32xx_adc.c              | 10 +++++---
 drivers/iio/adc/ltc2497-core.c             |  7 +++--
 drivers/iio/adc/ltc2497.h                  |  2 ++
 drivers/iio/adc/meson_saradc.c             | 10 +++++---
 drivers/iio/adc/rockchip_saradc.c          | 14 ++++++----
 drivers/iio/adc/sc27xx_adc.c               | 12 ++++++---
 drivers/iio/adc/vf610_adc.c                | 30 ++++++++++++++--------
 drivers/iio/common/scmi_sensors/scmi_iio.c |  9 +++++--
 drivers/iio/gyro/itg3200_core.c            |  9 ++++---
 drivers/iio/health/max30100.c              | 24 ++++++++++++-----
 drivers/iio/health/max30102.c              | 25 +++++++++++++-----
 drivers/iio/industrialio-buffer.c          | 29 ++++++++++++---------
 drivers/iio/industrialio-core.c            | 18 +++++++------
 drivers/iio/industrialio-event.c           |  4 +--
 drivers/iio/industrialio-trigger.c         | 12 ++++-----
 include/linux/iio/gyro/itg3200.h           |  2 ++
 include/linux/iio/iio-opaque.h             |  2 ++
 include/linux/iio/iio.h                    |  3 ---
 23 files changed, 175 insertions(+), 97 deletions(-)

-- 
2.37.3

