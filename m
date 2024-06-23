Return-Path: <linux-iio+bounces-6745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA34913A31
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A23280EA1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961317FAB7;
	Sun, 23 Jun 2024 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bok5LuwG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63F13D8B0;
	Sun, 23 Jun 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719143791; cv=none; b=QxJpOjO1sxcGf8kLth87bRDRx08r42GL85T6TBSo05GwWUSYZpjuU9JM3pw5CN3ntguqcqVpmJ9hm5fRCo2uNJSyXwfth5mKei+4+m1rmRdugENbLVjx7kzHQ2L4NLRAJsfJANzt1OHYnjQOpRfOY3auLRt7MpAO3diUvBcYlUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719143791; c=relaxed/simple;
	bh=uAE600xiIb96iQh6+8HJfPoX0sEcN+urA1yZyZSUwak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7qQXlTl86oVipiPoEMaFHo8/Ug4x9T5WCP+cP8Ey0DFlT0C4YFgymGhbYQvCv946lb8B0nzQ21DROdckJQRhl6mlOlAP9FEnrMk+4GYY7JlJec/6lDVyHVDzsKSTOXrwac/rbr38Cizxc0KPV4JA/pHFPl9FFy86vRja64iTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bok5LuwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D518C2BD10;
	Sun, 23 Jun 2024 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719143790;
	bh=uAE600xiIb96iQh6+8HJfPoX0sEcN+urA1yZyZSUwak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bok5LuwGFAuOhddobD0Tbr0GcIEaiE5Udl6xD7GL/9nvHYg0adQAMxTk3HzDGrfgQ
	 dcr50SNN7gbxh5bXiwtb204S/dkqCVA+zvAmii6DrTxW2UhQtwe0ZseToBZ/1+oY4i
	 yUUakUiu85WUSDRA2jgRbR7FIVPe6kLG1kAmgxf0bbPcj4VsXu1mUWILZbLIOPLLrV
	 A2Dd33VvislCEH1vV6KS7qmhWgC2dHSvz1HeVTRULwY+l3O+nqNyR83mZpPdH1A3kR
	 wBRgiRIlQSeBTAA61JHsH/jOUc4C7riWNIfVHx9VAgycpOfotQyW0sNfrjNM88ygKJ
	 /2dgeDW/OLOWg==
Date: Sun, 23 Jun 2024 12:56:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 yasin.lee.x@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
Message-ID: <20240623125621.07d1617c@jic23-huawei>
In-Reply-To: <20240621-add-tyhx-hx9023s-sensor-driver-v6-3-65196a9020f1@gmail.com>
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
	<20240621-add-tyhx-hx9023s-sensor-driver-v6-3-65196a9020f1@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 15:40:51 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> A SAR sensor from NanjingTianyihexin Electronics Ltd.
> 
> The device has the following entry points:
> 
> Usual frequency:
> - sampling_frequency
> 
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_raw
> - in_proximity4_raw
> and associated events in events/
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

Hi Yasin,

Some good reviews in already for this version, so I only took a quick look
this time. It seems to be in a reasonable state now.

Jonathan

> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> new file mode 100644
> index 000000000000..1d8cb9a05d8a
> --- /dev/null
> +++ b/drivers/iio/proximity/hx9023s.c
>
> +struct hx9023s_data {
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	unsigned long chan_prox_stat;
> +	unsigned long chan_read;
> +	unsigned long chan_event;
> +	unsigned long ch_en_stat;
> +	unsigned long chan_in_use;
> +	unsigned int prox_state_reg;
> +	bool trigger_enabled;
> +
> +	struct {
> +		__le16 channels[HX9023S_CH_NUM];
> +		s64 ts __aligned(8);
> +	} buffer;
> +
> +	struct mutex mutex;

Add a comment explaining the data this mutex is protecting
(that may be in this structure, or for example on the device)

> +	struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];
> +};


> +
> +static int hx9023s_sample(struct hx9023s_data *data)
> +{
...
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +		value = sign_extend32(value, 15);
> +		data->ch_data[i].lp = 0;
> +		data->ch_data[i].diff = 0;
> +		if (data->ch_data[i].sel_lp == true)
> +			data->ch_data[i].lp = value;
> +		if (data->ch_data[i].sel_diff == true)
> 
Run checkpatch.pl --strict and it will probably moan about these.
if (data->ch_data[i].sel_diff) is the same thing so just use that.


