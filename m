Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807BF51F00B
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiEHTSr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 15:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244266AbiEHSBI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 14:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF33F558C
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 10:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9D46128E
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 17:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FD7C385AC;
        Sun,  8 May 2022 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032637;
        bh=BNfLR+WqUZnGY4l22wCjlLTf5CQMmtJyMaPQ0Y+T7ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GqHKjJGJfyWNU56zNZPGtX1kV96tfmeRqQw9HsciSSyzP2tFwlus33US3VhrF4Gha
         EgccVISK0NelKaIiCkS0sztJSPY5qQLh/gnJ4mqzpgFG/11iGgQqU2wEgo4AUt/IFB
         FczekvE/O7bnn1DviEz7LdGvdAU2eHDHtKn131SAOZH8vqRKCMamRS1/XszxRwDwuC
         9iBme8xD1IVksrBflJ8yK25YJWFWz2bf7qnE53A5qNZ6q7sh7gR3z5GQ4nlu8oMaj8
         LIlr61aALW8vbH6meSeDFSpLKupVzOby9s2SbxM+ahoGXJNgKOl5dL0PJOBS9lK0ea
         UFiXoPzFNyuGA==
Date:   Sun, 8 May 2022 19:05:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, <bleung@chromium.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] chrome: Remove Custom ABI |location| attribute
Message-ID: <20220508190544.0489994a@jic23-huawei>
In-Reply-To: <20220428093130.000051b2@Huawei.com>
References: <20220427190804.961697-1-gwendal@chromium.org>
        <20220428093130.000051b2@Huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Apr 2022 09:31:30 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 27 Apr 2022 12:08:02 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
> > Instead of using the custom |location| attribute, use the |label| attribute
> > introduced in kernel 5.8.
> > A new location is required for sensors located in a camera subassembly that
> > swivels.
> >   
> 
> I'm assuming this ABI change is fine because you can change the software stack
> as well?
> 
> Is this likely to break anyone relying on the old location attribute?
> 
> Jonathan
> 
Reply was off list for some reason.  Anyhow, upshot is that this is fine
so applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at it.

Thanks,

Jonathan

> > ---
> >  changes in v2:
> >  * Add "accel-camera" define.
> >  * remove |location| attribute completely.
> > 
> > Gwendal Grignou (2):
> >   iio: ABI: Add a new location label
> >   iio: common: cros_ec_sensors: Add label attribute
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio       |  5 ++++
> >  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 30 ++++++-------------
> >  drivers/iio/light/cros_ec_light_prox.c        |  2 --
> >  drivers/iio/pressure/cros_ec_baro.c           |  2 --
> >  .../linux/iio/common/cros_ec_sensors_core.h   |  2 --
> >  6 files changed, 15 insertions(+), 28 deletions(-)
> >   
> 

