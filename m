Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2854D34B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiFOVGn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 17:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiFOVGk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 17:06:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02DD3EAB2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 14:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2ECEB8216F
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 21:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B448C3411A;
        Wed, 15 Jun 2022 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655327196;
        bh=xO0lWfM9eURwMp5gwbcmZbcdP/e7OM6+H+vDzM7kjqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ATzFiJ4RIQQcNAfO5rS5oITeGAZxIom1R0dBHWKWHHYra1zzersIwSv2F2duuee6f
         WoGBNJFOCBYeP/+RHS1QEHeKCv79BzHXT9E9oTGJV6iXT5xjITzdlgfUT2GDdBpJih
         txJXJsrMPalPPGgGSNw0CiPQOx19aKWP9tu9lqNOAr0/T8HpdxFKrUE7eDBAFJSVXS
         fzFFWCkSoODBdbUW2Xr6cQ+Gwz+clhNI+TCSWMndLi7HyeQyaprue/jXSFSE+KY5cl
         w6kF2bxc04pnEK84sNzl4jX9FCEb6BQYbFa1vsGIxaOunuAXsg1vw7fOqPNS5widTu
         wqetNv+QP/o7A==
Date:   Wed, 15 Jun 2022 22:15:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     haibo.chen@nxp.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v2] iio: accel: mma8452: ignore the return value of
 reset operation
Message-ID: <20220615221552.0d8afb3b@jic23-huawei>
In-Reply-To: <8690f687-8f9d-b03f-226f-3a289e718ed5@redhat.com>
References: <1655292718-14287-1-git-send-email-haibo.chen@nxp.com>
        <8690f687-8f9d-b03f-226f-3a289e718ed5@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jun 2022 18:10:47 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 6/15/22 13:31, haibo.chen@nxp.com wrote:
> > From: Haibo Chen <haibo.chen@nxp.com>
> > 
> > On fxls8471, after set the reset bit, the device will reset immediately,
> > will not give ACK. So ignore the return value of this reset operation,
> > let the following code logic to check whether the reset operation works.
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>  
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Looks very much like a fix to me, so fixes tag please.
As it's otherwise good, just sending the tag in reply to this
message will be fine.

Thanks,

Jonathan

> 
> Regards,
> 
> Hans
> 
> 
> 
> > ---
> >  drivers/iio/accel/mma8452.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index e0f0c0abed28..c7d9ca96dbaa 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -1511,10 +1511,14 @@ static int mma8452_reset(struct i2c_client *client)
> >  	int i;
> >  	int ret;
> >  
> > -	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
> > +	/*
> > +	 * Find on fxls8471, after config reset bit, it reset immediately,
> > +	 * and will not give ACK, so here do not check the return value.
> > +	 * The following code will read the reset register, and check whether
> > +	 * this reset works.
> > +	 */
> > +	i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
> >  					MMA8452_CTRL_REG2_RST);
> > -	if (ret < 0)
> > -		return ret;
> >  
> >  	for (i = 0; i < 10; i++) {
> >  		usleep_range(100, 200);  
> 

