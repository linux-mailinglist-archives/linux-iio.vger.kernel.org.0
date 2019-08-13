Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E808B436
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfHMJeI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 05:34:08 -0400
Received: from tr-host.de ([138.201.124.202]:35300 "EHLO kolab.tr-host.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfHMJeI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 05:34:08 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 05:34:07 EDT
Received: from localhost (localhost [127.0.0.1])
        by kolab.tr-host.de (Postfix) with ESMTP id 236BE365A1C3;
        Tue, 13 Aug 2019 11:25:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at example.com
Received: from kolab.tr-host.de ([127.0.0.1])
        by localhost (kolab.tr-host.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qKh9G4b_aYQI; Tue, 13 Aug 2019 11:25:14 +0200 (CEST)
Received: from kolab.tr-host.de (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pollak@tr-host.de)
        by kolab.tr-host.de (Postfix) with ESMTPSA id BEA93365A149;
        Tue, 13 Aug 2019 11:25:14 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Aug 2019 11:25:14 +0200
From:   "Pollak, Leonard" <pollak@tr-host.de>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Add ADE9000 driver to staging:iio:meter?
User-Agent: Kolab 16/Roundcube 1.4-git
Message-ID: <60e09b1c93eb54a6f8042ece9d34da80@tr-host.de>
X-Sender: pollak@tr-host.de
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I have written a driver for the ADE9000. It has enough functionality to 
calibrate the device
and use it for energy metering. This was tested on a Raspberry Pi 3 
which i also have
a dts for if anyone is interested.

There are some quirks though since the ABI doesn't really make it easy 
on this kind of device.
For example: my driver (ab)uses the iio modifiers x and y to distinguish 
between Wh and VAh.
There are other issues with the driver I can think of (especially the 
channel definitions).
I think if you would want a more complete implementation of this IC as 
an iio device one would
need to start adding modifiers/types to the iio chan spec which would 
probably need a lot
of discussion. Since this is the first driver I have written for the 
linux kernel don't
expect too much, but I am commited to learn and happy to implement any 
suggestions for
making this a nice driver in the future :)

For now, I have forked the kernel tree from GKH made a patch and cleaned 
it up with checkpatch.pl
should I just send the driver as a patch is there anything else I need 
to do beforehand?

Regards,
Leo
