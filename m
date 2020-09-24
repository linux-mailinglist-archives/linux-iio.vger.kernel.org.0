Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A33276B5F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgIXIFg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 04:05:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10034 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbgIXIFf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 04:05:35 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O84TfF026770;
        Thu, 24 Sep 2020 04:05:34 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u9b82m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 04:05:33 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08O85W3o049921
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 04:05:32 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 24 Sep 2020 01:05:30 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 24 Sep 2020 01:05:30 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 01:05:30 -0700
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08O85Srq000911;
        Thu, 24 Sep 2020 04:05:28 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/4] iio: adc: ad9467: add support for AD9434 & AD9265 
Date:   Thu, 24 Sep 2020 11:05:14 +0300
Message-ID: <20200924080518.96410-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_05:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240062
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a V2 & V3 for:
  https://lore.kernel.org/linux-iio/CA+U=DspC_W=j-eET38q1v+ytbntUXQwvUCBKx0DJ9hDGVtV-OA@mail.gmail.com/T/

V2 is:
  https://lore.kernel.org/linux-iio/20200922132559.38456-1-alexandru.ardelean@analog.com/T/

It does a bit of rework/unification of the 2 chip-info constants, so
that it's easier to add new devices 2 this driver.
V1 only added only AD9434, but when adding AD9265, I noticed that some
things could be a bit more unified for vref_mask & default_output_mode.

In V3 the dt-bindings patches were merged and the docs polished a bit.

Changelog v2 -> v3:
* merge dt-bindings patches from v2 into a single one
* polish the dt-bindings docs to better cover/describe new parts

Changelog v1 -> v2:
* add AD9265 support
* wrap axi-adc chip-info, to also define vref_mask & default_output_mode
  in the chip-info table

Alexandru Ardelean (2):
  iio: adc: ad9467: wrap a axi-adc chip-info into a ad9467_chip_info
    type
  dt-bindings: iio: ad9467: add entries for for AD9434 & AD9265 ADCs

Michael Hennerich (2):
  iio: adc: ad9467: add support for AD9434 high-speed ADC
  iio: adc: ad9467: add support for AD9265 high-speed ADC

 .../bindings/iio/adc/adi,ad9467.yaml          |  15 ++-
 drivers/iio/adc/ad9467.c                      | 121 +++++++++++++-----
 2 files changed, 100 insertions(+), 36 deletions(-)

-- 
2.25.1

