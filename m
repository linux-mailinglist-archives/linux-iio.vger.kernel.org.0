Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56B6578867
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiGRR3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 13:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiGRR3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 13:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1005F5E
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 10:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D00DB61597
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 17:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC893C341C0;
        Mon, 18 Jul 2022 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658165349;
        bh=vKOA2Sjkz4KWE9WHL2fgIwr0Xc0rETnybRUxjFN39KY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EgcnhQIBEcXnmvL+UheNSctoPnBX7T5/SYIW/7/Uy4k8YB5vKHB2U34Gs/zzZ2Bk+
         OM0yoHq21W9PUACBphvRSA0osufKWp6xglOf9YWi6dG2RDXMCYrA9mqwfmXSvZ/xrc
         4byEw6FkrFXSg9XiFw3Xd9WwHNdmnjrlaQ5nXE3YFelpbTSZHJWL9Vl5M52pwBlpQe
         S/TuFroSYd7n3XQUWgf6tazbRFDM+j4DTRqguCTqXitSccKNrY/0z3fwPeuHrFwGVk
         uX5L3Q0tKXghgyADR6HvqFb1v8bGGOgo4UZf7EIvIvokt8uNHrdrKm7nug75kvrXXK
         KcdFeGeOHL85Q==
Date:   Mon, 18 Jul 2022 18:39:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <linux-iio@vger.kernel.org>,
        "Fabrice Gasnier" <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 3/4] iio: ABI: stm32-timer-trigger: Fuse unusual ABI
 into main doc.
Message-ID: <20220718183905.2de6b3c7@jic23-huawei>
In-Reply-To: <20220628065119.38ef8aea@sal.lan>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-4-jic23@kernel.org>
        <20220626233745.10cd37ff@sal.lan>
        <20220627150955.00001e68@Huawei.com>
        <20220628065119.38ef8aea@sal.lan>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jun 2022 06:51:19 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Mon, 27 Jun 2022 15:09:55 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
> 
> > On Sun, 26 Jun 2022 23:37:45 +0100
> > Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> >   
> > > Em Sun, 26 Jun 2022 17:55:10 +0100
> > > Jonathan Cameron <jic23@kernel.org> escreveu:
> > >     
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > We can't duplicate the description of sampling_frequency. This device
> > > > has some unusual requirements which we solved by giving a
> > > > sampling_frequency of 0 special meaning. As such add a note
> > > > about this unusual usage to the main documentation.
> > > > 
> > > > Whilst I don't particularly like this resolution, it is the best
> > > > I could come up with given earlier discussion on this topic.
> > > > 
> > > > Link: https://lore.kernel.org/linux-iio/20210315101217.00002c50@Huawei.com/
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-iio             | 3 +++
> > > >  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
> > > >  2 files changed, 3 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > > index 3e00d7f7ee22..e81ba6f5e1c8 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > > @@ -107,6 +107,9 @@ Description:
> > > >  		relevant directories.  If it affects all of the above
> > > >  		then it is to be found in the base device directory.
> > > >  
> > > > +		The stm32-timer-trigger has the additional characteristic that
> > > > +		a sampling_frequency of 0 is defined to stop sampling.
> > > > +      
> > > 
> > > I would actually say something like:
> > > 
> > > 		A ampling_frequency of 0 means to stop sampling,
> > > 		if supported by the driver.
> > >     
> > 
> > We actively want to stop people doing this without coming
> > to the list and explaining exactly why they need to. The discussion
> > around that one exception was long and involved. So we want
> > them to have to modify this doc to list their part thus raising
> > awareness of them doing this. So far it's in one driver our of many
> > (and to use this feature it needs custom userspace as it is
> > setting up a complex chain of devices, but for other more conventional
> > use, not allowing 0 is fine).
> > 
> > The source of this disagreement is the documentation serves two
> > purposes - for userspace code authors and for kernel developers.
> > Userspace can just not set the value to 0 if it is generic code.
> > 
> > We could add additional ABI element to make userspace aware, but
> > so far only this one device which will run with customer userspace
> > uses this.  Hence we rely on documentation.  
> 
> 
> OK!
> 
> This actually proves the point that duplicated symbols at ABI cause
> troubles, as different implementations could end abusing on what
> it would be expected, like in this case ;-)
> 
> Anyway, feel free to add my reviewed-by to this patch.
Picked up 2 and 3 of this series. 4 was fixed by someone else.

Thanks,

Jonathan

> 
> Regards,
> Mauro
> 
> > 
> > Jonathan
> >   
> > > Either way:
> > > 
> > > Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > 
> > >     
> > > >  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
> > > >  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
> > > >  What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > > > index c4a4497c249a..05074c4a65e2 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > > > @@ -90,14 +90,6 @@ Description:
> > > >  		Reading returns the current master modes.
> > > >  		Writing set the master mode
> > > >  
> > > > -What:		/sys/bus/iio/devices/triggerX/sampling_frequency
> > > > -KernelVersion:	4.11
> > > > -Contact:	benjamin.gaignard@st.com
> > > > -Description:
> > > > -		Reading returns the current sampling frequency.
> > > > -		Writing an value different of 0 set and start sampling.
> > > > -		Writing 0 stop sampling.
> > > > -
> > > >  What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
> > > >  KernelVersion:	4.12
> > > >  Contact:	benjamin.gaignard@st.com      
> >   

