Return-Path: <linux-iio+bounces-15604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E5A3765D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFB93AFA18
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D519D08F;
	Sun, 16 Feb 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlxhGKPO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020E42070;
	Sun, 16 Feb 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727800; cv=none; b=s/cAzxsnlry2NRulViolOo+BG0wqB5FRur6I9YtR/LQ6Syx9pM++uuZ28grxY1GZUwo6rdPqzG2/zIR3kXiLewKfCazSzm8DQ2YEvA+p/k9eL3C73v3D8HVGXSHrI7cRVwaf7aLa+EwVETawWWsB84Z3W8EgUETVIG7XuFouAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727800; c=relaxed/simple;
	bh=w61Gb7//eBdfhCfK8mPTPyHmToQaDceO9T6CpCx0Vv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdDYLtCd/dlPKJKZFu8o737sOlw+Id8Wu9M5fxXym+Nnx32bob0309hBVEyV0nIo8JjWgciCmaO+1OBL1hsSjUQs++cg+npoefT9e7DkcJSVCU4+YHJEM54RxcLgrrfOTmM8OK8+gX5Wx+Mklf27SvPGKcbIF+p5JUpJbpvJfl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlxhGKPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508E6C4CEDD;
	Sun, 16 Feb 2025 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739727799;
	bh=w61Gb7//eBdfhCfK8mPTPyHmToQaDceO9T6CpCx0Vv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nlxhGKPOqINO+/gPp1aMCJY8bE6CxcJU5b2s9SoKjMkEhQoMbgtMdZdbNveVmN0Bp
	 3D46XEubv2kUe6npX7MzRBFs/4E4k4OxuppEwO7aRCHcOQ8hg9tsy06lAQnXMteAc5
	 CQHnrRfx6r3pZU5QmVsrSC2whgRnMvC/UWVi54c9njAR0rbfFO6/0PYZk0pNCP6qnz
	 Nl9xK8QDmDEaFA1Dg4wbTyVHog+g0eT2clQGZ4E3/S1njXH7+DlttS8BuB6KDu+Tqe
	 pds5A6bWgADwR2qFF/VkBuvr3JSUzQ8vLgTS8n2OLonOIlXMFDrGabgku/vdgEaRHg
	 3vFmSfjpCDuTg==
Date: Sun, 16 Feb 2025 17:43:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 11/14] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250216174312.2424443a@jic23-huawei>
In-Reply-To: <20250210110119.260858-12-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:16 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make the sensor detect and issue interrupts at activity. Activity
> events are configured by a threshold.
> 
> Activity, together with ODR and range setting are preparing a setup
> together with inactivity coming in a follow up patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 172 ++++++++++++++++++++++++++++++-
>  1 file changed, 171 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index ea7bfe193d31..16dea2a222d9 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -35,6 +35,7 @@
>  
>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
> +#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
>  
>  enum adxl345_axis {
>  	ADXL345_Z_EN = BIT(0),
> @@ -67,6 +68,23 @@ static const unsigned int adxl345_tap_time_reg[3] = {
>  	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
>  };
>  
> +/* activity/inactivity */
> +enum adxl345_activity_type {
> +	ADXL345_ACTIVITY,
> +};
> +
> +static const unsigned int adxl345_act_int_reg[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
As before [] for these to avoid having to set to 1 here and
update in next patch.

> +};
> +
> +static const unsigned int adxl345_act_thresh_reg[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
> +};
> +
> +static const unsigned int adxl345_act_axis_msk[2] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
> +};

> +
> +static int adxl345_set_act_inact_en(struct adxl345_state *st,
> +				    enum adxl345_activity_type type, bool cmd_en)
> +{
> +	bool axis_en, en = false;
> +	int ret;
> +
> +	ret = adxl345_write_act_axis(st, type, cmd_en);
> +	if (ret)
> +		return ret;
> +
> +	if (type == ADXL345_ACTIVITY) {
> +		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
> +		en = axis_en && st->act_threshold > 0;
> +	}
> +
> +	en ? __set_bit(ilog2(adxl345_act_int_reg[type]), (unsigned long *)&st->int_map)
> +		: __clear_bit(ilog2(adxl345_act_int_reg[type]), (unsigned long *)&st->int_map);

Similar comment to earlier on __set_bit()



