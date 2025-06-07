Return-Path: <linux-iio+bounces-20297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F309AD0E49
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17C43B065B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06711EF389;
	Sat,  7 Jun 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvqU0NtL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB414EC5B;
	Sat,  7 Jun 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311704; cv=none; b=ZDyBj7XNDg31WngUXAmRht3bKJednlwi4r97jG5dUEe+CZiAmkDDJPWy1HWLi11QuUOxowOu9QHndU7pwfsiaWW6m49Xex5+K/kRnuWzVGULFh0mAlmpJ6jwr7Uq+cCuPaxY1VgkXgmBrFhYddwYYlH+MoHRbngQedzpLp4BVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311704; c=relaxed/simple;
	bh=H8+ldFDAJXy/+SmjSpm+HxUKlQFuAhpqeic+7vEpHjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpbgKwJ4j45O9nE6OAwSJglv9ms37RVRTHDGI0XhQaTMqSmNml9cTN9hbO3BdbYM+mS7OaGv9FynBIM9e8rwZfgDFNhHhwjyGgFPRPOLGMBFcICV8rn4lv+3DpGDDD1bzBgFstQEUXXDNKuvNSOq9Vghn08jsq12v2y/2MEeTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvqU0NtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3DAC4CEEE;
	Sat,  7 Jun 2025 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749311703;
	bh=H8+ldFDAJXy/+SmjSpm+HxUKlQFuAhpqeic+7vEpHjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BvqU0NtLcp8SXMQdn8quk1affj7ZYyPoCqIeOUIsXKqo5MfvxqWkxlY9zYq6c8nX4
	 mtMGec4X15TqPFCcIAD2GyJ9A6DazXUBfkbneB+L1qzSLDA6A/u5Dlm2+9TogY+Rli
	 LgqczcNeiBV4tNexznrBsNcvuELoF75Qo6hNUY3qt3iXxYkddbEYYRlm9R4uciu/Th
	 lNP882d3sdp8AxwueQqcWXqX6xDbzvDAgtgxSn43CwEP2VoO+a24hc4N8SRPzMa1JZ
	 jyTztd34ASMRUfr8b2kA+Ur4XLFHbtB+FCVDaFojZEbRm+zSxe9RqkIA+4K6CiX/xa
	 ssazjJ0OD2VbA==
Date: Sat, 7 Jun 2025 16:54:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: imu: bmi270: add step counter watermark
 event
Message-ID: <20250607165457.3e886c62@jic23-huawei>
In-Reply-To: <20250605-bmi270-events-v2-2-8b2c07d0c213@gmail.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
	<20250605-bmi270-events-v2-2-8b2c07d0c213@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Jun 2025 19:05:02 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Add support for generating events when the step counter reaches the
> configurable watermark.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Trivial stuff inline given you are going to be doing a v3.



> +
> +static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
> +{
> +	int ret, reg;
> +
> +	guard(mutex)(&data->mutex);
> +	if (!data->steps_enabled)
> +		return -EINVAL;
> +
> +	reg = bmi270_int_map_reg(data->irq_pin);
> +	if (reg < 0)
> +		return reg;
> +
> +	ret = regmap_update_bits(data->regmap, reg,
> +				 BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
> +				 FIELD_PREP(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
> +					    state));
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return regmap_update_bits()
and save a couple of lines.

> +}


> +static const struct iio_event_spec bmi270_step_wtrmrk_event = {
> +	.type = IIO_EV_TYPE_CHANGE,
> +	.dir = IIO_EV_DIR_NONE,
> +	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> +			       BIT(IIO_EV_INFO_VALUE),

Could put those on one line as it's under 80 chars (just!)


> +};

