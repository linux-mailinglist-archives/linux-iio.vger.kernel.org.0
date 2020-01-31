Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE614F0F3
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2020 17:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgAaQ4n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 31 Jan 2020 11:56:43 -0500
Received: from smtp111.ord1d.emailsrvr.com ([184.106.54.111]:58110 "EHLO
        smtp111.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgAaQ4n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jan 2020 11:56:43 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2020 11:56:42 EST
X-Auth-ID: nick.burkitt@nanotok.com
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: nick.burkitt-AT-nanotok.com) with ESMTPSA id C4D77E0387;
        Fri, 31 Jan 2020 11:46:40 -0500 (EST)
X-Sender-Id: nick.burkitt@nanotok.com
Received: from [192.168.0.5] (108-88-90-111.lightspeed.sntcca.sbcglobal.net [108.88.90.111])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 31 Jan 2020 11:46:41 -0500
From:   "Nick Burkitt" <nick.burkitt@nanotok.com>
To:     "Lars-Peter Clausen" <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re[2]: IIO driver module doesn't load automatically on kernel 4.19
Date:   Fri, 31 Jan 2020 16:46:39 +0000
Message-Id: <em73402834-5869-442b-96c8-3106fbc29dae@nanotok>
In-Reply-To: <7f063be8-d81a-19f6-6357-079c0a479d54@metafoo.de>
References: <em32a58ce6-ecc9-4a0a-b47d-5d9b79f9bcc1@nanotok>
 <7f063be8-d81a-19f6-6357-079c0a479d54@metafoo.de>
Reply-To: "Nick Burkitt" <nick.burkitt@nanotok.com>
User-Agent: eM_Client/7.2.36908.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lars-Peter.

Many thanks for your help. I think you've identified where the problem 
lies. The behavior I'm seeing from the system on boot-up doesn't seem to 
match that described in the patch, though. Either there have been 
additional changes, or the description is inaccurate. Specifically, the 
author writes, "This patch changes the I2C core to report an OF related 
MODALIAS uevent if  the device was registered via OF," but it appears 
that an OF MODALIAS event will be reported even if the driver did *not* 
register via OF. Adding an of_device_id table to the i2c_driver struct 
seems to cure the problem.
At any rate, it's definitely not an IIO-related issue. I also found the 
same problem with the w1/masters/ds2482 driver. I suspect there are more 
in-tree drivers that have been broken by this change.
Vielen Dank,

-Nick

------ Original Message ------
From: "Lars-Peter Clausen" <lars@metafoo.de>
To: "Nick Burkitt" <nick.burkitt@nanotok.com>; linux-iio@vger.kernel.org
Sent: 1/30/2020 12:44:22 PM
Subject: Re: IIO driver module doesn't load automatically on kernel 4.19

>On 1/29/20 9:25 PM, Nick Burkitt wrote:
>>Hi All.
>>
>>Pardon me if I'm in the wrong place, but I have to start somewhere.
>>I'm using an IIO driver (based on the BNO055 driver proposed by Vlad Dogaru back in 2016).
>>All was well for a couple of years, but after I updated my kernel from 4.14 to 4.19, my driver will no longer load on boot, but is still happy to be loaded manually with modprobe.
>>All other drivers load normally.
>>Has something changed in the way IIO drivers register themselves? Or has some other requirement been added since 4.14 that I have to add to my driver?
>>If not, any suggestions on where to go next would be appreciated.
>>
>>Details:
>>Xilinx Zynq-7000 (ARM Cortex-A9, 2 cores@866 MHz), 1 GB RAM
>>Linux v4.19.0 (via Xilinx)
>>Ubuntu 16.04 and 18.04 (both exhibit the same problem)
>
>Hi,
>
>There shouldn't really be a IIO specific reason why it does not work anymore.
>
>Modules for devices are loaded based on the bus that the device is connected to. For sensors typically the I2C or SPI bus.
>
>I had a quick look at what changed in the I2C core that could have broken this and it could maybe be this commit:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af503716ac1444db61d80cb6d17cfe62929c21df
>
>The commit message warns that the change might break out-of-tree drivers that do not have a OF device table. You can fix the issue by adding such a table.
>
>- Lars

