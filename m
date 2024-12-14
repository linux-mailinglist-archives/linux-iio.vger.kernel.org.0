Return-Path: <linux-iio+bounces-13459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26C9F1F39
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F85163828
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EBB192B75;
	Sat, 14 Dec 2024 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAsIehzk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D6653;
	Sat, 14 Dec 2024 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734185871; cv=none; b=VFyvwfEWW+qQKdywgKt689FepAhpGUcqgMVqyK5Fwuew2aazIDvmAXUsWmU/4fuL8mQ6v6v8q91WDltQXAk+KKpwHgBAg97jGLGv14lOs40smOu5tSB3Y2TEH/MFnR7W8556yLkU/RIlqLZBOmTTr7RlW5K4Fff4QcwTHbWjc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734185871; c=relaxed/simple;
	bh=QO3n4VP0ZVPU7aLYGFfEVVIxCLvXX1E3ymy4xvCKQ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZX2RUT8H9zCKf4bMATPi2vvJ8oncJ4dEVQ5dhhpllvTIYAD+zhOG0oI6hs4s40zbPCEtZUgaBGVZtyVaVmAOaXzVUo5iNjyhTnzLqUW5EAQ+bYpKe8kCMk4aKTWTv6XEpBjLnCzgN5kSLYUytkRhfdHZngDIuX3ATdMaABKcp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAsIehzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2385BC4CED1;
	Sat, 14 Dec 2024 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734185871;
	bh=QO3n4VP0ZVPU7aLYGFfEVVIxCLvXX1E3ymy4xvCKQ9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAsIehzkr7Vrpt+MWeba4fCvbWVgiUhrTq80W/iIq4Y4NUYiU2WUwZ87VFMQRA0XX
	 8kb4uYYM4v/CM4jvQteW8VEC945/P7NVUZ+y85SqkZ/elrxi3qx/L5aDFsAJPxndfU
	 KmrqCk/hnsbe0GuiYcc7xfGO7YW0zu/lUiIez9Ig/vxBRV9CZGgEOALMI9ey1Ulkx2
	 kX28OjeHFwmlNTk8Z7TI/lI78WR9W4BcfweyocmY97an5lkTIbYy5XKMspw42YjsbM
	 TuAGLh2IUh5BjtM8FJ7+dxJcoMXAcazCUMRZaorhauFiuopsXm8oYyb3AUgCQhgE+n
	 Eygv395A5BSIA==
Date: Sat, 14 Dec 2024 14:17:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Bjorn Andersson" <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey
 <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, Taniya
 Das <quic_tdas@quicinc.com>, "Jagadeesh Kona" <quic_jkona@quicinc.com>,
 <quic_kamalw@quicinc.com>, <quic_jprakash@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH RFC v2 3/5] thermal: qcom: Add support for MBG thermal
 monitoring
Message-ID: <20241214141737.1c3a305e@jic23-huawei>
In-Reply-To: <20241212-mbg-v2-support-v2-3-3249a4339b6e@quicinc.com>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
	<20241212-mbg-v2-support-v2-3-3249a4339b6e@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 21:41:22 +0530
Satya Priya Kakitapalli <quic_skakitap@quicinc.com> wrote:

> Add driver for the MBG thermal monitoring device. It monitors
> the die temperature, and when there is a level 1 upper threshold
> violation, it receives an interrupt over spmi. The driver reads
> the fault status register and notifies thermal accordingly.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Just a quick comment on consistency of formatting.

> +static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int low_temp,
> +						int temp)
> +{
> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
> +	int ret = 0;
> +
> +	guard(mutex)(&chip->lock);
> +
> +	/* The HW has a limitation that the trip set must be above 25C */
> +	if (temp > MBG_MIN_TRIP_TEMP && temp < MBG_MAX_SUPPORTED_TEMP) {
> +		regmap_set_bits(chip->map,
> +			chip->base + MBG_TEMP_MON2_MISC_CFG, MON2_UP_THRESH_EN);
> +		ret = regmap_write(chip->map, chip->base + MON2_LVL1_UP_THRESH,
> +						temp_to_vtemp(temp));
Alignment in this driver should be consistent / tidied up.

I'm not sure on style preferred in thermal, but I'd always default to align
after the opening bracket + wrap at 80 chars unless readability is hurt.


> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		dev_dbg(chip->dev, "Set trip b/w 25C and 160C\n");
> +		regmap_clear_bits(chip->map,
> +			chip->base + MBG_TEMP_MON2_MISC_CFG, MON2_UP_THRESH_EN);
> +	}




