Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68B22E939
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 11:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgG0JkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 05:40:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43268 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgG0JkE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 05:40:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06R9bkRw111423;
        Mon, 27 Jul 2020 09:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=N0g+B9u6Zcg3e7HXcxlcWOiwdGAHTWGrldClMcyVhiY=;
 b=KOQFWNv2KvOuTaPpSOn6zHCNXvQapLt2Vy/00fuHgSirbnMwv0CpqT+LtGFFK2YwBkfi
 NqkSGVIy99HHh9qhNzNU1NFmRNopDxPORqLaODTxVz1h+OZTGJ2ZPU+vvnJ6/um63or7
 VnEqftvKhWSq2ercLuNP0fNmPsWAWFgrR3/CR4ED9punrhYEAiDbDd0NIzA/5tQmQLPG
 sd1iBtEcnNXWsqEJn4EXABh1ihTf9WzcCxVUpjkyghdITZqr6lmZMXz4Swh6fS5vTg00
 xHhSOhfSEnsNWbN+u96eEaYfQ6wWZkYbzWlHmT1lMJCAd3bchZv0zuWsIYWeYtNkuufh Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32hu1j0hbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 09:39:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06R9XVjW083906;
        Mon, 27 Jul 2020 09:37:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32hu5qbmh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 09:37:57 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06R9btjD007876;
        Mon, 27 Jul 2020 09:37:55 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 02:37:54 -0700
Date:   Mon, 27 Jul 2020 12:37:49 +0300
From:   <dan.carpenter@oracle.com>
To:     kamel.bouhara@bootlin.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] counter: Add microchip TCB capture counter
Message-ID: <20200727093749.GA369722@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=885 mlxscore=0
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=878
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=3 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Kamel Bouhara,

The patch 106b104137fd: "counter: Add microchip TCB capture counter"
from Jul 6, 2020, leads to the following static checker warning:

	drivers/counter/microchip-tcb-capture.c:188 mchp_tc_count_action_get()
	warn: bitwise AND condition is false here

drivers/counter/microchip-tcb-capture.c
   176  static int mchp_tc_count_action_get(struct counter_device *counter,
   177                                      struct counter_count *count,
   178                                      struct counter_synapse *synapse,
   179                                      size_t *action)
   180  {
   181          struct mchp_tc_data *const priv = counter->priv;
   182          u32 cmr;
   183  
   184          regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
   185  
   186          *action = MCHP_TC_SYNAPSE_ACTION_NONE;
   187  
   188          if (cmr & ATMEL_TC_ETRGEDG_NONE)

ATMEL_TC_ETRGEDG_NONE is zero so this condition is impossible.

   189                  *action = MCHP_TC_SYNAPSE_ACTION_NONE;
   190          else if (cmr & ATMEL_TC_ETRGEDG_RISING)
   191                  *action = MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
   192          else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
   193                  *action = MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
   194          else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
   195                  *action = MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
   196  
   197          return 0;
   198  }

regards,
dan carpenter
