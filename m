Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D509E3502BF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhCaOvS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 10:51:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43286 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbhCaOus (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Mar 2021 10:50:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VEceGB011345;
        Wed, 31 Mar 2021 14:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=F54Hp/vKV1mmuD8poN/zo4ahre9EvaYtFY+tH2asrf0=;
 b=HDSDrc5DLZ4jYi++ozURLtz5UyuWHBqs0stxXmys0oZeS16IL+EHZLWGQuy1NB4DxNWm
 TsMBCrKyyFnSk8tQ4Yv4dwhZlUqJWVwqCAfj1DTVjqpH51OQ6CmyhpUY8D7F5xvY4EvX
 BK6ACCBdeYc2yhIaHFo2g8AOGkEuqUpn203LcwuPtOX0WEsyoiF4Ja4PZ+Xprzhq3WBI
 EYzY1ecE/cLW1/wjknLamZFXItxDILaFi0nuSCSVd0Ex3p8toC4XbMEuoibjCHKOWVIx
 xVJAiGepNjbHqpExc1xVfzyYqG211rO4eMPUDldREcyaoITRfLlb266q8g1SU92ic3zv Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37mafv2ge9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 14:50:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VEdXm2015715;
        Wed, 31 Mar 2021 14:50:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 37mabmapvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 14:50:44 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12VEoh0j005102;
        Wed, 31 Mar 2021 14:50:44 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Mar 2021 07:50:43 -0700
Date:   Wed, 31 Mar 2021 17:50:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     gwendal@chromium.org
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: hrtimer: Allow sub Hz granularity
Message-ID: <YGSMPTIRAEQRyMWb@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310106
X-Proofpoint-ORIG-GUID: ujVOE01iXYOWHlMnZS1zUhehPZpvNy00
X-Proofpoint-GUID: ujVOE01iXYOWHlMnZS1zUhehPZpvNy00
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Gwendal Grignou,

The patch dafcf4ed8392: "iio: hrtimer: Allow sub Hz granularity" from
Feb 25, 2021, leads to the following static checker warning:

	drivers/iio/trigger/iio-trig-hrtimer.c:68 iio_hrtimer_store_sampling_frequency()
	warn: assigned value is less than 'u32max'

drivers/iio/trigger/iio-trig-hrtimer.c
    49  static
    50  ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
    51                                               struct device_attribute *attr,
    52                                               const char *buf, size_t len)
    53  {
    54          struct iio_trigger *trig = to_iio_trigger(dev);
    55          struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
    56          unsigned long long val;
    57          u64 period;
    58          int integer, fract, ret;
    59  
    60          ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
    61          if (ret)
    62                  return ret;
    63          if (integer < 0 || fract < 0)
    64                  return -ERANGE;
    65  
    66          val = fract + 1000 * integer;  /* mHz */
                      ^^^^^^^^^^^^^^^^^^^^^^
"fract" and "integer" are integers so the arithmatic will wrap instead
of going above UINT_MAX

    67  
    68          if (!val || val > UINT_MAX)
                            ^^^^^^^^^^^^^^
Unpossible!

    69                  return -EINVAL;
    70  
    71          info->sampling_frequency[0] = integer;  /* Hz */
    72          info->sampling_frequency[1] = fract * 1000;  /* uHz */
    73          period = PSEC_PER_SEC;
    74          do_div(period, val);
    75          info->period = period;  /* nS */
    76  
    77          return len;
    78  }

regards,
dan carpenter
