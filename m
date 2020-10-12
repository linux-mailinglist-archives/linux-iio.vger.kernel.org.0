Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A187E28BE9A
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 19:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403883AbgJLRER (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 13:04:17 -0400
Received: from vern.gendns.com ([98.142.107.122]:56706 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390355AbgJLRER (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 13:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zJY3Dr6AnVYzWq6bCyK4S4rlKOnb0m8nFs+n4rj0aqA=; b=k/NrFvl5XJsTY+RGXOx8Q7rgV5
        6WNNASc5T2nH77d9p4WJ5StsyyoafuyjaX7OIUA/cx9AzZCWgCRdBuECQRkacLzZujA1K1NtbFU9c
        KT8ra/6X+hfinxyRa8siQlResVDcawWPR3ET4bVDjn+XY2LOmvomALeWmTn4JL19k/gC+3IkGygGh
        WGAyhJUf0R5CDBejIe3Sr7wUWTQl8qhMG11CkFDMgw3zPBV8NQ1L+CdhHkXbHHuBBNBLcUxWHtbMt
        Q02yv7CcfFESjhKZTjKfgLviYlVIbGFNkkQZefNDtOBRrc2s4OMTLDJxaB1PKao2OkQWTGL3nL+ME
        t4YRc7kQ==;
Received: from [2600:1700:4830:165f::19e] (port=46758)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kS1F6-00009H-9o; Mon, 12 Oct 2020 13:04:12 -0400
Subject: Re: [PATCH v5 4/5] docs: counter: Document character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <54190f9875b81b6aa5483a7710b084053a44abb8.1601170670.git.vilhelm.gray@gmail.com>
 <20201008080909.GA31561@amd> <20201008122845.GA3314@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <d06d5e47-5776-85ee-0dc5-8b624e36d83d@lechnology.com>
Date:   Mon, 12 Oct 2020 12:04:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008122845.GA3314@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/8/20 7:28 AM, William Breathitt Gray wrote:
> On Thu, Oct 08, 2020 at 10:09:09AM +0200, Pavel Machek wrote:
>> Hi!
>>
>>> +        int main(void)
>>> +        {
>>> +                struct pollfd pfd = { .events = POLLIN };
>>> +                struct counter_event event_data[2];
>>> +
>>> +                pfd.fd = open("/dev/counter0", O_RDWR);
>>> +
>>> +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
>>> +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
>>> +                ioctl(pfd.fd, COUNTER_LOAD_WATCHES_IOCTL);
>>> +
>>> +                for (;;) {
>>> +                        poll(&pfd, 1, -1);
>>
>> Why do poll, when you are doing blocking read?
>>
>>> +                        read(pfd.fd, event_data,  sizeof(event_data));
>>
>> Does your new chrdev always guarantee returning complete buffer?
>>
>> If so, should it behave like that?
>>
>> Best regards,
>> 									Pavel
>> -- 
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> I suppose you're right: a poll() should be redundant now with this
> version of the character device implementation because buffers will
> always return complete; so a blocking read() should achieve the same
> behavior that a poll() with read() would.
> 
> I'll give some more time for additional feedback to come in for this
> version of the patchset, and then likely remove support for poll() in
> the v6 submission.
> 
> William Breathitt Gray
> 

I hope that you mean that you will just remove it from the example
and not from the chardev. Otherwise it won't be possible to
integrate this with an event loop.

