Return-Path: <linux-iio+bounces-7800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8EB93949B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A11C216E0
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 20:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47551CAAC;
	Mon, 22 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqh7P3D+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86717BD5;
	Mon, 22 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678844; cv=none; b=sXjUIBcn07y3joz3rdhiAbAoA1HZbnSoU8QQNOTJWSWXQMN6bhI/QQk58qwPR9OTw5F42tQeINEMztxkUS2MUXAxmY/B43dvVxr1gG9Fk7bBIcER1G59ZVKwau0fvvK459xSrvtFiCM1nBitZJ41NgstC8bSO6pT2mcsscWHKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678844; c=relaxed/simple;
	bh=kraaCRPRs6itOqlil/PUf/b33ue4X1ut9QGclpKorW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKCT5CkYqvIXsVFnGvppcdKnzvzfIYomLC5TwMVQswr7gU9yFMpHKSZrKFKoWfzYSjpjr7J3YreWs4RoOWUJrYmXSSH0Oxz0d612+hEdp91tiCgCw9HB884NjIJ7NN8rVj5FPxCCtqivcWBMGA3iA5vrTZjgy5trYPY7/Dmrui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqh7P3D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB932C116B1;
	Mon, 22 Jul 2024 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721678844;
	bh=kraaCRPRs6itOqlil/PUf/b33ue4X1ut9QGclpKorW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqh7P3D+sM193fxeGY6bEuMudt4D75N7f6tpTppaFk8oqYPoVF+6iAE/2kmGVUat3
	 nxoLmy7e+003BbPO0tU62+AzK0pfU3LrHyibmgH4ScgORB1hhAgRN0DsEe38o/K5Va
	 QtjCyeH1slEQVt/ckCl6yoY3v7IijfyMoN4zO2qWR2iSclUSUBOmRCBj3rR5YvpK84
	 cdnnF0gh0HElWcmqK5YWtN7cb0w7sVRvvRrQoJyR3PrDhei5nN9r8cH3l8HraXM6lq
	 MSRlgg3perOeet6Wj8hcqcSrXkigWoiQ/DpPWONqUn4jeRDbFe8TEIzKRZFEzj5Dm6
	 YzUwhFnH+/saQ==
Date: Mon, 22 Jul 2024 21:07:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marius Cristea <marius.cristea@microchip.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: ABI: generalize shunt_resistor attribute
Message-ID: <20240722210716.09ca4223@jic23-huawei>
In-Reply-To: <20240722-iio-pac1921-v3-2-05dc9916cb33@gmail.com>
References: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
	<20240722-iio-pac1921-v3-2-05dc9916cb33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 12:03:19 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Move ABI documentation for custom shunt resistor attributes into the
> generic iio documentation file. Exception for pac1934: leave it
> untouched since it does not comply with common iio ABI generalization.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
This stands on it's own even if the driver needs a minor tweak or two yet.
Hence in the interests of not having to remember I've read it before,
I've queued this patch up;


Applied to the testing branch of iio.git. That will be rebased on rc1 once
available and pushed out as togreg for linux-next to pick it up.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio             |  8 ++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 | 17 -----------------
>  Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc  |  9 ---------
>  3 files changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 7cee78ad4108..935d67fd1a43 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2289,3 +2289,11 @@ KernelVersion:	6.7
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		List of available timeout value for tap gesture confirmation.
> +
> +What:		/sys/.../iio:deviceX/in_shunt_resistor
> +What:		/sys/.../iio:deviceX/in_current_shunt_resistor
> +What:		/sys/.../iio:deviceX/in_power_shunt_resistor
> +KernelVersion:	6.10
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value of current sense resistor in Ohms.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> deleted file mode 100644
> index 6d2d2b094941..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/in_power_shunt_resistor
> -Date:		March 2017
> -KernelVersion:	4.12
> -Contact:	linux-iio@vger.kernel.org
> -Description: 	The value of the shunt resistor used to compute power drain on
> -                common input voltage pin (RS+). In Ohms.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/in_current_shunt_resistor
> -Date:		March 2017
> -KernelVersion:	4.12
> -Contact:	linux-iio@vger.kernel.org
> -Description: 	The value of the shunt resistor used to compute current flowing
> -                between RS+ and RS- voltage sense inputs. In Ohms.
> -
> -These attributes describe a single physical component, exposed as two distinct
> -attributes as it is used to calculate two different values: power load and
> -current flowing between RS+ and RS- inputs.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc b/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
> index 8916f7ec6507..8dbca113112d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
> @@ -13,12 +13,3 @@ Description:
>  		available for reading data. However, samples can be occasionally skipped
>  		or repeated, depending on the beat between the capture and conversion
>  		rates.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
> -Date:		December 2015
> -KernelVersion:	4.4
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		The value of the shunt resistor may be known only at runtime fom an
> -		eeprom content read by a client application. This attribute allows to
> -		set its value in ohms.
> 


