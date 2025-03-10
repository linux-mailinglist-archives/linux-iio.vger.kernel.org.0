Return-Path: <linux-iio+bounces-16693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AABA5A429
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4C53AE4A8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774A1DE2BB;
	Mon, 10 Mar 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni5UW5QE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03B15B971;
	Mon, 10 Mar 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636600; cv=none; b=h5YSTH0IcCJo9Xk7c67EvzpLSXgWQZ+ZTgVUONEZ085t7lGEtZSFWxwUZT9RGc4cnxTOH9n/7ECM09xwoIkK7EaA5Omx1ikFb5L0psl+AkR+iyTJkGMXzGm3ZBIKss0s94sHyfLkLMDbeep6sgOuBb6usL8dcmZU9b3LZkViVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636600; c=relaxed/simple;
	bh=Y/JTlBFAFa1kW02I57Oghnn1ZRacr1Bw8QsU9Lkbrkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFAJXCPfVYKFVwnSTm6Vcdyqh24fjA5tvOXOS9XfiVKO+kWFmKlgrC0b3HDXhZPwx5/TPCdLxgfYxcuL33s9l4Nlu2zyiYP0ieLxr+YQyXVYxVuI/D9UVAsw5WOSImvZQTAsLtFUZif0QS03OMIIPZXTZjUM8HfKA/mXMwJncTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni5UW5QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18390C4CEE5;
	Mon, 10 Mar 2025 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741636600;
	bh=Y/JTlBFAFa1kW02I57Oghnn1ZRacr1Bw8QsU9Lkbrkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ni5UW5QE/wJqGaWtOifwbYBgjJrPRPiOLjkCnvYtLzLaJaqgYT8caHEDNgZxoCBPF
	 XYnAwO1x0jLY342/IazQVSuMbePJgXIE2l4TwMt64ow4qeRhWDQYfvbw6v5rBgYHB0
	 iYjKI+N5yUn6pGEL6dt205RGG/CUuUo0akqylW1qilC0aaQQho8oP/d4WExnzYa+Ei
	 V8bJf2hVcXu1Dzz7QuzBsITNHKHLFWysK31snHwfnrWWBC780kkzhoqo/mTztNP14d
	 zUgwAzAaaa+xAGCeYwY/oXQfMJW/9yW4F7zuhcHSo+orJL11N4p2reHWlsPvev4vfr
	 QKW5ccCfz/Oaw==
Date: Mon, 10 Mar 2025 19:56:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <gastmaier@gmail.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Message-ID: <20250310195629.47ca023f@jic23-huawei>
In-Reply-To: <6ca1eafd-276d-421b-8d35-bd3e363803d1@baylibre.com>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
	<20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
	<CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
	<e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
	<6ca1eafd-276d-421b-8d35-bd3e363803d1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 09:31:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/9/25 3:49 PM, Jorge Marques wrote:
> >>> +.. list-table:: Driver attributes
> >>> +   :header-rows: 1
> >>> +
> >>> +   * - Attribute
> >>> +     - Description
> >>> +   * - ``in_voltage0_raw``
> >>> +     - Raw ADC voltage value
> >>> +   * - ``in_voltage0_oversampling_ratio``
> >>> +     - Enable the device's burst averaging mode to over sample using
> >>> +       the internal sample rate.
> >>> +   * - ``in_voltage0_oversampling_ratio_available``
> >>> +     - List of available oversampling values. Value 0 disable the burst
> >>> +       averaging mode.
> >>> +   * - ``sample_rate``
> >>> +     - Device internal sample rate used in the burst averaging mode.
> >>> +   * - ``sample_rate_available``
> >>> +     - List of available sample rates.  
> >>
> >> Why not using the standard sampling_frequency[_available] attributes?  
> > Because sampling_frequency is the sampling frequency for the pwm trigger
> > during buffer readings.
> > sample_rate is the internal device clock used during monitor and burst
> > averaging modes.  
> 
> I haven't done a chips with a monitor mode yet where we aren't reading
> the samples, so hopefully Jonathan will chime in here on the usual way
> to handle that.
> 
> For the burst averaging mode, I understand the need for a separate attribute
> now. I would suggest to call this the conversion_frequency rather than
> sampling_rate since IIO already defines "sampling" to be the data read
> from the chip to Linux even if it is an averaged value, it still counts
> as one sample.

I should have read on.  I'd like this more closely associated with oversampling.
As per other reply we use sampling_frequency in the events directory for
the monitoring frequency case.  One of our very first drivers did this
(max1363) so it's been in the ABI a long time!

Jonathan


