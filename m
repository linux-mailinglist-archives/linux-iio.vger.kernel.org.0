Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE93A14D1F4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 21:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgA2Ubq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 29 Jan 2020 15:31:46 -0500
Received: from smtp77.ord1c.emailsrvr.com ([108.166.43.77]:34230 "EHLO
        smtp77.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgA2Ubp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2020 15:31:45 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 15:31:45 EST
X-Auth-ID: nick.burkitt@nanotok.com
Received: by smtp10.relay.ord1c.emailsrvr.com (Authenticated sender: nick.burkitt-AT-nanotok.com) with ESMTPSA id A643640261
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2020 15:25:30 -0500 (EST)
X-Sender-Id: nick.burkitt@nanotok.com
Received: from [192.168.0.5] (108-88-90-111.lightspeed.sntcca.sbcglobal.net [108.88.90.111])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 29 Jan 2020 15:25:30 -0500
From:   "Nick Burkitt" <nick.burkitt@nanotok.com>
To:     linux-iio@vger.kernel.org
Subject: IIO driver module doesn't load automatically on kernel 4.19
Date:   Wed, 29 Jan 2020 20:25:28 +0000
Message-Id: <em32a58ce6-ecc9-4a0a-b47d-5d9b79f9bcc1@nanotok>
Reply-To: "Nick Burkitt" <nick.burkitt@nanotok.com>
User-Agent: eM_Client/7.2.36908.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All.

Pardon me if I'm in the wrong place, but I have to start somewhere.
I'm using an IIO driver (based on the BNO055 driver proposed by Vlad 
Dogaru back in 2016).
All was well for a couple of years, but after I updated my kernel from 
4.14 to 4.19, my driver will no longer load on boot, but is still happy 
to be loaded manually with modprobe.
All other drivers load normally.
Has something changed in the way IIO drivers register themselves? Or has 
some other requirement been added since 4.14 that I have to add to my 
driver?
If not, any suggestions on where to go next would be appreciated.

Details:
Xilinx Zynq-7000 (ARM Cortex-A9, 2 cores@866 MHz), 1 GB RAM
Linux v4.19.0 (via Xilinx)
Ubuntu 16.04 and 18.04 (both exhibit the same problem)

Thanks,

-Nick

