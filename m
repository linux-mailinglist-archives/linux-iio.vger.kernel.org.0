Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46921CCCD1
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgEJSMG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 14:12:06 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:39226 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgEJSMG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 May 2020 14:12:06 -0400
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 2C577177365
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2020 12:12:04 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id XqQjjCoMaVKjoXqQljgT8s; Sun, 10 May 2020 12:12:04 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=K7oM4ReI c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=sTwFKg_x9MkA:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=VwQbUJbxAAAA:8 a=9eRCeKCxr6mOf_OUt6IA:9 a=GWRvtodc5lQpLaii:21
 a=Ohp1ws75Cw8cpDCh:21 a=QEXdDO2ut3YA:10:nop_charset_2
 a=sfIEtMYjypgA:10:uccc_2email_address a=rsP06fVo5MYu2ilr0aT5:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OvLi804xCZ6xtXakpo4loaLqT7X+ucK02sepeBhNHRc=; b=ZgVFZrzARaLCKT1J2MrUDfTHMZ
        /AeJZZOhwqb3sV4v62yJfJshPH5O0iLuSvlLqVSIv2jM4ZkN7nVvxtZELcHsyXEgf0A2sTFniHx4g
        Z//8AagL4UWfTNswCZq/MKJlB9PTwwu8lhvrpryK9/0wDjAUuZFNfKlnUlc0uBdqcRhBrs62FmMBc
        PQMSKqHPAvSQaPAN6a2KfleljZfeJyl7x9ja6UFyo9kq9PeFYNiT5+AwyChfiicuAQFEBMUUVmzY3
        4xqPuDrjc51FVooYPbl6M5fvVubB5XvtsaggrYjsO1hQZ+HtHlsJVa8yRk6vtzNNW1rMCTXHmDfTm
        4G/UUvHw==;
Received: from p5dcfef04.dip0.t-ipconnect.de ([93.207.239.4]:43660 helo=[192.168.0.104])
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jXqQi-00045H-HA; Sun, 10 May 2020 18:12:00 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
Subject: Re: [PATCH v2 3/4] iio: accel: wsen-itds accel documentation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20200429133943.18298-1-saravanan@linumiz.com>
 <20200429133943.18298-4-saravanan@linumiz.com>
 <20200503130103.16a92131@archlinux>
Message-ID: <9e7b0365-deed-a647-ec36-b4e6ccfa2ae4@linumiz.com>
Date:   Sun, 10 May 2020 20:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503130103.16a92131@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 93.207.239.4
X-Source-L: No
X-Exim-ID: 1jXqQi-00045H-HA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5dcfef04.dip0.t-ipconnect.de ([192.168.0.104]) [93.207.239.4]:43660
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 10
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 03/05/20 2:01 pm, Jonathan Cameron wrote:
> On Wed, 29 Apr 2020 15:39:42 +0200
> Saravanan Sekar<saravanan@linumiz.com>  wrote:
>
>> Add documentation about device operating mode and output data range
>> supported according to operating mode
>>
>> Signed-off-by: Saravanan Sekar<saravanan@linumiz.com>
>> ---
>>   .../ABI/testing/sysfs-bus-iio-wsen-itds       | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
>> new file mode 100644
>> index 000000000000..5979f2b8aa1a
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
>> @@ -0,0 +1,23 @@
>> +What:		/sys/bus/iio/devices/iio\:device0/in_accel_samp_freq_available
>> +KernelVersion:	5.7
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Reading gives range of sample frequencies available for current operating mode
>> +		after one data has generated.
> This is standard ABI so should be the main docs, not here.
> It also takes absolute precedence over the power modes (as mentioned below, no
> standard userspace will be able to use those).  So if the frequency is
> only available in high perf mode, then we change to high perf mode.
>
>> +
>> +		Access: Read
>> +		Valid values: represented in Hz
>> +		- range [12.5, 1600] for high permormance mode
>> +		- range [1.6, 200] for normal/low power mode
>> +
>> +What:		/sys/bus/iio/devices/iio\:device0/operating_mode
>> +KernelVersion:	5.7
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Represents the device operating mode. High performance mode gives high output
>> +		data rate and low noise compared to normal mode. Normal mode consumes less
>> +		current.  In single shot device enters to lowpower after one data has
>> +		generated.
>> +
>> +		Access: Read, Write
>> +		Valid values: "lowpower", "normal", "high_perf", "single_shot"
> The issue with these sort of 'mode' interface is almost no userspace will ever use them.
> They are too unpredictable across different types of devices.
I don't understand how can we assume or say no one will use this. The 
device supports multiple features
and my understanding is driver should support according to device, not 
reverse. This is more or
less device specific and no sure idea about bring all the device in one 
umbrella.
> Some of these should also not be exposed to userspace anyway as they are about 'how'
> you are using the driver.  For example, if you aren't doing triggered capture then
> single_shot is almost always the correct option. Annoyingly I see high performance
> mode gives lower noise...
>
> So no need to expose single_shot to userspace.
>
> For the others we are just looking at different power vs speed and accuracy trade offs.
> Those are better exposed by what they effect.  Here the big control for that is
> sampling frequency.
>
> So if we assume the user is never going to touch this control (if it's even there)
> then we probably want to assume they want the best possible accuracy for whatever
> frequency they are running at.  So transition across the modes to provide that.
>
> Should we ever support low power mode?  It sounds nice on paper, but in reality
> userspace won't use so I suspect we should just drop it - certainly in an initial
> patch submission (as it will hold up acceptance).  Even if we did support
> it, as mentioned above ABI controls will take precedence so we are looking
> at a 'hint' not a control of mode.
>
> ABI is a pain, and we will put a lot of effort into not expanding it unless
> there is a good usecase plus no way of mapping to existing ABI.
Obviously without any reason or requirement device manufacture won't 
come-up these kind of feature.
I will change the driver as you don't accept at least for initial version.


Thanks,
Saravanan

