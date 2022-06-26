Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310655B467
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jun 2022 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiFZWhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 18:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiFZWhx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 18:37:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6472DE4
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 15:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF86B8018A
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 22:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6277C34114;
        Sun, 26 Jun 2022 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656283069;
        bh=5/3AgAQeAKH1hzMa821eal2v+dMKO1T/N6GEHvQdKqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=myF9JdMyrDk5jl+rHpMaZ9BLdrHdVTd5rYkRcijmPsm338U3TiOma/kjrqa/21qoD
         nU8RuiwUjsLC8HnguVRldC/N1mVyIXnW7OJf5PhkMfQVqvE6DQO+bITNMYmSn5e9PV
         3Op/aH0ooc/psA9X9Z4NJkAw2EEEjvbrNywgqFTylY6p6Ptc8rln9Ncsjrx28wun96
         7a4QJc8IzCjYky5jpCqMDhScS8DP8tXydzX4chCPUKFZ5WCpRJBGLb2y429tsW0GJt
         fbgdODnDxxvLGRzx/iuDP3p6+O+U/rw6ii2t9P3YFmYCgsE4sfrfXSwZIS4EcV+T9g
         r7WF343b3Lqnw==
Date:   Sun, 26 Jun 2022 23:37:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 3/4] iio: ABI: stm32-timer-trigger: Fuse unusual ABI
 into main doc.
Message-ID: <20220626233745.10cd37ff@sal.lan>
In-Reply-To: <20220626165511.602202-4-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-4-jic23@kernel.org>
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

Em Sun, 26 Jun 2022 17:55:10 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> We can't duplicate the description of sampling_frequency. This device
> has some unusual requirements which we solved by giving a
> sampling_frequency of 0 special meaning. As such add a note
> about this unusual usage to the main documentation.
> 
> Whilst I don't particularly like this resolution, it is the best
> I could come up with given earlier discussion on this topic.
> 
> Link: https://lore.kernel.org/linux-iio/20210315101217.00002c50@Huawei.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio             | 3 +++
>  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3e00d7f7ee22..e81ba6f5e1c8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -107,6 +107,9 @@ Description:
>  		relevant directories.  If it affects all of the above
>  		then it is to be found in the base device directory.
>  
> +		The stm32-timer-trigger has the additional characteristic that
> +		a sampling_frequency of 0 is defined to stop sampling.
> +

I would actually say something like:

		A ampling_frequency of 0 means to stop sampling,
		if supported by the driver.

Either way:

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>


>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index c4a4497c249a..05074c4a65e2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -90,14 +90,6 @@ Description:
>  		Reading returns the current master modes.
>  		Writing set the master mode
>  
> -What:		/sys/bus/iio/devices/triggerX/sampling_frequency
> -KernelVersion:	4.11
> -Contact:	benjamin.gaignard@st.com
> -Description:
> -		Reading returns the current sampling frequency.
> -		Writing an value different of 0 set and start sampling.
> -		Writing 0 stop sampling.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
>  KernelVersion:	4.12
>  Contact:	benjamin.gaignard@st.com
