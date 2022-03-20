Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E158D4E1C45
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbiCTP2d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiCTP2c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 11:28:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBF6A9960;
        Sun, 20 Mar 2022 08:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE0C5B80DC3;
        Sun, 20 Mar 2022 15:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5052C340EE;
        Sun, 20 Mar 2022 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647790026;
        bh=5H1gxkakWBmBtJqH2SJyAEEPgBoD0f9vFvJORCGszAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=unMG510N2lpk2tVs+CdlTgRSe80ah6BK4gp6wX+/j4H+OaP4M0KCWD8vOTDDBQGMN
         8xcO+lnorn7tZjyECMZs70kwtR0OELxIbQoYT3YWSJXHCcnrPALe6TUT4fq/aRMjyJ
         vm3D3ob+QiqSr5P7en6k7PNb8ZMqaJEktPUjnT+CiUadS1jpTeLMa/uylHak/NBhmF
         EjgTekVLi4ZwUCyLsu9lrj2bhr9ewSbJ+tNU7CTQ0dXEDHHE4gIz905PkqcS1KIWMV
         kzb6kd/6cFbnfRBXNEDMojLA8mlyypCuWcRt+G7LfXkXzucvMc0bywryZQbYCmGQP/
         3Pq/EpZt/cMdg==
Date:   Sun, 20 Mar 2022 15:34:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        maemo-leste@lists.dyne.org
Subject: Re: [PATCH v3 0/3] Support LIS302DL in st_accel
Message-ID: <20220320153428.0e1a8695@jic23-huawei>
In-Reply-To: <YiYPiStW3ELlfEUr@smile.fi.intel.com>
References: <20220307132502.73854-1-absicsz@gmail.com>
        <YiYPiStW3ELlfEUr@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Mar 2022 15:58:33 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Mar 07, 2022 at 03:24:59PM +0200, Sicelo A. Mhlongo wrote:
> > Hi,
> > 
> > The ST Microelectronics LIS302DL is currently only supported in the
> > evdev framework driver in drivers/misc/lis3lv02d. This series enables
> > support for it in the iio framework.  
> 
> The entire series is fine to me
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
This crossed with another series adding the sc7a20 so I hand tweaked
it whilst applying.

Applied to the togreg branch of iio.git but I'll be rebasing that on
rc1 once available so in meantime just pushed out as testing.

Thanks,

Jonathan

> 
> > Regards,
> > Sicelo
> > 
> > 
> > 
> > Sicelo A. Mhlongo (3):
> >   dt-bindings: iio: st,st-sensors add LIS302DL
> >   iio: accel: Remove unused enum in st_accel
> >   iio: accel: add support for LIS302DL variant
> > 
> >  .../bindings/iio/st,st-sensors.yaml           |  1 +
> >  drivers/iio/accel/st_accel.h                  | 26 +------------------
> >  drivers/iio/accel/st_accel_core.c             |  1 +
> >  drivers/iio/accel/st_accel_i2c.c              |  5 ++++
> >  drivers/iio/accel/st_accel_spi.c              |  5 ++++
> >  5 files changed, 13 insertions(+), 25 deletions(-)
> > 
> > -- 
> > 2.35.1
> >   
> 

