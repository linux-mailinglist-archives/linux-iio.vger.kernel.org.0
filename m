Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8427CD51
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbgI2MnL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:43:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35702 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbgI2Mmv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:42:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TCTVhK162323;
        Tue, 29 Sep 2020 12:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ooQL/jdNK5E0bwGTZMVh9gDWLUQ2nvmJK92rRekHYUQ=;
 b=fbDsT6lWzQ+ORM5K3s5HbTh37q+P1z9c+/B6RQ4VQx7oLjM2gwzIeE8N0TK9/h4MlugJ
 VmZKpujw7s9mQJMKXROtdkaJX+/M40fG89wb5M/Eb5lfOuzm6ifBoSQMNa1ZDYLDy96Q
 N5FurL2lN7UYjwYGf1sjjyvRX87rPwj+KMvYkCQLizmlU/Ua4y+pfB0M4iK5IHDAfOby
 Hommc306kBsy4enPQXLV0Mli3U5nB0z5aegJtQ2KWz1ehAOh7di/nh/mvWIUPuCzfgWZ
 mEbkR9polc8Mr77IP2HqyemXrTNGhtvRUKntBy9kx5+xTdBCZUmB2KCW9Fcu9Ddd4fTT HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33swkktdv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 12:41:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TCTjQh051184;
        Tue, 29 Sep 2020 12:41:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33tfjwmsb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 12:41:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08TCfLK3017010;
        Tue, 29 Sep 2020 12:41:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 05:41:20 -0700
Date:   Tue, 29 Sep 2020 15:41:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>, linux-iio@vger.kernel.org,
        drbd-dev@tron.linbit.com,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        David Lechner <david@lechnology.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        linux-amlogic@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
Message-ID: <20200929124108.GY4282@kadam>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=942 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=966 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290111
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 02:20:00PM +0200, Ard Biesheuvel wrote:
> On Sun, 27 Sep 2020 at 21:56, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > These patches replace commas by semicolons.
> 
> 
> Why?
> 

In the best case, these commas are just uninitentional mess, like typing
an extra space character or something.  I've looked at them before and
one case I see where they are introduced is when people convert a
struct initializer to code.

-	struct foo {
-		.a = 1,
-		.b = 2,
 		...
+	foo.a = 1,
+	foo.b = 2,

The times where commas are used deliberately to replace curly braces are
just evil.  Either way the code is cleaner with semi-colons.

regards,
dan carpenter

