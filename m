Return-Path: <linux-iio+bounces-20843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728BAE2F93
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256C5169AF8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C401DE8A4;
	Sun, 22 Jun 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZmWfT0C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEF7494;
	Sun, 22 Jun 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750592281; cv=none; b=bQhanTLT6SnJ8RujiwpNTx8TltSkX9n+7aekDp9HjN7G6fBkR2eUkGd8Ft1V4lZBpJwqaYnfwV7FyJIzs0/uhtAB7vSZ/yxdrXcykxugzC/CvW2Weekex7nHPqcl1czP2/RbIyXXG95sxLqix83r8/75fGHZKjYGfGspnmbHpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750592281; c=relaxed/simple;
	bh=EVhJHT4BylZuiCv4RkBjMQoFT1U+kck/kqVZcxToo4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvddCEKJC5jTjcrOYW+3MGp0YPOBoIQZSjJbjNvif1y1kbbifrbHPrh194dzLUgPw/afahJ1Pc3vpnF1n0ZrSE/fR602mfEzuDZXfroNQmBwWUvQsnkntPAk5t78OH6fqR1RBJ6oRF4SL0gnyIVI+G0McVymWLG8qWuVeAvu2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZmWfT0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC768C4CEE3;
	Sun, 22 Jun 2025 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750592280;
	bh=EVhJHT4BylZuiCv4RkBjMQoFT1U+kck/kqVZcxToo4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZmWfT0Ca9vRcd4BZesfyAfklg8czTZO78M4DSImpOR/ylw7Mr7TXbzDcDe/bhOOG
	 jB4qcEmKY1WmkH3kE4qtxWGjP3EcIfeh3S70TG+BTc0pN2trECdwksfpcqxxAs1/Y/
	 zkK+fhbGW4eJ9yRf2zG7pH/a3vvN5LW1IvyovUhBG+mQn+W5sg1mBmZeqxUsrctc4U
	 KQjtneOiLMaTMDJQ7/woWVh3gAtmPDmFZVv/7lw+5YkNgg8gu0ZJLa7NMHYjrZpuiT
	 rjlzZTHbhy0UT/Ww3C2jblZLryFpYV/Bqe+eXezJoGb8ddffFycSjbp7beFqBwIst7
	 XidB66JHfWzpA==
Date: Sun, 22 Jun 2025 12:37:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] iio: accel: adxl313: add AC coupled
 activity/inactivity events
Message-ID: <20250622123752.1834fbe2@jic23-huawei>
In-Reply-To: <20250615222258.117771-8-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
	<20250615222258.117771-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Jun 2025 22:22:57 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce AC-coupled activity and inactivity as MAG_ADAPTIVE events.
> This adds a new set of threshold and duration configuration options,
> ensures proper handling of event disabling, and extends the use of the
> link bit to support complementary event configurations.
> 
> For example, either ACTIVITY or ACTIVITY_AC can be enabled, but only the
> most recently set configuration will remain active. Disabling ACTIVITY
> will have no effect if ACTIVITY_AC is currently enabled, as the event
> types must match (i.e., ACTIVITY_AC must be explicitly disabled). When
> either INACTIVITY or INACTIVITY_AC is enabled alongside an activity
> event, the link bit is set.
> 
> With the link bit and auto-sleep enabled, activity and inactivity events
> represent changes in the sensor's power-saving state and are only
> triggered upon actual state transitions. Since AC coupling uses separate
> bits for activity and inactivity, each can be configured independently.
> For instance, ACTIVITY can be linked with INACTIVITY_AC.
> 
> If one of the linked events is disabled, the link bit is cleared. In
> that case, the remaining event will no longer reflect a state transition
> but will instead trigger based on periodic inactivity or whenever the
> activity threshold is exceeded.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

One small suggestion below.

>  
>  static int adxl313_set_act_inact_linkbit(struct adxl313_data *data, bool en)
>  {
> -	int act_en, inact_en;
> +	int act_en, inact_en, act_ac_en, inact_ac_en;
>  
>  	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
>  	if (act_en < 0)
>  		return act_en;
>  
> +	act_ac_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY_AC);
> +	if (act_ac_en < 0)
> +		return act_ac_en;
> +
> +	act_en = act_en || act_ac_en;

All ends up a little confusing as act_en changes meaning as it is built
up.  Maybe better to just have act_dc_en in earlier patch then so
the boolean complexity all in one place?...

> +
>  	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
>  	if (inact_en < 0)
>  		return inact_en;
>  
> +	inact_ac_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY_AC);
> +	if (inact_ac_en < 0)
> +		return inact_ac_en;
> +
> +	inact_en = inact_en || inact_ac_en;
> +
>  	en = en && act_en && inact_en;

	en = en && (act_dc_en || act_ac_en) && (inact_dc_en || inact_ac_en);

>  
>  	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,



