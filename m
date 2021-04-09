Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0D3595EE
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 08:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhDIG7R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 02:59:17 -0400
Received: from www381.your-server.de ([78.46.137.84]:55230 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhDIG7Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 02:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Cy9L1PAo4WObmjbGduwasz5m/vnjkPXQldgkEv8LOlA=; b=N8dzTjBNY+wyZ61iWV6yVX1Yy1
        75OxJBB/b3et5ysEYDBAB7pqoU43IGpUgc18MVepETWJrlUVaF7iJAiltnviBEmOtoTmYfahScSBi
        +jN451LBnHIh5b57w1FZ742TC04wqKWOwUxfwZbUV6hj/9Xo9DwgwZ+BOy7qQAdEnMjPQ5kboAGwY
        eu1OjvIOeIg2rqUx3Ij9rHWDjcTmmiF8RzaArREuF4YzJVtrMsIr/szNyM34ccY3X8AGJ8cf0n0mT
        kbb0t8lz5nSqsS20XzieErYxBlQZP7vIzq8SSyqOLFu9QXdnls13+HAgD6HDQ4rt7t8Sn9nGwP8o8
        JV0KpCJQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lUl6Z-0002aH-2q; Fri, 09 Apr 2021 08:58:59 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lUl6Y-000U4s-T8; Fri, 09 Apr 2021 08:58:58 +0200
Subject: Re: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
To:     Yicong Yang <yangyicong@hisilicon.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        prime.zeng@huawei.com, tiantao6@hisilicon.com
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <219ffc1f-7a5f-62ac-54f5-1b0499cedbdf@metafoo.de>
Date:   Fri, 9 Apr 2021 08:58:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26134/Thu Apr  8 13:08:38 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/8/21 1:38 PM, Yicong Yang wrote:
> Some devm variants are implemented with devres_alloc() and devres_add()
> manually to only manage a single pointer. This can be simplified with
> devm_add_action_or_reset() which works the same. Simplify these functions.
>
Whole series looks good to me, thanks.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

