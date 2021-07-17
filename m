Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857C3CC4B0
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhGQRIj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 13:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhGQRIj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:08:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B023661158;
        Sat, 17 Jul 2021 17:05:39 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:08:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, lars@metafoo.de,
        sre@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 0/2] mfd: rn5t618: Extend ADC support
Message-ID: <20210717180802.7261d8bb@jic23-huawei>
In-Reply-To: <YO1Ob18YsDdEMfuf@google.com>
References: <20210712212111.18896-1-andreas@kemnade.info>
        <YO1Ob18YsDdEMfuf@google.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Jul 2021 09:27:27 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Mon, 12 Jul 2021, Andreas Kemnade wrote:
> 
> > Add iio map to make voltage_now related channels accessible to power
> > driver.
> > 
> > Changes in v3:
> > - use scale functions
> > - add acks
> > 
> > Changes in v2:
> > - use iio_map instead of devicetree to allow mapping which does not
> >   block future extension by devicetree.
> > 
> > 
> > *** BLURB HERE ***  
> 
> Doh!
> 
> > Andreas Kemnade (2):
> >   iio: adc: rn5t618: Add iio map
> >   power: supply: rn5t618: Add voltage_now property
> > 
> >  drivers/iio/adc/rn5t618-adc.c        | 23 +++++++++++++++++
> >  drivers/power/supply/Kconfig         |  2 ++
> >  drivers/power/supply/rn5t618_power.c | 38 ++++++++++++++++++++++++++++
> >  3 files changed, 63 insertions(+)  
> 
> Not sure I get this.
> 
> Firstly, the cover-letter is marked as MFD, but no MFD changes occur.

So this is a bit of a fun corner case.  The series 'used' to include an mfd
change that made that labelling relevant.  Then that went away as I suggested
that we could do it in a simpler fashion.
Under the circumstances the series needed a rename!

> Secondly, I am only in receipt of the 0th patch which seems odd.  IMHO
> patch sets should be sent threaded and all parties should see
> discussion on all patches regardless of whether they maintain them or
> not, since the overall conversation is often useful/relevant to all.
> 
Absolutely agree for small series like this.

Anyhow, as far as I'm concerned this is now in the hands of the power supply
maintainers anyway so ignoring it ;)

Jonathan
