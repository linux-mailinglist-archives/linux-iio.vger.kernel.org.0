Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5027212D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 12:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIUKcf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 06:32:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2634 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbgIUKcd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 06:32:33 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LAUFxE028356;
        Mon, 21 Sep 2020 06:32:32 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33nbu6617y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 06:32:32 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08LAWV3K058395
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Sep 2020 06:32:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 21 Sep 2020 06:32:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 21 Sep 2020 06:32:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Sep 2020 06:32:32 -0400
Received: from saturn.ad.analog.com ([10.48.65.111])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08LAWQsL019526;
        Mon, 21 Sep 2020 06:32:28 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2 v2] iio: event: NULL-ify IIO device's event_interface ref during unregister
Date:   Mon, 21 Sep 2020 13:31:56 +0300
Message-ID: <20200921103156.194748-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921103156.194748-1-alexandru.ardelean@analog.com>
References: <20200921103156.194748-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_02:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=2 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210077
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Though we know that the iio_device_unregister_eventset() call is followed
by the free-ing of the IIO device object, we should not make this
assumption in the iio_device_unregister_eventset() function. It should
allow for the clean unregistering of the event-set, allowing a re-register
should we decide to implement this at some point later.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index a85919eb7c4a..99ba657b8568 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -561,4 +561,5 @@ void iio_device_unregister_eventset(struct iio_dev *indio_dev)
 	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
 	kfree(ev_int->group.attrs);
 	kfree(ev_int);
+	iio_dev_opaque->event_interface = NULL;
 }
-- 
2.25.1

