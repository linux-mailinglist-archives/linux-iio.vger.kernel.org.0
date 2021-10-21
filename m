Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B91435B6C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 09:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJUHMl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 03:12:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34360 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhJUHMl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 03:12:41 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L5mlci032180;
        Thu, 21 Oct 2021 03:10:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3btqxwaxkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 03:10:13 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 19L7AB8O037058
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Oct 2021 03:10:12 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 21 Oct 2021 00:10:10 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 21 Oct 2021 00:10:10 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 21 Oct 2021 00:10:10 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.18])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 19L7A67k003171;
        Thu, 21 Oct 2021 03:10:06 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v3 0/2] drivers:iio:dac: Add AD3552R driver support
Date:   Thu, 21 Oct 2021 07:09:23 +0000
Message-ID: <20211021070924.18626-1-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: jbx2UVI1ftO7ucrxufPJOlvK3RWXXwrj
X-Proofpoint-GUID: jbx2UVI1ftO7ucrxufPJOlvK3RWXXwrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 mlxlogscore=904
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210033
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
 drivers/iio/dac/ad3552r.c                     | 1208 +++++++++++++++++
 4 files changed, 1409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 create mode 100644 drivers/iio/dac/ad3552r.c


base-commit: ef226dcf3d88697a06335fbc55c4263ab164b135
-- 
2.27.0

