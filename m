Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F9D1D7A26
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERNiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:38:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64474 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbgERNiX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:38:23 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IDYv5n017131;
        Mon, 18 May 2020 09:38:20 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 312d35nn4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:38:19 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04IDcIpe060429
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 18 May 2020 09:38:18 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 May 2020 06:38:17 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 May 2020 06:38:16 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 18 May 2020 06:38:16 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04IDcEMj025859;
        Mon, 18 May 2020 09:38:14 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <ak@it-klinger.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: proximity: ping: pass reference to IIO device as param to ping_read()
Date:   Mon, 18 May 2020 16:38:13 +0300
Message-ID: <20200518133813.403903-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180121
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since there will be some changes to how iio_priv_to_dev() is implemented,
it could be that the helper becomes a bit slower, as it will be hidden away
in the IIO core.

But even without that rework, this looks like it can pass the 'indio_dev'
object to ping_read() and obtain the state struct via iio_priv() which is a
preferred practice than going back-n-forth (getting the state-struct, then
using iio_priv_to_dev() to get the indio_dev object back).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* split away from series
* pass 'indio_dev' to ping_read() and get the info via iio_priv()

 drivers/iio/proximity/ping.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index 12b893c5b0ee..2e99eeb27f2e 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -89,14 +89,14 @@ static irqreturn_t ping_handle_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int ping_read(struct ping_data *data)
+static int ping_read(struct iio_dev *indio_dev)
 {
+	struct ping_data *data = iio_priv(indio_dev);
 	int ret;
 	ktime_t ktime_dt;
 	s64 dt_ns;
 	u32 time_ns, distance_mm;
 	struct platform_device *pdev = to_platform_device(data->dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(data);
 
 	/*
 	 * just one read-echo-cycle can take place at a time
@@ -228,7 +228,6 @@ static int ping_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long info)
 {
-	struct ping_data *data = iio_priv(indio_dev);
 	int ret;
 
 	if (channel->type != IIO_DISTANCE)
@@ -236,7 +235,7 @@ static int ping_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ping_read(data);
+		ret = ping_read(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
-- 
2.25.1

