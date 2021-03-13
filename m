Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22A1339DAA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 11:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhCMKrH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 05:47:07 -0500
Received: from www381.your-server.de ([78.46.137.84]:44828 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhCMKqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Mar 2021 05:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=UN136MlC/RaejTyzQnpIwKjkPU9AEdBro+fAoPikmpw=; b=Aqtpn18cyZbFd5w+6daURA4OLA
        wY88WDkNng9R87WO98rI0g2xpkBOYpNhhy6B63sV4AXwQUwXLSjUrXXr1OQvj2Oc0UqQp0ZVhHD/4
        U0vSiskmXKW9xR8Wtqx2VXb4NsEUiB613JEjPBS7Rs7CqCYu71diBYfLnbnWF7apG5+4TNIj1GjFi
        F4rCPXxfnpni91yWvtqiiAMvp6OojfL5neX1tjfXoHwwEV/YrHutr95v61zXLxyCoCk12U96NsLx9
        WekrdVRbvnz+9scLd4yUhII+u47KmkdZ+FKSZQAGJVsHww4Cyto2/4Ib7/qLaHbp0itD/2XZtK3l/
        37fHVMIQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lL1nH-0005rx-CJ; Sat, 13 Mar 2021 11:46:51 +0100
Received: from [2001:a61:2aea:a901:224:d7ff:fe9f:8154]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lL1nH-0008z4-9U; Sat, 13 Mar 2021 11:46:51 +0100
Subject: Re: IIO advise + help
To:     Michel Arruat <michel.arruat@cern.ch>, linux-iio@vger.kernel.org
References: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c41ae3c7-ce3d-9036-280c-b25354bea22b@metafoo.de>
Date:   Sat, 13 Mar 2021 11:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26106/Fri Mar 12 13:03:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/12/21 5:54 PM, Michel Arruat wrote:
> Dear IIO Maintainers,
> 
> I'm starting studying IIO framework in order to migrate our acquisition 
> systems, based on fast ADC, to this framework.
> So far we are using our framework named ZIO which was developed more than 10 
> years ago, when IIO was not mature enough to handle high speed constraints, 
> large DMA transfer(>256MB) and zero copy.
> Out of curiosity https://ohwr.org/project/zio

I did have a few discussions with Frederico and Alessandro back in the day 
(maybe 6-7 years now) about what can be done to combine IIO and ZIO. 
Unfortunately we couldn't quite get agreement on whether it is better to have 
one or two frameworks.

One thing where IIO and ZIO differ is that IIO is more around streaming data, 
while ZIO is around packetized data. In ZIO when you capture data you get a 
header with metadata.

But having support for packetized data with metadata in addition to streaming 
data is something we wanted to have for IIO for a while now. Just nobody has 
implemented it yet.

I know that there are a few people that use IIO with packetized data, but it is 
sort of in a hacky way where the userspace application uses the streaming 
interface but captures exactly the number of bytes that are in a packet. This 
sort of works, but having proper packetized data support would be nice.

> 
> The idea is to get rid of our local framework and move to IIO to benefit from 
> the large Users community.
> For now, most of our drivers are running on x86_64 architecture, even if future 
> applications will run on SoC (Zynq UltraScale+).
> I made a first prototype, widely inspired from your "ad_adc.c" driver found on 
> your git repo, with a 4.18 kernel. I am facing some issues including kernel 
> Oops while unloading the module.
> Could you please let me know which minimal kernel version is required to use 
> the "IIO DMA engine buffer" features. In addition, I would really appreciate if 
> you could point me to some reference IIO ADC driver implementation that handles 
> similar DMA transfer size with good performances.

As Alex said high-speed support is still in progress of being upstreamed.

I do maintain a set of branches for recent Linux LTS releases which have a 
minimum set of patches to get high-speed support enabled.

See https://github.com/larsclausen/linux/branches

Maybe this is helpful since you should be able to easily import them into your 
kernel tree.

- Lars
