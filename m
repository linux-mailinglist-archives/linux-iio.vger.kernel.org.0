Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A81D30F263
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 12:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhBDLg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 06:36:26 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34904 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235649AbhBDLd6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 06:33:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114BUWo9015856;
        Thu, 4 Feb 2021 06:33:11 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36dbud5vec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 06:33:11 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 114BXAKV054304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 4 Feb 2021 06:33:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 4 Feb 2021
 06:33:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 4 Feb 2021 06:33:09 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 114BX7Yn009001;
        Thu, 4 Feb 2021 06:33:08 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] iio: adc: ad7124: allow 16 channels
Date:   Thu, 4 Feb 2021 13:35:49 +0200
Message-ID: <20210204113551.68744-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_06:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040072
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

AD7124-8 can have up to 16 pseudo-differential channels
enabled simultaneously and only 8 configurations. In this
scenario we cannot assign one configuration per channel,
some channels will have to share configurations like, ODR,
gain and filter parameters.

Allow the user to specify channels and configurations
separately in device-tree and assign, if needed, the same
configuration to multiple channels.

If two channels share the configuration changing the
sampling rate of one will change the sampling rate of the
other too.

Alexandru Tachici (2):
  iio: adc: ad7124: allow 16 channels
  dt-bindings: iio: adc: ad7124: add config nodes

 .../bindings/iio/adc/adi,ad7124.yaml          |  72 +++++--
 drivers/iio/adc/ad7124.c                      | 183 +++++++++++-------
 2 files changed, 166 insertions(+), 89 deletions(-)

-- 
2.20.1

