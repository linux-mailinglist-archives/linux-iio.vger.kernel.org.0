Return-Path: <linux-iio+bounces-11804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C19B9626
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3B11C22465
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD21CC179;
	Fri,  1 Nov 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpzyazao"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66B1A2643;
	Fri,  1 Nov 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480388; cv=none; b=fikN+1FfRxd/UwEbYzBoY/U6oOo0Rz0JS9dSzO75HnpeAo7wHTZPyBnRYh4hXjsa69rU4RSf7xIiQMZFuwkhCG8mAHifELyROZ+2CHh46MHTwzJ15e1OYWhX8SRslmH22fjcLbmrIslV6ahICG7lbN+BP49SJO9m0XaewyvILRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480388; c=relaxed/simple;
	bh=uW1XYYinselZ61VFECQL01iyBgcUhCFlCa/9NjOdWjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hex4xh8ocWr5xyE4ckUYnZ67S4ejn+E38dr9msf7l5AlPIi1ODHP2xJCUuErC1Iq3kCL0k7qwoZQOx4oSoQQnjjXpXr/hvqNmUkTmpFH34PC6FYkNtqa3FZbLzDIgzvXkPTW9eN/fbWfZq/rmFbsmC3ZcRVPWSjSB78RNS2OMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpzyazao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C3AC4CECD;
	Fri,  1 Nov 2024 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730480387;
	bh=uW1XYYinselZ61VFECQL01iyBgcUhCFlCa/9NjOdWjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpzyazaoDPxbjWgFHiaoFYuOzrpFB3JIgpdSV74pfD+wHgQRk/j7pyqUZNdAZEoIE
	 IOiP9Che+SDxevNLwuxDpw86Ip0k7DU15t2zh7VAZAg+epO51Mnb8YvI5+827n9O+R
	 wrM1DoAq50T0GQVhvVKR3gM7bE3zZnqyCx/PwbiNitxKa8Zz+eZCWikAT5ZgbhpqKQ
	 2tUIVZhcf4m3SLDU5eMNVCPmliSe6a3JC09Jy3aAwqYJtkwqGB4Ug1XO+PWztRwYqs
	 1/t/ETwfns3QVdkHXesgAchpW3bXLgvtbil7nNlymIQmFqiNipmzlgs58weR7caJzu
	 2fouvGHGxL8HQ==
Date: Fri, 1 Nov 2024 16:59:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH v4 0/3] iio: magnetometer: add support for the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Message-ID: <20241101165940.5bc37b69@jic23-huawei>
In-Reply-To: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
References: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 16:30:21 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
> mainly used in 3D sensing applications for head-on motion.
> 
> The device is configured over I2C, and as part of the Sensor
> data the temperature core is also provided.
> 
> While the device provides an IRQ gpio, it depends on a configuration
> programmed into the internal EEPROM, thus only the default mode
> is supported and buffered input via trigger is also supported
> to allow streaming values with the same sensing timestamp.
> 
> The device can be configured with different sensitivities in factory,
> but the sensitivity value used to calculate value into the Gauss
> unit is not available from registers, thus the sensitivity is
> provided by the compatible/device-id string which is based
> on the part number as described in the datasheet page 2.
>     
> The datasheet is available on the product website at [1].
> 
> [1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Hi Neil,

Applied to the togreg branch of iio.git but initially pushed out as testing
to let 0-day have a little poke at it.

Thanks,

Jonathan

