Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684CD13D43C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2020 07:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgAPGYP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jan 2020 01:24:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50172 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgAPGYO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jan 2020 01:24:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G6Dqhj021807;
        Thu, 16 Jan 2020 06:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=iCnFfG3gS1z8bRmuJUCzo8HFK3ZShsE2DhNrKyi+fDU=;
 b=Iyzd4W4mOu22xAZOWvoqi8tjxHQ8DnIWuT7kTEWyOqBVKjAi+sgTdMKDCFgnhlNZYeVW
 clLLSM4uhKLDWcFqFMRKDlB5VVpjV0RTQelTIxNne9NeKINCyZdFVVQ1Rlly4xWd+E/A
 escC80WlPwwa1HhkXAUd+0FxwUvDl/DTXj0geaSlpeZ5nw7HMu8fOnUTFmRpPwSnKoGW
 IOdGjPLrIO987knwlCjawa47v8IWSteOqTHgNwBEsjG5zgv2w3zneLRMxHXM65/yPghN
 nIuxKIzQ2UP6ZzDoNPUKSbpHw3tFDuVxSf3p3CoKHnnrZGt4QxxiMvHHQ4zhScrbdPwg gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73yrg8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 06:23:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G6DbTP038049;
        Thu, 16 Jan 2020 06:23:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xhy22qqwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 06:23:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00G6NbCW019673;
        Thu, 16 Jan 2020 06:23:38 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 22:23:36 -0800
Date:   Thu, 16 Jan 2020 09:24:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma400: integer underflow setting accel scale
Message-ID: <20200116061916.GH9562@kadam>
References: <20200115174531.p623ukjibn6kg6zz@kili.mountain>
 <20200115181717.GA22797@nessie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115181717.GA22797@nessie>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160052
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 15, 2020 at 06:17:17PM +0000, Dan Robertson wrote:
> On Wed, Jan 15, 2020 at 08:45:31PM +0300, Dan Carpenter wrote:
> > We put an upper bound on "val2" but we also need to prevent negative
> > values.
> > 
> > Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/iio/accel/bma400_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index ab4a158b35af..ffc7b146bbfc 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -752,7 +752,7 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
> >  		mutex_unlock(&data->mutex);
> >  		return ret;
> >  	case IIO_CHAN_INFO_SCALE:
> > -		if (val != 0 || val2 > BMA400_SCALE_MAX)
> > +		if (val != 0 || val2 < 0 || val2 > BMA400_SCALE_MAX)
> 
> AFAIK if val2 is less than BMA400_SCALE_MIN we should return -EINVAL.
> 

Ah.  Thanks.  Let me resend.

regards,
dan carpenter

