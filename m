Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E575FC826
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJLPRB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 12 Oct 2022 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJLPQs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 11:16:48 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98103CE9AE
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 08:16:40 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CEGmL2000662;
        Wed, 12 Oct 2022 11:15:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3k3645e13d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 11:15:38 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 29CFFbEs045454
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Oct 2022 11:15:37 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Oct 2022 11:15:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Oct 2022 11:15:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Oct 2022 11:15:36 -0400
Received: from nsa.ad.analog.com ([10.44.3.62])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 29CFEunb022095;
        Wed, 12 Oct 2022 11:14:59 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux-imx@nxp.com>
CC:     Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 0/4] Make 'mlock' really private
Date:   Wed, 12 Oct 2022 17:16:16 +0200
Message-ID: <20221012151620.1725215-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: r_C5qfRQbavOxvOQkH8WZcF4BbERRqlw
X-Proofpoint-ORIG-GUID: r_C5qfRQbavOxvOQkH8WZcF4BbERRqlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=796 priorityscore=1501
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120100
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

v3:

[PATCH 1/4]
 * fix 'make W=1' warning about prototypes mismatch.

[PATCH 2/4]
 * improved commit message to explain why we are shadowing error codes.

[PATCH 4/4]
 * minor English fix on the commit message (as suggested by Andy).

Nuno Sá (4):
  iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs
  iio: health: max30100: do not use internal iio_dev lock
  iio: health: max30102: do not use internal iio_dev lock
  iio: core: move 'mlock' to 'struct iio_dev_opaque'

 drivers/iio/TODO                   |  3 --
 drivers/iio/health/max30100.c      |  9 ++---
 drivers/iio/health/max30102.c      | 19 +++++++---
 drivers/iio/industrialio-buffer.c  | 29 ++++++++-------
 drivers/iio/industrialio-core.c    | 58 +++++++++++++++++++++++++-----
 drivers/iio/industrialio-event.c   |  4 +--
 drivers/iio/industrialio-trigger.c | 12 +++----
 include/linux/iio/iio-opaque.h     |  2 ++
 include/linux/iio/iio.h            |  5 ++-
 9 files changed, 97 insertions(+), 44 deletions(-)

-- 
2.38.0

