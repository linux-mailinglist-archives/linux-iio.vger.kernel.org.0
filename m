Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163E13691AE
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhDWMCO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 08:02:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45958 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMCN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 08:02:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13NBxx4I101003;
        Fri, 23 Apr 2021 12:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=wC80dJIbqtkzHsdT0dHuUo+Tt3N86MZmfTktEAdfi0A=;
 b=YMr8jMxX6MI1wY1SNMXTX9JGb+21xEk/ZyMjsSuIPZDOJBLWKN6BPH9yHedYM675RJ+C
 jNihJZNsYlP3uTGh5fJKyzWhddt02JOx4ccZt6oaAsU+eryvmwJ/WLiOqgXhMGYlOO7r
 DaP9Fjewy+o+ZsLBasBbawP78h4TTabP225195OGBid4afN6uTIP3sOQ1tyoPJdqMoCQ
 kdLu5cDd67pgKG5BEzXUahsi8DYBQ7yf0HIjsF4/ZlyBeSVIONu6WmOx7qtZT4zLOC0q
 toBF8W7wFYmSQ1pmIyak1Yf69vXjumJL3WAUTM16OkqJh82o2k6MMEn3JqnLwUv7Nhaf xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37yveaquwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 12:01:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13NBuDug172779;
        Fri, 23 Apr 2021 12:01:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 383cdsshev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 12:01:32 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13NC1WRG182994;
        Fri, 23 Apr 2021 12:01:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 383cdsshen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 12:01:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13NC1VRW011645;
        Fri, 23 Apr 2021 12:01:31 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 05:01:31 -0700
Date:   Fri, 23 Apr 2021 15:01:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     k.wrona@samsung.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: common: ssp_sensors: Add sensorhub driver
Message-ID: <YIK3FmCXeM6QcUYQ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: ioFcOIsPxZmmeWJtoftLIBRosmbrcrwr
X-Proofpoint-ORIG-GUID: ioFcOIsPxZmmeWJtoftLIBRosmbrcrwr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Karol Wrona,

The patch 50dd64d57eee: "iio: common: ssp_sensors: Add sensorhub
driver" from Jan 28, 2015, leads to the following static checker
warning:

	drivers/iio/common/ssp_sensors/ssp_spi.c:276 ssp_parse_dataframe()
	warn: check that incremented offset 'idx' is capped

drivers/iio/common/ssp_sensors/ssp_spi.c
   267  static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
   268  {
   269          int idx, sd;
   270          struct ssp_sensor_data *spd;
   271          struct iio_dev **indio_devs = data->sensor_devs;
   272  
   273          for (idx = 0; idx < len;) {
   274                  switch (dataframe[idx++]) {
   275                  case SSP_MSG2AP_INST_BYPASS_DATA:

There needs to be be a check here:

				if (idx == len)
					return -EPROTO;

   276                          sd = dataframe[idx++];
   277                          if (sd < 0 || sd >= SSP_SENSOR_MAX) {
   278                                  dev_err(SSP_DEV,
   279                                          "Mcu data frame1 error %d\n", sd);
   280                                  return -EPROTO;
   281                          }
   282  
   283                          if (indio_devs[sd]) {
   284                                  spd = iio_priv(indio_devs[sd]);
   285                                  if (spd->process_data)
   286                                          spd->process_data(indio_devs[sd],
   287                                                            &dataframe[idx],
   288                                                            data->timestamp);

But then the problem is we don't pass the "len" to ->process_data().  I
looked at trying to fix this but it's a bit involved.

   289                          } else {
   290                                  dev_err(SSP_DEV, "no client for frame\n");
   291                          }
   292  
   293                          idx += ssp_offset_map[sd];
   294                          break;
   295                  case SSP_MSG2AP_INST_DEBUG_DATA:
   296                          sd = ssp_print_mcu_debug(dataframe, &idx, len);
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
There is another potential read overflow here because we read one more
byte before we check the "len".

   297                          if (sd) {
   298                                  dev_err(SSP_DEV,
   299                                          "Mcu data frame3 error %d\n", sd);
   300                                  return sd;
   301                          }
   302                          break;
   303                  case SSP_MSG2AP_INST_LIBRARY_DATA:
   304                          idx += len;
   305                          break;
   306                  case SSP_MSG2AP_INST_BIG_DATA:
   307                          ssp_handle_big_data(data, dataframe, &idx);
   308                          break;
   309                  case SSP_MSG2AP_INST_TIME_SYNC:
   310                          data->time_syncing = true;
   311                          break;
   312                  case SSP_MSG2AP_INST_RESET:
   313                          ssp_queue_ssp_refresh_task(data, 0);
   314                          break;
   315                  }
   316          }
   317  
   318          if (data->time_syncing)
   319                  data->timestamp = ktime_get_real_ns();
   320  
   321          return 0;
   322  }

regards,
dan carpenter
