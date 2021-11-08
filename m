Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8010A447BC3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhKHI2W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 03:28:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57514 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236740AbhKHI2V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 03:28:21 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A85jHET000480;
        Mon, 8 Nov 2021 03:25:25 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c5pm6ytew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 03:25:25 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1A88PONu046548
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Nov 2021 03:25:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 8 Nov 2021 03:25:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 8 Nov 2021 03:25:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Mon, 8 Nov 2021 03:25:22 -0500
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.18])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A88PJeF001294;
        Mon, 8 Nov 2021 03:25:20 -0500
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v5 0/2] drivers:iio:dac: Add AD3552R driver support
Date:   Mon, 8 Nov 2021 08:24:45 +0000
Message-ID: <20211108082447.116663-1-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 493qRhUGg9R_zSnXh4sqj73FSWsFpkQJ
X-Proofpoint-GUID: 493qRhUGg9R_zSnXh4sqj73FSWsFpkQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=851
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog v4 -> v5:
  - https://lore.kernel.org/all/20211022120427.99516-1-mihail.chindris@analog.com
  - Add changelog for previous version
  - Extend lock comment
  - Remove unused variable is_custom

Changelog v3 -> v4:
  - https://lore.kernel.org/all/20211021070924.18626-1-mihail.chindris@analog.com
  - Remove trigger.h
  - Use dev_err_probe only where needed
  - Add comment about buff size
  - Fix mutex order
  - Return from all switch cases
  - Return int in ad3552r_read_reg_wrapper
  - Add goto put_child where missing
  - Restructure ad3552r_write_codes
  - Move ad3552r_write_codes nex to ad3552r_trigger_handler
  - Use memcpy and memcmp in ad3552r_write_codes
  - Remove endieness functions in ad3552r_write_codes

Changelog v2 -> v3:
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

Changelog v0 -> v2:
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

