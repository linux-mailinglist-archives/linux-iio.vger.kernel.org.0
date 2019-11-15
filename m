Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225E0FDE8B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 14:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKONEt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 08:04:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKONEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 08:04:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFCx9Ue167692;
        Fri, 15 Nov 2019 13:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=NFSSVbjhEqElsrA73XhmCVdsI7Nss0hsHyVS7FwP2+Q=;
 b=YQVJAjOD8u/DCdzbTWgjB6kB+86XbwfNvVG7HB4og2jcOuYIoorw9Q0nkqXYcYRYisSN
 aepKCWa+8+eYyaAJ3vCuvuCAxqGNJYt/T/V07mfYHzTeQo0Gy/ggjPSc0Vc98o2b30ul
 wtXquJGr3i3w8r/zQiIYaXbhGct+RBGyxizIoCLdpAGfNU8GwaV4T7UQQmWSLq6/hBwU
 oP2OyO7QXXejzW08cEid5+zGbKT/76G/p51uxVcWg5xjdIWdMshHO9vtZzBKNhgff9a4
 Vam6PKjXqF83Nz2Y/U7zL6RKBmqe40HuI9EQLO5rpaip/GGr3Qnm3sGc1oSR8u82aGyS mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w9gxpk4b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 13:04:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFCx7p0167338;
        Fri, 15 Nov 2019 13:04:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w9h14fam4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 13:04:15 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAFD48Hx001873;
        Fri, 15 Nov 2019 13:04:08 GMT
Received: from kadam.lan (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 05:04:08 -0800
Date:   Fri, 15 Nov 2019 16:03:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, devel@driverdev.osuosl.org, mark.rutland@arm.com,
        lars@metafoo.de, biabeniamin@outlook.com,
        Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de,
        Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH v4 2/4] iio: adc: ad7091r5: Add scale and external VREF
 support
Message-ID: <20191115130359.GE19101@kadam.lan>
References: <20191115122316.20893-1-beniamin.bia@analog.com>
 <20191115122316.20893-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115122316.20893-2-beniamin.bia@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 15, 2019 at 02:23:14PM +0200, Beniamin Bia wrote:
> @@ -216,6 +240,21 @@ int ad7091r_probe(struct device *dev, const char *name,
>  			return ret;
>  	}
>  
> +	st->vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(st->vref)) {
> +		if (PTR_ERR(st->vref) == EPROBE_DEFER)
                                      ^^^^^^^^^^^^^^^
Missing - on EPROBE_DEFER.

> +			return -EPROBE_DEFER;
> +
> +		st->vref = NULL;
> +	} else {
> +		ret = regulator_enable(st->vref);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
> +		if (ret)
> +			return ret;
> +		}

Curly brace is indented an extra tab.

regards,
dan carpenter
