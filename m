Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4756014E42F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2020 21:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgA3UoZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jan 2020 15:44:25 -0500
Received: from www381.your-server.de ([78.46.137.84]:43770 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3UoZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2020 15:44:25 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1ixGfm-0006in-Vz; Thu, 30 Jan 2020 21:44:23 +0100
Received: from [93.104.117.216] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ixGfm-000W7N-Po; Thu, 30 Jan 2020 21:44:22 +0100
Subject: Re: IIO driver module doesn't load automatically on kernel 4.19
To:     Nick Burkitt <nick.burkitt@nanotok.com>, linux-iio@vger.kernel.org
References: <em32a58ce6-ecc9-4a0a-b47d-5d9b79f9bcc1@nanotok>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7f063be8-d81a-19f6-6357-079c0a479d54@metafoo.de>
Date:   Thu, 30 Jan 2020 21:44:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <em32a58ce6-ecc9-4a0a-b47d-5d9b79f9bcc1@nanotok>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25711/Thu Jan 30 12:38:44 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/29/20 9:25 PM, Nick Burkitt wrote:
> Hi All.
> 
> Pardon me if I'm in the wrong place, but I have to start somewhere.
> I'm using an IIO driver (based on the BNO055 driver proposed by Vlad 
> Dogaru back in 2016).
> All was well for a couple of years, but after I updated my kernel from 
> 4.14 to 4.19, my driver will no longer load on boot, but is still happy 
> to be loaded manually with modprobe.
> All other drivers load normally.
> Has something changed in the way IIO drivers register themselves? Or has 
> some other requirement been added since 4.14 that I have to add to my 
> driver?
> If not, any suggestions on where to go next would be appreciated.
> 
> Details:
> Xilinx Zynq-7000 (ARM Cortex-A9, 2 cores@866 MHz), 1 GB RAM
> Linux v4.19.0 (via Xilinx)
> Ubuntu 16.04 and 18.04 (both exhibit the same problem)

Hi,

There shouldn't really be a IIO specific reason why it does not work 
anymore.

Modules for devices are loaded based on the bus that the device is 
connected to. For sensors typically the I2C or SPI bus.

I had a quick look at what changed in the I2C core that could have 
broken this and it could maybe be this commit:
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af503716ac1444db61d80cb6d17cfe62929c21df

The commit message warns that the change might break out-of-tree drivers 
that do not have a OF device table. You can fix the issue by adding such 
a table.

- Lars
