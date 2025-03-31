Return-Path: <linux-iio+bounces-17414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D7A76430
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4D33AA80A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9B1DF973;
	Mon, 31 Mar 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlkuEdmW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D331953A1;
	Mon, 31 Mar 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416926; cv=none; b=eHSFl4xOTynSlXiCEjdbEPURXk2t7zRwp47PvUe/ZaeDzqrylOTAYsfSwVmMqM3m0dwJQoZRJmSqxwUhlvPlqCDLbCWplDiWbioU8hnqZyql//GZNv0ISM8oIWqZvLFzdESNAP6x5vTl3+je3jroGTHsD3TKSJf5mWrqGqi6u+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416926; c=relaxed/simple;
	bh=GrUb+KIIUHkvSDrm6TVkfQkGcwFu1AfF56FtxXXZ7oA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JauX0jerY7DStdXcnN/60AqvQY0Oj1ILfFNyQPp8IVukYoAQOYuP3SWNKfe3H0JNqKGBeNa7U53aYHiqbI3NryD2KAiEsDWKYvctooyTqIuqK7eUI3akcHVn0WX7KgoT2bHTPKBrKCEkfpyZSEZI7FpjgD+V1ucgw4qRZwagOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlkuEdmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4971DC4CEE3;
	Mon, 31 Mar 2025 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416925;
	bh=GrUb+KIIUHkvSDrm6TVkfQkGcwFu1AfF56FtxXXZ7oA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XlkuEdmWRRSQLE3xjk10F+TNYSW3bjmZSL3fgQqmqsX0c+2fWM6Ml8x8I25dmpvpW
	 7g+QTg61PZBYFCGI2awbqCy3tRErg742QvL5HFSiln8H8I6KFIvR4winBjR0eZ3x16
	 cUPVw+tKj3zQ7YP9xuQ9cGo6N1HpxmtT/puDcXBAWo//Iz5tH9IMWhl6OvEyGwqNeM
	 gGke50WVvD/RfjY5pNhh3N7pq/Gtadw6eQSLMefG0RZB85RafGrowPncJxrha6lkpW
	 NtniuEjOhksjmtv83r5FzbyRvszrK1f+XGC06O4yWtQy5FrV3hIaoBI25EjPMKseJ4
	 wC+aksPGzoShw==
Date: Mon, 31 Mar 2025 11:28:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 05/11] iio: accel: adxl345: add freefall feature
Message-ID: <20250331112839.78c2bc71@jic23-huawei>
In-Reply-To: <20250318230843.76068-6-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 23:08:37 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the freefall detection of the sensor together with a threshold and
> time parameter. A freefall event is detected if the measuring signal
> falls below the threshold.
> 
> Introduce a freefall threshold stored in regmap cache, and a freefall
> time, having the scaled time value stored as a member variable in the
> state instance.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

Apologies for the slow review!  Just catching up after travel
and I did it reverse order.

> +
> +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> +{
> +	unsigned int regval, ff_threshold;
> +	const unsigned int freefall_mask = 0x02;

Where did this mask come from?   Feels like it should be a define
(just use ADXL345_INT_FREE_FALL probably)
or if not that at lest use BIT(1) to make it clear it's a bit rather
than the number 2.

> +	bool en;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_threshold);
> +	if (ret)
> +		return ret;
> +
> +	en = cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> +
> +	regval = en ? ADXL345_INT_FREE_FALL : 0x00;
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> +				  freefall_mask, regval);
> +}

Jonathan

