Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE738AD39
	for <lists+linux-iio@lfdr.de>; Thu, 20 May 2021 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhETMAO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 May 2021 08:00:14 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25948 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241582AbhETL6L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 May 2021 07:58:11 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KBtHEh006443;
        Thu, 20 May 2021 07:56:38 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 38n0hv4bb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 07:56:38 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 14KBubwr035310
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 07:56:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 20 May 2021
 07:56:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 20 May 2021 07:56:36 -0400
Received: from nsa.sphairon.box ([10.44.3.50])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 14KBuXal007744;
        Thu, 20 May 2021 07:56:34 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/2] Make use of adis lock helpers
Date:   Thu, 20 May 2021 13:59:07 +0200
Message-ID: <20210520115909.466275-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: t-h5hQT7V0XVImGqV6Yh1ZeTNhCLT-eP
X-Proofpoint-ORIG-GUID: t-h5hQT7V0XVImGqV6Yh1ZeTNhCLT-eP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_03:2021-05-20,2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=528
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200092
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In [1], some helpers were added to the adis lib to make things a bit
more neater when users need to use the device lock. Somehow, these two
users were left "behind". Let's make things consistent and make them use
the helpers.
 
[1]: https://patchwork.kernel.org/project/linux-iio/patch/20210218114039.216091-5-nuno.sa@analog.com/

Nuno Sá (2):
  iio: adis16260: make use of adis lock helpers
  iio: adis16136: make use of adis lock helpers

 drivers/iio/gyro/adis16136.c | 15 ++++++---------
 drivers/iio/gyro/adis16260.c |  4 ++--
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.31.1

