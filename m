Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7F2569BE
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 20:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgH2SaM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 14:30:12 -0400
Received: from www381.your-server.de ([78.46.137.84]:52636 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Aug 2020 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ERbgAE3pZSuPPJ0AciVRDP2ivLaLFeMXcTLXqWG2SVE=; b=HcLkvCJsyeO91oXJbXf0t/bhGZ
        P/fXd19U0dEgh3KzE0VBhVBHjLI2iz5CvV3qItM73EioluC/CxO5k3+7RJ7kjjI1jPRwqU1fF6V8j
        lc9wMV/1zMNH0/EOe2xwl+GJgWXSOWmOSWRmoN1b8luMDNfGgc88R94bQwmNbTQh1mswB9Fn+aNxR
        vdGeaAc+4jf/BZRKufhReSkI3kYMVv0A/TWRCg7IeDmsh1/z4BQZauvoOfQq24fTOH+yohvFiLmuS
        WkOJd5HV7pFmYOxeWWzcMlQvZ9Doj1IX9IPLWDPxz1Ae+Ftn9XudlQ07Z++siXRU6VrMVXBxiw3w0
        3x41cQjw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kC5c4-0002cI-S7; Sat, 29 Aug 2020 20:30:04 +0200
Received: from [2001:a61:25dc:8101:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kC5c4-000WKk-Nq; Sat, 29 Aug 2020 20:30:04 +0200
Subject: Re: [PATCH] iio: buffer-dmaengine: adjust `bytes_used` with residue
 info
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20200826052011.13348-1-lars@metafoo.de>
 <CA+U=Dsp8KXNzmVGf9N=A+h7DyC2L7Hk2A7N4ERPL4jc+-M_mFg@mail.gmail.com>
 <20200829165134.3361315a@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f336acac-ed70-ad88-57ca-8d06ec54182e@metafoo.de>
Date:   Sat, 29 Aug 2020 20:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829165134.3361315a@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25914/Sat Aug 29 15:19:48 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/29/20 5:51 PM, Jonathan Cameron wrote:
> On Wed, 26 Aug 2020 09:36:39 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
>> On Wed, Aug 26, 2020 at 8:22 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>>
>>> A transfer may fall shorter than the bytes in the block.
>>> This information is available in the residue from the DMA engine, so we can
>>> compute actual `bytes_used` with that by subtracting the residue.
>>>   
>> This was in my pipeline as well [obviously].
>> Thanks :)
>>
>>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> "smells" like a fix.  Is it?  Or are we looking at something that
> only matters for some future hardware, or an optmization?
>
> If it's a fix, where is the fixes tag?

It's a feature :)

When we first added the IIO DMA buffer support this API did not exist in 
dmaengine. So for the longest time most DMA drivers did not have the 
ability to report short transfers. Primarily because in many cases the 
hardware doesn't even support it.

Now with this patch the IIO DMA buffer implementation supports systems 
where the DMA can generate short transfers.

- Lars

