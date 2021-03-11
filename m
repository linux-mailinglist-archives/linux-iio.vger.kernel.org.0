Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAC3377EC
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 16:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhCKPfa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 10:35:30 -0500
Received: from www381.your-server.de ([78.46.137.84]:40586 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhCKPfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 10:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=SCt0exIS+NG9RAhZ70vt5uw9rDwuj9pgIIf4Kc4kcbI=; b=DJNkiGprenSAOFHVj5/efl6+Yt
        dEhHf2ZCdqmrZpjeD6TE1BsPT0QXqaulRtiVNKWPEVRVxaFYJHcqWxyrnHW8AxtxPjZu2d+glH7EK
        Rmfs3d3GOeumkQd7B/DrB2tdBllMXigGSJUhfqEwwS5oDxMjfy4QdlsnRViPuQ3r6HA5Gjzeo1+FL
        7c2yN3F9LaWKksvAn9RATW9M7e213Fuzs/sdFttDmbEF12PQWHRcNnXE/TZzGNraqLi/Sec+bXJVE
        993m/dZGNAMi3YoljRgU1Fv89IqjTgoExZmAs/BMCoUDHIeVRvHmZs+vbSeRrjwv1xfzYxlNmmVaW
        DYA5ONPg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lKNLF-0008il-Es; Thu, 11 Mar 2021 16:35:13 +0100
Received: from [2001:a61:2aea:a901:224:d7ff:fe9f:8154]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lKNLF-000Pot-AU; Thu, 11 Mar 2021 16:35:13 +0100
Subject: Re: GSoC IIO project: Mugil
To:     Mugil Raj <dmugil2000@gmail.com>, linux-iio@vger.kernel.org
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8e719167-27b6-436c-7bcd-9eb2b85500e6@metafoo.de>
Date:   Thu, 11 Mar 2021 16:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26105/Thu Mar 11 13:09:56 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/11/21 8:01 AM, Mugil Raj wrote:
> Hi,
> This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
> GSoC'21 for the project IIO driver. So, I need help from you guys with
> the application process and finding the device to develop a driver.
> I've done few exercises on patch submissions and completed a Linux
> Foundations course, "A beginners guide to Linux kernel development
> (LFD103)". I found this "https://kernelnewbies.org/IIO_tasks" task for
> beginners, and now I'm doing that also If anyone suggests some fixes
> to develop, that would be helpful for me.
> 
> Is there any IRC channel for IIO?

#linux-iio in irc.oftc.net. It is a bit quiet at times, but if you stick around 
you'll usually get a reply.

- Lars
