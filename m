Return-Path: <linux-iio+bounces-26235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31309C60906
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D7352465
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0661A301030;
	Sat, 15 Nov 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL3HK0iH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED832D77F7;
	Sat, 15 Nov 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763226744; cv=none; b=tTfecqVdhRppLrvuB8mab1l41EgLeL+gIzfgYPxqcbSP/JGaKalN5PwmkWzqnqZMDeQ4AhKZpEApc+54Nw+GGlY0j6MfWCSWw0wsNiKhCvBag6qipzDwjAp7YHwo0AmmmIl7O26DU4lVJ5+AtWdEELRLIaHKOKuBHKxCTB4XT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763226744; c=relaxed/simple;
	bh=5j4/aYUCi2pGyCmWfgWOhOgjHxwvOVufrjBIhcVXRmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gN+IbmqoHE0bhO123bfM4aX22aTXnWsEQoSM9xFzZ9llXql7MI97tSB9zP1TU+rgkoZAM0hybRaM4QdfPvueeT7zzkQQiVlWtybKJN0FhZorrbr774Zem5+S9GU7gFtV4dhE6uEFGervPOn/1NYryIJkyu1VlCzZ4IrHTTQMOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL3HK0iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC41DC113D0;
	Sat, 15 Nov 2025 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763226744;
	bh=5j4/aYUCi2pGyCmWfgWOhOgjHxwvOVufrjBIhcVXRmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CL3HK0iHZQso0OJ3E19vujvzTmqhP8wCUCJ6UXdJ9KuiU30jemB/KCHUyApZEepEa
	 EQgS6C3LD9ClKEy3/2zxKJb4VW2jjjnfPJ9HBJ/HsQAnApkpoiLFRB/rbpH9Y61ovG
	 7ZHJyRwoBT5H9bqvIuKyCnLRSxobvbln9NecoRFKms76mY6y2KcR4ZAunfvFVqaQpD
	 hiBP7C+hMxai8utkMWFt/qAfFSJsdRQ8kK++zapDVhQNjGEzlOzlyFvw2+4XALYs59
	 lml9hXdTUyvZy+QLkaSE9uMQdewa/RKRY68Kl2BVru+6avFShigJeCC5XBttafAGe3
	 zy+WEPA6mjT1w==
Date: Sat, 15 Nov 2025 17:12:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 2/2] iio: accel: adxl380: add support for ADXL318 and
 ADXL319
Message-ID: <20251115171217.4f9d1d12@jic23-huawei>
In-Reply-To: <94f1c01bdaea81a1a5f14df6aa95bc2b209165e9.1763134751.git.Jonathan.Santos@analog.com>
References: <27fdb3b85015d29c01b804e7f1de5fa615cf9f5f.1763134751.git.Jonathan.Santos@analog.com>
	<94f1c01bdaea81a1a5f14df6aa95bc2b209165e9.1763134751.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 19:14:02 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The ADXL318 and ADXL319 are low noise density, low power, 3-axis
> accelerometers based on ADXL380 and ADXL382, respectively. The main
> difference between the new parts and the existing ones are the absence
> of interrupts and events like tap detection, activity/inactivity, and
> free-fall detection.
> 
> Other differences in the new parts are fewer power modes, basically
> allowing only idle and measurement modes, and the removal of the 12-bit
> SAR ADC path for the 3-axis signals (known as lower signal chain),
> being excluisive for the temperature sensor in the ADXL318/319.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

One tiny thing I'll tweak whilst applying.   Applied to the togreg
branch of iio.git which will go out initially as testing.

Thanks,

Jonathan



>  static const unsigned int adxl380_th_reg_high_addr[2] = {
>  	[ADXL380_ACTIVITY] = ADXL380_THRESH_ACT_H_REG,
>  	[ADXL380_INACTIVITY] = ADXL380_THRESH_INACT_H_REG,
> @@ -276,9 +243,14 @@ static int adxl380_set_measure_en(struct adxl380_state *st, bool en)
>  		if (ret)
>  			return ret;
>  
> -		/* Activity/ Inactivity detection available only in VLP/ULP mode */
> -		if (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
> -		    FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl))
> +		/*
> +		 * Activity/Inactivity detection available only in VLP/ULP
> +		 * mode and for devices that support low power modes. Otherwise
> +		 * go straight to measure mode (same bits as ADXL380_OP_MODE_HP).
> +		 */
> +		if (st->chip_info->has_low_power &&
> +		    (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
> +		    FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl)))

Looks like this is aligned one space before where it should be.

>  			op_mode = ADXL380_OP_MODE_VLP;


