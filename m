Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC9354C9D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 08:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhDFGRT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 02:17:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48872 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbhDFGRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 02:17:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210406061710euoutp01e993743a45e1832087216a42065a48ed~zMFRm51y51053510535euoutp01F
        for <linux-iio@vger.kernel.org>; Tue,  6 Apr 2021 06:17:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210406061710euoutp01e993743a45e1832087216a42065a48ed~zMFRm51y51053510535euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617689830;
        bh=6kxgouY+vTopnyddfeFYlz4bGmxSvwI6aXPtC0I4ymI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ceti/8F3fRirnOqi6/7nV2YlBz2r0JCjiFtPn1oQfn/5ewxS1vNcoyfz1/9iK2Yrs
         G/nDFsNRo0+gxpoLRYrcalPSNFke6uG//bViutZGDCtPBXwXhoxvcwL3bdrzihGESf
         HGFQwOCnS1Llb6xOuBMUjo/MK2DqPqTI2akx4qpc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210406061710eucas1p1ccfa6bfa7b4eb73c6dcfc0b2c2397d3f~zMFRfFOK32975229752eucas1p1W;
        Tue,  6 Apr 2021 06:17:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.32.09444.5ECFB606; Tue,  6
        Apr 2021 07:17:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210406061709eucas1p1e8c4a2ad214fc3eec6e3c91c09607fed~zMFRDu2ML2972829728eucas1p1D;
        Tue,  6 Apr 2021 06:17:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210406061709eusmtrp2337a8e0a500d478fa32c67b0a23ee101~zMFRDINWU2270622706eusmtrp2o;
        Tue,  6 Apr 2021 06:17:09 +0000 (GMT)
X-AuditID: cbfec7f4-dbdff700000024e4-7f-606bfce5573a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.6C.08705.5ECFB606; Tue,  6
        Apr 2021 07:17:09 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210406061709eusmtip147463ca24a3bca8c6459eba331cb0e1e~zMFQv9cZ-0978709787eusmtip1g;
        Tue,  6 Apr 2021 06:17:09 +0000 (GMT)
