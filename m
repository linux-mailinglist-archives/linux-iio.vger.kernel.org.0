Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4400D6FA266
	for <lists+linux-iio@lfdr.de>; Mon,  8 May 2023 10:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjEHIhb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 May 2023 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHIhb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2023 04:37:31 -0400
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E7AB100EB
        for <linux-iio@vger.kernel.org>; Mon,  8 May 2023 01:37:23 -0700 (PDT)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 04B0DDF00B2; Mon,  8 May 2023 10:37:19 +0200 (CEST)
Date:   Mon, 8 May 2023 10:37:19 +0200
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: dac: ad5446: Add ID of compatible Texas
        Instruments i2c dac121c*
Message-ID: <20230508083719.GA920@frolo.macqel>
References: <1683450625-28789-1-git-send-email-Philippe.DeMuyter@macq.eu> <20230507144608.15e7aa8e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507144608.15e7aa8e@jic23-huawei>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

On Sun, May 07, 2023 at 02:46:08PM +0100, Jonathan Cameron wrote:
> On Sun,  7 May 2023 11:10:25 +0200
> Philippe De Muyter <Philippe.DeMuyter@macq.eu> wrote:
> 
> > From: Philippe De Muyter <phdm@macqel.be>
> > 
> > The Texas Instruments DAC121C* chips are the I2C counterparts of
> > the DAC121S* SPI chips which are already supported by this ad5446 driver.
> > 
> > Add them to the compatible list.
> 
> Hi Philippe,
> 
> DT binding should be updated and include the fallback to adi,ad5622.
> Does this driver actually have a bindings doc?  If not please add one
> as a precursor patch then add binding for this new part on top.

No, there's no ad5446 to find in Documentation/ :(

I will try to make one.

> 
> > 
> > Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > ---
> >  drivers/iio/dac/ad5446.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> > index aa3130b33456..b95c0ccbb796 100644
> > --- a/drivers/iio/dac/ad5446.c
> > +++ b/drivers/iio/dac/ad5446.c
> > @@ -587,6 +587,7 @@ static const struct i2c_device_id ad5446_i2c_ids[] = {
> >  	{"ad5602", ID_AD5602},
> >  	{"ad5612", ID_AD5612},
> >  	{"ad5622", ID_AD5622},
> > +	{"dac121", ID_AD5622}, /* 'ti,' is dropped by 'of_modalias_node' */
> 
> True, but why is the comment needed?

I will remove it

> Also, for consistency with the spi equivalent it should be dac121c101 or similar
> I think.

Actually the chip I use is a dac121c085, and there exists also dac121c081.
They share the same datasheet.  The difference is only in the number of
i2c addresses the hardware designer may choose from and the pin used for the
external Vref.

Do you prefer I add only dac121c085, both dac121c085 and dac121c081, or
stick to the common part of the name, with or without the 'c' that stands
for i2C, like the 's' in dac121s101 stands for Spi ?

The documentation also mentions lower-resolution chips in the same family :
dac101c081 and dac101c085 (10 bit resolution), and dac081c081 and dac081c085
(8 bit resolution).

> 
> I think this use of the driver with multiple vendor prefixes,
> also indicates we should really add the of_device_id table for this
> driver. To do that nicely will require more changes as we'd want to do
> the same for the SPI side which has a single entry table (which is odd)
> then deal with the data fields which should probably all be pointers
> rather than enum values.
> 
> Still I'm fine with proper explicit DT support being left for a follow up patch.
> 
> I do want the missing binding doc fixed though (which is independent of the
> question of how the driver binds based on the compatible values).
> 
> Thanks,
> 
> Jonathan
> 
> 
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);

Best regards

Philippe
