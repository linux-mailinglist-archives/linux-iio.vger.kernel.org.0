Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED62387648
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbhERKSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 06:18:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48746 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbhERKSa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 06:18:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14IAF7mh097788;
        Tue, 18 May 2021 10:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Dz0JFBpG2YkGnA6Kv+iRNqW5ei6j9FYbBlVBaa8JuDE=;
 b=j/msDuiXPVfGAKm6W7G3t7KrT7HSSMjxMOz3rCLqQVkbCkOrjP+dVeEk3CpLGxek+JCb
 xELI9DYOJESBCVu1u1f68s0cT3rGRGrBZhEDkQxRB00NzE0Hvr8v4RFQLSXOICeOl7Hf
 CMYbj9S6OHK9ztKMXRuAlStvDwBwDIjtCw1sgYOjNCN2BO1gvT2iz788PeoLV4ygwatv
 BiAGeO4C/LLuQceg26mcXL66lHuIw3PKSPhw8+F3leG+68ywVQhmD5tkH77Yw6pATDD5
 H6ZQlfP6KulEgX6N7gukK3Bl2MLJsM7q2g2D6gGkFFSEU4D2IsQqEGqbKtXC2jhtmtY3 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38j5qr5wgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 10:16:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14IAFq2r125832;
        Tue, 18 May 2021 10:16:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38j6486fg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 10:16:39 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14IAGcZ0132121;
        Tue, 18 May 2021 10:16:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38j6486feh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 10:16:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14IAGY6b016208;
        Tue, 18 May 2021 10:16:36 GMT
Received: from kadam (/62.8.83.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 May 2021 10:16:34 +0000
Date:   Tue, 18 May 2021 13:16:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Remove unnecessary assignment
 in ad7746_probe()
Message-ID: <20210518101626.GO1955@kadam>
References: <20210518095647.3008-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518095647.3008-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: pFFpgWCER-ethSIjiD4beJU8BUWa1bhp
X-Proofpoint-ORIG-GUID: pFFpgWCER-ethSIjiD4beJU8BUWa1bhp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180071
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 18, 2021 at 05:56:47PM +0800, Tang Bin wrote:
> In the function ad7746_probe(), the initialized value of 'ret' is unused,
> because it will be assigned by the function i2c_smbus_write_byte_data(),
> thus remove it.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

