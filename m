Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6373B7439
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jun 2021 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhF2O2B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Jun 2021 10:28:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14844 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232518AbhF2O17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jun 2021 10:27:59 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TEJ1xJ024486;
        Tue, 29 Jun 2021 10:25:32 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 39fp4btsrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 10:25:32 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 15TEPUVo030065
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jun 2021 10:25:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 29 Jun 2021 10:25:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 29 Jun 2021 10:25:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 29 Jun 2021 10:25:29 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 15TEPRhH027422;
        Tue, 29 Jun 2021 10:25:27 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2] iio: frequency: adrf6780: add support for ADRF6780
Date:   Tue, 29 Jun 2021 17:23:06 +0300
Message-ID: <20210629142308.25868-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LodfvXz3tKzrTaUXEtSYtnmkvD1ALxgb
X-Proofpoint-ORIG-GUID: LodfvXz3tKzrTaUXEtSYtnmkvD1ALxgb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290096
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the ADRF6780 microwave upconverter.

Antoniu Miclaus (2):
  iio: frequency: adrf6780: add support for ADRF6780
  dt-bindings: iio: frequency: add adrf6780 doc

 .../bindings/iio/frequency/adi,adrf6780.yaml  | 133 +++++
 drivers/iio/frequency/Kconfig                 |  13 +
 drivers/iio/frequency/Makefile                |   1 +
 drivers/iio/frequency/adrf6780.c              | 534 ++++++++++++++++++
 4 files changed, 681 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
 create mode 100644 drivers/iio/frequency/adrf6780.c

-- 
2.32.0

