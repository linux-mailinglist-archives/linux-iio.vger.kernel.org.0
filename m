Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA218319806
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 02:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBLBkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 20:40:07 -0500
Received: from vern.gendns.com ([98.142.107.122]:49368 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBLBkG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 11 Feb 2021 20:40:06 -0500
X-Greylist: delayed 1689 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 20:40:05 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F8f7LywDtKTmk9rZYp4IQgbKog4kMRZJjOcgsQe3LqI=; b=xxBJvN3oq/mEpgslNCzqZoWktf
        YJ0QYkvdGpElUtgNgkwXtP7+tEsxB0biJ3ZWbgHicnsF846uU6fcXixCtGd3jIUUfD8CC6IY3Y96P
        6qWX9qXc9CXI85/JI2r+zF6nrgIbdGBM9eixwoYPbXOTUf5rW0DSSjK9D8MYzlcgG1cPcNQwXiZxO
        XHFez9U8PNdsv6grLAIl+atBuO5RLoPCMCJw4SOxF87+kYMQYPRLUVFe7uKOT6TUvt5UV9CYK6oFu
        8dbpxcLq21lmZuz9YkBzZKRpACK89nYiYAxr+s/UEA+10lLrr9KvzCtzmh79lTKaqaw0Kc+M3FQoE
        kWs9fGLA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:43618 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lAMz7-0001We-0Y; Thu, 11 Feb 2021 20:11:01 -0500
Subject: Re: [PATCH v7 5/5] counter: 104-quad-8: Add IRQ support for the ACCES
 104-QUAD-8
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <bb2db54669ef27515da4d5f235c52e0b484b5820.1608935587.git.vilhelm.gray@gmail.com>
 <7a78ad95-9eba-277d-25da-ddf68357b969@lechnology.com>
 <YCXEFMJOoOhyhfBu@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <add6a885-e666-c5b7-612c-c2d1b08111a5@lechnology.com>
Date:   Thu, 11 Feb 2021 19:10:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCXEFMJOoOhyhfBu@shinobu>
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

On 2/11/21 5:56 PM, William Breathitt Gray wrote:
> On Wed, Dec 30, 2020 at 11:36:45AM -0600, David Lechner wrote:
>> On 12/25/20 6:15 PM, William Breathitt Gray wrote:
>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>>> index eac32180c40d..0ecba24d43aa 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>>> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>>> @@ -1,3 +1,28 @@
>>> +What:		/sys/bus/counter/devices/counterX/countY/irq_trigger
>>
>> Do we really need this sysfs attribute? Shouldn't interrupts be configured
>> _only_ by the chrdev interface?
> 
> I think this attribute can go away because we can implicitly figure out
> the correct IRQ configuration from the struct counter_watch data when a
> user executes a COUNTER_ADD_WATCH_IOCTL ioctl command.
> 
> However, I need some help deciding on an appropriate behavior for
> conflicting counter_watch configurations. Let me give some context
> first.
> 
> The 104-QUAD-8 features 8 channels (essentially 8 independent physical
> counters on the device). Each channel can independently issue an event,
> but any particular channel can only be set to a single kind of event
> (COUNTER_EVENT_INDEX, COUNTER_EVENT_OVERFLOW, etc.).
> 
> The purpose of the irq_trigger sysfs attribute I introduced in this
> patch is to allow the user to select the event configuration they want
> for a particular channel. We can theoretically figure this out
> implicitly from the struct counter_watch request, so this sysfs
> attribute may not be necessary.
> 
> However, how do we handle the case where a user executes two
> COUNTER_ADD_WATCH_IOCTL ioctl commands for the same channel but with
> different event selections? I'm considering three possible behaviors:
> 
> * Fail the second ioctl call; event selection of the first struct
>    counter_watch takes precedence and thus second is incompatible.
> * Issue a dev_warn() indicating that the second struct counter_watch
>    event selection will now be the event configuration for that channel.
> * Don't notify the user, just silently reconfigure for the second struct
>    counter_watch event selection.
> 
> I'm suspecting the first behavior I listed here (ioctl returning failed)
> is the most appropriate as a user is explicitly made known of this
> particular device's inability to support more than one type of event per
> channel.
> 
> What do you think?
> 

I agree that it should return an error instead of adding the watch.
I'm pretty sure that is how I implemented the TI eQEP driver already.

