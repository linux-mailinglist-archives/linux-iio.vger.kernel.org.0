Return-Path: <linux-iio+bounces-21529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEEB00076
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 13:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444714837FE
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14529C352;
	Thu, 10 Jul 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEBUgTqK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785A29ACEE;
	Thu, 10 Jul 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146536; cv=none; b=Z46Ye3lK8IPkRR3QQKn/nT6QSAf8CzLzcEEtl2GV6ksg9lMmNF3YCsqNoBTGweG2/E4qsX5kjwscdUO1KwAdskWXT7zNYmo7Df1jSLUswJzfbz+mJBxuKzzbtt3kGHj9O5EdPyGRSIG9Cm9TgX07XUW+m72//q/Ly3CbUnAtryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146536; c=relaxed/simple;
	bh=FO1OCNrq6w735NJWEpXhsPUksW6u1+YSWEZEvqgzblw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8WOA2TzV15cozOAQt56IVJQTyz2SGuZI0qlhl2eCvGhjfOfEdyHExOzlg3aky1nVnsnURnB2CaRibWNKLbzlpKd/GwhbUSIROnqyIsHWWyalDlVyUAJfZh1IpGpd5wQDxO5A0asuWRiNeyqsZj3oMvy7lfkFd/hHc6tpqx9MJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEBUgTqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5026C4CEE3;
	Thu, 10 Jul 2025 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752146535;
	bh=FO1OCNrq6w735NJWEpXhsPUksW6u1+YSWEZEvqgzblw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEBUgTqK5FsHJbbli1kLU6kCReCBYxmxDLzUtsHhyEcHly/o0I9ntYjbBPbdKlU3y
	 BEPrgzxj0Ea6Kj8AN1W5Jj96n9eUeGF4UEXvD9w+dQwig3y0kCIeGDXKpsvvXeJjp4
	 JyUa8VVGGuspSAmUTe2jlcd2YGdCkZ9YZg4wLZwwXQv0Hty8r6PVIubIKVaN9LhPGz
	 bRUAdB8gSMAZeGHwZYdTuivHaBVSkHY3ThQYhEnaGY6JyhRuYAgOFPJYv3fm1g5wML
	 7wYa2KD2BXFAu3FBwBXQqj5IjPQTREOwHIuKnW7sqh1d4r5fn8JkkxpdIZmgAf5XqM
	 Fm7j6ckGZg7vw==
Date: Thu, 10 Jul 2025 12:22:08 +0100
From: Simon Horman <horms@kernel.org>
To: y.oudjana@protonmail.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/4] QRTR bus and Qualcomm Sensor Manager IIO drivers
Message-ID: <20250710112208.GR721198@horms.kernel.org>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>

On Thu, Jul 10, 2025 at 09:06:26AM +0100, Yassine Oudjana via B4 Relay wrote:
> Sensor Manager is a QMI service available on several Qualcomm SoCs which
> exposes available sensors and allows for getting data from them. This
> service is provided by either:
> 
> - SSC (Snapdragon Sensor Core): Also known as SLPI (Sensor Low Power
>   Island). Has its own set of pins and peripherals to which sensors are
>   connected. These peripherals are generally inaccessible from the AP,
>   meaning sensors need to be operated exclusively through SSC. The only
>   known SoCs in this category are MSM8996 and MSM8998 (and their
>   derivatives).
> - ADSP (Audio DSP): Shares pins and peripherals with the AP. At least on
>   some devices, these pins could be configured as GPIOs which allows the AP
>   to access sensors by bit-banging their interfaces. Some SoCs in this
>   category are SDM630/660, MSM8953, MSM8974 and MSM8226.
> 
> Before Sensor Manager becomes accessible, another service known as Sensor
> Registry needs to be provided by the AP. The remote processor that provides
> Sensor Manager will then request data from it, and once that process is
> done, will expose several services including Sensor Manager.
> 
> This series adds a kernel driver for the Sensor Manager service, exposing
> sensors accessible through it as IIO devices. To facilitate probing of this
>  driver, QRTR is turned into a bus, with services being exposed as devices.
> Once the Sensor Manager service becomes available, the kernel attaches its
> device to the driver added in this series. This allows for dynamic probing
> of Sensor Manager without the need for static DT bindings, which would also
> not be ideal because they would be describing software rather than
> hardware. Sensor Manager is given as a working example of the QRTR bus.
> Kernel drivers for other services may also be able to benefit from this
> change.

...

Hi Yassine,

This series both adds an IIO driver and updates Networking code.

I'd suggest splitting the series so that the Networking updates can be
targeted at net-next, while the IIO driver is targeted at a different tree.

Also, I note that this series does not compile against current net-next.
This seems like it should be addressed, at least for the Networking
changes.

-- 
pw-bot: changes-requested

