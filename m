Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D155CFB6
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiF1GoS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 02:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbiF1GoQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 02:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA026AE7
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 23:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1421B61978
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 06:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B819C3411D;
        Tue, 28 Jun 2022 06:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656398654;
        bh=SgKayFUXb94rbpByuktzT/IaSy0xwPrAP6meJL46oK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a6dKnTaRMJj5BkF+ocz5+0Od0DpvbxJQDTb0E8TAT5Wl3XDGwBiKw8fHLGut0HW6p
         QellHN8WHd8l+/+yNTH0sNFi+4e3D37MVycS72/XPIEVE4cdXvpr/4cn7+TcX6bwyc
         ILz2ZxcNFWfwUOo6jHYHxV93JpVE5BSTMOEsNi4cp7syL7C/VZvKApw7BUWVanyqkf
         0I+dfc/MCI9Im2SF0gPju29NN9MPg3iK9ClM18ZsHMU7opsCF4nlu6gusbJRZmBRLI
         +JaGAMtu44suNxqjPlr9QMo/s1WOxU0JkcgRBykAG/WCUFSXj0M4xC5OjN48D38oDS
         KIkbHlHv8BQwg==
Date:   Tue, 28 Jun 2022 07:44:09 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Navin Sankar Velliangiri" <navin@linumiz.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Subject: Re: [PATCH 1/4] iio: ABI: temperature: Unify documentation for
 thermocouple fault detection.
Message-ID: <20220628074409.42f0ecae@sal.lan>
In-Reply-To: <20220627151812.000069d2@Huawei.com>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-2-jic23@kernel.org>
        <20220626233331.2e8e38d1@sal.lan>
        <20220627151812.000069d2@Huawei.com>
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

Em Mon, 27 Jun 2022 15:18:12 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Sun, 26 Jun 2022 23:33:31 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> 
> > Em Sun, 26 Jun 2022 17:55:08 +0100
> > Jonathan Cameron <jic23@kernel.org> escreveu:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > The kernel build docs do not support having multiple definitions for
> > > the same sysfs filename.     
> > 
> > Actually, this is not a matter of the docs build system not supporting. 
> > It is, instead, how the ABI were supposed to work: a given ABI symbol 
> > should have consistent behavior on all drivers that use it. Failing to
> > do that is asking for troubles.
> > 
> > So, having duplicated symbols either mean that:
> > 
> > a) both have the same meaning. They can/should be unified in order to
> >    remove redundant documentation;
> > 
> > b) the same ABI symbol have different meanings depending on the driver(s)
> >    that use it. This makes very hard for userspace, as it is harder to
> >    write a program using it, as the behavior/meaning starts to be
> >    driver-dependent.  
> 
> I think we'll disagree on this.
> 
> There are circumstances where a particular ABI in a particular driver
> benefits from additional documentation that would be in the 'impdef
> category' for the generic ABI.

If a particular driver needs something different, either:

1. the ABI definition was loose or too tight, not being generic enough to
   cover other hardware needing ABI for the same feature;
2. a different ABI symbol would need, as the two symbols with the same
   name are mapping completely different ABIs.

> For this particular case it extends the info available from 'wire
> disconnected' in the generic case, to 'which possible wires are
> disconnected' in the specific case. 

In the specific case of device faults, it could be mapped in a way
that would be generic enough, yet providing hardware-specific information,
when the hardware supports it.

In this specific case, I would probably create a generic ABI (or ABI set)
to report hardware issues in a way that it would be more generic.

One possibility for this case would be to use something like this:

	$ cat /sys/bus/iio/devices/iio:deviceX/fault
	no faults

On hardware that can't pinpoint what wire(s) the problem is occurring:

	$ cat /sys/bus/iio/devices/iio:deviceX/fault
	fault: open circuit

or
	$ cat /sys/bus/iio/devices/iio:deviceX/fault
	fault: excessive voltage

On more sophisticated hardware that can pinpoint what wires have
issues, it may report, instead:

	$ cat /sys/bus/iio/devices/iio:deviceX/fault
	fault: open circuit fault at thermocouple wire #2

or

	$ cat /sys/bus/iio/devices/iio:deviceX/fault
	fault: excessive voltage at thermocouple wires #0 and #1

or even:

	$ cat /sys/bus/iio/devices/iio:deviceX/fault
	fault: open circuit fault at thermocouple wire #2
	fault: excessive voltage at thermocouple wires #0 and #1

The above should be generic enough for a program to identify if there
isn't any failures if such "fault" ABI would return "no faults". Any value
different than that means that there's a fault, and the read value
telling what happened could be output to the user before such program
aborts due to a hardware error.

