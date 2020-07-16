Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2108221FEE
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGPJoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 05:44:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61196 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbgGPJoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 05:44:09 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G9eB6b031078;
        Thu, 16 Jul 2020 05:44:08 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3279gmq8hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 05:44:08 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06G9i6K7057819
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Jul 2020 05:44:07 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 16 Jul
 2020 02:44:05 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jul 2020 02:44:05 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06G9i21m001073;
        Thu, 16 Jul 2020 05:44:03 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: iio:adc:ltc2371: add support for ltc2361/ltc2363
Date:   Thu, 16 Jul 2020 12:46:08 +0300
Message-ID: <20200716094611.81746-1-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_05:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=743 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160075
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v1->v2:
- document power supply in yaml
- reorder enums in alphabetical order
- add missing include
- drop the of_match_ptr protection

Darius Berghe (3):
  ltc2471: add of_match_table for existing devices
  ltc2471: ltc2461/ltc2463 compatible strings
  ltc2471 driver yaml

 .../bindings/iio/adc/adi,ltc2471.yaml         | 49 +++++++++++++++++++
 drivers/iio/adc/ltc2471.c                     | 25 ++++++++--
 2 files changed, 70 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml

-- 
2.27.0

