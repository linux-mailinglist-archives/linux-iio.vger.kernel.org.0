Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1806990D2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 11:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBPKNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 05:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBPKNa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 05:13:30 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE7518CF
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 02:13:28 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G9ob1X002341;
        Thu, 16 Feb 2023 05:13:11 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ns89qb1vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 05:13:10 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 31GAD9O3042594
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Feb 2023 05:13:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 16 Feb
 2023 05:13:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 16 Feb 2023 05:13:08 -0500
Received: from nsa.sphairon.box ([10.44.3.102])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 31GAD0rt028929;
        Thu, 16 Feb 2023 05:13:06 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/3] iio: buffer: make sure O_NONBLOCK is respected
Date:   Thu, 16 Feb 2023 11:14:51 +0100
Message-ID: <20230216101452.591805-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216101452.591805-1-nuno.sa@analog.com>
References: <20230216101452.591805-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: VGV6LwmizW9LA0TM7UT0Ff2hTF6FeVfK
X-Proofpoint-GUID: VGV6LwmizW9LA0TM7UT0Ff2hTF6FeVfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160085
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For output buffers, there's no guarantee that the buffer won't be full
in the first iteration of the loop in which case we would block
independently of userspace passing O_NONBLOCK or not. Fix it by always
checking the flag before going to sleep.

While at it (and as it's a bit related), refactored the loop so that the
stop condition is 'written != n', i.e, run the loop until all data has
been copied into the IIO buffers. This makes the code a bit simpler.

Fixes: 9eeee3b0bf190 ("iio: Add output buffer support")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c56cf748fde1..7e7ee307a3f7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -203,21 +203,24 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 				break;
 			}
 
+			if (filp->f_flags & O_NONBLOCK) {
+				if (!written)
+					ret = -EAGAIN;
+				break;
+			}
+
 			wait_woken(&wait, TASK_INTERRUPTIBLE,
 					MAX_SCHEDULE_TIMEOUT);
 			continue;
 		}
 
 		ret = rb->access->write(rb, n - written, buf + written);
-		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
-			ret = -EAGAIN;
+		if (ret < 0)
+			break;
 
-		if (ret > 0) {
-			written += ret;
-			if (written != n && !(filp->f_flags & O_NONBLOCK))
-				continue;
-		}
-	} while (ret == 0);
+		written += ret;
+
+	} while (written != n);
 	remove_wait_queue(&rb->pollq, &wait);
 
 	return ret < 0 ? ret : written;
-- 
2.39.2

