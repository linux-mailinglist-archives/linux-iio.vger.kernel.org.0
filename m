Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A91984EC
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgC3TxB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 15:53:01 -0400
Received: from mail.computer-surgery.co.uk ([82.69.253.61]:44021 "EHLO
        nicole.computer-surgery.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728393AbgC3TxA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 15:53:00 -0400
X-Greylist: delayed 2686 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 15:53:00 EDT
Received: from [10.94.89.11] (helo=kilburn)
        by nicole.computer-surgery.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <rgammans@gammascience.co.uk>)
        id 1jIzlc-000433-3Z; Mon, 30 Mar 2020 20:08:12 +0100
Message-ID: <fb289e488d777bd4e56befa6e8791de84a830557.camel@gammascience.co.uk>
Subject: Re: [PATCH v4 4/4] SFH: Create HID report to Enable support of AMD
 sensor fusion Hub (SFH)
From:   Roger Gammans <rgammans@gammascience.co.uk>
To:     "Singh, Sandeep" <ssingh1@amd.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Date:   Mon, 30 Mar 2020 20:07:51 +0100
In-Reply-To: <b96bb88c-dd1a-97d3-21fa-2cc60a4d6a60@amd.com>
References: <20200329184006.GA8199@kilburn.gammascience.co.uk>
         <b96bb88c-dd1a-97d3-21fa-2cc60a4d6a60@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-03-30 at 09:53 +0530, Singh, Sandeep wrote:
> Hi Roger,
> 
> On 3/30/2020 12:10 AM, Roger Gammans wrote:
> > [CAUTION: External Email]
> > 
> > Also I don't seem to be getting any data through
> > to monitor-sensor in user space when I do install it, but I am
> > gettting logs of log messages similar to this:
> > 
> >   pcie_mp2_amd 0000:04:00.7: AMD-Vi: Event logged [IO_PAGE_FAULT
> > domain=0x000c address=0x5267f000 flags=0x0020]
> >   pcie_mp2_amd 0000:04:00.7: AMD-Vi: Event logged [IO_PAGE_FAULT
> > domain=0x000c address=0x5267f000 flags=0x0020]
> > 
> > This is compiled against the debian 5.4.0 kernel, on a
> >       HP ENVY x360 Convertible 15-ds0xxx, SKU 6TD07EA#ABU
> > 
> > I can run other tests or try other kernels if you think it might
> > help,
> > let me know what you need.
> Can you disable IOMMU from bios and give a try or if your laptop
> does 
> not have iommu option you can pass boot parameter "iommu=soft"

I couldn't find anything useful in the BIOS, so tried iommu=soft on the
kernel command line. And that seems to have done the trick, we get
rotation info all the way through to the userspace, and the desktop 
does it auto-rotate magic. Thanks for all your hard work.

On module inserion I have these messages if it is of any concern:-

pcie_mp2_amd 0000:04:00.7: MP2 device found [1022:15e4] (rev 0)
hid-generic 0020:03FE:0001.0003: hidraw2: <UNKNOWN> HID v0.01 Device [hid-amdtp 03FE:0001] on 
hid-generic 0020:03FE:0001.0004: hidraw3: <UNKNOWN> HID v0.01 Device [hid-amdtp 03FE:0001] on 
hid-generic 0020:03FE:0001.0005: hidraw4: <UNKNOWN> HID v0.01 Device [hid-amdtp 03FE:0001] on 

-- 
Roger Gammans <rgammans@gammascience.co.uk>

