Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91FC279A52
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgIZPRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 11:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZPRm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 11:17:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCCA20BED;
        Sat, 26 Sep 2020 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601133462;
        bh=D4U25c4Vq+RI+pFAEaZB5jMZ72TqFjqgB+2lURo9ENI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h+W6BnHqqaNoA+fHIr4COoKmQyK1ytOEwSBBQ59l+aZSQs1vZQj5ZoyBj2UGvhLV3
         waUw7yYToz20RmoMXtzILR5ovSwIl0Ba/Bp9HE/h90aYrNXRztB3WOsPBS0wSJf2Mx
         +JLcRvIU5InDoa9bWLS4jsUpoTNKbc6UoOcnER3E=
Date:   Sat, 26 Sep 2020 16:17:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <rafael.j.wysocki@intel.com>, <rjw@rjwysocki.net>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [RESEND PATCH v2] iio: adc: stm32-adc: fix runtime autosuspend
 delay when slow polling
Message-ID: <20200926161732.72af96e3@archlinux>
In-Reply-To: <045e9e34-f1e0-087b-bc5b-44440db6be27@st.com>
References: <1593615328-5180-1-git-send-email-fabrice.gasnier@st.com>
        <045e9e34-f1e0-087b-bc5b-44440db6be27@st.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 12:28:00 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 7/1/20 4:55 PM, Fabrice Gasnier wrote:
> > When the ADC is runtime suspended and starting a conversion, the stm32-adc
> > driver calls pm_runtime_get_sync() that gets cascaded to the parent
> > (e.g. runtime resume of stm32-adc-core driver). This also kicks the
> > autosuspend delay (e.g. 2s) of the parent.
> > Once the ADC is active, calling pm_runtime_get_sync() again (upon a new
> > capture) won't kick the autosuspend delay for the parent (stm32-adc-core
> > driver) as already active.
> > 
> > Currently, this makes the stm32-adc-core driver go in suspend state
> > every 2s when doing slow polling. As an example, doing a capture, e.g.
> > cat in_voltageY_raw at a 0.2s rate, the auto suspend delay for the parent
> > isn't refreshed. Once it expires, the parent immediately falls into
> > runtime suspended state, in between two captures, as soon as the child
> > driver falls into runtime suspend state:
> > - e.g. after 2s, + child calls pm_runtime_put_autosuspend() + 100ms
> >   autosuspend delay of the child.
> > - stm32-adc-core switches off regulators, clocks and so on.
> > - They get switched on back again 100ms later in this example (at 2.2s).
> > 
> > So, use runtime_idle() callback in stm32-adc-core driver to call
> > pm_runtime_mark_last_busy() for the parent driver (stm32-adc-core),
> > to avoid this.
> > 
> > Fixes: 9bdbb1139ca1 ("iio: adc: stm32-adc: add power management support")
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v2:
> > - Use runtime_idle callback in stm32-adc-core driver, instead of refreshing
> >   last_busy from the child (for the parent) at many place. Initial patch v1
> >   looked like "somewhat adhoc solution" as commented by Jonathan.  
> 
> Hi all,
> 
> Gentle reminder for this patch. Earlier discussions on it were as per
> [1] and [2].
> 
> Ideally, Jonathan was looking for an ack from Rafael on this patch.
> This is a long pending issue. I'd like to progress on this.
> 
> [1] https://patchwork.kernel.org/patch/11349841/
> [2] https://lkml.org/lkml/2020/6/11/279

Fabrice, I think this one has sat waiting for inputs for
too long. Hence I'm going to take a slight gamble that you are correct
on doing the fix this way (I'm reasonably convinced)

Applied to the fixes-togreg branch of iio.git.
It won't go in for 5.9 now, so we have a bit of time for any last
minute comments.

Thanks,

Jonathan

> 
> Please advise,
> Thanks in advance,
> Fabrice
> 
> > ---
> >  drivers/iio/adc/stm32-adc-core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index 0e2068e..3586369 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -794,6 +794,13 @@ static int stm32_adc_core_runtime_resume(struct device *dev)
> >  {
> >  	return stm32_adc_core_hw_start(dev);
> >  }
> > +
> > +static int stm32_adc_core_runtime_idle(struct device *dev)
> > +{
> > +	pm_runtime_mark_last_busy(dev);
> > +
> > +	return 0;
> > +}
> >  #endif
> >  
> >  static const struct dev_pm_ops stm32_adc_core_pm_ops = {
> > @@ -801,7 +808,7 @@ static const struct dev_pm_ops stm32_adc_core_pm_ops = {
> >  				pm_runtime_force_resume)
> >  	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
> >  			   stm32_adc_core_runtime_resume,
> > -			   NULL)
> > +			   stm32_adc_core_runtime_idle)
> >  };
> >  
> >  static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
> >   

