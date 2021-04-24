Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370B1369FED
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhDXHIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 03:08:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46072 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbhDXHI3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Apr 2021 03:08:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13O77lGL023962;
        Sat, 24 Apr 2021 07:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=wOmJSzOdmq3CPYG3OnPjUMtUuMELhMK6xMPL1sWb2/w=;
 b=L3mJQ1Cd97shNhGGcZ0Iw/N6tb5Tq0FHnltUbnpB/6JsBeF2ELGWPE2w6rZhYQMMxflr
 05D9ho/Oy2X9K9tYAzNul/JOIkNu2h7Q/rEWXBgqCdViA5Cqj8whcTda8zXAYVaI6Wnk
 PJEdoWudYgwPM/YwJh2tiWehqdCVWHEGO2MRv3IH0nn0gqV4kPlhtTN6pbQvgEOyPY8r
 sp5qLkUCRoqKhSRC1XHTiaPKiHZcq6vqZdTgDtBVQC3UOYvp6oK2c2AEsThhW3pHwxT4
 /r8nWxlg3x0WvV8dU0LlTRFcpoNIQzl7RhTRngvsnep9eE4drOPcqoPVP4xp21J6457i Tg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 384bvu013y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 07:07:47 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13O77kmQ065752;
        Sat, 24 Apr 2021 07:07:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3849c9yn21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 07:07:46 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13O77jgt065729;
        Sat, 24 Apr 2021 07:07:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3849c9yn1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 07:07:45 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13O77ieU015982;
        Sat, 24 Apr 2021 07:07:45 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 24 Apr 2021 00:07:44 -0700
Date:   Sat, 24 Apr 2021 10:07:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "k.wrona@samsung.com" <k.wrona@samsung.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [bug report] iio: common: ssp_sensors: Add sensorhub driver
Message-ID: <20210424070739.GX1959@kadam>
References: <YIK3FmCXeM6QcUYQ@mwanda>
 <CAHp75VeXUCjVnfED504SzByJwnWAtjDUsZe6HjQ3TqFLdbFQWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeXUCjVnfED504SzByJwnWAtjDUsZe6HjQ3TqFLdbFQWw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: -Hd8eg2_8P-a-LI_gf1FCWpwYRs7dQI_
X-Proofpoint-ORIG-GUID: -Hd8eg2_8P-a-LI_gf1FCWpwYRs7dQI_
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 24, 2021 at 01:12:46AM +0300, Andy Shevchenko wrote:
> On Friday, April 23, 2021, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > Hello Karol Wrona,
> >
> > The patch 50dd64d57eee: "iio: common: ssp_sensors: Add sensorhub
> > driver" from Jan 28, 2015, leads to the following static checker
> > warning:
> >
> >         drivers/iio/common/ssp_sensors/ssp_spi.c:276 ssp_parse_dataframe()
> >         warn: check that incremented offset 'idx' is capped
> >
> > drivers/iio/common/ssp_sensors/ssp_spi.c
> >    267  static int ssp_parse_dataframe(struct ssp_data *data, char
> > *dataframe, int len)
> >    268  {
> >    269          int idx, sd;
> >    270          struct ssp_sensor_data *spd;
> >    271          struct iio_dev **indio_devs = data->sensor_devs;
> >    272
> >    273          for (idx = 0; idx < len;) {
> >    274                  switch (dataframe[idx++]) {
> >    275                  case SSP_MSG2AP_INST_BYPASS_DATA:
> >
> > There needs to be be a check here:
> >
> >                                 if (idx == len)
> >                                         return -EPROTO;
> >
> >    276                          sd = dataframe[idx++];
> >    277                          if (sd < 0 || sd >= SSP_SENSOR_MAX) {
> >    278                                  dev_err(SSP_DEV,
> >    279                                          "Mcu data frame1 error
> > %d\n", sd);
> >    280                                  return -EPROTO;
> >    281                          }
> >    282
> >    283                          if (indio_devs[sd]) {
> >    284                                  spd = iio_priv(indio_devs[sd]);
> >    285                                  if (spd->process_data)
> >    286
> > spd->process_data(indio_devs[sd],
> >    287
> > &dataframe[idx],
> >    288
> > data->timestamp);
> >
> > But then the problem is we don't pass the "len" to ->process_data().  I
> > looked at trying to fix this but it's a bit involved.
> 
> 
> Because infinite loops are bad. That’s why I try convince people to avoid
> them as much as possible.
> 

I'm not sure what you mean at all.  The issue here is that
->process_data() reads an unknown number of bytes.  We need to pass
"len - idx" to ->process_data() to detect the overflow and return -EPROTO.

regards,
dan carpenter

> 
> >
> >    289                          } else {
> >    290                                  dev_err(SSP_DEV, "no client for
> > frame\n");
> >    291                          }
> >    292
> >    293                          idx += ssp_offset_map[sd];
> >    294                          break;
> >    295                  case SSP_MSG2AP_INST_DEBUG_DATA:
> >    296                          sd = ssp_print_mcu_debug(dataframe, &idx,
> > len);
> >                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > There is another potential read overflow here because we read one more
> > byte before we check the "len".
> >
> >    297                          if (sd) {
> >    298                                  dev_err(SSP_DEV,
> >    299                                          "Mcu data frame3 error
> > %d\n", sd);
> >    300                                  return sd;
> >    301                          }
> >    302                          break;
> >    303                  case SSP_MSG2AP_INST_LIBRARY_DATA:
> >    304                          idx += len;
> >    305                          break;
> >    306                  case SSP_MSG2AP_INST_BIG_DATA:
> >    307                          ssp_handle_big_data(data, dataframe, &idx);
> >    308                          break;
> >    309                  case SSP_MSG2AP_INST_TIME_SYNC:
> >    310                          data->time_syncing = true;
> >    311                          break;
> >    312                  case SSP_MSG2AP_INST_RESET:
> >    313                          ssp_queue_ssp_refresh_task(data, 0);
> >    314                          break;
> >    315                  }
> >    316          }
> >    317
> >    318          if (data->time_syncing)
> >    319                  data->timestamp = ktime_get_real_ns();
> >    320
> >    321          return 0;
> >    322  }
> >
> > regards,
> > dan carpenter
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
