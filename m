Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3347898B
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhLQLM5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 06:12:57 -0500
Received: from www381.your-server.de ([78.46.137.84]:48190 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhLQLM4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 06:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=M1qZmw40PXqMqrgw+K/36cyB5pi+79BF89HAxnb27ZE=; b=S509tAKUYo/17+1G2Ncqyxaslx
        uY1E867+vfu+1Wzcia4YP8zow7ElragPp3abADLhtVzYS0qILz+DqmgnxIqSeOD7RrbGzCPS4ZHFn
        3T5EQAQtJRmCXmYMkwXHT1yBuwXptwYZN/eIn/jnGHfZyc5DXJWEiDJ7V/azPA91AUJL+m1cYg1hm
        4QyvDmRVvNTnSYH+LdvQ1olmXrJoBSaZ10ae1b9azMpRjJ9q2AQvBbAbuB+CUsBDK7/Bol4lMs0VL
        rV4FVK93Y2fEvr99dn+RHrNipsUNJZrkhpe4Z+u8aZTyNOxDYuUbYhGQpXGNcxOutRxDBORTiOpEJ
        mOiURiBA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1myBAV-0001XN-OA; Fri, 17 Dec 2021 12:12:55 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1myBAV-000Lsg-L6; Fri, 17 Dec 2021 12:12:55 +0100
Subject: Re: iio_hwmon meaningful names
To:     Henk Medenblik <yoda@deathstar2.nl>, linux-iio@vger.kernel.org
References: <e723786f-abd2-86ac-7eb8-f5e92c63b31c@deathstar2.nl>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a38dd056-3bab-5b0e-724d-7b17f8f6ba05@metafoo.de>
Date:   Fri, 17 Dec 2021 12:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e723786f-abd2-86ac-7eb8-f5e92c63b31c@deathstar2.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26390/Fri Dec 17 10:20:34 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/17/21 11:46 AM, Henk Medenblik wrote:
> Hi,
>
> Did anyone ever asked for meaningful names for the iio-hwmon readout?
> I integrated the Xilinx AMS block which now shows up  through the 
> sensors readout as:
>
> iio_hwmon-isa-0000
> Adapter: ISA adapter
> in1:           1.19 V
> in2:         357.00 mV
> in3:         860.00 mV
> in4:         859.00 mV
> in5:           1.78 V
> in6:           1.78 V
> in7:         842.00 mV
> temp1:        +45.0 C
> temp2:        +44.4 C
> temp3:       -280.2 C
>
> But I believe an option to make more sense of in1 - in7 and 
> temp1-temp3 would be a nice addition. 

IIO recently gained supported for attaching a descriptive label to a 
channel[1]. The hwmon framework has a similar mechanism where a driver 
can report a label for a channel.

But the IIO hwmon bridge doesn't have support for handling labels yet. 
But if you are interested in this feature this might be a nice small 
project to work on.

hwmon also has the sensors.conf which allows to provide labels for 
channels through a userspace configuration file[2].

- Lars

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d4ef9b39ebec
[2] https://linux.die.net/man/5/sensors.conf

