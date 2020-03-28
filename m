Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C44196762
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgC1QfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 12:35:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57334 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgC1QfL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 12:35:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02SGThAm019757;
        Sat, 28 Mar 2020 12:34:58 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e694mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Mar 2020 12:34:58 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02SGYvbV015127
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 28 Mar 2020 12:34:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Sat, 28 Mar
 2020 12:34:56 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 28 Mar 2020 12:34:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02SGYqUV010131;
        Sat, 28 Mar 2020 12:34:53 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer: drop left-over 'stufftoread' field
Date:   Sat, 28 Mar 2020 18:34:21 +0200
Message-ID: <20200328163421.69784-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-28_06:2020-03-27,2020-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=962
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003280157
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This seems like a left-over from a7348347ba8a4 ("staging:iio: Add polling
of events on the ring access chrdev.").

Then it was moved into the sca3000 driver around 9dd4694dafbd8 ("iio:
staging: sca3000: hide stufftoread logic"), and that one seemed to be the
only user of this.

Then it eventually was no longer used after 152a6a884ae1
("staging:iio:accel:sca3000 move to hybrid hard / soft buffer design.")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/buffer_impl.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index a4d2d8061ef6..1e7edf6bed96 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -115,9 +115,6 @@ struct iio_buffer {
 	 */
 	struct attribute_group scan_el_group;
 
-	/* @stufftoread: Flag to indicate new data. */
-	bool stufftoread;
-
 	/* @attrs: Standard attributes of the buffer. */
 	const struct attribute **attrs;
 
-- 
2.17.1

