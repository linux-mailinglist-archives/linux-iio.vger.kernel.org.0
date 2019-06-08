Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506A439F60
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfFHMAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 08:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfFHMAg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 08:00:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4723021530;
        Sat,  8 Jun 2019 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559995235;
        bh=E/n4ngGBdThx86aoC0hcq9aOnFIcxwRcrFYMjA4xarA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1pdCK/MfmhuBz1RjHqVxyDYI4trrLf4i/neH/tnr24yrhF/kW9SZYOIcgsPU/8+W
         5X04JGbbL4j72gvoWXy7SqrAjp/3DJeIEmYqsFamVuslBClc24HLveF0B+sJAkxd64
         Hv6+KIHqWgpiU9rm9siXZtIFRcMU4t65lu/7iE9U=
Date:   Sat, 8 Jun 2019 13:00:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: xilinx: support all ARM platforms
Message-ID: <20190608130031.4a695baf@archlinux>
In-Reply-To: <13a8eaf3-b5ee-151b-d959-80fb41e8a7f8@sedsystems.ca>
References: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
        <379a99c8405b4cfbaa61ac49f9b40d4c577eb2a8.camel@analog.com>
        <95be35ff-2e3d-bc00-8798-7c9f462a96a6@sedsystems.ca>
        <a96943b7-00f5-288f-fa27-a82f1d6aa8dd@xilinx.com>
        <CA+U=DsrBqfmqfxS_SaPJHHiet0ZuAsCK5Kdha_rH+Cbm4VRP4A@mail.gmail.com>
        <13a8eaf3-b5ee-151b-d959-80fb41e8a7f8@sedsystems.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 7 Jun 2019 13:32:11 -0600
Robert Hancock <hancock@sedsystems.ca> wrote:

> On 2019-06-07 1:17 p.m., Alexandru Ardelean wrote:
> > On Fri, Jun 7, 2019 at 10:33 AM Michal Simek <michal.simek@xilinx.com> wrote:  
> >>
> >> On 06. 06. 19 17:21, Robert Hancock wrote:  
> >>> On 2019-06-06 4:09 a.m., Ardelean, Alexandru wrote:  
> >>>> On Wed, 2019-06-05 at 15:07 -0600, Robert Hancock wrote:  
> >>>>> [External]
> >>>>>
> >>>>>
> >>>>> Since the XADC logic can be used with standalone Xilinx FPGAs, this driver
> >>>>> can potentially be used with various ARM platforms, not just Zynq.
> >>>>> Change the Zynq dependency to ARM in the list of supported platforms
> >>>>> in the Kconfig dependencies for this driver.  
> >>>>
> >>>> To my knowledge, there are 3 FPGA platforms with ARM supported in Linux.
> >>>> And symbols are ARCH_ZYNQ, ARCH_ZYNQMP & ARCH_SOCFPGA.
> >>>> For these ARM + FPGA SoCs, it is usually preferred to list the supported/tested ARM + FPGA platforms in Kconfig.
> >>>>
> >>>> I am curious: are you using something that isn't in the above list?  
> >>>
> >>> Yes, we are using the XADC on a Kintex-7 FPGA through a PCIe to AXI
> >>> bridge using an iMX6D platform - not an integrated ARM+FPGA.
> >>>  
> > 
> > In that case, it would be a bit more interesting to do a depends on
> > PCIE_XILINX, or whichever is the Kconfig symbol for the PCIe-to-AXI
> > bridge.
> > 
> > And there are some benefits to that, the major being that you can also
> > support other ARCHs as well (x86, ppc, mips, etc).  
> 
> There isn't a kernel driver for that PCIe-AXI bridge - it doesn't really
> do much very interesting on its own, it just acts as a regular PCIe
> endpoint and has build-time settings to map AXI memory to PCIe BARs and
> host memory into AXI memory space. You have to build your own logic to
> do things like map interrupts from the AXI side onto MSI interrupts from
> the bridge.
> 
> It kind of seems like the easiest solution would be to just delete the
> platform restriction entirely for this driver, as I really don't see
> anything platform specific in there. Would anyone object to that?

Sounds good to me.

Jonathan

> 
> > 
> > Naturally, if using a different PCIe-to-AXI bridge controller (other
> > than Xilinx's), it would be an idea to use that Kconfig symbol.
> >   
> >>> Using such an approach this driver could potentially be used on just
> >>> about any platform, but I didn't want to open it up too much for now in
> >>> case of some compile issues.  
> >>
> >> 0day system should answer this for you.
> >>
> >> M  
> 

