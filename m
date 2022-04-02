Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79E94F04D7
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbiDBQ0m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiDBQ0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 12:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D67158D97
        for <linux-iio@vger.kernel.org>; Sat,  2 Apr 2022 09:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0160560B01
        for <linux-iio@vger.kernel.org>; Sat,  2 Apr 2022 16:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009EAC340F3;
        Sat,  2 Apr 2022 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648916689;
        bh=NWcA15qpX8CuDA6YW5Vak+d/ThM6esGgpMW7rxPUaRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z93WQZj+65+6FxucK9nYK051ji/sb2x3GI4oo0Q7QcZZK+hT9v2eNBrapsyXTodYH
         9+zRKbjylhrVN0d/NABsWiKCM9wVzlmFmexfhYKI78n1pbtCMYEMgU9q6HY0ixFLbd
         EEKLfJLgT4JNi46lvs9UCNDeMdg375EjceR2gpufWQtY4F9QWRFb/wI3ZaPSzJ1t/u
         fiBMKPG5X10MCzRUrChHrk9oiniT8SNhln00Ls1J42dZtEKflkqEAfvvB0pCAZjw6f
         fKw9Qi3wGMz/BGyFQYAWgm7a0+0jXY7D2vVZMEz6C43CnRzDxSIInZc3/fGu94E0mJ
         MTHx4mUpFq/TQ==
Date:   Sat, 2 Apr 2022 17:32:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3] iio: core: Print error in case sample bits do not
 fit storage bits
Message-ID: <20220402173231.492a8c3a@jic23-huawei>
In-Reply-To: <YkRunZ15S5noNYbJ@smile.fi.intel.com>
References: <20220328195307.154422-1-marex@denx.de>
        <YkRunZ15S5noNYbJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Mar 2022 17:52:13 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 28, 2022 at 09:53:07PM +0200, Marek Vasut wrote:
> > Add runtime check to verify whether storagebits are at least as big
> > as shifted realbits. This should help spot broken drivers which may
> > set realbits + shift above storagebits.  
> 
> Let's go with it.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
Agreed.  Applied with a slight change to the title to make it clear
we don't just print the error, we also fail the iio_device_register() call

Applied to the togreg branch of iio.git and pushed out as testing both to let
0-day poke at it and because I will rebase on rc1 once available.

Thanks,

Jonathan

> 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > V2: Use dev_err() instead as WARN_ON() may panic() the kernel on existing machines
> > V3: Abort probe and return -EINVAL in case this condition is triggered
> > ---
> >  drivers/iio/industrialio-buffer.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index b078eb2f3c9de..75a1c57b49102 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1629,6 +1629,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >  			if (channels[i].scan_index < 0)
> >  				continue;
> >  
> > +			/* Verify that sample bits fit into storage */
> > +			if (channels[i].scan_type.storagebits <
> > +			    channels[i].scan_type.realbits +
> > +			    channels[i].scan_type.shift) {
> > +				dev_err(&indio_dev->dev,
> > +					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
> > +					i, channels[i].scan_type.storagebits,
> > +					channels[i].scan_type.realbits,
> > +					channels[i].scan_type.shift);
> > +				ret = -EINVAL;
> > +				goto error_cleanup_dynamic;
> > +			}
> > +
> >  			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
> >  							 &channels[i]);
> >  			if (ret < 0)
> > -- 
> > 2.35.1
> >   
> 

