Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C327212A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 12:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIUKcc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 06:32:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2436 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIUKcc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 06:32:32 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LAWKle025450;
        Mon, 21 Sep 2020 06:32:30 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33new45dwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 06:32:30 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08LAWT0D058384
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Sep 2020 06:32:29 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 21 Sep 2020 06:32:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 21 Sep 2020 06:32:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Sep 2020 06:32:31 -0400
Received: from saturn.ad.analog.com ([10.48.65.111])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08LAWQsK019526;
        Mon, 21 Sep 2020 06:32:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2 v2] iio: event: use short-hand variable in iio_device_{un}register_eventset functions
Date:   Mon, 21 Sep 2020 13:31:55 +0300
Message-ID: <20200921103156.194748-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_02:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=2 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009210077
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the recent 'iio_dev_opaque' variable name, these two functions are
looking a bit ugly.

This change uses an 'ev_int' variable for the
iio_device_{un}register_eventset functions to make the code a little easier
to read.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* move 'iio_dev_opaque->event_interface = ev_int;' assigment right after
  allocation to avoid crash; 'iio_dev_opaque->event_interface' is accessed
  after init

 drivers/iio/industrialio-event.c | 50 +++++++++++++++-----------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 2ab4d4c44427..a85919eb7c4a 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -477,6 +477,7 @@ static const char *iio_event_group_name = "events";
 int iio_device_register_eventset(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_event_interface *ev_int;
 	struct iio_dev_attr *p;
 	int ret = 0, attrcount_orig = 0, attrcount, attrn;
 	struct attribute **attr;
@@ -485,14 +486,15 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 	      iio_check_for_dynamic_events(indio_dev)))
 		return 0;
 
-	iio_dev_opaque->event_interface =
-		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
-	if (iio_dev_opaque->event_interface == NULL)
+	ev_int = kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
+	if (ev_int == NULL)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&iio_dev_opaque->event_interface->dev_attr_list);
+	iio_dev_opaque->event_interface = ev_int;
+
+	INIT_LIST_HEAD(&ev_int->dev_attr_list);
 
-	iio_setup_ev_int(iio_dev_opaque->event_interface);
+	iio_setup_ev_int(ev_int);
 	if (indio_dev->info->event_attrs != NULL) {
 		attr = indio_dev->info->event_attrs->attrs;
 		while (*attr++ != NULL)
@@ -506,34 +508,29 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 		attrcount += ret;
 	}
 
-	iio_dev_opaque->event_interface->group.name = iio_event_group_name;
-	iio_dev_opaque->event_interface->group.attrs = kcalloc(attrcount + 1,
-							  sizeof(iio_dev_opaque->event_interface->group.attrs[0]),
-							  GFP_KERNEL);
-	if (iio_dev_opaque->event_interface->group.attrs == NULL) {
+	ev_int->group.name = iio_event_group_name;
+	ev_int->group.attrs = kcalloc(attrcount + 1,
+				      sizeof(ev_int->group.attrs[0]),
+				      GFP_KERNEL);
+	if (ev_int->group.attrs == NULL) {
 		ret = -ENOMEM;
 		goto error_free_setup_event_lines;
 	}
 	if (indio_dev->info->event_attrs)
-		memcpy(iio_dev_opaque->event_interface->group.attrs,
+		memcpy(ev_int->group.attrs,
 		       indio_dev->info->event_attrs->attrs,
-		       sizeof(iio_dev_opaque->event_interface->group.attrs[0])
-		       *attrcount_orig);
+		       sizeof(ev_int->group.attrs[0]) * attrcount_orig);
 	attrn = attrcount_orig;
 	/* Add all elements from the list. */
-	list_for_each_entry(p,
-			    &iio_dev_opaque->event_interface->dev_attr_list,
-			    l)
-		iio_dev_opaque->event_interface->group.attrs[attrn++] =
-			&p->dev_attr.attr;
-	indio_dev->groups[indio_dev->groupcounter++] =
-		&iio_dev_opaque->event_interface->group;
+	list_for_each_entry(p, &ev_int->dev_attr_list, l)
+		ev_int->group.attrs[attrn++] = &p->dev_attr.attr;
+	indio_dev->groups[indio_dev->groupcounter++] = &ev_int->group;
 
 	return 0;
 
 error_free_setup_event_lines:
-	iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
-	kfree(iio_dev_opaque->event_interface);
+	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
+	kfree(ev_int);
 	iio_dev_opaque->event_interface = NULL;
 	return ret;
 }
@@ -557,10 +554,11 @@ void iio_device_wakeup_eventset(struct iio_dev *indio_dev)
 void iio_device_unregister_eventset(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
 
-	if (iio_dev_opaque->event_interface == NULL)
+	if (ev_int == NULL)
 		return;
-	iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
-	kfree(iio_dev_opaque->event_interface->group.attrs);
-	kfree(iio_dev_opaque->event_interface);
+	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
+	kfree(ev_int->group.attrs);
+	kfree(ev_int);
 }
-- 
2.25.1

