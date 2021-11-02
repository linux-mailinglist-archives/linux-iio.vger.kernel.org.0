Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE31442F9B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Nov 2021 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhKBOCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Nov 2021 10:02:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5912 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBOCv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Nov 2021 10:02:51 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A2A7Jk5003786;
        Tue, 2 Nov 2021 10:00:16 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c2dnkx7rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 10:00:15 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A2E0EVs063013
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Nov 2021 10:00:14 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 2 Nov 2021 10:00:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 2 Nov 2021 10:00:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 2 Nov 2021 10:00:13 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A2E0CvC031291;
        Tue, 2 Nov 2021 10:00:12 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2] Add support for AD7293 Power Amplifier
Date:   Tue, 2 Nov 2021 15:59:45 +0200
Message-ID: <20211102135947.131223-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LcsWmcGjPik1SiqGgI9AsTGDJUCSXPrb
X-Proofpoint-GUID: LcsWmcGjPik1SiqGgI9AsTGDJUCSXPrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=991 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020083
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7293 is a Power Amplifier drain current controller containing 
functionality for general-purpose monitoring and control of 
current, voltage, and temperature, integrated into a single chip 
solution with an SPI-compatible interface.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/AD7293.pdf

This series of patches provide an initial implementation of the
driver with access from the userspace to the:
 - ADC channels (read raw values, set range, set offset)
 - DAC channels (set code, set offset)
 - Temperature sensing (read raw values, set offset)
 - Current sensing (read raw, set offset, set gain)

Antoniu Miclaus (2):
  iio:amplifiers:ad7293: add support for AD7293
  dt-bindings:iio:amplifiers: add ad7293 doc

 .../bindings/iio/amplifiers/adi,ad7293.yaml   |  49 ++
 drivers/iio/amplifiers/Kconfig                |  11 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/ad7293.c               | 794 ++++++++++++++++++
 4 files changed, 855 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
 create mode 100644 drivers/iio/amplifiers/ad7293.c

-- 
2.33.1

