Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0B13CBB3
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgAOSJy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 13:09:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOSJx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jan 2020 13:09:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FI9Dn2086438;
        Wed, 15 Jan 2020 18:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=MoS3Ar/TZ23O73sTR55GHmFj7hQu/li0Vucux1MDCJ4=;
 b=qFRhnek9jgeFTfpIn9KFA/tyvE02UYHtSHX/TReQAwue0bTQ0cjTzWVPRXpjKVD7ouKp
 NQCsCqLnjsPii30CPvokIeoGZuZ8b5YeGMJOeJKuQAdu8fkxksUrJ6hvakmUKxR5A6dx
 EED4ql2ByZbLEsLQE06dE/ksI2SrgemXdjt3v0tCvtjYRNDoLYEsPMPJeHg02lQAFnYb
 HwcRJztApq3DAczqjgxDi2zffsfEzkffjhWmpTRj1Kt4+CT/JqEJtcwPQc3NkPu//0Dy
 f1xzjUoe+VvLl1TjKgNkrabSOJS1fqHngx9BXY2vrzNP6peHcO4Tvlx2PzevMhSRkWNL 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xf73ynt0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:09:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FI9ARE031858;
        Wed, 15 Jan 2020 18:09:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xj1aq6qr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:09:21 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FI8SHp009089;
        Wed, 15 Jan 2020 18:08:28 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 10:08:28 -0800
Date:   Wed, 15 Jan 2020 21:09:01 +0300
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
Message-ID: <20200115180518.GF9562@kadam>
References: <20200115174531.p623ukjibn6kg6zz@kili.mountain>
 <20200115174324.GA29555@nessie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115174324.GA29555@nessie>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=693
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=745 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150139
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 15, 2020 at 05:43:24PM +0000, Dan Robertson wrote:
> Thanks for taking a look at the code and your feedback on the driver!
> 
> On Wed, Jan 15, 2020 at 08:45:31PM +0300, Dan Carpenter wrote:
> > We put an upper bound on "val2" but we also need to prevent negative
> > values.
> 
> "val" is not used past the invalid value check. We only use "val" to make sure
> that it is in fact 0. AFAIK there is no "upper bound" on "val", it should be
> zero or we return -EINVAL. Am I missing something?

This patch affects "val2" not "val".  ;)

regards,
dan carpenter

