Return-Path: <linux-iio+bounces-27619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156BD0F623
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54EFF3041A44
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191AB34BA5A;
	Sun, 11 Jan 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q62C+WOo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF656883F;
	Sun, 11 Jan 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768147028; cv=none; b=Q+30qA/ipHHFsOiTuN0XwNdyKTmc4Bfvh2GR8wSE4RUoHjpZhYBRbp9isk9S+HhPiZ4uu6p7Tyl44b5pHt1c9Mh/2lv1xUzMpxwmPnIy+6YWXLXTs8D6B21pkrgRj7UIwv2D8fTaIaVADmCfHK0LUA3lt/MLh6zbZNZcYlalN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768147028; c=relaxed/simple;
	bh=4Yc+CaJAix/ejrKYfOL37fJ1nWaZU1jqbqvmNxJKQnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTvBnVzbWa7xBuIN2ow9FTvqz3I3a/Qu/cQefzjVwZZDCjdCui3GAQbB5KcL3PLzdR/pedaZrAZhcv/45RkDPA39RzO1D+l02IJfKlVt70ftrEQ2qyrJQihKbf5eBohjJvenYwaYbg4rGpofChFkawyvbEAJiMVvacLoO+69jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q62C+WOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374A6C4CEF7;
	Sun, 11 Jan 2026 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768147028;
	bh=4Yc+CaJAix/ejrKYfOL37fJ1nWaZU1jqbqvmNxJKQnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q62C+WOo5gP/VBCfeYDZYdWMO06Wprr0nzVcFR5yPBfPKxMlEno/kECwirzii6uBQ
	 0qGLoLrMhtHYYhONP4KDY/yB7T2MvELEpQyTGJFBNpYQ7WtaP3++4Gzar36ZLPrTds
	 0ER+Ro5yYIhp5YGUc2gRjYNXfqqlMU10KQR1HSD68ro9vlVhVPreTTTf+fxDhPGgPp
	 13kyFU5iJ8i3te1KdRwjdtxnamB9UlnpnvA9NNCU54ARniqN+ScTQPem6+HAkj936f
	 vYERceN7+gD9cSanL8e2NgGnW8qodAGLvQWATRBJr+tM7Jxo0RTMUYGBv3N7HHL2lz
	 Ze3G49kZ1otcA==
Date: Sun, 11 Jan 2026 15:56:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Janani Sunil
 <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: Add MAX22007 DAC driver support
Message-ID: <20260111155658.64aa9577@jic23-huawei>
In-Reply-To: <098d6f0e-95f0-4a25-938b-eee3bb35c77a@gmail.com>
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
	<20260108-max22007-dev-v2-2-2506c738784f@analog.com>
	<aWEMqQed7OXZBLp3@debian-BULLSEYE-live-builder-AMD64>
	<098d6f0e-95f0-4a25-938b-eee3bb35c77a@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +		st->iio_chans[i++] = (struct iio_chan_spec) {
> >> +			.output = 1,
> >> +			.indexed = 1,
> >> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +					      BIT(IIO_CHAN_INFO_SCALE),
> >> +			.ext_info = max22007_ext_info,
> >> +			.channel = reg,
> >> +			.type = chan_type,
> >> +		};  
> > IMHO, this would look cleaner with a channel template. See ad7124, ad4130,
> > ad4170 for examples.  
> 
> A channel template approach was followed initially and this approach was taken up based on the latest suggestions from the reviewers, since the template is not being reused elsewhere.

FWIW I prefer this option when it is only used in one place.

Jonathan

