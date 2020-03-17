Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1762C188FC3
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQUwe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 16:52:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:46070 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQUwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 16:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AVIRfURewAUDtcpsATRU8f7bX4bzYCYSZZ+pl4fjRwU=; b=jquuGgalJyhPbq82sxCMZJVdR8
        MmVIBNS1M7giXCtojP60Ny8zha2wK26BMcLUCY6De+GdDMvorpVKtJpQWnL0WzUPlmrQNQ12JnHoT
        Awr8Rt08GcHP88W0CGZrYvnj5QYdDzOPiwA0Lkx4uF1/8uL3e0CMiyJsgDKH+hE0HhGHwZxziRgum
        9nCRPSqc0bGxAAzuIKW7bsRVB4V1FwJ41/wiXv2TK81aJYqSBn9bC5o+QoKP9hGqMTQHeAxbctAat
        UrAPrZgFkhzF+2+guNh3Ny+Xyjdp/aMhT3RYEJGFvpMxFP+W5D7hAddRQwWrKJK02Md1gjZmMAu2M
        bccxX24A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEJCR-0008QF-IP; Tue, 17 Mar 2020 21:52:31 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEJCR-000DzH-95; Tue, 17 Mar 2020 21:52:31 +0100
Subject: Re: [PATCH 0/2] Maxim MAX1241 driver
To:     Alexandru Lazar <alazar@startmail.com>, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
References: <20200317201710.23180-1-alazar@startmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f817b4af-081e-08e7-b260-6411a3f5a43a@metafoo.de>
Date:   Tue, 17 Mar 2020 21:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317201710.23180-1-alazar@startmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 9:17 PM, Alexandru Lazar wrote:
> Hello!
> 
> This patch series adds support for the Maxim MAX1241, a 12-bit,
> single-channel, SPI-connected ADC. It's a pretty sturdy ADC that I've
> used for some time now and I figured my driver may be useful to others
> as well.
> 
> I originally thought I might get this under the max1027 driver but the
> 124x family is different enough that shoehorning it in there didn't seem
> like a good idea. The 1241 has a single channel, no FIFO, uses a
> different mechanism to signal conversion start and has a low-power
> operation mode which it uses in a pretty different way. This is actually
> closer to MAX111x, but those also have a pretty different signaling
> convention.
> 
> Needless to say, though, if anyone who is more familiar with this
> situation disagrees and wants to point me in the direction of the
> appropriate driver, I'm happy to make the changes there instead of
> providing a separate driver.

I think your approach is the best approach here. Trying to build 
"generic" drivers that support lots of only partially related devices 
can get messy real quick.

> 
> Also please note that I am somewhat unfamiliar with the idioms of the
> IIO subsystem's tree. Jonathan Cameron was kind enough to give me a few
> pointers but there are a few questions I didn't bother him with (so I'm
> guess I'm gonna bother you instead now).
> 
> 1. There are two ADCs in this family, MAX1240 and MAX1241. This driver
> only supports the MAX1241. The scaffolding to get MAX1240 support is in
> there, but I didn't have access to a MAX1240 and I didn't want to submit
> untested code for review. Can we add MAX1240 support later, or should I
> do it from the very beginning? Either way is fine by me (I'm just a
> little concerned about how quickly I might *get* a MAX1240 these
> days...)
> 

Can be added later. Its always good to start with a small tested 
baseline. But either way it is up to you, no problem with having it 
supported by the initial patch either.

> 2. Looking at other drivers, it seems to me that, on ADCs that require
> an external reference, it's customary to make a voltage regulator a
> required property in the DT bindings. Am I correct here?

Yes.

> 
> 3. checkpatch.pl warns me that the MAINTAINERS file might need
> updating. I'm not sure what the appropriate thing to do is here -- I can
> maintain this driver indefinitely (I am actively using it anways) but
> it's a 200-line driver, does that warrant inclusion in MAINTAINERS?

Different people will have different options on this. My opinion is that 
it is not needed for small drivers. get_maintainers.pl will list your 
name anyway since you are the author for the commit.

> My apologies if anything here is distinctly bad -- this isn't the first
> time I'm writing kernel code but it's definitely the first time I'm
> sending ay upstream. Any bugs are due to my own incompetence, everything
> else is just temporary ignorance :-).

The driver's code looks very clean. Top job!

- Lars
