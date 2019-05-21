Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE2245DA
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2019 04:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfEUCNo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 22:13:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfEUCNo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 22:13:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L26Y9k016568
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 22:13:42 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sm6ueaqy9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 22:13:42 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 21 May 2019 03:13:42 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 03:13:38 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L2DbUM2752994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 02:13:37 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B64A7805C;
        Tue, 21 May 2019 02:13:37 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C702478063;
        Tue, 21 May 2019 02:13:36 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 02:13:36 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 0/3] iio: Add driver for Infineon DPS310
Date:   Mon, 20 May 2019 21:13:31 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19052102-0036-0000-0000-00000ABEF358
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206296; UDB=6.00633418; IPR=6.00987257;
 MB=3.00026978; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 02:13:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052102-0037-0000-0000-00004BDF2BAD
Message-Id: <1558404814-26078-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210011
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The DPS310 is a temperature and pressure sensor. It can be accessed over i2c
and SPI.

The driver supports polled measurement of temperature and pressure over i2c
only.

Changes since v3:
 - Correct spacing in Kconfig
 - Safer conversion from s64 to int

Changes since v2:
 - Switch to processed rather than raw for both pressure and temperature
 - Add locking around writing frequency/sampling rates and sensor reads
 - Further cleanup

Changes since v1:
 - Switch to wait for temperature/pressure sensor ready
 - Various cleanup

Christopher Bostic (1):
  iio: dps310: Temperature measurement errata

Eddie James (1):
  iio: dps310: Add pressure sensing capability

Joel Stanley (1):
  iio: Add driver for Infineon DPS310

 MAINTAINERS                   |   6 +
 drivers/iio/pressure/Kconfig  |  11 +
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/dps310.c | 827 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 845 insertions(+)
 create mode 100644 drivers/iio/pressure/dps310.c

-- 
1.8.3.1

