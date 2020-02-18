Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C01625EC
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 13:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgBRMLc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 07:11:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1914 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgBRMLc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 07:11:32 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IC3Mql011959;
        Tue, 18 Feb 2020 07:11:31 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y6eeb6u66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 07:11:31 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01ICBTBD008060
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 18 Feb 2020 07:11:29 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 18 Feb 2020 04:11:28 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 18 Feb 2020 04:11:27 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ICBOF4029392;
        Tue, 18 Feb 2020 07:11:25 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v4 0/2] iio: dac: AD5770R: Add support
Date:   Tue, 18 Feb 2020 14:10:29 +0200
Message-ID: <20200218121031.27233-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=836 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series of patches adds support for the AD5570R
14-bit current DAC.

Changelog V3 -> V4:

- make use of GENMASK in defines
- added a DMA safe buffer for regmap_bulk_read/writeval
- removed of_match_ptr
- removed DVdd supply from dt bindings as the datasheet
specifies that must have same voltage as AVdd

Alexandru Tachici (2):
  iio: dac: ad5770r: Add AD5770R support
  dt-bindings: iio: dac: Add docs for AD5770R DAC

 .../bindings/iio/dac/adi,ad5770r.yaml         | 188 +++++
 drivers/iio/dac/Kconfig                       |  10 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad5770r.c                     | 695 ++++++++++++++++++
 4 files changed, 894 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
 create mode 100644 drivers/iio/dac/ad5770r.c

-- 
2.20.1

