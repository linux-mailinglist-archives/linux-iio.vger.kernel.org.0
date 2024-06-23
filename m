Return-Path: <linux-iio+bounces-6750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8D913AAB
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD87428193A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAB181322;
	Sun, 23 Jun 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOsCOiij"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228E12FF7B;
	Sun, 23 Jun 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719146805; cv=none; b=IykSKBtfyzKrGlcXdy7SaM5X67omW7hKlc4y6niSLPm9+vdMPGTqRWXbUO5GrKEf6uxfRHzI9M7R0W9NO0fuPYM1FM22idSB4zH3wVR4wJbFjHvD/6XxbALyyer+qwoZYQjp4mhVuk2CVZw72Qyb3o7JtSyxAbZsX53WxTHDv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719146805; c=relaxed/simple;
	bh=DMWLHkxTqyALf1Cf5us9V7DYOoKrsleUvYt76jR37S8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNSC5FcqrPQJmzvxeC/OD/CnLhjPzASFZRrF9n4gq0KW5XrYDM4b8nMNMj+JzT5S7Xbsw54iDYcjdljLkKm/Hjit+jtamiKvgd1pjcKF9S97C6x4JMRk0+7bEBiDx6YnnIeNeAspaOGlOZtDmEA9jO55bUl6ARFklL+VKneJn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOsCOiij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CEEC2BD10;
	Sun, 23 Jun 2024 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719146805;
	bh=DMWLHkxTqyALf1Cf5us9V7DYOoKrsleUvYt76jR37S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hOsCOiijC/Bfah6vEP8gUJOn42wkVkRG6+HoIk6o+V16ziLEN7l9d9IYXRIOD8NmH
	 wjIFRHPrpa99uP1Req6ANCqTndWGWhrfklLMgbZ+V/UNd/idWiPDQwKNs5TkQo5MmD
	 +9yIkV/WfYZuIQqxf/LzGncvby36sINuUUg3yvPenEmzVea6XMrnLnDVBQhLPsz9aw
	 /H5+u2IOG1RooeI7yos8bzVrbm3ZxkZiJxwQ9hDvhfH1YpEcp1ue7OeNLndiM4xiP3
	 6ajhttY1LhX35Sm/gk91KA52r017BktQ3IKrtHTO/IXSMxzseckwtRN7tozuFWzjcv
	 gCbRpR9Adorzg==
Date: Sun, 23 Jun 2024 13:46:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Maksim Kiselev <bigunclemax@gmail.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Marius Cristea
 <marius.cristea@microchip.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Okan Sahin <okan.sahin@analog.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, Liam Beguin
 <liambeguin@gmail.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <20240623134633.15f793be@jic23-huawei>
In-Reply-To: <20240619122301.22737-2-ramona.nechita@analog.com>
References: <20240619122301.22737-1-ramona.nechita@analog.com>
	<20240619122301.22737-2-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 15:22:43 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> The filter mode / filter type property is used for ad4130
> and ad7779 drivers, therefore the ABI doc file for ad4130
> was removed, merging both of them in the sysfs-bus-iio
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio       |  7 +++
>  .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 46 -------------------
>  2 files changed, 7 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2e6d5ebfd3c7..c808ec9c4a81 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2225,6 +2225,13 @@ Description:
>  		An example format is 16-bytes, 2-digits-per-byte, HEX-string
>  		representing the sensor unique ID number.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible filter modes.
Even though it is not generalized an a given device might not provide each option, we still
need to let those writing userspace software know what they might get.
So Include the options, but skip the frequency specific details etc.

For things like the pf ones, just say + device specific post filter X

If the details are necessary we do allow a device specific entry in the main
docs.  I think there are a few existing ones though not sure they've
made it to the top level doc rather than one of the device type specific ones.



> +
>  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
>  KernelVersion:	6.6
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> deleted file mode 100644
> index f24ed6687e90..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> -KernelVersion:  6.2
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Reading returns a list with the possible filter modes.
> -
> -		  * "sinc4"       - Sinc 4. Excellent noise performance. Long
> -                    1st conversion time. No natural 50/60Hz rejection.
> -
> -		  * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
> -		    time.
> -
> -		  * "sinc3"	      - Sinc3. Moderate 1st conversion time.
> -		    Good noise performance.
> -
> -		  * "sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling
> -		    frequency of 50Hz, achieves simultaneous 50Hz and 60Hz
> -		    rejection.
> -
> -		  * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
> -		    time. Best used with a sampling frequency of at least
> -		    216.19Hz.
> -
> -		  * "sinc3+pf1"   - Sinc3 + Post Filter 1. 53dB rejection @
> -		    50Hz, 58dB rejection @ 60Hz.
> -
> -		  * "sinc3+pf2"   - Sinc3 + Post Filter 2. 70dB rejection @
> -		    50Hz, 70dB rejection @ 60Hz.
> -
> -		  * "sinc3+pf3"   - Sinc3 + Post Filter 3. 99dB rejection @
> -		    50Hz, 103dB rejection @ 60Hz.
> -
> -		  * "sinc3+pf4"   - Sinc3 + Post Filter 4. 103dB rejection @
> -		    50Hz, 109dB rejection @ 60Hz.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> -KernelVersion:  6.2
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Set the filter mode of the differential channel. When the filter
> -		mode changes, the in_voltageY-voltageZ_sampling_frequency and
> -		in_voltageY-voltageZ_sampling_frequency_available attributes
> -		might also change to accommodate the new filter mode.
> -		If the current sampling frequency is out of range for the new
> -		filter mode, the sampling frequency will be changed to the
> -		closest valid one.


