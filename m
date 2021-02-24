Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C73323727
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 07:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhBXGKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 01:10:05 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:40472 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhBXGKE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2021 01:10:04 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210224060921epoutp04a0e061cd9fa2f9171a50533e6642706a~mmhv6BZPb0144301443epoutp04y
        for <linux-iio@vger.kernel.org>; Wed, 24 Feb 2021 06:09:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210224060921epoutp04a0e061cd9fa2f9171a50533e6642706a~mmhv6BZPb0144301443epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614146961;
        bh=lUNO9sPSxE5o4aS0CTnJy7QerwMb/kkedf/3C7YNiho=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BoGKshoVS/Ou04W1hxhJxjtQxvetfyPOZ0nsr3BMWUVKMeGkVkjXI7Rww91t10PSx
         M3sjPO2KreSI2a9TCKZYc62ZaN2quA+paMhx+W6+VpNum8CTnPrLEtX8oDpOHkHfT5
         6BJLu3xXYuKvpcYPp2F/4P0J2RJ427e4RLDaSSug=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210224060920epcas1p4118ef997ff38056275752b3276c00882~mmhvUNqYt0337803378epcas1p47;
        Wed, 24 Feb 2021 06:09:20 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Dllqd6SsHz4x9QB; Wed, 24 Feb
        2021 06:09:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.4C.09577.D8DE5306; Wed, 24 Feb 2021 15:09:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210224060917epcas1p37c2d49fee6ee8c7f4e799bc80147cfec~mmhr7v2PQ0758407584epcas1p39;
        Wed, 24 Feb 2021 06:09:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210224060917epsmtrp2f288292bb3a138f14c55bf7b7ee96f10~mmhr62ip92303623036epsmtrp2W;
        Wed, 24 Feb 2021 06:09:17 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-cb-6035ed8db579
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.8C.13470.C8DE5306; Wed, 24 Feb 2021 15:09:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210224060916epsmtip2774f357f869ce792c8ff0af9f60e8740~mmhrrDAVf2155221552epsmtip2h;
        Wed, 24 Feb 2021 06:09:16 +0000 (GMT)
