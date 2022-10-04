Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBA5F44B5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJDNtm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 4 Oct 2022 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJDNtj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 09:49:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F32B250
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 06:49:32 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294Dbamp005506;
        Tue, 4 Oct 2022 09:48:29 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxfd73nf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:48:28 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 294DmRSc001528
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Oct 2022 09:48:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Oct 2022
 09:48:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Oct 2022 09:48:26 -0400
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 294DlkVX032663;
        Tue, 4 Oct 2022 09:47:49 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 00/16] Make 'mlock' really private
Date:   Tue, 4 Oct 2022 15:48:53 +0200
Message-ID: <20221004134909.1692021-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: PTY91YZxN3rY6kTbfI0Li0-AOheAoNfO
X-Proofpoint-ORIG-GUID: PTY91YZxN3rY6kTbfI0Li0-AOheAoNfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=495 clxscore=1011 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040089
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

Note that this series was only compiled tested using allyesconfig for
ARM. I ran 'git grep' to make sure there were no more users of 'mlock'.
Hopefully I covered them all...

v2:

[PATCH 1-8, 10-12/16]
 * Mention the inclusion of mutex.h in the commit message.

[PATCH 1-8, 10, 12/16]
 * Initialize mutex as late as possible.
Note that [PATCH 11/16] was not included since the code to do so was not
direct enough. Would need to get a pointer to the private struture
outside of scmi_alloc_iiodev() to do it. While not hard, the added changes
in the code is not really worth it (IMO of course).

[PATCH 1/16]
 * Refactored the commit message a bit. I guess this one will still needs
more discussion...

[PATCH 9/16]
 * New patch to add an helper function to read the samples.

[PATCH 13/16]
 * New patch to introduce iio_device_{claim|release}_buffer_mode() APIs.

[PATCH 14/16]
 * Make use of the new iio_device_{claim|release}_buffer_mode() helpers

[PATCH 15/16]
 * Make use of the new iio_device_{claim|release}_buffer_mode() helpers
in combination with claim_direct_mode(). This is needed so that we make sure
we always get one of the modes (and hence the iio_dev lock) to safely call
max30102_get_temp(). Note that I'm not particular "happy" with the code but
OTOH, it does not look as bad as I thought :). Anyways, if there are no
complains with it, I'm ok to leave it as-is. Otherwise, I think we can think
on the flag approach (briefly discussed in the first series).

Nuno Sá (16):
  iio: adc: ad799x: do not use internal iio_dev lock
  iio: adc: axp288_adc: do not use internal iio_dev lock
  iio: adc: imx7d_adc: do not use internal iio_dev lock
  iio: adc: lpc32xx_adc: do not use internal iio_dev lock
  iio: adc: ltc2947-core: do not use internal iio_dev lock
  iio: adc: meson_saradc: do not use internal iio_dev lock
  iio: adc: rockchip_saradc: do not use internal iio_dev lock
  iio: adc: sc27xx_adc: do not use internal iio_dev lock
  iio: adc: vf610_adc: add helper function to read samples
  iio: adc: vf610_adc: vf610_adc: do not use internal iio_dev lock
  iio: common: scmi_iio: do not use internal iio_dev lock
  iio: gyro: itg3200_core: do not use internal iio_dev lock
  iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs
  iio: health: max30100: do not use internal iio_dev lock
  iio: health: max30102: do not use internal iio_dev lock
  iio: core: move 'mlock' to 'struct iio_dev_opaque'

 drivers/iio/TODO                           |   3 -
 drivers/iio/adc/ad799x.c                   |  20 ++--
 drivers/iio/adc/axp288_adc.c               |  10 +-
 drivers/iio/adc/imx7d_adc.c                |  14 ++-
 drivers/iio/adc/lpc32xx_adc.c              |  11 ++-
 drivers/iio/adc/ltc2497-core.c             |   7 +-
 drivers/iio/adc/ltc2497.h                  |   2 +
 drivers/iio/adc/meson_saradc.c             |  11 ++-
 drivers/iio/adc/rockchip_saradc.c          |  15 ++-
 drivers/iio/adc/sc27xx_adc.c               |  14 ++-
 drivers/iio/adc/vf610_adc.c                | 104 ++++++++++++---------
 drivers/iio/common/scmi_sensors/scmi_iio.c |   9 +-
 drivers/iio/gyro/itg3200_core.c            |  10 +-
 drivers/iio/health/max30100.c              |   9 +-
 drivers/iio/health/max30102.c              |  19 +++-
 drivers/iio/industrialio-buffer.c          |  29 +++---
 drivers/iio/industrialio-core.c            |  58 ++++++++++--
 drivers/iio/industrialio-event.c           |   4 +-
 drivers/iio/industrialio-trigger.c         |  12 +--
 include/linux/iio/gyro/itg3200.h           |   2 +
 include/linux/iio/iio-opaque.h             |   2 +
 include/linux/iio/iio.h                    |   5 +-
 22 files changed, 249 insertions(+), 121 deletions(-)

-- 
2.37.3

