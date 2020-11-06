Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376832A9A9C
	for <lists+linux-iio@lfdr.de>; Fri,  6 Nov 2020 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgKFRQy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Nov 2020 12:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFRQy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2020 12:16:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393A1C0613CF
        for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2020 09:16:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <h.assmann@pengutronix.de>)
        id 1kb5M4-0004FQ-MM; Fri, 06 Nov 2020 18:16:52 +0100
Subject: Re: Counter device Interface for reading out input capture
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
References: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
 <f9f26c15-f214-0fa5-3d12-10a5ec3b6202@st.com>
From:   Holger Assmann <h.assmann@pengutronix.de>
Message-ID: <f076d2e7-f4fc-ec66-b4a9-56ce3d4606be@pengutronix.de>
Date:   Fri, 6 Nov 2020 18:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f9f26c15-f214-0fa5-3d12-10a5ec3b6202@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: h.assmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Fabrice,

On Fri, Nov 06, 2020 at 10:11:07 +0100, Fabrice Gasnier wrote:
> May I ask a bit more information regarding your needs here?

We basically want to latch the current counter value into the
respective Capture/Compare Register when a pulse occurs at the
corresponding ICx input.
Our goal is to measure the jitter (and timing offset) between two or
more data lines which are supposed to carry the same signal at the
same time. Every line is thus connected to one of the four channels.

 From my understanding the PWM capture interface already goes into the
right direction, although we obviously require to utilize more than
one channel of the timer (and in return only need one C/C Register
per channel). I will therefore take your hint and have a closer look
at the pwm-stm32.c - thanks!

Regards,
Holger
