Return-Path: <linux-iio+bounces-12574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A147D9D755A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 16:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB33B3B5E6
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D621CEE9F;
	Sun, 24 Nov 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/+hFmjU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF119DF66;
	Sun, 24 Nov 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732454360; cv=none; b=E/rfKqtrsCJj1cvQvqWvTJkXsmvlIWBucYEGZ7r2ZI40PAwAlskkA4+j11TqvW/S62VmbjQSHcmfAYc1N0GsQmDmgN8X3FzNR8CYFFuiaBFZu45MS6BC5/guANbbCZ4gHennSjvcayuvbnYJm8rDmhXMCm4Zb763R/TraobxOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732454360; c=relaxed/simple;
	bh=sxKZYASatDASe1lHjm2Qs/c1u8f+S06Fq0ta2VmTAho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuRXZqnbXRGcMfS1kj8kuzfBnnKHaysVoiTjX79vGBWy6pf+TywL3VOf/507LlXIP3h61i7P25xs1Z4651YOni7pVrXrGx/yWqE1JznQiuo9moAca6S3dK0oEVJux6p8bRrmab81sibovI4ZCqAA8Ukm0kpZH8/ityhhqjbPWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/+hFmjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D798EC4CECC;
	Sun, 24 Nov 2024 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732454359;
	bh=sxKZYASatDASe1lHjm2Qs/c1u8f+S06Fq0ta2VmTAho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l/+hFmjUzwg7qwsqmjXQmcRoyfDwGCabJlp4IAK+xur7gOb2XiTo9u7Hj/WCCFdQZ
	 Y22CHBfcnDiAiLpPWNNJqlBmJE7JvIVAjvvGeIZRi5UXoaxi562yD6gXSQj9WKKvBx
	 eLBTAuAKLCgoBdrk8xFreHVBGd7xQX/tnOvAOR5bNJ2vtx9LUFaxK7xEnchu1h4EMZ
	 2ISUOEjEGtGkqotTXGv8uNdB5Eg4F1GuekohXb+4rxmdiG0ybbay4PNt1pCWAUHBHS
	 x2JmFtur6/RXdntCgX+pGBSO81uBqUxVMaVcFvEyRBvqfGvHo3MPurhGJWrhz3ATDS
	 jeiGTom6udaJw==
Date: Sun, 24 Nov 2024 13:19:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 4/4] iio: adc: ad4000: Add support for PulSAR devices
Message-ID: <20241124131910.0b2a2d8d@jic23-huawei>
In-Reply-To: <d5f127acef28e02f1bd4af0d68bd06e75a98dfca.1732020224.git.marcelo.schmitt@analog.com>
References: <cover.1732020224.git.marcelo.schmitt@analog.com>
	<d5f127acef28e02f1bd4af0d68bd06e75a98dfca.1732020224.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 09:54:39 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ADI PulSAR series of single-channel devices comprises differential and
> pseudo-differential ADCs that don't require any input data from the host
> controller. By not requiring a data input line, PulSAR devices can operate
> with a 3-wire only data bus in some setups.
> 
> The AD4000 series and the single-channel PulSAR series of devices have
> similar SPI transfer specifications and wiring configurations.
> Single-channel PulSAR devices are slower than AD4000 and don't have a
> configuration register. That taken into account, single-channel PulSARs can
> be supported by the ad4000 driver without any increase in code complexity.
> 
> Extend the AD4000 driver to also support single-channel PulSAR devices.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
The series looks fine to be other than the remaining DT discussion.
Fingers crossed for v4 :)

Jonathan

