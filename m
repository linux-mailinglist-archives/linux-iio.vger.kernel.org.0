Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9319230CFB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgG1PFh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:05:37 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgG1PFg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:05:36 -0400
Received: from ThinkCentre ([81.14.225.83]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybbH-1kzNwi3tL3-00z1gU; Tue, 28 Jul 2020 17:05:22 +0200
Message-ID: <c8046227481b367a3a1bbd123234279fcde76f87.camel@richard-neumann.de>
Subject: Re: [PATCH v5 0/4] SFH: Add Support for AMD Sensor Fusion Hub
From:   Richard Neumann <mail@richard-neumann.de>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Shyam-sundar.S-k@amd.com
Date:   Tue, 28 Jul 2020 17:05:20 +0200
In-Reply-To: <20200728145833.xc53dpvwu7deqzjw@pengutronix.de>
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
         <CAHp75VeDAc9pP16wf10xvJn6t34cTXkPAXHus1aSL_07HN3EAA@mail.gmail.com>
         <20200728145833.xc53dpvwu7deqzjw@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NXpkszrA9og9+kV2+FrWLRxHSACXOXAN44gfv0kU+p4LQT/Io5H
 2/Hw0JiTYCJFf3aSLCjG8hma09jM0U9LheVGLa33OiBj+wiYNarF6DAVX2hvMnlFi8B4qly
 GJDxcUvHJfpkPtRSa/KQrIiL7r+twhOjA73G4P+cZswHkMwv4rYuiTtwqgJsC/2ftbQp9HC
 YWyWuePQq6jBfsIFT6WeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FUtYt8PjYvQ=:/YEAIYjBV3wjZmEkEK7s6z
 f1KSafvjIzWum6u2HgtKN8axM3B7EiFgTYc7K2ESamx5lFzWLPXkt2jNc9OjtXd9pkbUVUppT
 965u54QtxFRa2vecyyrAFYA8qnuA6OsGO533cTSWheISZthn4wAOcIeh6hRs1vS/pZl/ACRQX
 +psug9I+XGFz9j7k6is64UrGHXeA000SyK1frmA+6BdDg+on8Ksga2pPMpf8BWOIPHnutELpK
 ojjhxiY3CLGp79ZJ0JcPbXjyHyTi9qz7baVqO5fy24cD6qY1rQpx8poa/hGqATpfK5SrPKBS3
 vkSkk61h1gBaEFMOLbGYL3PKG6Q61Az+eZuNdocyHGId/DJV7spr2BR8FSuXKzeFuEnUKejUW
 0NOXH0Zwg7KN5rixF843/N/BIRCdx/UFQPfw7ELmWMDd3twidzAKSD0NmSf/ihBVW4EoAKVXB
 GPGJ1c4Qp03Qf4glC91YL5QMVEBdrMWv0LnhdPK5Gbc1Mp7anRQKoWZ13Ow4DrpbLr49kBfDJ
 hpa4103NAZpA1lxsDRC0cn9p4UNrDtAB/8ShRiZFFqCK91z+MZXvjvhfQmQ/neNcW0AXA/9mE
 EuUu3gjIpk3zqoW7HbRO49H8CRN0lWvjiEbMmoQPJ8pL4sd2UGbgWQHjIr0HVfxN/nyiWJI2s
 ebAB2bpTsf+3TaxjdGL6C4Z/Gir9BjtREJ12+WknhvaJu+wWtjpFwASvV32AvW8+jxEZJkO53
 4k0ZEvyL9OGcpqKiagTPvQZcn76WgNGseSpassRETSQylTpBESSSofY4dSsHJK2BUgc2RMIuF
 gB2YIJnPok/ma5DoBtjSvV5CUJa1hiMScVqzuBniCN4F9wQhwS7vPulj5qLU9FaYs3/cTZY
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Am Dienstag, den 28.07.2020, 16:58 +0200 schrieb Marco Felsch:
> Hi,
> 
> On 20-05-29 17:21, Andy Shevchenko wrote:
> > On Fri, May 29, 2020 at 4:42 PM Sandeep Singh <
> > Sandeep.Singh@amd.com> wrote:
> > > From: Sandeep Singh <sandeep.singh@amd.com>
> > > 
> > > AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
> > > is part of MP2 processor (MP2 which is an ARM® Cortex-M4
> > > core based co-processor to x86) and it runs on MP2 where
> > > in driver resides on X86.The driver functionalities are
> > > divided  into three parts:-
> > > 
> > > 1: amd-mp2-pcie:-       This module will communicate with MP2 FW
> > > and
> > >                         provide that data into DRAM.
> > > 2: Client driver :-     This part for driver will use dram data
> > > and
> > >                         convert that data into HID format based
> > > on
> > >                         HID reports.
> > > 3: Transport driver :-  This part of driver will communicate with
> > >                         HID core. Communication between devices
> > > and
> > >                         HID core is mostly done via HID reports
> > > 
> > > In terms of architecture it is much more reassembles like
> > > ISH(Intel Integrated Sensor Hub). However the major difference
> > > is all the hid reports are generated as part of kernel driver.
> > > AMD SFH driver taken reference from ISH in terms of
> > > design and functionalities at fewer location.
> > > 
> > > AMD sensor fusion Hub is part of a SOC 17h family based
> > > platforms.
> > > The solution is working well on several OEM products.
> > > AMD SFH uses HID over PCIe bus.
> > > 
> > 
> > I can't believe this is fifth version.
> > Guys, you have to do much more work on these drivers.
> 
> Is there any active development addressing Andy's comments? Else can
> we
> support you to bring these patches mainline?
> 
> Regards,
>   Marco

I did some major refactoring¹ on the v4 patch series and am currently
providing it for Arch Linux as a DKMS package in the AUR².
A teensy bit of my changes seems to have influenced the v5 version but
I actually did some major changes, like strictly separating the HID,
platform and PCI driver parts.
I did not submit my changes for upstream so far, since I do not want to
undermine AMD's work on this nor cause competing driver
implementations.

Sincerely,

Richard

[1] https://github.com/conqp/linux/tree/amd-sfh-hid/drivers/hid/amd-sfh-hid
[2] https://aur.archlinux.org/packages/amd-sfh-hid-dkms/

