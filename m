Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC94F1A8852
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503283AbgDNSCq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503187AbgDNSB1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:01:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3922A20767;
        Tue, 14 Apr 2020 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586887287;
        bh=PtAFfHJJmm+j+Kb6LPSRoxHltnduIZpLutVkxDiIp6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PNGC55v0Lk+cz0A6FXEaVrU1+fhb/3ILrbT3nI3yKEMti6V/jdpmJEqkcIzPAVtUW
         pm/J+Q3/0/XbKwkpE9qJ1O0MrF/cz56h3K53dF2MyIKuWxOxyUCAwXHqHcvviyZkzq
         3Xpro0hMvZ+5shzFBI0w52SsOG8ok9SJpGIQZQeE=
Date:   Tue, 14 Apr 2020 19:01:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: patch set ltc2632
Message-ID: <20200414190122.6881a478@archlinux>
In-Reply-To: <20200414062648.19013-1-chris.ruehl@gtsys.com.hk>
References: <20200414062648.19013-1-chris.ruehl@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 14:26:43 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> Patchset to extend ltc2632 spi driver to support the similar chip set
> ltc2634.
> * Patch v2 1/3 update documentation struct ltc2632_chip_info
> * Patch v2 2/3 patch ltc2632.c,Kconfig,ltc2632.txt(devtree)
> * Patch v2 3/3 convert ltc2632.txt to yaml format named lltc,ltc2632.yaml
Hi Chris,

Still something going on with your git send-email.  Are you sending these one
by one perhaps?  Or maybe have something odd in your .git/config?

These have turned up as a series of independent messages as the in-reply-to
field isn't set in the patches (which should point to this one).
git-send-email will do that automatically by default if pointed at all the
files in one go.

Thanks,

Jonathan
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
> 