Subject: Re: [PATCH 2/2] units: Use the HZ_PER_KHZ macro
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AMS AS73211 DRIVER" <linux-iio@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c493dac9-9199-12c9-365a-8c96cb73d91e@samsung.com>
Date:   Wed, 24 Feb 2021 15:25:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210223203004.7219-2-daniel.lezcano@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmgW7vW9MEg89TjCwOz6+waOy9zmgx
        77OsxYOmVUwWZ5vesFssmTyf1WLekXcsFpd3zWGz+Nx7hNHiduMKNovfu46xW8z9MpXZ4snD
        PjYHXo9jazazeize85LJY9OqTjaPO9f2sHkseXOI1eN88xFGj74tqxg9Pm+SC+CIyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpYSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdsemcVsEB
        wYqV17axNzDu5Oti5OSQEDCReHFmFksXIxeHkMAORom5C44xgiSEBD4xSqyeXg5hf2OU+Dgz
        uYuRA6xh2wpxiPq9jBJbd55mg3DeM0rsuXwWrFlYwELi+/4PTCC2iICjxJe/i9hBipgFXjJL
        XJjbywKSYBPQktj/4gYbiM0voChx9cdjsGZeATuJmyufMIJsYxFQleidaQESFhUIkzi5rQWq
        RFDi5MwnLCAlnEDl7e0xIGFmAXGJW0/mM0HY8hLb385hBlkrIXCHQ+LX/mlsEB+7SDxdeJcR
        whaWeHV8CzuELSXx+d1eqJpqiZUnj7BBNHcwSmzZf4EVImEssX/pZCaQxcwCmhLrd+lDhBUl
        dv6eywixmE/i3dceVkhg8Up0tAlBlChLXH5wlwnClpRY3N7JNoFRaRaSb2YheWEWkhdmISxb
        wMiyilEstaA4Nz212LDAFDmmNzGCU7KW5Q7G6W8/6B1iZOJgPMQowcGsJMLLdtcoQYg3JbGy
        KrUoP76oNCe1+BCjKTB4JzJLiSbnA7NCXkm8oamRsbGxhYmhmamhoZI4b5LBg3ghgfTEktTs
        1NSC1CKYPiYOTqkGJr3/Ns2PWlJ+bv1QcSFcoMah00ekUtwn/uel2uXdiv9/pHN2tD9INWR6
        ncMQtLhbyOna45rLq3aFn6zIvnNGn/HPBb0HLaLTF8V29TN8W3BqR8Bl5j+zrGsf+tz/dPxg
        +IRkHbbwDTvj1ZqEbatqeG9pz2JduK1gziuP2GO52x06hE4c/8DMFaUfYO/3d7Up/6vfJaFL
        MsTd1s0pdX7Stvpb/+S6L6Y8rs46/vN/iv0vnSpuuL6l3yMgstrpejzP/ugSlV+hCgbrX6Xs
        e2g4UWBe/JNqwawrqmllGpySm1ccNNj+L/7BOeNzU2acnKVqvn731bVxfNcso+bXRr6L9bu6
        XNxefYHeB3aLs/zXlFiKMxINtZiLihMBpDq6tVIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvG7vW9MEg6bdjBaH51dYNPZeZ7SY
        91nW4kHTKiaLs01v2C2WTJ7PajHvyDsWi8u75rBZfO49wmhxu3EFm8XvXcfYLeZ+mcps8eRh
        H5sDr8exNZtZPRbvecnksWlVJ5vHnWt72DyWvDnE6nG++QijR9+WVYwenzfJBXBEcdmkpOZk
        lqUW6dslcGVsOqdVcECwYuW1bewNjDv5uhg5OCQETCS2rRDvYuTiEBLYzSixbeU5pi5GTqC4
        pMS0i0eZIWqEJQ4fLoaoecsoMWXhTxaQGmEBC4nv+z+A1YsIOEp8+buIHaSIWeAts8Snjh8s
        EB1HGSU2fV3HDlLFJqAlsf/FDTYQm19AUeLqj8eMIDavgJ3EzZVPGEG2sQioSvTOtAAJiwqE
        Sexc8pgJokRQ4uTMJywgJZxA5e3tMSBhZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS
        7llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg+NTS3MG4fdUH
        vUOMTByMhxglOJiVRHjZ7holCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1
        tSC1CCbLxMEp1cB0dMGvWrvp/9eary5vv2s+Ta5+P6cQw9KEHQcDe3qyc9OnJDYsl6/jWlC8
        Ifjm459M4ekz498fT567x3WR2R6rp9+W8XW+U723/v+GzKpmnh1dliX797V4/ZdZ9XFpwu7L
        ckaP1xeY26w5/rnMJzht6YPqFwyO1hKPa103px0QCrqfbOcn+HflF468q4sW8F0Km7rgakm8
        6w8exUiGuxHtOx1s5XMOnD4Sot+n8mfL5jfztglNvr2R0byPq2e1050bcTwRZzWvXNxzQ+KI
        0OX06DeJTNNsd7ttuvY612fbpcDOyXxxmZG3mFhd1T/Pzm2w4pafpOp8rTJWYj/jHqnEZQEz
        etVMnBdPNE4rtTVXYinOSDTUYi4qTgQA5pXmpz4DAAA=
X-CMS-MailID: 20210224060917epcas1p37c2d49fee6ee8c7f4e799bc80147cfec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210223203223epcas1p43d6a797026eb0d36d4f5b77bd5d79d6d
References: <20210223203004.7219-1-daniel.lezcano@linaro.org>
        <CGME20210223203223epcas1p43d6a797026eb0d36d4f5b77bd5d79d6d@epcas1p4.samsung.com>
        <20210223203004.7219-2-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/24/21 5:30 AM, Daniel Lezcano wrote:
> The HZ_PER_KHZ macro definition is duplicated in different subsystems.
> 
> The macro now exists in include/linux/units.h, make use of it and
> remove all the duplicated ones.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/devfreq/devfreq.c         | 2 +-
>  drivers/iio/light/as73211.c       | 3 +--
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6aa10de792b3..4c636c336ace 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
>  #include <linux/pm_qos.h>
> +#include <linux/units.h>
>  #include "governor.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -33,7 +34,6 @@
>  
>  #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
>  #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
> -#define HZ_PER_KHZ	1000
>  
>  static struct class *devfreq_class;
>  static struct dentry *devfreq_debugfs;
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 7b32dfaee9b3..3ba2378df3dd 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -24,8 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
> -
> -#define HZ_PER_KHZ 1000
> +#include <linux/units.h>
>  
>  #define AS73211_DRV_NAME "as73211"
>  
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index fed3121ff2a1..fa5b8b0c7604 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -19,10 +19,10 @@
>  #include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  #include <linux/thermal.h>
> +#include <linux/units.h>
>  
>  #include <trace/events/thermal.h>
>  
> -#define HZ_PER_KHZ		1000
>  #define SCALE_ERROR_MITIGATION	100
>  
>  static DEFINE_IDA(devfreq_ida);
> 

For devfreq part,
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
