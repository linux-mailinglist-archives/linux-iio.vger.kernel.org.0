Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E074BB8B5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 12:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiBRLxZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 06:53:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiBRLxY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 06:53:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD623D3D1
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 03:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3255561F5A
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 11:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD6CC340E9;
        Fri, 18 Feb 2022 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645185186;
        bh=fc9G1W2F+02XTviIMZxLjKVwSy/dvhYcZG+8dtSPfpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ExeoTXiO/wKINzgVMj/pMw7liTwcH3OMAxaOuAQ9F0nOPXvNbsKzY7AMwOxr2Ka3G
         LhRp2LvFQChLuW0LMTFsaLIjxvnsJbxmq3i1MOFNvFY0fLzIzNc3kzgcUt+6CvdLnt
         g0J/udy+c+mKkbxOQ1b9Ch2MtEAkLAH+8MjDOiOkHWUiUciC6EiBs/h6PuhP9fjeMs
         W2S5l/6h+ABE0dHxcjh4tR02GPJiOcTWmvgY90XRtyCbSqMCuNspLhaHzpx9Kss+jo
         YgqYNS6grE67hGg01WUUr+hmblzPmNsq/AFy+wukL+skjvtwr7yF7pzirvv95oqiGY
         giB+ozAHf5c9g==
Date:   Fri, 18 Feb 2022 11:59:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hennerich@marsc.168.1.7,
        Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 00/20] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <20220218115955.520ef6e4@jic23-huawei>
In-Reply-To: <Ygll3yGIjH7NOFx/@marsc.168.1.7>
References: <20220206190328.333093-1-jic23@kernel.org>
        <Ygll3yGIjH7NOFx/@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Feb 2022 17:11:11 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 02/06, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Changes since v2:
> > All in response to Marcelo Schmitt doing a really detailed review and
> > testing against the QEMU model.
> > 
> > - Moved elements of patch 2 to patch 5 to avoid missing defines.
> > - Patch 6: Amend ordering to avoid updated software cached values until the
> >   hardware write has succeeded.
> > - Patch 12 Fixed wrong callbacks in no_irq case
> > - Patch 14: Changed all numeric properties to u32 to avoid needing to
> >   specify bit depth in dts.
> > - Patch 14: Typo fix.
> > - Patch 15: New Patch to drop the handling of partial aux alert channels as
> >   it is buggy (and always was). Anyone wanting to bring this back will
> >   hopefully have hardware to test as it will be fiddly.
> > - Patch 15 (old number, now 16). Update dt bindings to drop the
> >   adi,temp-alert-last-chan given new patch 15 drops the support.
> > - New Patch 18: Change cb_mask software cache to not include the offset of 2
> >   and instead apply that only when writing the registers.
> > - New Patch 19: More conservative timings to allow 105 degree Centigrade
> >   operation.
> > - Patch 20 is moving the new code so obviously all the above apply to that
> >   as well!  
> 
> I had another look into this set (including the new patches), and it seems all good. :)
> Also, thanks for clarifying my doubts about the driver on the previous thread.
> So,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> for the whole series.
> 
> It will be nice to see another driver getting out of staging. :D

Hi Marcelo,

Thanks for your help with this.

Applied to the togreg branch of iio.git and pushed out as testing to
let 0-day see if it can find anything we missed.

Guess I'll have to figure out which one of the remaining staging drivers
to tackle next in my (very) slow moving project to get them all out...

I actually have hardware for the adt7316 so maybe time to wire that up
though IIRC I could only get SPI to work intermittently due to
my dubious soldering.  Keeping it all in software by using emulation
for this one was nice :)

Jonathan

> 
> Thanks,
> 
> Marcelo
> 
> > 
> > Hi All,
> > 
> > This one proved an interesting diversion.
> > 
> > Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
> > ad7280a devices (18 channels).  Note that the emulation isn't complete
> > but does do chaining, CRC, and readout of channels etc in a fashion that
> > worked with the original driver (up to the bug in patch 1) and continues
> > to work with the updated version. I've not intention to upstream the
> > emulation (as would need to make it more completed and flexible), but
> > happy to share it with anyone who is interested.
> > 
> > I briefly flirted with posting a patch to just drop the driver entirely,
> > but the part is still available and it looked like fun + isn't going
> > to greatly impact maintainability of the subsystem long term so is low
> > cost even if it becomes unavailable sometime soon.
> > 
> > There are lots of things we could do after this set to improved the driver
> > and make things more flexible, but it should basically 'just work'
> > 
> > Anyhow, as normal for staging graduations, last patch has rename detection
> > turned off so that people can easily see what I am proposing we move
> > out of staging.
> > 
> > All comments welcome and thanks to Marcelo for reviewing this beast!
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > 
> > Jonathan Cameron (20):
> >   staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
> >   staging:iio:adc:ad7280a: Register define cleanup.
> >   staging:iio:adc:ad7280a: rename _read() to _read_reg()
> >   staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
> >   staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
> >     transfers.
> >   staging:iio:adc:ad7280a: Switch to standard event control
> >   staging:iio:adc:ad7280a: Standardize extended ABI naming
> >   staging:iio:adc:ad7280a: Drop unused timestamp channel.
> >   staging:iio:adc:ad7280a: Trivial comment formatting cleanup
> >   staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
> >   staging:iio:adc:ad7280a: Cleanup includes
> >   staging:iio:ad7280a: Reflect optionality of irq in ABI
> >   staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
> >   staging:iio:adc:ad7280a: Use device properties to replace platform
> >     data.
> >   staging:iio:adc:ad7280a: Drop buggy support for early termination of
> >     AUX alert.
> >   dt-bindings:iio:adc:ad7280a: Add binding
> >   iio:adc:ad7280a: Document ABI for cell balance switches
> >   staging:iio:adc:ad7280a: Remove shift from cb_mask state cache.
> >   staging:iio:adc:ad7280a: Use more conservative delays to allow 105C
> >     operation.
> >   iio:adc:ad7280a: Move out of staging
> > 
> >  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   13 +
> >  .../bindings/iio/adc/adi,ad7280a.yaml         |   77 ++
> >  drivers/iio/adc/Kconfig                       |   11 +
> >  drivers/iio/adc/Makefile                      |    1 +
> >  drivers/iio/adc/ad7280a.c                     | 1111 +++++++++++++++++
> >  drivers/staging/iio/adc/Kconfig               |   11 -
> >  drivers/staging/iio/adc/Makefile              |    1 -
> >  drivers/staging/iio/adc/ad7280a.c             | 1044 ----------------
> >  drivers/staging/iio/adc/ad7280a.h             |   37 -
> >  9 files changed, 1213 insertions(+), 1093 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> >  create mode 100644 drivers/iio/adc/ad7280a.c
> >  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
> >  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> > 
> > -- 
> > 2.35.1
> >   

