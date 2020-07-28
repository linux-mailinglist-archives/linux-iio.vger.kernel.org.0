Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65982230D8E
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgG1PUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgG1PUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:20:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D4C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:20:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0ROd-0002aa-DL; Tue, 28 Jul 2020 17:20:03 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0ROc-0006NV-Bb; Tue, 28 Jul 2020 17:20:02 +0200
Date:   Tue, 28 Jul 2020 17:20:02 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Richard Neumann <mail@richard-neumann.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
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
Subject: Re: [PATCH v5 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Message-ID: <20200728152002.pscc6a34cfelzvsu@pengutronix.de>
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
 <CAHp75VeDAc9pP16wf10xvJn6t34cTXkPAXHus1aSL_07HN3EAA@mail.gmail.com>
 <20200728145833.xc53dpvwu7deqzjw@pengutronix.de>
 <c8046227481b367a3a1bbd123234279fcde76f87.camel@richard-neumann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8046227481b367a3a1bbd123234279fcde76f87.camel@richard-neumann.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:15:30 up 256 days,  6:34, 241 users,  load average: 0.09, 0.06,
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

Hi Richard,

On 20-07-28 17:05, Richard Neumann wrote:
> Hi,
> 
> Am Dienstag, den 28.07.2020, 16:58 +0200 schrieb Marco Felsch:
> > Hi,
> > 
> > On 20-05-29 17:21, Andy Shevchenko wrote:
> > > On Fri, May 29, 2020 at 4:42 PM Sandeep Singh <
> > > Sandeep.Singh@amd.com> wrote:
> > > > From: Sandeep Singh <sandeep.singh@amd.com>
> > > > 

...

> > > I can't believe this is fifth version.
> > > Guys, you have to do much more work on these drivers.
> > 
> > Is there any active development addressing Andy's comments? Else can
> > we
> > support you to bring these patches mainline?
> > 
> > Regards,
> >   Marco
> 
> I did some major refactoring¹ on the v4 patch series and am currently
> providing it for Arch Linux as a DKMS package in the AUR².
> A teensy bit of my changes seems to have influenced the v5 version but
> I actually did some major changes, like strictly separating the HID,
> platform and PCI driver parts.
> I did not submit my changes for upstream so far, since I do not want to
> undermine AMD's work on this nor cause competing driver
> implementations.
> 
> Sincerely,
> 
> Richard
> 
> [1] https://github.com/conqp/linux/tree/amd-sfh-hid/drivers/hid/amd-sfh-hid
> [2] https://aur.archlinux.org/packages/amd-sfh-hid-dkms/

Thanks for the links :) We should get this work done to improve user
experience. Let's wait for the AMD developers comments and then we can
discuss the further steps :)

Regards,
  Marco
