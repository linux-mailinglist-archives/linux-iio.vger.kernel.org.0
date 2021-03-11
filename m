Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2750D337863
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhCKPpi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 10:45:38 -0500
Received: from www381.your-server.de ([78.46.137.84]:55096 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbhCKPpW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 10:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=SUf8Sy7LpIvQdG+kTu8zX+Pjj004yHkcIas+uavxD/M=; b=W/yUWXvLT7/kvanAk72jzzJjol
        tvBCWpkXGKiqHMnHtw2/gHeq90QhQ/ILxc2fTpimVBz1RopQ5a0qSG1iOpb3h/VaVYXTVFytehxb8
        XAbqudyC+pHTsjn5/H+a4r6euuPrKrpZE8CdURh+1xxijj2sH90Tn3WryALVZsFBOuagQcXLYw2Mt
        UpdDD842RxjlIS6rYtzsqtcUwJ66350BmjtFJYqckQsQKt50TWyYbRz6dCZeJ1f4tfNPn/jO7LpC5
        LvnZs35XHKDP4rp0gFiskFBxxdEpUO89XfYrne/yPAhrBKPWy8LWjP2vlhkQhu8ttBMc5RtgxsTn5
        3FwSa/FQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lKNV3-000AHi-Ao; Thu, 11 Mar 2021 16:45:21 +0100
Received: from [2001:a61:2aea:a901:224:d7ff:fe9f:8154]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lKNV3-000DpW-5r; Thu, 11 Mar 2021 16:45:21 +0100
Subject: Re: GSoC IIO project: Mugil
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Mugil Raj <dmugil2000@gmail.com>, linux-iio@vger.kernel.org,
        utkarshverma294@gmail.com
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
 <708e557e-8318-9141-ccab-c564249a7264@metux.net>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9028e023-fd0a-c10d-2d7a-3b4302638c35@metafoo.de>
Date:   Thu, 11 Mar 2021 16:45:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <708e557e-8318-9141-ccab-c564249a7264@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26105/Thu Mar 11 13:09:56 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/11/21 2:59 PM, Enrico Weigelt, metux IT consult wrote:
> On 11.03.21 08:01, Mugil Raj wrote:
> 
> Hi,
> 
> [ CC'ing Utkarsh, who's got a similar question ]
> 
>> This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
>> GSoC'21 for the project IIO driver. So, I need help from you guys with
>> the application process and finding the device to develop a driver.
> 
> Since you're not very experienced, I suggest starting with some
> simple device like plain ADCs. Several vendors like TI or AD offer
> a huge range of ADCs where we no drivers for >
> I'd start w/ the simple SPI based devices. It seems they've got quite
> some overlap (quite simiar protocols), so parts of that maybe could be
> consolidated into some common library code.

They are sometimes similar, but then have subtle differences. Sometimes 
hardware designers like to move bits around, just because they can.

For one family (100+ devices) we already have such a library, see 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/ad_sigma_delta.c.

What can make a good target for shared code is single channels converters (both 
ADCs and DACs),since there is really only that many ways how to implement that 
in hardware.

> 
> 
> For simple ADCs, I've also got yet another(more complex) idea:
> 
> Create some 'simple-ADC' subsys, which gives a *simple* API for the
> *simple* cases that's bridged to iio and hwmon (maybe even other
> subsys's). The idea is getting actual hw drivers for those devices very
> simple and small, make them usable in IIO as well as hwmon.

Not to forget ALSA. Some ADCs are multi-purpose so that they can be used for 
monitoring, but also audio applications.

I did propose such a ADC subsystem maybe 10 years ago. The conclusions back 
then was that we shouldn't create a subsystem for every sensor type and instead 
use IIO.

> 
> An interesting question here, that needs some deeper thoughs, is the
> driver instantiation into the actual subsystems.
> 
> For example, if some DT says, there's some "ti,adcXYZABC" on the board,
> what does that actually mean for us ? Where (eg. in which subsys) shall
> it appear ? Is it an IIO or hwmon device ? Shall that decision even be
> made only by DT, or do we rely on some other configuration layer ?

Yes, that is a really complicated question. DT is not supposed to describe the 
software (sub-)systems that are used.
