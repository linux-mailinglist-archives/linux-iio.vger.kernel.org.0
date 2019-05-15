Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377081FA1D
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2019 20:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfEOSl0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 May 2019 14:41:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbfEOSl0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 May 2019 14:41:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FIX2AD003995
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2019 14:41:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgnshqp0t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2019 14:41:24 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 15 May 2019 19:41:24 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 19:41:20 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FIfJ6516056340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 18:41:19 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C42C6057;
        Wed, 15 May 2019 18:41:19 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 611F8C6055;
        Wed, 15 May 2019 18:41:19 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 May 2019 18:41:19 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 0/3] iio: Add driver for Infineon DPS310
Date:   Wed, 15 May 2019 13:41:14 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19051518-0036-0000-0000-00000ABB1E9A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011102; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203784; UDB=6.00631895; IPR=6.00984711;
 MB=3.00026906; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-15 18:41:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051518-0037-0000-0000-00004BCDBA63
Message-Id: <1557945677-12838-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150112
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The DPS310 is a temperature and pressure sensor. It can be accessed over i2c
and SPI.

The driver supports polled measurement of temperature and pressure over i2c
only.

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
 drivers/iio/pressure/Kconfig  |  10 +
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/dps310.c | 824 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 841 insertions(+)
 create mode 100644 drivers/iio/pressure/dps310.c

-- 
1.8.3.1

