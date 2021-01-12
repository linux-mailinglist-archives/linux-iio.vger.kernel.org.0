Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F151F2F2CBE
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 11:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405010AbhALK0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jan 2021 05:26:02 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:30388 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404204AbhALK0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2021 05:26:02 -0500
Received: from pps.filterd (m0135534.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C9pdL8030773;
        Tue, 12 Jan 2021 09:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=28082020;
 bh=EZIq5A4jz1inZZfQZU6r00tBxocM9dNEjtXRYj0nHp8=;
 b=VjHg/NLEzpR7etufDZldE5WiEQH6aGps3DOuaqRoYY05uqN7d6gCmRfdlxdO5mBbNGd5
 /hCfHpWvNc3Mrie47CVaWHw+8lyNsN5fOAyIOa59Izrbw0H5kdOvpuWZhVsJ687Maw5q
 KMdHuzoKG9naeBPzpSBkRdBHmHG7pMhibjcAWFWfY4gQeTWZuB163Hmsx2Y0vU23adXG
 oSsCToP7Uf98vSBUZmJSuXIF8o8WvcokonUrLAFLb6CNBmrsW0QRqzaQ1kLNXzBvLTXq
 joD6O/OaMVDP4KKiFOSMjfLyJAqaJn5WDa6XOsQnv9Tc/LC+mnrJhvo+9Dku4omuDF1+ AQ== 
Received: from atgrzso8133.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 35y5k6ve9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 09:51:39 +0000
Received: from pps.filterd (atgrzso8133.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8133.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 10C9XUpU031853;
        Tue, 12 Jan 2021 10:51:30 +0100
Received: from atgrzsw3760.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8133.avl01.avlcorp.lan with ESMTP id 35y3xps7dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 10:51:29 +0100
Received: from atgrzsw3763.avl01.avlcorp.lan (10.37.149.16) by
 atgrzsw3760.avl01.avlcorp.lan (10.37.149.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 12 Jan 2021 10:51:29 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw3763.avl01.avlcorp.lan (10.37.149.16) with Microsoft SMTP Server id
 15.1.2044.4 via Frontend Transport; Tue, 12 Jan 2021 10:51:29 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v3 0/2] Add support for ADS131E0x ADC family
Date:   Tue, 12 Jan 2021 10:51:26 +0100
Message-ID: <20210112095128.7112-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=963
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120053
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for Texas Instruments ADS131E0x
analog-to-digital converters family.

Datasheet: https://www.ti.com/lit/ds/symlink/ads131e08.pdf

Changes in v3:
- update driver description in Kconfig 
- reorder includes in alphabetical order
- replace all occurrences of sizeof(type) with sizeof(variable)
- validate gain and channel mux values when parsing DT
- use of_device_get_match_data insted spi_get_device_id mapping
- proper handling of devm_regulator_get_optional error
- fetch vref regulator value each time when reading the scale value
- remove spi_device_id table
- fix wrong maximum value in driver bindings


Tomislav Denis (2):
  iio: adc: Add driver for Texas Instruments ADS131E0x ADC family
  bindings: iio: adc: Add documentation for ADS131E0x ADC driver

 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 181 ++++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads131e08.c                     | 960 +++++++++++++++++++++
 5 files changed, 1161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
 create mode 100644 drivers/iio/adc/ti-ads131e08.c

-- 
2.7.4

