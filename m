Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD255E208
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiF1Fv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 01:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiF1Fv2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 01:51:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9E266
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 22:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14810B81C50
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5952EC3411D;
        Tue, 28 Jun 2022 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656395484;
        bh=zNWn6p3tm6XVKPrC56cQgT5KFsmy9+6OJpM+ncGOakg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDaFxuaDLbkgEw41rHJidqJzOvV4NgT4UWtK+orUAwIV+U/FRAtPCkM1aDCC7t8Xc
         3onCLqGPt/u2UWjxe1drABU+n4v/cRat3Qap++/ImKu6fXYPzspVNS/6rbkOmMj4Ou
         7XFQQ1geehWRB0wcb6r4q3pHYL9+4DcTNIiHKZbutqYhfBmuWLat/ZE2pTiKUuyPWj
         bkUgQbjspk43SoE5aNXeEfTo/+gUfx9hWNf3XgTrayx6Oj5t9YGhhIW3GkF5fCWylU
         Eetvjxw04sWaeu49HQupe5KnAwP0jm+l1SXGEg08rgo+PifoFNcvcrjgpJVRgoPvDK
         j1Hdrlx468qZQ==
Date:   Tue, 28 Jun 2022 06:51:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Fabrice Gasnier" <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 3/4] iio: ABI: stm32-timer-trigger: Fuse unusual ABI
 into main doc.
Message-ID: <20220628065119.38ef8aea@sal.lan>
In-Reply-To: <20220627150955.00001e68@Huawei.com>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-4-jic23@kernel.org>
        <20220626233745.10cd37ff@sal.lan>
        <20220627150955.00001e68@Huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Mon, 27 Jun 2022 15:09:55 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Sun, 26 Jun 2022 23:37:45 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> 
> > Em Sun, 26 Jun 2022 17:55:10 +0100
> > Jonathan Cameron <jic23@kernel.org> escreveu:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > We can't duplicate the description of sampling_frequency. This device
> > > has some unusual requirements which we solved by giving a
> > > sampling_frequency of 0 special meaning. As such add a note
> > > about this unusual usage to the main documentation.
> > > 
> > > Whilst I don't particularly like this resolution, it is the best
> > > I could come up with given earlier discussion on this topic.
> > > 
> > > Link: https://lore.kernel.org/linux-iio/20210315101217.00002c50@Huawei.com/
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio             | 3 +++
> > >  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
> > >  2 files changed, 3 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index 3e00d7f7ee22..e81ba6f5e1c8 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -107,6 +107,9 @@ Description:
> > >  		relevant directories.  If it affects all of the above
> > >  		then it is to be found in the base device directory.
> > >  
> > > +		The stm32-timer-trigger has the additional characteristic that
> > > +		a sampling_frequency of 0 is defined to stop sampling.
> > > +    
> > 
> > I would actually say something like:
> > 
> > 		A ampling_frequency of 0 means to stop sampling,
> > 		if supported by the driver.
> >   
> 
> We actively want to stop people doing this without coming
> to the list and explaining exactly why they need to. The discussion
> around that one exception was long and involved. So we want
> them to have to modify this doc to list their part thus raising
> awareness of them doing this. So far it's in one driver our of many
> (and to use this feature it needs custom userspace as it is
> setting up a complex chain of devices, but for other more conventional
> use, not allowing 0 is fine).
> 
> The source of this disagreement is the documentation serves two
> purposes - for userspace code authors and for kernel developers.
> Userspace can just not set the value to 0 if it is generic code.
> 
> We could add additional ABI element to make userspace aware, but
> so far only this one device which will run with customer userspace
> uses this.  Hence we rely on documentation.


OK!

This actually proves the point that duplicated symbols at ABI cause
troubles, as different implementations could end abusing on what
it would be expected, like in this case ;-)

Anyway, feel free to add my reviewed-by to this patch.

Regards,
Mauro

> 
> Jonathan
> 
> > Either way:
> > 
> > Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > 
> >   
> > >  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
> > >  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
> > >  What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > > index c4a4497c249a..05074c4a65e2 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > > @@ -90,14 +90,6 @@ Description:
> > >  		Reading returns the current master modes.
> > >  		Writing set the master mode
> > >  
> > > -What:		/sys/bus/iio/devices/triggerX/sampling_frequency
> > > -KernelVersion:	4.11
> > > -Contact:	benjamin.gaignard@st.com
> > > -Description:
> > > -		Reading returns the current sampling frequency.
> > > -		Writing an value different of 0 set and start sampling.
> > > -		Writing 0 stop sampling.
> > > -
> > >  What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
> > >  KernelVersion:	4.12
> > >  Contact:	benjamin.gaignard@st.com    
> 
