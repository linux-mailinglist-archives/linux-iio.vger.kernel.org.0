Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F310B20ED05
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgF3Eys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 00:54:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35658 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgF3Eys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 00:54:48 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U4qanq000352;
        Tue, 30 Jun 2020 00:54:30 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31x315fr8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:54:30 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05U4sSbQ023141
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 30 Jun 2020 00:54:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 00:54:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 00:54:27 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 30 Jun 2020 00:54:27 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05U4sPIj018305;
        Tue, 30 Jun 2020 00:54:26 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 0/7]  iio: core: wrap IIO device into an iio_dev_opaque object
Date:   Tue, 30 Jun 2020 07:57:01 +0300
Message-ID: <20200630045708.14166-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change starts to hide some internal fields of the IIO device into
the framework.

This patchset assumes that all drivers have been addressed with respect
to the use of iio_priv_to_dev(), so the first patch in the series (now)
is to remove it, so that we don't need to move it.

Changelog v3 -> v4:
* added ifdef guard for iio_get_debugfs_dentry();
  Reported-by: kernel test robot <lkp@intel.com>

V2 series:
   https://patchwork.kernel.org/patch/11548709/
   https://lore.kernel.org/linux-iio/20200514131710.84201-1-alexandru.ardelean@analog.com/
Referencing them, since it took a bit longer to get to V3

Changelog v2 -> v3:
- no driver should use iio_priv_to_dev() now; all drivers that use it
  should have been taken care by now; and as a result, all patches from
  v2 are no longer here
- added patch that just removes iio_priv_to_dev()
- for patch 'iio: core: wrap IIO device into an iio_dev_opaque object'
  added comment about 'priv' field that it must be accessed via
  iio_priv() helper
- patch 'iio: core: simplify alloc alignment code' removed
  added 'iio: core: remove padding from private information' instead
- v2 did not address too many movements from iio_dev -> iio_dev_opaque
  this patchset introduces a few more, the ones that seemed easier;
  v2 only had 'iio: core: move debugfs data on the private iio dev info'
  anything after that was added in v3

Changelog v1 -> v2:
- add pre-work patches that remove some calls to iio_priv_to_dev() from
  interrupt handlers
- renamed iio_dev_priv -> iio_dev_opaque
- moved the iio_dev_opaque to 'include/linux/iio/iio-opaque.h' this way
  it should be usable for debugging
- the iio_priv() call, is still an inline function that returns an
  'indio_dev->priv' reference; this field is added to 'struct iio_dev';
  the reference is computed in iio_device_alloc() and should be
  cacheline aligned
- the to_iio_dev_opaque() container is in the
  'include/linux/iio/iio-opaque.h' header; it's still implemented with
  some pointer arithmetic; one idea was to do it via an
  'indio_dev->opaque' field; that may still be an optionif there are
  some opinions in that direction

Alexandru Ardelean (7):
  iio: core: remove iio_priv_to_dev() helper
  iio: core: wrap IIO device into an iio_dev_opaque object
  iio: core: remove padding from private information
  iio: core: move debugfs data on the private iio dev info
  iio: core: move channel list & group to private iio device object
  iio: core: move iio_dev's buffer_list to the private iio device object
  iio: core: move event interface on the opaque struct

 drivers/iio/industrialio-buffer.c |  38 ++++++----
 drivers/iio/industrialio-core.c   | 120 +++++++++++++++++++-----------
 drivers/iio/industrialio-event.c  |  68 ++++++++++-------
 include/linux/iio/iio-opaque.h    |  36 +++++++++
 include/linux/iio/iio.h           |  35 ++-------
 5 files changed, 182 insertions(+), 115 deletions(-)
 create mode 100644 include/linux/iio/iio-opaque.h

-- 
2.17.1

