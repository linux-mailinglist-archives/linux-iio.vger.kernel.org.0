Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF655B465
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jun 2022 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiFZWdl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 18:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiFZWdl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 18:33:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16295270C
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 15:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39875B80DF4
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 22:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC674C34114;
        Sun, 26 Jun 2022 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656282816;
        bh=yQm8UCzni9RsZtvE4sjmJjz7dV+jCvYmbvZa5sMC6Go=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MZcdhSdFTfzA7MSYXTvwOZuMMfyLvQ+F21tqdGHdI1eY1G7FisIXXtg8xQepLCyot
         MCwk3W0qHlyWTkWzITHAXjemTNspk5sdfKKM5lLpWPX3ho1IMWs4o7muUIGLRYwDgf
         pQuMBVBjJFD1Rd0j/ecq0qEwpREv3GHH3F/b+hXdn1VsuyYQv4YL3fH3VyBoSCZNnO
         Gs3KmCjkXE1auHv65UaHQRM4kmkMDRgdY341SGXjLvB+ZfhOPG9uH06DHI9igd+mX+
         vPkI3T13aH4L6tV849U8WcO116fuOYBsGvCLe2NGpZVSozJVHrJjWoalBP4kibJmsX
         O9pwOt1oBlLOw==
Date:   Sun, 26 Jun 2022 23:33:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Subject: Re: [PATCH 1/4] iio: ABI: temperature: Unify documentation for
 thermocouple fault detection.
Message-ID: <20220626233331.2e8e38d1@sal.lan>
In-Reply-To: <20220626165511.602202-2-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-2-jic23@kernel.org>
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

Em Sun, 26 Jun 2022 17:55:08 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The kernel build docs do not support having multiple definitions for
> the same sysfs filename. 

Actually, this is not a matter of the docs build system not supporting. 
It is, instead, how the ABI were supposed to work: a given ABI symbol 
should have consistent behavior on all drivers that use it. Failing to
do that is asking for troubles.

So, having duplicated symbols either mean that:

a) both have the same meaning. They can/should be unified in order to
   remove redundant documentation;

b) the same ABI symbol have different meanings depending on the driver(s)
   that use it. This makes very hard for userspace, as it is harder to
   write a program using it, as the behavior/meaning starts to be
   driver-dependent.


>  Hence generalize the documentation a little
> and pull it out of device specific files and into
> sysfs-bus-iio-thermocouple
> 
> These may well be more general and need pulling into a more generic
> file in the future, but we can do that when it is needed.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Navin Sankar Velliangiri <navin@linumiz.com>
> Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

Except for the above correction, the patch looks OK to me.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  .../sysfs-bus-iio-temperature-max31856        | 31 -------------------
>  .../sysfs-bus-iio-temperature-max31865        | 12 -------
>  .../ABI/testing/sysfs-bus-iio-thermocouple    | 18 +++++++++++
>  3 files changed, 18 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> deleted file mode 100644
> index e5ef6d8e5da1..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
> -KernelVersion:	5.1
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Open-circuit fault. The detection of open-circuit faults,
> -		such as those caused by broken thermocouple wires.
> -		Reading returns either '1' or '0'.
> -
> -		===  =======================================================
> -		'1'  An open circuit such as broken thermocouple wires
> -		     has been detected.
> -		'0'  No open circuit or broken thermocouple wires are detected
> -		===  =======================================================
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> -KernelVersion:	5.1
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Overvoltage or Undervoltage Input Fault. The internal circuitry
> -		is protected from excessive voltages applied to the thermocouple
> -		cables by integrated MOSFETs at the T+ and T- inputs, and the
> -		BIAS output. These MOSFETs turn off when the input voltage is
> -		negative or greater than VDD.
> -
> -		Reading returns either '1' or '0'.
> -
> -		===  =======================================================
> -		'1'  The input voltage is negative or greater than VDD.
> -		'0'  The input voltage is positive and less than VDD (normal
> -		     state).
> -		===  =======================================================
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> index 4b072da92218..349089e4f2d6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> @@ -1,15 +1,3 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> -KernelVersion:	5.11
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Overvoltage or Undervoltage Input fault. The internal circuitry
> -		is protected from excessive voltages applied to the thermocouple
> -		cables at FORCE+, FORCE2, RTDIN+ & RTDIN-. This circuitry turn
> -		off when the input voltage is negative or greater than VDD.
> -
> -		Reading returns '1' if input voltage is negative or greater
> -		than VDD, otherwise '0'.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
>  KernelVersion:	5.11
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-thermocouple b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
> new file mode 100644
> index 000000000000..01259df297ca
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
> @@ -0,0 +1,18 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Overvoltage or Undervoltage Input Fault. The internal circuitry
> +		is protected from excessive voltages applied to the thermocouple
> +		cables. The device can also detect if such a condition occurs.
> +
> +		Reading returns '1' if input voltage is negative or greater
> +		than VDD, otherwise '0'.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Open-circuit fault. The detection of open-circuit faults,
> +		such as those caused by broken thermocouple wires.
> +		Reading returns '1' if fault, '0' otherwise.
