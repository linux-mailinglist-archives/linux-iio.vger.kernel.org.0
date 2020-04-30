Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D61C079B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgD3UNv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 16:13:51 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39037 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgD3UNu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 16:13:50 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9F8B7FF80A;
        Thu, 30 Apr 2020 20:13:45 +0000 (UTC)
Date:   Thu, 30 Apr 2020 22:13:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, felipe.balbi@linux.intel.com,
        fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH 0/4] Introduce the Counter character device interface
Message-ID: <20200430201345.GX51277@piout.net>
References: <cover.1588176662.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588176662.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 29/04/2020 14:11:34-0400, William Breathitt Gray wrote:
> Over the past couple years we have noticed some shortcomings with the
> Counter sysfs interface. Although useful in the majority of situations,
> there are certain use-cases where interacting through sysfs attributes
> can become cumbersome and inefficient. A desire to support more advanced
> functionality such as timestamps, multi-axis positioning tables, and
> other such latency-sensitive applications, has motivated a reevaluation
> of the Counter subsystem. I believe a character device interface will be
> helpful for this more niche area of counter device use.
> 
> To quell any concerns from the offset: this patchset makes no changes to
> the existing Counter sysfs userspace interface -- existing userspace
> applications will continue to work with no modifications necessary. I
> request that driver maintainers please test their applications to verify
> that this is true, and report any discrepancies if they arise.
> 

On that topic, I'm wondering why the counter subsystem uses /sys/bus
instead of /sys/class that would be more natural for a class of devices.
I can't see how counters would be considered busses. I think you should
consider moving it over to /sys/class (even if deprecating
/sys/bus/counter will be long).

> Interaction with Counter character devices occurs via ioctl commands.
> This allows userspace applications to access and set counter data using
> native C datatypes rather than working through string translations.
> 

I agree with David that you should consider using read to retrieve the
counter data as this will simplify interrupt handling/polling and
blocking/non-blocking reads can be used by an application. ABI wise,
this can also be a good move as you could always consider having an
ioctl requesting a specific format when reading the device so you are
not stuck with the initial format you are going to choose.

> 2. Should device driver callbacks return int or long? I sometimes see
>    error values returned as long (e.g. PTR_ERR(), the file_operations
>    structure's ioctl callbacks, etc.); when is it necessary to return
>    long as opposed to int?
> 

You should use a long if you ever have to return a point as it is
guaranteed to have the correct size. Else, just stick to an int if you
are not going to overflow it.

> 3. I only implemented the unlocked_ioctl callback. Should I implement a
>    compat_ioctl callback as well?
> 

The compat_ioctl is to handle 32bit userspace running on a 64bit kernel.
If your structures have the same size in both cases, then you don't have
to implement compat_ioctl.

Have a look at Documentation/driver-api/ioctl.rst


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
