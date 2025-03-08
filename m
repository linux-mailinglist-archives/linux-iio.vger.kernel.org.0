Return-Path: <linux-iio+bounces-16550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C0AA57A96
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3573B2C8E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1DA1CAA94;
	Sat,  8 Mar 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw4YZquG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1C158A13;
	Sat,  8 Mar 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441287; cv=none; b=VdG+03b731+sfo2PZo3hmgYvxpAP+DEGJ3opNDT0P9geHjpe8KTJ+XU4aJhcQFvPA3J9/8G+xZiVsjPFyoE7kC6sw/LV6ojcInGWsqBi79kJIawcgBnZkdKFk351jbhIro6nt1VIRfgGLh6ezLQJarEfrVb6+N0d7vVkoeaepV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441287; c=relaxed/simple;
	bh=4NHDFlsc8FG2y36EOTQ/Y40HsfXXBpBLZPan5YHNSzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3ng2mq6mQKGrs2mhR5OdBBWVBnKatlk1+hFKnJBq+kNXTZBGNGtzoo253pn83TzIXcoFRKAF6iolkmFpuz2wMbLxaXSn8qlh8gk6tqp3zxrNwGQvBbPMZYw5tJCXnx25ZU4aTAaZsV7E8v3erIfwPgxwCvD/yTJusMKuZNM2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw4YZquG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CE2C4CEE0;
	Sat,  8 Mar 2025 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741441286;
	bh=4NHDFlsc8FG2y36EOTQ/Y40HsfXXBpBLZPan5YHNSzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bw4YZquGCyDn/lQZjSGo9ADHwvZdYKsoGkhrzO9G3tHe+qV32IdRkUvSYXZi3hu1s
	 27g1/sZT7vAiTXtRbTJ9UXs1U2qHuNM4wefFtsREK4NyvGdyLDp3puDAK7qxyIvsS4
	 wWlR9X9Izxs19UUSuQ42jyzG4a+NwrisL2/QMWWS4L9vas4vxUIZyhYFAv4IaMzXvE
	 QjxwvsMeHf7675956XY2nYR7hXnlNZw8R0AEgbm86FMWYs+HwTT8p4K1iLVSsJb8ff
	 RpfxxssGX/s1K5TW61Uuce9VUs5Nm46wdnyZir7ZfNZK5QrO5CYW73FMzMfgPmIEal
	 q9O2VP+XwOukg==
Date: Sat, 8 Mar 2025 13:41:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v4 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
Message-ID: <20250308134114.093a1ed4@jic23-huawei>
In-Reply-To: <efdbddad734021f38a43cc9d101a22424e71dcef.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<efdbddad734021f38a43cc9d101a22424e71dcef.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 18:03:13 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The AD7768-1 has the ability to control other local hardware (such as gain
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
> 
> Add direct mode conditional locks in the gpio callbacks to prevent register
> access when the device is in buffered mode.
> 
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
More iio_device_claim_direct() conversions to make in here.
That's just a bit of unlucky timing vs that series getting merged.

Jonathan

