Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F5154117
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 10:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBFJX6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 04:23:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22516 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727672AbgBFJX6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 04:23:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0169Bwco019321;
        Thu, 6 Feb 2020 04:23:56 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhnkm4cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 04:23:56 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0169Nti7025760
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 6 Feb 2020 04:23:55 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 6 Feb 2020
 04:23:54 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 6 Feb 2020 04:23:54 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0169NoIn010043;
        Thu, 6 Feb 2020 04:23:51 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/2] iio: dac: AD5770R: Add support
Date:   Thu, 6 Feb 2020 11:23:11 +0200
Message-ID: <20200206092313.18265-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=677 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002060073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series of patches adds support for the AD5570R
14-bit current DAC.

It contains changes discussed in:
https://patchwork.kernel.org/patch/10549129/

Alexandru Tachici (2):
  iio: dac: ad5770r: Add AD5770R support
  dt-bindings: iio: dac: Add docs for AD5770R DAC

 .../bindings/iio/dac/adi,ad5770r.yaml         | 176 +++++
 drivers/iio/dac/Kconfig                       |  10 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad5770r.c                     | 662 ++++++++++++++++++
 include/linux/iio/common/adi_spi_regs.h       |  44 ++
 5 files changed, 893 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
 create mode 100644 drivers/iio/dac/ad5770r.c
 create mode 100644 include/linux/iio/common/adi_spi_regs.h

-- 
2.20.1

