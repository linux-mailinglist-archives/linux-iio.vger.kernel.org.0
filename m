Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7FF488A97
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 17:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiAIQdW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 11:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiAIQdW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 11:33:22 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC4C06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 08:33:22 -0800 (PST)
Received: from [81.101.6.87] (port=35374 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6b88-000096-BV; Sun, 09 Jan 2022 16:33:20 +0000
Date:   Sun, 9 Jan 2022 16:39:14 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v10 3/5] iio: proximity: Add SX9324 support
Message-ID: <20220109163903.7c368fb2@jic23-huawei>
In-Reply-To: <CAHp75Ve5OjpdSs3DLvV8PORZMmEz5H+nA=c2Zior-wMTWj0A3w@mail.gmail.com>
References: <20220101203817.290512-1-gwendal@chromium.org>
        <20220101203817.290512-4-gwendal@chromium.org>
        <CAHp75Ve5OjpdSs3DLvV8PORZMmEz5H+nA=c2Zior-wMTWj0A3w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 Jan 2022 14:25:35 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jan 2, 2022 at 6:28 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Semtech SAR sensor SX9324 is an evolution of the SX9310:
> > It has 4 phases that can be configure to capture and process data  
> 
> configured
Fixed up.
> 
> > from any of 3 CS pins and provide independent detection:
> > proximity, table proximity or body proximity.  
> 
> ...
> 
> > +static const struct acpi_device_id sx9324_acpi_match[] = {
> > +       { "STH9324", SX9324_WHOAMI_VALUE },  
> 
> So I believe this one is allocated by SEMTECH. Can you confirm?
> 

This one seemed highly plausible, but indeed good to have it
actually stated that they'd allocated the ID.

> > +       { }
> > +};  
> 
> ...
> 
> > +static const struct i2c_device_id sx9324_id[] = {
> > +       {"sx9324", SX9324_WHOAMI_VALUE },  
> 
> Missed space.
Fixed up.
> 
> > +       { }
> > +};  
> 

Jonathan
