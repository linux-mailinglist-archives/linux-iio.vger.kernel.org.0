Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC9B377CB5
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEJHBL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 03:01:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50012 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJHBK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 03:01:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14A6xjvj118442;
        Mon, 10 May 2021 06:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=4e7dQppKfNIV7YVAFBbupKmBJtQcsa0sycuBhEJrB08=;
 b=f9a+II+4xilHF+3C2FBIoI0hgNKODGJYn5fXqlzQcv9FOvY2mE/AFcZE9yaWDErFzkUN
 vLRy5XrWIpSHqRaH+dJb5SMs2Mw2VzQnenNvDDkY0rheEEkI6CYfl40aIoRPIhWSv9Nh
 4fjrwGFYVFA92fTULbOxnBlxRyTHSzfHOIhKds3mDiu5J0cdGYbhsLh+YCPHz0gneD9B
 dJa3Rl1QCQzWinHnBEqeheoEdUt8B2n7vyd9tI0sHmSxhIx2LJplOExBOtRmb44Rq002
 01VY+2bHnhI7E8k3Azg+kwKnAtxJMBh7J3HXPSGn6F1Us9BPlfJVMSfegiCTwftFz8gy Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38dg5ba5ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 06:59:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14A6pX3Q017400;
        Mon, 10 May 2021 06:59:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38dfrusufx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 06:59:42 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14A6xfRt042804;
        Mon, 10 May 2021 06:59:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 38dfrusuew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 06:59:41 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14A6xaPL019927;
        Mon, 10 May 2021 06:59:39 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 May 2021 23:59:36 -0700
Date:   Mon, 10 May 2021 09:59:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jon Brenner <jbrenner@taosinc.com>, linux-iio@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2583: Fix division by a zero lux_val
Message-ID: <20210510065928.GR1955@kadam>
References: <20210507183041.115864-1-colin.king@canonical.com>
 <20210508171258.2ef71a70@jic23-huawei>
 <1eb0428d352be2498739de71eb65746309c90f4c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb0428d352be2498739de71eb65746309c90f4c.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: Wofz6Vl8vwk6Pcbex2r8_g2sHLoUZkQg
X-Proofpoint-ORIG-GUID: Wofz6Vl8vwk6Pcbex2r8_g2sHLoUZkQg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9979 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxlogscore=980 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100049
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 08, 2021 at 10:01:14AM -0700, Joe Perches wrote:
> On Sat, 2021-05-08 at 17:12 +0100, Jonathan Cameron wrote:
> > On Fri,  7 May 2021 19:30:41 +0100 Colin King <colin.king@canonical.com> wrote:
> []
> > > The lux_val returned from tsl2583_get_lux can potentially be zero,
> > > so check for this to avoid a division by zero and an overflowed
> > > gain_trim_val.
> []
> > > Fixes: ac4f6eee8fe8 ("staging: iio: TAOS tsl258x: Device driver")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > Definitely looks like it could happen so applied to the fixes-togreg branch of
> > iio.git and marked for stable.
> []
> > > diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> []
> > > @@ -341,6 +341,14 @@ static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
> > >  		return lux_val;
> > >  	}
> > > 
> > > +	/* Avoid division by zero of lux_value later on */
> > > +	if (lux_val == 0) {
> > > +		dev_err(&chip->client->dev,
> > > +			"%s: lux_val of 0 will produce out of range trim_value\n",
> > > +			__func__);
> > > +		return -ENODATA;
> > > +	}
> > > +
> > >  	gain_trim_val = (unsigned int)(((chip->als_settings.als_cal_target)
> > >  			* chip->als_settings.als_gain_trim) / lux_val);
> 
> Is a multiplication overflow possible here?

These are chip->foo values and they ought to be trustworthy.

Of course, in real life, they can be set to INT_MAX in
in_illuminance_input_target_store() and tsl2583_write_raw so they can
overflow...  Anyway, if we were going to add a check it would be at
the point where we get the number from the user and before we save it
to chip->

regards,
dan carpenter

