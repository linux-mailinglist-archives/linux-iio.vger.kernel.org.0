Return-Path: <linux-iio+bounces-16239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09787A4B170
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339177A2BFE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA81DF728;
	Sun,  2 Mar 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej+sD8iO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEF1B424F;
	Sun,  2 Mar 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917846; cv=none; b=gh15qLzyZRlSMA6C3j8WwuU+E7x3Jmo0kBVvcnC9YKr8UyeEZufm2vxI7o/uok8MML8u+FHiBYCTwMgG4lXGsyxJ2v4dzC65OS8R0OKu9hMfaDKe4cNyGLDs9YXDDTDgfv/YHlnRgR7UesSSiFa2ccjbWlNzDM/qNiJNmUbaaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917846; c=relaxed/simple;
	bh=FR6q2kZ41RkvmAkXZ4BwOb8OgzNJSqk9qKzcUYznR38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUr5jP02qVWcQ3D/vU8saVwVHUUThLzXDBiL1SvWBMvrMUsGcMba0z3MkglZ5PKXzC+BaCNilEroqU3S8lJhP71tptqvUW5kV9xJnrYWUZbOpqwdqQtPQlIwBs8f0zz+kNySTR6um9PQJnZcmQZlN5LTEiFkMDJhP22xCYNo+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej+sD8iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1967C4CED6;
	Sun,  2 Mar 2025 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740917845;
	bh=FR6q2kZ41RkvmAkXZ4BwOb8OgzNJSqk9qKzcUYznR38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ej+sD8iOKNPpZgL01ZCRNpyW6JaN+BsYNNBFu4Cw+Vg4GdUXDU+QWyGQITvuwY2rd
	 azb3i7KinVobN+DtwC5G9bAY0wT3XrpSWdEH5Dzu7jkmoIkglFM0GRkopVujUvpaUA
	 ku57WPpcSHYoWIIeO3Ir08V7AD5Fau4pZbLGq5swdBRFUzXck+zMDiXhzJT2LvTpsW
	 OopCEtmqNjkEoI8WKWlCm7vRgBAJ4q1MRFLoUYMOJNzTafcutK91H0T3PA4gSy5rBq
	 S4yzEbtvl5UrBnIs6o+BcCA5UEbqndeJCpHt1NS1KEEF+HCHcMozb1lqRAdUaU68RT
	 b2UWMxjnXC4tg==
Date: Sun, 2 Mar 2025 12:17:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 08/15] iio: accel: adxl345: add double tap suppress
 bit
Message-ID: <20250302121714.7708d220@jic23-huawei>
In-Reply-To: <20250220104234.40958-9-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:27 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Set the suppress bit feature to the double tap detection, whenever
> double tap is enabled.
> 
> Any tap event is defined by a rising signal edge above threshold, i.e.
> duration time starts counting; and the falling edge under threshold
> within duration time, i.e. then the tap event is issued. This means
> duration is used individually for each tap event.
> 
> For double tap detection after a single tap, a latency time needs to be
> specified. Usually tap events, i.e. spikes above and returning below
> threshold will be ignored within latency. After latency, the window
> time starts counting for a second tap detection which has to happen
> within a duration time.
> 
> If the suppress bit is not set, spikes within latency time are ignored.
> Setting the suppress bit will invalidate the double tap function. The
> sensor will thus be able to save the window time for double tap
> detection, and follow a more strict definition of what signal qualifies
> for a double tap.
> 
> In a summary having the suppress bit set, fewer signal spikes will be
> considered as double taps. This is an optional add on to double tap,
> thus a separate patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index c014bdf84e66..10cd81dd08bb 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -34,6 +34,7 @@
>  #define ADXL345_INT2			1
>  
>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
> +#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  
>  enum adxl345_axis {
>  	ADXL345_Z_EN = BIT(0),
> @@ -258,6 +259,18 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
>  
>  static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
>  {
> +	int ret;
> +
> +	/*
> +	 * generally suppress detection of spikes during the latency period as
Local style has large comments as sentences so capital letter at start and a full stop
at the end preferred.

> +	 * double taps here, this is fully optional for double tap detection
> +	 */
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
> +				 ADXL345_REG_TAP_SUPPRESS_MSK,
> +				 en ? ADXL345_TAP_SUPPRESS : 0x00);
> +	if (ret)
> +		return ret;
> +
>  	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
>  }
>  


