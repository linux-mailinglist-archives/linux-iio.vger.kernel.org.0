Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3359545FD9
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348195AbiFJIpl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 10 Jun 2022 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiFJIpj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 04:45:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD031C13A;
        Fri, 10 Jun 2022 01:45:32 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A5dcRs010610;
        Fri, 10 Jun 2022 04:45:32 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gm00mh1h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:45:31 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 25A8jTCo027432
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 04:45:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 10 Jun
 2022 04:45:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jun 2022 04:45:28 -0400
Received: from nsa.ad.analog.com ([10.44.3.70])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 25A8imiM014275;
        Fri, 10 Jun 2022 04:44:51 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-imx@nxp.com>, <linux-renesas-soc@vger.kernel.org>,
        <linux-mips@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/34] make iio inkern interface firmware agnostic
Date:   Fri, 10 Jun 2022 10:45:11 +0200
Message-ID: <20220610084545.547700-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ECPDV-TWick4LVOEVuc0kdMXUUX-GpEN
X-Proofpoint-GUID: ECPDV-TWick4LVOEVuc0kdMXUUX-GpEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100031
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The main goal of this patchset is to convert the iio inkern interface to
be firmware agnostic. Some previous discussion was done in here [1].
Though something odd happened while sending the patches and the RFC
actually never landed in the IIO list (hopefully now works):

As suggested by Andy, the series can be seen in three blocks:

1) "Fix" all drivers that were relying on iio.h for specific header
files (mainly of.h and mod_devicetable.h). After that we can drop
of.h from iio.h and just forward declare what we need.

2) Move "most" of the IIO in kernel interface to FW API. At this point,
there's still some OF dependent API in place so that users are not broken.

3) Move all users of the IIO in kernel interface to the FW API and with
that, make IIO firmware agnostic.

On 3), the qcom-spmi-adc-tm5.c driver was only converted to use the IIO
API while on the IIO drivers a full driver conversion was done. The
thermal one would be really non trivial as we would also need to touch the
subsystem. On the IIO drivers, the conversions were mostly peacefull
(apparently). Special care for the stm32-adc.c driver though as that one
was far from being straight :).

Lastly, this is only compile tested with allyesconfig for arm and arm64.
While I surely can come up with some dummy devices to make sure I can still
properly get IIO channels, having proper tested-by tags on platforms
relying on this interface would be very appreciated (and I suspect Jonathan
will require it).

[1]: https://lore.kernel.org/linux-iio/20220604141925.129f0ffe@jic23-huawei/T/#mfd5ccd793841569182e4f831f2c46089b665c346

Nuno Sá (34):
  iio: adc: ad7606: explicitly add proper header files
  iio: adc: ad7606_par: explicitly add proper header files
  iio: adc: berlin2-adc: explicitly add proper header files
  iio: adc: imx7d_adc: explicitly add proper header files
  iio: adc: imx8qxp-adc: explicitly add proper header files
  iio: adc: ingenic-adc: explicitly add proper header files
  iio: adc: mp2629_adc: explicitly add proper header files
  iio: adc: mt6360-adc: explicitly add proper header files
  iio: adc: npcm_adc: explicitly add proper header files
  iio: adc: rzg2l_adc: explicitly add proper header files
  iio: common: cros_ec_lid_angle: explicitly add proper header files
  iio: common: cros_ec_sensors: explicitly add proper header files
  iio: dac: stm32-dac: explicitly add proper header files
  iio: dac: vf610_dac: explicitly add proper header files
  iio: humidity: hts221_buffer: explicitly add proper header files
  iio: light: cros_ec_light_prox: explicitly add proper header files
  iio: pressure: cros_ec_baro: explicitly add proper header files
  iio: trigger: stm32-lptimer-trigger: explicitly add proper header
    files
  iio: core: drop of.h from iio.h
  iio: inkern: only relase the device node when done with it
  iio: inkern: fix return value in devm_of_iio_channel_get_by_name()
  iio: inkern: only return error codes in iio_channel_get_*() APIs
  iio: inkern: split of_iio_channel_get_by_name()
  iio: inkern: move to fwnode properties
  thermal: qcom: qcom-spmi-adc-tm5: convert to IIO fwnode API
  iio: adc: ingenic-adc: convert to IIO fwnode interface
  iio: adc: ab8500-gpadc: convert to device properties
  iio: adc: at91-sama5d2_adc: convert to device properties
  iio: adc: qcom-pm8xxx-xoadc: convert to device properties
  iio: adc: qcom-spmi-vadc: convert to device properties
  iio: adc: qcom-spmi-adc5: convert to device properties
  iio: adc: stm32-adc: convert to device properties
  iio: inkern: remove OF dependencies
  iio: inkern: fix coding style warnings

 drivers/iio/adc/ab8500-gpadc.c                |  27 +-
 drivers/iio/adc/ad7606.c                      |   1 +
 drivers/iio/adc/ad7606_par.c                  |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c            |  30 +--
 drivers/iio/adc/berlin2-adc.c                 |   2 +
 drivers/iio/adc/imx7d_adc.c                   |   1 +
 drivers/iio/adc/imx8qxp-adc.c                 |   1 +
 drivers/iio/adc/ingenic-adc.c                 |   9 +-
 drivers/iio/adc/mp2629_adc.c                  |   1 +
 drivers/iio/adc/mt6360-adc.c                  |   1 +
 drivers/iio/adc/npcm_adc.c                    |   1 +
 drivers/iio/adc/qcom-pm8xxx-xoadc.c           |  58 ++---
 drivers/iio/adc/qcom-spmi-adc5.c              |  63 +++--
 drivers/iio/adc/qcom-spmi-vadc.c              |  44 ++--
 drivers/iio/adc/rzg2l_adc.c                   |   1 +
 drivers/iio/adc/stm32-adc.c                   | 128 +++++-----
 .../cros_ec_sensors/cros_ec_lid_angle.c       |   1 +
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   1 +
 drivers/iio/dac/stm32-dac.c                   |   2 +
 drivers/iio/dac/vf610_dac.c                   |   1 +
 drivers/iio/humidity/hts221_buffer.c          |   1 +
 drivers/iio/inkern.c                          | 241 +++++++++---------
 drivers/iio/light/cros_ec_light_prox.c        |   1 +
 drivers/iio/pressure/cros_ec_baro.c           |   1 +
 drivers/iio/trigger/stm32-lptimer-trigger.c   |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   3 +-
 include/linux/iio/consumer.h                  |  28 +-
 include/linux/iio/iio.h                       |   9 +-
 28 files changed, 347 insertions(+), 312 deletions(-)

-- 
2.36.1

