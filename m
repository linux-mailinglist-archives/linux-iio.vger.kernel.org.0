Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE77230BA25
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhBBIl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 03:41:59 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:42138 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231968AbhBBIl5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 03:41:57 -0500
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1128W6Xt019122;
        Tue, 2 Feb 2021 08:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=28082020;
 bh=+gbhGgPtICUmJyZZ5NL1RemYtfy8I3XboKuvJSehDrY=;
 b=vp/isQjTSNLDq91mf7jA4c4+TxbqTgknAw3LWPQ5shWvbt4JgQ/AsYEk4xAyOsPw0LW5
 oTIwP0cc1LYgO3vawpb7v5bcx1xCKwAGibCMX0nMqbIzMbCtzukJDWdm1tWWHe7rEYle
 feRadBP8S29H5CnlBiXIDOU5vNTu4HM+D8H210oO3J0lzDpMeG9Cgr8PqG82CQES0pob
 YQupeWnXws6TnK6EvGo5QpvRvGpHn0Q+1nLtYXEBa4JYmZ8WQLVl2h0ShhjJXtBiqdWm
 3mDm4iWv861IzG4M7FYBhsFJprAUx+2ZliRDHe8fsARJqDIXqSsGiiaAm6rDPrI1C5w/ OA== 
Received: from atgrzso2833.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 36d4r8m1a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 08:41:09 +0000
Received: from pps.filterd (atgrzso2833.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2833.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 1128ZIDw025437;
        Tue, 2 Feb 2021 09:41:08 +0100
Received: from atgrzsw3764.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2833.avl01.avlcorp.lan with ESMTP id 36d01s12wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 09:41:08 +0100
Received: from atgrzsw3767.avl01.avlcorp.lan (10.37.149.20) by
 atgrzsw3764.avl01.avlcorp.lan (10.37.149.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 2 Feb 2021 09:41:08 +0100
Received: from atgrzsw3765.avl01.avlcorp.lan (10.37.149.18) by
 atgrzsw3767.avl01.avlcorp.lan (10.37.149.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 2 Feb 2021 09:41:08 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw3765.avl01.avlcorp.lan (10.37.149.18) with Microsoft SMTP Server id
 15.1.2044.4 via Frontend Transport; Tue, 2 Feb 2021 09:41:07 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v4 0/2] Add support for ADS131E0x ADC family
Date:   Tue, 2 Feb 2021 09:41:05 +0100
Message-ID: <20210202084107.3260-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_04:2021-01-29,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020059
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_04:2021-01-29,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for Texas Instruments ADS131E0x
analog-to-digital converters family.

Datasheet: https://www.ti.com/lit/ds/symlink/ads131e08.pdf

Changes in v4:
- regroup includes and add blank lines between groups
- update and rename some of defines
- remove  all __func__ occurrences from logging statements
- replace all occurrences of the pre increment with the
  post increment operator 
- optimize return statements
- use for_each_clear_bit where is possible
- use fwnode API instead of the OF API
- use dev_err_probe to avoid spam when deferred
- support use of other triggers

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

Changes in v2:
- refactor SPI communication and use DMA safe buffers
- supplay timestamp when sample data is added to the buffer
- do trigger pooling in top half instead threaded IRQ
- refactor external/internal voltage reference logic
- make everything device managed by using devm_add_action_or_reset
- make data rate runtime controllable insted DT parameter
- use generic ADC channel binding for DT channel configuration
- replace global PGA gain with PGA gain per channel
- add support for channel input selection(muliplexer)
- don't use validate_device in iio_trigger_ops struct
- drop the unneceseary return ret;
- minor changes on defines

Tomislav Denis (2):
  iio: adc: Add driver for Texas Instruments ADS131E0x ADC family
  bindings: iio: adc: Add documentation for ADS131E0x ADC driver

 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 181 ++++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads131e08.c                     | 948 +++++++++++++++++++++
 5 files changed, 1149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
 create mode 100644 drivers/iio/adc/ti-ads131e08.c

-- 
2.7.4

