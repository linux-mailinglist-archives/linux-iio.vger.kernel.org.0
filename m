Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF72B5D50
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKQKyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 05:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQKyV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 05:54:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB40DC0613CF
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2020 02:54:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1keyct-00059B-EW; Tue, 17 Nov 2020 11:54:19 +0100
Subject: Re: Counter device Interface for reading out input capture
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Holger Assmann <h.assmann@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org
References: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
 <20201106124217.GA4015@shinobu>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <0fa25b7a-92f9-8eb7-088e-2ef3a2edf2a0@pengutronix.de>
Date:   Tue, 17 Nov 2020 11:54:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106124217.GA4015@shinobu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello William,

On 06.11.20 13:42, William Breathitt Gray wrote:
> On Thu, Nov 05, 2020 at 07:46:14PM +0100, Ahmad Fatoum wrote:
>> It doesn't look like the counter device API is yet made to support such
>> an input capture mode (latching a counter value on an external event, e.g.
>> to timestamp incoming rising edges to measure jitter between pulses).
>
> Regarding the Counter subsystem, I'm developing a Counter character
> device API that supports timestamps for counter devices:
> https://lore.kernel.org/linux-arm-kernel/157d1edf-feec-33b5-7ad5-94f99316ca6e@lechnology.com/T/

Any chance we could have a "raw" timestamp as well like the network
stack offers (cf. SOF_TIMESTAMPING_{RAW,SYS}_HARDWARE)?

The API currently only exposes a ktime (i.e. CLOCK_MONOTONIC), which the
raw timer count can't be readily converted to. For our use case of
measuring jitter, the raw value is sufficient.

> My aim is to get this functionality picked up for the Linux 5.11 merge
> window. I have one more revision at least that should be ready in a
> couple weeks -- I'll CC you for that patchset to keep you in the loop;
> I force-push periodically to my personal repo when as I develop, so you
> can take a look at the current state of this next revision if you're
> curious:
> https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v6

Great. Looking forward to see this merged.

Thanks,
Ahmad

> 
> Sincerely,
> 
> William Breathitt Gray
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
