Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DFD44AD8F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 13:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbhKIMeq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 07:34:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33646 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241539AbhKIMeq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 07:34:46 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A98v5pH019618;
        Tue, 9 Nov 2021 07:32:00 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c7156xte9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 07:31:59 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A9CVw2p052994
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Nov 2021 07:31:58 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 9 Nov 2021 04:31:57 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 9 Nov 2021 04:31:56 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 9 Nov 2021 04:31:56 -0800
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A9CVsSu007733;
        Tue, 9 Nov 2021 07:31:55 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/4] Add support for ADMV8818
Date:   Tue, 9 Nov 2021 14:31:23 +0200
Message-ID: <20211109123127.96399-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: F3fSEDiNXfOLUsaY2hqzXfGj1iwzxAQ3
X-Proofpoint-ORIG-GUID: F3fSEDiNXfOLUsaY2hqzXfGj1iwzxAQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=702 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADMV8818-EP is a fully monolithic microwave integrated 
circuit (MMIC) that features a digitally selectable frequency of 
operation. The device features four independently controlled high-
pass filters (HPFs) and four independently controlled low-pass 
filters (LPFs) that span the 2 GHz to 18 GHz frequency range.

This patch series includes a proposal to add a subsection in the
IIO subsystem for filter drivers.

NOTE:
Currently depends on 64-bit architecture since the input
clock that server as RFIN should support values
in the range 2 GHz to 18 GHz.

We might need some scaling implementation in the clock
framework so that u64 types are supported when using 32-bit
architectures.

Antoniu Miclaus (4):
  iio: add filter subfolder
  iio:filter:admv8818: add support for ADMV8818
  dt-bindings:iio:filter: add admv8818 doc
  iio:filter:admv8818: Add sysfs ABI documentation

 .../ABI/testing/sysfs-bus-iio-filter-admv8818 |  60 ++
 .../bindings/iio/filter/adi,admv8818.yaml     |  78 ++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/filter/Kconfig                    |  18 +
 drivers/iio/filter/Makefile                   |   7 +
 drivers/iio/filter/admv8818.c                 | 819 ++++++++++++++++++
 7 files changed, 984 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
 create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
 create mode 100644 drivers/iio/filter/Kconfig
 create mode 100644 drivers/iio/filter/Makefile
 create mode 100644 drivers/iio/filter/admv8818.c

-- 
2.33.1

