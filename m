Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E702742EB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIVN0U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 09:26:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20046 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgIVN0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 09:26:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MDMT0t017278;
        Tue, 22 Sep 2020 09:26:19 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33new49vcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 09:26:19 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08MDQIVZ062803
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 22 Sep 2020 09:26:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 22 Sep 2020 09:26:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 22 Sep 2020 09:26:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 22 Sep 2020 09:26:18 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08MDQCon015940;
        Tue, 22 Sep 2020 09:26:13 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 0/5] iio: adc: ad9467: add support for AD9434 & AD9265
Date:   Tue, 22 Sep 2020 16:25:54 +0300
Message-ID: <20200922132559.38456-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_12:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220104
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a V2 for:
  https://lore.kernel.org/linux-iio/CA+U=DspC_W=j-eET38q1v+ytbntUXQwvUCBKx0DJ9hDGVtV-OA@mail.gmail.com/T/

It does a bit of rework/unification of the 2 chip-info constants, so
that it's easier to add new devices 2 this driver.
V1 only added only AD9434, but when adding AD9265, I noticed that some
things could be a bit more unified for vref_mask & default_output_mode.

Changelog v1 -> v2:
* add AD9265 support
* wrap axi-adc chip-info, to also define vref_mask & default_output_mode
  in the chip-info table

Alexandru Ardelean (3):
  iio: adc: ad9467: wrap a axi-adc chip-info into a ad9467_chip_info
    type
  dt-bindings: iio: ad9467: add entry for for AD9434 ADC
  dt-bindings: iio: ad9467: add entry for for AD9265 ADC

Michael Hennerich (2):
  iio: adc: ad9467: add support for AD9434 high-speed ADC
  iio: adc: ad9467: add support for AD9265 high-speed ADC

 .../bindings/iio/adc/adi,ad9467.yaml          |   2 +
 drivers/iio/adc/ad9467.c                      | 121 +++++++++++++-----
 2 files changed, 90 insertions(+), 33 deletions(-)

-- 
2.17.1

