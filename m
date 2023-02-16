Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398116990D4
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 11:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBPKNd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Feb 2023 05:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBPKNb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 05:13:31 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB37518E3
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 02:13:29 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G7CH8C030246;
        Thu, 16 Feb 2023 05:13:09 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ns8cytyvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 05:13:09 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 31GAD8XN042588
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Feb 2023 05:13:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 16 Feb
 2023 05:13:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 16 Feb 2023 05:13:07 -0500
Received: from nsa.sphairon.box ([10.44.3.102])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 31GAD0rr028929;
        Thu, 16 Feb 2023 05:13:02 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] output buffer write fops fixes
Date:   Thu, 16 Feb 2023 11:14:49 +0100
Message-ID: <20230216101452.591805-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: sYGCOMubTlY8bVIA2pi7LR3Ip70wK-cZ
X-Proofpoint-GUID: sYGCOMubTlY8bVIA2pi7LR3Ip70wK-cZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=827 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1031 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160085
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds some fixes for output buffers:

1) Always return the number of bytes that we effectively copied;
2) Make sure we never block if O_NONBLOCK is passed.

With 2) some refactoring was done on the loop which makes it (IMHO) a bit
neater. Also note all of this is by code inspection and not really tested
on a real system. Even though the changes are fairly trivial, I do intend
to run a small test to make sure nothing basic broke.

Since I was touching this file, I jut felt I could fix all the checkpatch
complains :)

Nuno Sá (3):
  iio: buffer: correctly return bytes written in output buffers
  iio: buffer: make sure O_NONBLOCK is respected
  iio: buffer: fix coding style warnings

 drivers/iio/industrialio-buffer.c | 119 +++++++++++++++---------------
 1 file changed, 61 insertions(+), 58 deletions(-)

-- 
2.39.2

