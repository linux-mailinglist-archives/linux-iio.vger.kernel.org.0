Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FFC3C35B5
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhGJRJq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 13:09:46 -0400
Received: from vern.gendns.com ([98.142.107.122]:34050 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhGJRJp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 13:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F3dxVd9EJ5mEHpXDj1LpSHlp8jLyHIKmRh7AqA12FRs=; b=Wo8uUtFUJlsDVaahV4H1MUQ2JG
        fBcwQCbT4gcjZotUKE73BDc+3KP+bPyNauXGk1xNdMRozpzxUfjo4IzQxzilreksKrLHuYngn380d
        GsyobHVYUkuKU3hRo1/VbojyUHVTVDzCPaXxJX6x3sHuinafF/c1QuxNqY02mi1iYdhnWwykfEX1M
        DiTMGQRKysNCFSfgPTy9VvqnZu7mJl2wppHnsvvlKeKnEe2j/LzP8O4M+1x29mOfwCmj99KJRRSN6
        E2Axe36yR4eYFZDzha43pbwtiz4SyRk5d7d3GmYYg7zb3ePJ7x+vNfNvK7DYpqF3fsFZWRaozQLew
        qNGxySHA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:46940 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2GR8-00Gjkq-Cn; Sat, 10 Jul 2021 13:06:57 -0400
Subject: Re: [PATCH v12 14/17] counter: Implement *_component_id sysfs
 attributes
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <0e04a9e6455faf171e5dd7885676e55b5321b1ea.1625471640.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <bd0313ce-22fa-0516-93a1-ff3a5cb1fdd1@lechnology.com>
Date:   Sat, 10 Jul 2021 12:06:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0e04a9e6455faf171e5dd7885676e55b5321b1ea.1625471640.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/5/21 3:19 AM, William Breathitt Gray wrote:
> The Generic Counter chrdev interface expects users to supply component
> IDs in order to select extensions for requests. In order for users to
> know what component ID belongs to which extension this information must
> be exposed. The *_component_id attribute provides a way for users to
> discover what component ID belongs to which respective extension.
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++-
>   drivers/counter/counter-sysfs.c             | 30 ++++++++++++++++-----
>   2 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> index 9809d8a47431..e0e99adb0ecc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -203,12 +203,26 @@ Description:
>   		both edges:
>   			Any state transition.
>   
> +What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
>   What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
> +What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id

Could we just write a single line?

What:		/sys/bus/counter/devices/counterX/signalY/<component>_component_id

>   KernelVersion:	5.15
>   Contact:	linux-iio@vger.kernel.org
>   Description:
>   		Read-only attribute that indicates the component ID of the
> -		respective Synapse of Count Y for Signal Z.
> +		respective extension or Synapse.
>   
>   What:		/sys/bus/counter/devices/counterX/countY/spike_filter_ns
>   KernelVersion:	5.14
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> index bb49a10f160b..eb1505bfbd89 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c
> @@ -587,6 +587,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
>   	int err;
>   	struct counter_comp comp;
>   	size_t i;
> +	struct counter_comp *ext;
>   
>   	/* Create main Signal attribute */
>   	comp = counter_signal_comp;
> @@ -602,8 +603,13 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
>   
>   	/* Create an attribute for each extension */
>   	for (i = 0; i < signal->num_ext; i++) {
> -		err = counter_attr_create(dev, group, signal->ext + i, scope,
> -					  signal);
> +		ext = signal->ext + i;
> +
> +		err = counter_attr_create(dev, group, ext, scope, signal);
> +		if (err < 0)
> +			return err;
> +
> +		err = counter_comp_id_attr_create(dev, group, ext->name, i);
>   		if (err < 0)
>   			return err;
>   	}
> @@ -694,6 +700,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
>   	int err;
>   	struct counter_comp comp;
>   	size_t i;
> +	struct counter_comp *ext;
>   
>   	/* Create main Count attribute */
>   	comp = counter_count_comp;
> @@ -718,8 +725,13 @@ static int counter_count_attrs_create(struct counter_device *const counter,
>   
>   	/* Create an attribute for each extension */
>   	for (i = 0; i < count->num_ext; i++) {
> -		err = counter_attr_create(dev, group, count->ext + i, scope,
> -					  count);
> +		ext = count->ext + i;

		ext = &count->ext[i];

Could make it more clear we are dealing with pointers rather than integers.

> +
> +		err = counter_attr_create(dev, group, ext, scope, count);
> +		if (err < 0)
> +			return err;
> +
> +		err = counter_comp_id_attr_create(dev, group, ext->name, i);
>   		if (err < 0)
>   			return err;
>   	}
> @@ -783,6 +795,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
>   	struct device *const dev = &counter->dev;
>   	int err;
>   	size_t i;
> +	struct counter_comp *ext;
>   
>   	/* Add Signals sysfs attributes */
>   	err = counter_sysfs_signals_add(counter, group);
> @@ -815,8 +828,13 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
>   
>   	/* Create an attribute for each extension */
>   	for (i = 0; i < counter->num_ext; i++) {
> -		err = counter_attr_create(dev, group, counter->ext + i, scope,
> -					  NULL);
> +		ext = counter->ext + i;

ditto

> +
> +		err = counter_attr_create(dev, group, ext, scope, NULL);
> +		if (err < 0)
> +			return err;
> +
> +		err = counter_comp_id_attr_create(dev, group, ext->name, i);
>   		if (err < 0)
>   			return err;
>   	}
> 

