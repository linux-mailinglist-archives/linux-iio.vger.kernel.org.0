Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16947320ADB
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBUOD7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 09:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUOD7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 09:03:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E86E64EE0;
        Sun, 21 Feb 2021 14:03:15 +0000 (UTC)
Date:   Sun, 21 Feb 2021 14:03:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 10/22] counter: Standardize to ERANGE for limit
 exceeded errors
Message-ID: <20210221140312.299b0e5a@archlinux>
In-Reply-To: <YCsfXGzfEgRAD9p9@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <7fa80c10fcd10d1d47d1bddced2b2cca3ff59ba9.1613131238.git.vilhelm.gray@gmail.com>
        <20210214171021.41b3e4e3@archlinux>
        <YCsfXGzfEgRAD9p9@shinobu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Feb 2021 10:26:52 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Feb 14, 2021 at 05:10:21PM +0000, Jonathan Cameron wrote:
> > On Fri, 12 Feb 2021 21:13:34 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > ERANGE is a semantically better error code to return when an argument
> > > value falls outside the supported limit range of a device.  
> > 
> > #define	ERANGE		34	/* Math result not representable */
> > 
> > Not generally applicable to a parameter being out of range
> > despite the name.
> > #define	EINVAL		22	/* Invalid argument */
> > Is probably closer to what we want to describe here.
> > 
> > Jonathan  
> 
> The comment for ERANGE in error-base.h may be terse to a fault. I
> believe there's a connotation here provided by ERANGE that is absent
> from EINVAL: primarily that the device buffer is incapable of supporting
> the desired value (i.e. there is a hardware limitation).
> 
> This is why strtoul() returns ERANGE if the correct value is outside the
> range of representable values: the result of the operation is valid in
> theory (it would be an unsigned integer), but it cannot be returned to
> the user due to a limitation of the hardware to support that value (e.g.
> 32-bit registers) [1].
> 
> The changes in this patch follow the same logic: these are arguments
> that are valid in theory (e.g. they are unsigned integers), but the
> underlying devices are incapable of processing such a value (e.g. the
> 104-QUAD-8 can only handle 24-bit values).
> 
> [1] https://stackoverflow.com/a/34981398/1806289

Its a bit of a stretch, but I can't claim to feel that strongly about
this.

Jonathan

> 
> William Breathitt Gray

