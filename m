Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937B15F22EA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJBL2i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJBL2e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 07:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95B2E6AC
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 04:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780FE60EA9
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 11:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE4AC433C1;
        Sun,  2 Oct 2022 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664710111;
        bh=uPGl4+mHXoNK6OWmL1SCISOwY6XFRpsBzkX2ePCIhW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jcuhRNdvdJ4VwwJAGZesFLl8hQzkMRp88MmL8c/atOJbhxyK8XfOscu/5vyKeisQE
         2tWSeKlaANFucXNrvyhQbQ6iD3VbQyd+E5/MBSP4PcZuE98ZuFC3rlEtrkNvkv349o
         fSE6oH1NITVMHfvtSV2h3GYDzdhV59oh1JPTuv+FODmgabEMez1WGxx6vSslnefJY/
         Zzo2pxYxE+Z405r/AO8FN7e4M3e457e5ruDAaxPkjd0qFwKPeK11IX6z+Y/tVOZ4kI
         ukE4bD7IJhLfT6FRsrVPsZHb0U7aiEHb9cqsTeR/lemZDKbCtby5465awCP22ftBug
         HtYZKfN1JKR1Q==
Date:   Sun, 2 Oct 2022 12:28:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: filter: admv8818: fix out-of-bounds read in
 __admv8818_read_[h|l]pf_freq()
Message-ID: <20221002122848.68b59023@jic23-huawei>
In-Reply-To: <CY4PR03MB33994103D029E15346CC99049B529@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220922115848.1800021-1-weiyongjun@huaweicloud.com>
        <20220924175336.3c3cadb6@jic23-huawei>
        <CY4PR03MB33994103D029E15346CC99049B529@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Sep 2022 06:20:20 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, September 24, 2022 7:54 PM
> > To: Wei Yongjun <weiyongjun@huaweicloud.com>
> > Cc: linux-iio@vger.kernel.org; Wei Yongjun <weiyongjun1@huawei.com>;
> > Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH] iio: filter: admv8818: fix out-of-bounds read in
> > __admv8818_read_[h|l]pf_freq()
> > 
> > [External]
> > 
> > On Thu, 22 Sep 2022 11:58:48 +0000
> > Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
> >   
> > > From: Wei Yongjun <weiyongjun1@huawei.com>
> > >
> > > ADMV8818_SW_IN_WR0_MSK and ADMV8818_SW_OUT_WR0_MSK have 3  
> > bits,  
> > > which means a length of 8, but freq_range_hpf and freq_range_lpf
> > > array size is 4, may end up reading 4 elements beyond the end of
> > > those arrays.
> > >
> > > Fix to check value first before access freq_range_hpf and
> > > freq_range_lpf.
> > >
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>  
> Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

I tweaked the commit message a little to have this as hardening rather than 
a fix.  I'm fine with it being backported if that makes sense, but I don't
want it automatically picked up.

Good to harden this though.

Applied to the togreg branch of iio.git. I'll only be pushing that out as
testing until I can rebase on rc1.  In the meantime we should get 0-day
checking it etc.

Thanks,

Jonathan

> > 
> > The datasheet isn't clear on whether the register simply can't take values
> > above b100 or that the behaviour if it does is undefined.  It would take someone
> > to poke the registers on a real device to find out.  Either way, this seems to
> > be a reasonable hardening against corrupt data back from the device.
> > 
> > I will leave it on list a while longer though so it is probably 6.2 material
> > now.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/filter/admv8818.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> > > index 68de45fe21b4..fe8d46cb7f1d 100644
> > > --- a/drivers/iio/filter/admv8818.c
> > > +++ b/drivers/iio/filter/admv8818.c
> > > @@ -265,7 +265,7 @@ static int __admv8818_read_hpf_freq(struct  
> > admv8818_state *st, u64 *hpf_freq)  
> > >  		return ret;
> > >
> > >  	hpf_band = FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
> > > -	if (!hpf_band) {
> > > +	if (!hpf_band || hpf_band > 4) {
> > >  		*hpf_freq = 0;
> > >  		return ret;
> > >  	}
> > > @@ -303,7 +303,7 @@ static int __admv8818_read_lpf_freq(struct  
> > admv8818_state *st, u64 *lpf_freq)  
> > >  		return ret;
> > >
> > >  	lpf_band = FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
> > > -	if (!lpf_band) {
> > > +	if (!lpf_band || lpf_band > 4) {
> > >  		*lpf_freq = 0;
> > >  		return ret;
> > >  	}  
> 

