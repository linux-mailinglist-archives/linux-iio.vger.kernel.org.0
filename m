Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47B2A865B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgKESqS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 13:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbgKESqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Nov 2020 13:46:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAAAC0613CF
        for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2020 10:46:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kakH2-0005Op-8u; Thu, 05 Nov 2020 19:46:16 +0100
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Holger Assmann <h.assmann@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Counter device Interface for reading out input capture
Message-ID: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
Date:   Thu, 5 Nov 2020 19:46:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
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

Hello Benjamin,
Hello Fabrice,

In the stm32-timer-cnt driver I find unused #defines for TIM_CCMR_MASK and
TIM_CCER_MASK, which to me hint that support for the "input capture mode"[1]
was implemented but removed prior to upstreaming.

It doesn't look like the counter device API is yet made to support such
an input capture mode (latching a counter value on an external event, e.g.
to timestamp incoming rising edges to measure jitter between pulses).

I am still very new to this, so I figured I ask whether you already have
thoughts (or maybe code to share) on how to best integrate this with the
counter device API.

I've added linux-iio/linux-stm32 to the CC as well, so if someone else
has an idea how to best do this, please share.

[1]: 40.3.7 in RM0436 rev 3

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
