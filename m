Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87DCD88F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJFSPU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 14:15:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfJFSPU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 14:15:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x96IB51v015859;
        Sun, 6 Oct 2019 18:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Z/8cilR+SOCZwA8hNy7Ewd1pr7qibxNHXT1a8xzhh0w=;
 b=DfS1JJHjUEaa4DK8pBL7OP4qvU6ZuGPCIVFpkKL1g2/iK1TMANTHH1cWdqe+A7dVgpT7
 Q7xeTDvlycAIAXsUr0tSm8n2A9Vi1jDR/vuGQn5FQ79TOSnD3QMuBKaMrTxA4rMXWkAr
 xtc4ovg9yaNous7DZTQ+TxSBvKKbjpYdooAvychxfrw/W8eMYXWI8WFcIdscC68so9CB
 1+tQ31oGelOL+WX5b56D9+DnjEXMllnPdnJim0gEj4oJ2VB1Jgd0ovCfu/63s0jF2I9z
 x5rz0luXGSnKYtkLBjZHPEwDqCXKZYnKGDwAX/j33Cg4Gh61ilRygyX4f2+3+22YvLss 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4q3mdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 18:14:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x96I84Fb004999;
        Sun, 6 Oct 2019 18:14:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vf4pg684a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 18:14:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x96IEmtr016609;
        Sun, 6 Oct 2019 18:14:48 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 06 Oct 2019 11:14:47 -0700
Date:   Sun, 6 Oct 2019 21:14:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: imu: adis16480: clean up a condition
Message-ID: <20191006181439.GU22609@kadam>
References: <20190926081016.GA2332@mwanda>
 <9e40c550310d6f30e6481329e01061beb474bc33.camel@analog.com>
 <20190926113630.GF27389@kadam>
 <20191006095133.24fb89be@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006095133.24fb89be@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=705
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910060187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=781 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910060187
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 06, 2019 at 09:51:33AM +0100, Jonathan Cameron wrote:
> On Thu, 26 Sep 2019 14:36:30 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > On Thu, Sep 26, 2019 at 11:06:39AM +0000, Ardelean, Alexandru wrote:
> > > On Thu, 2019-09-26 at 11:10 +0300, Dan Carpenter wrote:  
> > > > [External]
> > > > 
> > > > The "t" variable is unsigned so it can't be less than zero.  We really
> > > > are just trying to prevent divide by zero bugs so just checking against
> > > > zero is sufficient.
> 
> I'm not sure that true.  It if were signed we'd be detecting that the
> input from userspace was negative.

It does a really bad job of that though so it raises more questions than
answers.  Maybe just one of the parameters is negative or maybe the
multiply or the addition overflowed?  Should scenarios those be checked?

It turns out none of those situations matter, only divide by zero needs
to be checked.

regards,
dan carpenter




