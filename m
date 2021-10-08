Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E7D426B0B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbhJHMlh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 08:41:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12540 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241191AbhJHMlg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 08:41:36 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1981GEhW003102;
        Fri, 8 Oct 2021 08:39:28 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bhtt1pwur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 08:39:27 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 198CdPnP033746
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Oct 2021 08:39:26 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 8 Oct 2021 05:39:24 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 8 Oct 2021 05:39:24 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 198CdLda026676;
        Fri, 8 Oct 2021 08:39:22 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v2 0/2] Add ad3552r and ad3542r driver support
Date:   Fri, 8 Oct 2021 12:39:07 +0000
Message-ID: <20211008123909.1901-1-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Moc7Mqd6dzxCx5YKXDGe3kE5LoDSX4ZL
X-Proofpoint-GUID: Moc7Mqd6dzxCx5YKXDGe3kE5LoDSX4ZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110080075
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

 .../bindings/iio/dac/adi,ad3552r.yaml         |  199 +++
 drivers/iio/dac/Kconfig                       |   10 +
 drivers/iio/dac/Makefile                      |    1 +
 drivers/iio/dac/ad3552r.c                     | 1396 +++++++++++++++++
 4 files changed, 1606 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 create mode 100644 drivers/iio/dac/ad3552r.c

-- 
2.27.0

