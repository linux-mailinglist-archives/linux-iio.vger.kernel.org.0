Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE236A838
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhDYQFv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 12:05:51 -0400
Received: from www381.your-server.de ([78.46.137.84]:41226 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhDYQFu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 12:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=1GQ5akc9O+xkZSrawfFCPTKMi5K02rD6O4QtWIcBTZY=; b=i6baA5TmzzWpRd6P1cCvgeKhfj
        8maaQ/neWgIkQ6XcLUSEoKmqBbKEBDfW6+bHKc/mKT27HubRKSRJKXmaJT0SP0LaNqu0kA9xHFLV3
        R+tdpZX8OpQl77z9MXmN+9vDUY0O8X0/XSZXYdjqiHbsGd/Qc6Oj0Rz1kCRRhUbry0QRB3mEGMi7E
        RTtfH37BbuSqE+caxdu+f0QhC/tgPHWrw2jt00tQX8CFR5Ael0TtQmUmiwvMs1TGmRokmUWmNhu0a
        hkm6Kc1jVMfa1gRIh2yPj1qjkgVWjj8ahKougtXZxVXPnpUhE+oz6zdX8OuN6FGck8wUWTn+vMWDr
        VRiHiZ1w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lahFs-000D3v-Gy; Sun, 25 Apr 2021 18:05:08 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lahFs-000X7A-Cj; Sun, 25 Apr 2021 18:05:08 +0200
Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Make IRQ optional
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Anand Ashok Dumbre <anandash@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org
References: <20210425102638.9511-1-lars@metafoo.de>
 <20210425102638.9511-2-lars@metafoo.de>
 <20210425162559.11371323@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2d5f7509-a08e-91ec-dff7-2c70eb57aaa6@metafoo.de>
Date:   Sun, 25 Apr 2021 18:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210425162559.11371323@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26151/Sun Apr 25 13:05:06 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/25/21 5:25 PM, Jonathan Cameron wrote:
> On Sun, 25 Apr 2021 12:26:38 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> In some setups the IRQ signal of the XADC might not be wired to the host
>> system. The driver currently requires that an interrupt is specified. Make
>> the interrupt optional so the driver can be used in such setups where the
>> interrupt is not connected.
>>
>> Since both buffered capture as well as events depend on the interrupt being
>> connected both are not available when the interrupt is not connected.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Code looks fine to me but raises a question.  As there is no validate_trigger
> callback in this driver, nothing stops it being associated with for example
> an hrtimer trigger.  I don't think that will work so perhaps we should add the
> callback?  If it does work, then the presence or not of an irq should not
> change whether we register the buffer.

This is a good point. But the driver can actually work with a hrtimer 
trigger. You'd get aliasing problems and all that stuff, but if you only 
care about the instantaneous values it will work.

Without an IRQ we should only mask out the events and not register the 
triggers. Registering the buffer should be fine.

- Lars

