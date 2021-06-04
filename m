Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A824A39B2CD
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFDGrP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 02:47:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhFDGrP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 02:47:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1546etj3078826;
        Fri, 4 Jun 2021 06:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SM+12bs/cF//qW82eBNiHctbS0B3oN6oI6og++uErus=;
 b=de0SuW/DK6P9YEVODVSAhBGsfbDAtXFMubYDeFAfXUVsnBa/QKrZmPIOwOxRG6WdTMSZ
 J4EzH53wmo/29eXhttoYJPibXey1yZ9RpQALOZsmK/Tx9p7bSKaH1iqXsXZce2Y9ulhr
 hct7vD+b63boluBpuka/WZdfxVQ6qxsiAZBCftnPNq/1EJX5qF7tc12V/yh536VH/1IY
 E9g+Ay5MRir2iWmVmui/G3zyoCPDrjxAWX0+5XmSsK0cUKweH94fgKg+0pZRLRVaPgUj
 +VxjSZRiOZbab+EVCYktKsrjd+pIb+0yXMPmmssmisL7Nm27b+h2iqNP3pvGdI39VIrE dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38ud1sn2wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 06:45:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1546e7Hr039908;
        Fri, 4 Jun 2021 06:45:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38uar00r7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 06:45:21 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1546jK1g053000;
        Fri, 4 Jun 2021 06:45:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38uar00r7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 06:45:20 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1546jG9j018808;
        Fri, 4 Jun 2021 06:45:16 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Jun 2021 06:45:15 +0000
Date:   Fri, 4 Jun 2021 09:45:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jic23@cam.ac.uk, linux-iio@vger.kernel.org
Subject: Re: [bug report] staging:iio:sca3000 extract old event handling and
 move to poll for events from buffer
Message-ID: <20210604064510.GE10983@kadam>
References: <YLDbdN688C0xBgMn@mwanda>
 <20210603173842.5d2b1004@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603173842.5d2b1004@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: QHoUCOVT5uMUBbJC1GGQE1NbnG3bZCF_
X-Proofpoint-GUID: QHoUCOVT5uMUBbJC1GGQE1NbnG3bZCF_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 03, 2021 at 05:38:42PM +0100, Jonathan Cameron wrote:
> On Fri, 28 May 2021 15:00:52 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > Hello Jonathan Cameron,
> > 
> > The patch 25888dc51163: "staging:iio:sca3000 extract old event
> > handling and move to poll for events from buffer" from May 18, 2011,
> > leads to the following static checker warning:
> > 
> > 	drivers/iio/accel/sca3000.c:734 sca3000_read_raw()
> > 	warn: no-op. '((*val) << 19) >> 19'
> > 
> > drivers/iio/accel/sca3000.c
> >    709  static int sca3000_read_raw(struct iio_dev *indio_dev,
> >    710                              struct iio_chan_spec const *chan,
> >    711                              int *val,
> >    712                              int *val2,
> >    713                              long mask)
> >    714  {
> >    715          struct sca3000_state *st = iio_priv(indio_dev);
> >    716          int ret;
> >    717          u8 address;
> >    718  
> >    719          switch (mask) {
> >    720          case IIO_CHAN_INFO_RAW:
> >    721                  mutex_lock(&st->lock);
> >    722                  if (chan->type == IIO_ACCEL) {
> >    723                          if (st->mo_det_use_count) {
> >    724                                  mutex_unlock(&st->lock);
> >    725                                  return -EBUSY;
> >    726                          }
> >    727                          address = sca3000_addresses[chan->address][0];
> >    728                          ret = sca3000_read_data_short(st, address, 2);
> >    729                          if (ret < 0) {
> >    730                                  mutex_unlock(&st->lock);
> >    731                                  return ret;
> >    732                          }
> >    733                          *val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> >    734                          *val = ((*val) << (sizeof(*val) * 8 - 13)) >>
> >                                                   ^^^^^^^^^^^^^^^^^^^^^^^
> >    735                                  (sizeof(*val) * 8 - 13);
> >                                         ^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > This code works, but it relies on undefined behavior of left shift
> > overflow and it's very unsatisfying.  Pretty sure there is a UBSan
> > warning for this at runtime.
> 
> Thanks Dan.  Looks like a slightly odd variant on open coded sign_extend32()
> Should be fine to replace with
> 
> *val = sign_extend32(*val, 13);
> 
> What can I say, I wrote this a long time ago when I was young and stupid :)

I didn't think of sign_extend32()...  I was forced to look at some of my
2009 code the other day and it was *so* bad.  :P

regards,
dan carpenter

