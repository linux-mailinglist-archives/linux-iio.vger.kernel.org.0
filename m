Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8725A3533CC
	for <lists+linux-iio@lfdr.de>; Sat,  3 Apr 2021 13:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhDCLpn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Apr 2021 07:45:43 -0400
Received: from www381.your-server.de ([78.46.137.84]:35966 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhDCLpn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Apr 2021 07:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=0TWIFkFfRw2A8U4shLoTBKKXAMhn5rjIeEE/n4rooQY=; b=UnvYziEAcknH0KNu4MHGXcb/o5
        NkyfS9n777KV32i34rP1bxWUQiPcScwbuZwAktuuVqN3w8H27RFPQnFgSfwDLp/OFY1PVwoCL8bb7
        B9epy2PAH1Amo9q/ad1d227o0Elxj7YH/NDLE/GRkm49DQqF+Lv0lXbzadJCGUHzb4MDxZEn8V5dV
        oiHcLVlOxr4JCUR2PA4rG2MRb5cwoWFOlQkAc4GVTQZe1/7DjeGeGBlXITZ43uqScgms9P9nLjb8/
        5qlmM+W+LdqHmndCiBIqwhyZ+qvx7X64zppWhUc3RmdHXzbfdzIok7ciyd9BxprRPyaYV8Khu3Yaf
        VSj4QxtA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lSeid-0000jF-Bu; Sat, 03 Apr 2021 13:45:35 +0200
Received: from [2001:a61:2aa1:1e01:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lSeid-000VTB-87; Sat, 03 Apr 2021 13:45:35 +0200
Subject: Re: [PATCH 0/7] iio: Use IRQF_NO_AUTOEN
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210402184544.488862-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c4249ee3-b69c-cc39-0129-6b271f3962a9@metafoo.de>
Date:   Sat, 3 Apr 2021 13:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26128/Fri Apr  2 13:10:37 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/2/21 8:45 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This series is dependant on
> cbe16f35bee68 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> which is available in an immutable tag in the tip tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tag/?h=irq-no-autoen-2021-03-25
> which I'll merge in to the IIO tree if we need it before it's available
> upstream.
>
> That patch introduces a new IRQF_NO_AUTOEN flag for irq requests to avoid
> the current dance where we either mark an irq as not to be autoenabled before
> we know if we can actually request it succesfully, or (as IIO drivers seem to
> have gone with) we disable the interrupt just after requesting it.
> In short the flag stops the interrupt being autoenabled in the first place.
>
> So this series applies this magic to IIO :)
>
> Note these are all just compile tested and some of them aren't entirely
> trivial because of other aspects of the irq flag handling.

Something like IRQF_NO_AUTOEN has been on my wish list for a long time. 
Thanks Barry!

Series looks good.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>


