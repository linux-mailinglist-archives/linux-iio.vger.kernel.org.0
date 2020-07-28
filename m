Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759E2230CD6
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgG1O6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgG1O6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 10:58:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1087C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 07:58:43 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0R3s-0008Kw-CQ; Tue, 28 Jul 2020 16:58:36 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0R3p-0005II-Qu; Tue, 28 Jul 2020 16:58:33 +0200
Date:   Tue, 28 Jul 2020 16:58:33 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Richard Neumann <mail@richard-neumann.de>,
        Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v5 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Message-ID: <20200728145833.xc53dpvwu7deqzjw@pengutronix.de>
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
 <CAHp75VeDAc9pP16wf10xvJn6t34cTXkPAXHus1aSL_07HN3EAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeDAc9pP16wf10xvJn6t34cTXkPAXHus1aSL_07HN3EAA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:53:55 up 256 days,  6:12, 240 users,  load average: 0.19, 0.14,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 20-05-29 17:21, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 4:42 PM Sandeep Singh <Sandeep.Singh@amd.com> wrote:
> >
> > From: Sandeep Singh <sandeep.singh@amd.com>
> >
> > AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
> > is part of MP2 processor (MP2 which is an ARM® Cortex-M4
> > core based co-processor to x86) and it runs on MP2 where
> > in driver resides on X86.The driver functionalities are
> > divided  into three parts:-
> >
> > 1: amd-mp2-pcie:-       This module will communicate with MP2 FW and
> >                         provide that data into DRAM.
> > 2: Client driver :-     This part for driver will use dram data and
> >                         convert that data into HID format based on
> >                         HID reports.
> > 3: Transport driver :-  This part of driver will communicate with
> >                         HID core. Communication between devices and
> >                         HID core is mostly done via HID reports
> >
> > In terms of architecture it is much more reassembles like
> > ISH(Intel Integrated Sensor Hub). However the major difference
> > is all the hid reports are generated as part of kernel driver.
> > AMD SFH driver taken reference from ISH in terms of
> > design and functionalities at fewer location.
> >
> > AMD sensor fusion Hub is part of a SOC 17h family based platforms.
> > The solution is working well on several OEM products.
> > AMD SFH uses HID over PCIe bus.
> >
> 
> I can't believe this is fifth version.
> Guys, you have to do much more work on these drivers.

Is there any active development addressing Andy's comments? Else can we
support you to bring these patches mainline?

Regards,
  Marco
