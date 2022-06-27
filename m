Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFEF55CA9B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiF0OSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiF0OSR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 10:18:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4B101E6
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 07:18:16 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LWqYn70Qmz67JwR;
        Mon, 27 Jun 2022 22:17:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:18:14 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 27 Jun
 2022 15:18:13 +0100
Date:   Mon, 27 Jun 2022 15:18:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Navin Sankar Velliangiri" <navin@linumiz.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Subject: Re: [PATCH 1/4] iio: ABI: temperature: Unify documentation for
 thermocouple fault detection.
Message-ID: <20220627151812.000069d2@Huawei.com>
In-Reply-To: <20220626233331.2e8e38d1@sal.lan>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-2-jic23@kernel.org>
        <20220626233331.2e8e38d1@sal.lan>
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

On Sun, 26 Jun 2022 23:33:31 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun, 26 Jun 2022 17:55:08 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The kernel build docs do not support having multiple definitions for
> > the same sysfs filename.   
> 
> Actually, this is not a matter of the docs build system not supporting. 
> It is, instead, how the ABI were supposed to work: a given ABI symbol 
> should have consistent behavior on all drivers that use it. Failing to
> do that is asking for troubles.
> 
> So, having duplicated symbols either mean that:
> 
> a) both have the same meaning. They can/should be unified in order to
>    remove redundant documentation;
> 
> b) the same ABI symbol have different meanings depending on the driver(s)
>    that use it. This makes very hard for userspace, as it is harder to
>    write a program using it, as the behavior/meaning starts to be
>    driver-dependent.

I think we'll disagree on this.

There are circumstances where a particular ABI in a particular driver
benefits from additional documentation that would be in the 'impdef
category' for the generic ABI.

For this particular case it extends the info available from 'wire
disconnected' in the generic case, to 'which possible wires are
disconnected' in the specific case.  Neither affects what userspace
does with it, but they are useful if you are debugging the hardware.
They are probably not worth expanding the ABI to provide a debugging
guide, so it that info was in the documentation but is now lost
(in this case, non critical as it's probably a case of go read the
 datasheet if the hanging wire isn't obvious).

I don't mind just making this patch description vague: 

Kernel documentation for a given ABI element should not be duplicated
in multiple files, so pull them into one higher level documentation file.



> 
> 
> >  Hence generalize the documentation a little
> > and pull it out of device specific files and into
> > sysfs-bus-iio-thermocouple
> > 
> > These may well be more general and need pulling into a more generic
> > file in the future, but we can do that when it is needed.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Navin Sankar Velliangiri <navin@linumiz.com>
> > Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>  
> 
> Except for the above correction, the patch looks OK to me.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> > ---
> >  .../sysfs-bus-iio-temperature-max31856        | 31 -------------------
> >  .../sysfs-bus-iio-temperature-max31865        | 12 -------
> >  .../ABI/testing/sysfs-bus-iio-thermocouple    | 18 +++++++++++
> >  3 files changed, 18 insertions(+), 43 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> > deleted file mode 100644
> > index e5ef6d8e5da1..000000000000
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> > +++ /dev/null
> > @@ -1,31 +0,0 @@
> > -What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
> > -KernelVersion:	5.1
> > -Contact:	linux-iio@vger.kernel.org
> > -Description:
> > -		Open-circuit fault. The detection of open-circuit faults,
> > -		such as those caused by broken thermocouple wires.
> > -		Reading returns either '1' or '0'.
> > -
> > -		===  =======================================================
> > -		'1'  An open circuit such as broken thermocouple wires
> > -		     has been detected.
> > -		'0'  No open circuit or broken thermocouple wires are detected
> > -		===  =======================================================
> > -
> > -What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> > -KernelVersion:	5.1
> > -Contact:	linux-iio@vger.kernel.org
> > -Description:
> > -		Overvoltage or Undervoltage Input Fault. The internal circuitry
> > -		is protected from excessive voltages applied to the thermocouple
> > -		cables by integrated MOSFETs at the T+ and T- inputs, and the
> > -		BIAS output. These MOSFETs turn off when the input voltage is
> > -		negative or greater than VDD.
> > -
> > -		Reading returns either '1' or '0'.
> > -
> > -		===  =======================================================
> > -		'1'  The input voltage is negative or greater than VDD.
> > -		'0'  The input voltage is positive and less than VDD (normal
> > -		     state).
> > -		===  =======================================================
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> > index 4b072da92218..349089e4f2d6 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> > @@ -1,15 +1,3 @@
> > -What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> > -KernelVersion:	5.11
> > -Contact:	linux-iio@vger.kernel.org
> > -Description:
> > -		Overvoltage or Undervoltage Input fault. The internal circuitry
> > -		is protected from excessive voltages applied to the thermocouple
> > -		cables at FORCE+, FORCE2, RTDIN+ & RTDIN-. This circuitry turn
> > -		off when the input voltage is negative or greater than VDD.
> > -
> > -		Reading returns '1' if input voltage is negative or greater
> > -		than VDD, otherwise '0'.
> > -
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
> >  KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-thermocouple b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
> > new file mode 100644
> > index 000000000000..01259df297ca
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
> > @@ -0,0 +1,18 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> > +KernelVersion:	5.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Overvoltage or Undervoltage Input Fault. The internal circuitry
> > +		is protected from excessive voltages applied to the thermocouple
> > +		cables. The device can also detect if such a condition occurs.
> > +
> > +		Reading returns '1' if input voltage is negative or greater
> > +		than VDD, otherwise '0'.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
> > +KernelVersion:	5.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Open-circuit fault. The detection of open-circuit faults,
> > +		such as those caused by broken thermocouple wires.
> > +		Reading returns '1' if fault, '0' otherwise.  

