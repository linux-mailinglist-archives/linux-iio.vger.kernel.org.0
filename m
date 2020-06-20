Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84635202562
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jun 2020 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFTQkl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Jun 2020 12:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgFTQkk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jun 2020 12:40:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FCBF208D5;
        Sat, 20 Jun 2020 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592671239;
        bh=lfSzalvbtneZ8u/8cfqsrPZxTlT9H2bEBJMac45J2rA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pAqd9F3Tq6dKNOl+JLqJE94RTQ8RA+y2gHkD6XfvR23ET/VKwBv5V31BLXxbqORxC
         3tEOumxZSSOl3VnVbkNYDhfJNyGl3GxvfxUZUC9fF9dwpynj8udwgyIUwhu5r5dG9y
         FhO9dXAkwG/O4ajHz9/8n5Ex3NYsdsO3I2KSd64c=
Date:   Sat, 20 Jun 2020 17:40:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "songqiang1304521@gmail.com" <songqiang1304521@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Message-ID: <20200620174033.2ffec237@archlinux>
In-Reply-To: <8ae96d9defc521ae3b8ac37ebfc9dd0f5b32cfb3.camel@analog.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
        <20200525113855.178821-3-alexandru.ardelean@analog.com>
        <20200531164020.765822dc@archlinux>
        <a0253d719a4390f65668789e5fc182ec19355f17.camel@analog.com>
        <20200602095406.00005add@Huawei.com>
        <37ef45f4-9330-86ea-77c1-3138bb88601b@microchip.com>
        <0eeae8e8c2c1a3f21e15c1931bacb197a8245104.camel@analog.com>
        <e17fc5b3-fc6b-5980-7294-6d0a151138da@microchip.com>
        <8ae96d9defc521ae3b8ac37ebfc9dd0f5b32cfb3.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jun 2020 13:37:16 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2020-06-18 at 13:01 +0000, Eugen.Hristev@microchip.com wrote:
> > On 17.06.2020 16:52, Ardelean, Alexandru wrote:  
> > > On Wed, 2020-06-17 at 13:37 +0000, Eugen.Hristev@microchip.com wrote:  
> > > > [External]
> > > > 
> > > > On 02.06.2020 11:54, Jonathan Cameron wrote:  
> > > > > On Tue, 2 Jun 2020 07:50:23 +0000
> > > > > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> > > > >   
> > > > > > On Sun, 2020-05-31 at 16:40 +0100, Jonathan Cameron wrote:  
> > > > > > > On Mon, 25 May 2020 14:38:55 +0300
> > > > > > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > > > > > >   
> > > > > > > > From: Lars-Peter Clausen <lars@metafoo.de>
> > > > > > > > 
> > > > > > > > This patch should be squashed into the first one, as the
> > > > > > > > first one is
> > > > > > > > breaking the build (intentionally) to make the IIO core files
> > > > > > > > easier
> > > > > > > > to
> > > > > > > > review.
> > > > > > > > 
> > > > > > > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > > > > > > Signed-off-by: Alexandru Ardelean <  
> > > > > > > > alexandru.ardelean@analog.com>  
> > > > > > > > ---  
> > > > > > > 
> > > > > > > Friend poke.  Version log?  
> > > > > > 
> > > > > > Version log is in the first patch.
> > > > > > I was wondering if I omitted it.
> > > > > > Seems, this time I didn't. But I admit, it probably would have
> > > > > > been better
> > > > > > here.  
> > > > > Ah fair enough.  That works fine if there is a cover letter but not
> > > > > so much just putting things in the first patch!  
> > > > > > > Other than the wistful comment below (which I'm not expecting
> > > > > > > you to
> > > > > > > do anything about btw!) whole series looks good to me.
> > > > > > > 
> > > > > > > These are obviously no functional changes (I think) so it's
> > > > > > > only really
> > > > > > > patch 2 that
> > > > > > > could do with more eyes and acks.
> > > > > > > 
> > > > > > > Far as I can tell that case is fine as well because of the
> > > > > > > protections
> > > > > > > on being in the right mode, but more eyes on that would be
> > > > > > > great.
> > > > > > > 
> > > > > > > So assuming that's fine, what commit message do you want me to
> > > > > > > use for
> > > > > > > the fused single patch?  
> > > > > > 
> > > > > > Commit message-wise: I think the message in the first commit
> > > > > > would be
> > > > > > mostly sufficient.
> > > > > > No idea what other description would be needed.
> > > > > > 
> > > > > > So, maybe something like:
> > > > > > 
> > > > > > ---------------------------------------------------------------
> > > > > > -------
> > > > > > All devices using a triggered buffer need to attach and detach
> > > > > > the trigger
> > > > > > to the device in order to properly work. Instead of doing this in
> > > > > > each and
> > > > > > every driver by hand move this into the core.
> > > > > > 
> > > > > > At this point in time, all drivers should have been resolved to
> > > > > > attach/detach the poll-function in the same order.
> > > > > > 
> > > > > > This patch removes all explicit calls of
> > > > > > iio_triggered_buffer_postenable()
> > > > > > & iio_triggered_buffer_predisable() in all drivers, since the
> > > > > > core handles
> > > > > > now the pollfunc attach/detach.
> > > > > > 
> > > > > > The more peculiar change is for the 'at91-sama5d2_adc' driver,
> > > > > > since it's
> > > > > > not obvious that removing the hooks doesn't break anything**
> > > > > > ---------------------------------------------------------------
> > > > > > -------
> > > > > >   
> > > > > 
> > > > > Looks good.
> > > > >   
> > > > > > ** for the comment about 'at91-sama5d2_adc', we really do need to
> > > > > > get some
> > > > > > testing; otherwise this risks breaking it.  
> > > > 
> > > > Hi,
> > > > 
> > > > I can test it, do we have any patchwork so I can easily download the
> > > > patches ?
> > > > I have issues when applying them.  
> > > 
> > > Is this good?
> > > 
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11568743/__;!!A3Ni8CS0y2Y!sOycjyvbMtVr_UDFBvb0vdcf9ONdhs0VBLhTcuYO4qnuZmazm5342mRE2T-119Sk7-d50A$ 
> > > Series:
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-iio/list/?series=293141__;!!A3Ni8CS0y2Y!sOycjyvbMtVr_UDFBvb0vdcf9ONdhs0VBLhTcuYO4qnuZmazm5342mRE2T-119TNWi1mbQ$ 
> > > 
> > > Many thanks
> > > Alex  
> > 
> > On at91-sama5d2-adc driver, sama5d2-xplained board,
> > Tested-by: Eugen Hristev <eugen.hristev@microchip.com>
> > 
> > I applied all three patches and tested together with the other patch on 
> > sama5d2-adc driver.
> > It looks to be working fine. If I discover something later, I will let 
> > you know.
> > Thanks  
> 
> Also thanks from my side for testing.