-

The point is that, when the ABI is made to be subsystem-wide since
the beginning, it tends to be more generic, as the ABI design should
consider that other devices may have different capabilities. 

> Neither affects what userspace
> does with it, but they are useful if you are debugging the hardware.
> They are probably not worth expanding the ABI to provide a debugging
> guide, so it that info was in the documentation but is now lost
> (in this case, non critical as it's probably a case of go read the
>  datasheet if the hanging wire isn't obvious).
> 
> I don't mind just making this patch description vague: 
> 
> Kernel documentation for a given ABI element should not be duplicated
> in multiple files, so pull them into one higher level documentation file.

Works for me. With that, feel free to add my reviewed-by.

Regards,
Mauro

> > >  Hence generalize the documentation a little
> > > and pull it out of device specific files and into
> > > sysfs-bus-iio-thermocouple
> > > 
> > > These may well be more general and need pulling into a more generic
> > > file in the future, but we can do that when it is needed.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Navin Sankar Velliangiri <navin@linumiz.com>
> > > Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>    
> > 
> > Except for the above correction, the patch looks OK to me.
> > 
> > Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> >   
> > > ---
> > >  .../sysfs-bus-iio-temperature-max31856        | 31 -------------------
> > >  .../sysfs-bus-iio-temperature-max31865        | 12 -------
> > >  .../ABI/testing/sysfs-bus-iio-thermocouple    | 18 +++++++++++
> > >  3 files changed, 18 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> > > deleted file mode 100644
> > > index e5ef6d8e5da1..000000000000
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> > > +++ /dev/null
> > > @@ -1,31 +0,0 @@
> > > -What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
> > > -KernelVersion:	5.1
> > > -Contact:	linux-iio@vger.kernel.org
> > > -Description:
> > > -		Open-circuit fault. The detection of open-circuit faults,
> > > -		such as those caused by broken thermocouple wires.
> > > -		Reading returns either '1' or '0'.
> > > -
> > > -		===  =======================================================
> > > -		'1'  An open circuit such as broken thermocouple wires
> > > -		     has been detected.
> > > -		'0'  No open circuit or broken thermocouple wires are detected
> > > -		===  =======================================================
> > > -
> > > -What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> > > -KernelVersion:	5.1
> > > -Contact:	linux-iio@vger.kernel.org
> > > -Description:
> > > -		Overvoltage or Undervoltage Input Fault. The internal circuitry
> > > -		is protected from excessive voltages applied to the thermocouple
> > > -		cables by integrated MOSFETs at the T+ and T- inputs, and the
> > > -		BIAS output. These MOSFETs turn off when the input voltage is
> > > -		negative or greater than VDD.
> > > -
> > > -		Reading returns either '1' or '0'.
> > > -
> > > -		===  =======================================================
> > > -		'1'  The input voltage is negative or greater than VDD.
> > > -		'0'  The input voltage is positive and less than VDD (normal
> > > -		     state).
> > > -		===  =======================================================
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> > > index 4b072da92218..349089e4f2d6 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> > > @@ -1,15 +1,3 @@
> > > -What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> > > -KernelVersion:	5.11
> > > -Contact:	linux-iio@vger.kernel.org
> > > -Description:
> > > -		Overvoltage or Undervoltage Input fault. The internal circuitry
> > > -		is protected from excessive voltages applied to the thermocouple
> > > -		cables at FORCE+, FORCE2, RTDIN+ & RTDIN-. This circuitry turn
> > > -		off when the input voltage is negative or greater than VDD.
> > > -
> > > -		Reading returns '1' if input voltage is negative or greater
> > > -		than VDD, otherwise '0'.
> > > -
> > >  What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
> > >  KernelVersion:	5.11
> > >  Contact:	linux-iio@vger.kernel.org
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-thermocouple b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
> > > new file mode 100644
> > > index 000000000000..01259df297ca
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
> > > @@ -0,0 +1,18 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> > > +KernelVersion:	5.1
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Overvoltage or Undervoltage Input Fault. The internal circuitry
> > > +		is protected from excessive voltages applied to the thermocouple
> > > +		cables. The device can also detect if such a condition occurs.
> > > +
> > > +		Reading returns '1' if input voltage is negative or greater
> > > +		than VDD, otherwise '0'.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
> > > +KernelVersion:	5.1
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Open-circuit fault. The detection of open-circuit faults,
> > > +		such as those caused by broken thermocouple wires.
> > > +		Reading returns '1' if fault, '0' otherwise.    
> 
