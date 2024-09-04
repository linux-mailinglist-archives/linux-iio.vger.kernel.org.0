Return-Path: <linux-iio+bounces-9114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D796B15B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 08:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2264BB2629C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99CC12C489;
	Wed,  4 Sep 2024 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUZjIZWk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99D3D6B;
	Wed,  4 Sep 2024 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430590; cv=none; b=qVEblmFjNYuc+830HcUj9tezvCT1pRz4/ZGQ2AM1rcrGIq5PpmdN0OKl6LaPC05JntPF0HgyvwSCHqMfbVhsiWQ7Gg3cN5vOLxhG0sU5Pi+/s9Ai7ptqtPOBqoYoLnJS0K0+SU0VZP3yPXbYY7SPQLz4maBN4N+KUdiwTr5xRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430590; c=relaxed/simple;
	bh=YbIPMLh3rIWjc+gxMHP7B5n5k2gZOyWWwegpaNGup5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl2CDfIFfU0wryCqcxbN8GXWduGFHk2Vnc8FSSZ8I/gs2mV+Gg0+5yOA1uBMpVVsqW1GReDKV8jExiQRJg1e+vWouLPNWz4HT8EBRngkT6iu1Zq8WtHeZ2Ej/ZzDceKQs8P7EEIVQaksb0Cm2EpM2sBapZit/GZQURNrF+Eayno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUZjIZWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4713EC4CEC2;
	Wed,  4 Sep 2024 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725430590;
	bh=YbIPMLh3rIWjc+gxMHP7B5n5k2gZOyWWwegpaNGup5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUZjIZWkA8FaJG/HZqybk8K/5KrrLOpJqeHOFN+MrVCfPyX1dXDU6bMcPN8iyByBn
	 hmbHx0drZcF1u6zvMp/gKPlj8tct+YKrFO+q37REH3+YAY+jGvjklSsAwlyyJVanAo
	 kNERoyveIJbvAfe3Wtz0Yl3ut9Rt1SE0W8bDL1dcGuqO631Le2GjYAjsYfolP7PEi+
	 qm1T5aWPbtkrssCOcqv1yjt8cCvk5U3/EEvuHsIqehO62SiH7TWpYg/hTyA+T+CfXU
	 1hKiCXQYhyphNZMkCIzN30KPnvhbNu+C2bJiQdy6ARoTpHHS2R13ph4jWqcqXBtN6m
	 r4k4m3GSve41w==
Date: Wed, 4 Sep 2024 08:16:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 0/2] Add support to AD8460 Waveform Generator DAC
Message-ID: <36nd2cbka2oeht73eadgsftpq6uq2de4ip4qddh46zo6fuwppn@ok7topfbmsys>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904023040.23352-1-Mariel.Tinaco@analog.com>

On Wed, Sep 04, 2024 at 10:30:38AM +0800, Mariel Tinaco wrote:
> Apply comments for adding support to AD8460 Waveform Generator DAC
> 
> ad8460:
>   * Fixed errors detected by test bot
>   * Applied proper masking of fixed values
>   * Applied proper wrapping to get close to 80 chars
>   * Applied proper comment formatting
>   * Applied proper placement of breaks in switch cases
>   * Removed channel properties unused by IIO buffer interface
>   * Simplified property getting on probe function
>   * Fixed error handlings on probe function
>   * Fixed setting of overvoltage, overcurrent and overtemperature ranges;
>     If value provided is invalid, default state of the register will not
>     be rewritten
> 
> Bindings:
>   * Dropped unnecessary descriptions
>   * Updated property descriptions to describe functionality properly
>   * Added multiple selection of values for adi,range-microvolt property
>   * Fixed formatting errors to follow DTS coding style
>   * Lifted GPIO naming from gpio-consumer-common yaml

This all happened in v3? Or v2? Please write accurate changelogs.

Best regards,
Krzysztof


