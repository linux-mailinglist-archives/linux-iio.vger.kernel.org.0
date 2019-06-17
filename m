Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D947D5F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfFQIl3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 04:41:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33508 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQIl3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 04:41:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H8dG9s171166;
        Mon, 17 Jun 2019 08:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mtHQgsyMZPGWe/GtLM4GBjN4evtvLlkaFbbD9s9dYHc=;
 b=tpPU+h5+tChKaBLVITUdWhziFfm/aZCQvxbIk6T1ZoreFkfteknyoZphPXRVsOWSnRHc
 yT7fkuV2H3JGDzfx5Wqoe9CltzTt/8BQ4SS6AdavygyUnCqBmdP1RXDJmp4hTCqf2Oel
 e0axr6p5JsEg88NvqWwaoMjsxJ+AkvlKry8VJTLEKSFXGHCAzv4CMuoO/GrIYyFd4BZM
 Drj17BYZIYYQpWvQPAF++51ZTIJv3wb4wFpiCduHYxAICMGKR2/piciLbJJHJcqCdh3N
 D6zpLun1X48U29YHR/7grjby/ZE6mfOMgjxlk4kgLP2hlk6j9gXieYTJaAftOrnGPnW3 OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t4rmnw486-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 08:40:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H8eN7o165168;
        Mon, 17 Jun 2019 08:40:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t5mgb7wt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 08:40:50 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5H8ehRn003768;
        Mon, 17 Jun 2019 08:40:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Jun 2019 01:40:43 -0700
Date:   Mon, 17 Jun 2019 11:40:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Melissa Wen <melissa.srw@gmail.com>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] staging: iio: ad7150: use ternary operating to ensure
 0/1 value
Message-ID: <20190617084033.GG28859@kadam>
References: <20190614165059.7bifufvhxofy6ybu@smtp.gmail.com>
 <20190616111516.1af0d41b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616111516.1af0d41b@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 16, 2019 at 11:15:16AM +0100, Jonathan Cameron wrote:
> On Fri, 14 Jun 2019 13:50:59 -0300
> Melissa Wen <melissa.srw@gmail.com> wrote:
> 
> > Remove idiom and use ternary operator for consistently trigger 0/1 value
> > on variable declaration.
> > 
> > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> Hi Melissa,
> 
> In general I would consider this unnecessary churn as, whilst
> it's no longer a favoured idiom, it is extremely common in the
> kernel.

It's still my favourite...  Why wouldn't people like it?  It feels like
last week I just saw someone send a bunch of:

-	foo = (bar == baz) ? 1 : 0;
+	foo = (bar == baz);

patches and I thought it was an improvement at the time...

regards,
dan carpenter

