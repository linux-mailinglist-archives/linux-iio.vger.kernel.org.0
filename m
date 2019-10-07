Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759C4CE4FD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfJGOSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 10:18:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOSx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 10:18:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97EEx9s096980;
        Mon, 7 Oct 2019 14:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=o/aF5OGHe1WsAEZqjOizMyen7w4k90sGuDawVgOV3sM=;
 b=cJQrpLpSFAKO4fpj+/pSzdLiNwZGROb7M93QOZslX+U1t15APVYR9xLlxfbRan6lZNTc
 75hjgwd5ouUoCqSRlGQSJYSJJLNOxV+a9L2zR9WYwVlG5QNdhd9OjL1oCBpkMEUa+YcM
 8edLsam4a1/afi22/SoFLSbu3sFVAdSuSFDaTHG9LYi6OBq9aP9668J0fVYerEO9ASDZ
 DOYPGavA0FHsA6FdD0ydIRUnX5XxfImu/wQCloq2s/Gzd6r6oeQj/SQ5m8RZVFnxjvRA
 PxUMVgj9Iv4GGyllbjwEF3c1n9LpOy3Mm36vuNNzSzudEToeEjXfmEYG/7X9NBmBGaz2 aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vejku71xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 14:18:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97EI0Nf192570;
        Mon, 7 Oct 2019 14:18:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vf4phm9sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 14:18:20 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x97EICHO005519;
        Mon, 7 Oct 2019 14:18:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 07:18:11 -0700
Date:   Mon, 7 Oct 2019 17:18:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: imu: adis16480: clean up a condition
Message-ID: <20191007141803.GZ22609@kadam>
References: <20190926081016.GA2332@mwanda>
 <9e40c550310d6f30e6481329e01061beb474bc33.camel@analog.com>
 <20190926113630.GF27389@kadam>
 <20191006095133.24fb89be@archlinux>
 <20191006181439.GU22609@kadam>
 <20191007102107.000067b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007102107.000067b6@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070142
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 07, 2019 at 10:21:07AM +0100, Jonathan Cameron wrote:
> On Sun, 6 Oct 2019 21:14:40 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > On Sun, Oct 06, 2019 at 09:51:33AM +0100, Jonathan Cameron wrote:
> > > On Thu, 26 Sep 2019 14:36:30 +0300
> > > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >   
> > > > On Thu, Sep 26, 2019 at 11:06:39AM +0000, Ardelean, Alexandru wrote:  
> > > > > On Thu, 2019-09-26 at 11:10 +0300, Dan Carpenter wrote:    
> > > > > > [External]
> > > > > > 
> > > > > > The "t" variable is unsigned so it can't be less than zero.  We really
> > > > > > are just trying to prevent divide by zero bugs so just checking against
> > > > > > zero is sufficient.  
> > > 
> > > I'm not sure that true.  It if were signed we'd be detecting that the
> > > input from userspace was negative.  
> > 
> > It does a really bad job of that though so it raises more questions than
> > answers.  Maybe just one of the parameters is negative or maybe the
> > multiply or the addition overflowed?  Should scenarios those be checked?
> > 
> > It turns out none of those situations matter, only divide by zero needs
> > to be checked.
> 
> It isn't being nearly paranoid enough. Either val or val2 being
> negative is a reason to fault out.  Divide by zero needs handling after
> that.  Obviously divide by zero is the only one that causes a crash but
> negatives are going to cause rather 'unexpected' results.

The result is that it gets capped at st->chip_info->max_dec_rate so it's
not a horrible result.  :P  I don't know if it's unexpected or not.

regards,
dan carpenter

