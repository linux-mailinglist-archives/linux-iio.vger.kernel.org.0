Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5C2EA9EA
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbhAELan (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 06:30:43 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:37038 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbhAELan (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jan 2021 06:30:43 -0500
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 105B7luo030107;
        Tue, 5 Jan 2021 11:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=28082020;
 bh=B9nCcG7LWkjGp+yHKN5/qQpRSUC0jsFyq7RcU1QoHso=;
 b=ZOZTMjlDlWfrSwjldr1WfZGlLDmp+YI463dJ4i01UG5Eodh+4g36dmklrrOwi6AKyhd/
 cwWFyXoaGU1ves8DJRSY5+tv8vrmL5UKxm1GMDzeXt3k90OeONDj+K5hJd4hF4WcKXpP
 UdrjZ1QVscndr58tVm1BLn6pLG1NDSqHegz2Z0skg8cunNfDLAhK+S5m1y5bZC3QsfaM
 A801uMty7bKI4XZPQzuqPqSMxM6vA4ATh8hWgycoXpLEw6V4dsIQP5fVoc5zZeLMHWsg
 qW1MtOoNTKAxQl1wYgz2/xWq4BmJWBlEBsKrpDMwj4eB2ilxJkT7fJTYjY4imjOCmtY1 ww== 
Received: from atgrzso8133.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 35tj1h3ym0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 11:08:42 +0000
Received: from pps.filterd (atgrzso8133.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8133.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 105B4s8w006743;
        Tue, 5 Jan 2021 12:08:41 +0100
Received: from atgrzsw3759.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8133.avl01.avlcorp.lan with ESMTP id 35tg9p8vfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 12:08:41 +0100
Received: from atgrzsw3764.avl01.avlcorp.lan (10.37.149.17) by
 atgrzsw3759.avl01.avlcorp.lan (10.37.149.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 5 Jan 2021 12:08:41 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw3764.avl01.avlcorp.lan (10.37.149.17) with Microsoft SMTP Server id
 15.1.2044.4 via Frontend Transport; Tue, 5 Jan 2021 12:08:40 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v2 0/2] Add support for ADS131E0x ADC family
Date:   Tue, 5 Jan 2021 12:08:37 +0100
Message-ID: <20210105110839.5436-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050068
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for Texas Instruments ADS131E0x
analog-to-digital converters family.

Datasheet: https://www.ti.com/lit/ds/symlink/ads131e08.pdf

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
 drivers/iio/adc/ti-ads131e08.c                     | 921 +++++++++++++++++++++
 5 files changed, 1122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
 create mode 100644 drivers/iio/adc/ti-ads131e08.c

-- 
2.7.4

