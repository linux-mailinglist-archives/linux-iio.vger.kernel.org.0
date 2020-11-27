Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334922C6E9C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 04:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgK1DS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Nov 2020 22:18:26 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:44112 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730889AbgK0T4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 14:56:08 -0500
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARJaijD013911;
        Fri, 27 Nov 2020 19:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=28082020;
 bh=Ei0DtcfknakrZeJGnTpnw9OsPWEyKDEl9GawEswBnqM=;
 b=jWV3LyiK5AHeHqoBwJAzg+KB7JKQKEa4oxSCUeGPwml+Jl6DUCCVVnMY3kyI6DudLv00
 rm4mnILEG/YvVTSeq3xH0Y028esW+LO0Z4OyZmlhZd1589l3cRm3pFUwzx0/CwXCO7Og
 5P0OqSWAQ5zdX8O5N778l8ZmgnPI1n8L2JmxnuCUxrwdEADEbWrvgSV6/e9h8PZQvv7B
 Ur0C9Go4dKoU7+7RXknI9CTmMduXpFw84ZKosPQXP7DIv4gNXljOWu/QxvhAMqXw+uV2
 AEfrxQpYabKE3ix8ydC2ZEKB27FI7dtwZJ8Id5HQP2y1AEqr/Cv6yDwLsemqE6Lgva7g Iw== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 34xv3g47ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 19:42:41 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 0ARJge8O030534;
        Fri, 27 Nov 2020 20:42:40 +0100
Received: from atgrzsw3765.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 34xufsb0d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 20:42:40 +0100
Received: from atgrzsw3762.avl01.avlcorp.lan (10.37.149.15) by
 atgrzsw3765.avl01.avlcorp.lan (10.37.149.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Fri, 27 Nov 2020 20:42:40 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw3762.avl01.avlcorp.lan (10.37.149.15) with Microsoft SMTP Server id
 15.1.2044.4 via Frontend Transport; Fri, 27 Nov 2020 20:42:40 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH 0/2] Add support for ADS131E0x ADC family
Date:   Fri, 27 Nov 2020 20:42:38 +0100
Message-ID: <20201127194240.15060-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_11:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=838
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270116
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_11:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=879 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270116
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for Texas Instruments ADS131E0x
analog-to-digital converters family.

Datasheet: https://www.ti.com/lit/ds/symlink/ads131e08.pdf

Tomislav Denis (2):
  iio: adc: Add driver for Texas Instruments ADS131E0x ADC family
  bindings: iio: adc: Add documentation for ADS131E0x ADC driver

 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 145 ++++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads131e08.c                     | 826 +++++++++++++++++++++
 5 files changed, 991 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
 create mode 100644 drivers/iio/adc/ti-ads131e08.c

-- 
2.7.4

