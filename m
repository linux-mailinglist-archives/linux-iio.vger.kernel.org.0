Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9BD43765E
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJVMHf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Oct 2021 08:07:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60572 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbhJVMHe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Oct 2021 08:07:34 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19M5oUx8013923;
        Fri, 22 Oct 2021 08:05:06 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bucbnmn3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 08:05:05 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 19MC4srD008431
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Oct 2021 08:04:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 22 Oct 2021
 08:04:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 22 Oct 2021 08:04:53 -0400
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.18])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 19MC4nKo018003;
        Fri, 22 Oct 2021 08:04:50 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v4 0/2] drivers:iio:dac: Add AD3552R driver support
Date:   Fri, 22 Oct 2021 12:04:25 +0000
Message-ID: <20211022120427.99516-1-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oslOB9TL1MARhW_z-Tg37Ut-Gz8gXiXz
X-Proofpoint-ORIG-GUID: oslOB9TL1MARhW_z-Tg37Ut-Gz8gXiXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_03,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=898
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220068
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v1 -> v2:
  - https://lore.kernel.org/all/20211008123909.1901-1-mihail.chindris@analog.com
  - Order compatilbe in alphabetic order
  - Fix comments in yaml
  - Grup struct by types
  - Drop usless "if (err)"
  - Handle error in ad3552r_read_reg_wrapper
  - ad3552r_find_range: u32 -> s32
  - Add fwnode_handle_put(custom_gain_child); in good path too
  - Vals[0] -> val
  - Fix: fwnode_handle_put in ad3552r_configure_device
  - Fix indio_dev->name
  - Rename custom_gain_child -> gain_child
  - Remove intermediary functions and write code inline where possible
  - Add ad3552r_field_prep helper function
  - Dev_err -> dev_warn for vref supply check
  - Replace dev_err with dev_err_probe
  - Remove channel for simultaneous update and do update mask register if both
    channels values are the same.

Changelog v0 -> v1:
  - Split https://lore.kernel.org/all/20210820165927.4524-1-mihail.chindris@analog.com
    and move ad3552r driver to this serie.
  - Remove precision_mode abi
  - Remove adi,synch_channels dt property
  - Use vref-supply instead of adi,vref-select
  - Remove unimplemented spi modes
  - Change output-range format and use enums
  - Update description for custom-output-range-config to be more clear
  - Add datasheet tag
  - Use GENMASK for defines
  - Remove tomicro define
  - Use get_unaligned_be16 and put_unaligned_be16
  - Remove unnecessary checks
  - Add comment for AD3552R_CH_DAC_PAGE channel
  - Fix indent
  - Remove irq trigger
  - Remove irelevant checks
  - Rename ad3552r_read_reg_pool to ad3552r_read_reg_wrapper.
  - Add support for ad3542r

V0:
  * Add ad3552r example to https://lore.kernel.org/linux-iio/20210219124012.92897-1-alexandru.ardelean@analog.com

Mihail Chindris (2):
  dt-bindings: iio: dac: Add adi,ad3552r.yaml
  drivers:iio:dac: Add AD3552R driver support

 .../bindings/iio/dac/adi,ad3552r.yaml         |  190 +++
 drivers/iio/dac/Kconfig                       |   10 +
 drivers/iio/dac/Makefile                      |    1 +
 drivers/iio/dac/ad3552r.c                     | 1199 +++++++++++++++++
 4 files changed, 1400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 create mode 100644 drivers/iio/dac/ad3552r.c


base-commit: ef226dcf3d88697a06335fbc55c4263ab164b135
-- 
2.27.0

