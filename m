Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5FBF1D3
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfIZLhG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:37:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfIZLhG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:37:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QBXdSp119294;
        Thu, 26 Sep 2019 11:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2qOrni6IPbt/vQtoX6vU5ylqBJxxMMwA2xbRwedxvDY=;
 b=VQIeNflaAMD33SvSI/od1Ck3sNCfxFghiIWak1p9oHXMCgy1/NYpL3pDmb7ipXio0sfL
 oqFZse3bQFRQdltVLvHavb6VFbZdxSo09ifJJ+/FREu84/P4Vm0afbZXxVbqVK7CxgPf
 4hTQHG21U2FOwvxF5tXBGYbHIYOuUZ6dKot2dmpBHBWUj6fkRmek/fOKGRAbCQNkyiHW
 nP+e28iOGYRwnMaia2H2RFfHk0fKEMIfgSa6NX+ywwcRjesgJ9/F93pQKoQ+wnyA7qb6
 dcqBE9lopmv/Dd3/+9MOJDLSM6ORrYBLHV+t8429h3+ijeLCiG43TPehRnb06lbqMMWB nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v5b9u32n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 11:36:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QBX7nM049510;
        Thu, 26 Sep 2019 11:36:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v82tn06mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 11:36:42 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8QBacLd022286;
        Thu, 26 Sep 2019 11:36:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 04:36:37 -0700
Date:   Thu, 26 Sep 2019 14:36:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: imu: adis16480: clean up a condition
Message-ID: <20190926113630.GF27389@kadam>
References: <20190926081016.GA2332@mwanda>
 <9e40c550310d6f30e6481329e01061beb474bc33.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e40c550310d6f30e6481329e01061beb474bc33.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 26, 2019 at 11:06:39AM +0000, Ardelean, Alexandru wrote:
> On Thu, 2019-09-26 at 11:10 +0300, Dan Carpenter wrote:
> > [External]
> > 
> > The "t" variable is unsigned so it can't be less than zero.  We really
> > are just trying to prevent divide by zero bugs so just checking against
> > zero is sufficient.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/iio/imu/adis16480.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> > index b99d73887c9f..e144e567675d 100644
> > --- a/drivers/iio/imu/adis16480.c
> > +++ b/drivers/iio/imu/adis16480.c
> > @@ -318,7 +318,7 @@ static int adis16480_set_freq(struct iio_dev
> > *indio_dev, int val, int val2)
> >  	unsigned int t, reg;
> 
> I would just change the type of "t" to "int".
> Especially, since "val" & "val2" are "int".
> 

Yeah, but negatives or high values are basically fine.  We only care
zero.

regards,
dan carpenter

