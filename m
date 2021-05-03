Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79C3716DF
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhECOqC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 10:46:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43078 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhECOqA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 10:46:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143EiLvb002715;
        Mon, 3 May 2021 14:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=F5Gq3RM9SXS/0D9/JJvhMbztWLCjlhpTmu0PVituFkg=;
 b=n5SZwk9VPKMb6VRhgWH8tRyrPDOriKliiP9LQhMCHCIkXsRis+xK1qJ1G8Kxs18EXzql
 6HqqTyM+xVwhlxekyd4jxS6Z7WQGv1gjgYESfqz43qYutP/RzTCvMuejADVUmQCnUPRh
 vnt5ocMiFR8SsWqnmQkoq1Rs7dZBFJzwY9rcvZovI9SxW1RjDweZjM8ijCA71FJO+bgG
 txnLxLh4MBHpOwE/2G9/RSqqOu4U4uuSjIqVqwVgrRIioX8nFJK3Xs2Adni8qLdUNtes
 fUTKMHXWZ6cKYnoxaT+Od5MpTq9MKWmvRvUbwBrobMrN78oGhvW5CRtTKOjhXavLqVre iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 389h13tr6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:44:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143EeBep028546;
        Mon, 3 May 2021 14:44:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 388xt2gdb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:44:40 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143EieId101156;
        Mon, 3 May 2021 14:44:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 388xt2gdb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:44:40 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 143Eicdl031343;
        Mon, 3 May 2021 14:44:38 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 07:44:38 -0700
Date:   Mon, 3 May 2021 17:44:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] staging: iio: cdc: ad7746: use dt for capacitive
 channel setup.
Message-ID: <20210503144429.GN21598@kadam>
References: <cover.1619841953.git.lucas.p.stankus@gmail.com>
 <3e7f2a0a8960cece185f518ff2b7ceb87891edcd.1619841953.git.lucas.p.stankus@gmail.com>
 <20210503100720.GP1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503100720.GP1981@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: j3GYA5SgvROSBYTLZ60Q1c1N67ftKOHO
X-Proofpoint-GUID: j3GYA5SgvROSBYTLZ60Q1c1N67ftKOHO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 03, 2021 at 01:07:20PM +0300, Dan Carpenter wrote:
> On Sat, May 01, 2021 at 09:32:53AM -0300, Lucas Stankus wrote:
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > index dfd71e99e872..531f1b96dea2 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -18,8 +18,6 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  
> > -#include "ad7746.h"
> > -
> >  /*
> >   * AD7746 Register Definition
> >   */
> > @@ -676,10 +674,11 @@ static const struct iio_info ad7746_info = {
> >  static int ad7746_probe(struct i2c_client *client,
> >  			const struct i2c_device_id *id)
> >  {
> > -	struct ad7746_platform_data *pdata = client->dev.platform_data;
> > +	struct device *dev = &client->dev;
> >  	struct ad7746_chip_info *chip;
> >  	struct iio_dev *indio_dev;
> >  	unsigned char regval = 0;
> > +	unsigned int vdd_permille;
> >  	int ret = 0;
> >  
> >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > @@ -703,26 +702,39 @@ static int ad7746_probe(struct i2c_client *client,
> >  	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > -	if (pdata) {
> > -		if (pdata->exca_en) {
> > -			if (pdata->exca_inv_en)
> > -				regval |= AD7746_EXCSETUP_NEXCA;
> > -			else
> > -				regval |= AD7746_EXCSETUP_EXCA;
> > -		}
> > +	if (device_property_read_bool(dev, "adi,exca-output-en")) {
> > +		if (device_property_read_bool(dev, "adi,exca-output-invert"))
> > +			regval |= AD7746_EXCSETUP_NEXCA;
> > +		else
> > +			regval |= AD7746_EXCSETUP_EXCA;
> > +	}
> >  
> > -		if (pdata->excb_en) {
> > -			if (pdata->excb_inv_en)
> > -				regval |= AD7746_EXCSETUP_NEXCB;
> > -			else
> > -				regval |= AD7746_EXCSETUP_EXCB;
> > -		}
> > +	if (device_property_read_bool(dev, "adi,excb-output-en")) {
> > +		if (device_property_read_bool(dev, "adi,excb-output-invert"))
> > +			regval |= AD7746_EXCSETUP_NEXCB;
> > +		else
> > +			regval |= AD7746_EXCSETUP_EXCB;
> > +	}
> >  
> > -		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> > -	} else {
> > -		dev_warn(&client->dev, "No platform data? using default\n");
> > -		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> > -			AD7746_EXCSETUP_EXCLVL(3);
> > +	ret = device_property_read_u32(dev, "adi,excitation-vdd-permille",
> > +				       &vdd_permille);
> > +	if (!ret) {
> 
> This test is reversed.  I wonder if the static checkers can catch the
> uninitialized variable bug...  It's probably better to write it as:
> 
> 	if (device_property_read_u32(dev, "adi,excitation-vdd-permille",
> 				     &vdd_permille) {
> 
> So it matches the others.

Oops.  Sorry for the noise.  I was wrong on this.  I looked at the
device_property_read_bool() code instead of the device_property_read_u32().

It's disappointing that the returns are reversed.

regards,
dan carpenter

