Return-Path: <linux-iio+bounces-677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDAF8076D4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5AC281DD7
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374A6AB82;
	Wed,  6 Dec 2023 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5aspjRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4D364B2
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 17:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B16C433C7;
	Wed,  6 Dec 2023 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701884700;
	bh=c62MJPU3LWesp61kfHoQtJ5bG1ANKAKahi1+gxMsJV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5aspjRw8Rlvjs6c8+jncK8NtSzup0/O7zTHTEAcEW7txJRfe7N3ZVtH25fAxZzbm
	 MU/UMbiPazp94YUGyQ+aD7SEYumme4Mh2ugMWV35CBHSU3NX4Jk1IQbq+o/ehvH5AN
	 t3BHTtnsgb6osvj/I4EaP9PYeCtEeBvuhStznsvgzRY1fKFzvq4TgZ/WQIDTtLmWyE
	 fHPPz9HT7xX5tWRUC821Ea61pxviclEJ0fHva85aGhQQxwQ+kFQD2bfAAv3aUuvLyf
	 Oc3ok0HxFAtY4zbEdCJcXbqFlpNNxv5nNrv/r3Rfeot82vkdZGAGR40jz6XPkWQy8e
	 o+zUmTOI+lVsQ==
Date: Wed, 6 Dec 2023 17:44:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Andreas Klinger <ak@it-klinger.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v7 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series
Message-ID: <20231206174451.301b1cd2@jic23-huawei>
In-Reply-To: <20231204194401.20891-2-petre.rodan@subdimension.ro>
References: <20231204194401.20891-1-petre.rodan@subdimension.ro>
	<20231204194401.20891-2-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 21:43:59 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.
> 
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
One trivial comment from me to add to what Andy covered.

> +/*
/**
Looks to be valid kernel-doc. Might as well mark it as such.


> + * hsc_measurement_is_valid() - validate last conversion via status bits
> + * @data: structure containing instantiated sensor data
> + * Return: true only if both status bits are zero
> + *
> + * the two MSB from the first transfered byte contain a status code
> + *   00 - normal operation, valid data
> + *   01 - device in factory programming mode
> + *   10 - stale data
> + *   11 - diagnostic condition
> + */


