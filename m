Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD62394242
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhE1MC5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 08:02:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhE1MC4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 May 2021 08:02:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SBxavO112113;
        Fri, 28 May 2021 12:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=W9036lewVKlFIApqZNhO+zl0/OIn6ZeusuWBc3qKX5c=;
 b=nRjkb+3IDeNh6c158I0waf6kJa396fItbBKV80vHucNeg/Omkn/eLtWPSlip1FmxTjDz
 xI3xgo+4D1BOOhMmtaoMeL1ETSrhrXU5tuo6o4djENAxFkmFWZAtoeUEykJkoaCmwfym
 bwLuPIl/PWwkL114+XBUvgTR7Wz9F8Sd15tqu28zGAbYpuUIpo9zJ6HsMZygQ2zBaqMY
 dLhLkV35PRAXde53foXfltXTOKU0dJ3EVopwT4nHf0CbBfIPN1EggQMnq8oA4HhjRFFG
 PhYcLAMsXwLrmr9R0YlauBms26jAqUlF6Jp9ZMawxpsxVjWYXdoZ/P0Z7DpSwOKREWpM tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ptkpeuu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 12:01:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SC0bOs012001;
        Fri, 28 May 2021 12:01:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38rehkrvcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 12:01:12 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14SC18bl017404;
        Fri, 28 May 2021 12:01:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38rehkruyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 12:01:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14SC0v5i030004;
        Fri, 28 May 2021 12:00:57 GMT
Received: from mwanda (/10.175.203.144)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 May 2021 05:00:57 -0700
Date:   Fri, 28 May 2021 15:00:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jic23@cam.ac.uk
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] staging:iio:sca3000 extract old event handling and move
 to poll for events from buffer
Message-ID: <YLDbdN688C0xBgMn@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: D9gVOZ_2t3uYC7R7xvsVguyQk8zHRcx8
X-Proofpoint-ORIG-GUID: D9gVOZ_2t3uYC7R7xvsVguyQk8zHRcx8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280080
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan Cameron,

The patch 25888dc51163: "staging:iio:sca3000 extract old event
handling and move to poll for events from buffer" from May 18, 2011,
leads to the following static checker warning:

	drivers/iio/accel/sca3000.c:734 sca3000_read_raw()
	warn: no-op. '((*val) << 19) >> 19'

drivers/iio/accel/sca3000.c
   709  static int sca3000_read_raw(struct iio_dev *indio_dev,
   710                              struct iio_chan_spec const *chan,
   711                              int *val,
   712                              int *val2,
   713                              long mask)
   714  {
   715          struct sca3000_state *st = iio_priv(indio_dev);
   716          int ret;
   717          u8 address;
   718  
   719          switch (mask) {
   720          case IIO_CHAN_INFO_RAW:
   721                  mutex_lock(&st->lock);
   722                  if (chan->type == IIO_ACCEL) {
   723                          if (st->mo_det_use_count) {
   724                                  mutex_unlock(&st->lock);
   725                                  return -EBUSY;
   726                          }
   727                          address = sca3000_addresses[chan->address][0];
   728                          ret = sca3000_read_data_short(st, address, 2);
   729                          if (ret < 0) {
   730                                  mutex_unlock(&st->lock);
   731                                  return ret;
   732                          }
   733                          *val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
   734                          *val = ((*val) << (sizeof(*val) * 8 - 13)) >>
                                                  ^^^^^^^^^^^^^^^^^^^^^^^
   735                                  (sizeof(*val) * 8 - 13);
                                        ^^^^^^^^^^^^^^^^^^^^^^^

This code works, but it relies on undefined behavior of left shift
overflow and it's very unsatisfying.  Pretty sure there is a UBSan
warning for this at runtime.

   736                  } else {
   737                          /* get the temperature when available */
   738                          ret = sca3000_read_data_short(st,
   739                                                        SCA3000_REG_TEMP_MSB_ADDR,
   740                                                        2);
   741                          if (ret < 0) {
   742                                  mutex_unlock(&st->lock);
   743                                  return ret;
   744                          }
   745                          *val = ((st->rx[0] & 0x3F) << 3) |
   746                                 ((st->rx[1] & 0xE0) >> 5);
   747                  }
   748                  mutex_unlock(&st->lock);
   749                  return IIO_VAL_INT;

regards,
dan carpenter