Great.  Thanks for testing Eugen!

Applied and flattened into a single patch as discussed previously
using a slightly edited version of your cover letter to reflect
that Eugen was able to test it.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.  Was a bit of fuzz but I don't think
anything significant.

Thanks for all your hard work driving this one through!

Jonathan

> 
> 
> >   
> > > > Thanks !
> > > >   
> > > > > Agreed.
> > > > >   
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > Jonathan
> > > > > > >   
> > > > > > > >    static const struct iio_trigger_ops
> > > > > > > > atlas_interrupt_trigger_ops = {
> > > > > > > > diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> > > > > > > > b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> > > > > > > > index 17606eca42b4..8e13c53d4360 100644
> > > > > > > > --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> > > > > > > > +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> > > > > > > > @@ -99,20 +99,6 @@ static irqreturn_t
> > > > > > > > iio_simple_dummy_trigger_h(int
> > > > > > > > irq, void *p)
> > > > > > > >    }
> > > > > > > > 
> > > > > > > >    static const struct iio_buffer_setup_ops
> > > > > > > > iio_simple_dummy_buffer_setup_ops = {
> > > > > > > > - /*
> > > > > > > > -  * iio_triggered_buffer_postenable:
> > > > > > > > -  * Generic function that simply attaches the pollfunc to
> > > > > > > > the
> > > > > > > > trigger.
> > > > > > > > -  * Replace this to mess with hardware state before we
> > > > > > > > attach the
> > > > > > > > -  * trigger.
> > > > > > > > -  */
> > > > > > > > - .postenable = &iio_triggered_buffer_postenable,
> > > > > > > > - /*
> > > > > > > > -  * iio_triggered_buffer_predisable:
> > > > > > > > -  * Generic function that simple detaches the pollfunc from
> > > > > > > > the
> > > > > > > > trigger.
> > > > > > > > -  * Replace this to put hardware state back again after the
> > > > > > > > trigger
> > > > > > > > is
> > > > > > > > -  * detached but before userspace knows we have disabled the
> > > > > > > > ring.
> > > > > > > > -  */
> > > > > > > > - .predisable = &iio_triggered_buffer_predisable,
> > > > > > > >    };
> > > > > > > >   
> > > > > > > Hmm. Guess we should probably 'invent' a reason to illustrate
> > > > > > > the bufer
> > > > > > > ops in the dummy example.  Anyone feeling creative?  
> > > > > > _______________________________________________
> > > > > > linux-arm-kernel mailing list
> > > > > > linux-arm-kernel@lists.infradead.org
> > > > > > https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!A3Ni8CS0y2Y!ulH92S3o_JWLMQfg5VBrFknwc_-a0K5AHpJBrTEB-RtYEp7PnRJ9jA_EacOzFQmbNIKO-Q$  
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!A3Ni8CS0y2Y!sOycjyvbMtVr_UDFBvb0vdcf9ONdhs0VBLhTcuYO4qnuZmazm5342mRE2T-119RWwM-1NA$ 
> > >   

