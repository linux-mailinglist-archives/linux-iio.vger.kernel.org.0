Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FA55D06D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiF0OKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiF0OKB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 10:10:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F201D13D0F
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 07:09:59 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LWqJP4rlCz6H8N8;
        Mon, 27 Jun 2022 22:05:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:09:57 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 27 Jun
 2022 15:09:56 +0100
Date:   Mon, 27 Jun 2022 15:09:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Fabrice Gasnier" <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 3/4] iio: ABI: stm32-timer-trigger: Fuse unusual ABI
 into main doc.
Message-ID: <20220627150955.00001e68@Huawei.com>
In-Reply-To: <20220626233745.10cd37ff@sal.lan>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-4-jic23@kernel.org>
        <20220626233745.10cd37ff@sal.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Jun 2022 23:37:45 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun, 26 Jun 2022 17:55:10 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > We can't duplicate the description of sampling_frequency. This device
> > has some unusual requirements which we solved by giving a
> > sampling_frequency of 0 special meaning. As such add a note
> > about this unusual usage to the main documentation.
> > 
> > Whilst I don't particularly like this resolution, it is the best
> > I could come up with given earlier discussion on this topic.
> > 
> > Link: https://lore.kernel.org/linux-iio/20210315101217.00002c50@Huawei.com/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio             | 3 +++
> >  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
> >  2 files changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 3e00d7f7ee22..e81ba6f5e1c8 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -107,6 +107,9 @@ Description:
> >  		relevant directories.  If it affects all of the above
> >  		then it is to be found in the base device directory.
> >  
> > +		The stm32-timer-trigger has the additional characteristic that
> > +		a sampling_frequency of 0 is defined to stop sampling.
> > +  
> 
> I would actually say something like:
> 
> 		A ampling_frequency of 0 means to stop sampling,
> 		if supported by the driver.
> 

We actively want to stop people doing this without coming
to the list and explaining exactly why they need to. The discussion
around that one exception was long and involved. So we want
them to have to modify this doc to list their part thus raising
awareness of them doing this. So far it's in one driver our of many
(and to use this feature it needs custom userspace as it is
setting up a complex chain of devices, but for other more conventional
use, not allowing 0 is fine).

The source of this disagreement is the documentation serves two
purposes - for userspace code authors and for kernel developers.
Userspace can just not set the value to 0 if it is generic code.

We could add additional ABI element to make userspace aware, but
so far only this one device which will run with customer userspace
uses this.  Hence we rely on documentation.

Jonathan

> Either way:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> 
> >  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > index c4a4497c249a..05074c4a65e2 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> > @@ -90,14 +90,6 @@ Description:
> >  		Reading returns the current master modes.
> >  		Writing set the master mode
> >  
> > -What:		/sys/bus/iio/devices/triggerX/sampling_frequency
> > -KernelVersion:	4.11
> > -Contact:	benjamin.gaignard@st.com
> > -Description:
> > -		Reading returns the current sampling frequency.
> > -		Writing an value different of 0 set and start sampling.
> > -		Writing 0 stop sampling.
> > -
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
> >  KernelVersion:	4.12
> >  Contact:	benjamin.gaignard@st.com  

