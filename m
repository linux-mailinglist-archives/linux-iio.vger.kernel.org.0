Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9C14CC36
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 15:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA2OV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jan 2020 09:21:29 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgA2OV3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2020 09:21:29 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TEDYPs012775;
        Wed, 29 Jan 2020 09:21:06 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xrkfam72s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 09:21:06 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00TEL5b6039244
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 29 Jan 2020 09:21:05 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 29 Jan
 2020 09:21:03 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 29 Jan 2020 06:21:03 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00TEKwxe027599;
        Wed, 29 Jan 2020 09:20:59 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v4 0/5] Add hmc425a support
Date:   Wed, 29 Jan 2020 16:22:56 +0200
Message-ID: <20200129142301.13918-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_03:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=613 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v4:
-handle db patch was added
-gpiod_set_array_value_cansleep call was updated

Beniamin Bia (4):
  iio: core: Handle 'dB' suffix in core
  iio: amplifiers: ad8366: Add write_raw_get_fmt function
  iio: amplifiers: hmc425a: Add support for HMC425A attenuator
  MAINTAINERS: add entry for hmc425a driver.

Michael Hennerich (1):
  dt-bindings: iio: amplifiers: Add docs for HMC425A Step Attenuator

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  48 ++++
 MAINTAINERS                                   |   9 +
 drivers/iio/amplifiers/Kconfig                |  10 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/ad8366.c               |  13 +
 drivers/iio/amplifiers/hmc425a.c              | 256 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  35 ++-
 7 files changed, 369 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
 create mode 100644 drivers/iio/amplifiers/hmc425a.c

-- 
2.17.1

