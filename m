Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5E224D19
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGRQg5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:36:57 -0400
Received: from www381.your-server.de ([78.46.137.84]:50708 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRQg5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jul 2020 12:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MuAF07/PLYpW3vDGuXu6XLibaUuocTYnjLIQeyAsQI0=; b=RmXTjFH1+pOtSPwnYZcb2DsfUK
        jf1gsQQBazFVX/Ntfzfa1iptZXdb3uRKHeLwDQioklHhFkemG+QC1un/iVZixXYHfHFZMc9ZPg9wf
        tMF95BGfusRR6Ki2PkAOSPVPPLtp7XCuXbI8jIDU23VQH/NSsQ1bSKOKASDpTHy2devf1AScVT717
        N2+Ynnae8wHjGrEip6nQ5q57Gc81vhbS4LUd86cJ2u1O4BXWZ/57Gv4VKSgFGPTmcdRYugmFMyPem
        VEXDLk7Pur/Spky6Uxlge+mkcBbQZoPWw7CSoYtQcVQkqj5lo2I5aV4yYTUMVRwbcOBmBzJe/e0Kt
        hXXEBlKQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jwppU-0002Yl-8e; Sat, 18 Jul 2020 18:36:52 +0200
Received: from [62.216.206.120] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jwppU-0005jj-4K; Sat, 18 Jul 2020 18:36:52 +0200
Subject: Re: [PATCH] iio: trigger: Staticise stub functions
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200714142456.67054-1-alexandru.ardelean@analog.com>
 <20200718172501.4ba58924@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <017b33b1-b6f9-107b-b9c4-8c0abd0d6a3b@metafoo.de>
Date:   Sat, 18 Jul 2020 18:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718172501.4ba58924@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.3/25877/Sat Jul 18 16:24:08 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/18/20 6:25 PM, Jonathan Cameron wrote:
> On Tue, 14 Jul 2020 17:24:56 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
>> From: Lars-Peter Clausen <lars@metafoo.de>
>>
>> Make sure that the trigger function stubs are all static inline. Otherwise
>> we'll get linker errors due to multiple definitions of the same function.
>>
>> Fixes f8c6f4e9a40d4: ("iio: trigger: Staticise stub functions")
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> I'm curious on what the actual build error is?  Static functions should
> result in independent implementations in each C file that includes
> them. Inline is normally considered a hint.  Hence what am I missing?

It's a bad commit message, my fault. This should have been

Make sure that the trigger function stubs are all static inline. 
Otherwise we might see compiler warnings about declared but unused 
functions.