Subject: Re: [PATCH] iio: buffer: use sysfs_attr_init() on allocated attrs
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <6c77abb2-0b6f-a745-0950-0be34d41913e@samsung.com>
Date:   Tue, 6 Apr 2021 08:17:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402174226.630346-1-aardelean@deviqon.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd2nf7ITDLoO2Fi0PVexeNC0isli
        3pF3LBaXd81hc2DxWLVzHbPHplWdbB6fN8kFMEdx2aSk5mSWpRbp2yVwZfTsvsBWcJWv4u7K
        jywNjMt4uhg5OSQETCTenehj72Lk4hASWMEo8enQfFYI5wujxLMpe6AynxklVr8+xg7T8rPz
        PxtEYjmjxOU7e1ggnI+MEl9XnmADqRIW8JJYt+8WWIeIQKbErWm/WUFsZgERiY+9W8HibAKG
        El1vu8DqeQXsJJ7PWsoIYrMIqEis+7EIrEZUIEli6aN/jBA1ghInZz5hAbE5BWwkNsycAzVT
        XmL72znMELa4xK0n85lADpIQ2MEh8XTKQ0aIs10kDr5rg7KFJV4d3wL1jozE/50wDc2MEg/P
        rWWHcHqAfmuaAdVhLXHn3C+gUzmAVmhKrN+lDxF2lLi4t48JJCwhwCdx460gxBF8EpO2TWeG
        CPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQvLaLCTvzELyziyEvQsYWVYxiqeWFuempxYb5aWW
        6xUn5haX5qXrJefnbmIEppTT/45/2cG4/NVHvUOMTByMhxglOJiVRHh39GYnCPGmJFZWpRbl
        xxeV5qQWH2KU5mBREudN2rImXkggPbEkNTs1tSC1CCbLxMEp1cA0vck6fuakR+1XBCbwXZmo
        12+2ITjWcGUaW50Z84zZq/11+kRb1v5yLgsTK3hue/S9wv3Ds9mX/tS6JSU0SWfFzE/xrCFu
        h8u3Tk4X/2YmcNRgivqN20+EnyrxH/Tnsvn2YvIyzStvLynJtDIEO03dqS4n6tzabX4/etnl
        E+vq/zrYep+Ku/Ukf9GmM92urIZSDDw2QRNTWBZe3jyx79S6/2Fxhu+fFJwzWjmvxc8qoq+m
        +NaDpU55vGYCnYwr7Hd+y7FKcsyQ3Dj/8GT1ZNHO+zk3Nat6XFf9v1d0q/K6Z8aFwuWCatWc
        MkaFFYodGQ22rVNqkte8Oh29r0c18bflFAHNq8s2mIs7eUxYt12JpTgj0VCLuag4EQDvwIA0
        mAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7pP/2QnGKx6rGTR9lzF4kHTKiaL
        eUfesVhc3jWHzYHFY9XOdcwem1Z1snl83iQXwBylZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
        YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9Gz+wJbwVW+irsrP7I0MC7j6WLk5JAQMJH42fmf
        rYuRi0NIYCmjxLwDPxghEjISJ6c1sELYwhJ/rnVBFb1nlFj+5AkLSEJYwEti3b5b7F2MHBwi
        ApkSX995g4SZBUQkPvZuZQexhQT6GSWmnNEBsdkEDCW63oLM4eTgFbCTeD5rKdguFgEViXU/
        FoHViwokSbTtnskOUSMocXImxCpOARuJDTPnsELMN5OYt/khM4QtL7H97RwoW1zi1pP5TBMY
        hWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyfbcd+bt7BOO/V
        R71DjEwcjIcYJTiYlUR4d/RmJwjxpiRWVqUW5ccXleakFh9iNAX6ZyKzlGhyPjCC80riDc0M
        TA1NzCwNTC3NjJXEebfOXRMvJJCeWJKanZpakFoE08fEwSnVwKRwTOgB4+yzi+7YNXv36zt+
        1maef31+Iv86m7zijtOhKpf/LTfdYnDi25I7D04lnftkx3Xo/haBtCsbM5u5RKYsn6Dsfeuf
        d+X/FT80rx1SmyeY8f8Rr8lBRc9gJ4ZD/TMdPNUU9jaVLQ9zUtm9pO60a+MfB4OMVNXHnnv3
        au3My5U1yY/cb1MQWD99YYr/FG/9H+dmKVmv6mrZXeKi4vJIQShuUeEG06KgBbLHBb/Kr7z+
        s1vbosxSr2VS3hmeYlt3zsCdB/dFupW5b5504YvZmz8H3h4p3fZ5w/KM8nmBjCqP/rzNnVyR
        qS+64CIfn++vZf4HuvZ9MTqW++vcv4keWg8jnC7+c3l8o7OVY4kSS3FGoqEWc1FxIgA5puS4
        KAMAAA==
X-CMS-MailID: 20210406061709eucas1p1e8c4a2ad214fc3eec6e3c91c09607fed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210402174237eucas1p1b117ceaf744e851703a229e87725f776
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210402174237eucas1p1b117ceaf744e851703a229e87725f776
References: <CGME20210402174237eucas1p1b117ceaf744e851703a229e87725f776@eucas1p1.samsung.com>
        <20210402174226.630346-1-aardelean@deviqon.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02.04.2021 19:42, Alexandru Ardelean wrote:
> When dynamically allocating sysfs attributes, it's a good idea to call
> sysfs_attr_init() on them to initialize lock_class_keys.
> This change does that.
>
> The lock_class_keys are set when the CONFIG_DEBUG_LOCK_ALLOC symbol is
> enabled. Which is [likely] one reason why I did not see this during
> development.
>
> I also am not able to see this even with CONFIG_DEBUG_LOCK_ALLOC enabled,
> so this may [likely] be reproduce-able on some system configurations.
>
> This was reported via:
>    https://lore.kernel.org/linux-iio/CA+U=DsrsvGgXEF30-vXuXS_k=-mjSjiBwEEzwKb1hJVn1P98OA@mail.gmail.com/T/#u
>
> Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>
> @Marek: could you maybe test this on your setup?
>
> I haven't been able to reproduce this on mine.

Works fine with this fix. Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Thanks
> Alex
>
>   drivers/iio/industrialio-buffer.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index ee5aab9d4a23..06b2ea087408 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1309,6 +1309,7 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
>   	iio_attr->buffer = buffer;
>   	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
>   	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
> +	sysfs_attr_init(&iio_attr->dev_attr.attr);
>   
>   	list_add(&iio_attr->l, &buffer->buffer_attr_list);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

