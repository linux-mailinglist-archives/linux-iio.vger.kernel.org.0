Return-Path: <linux-iio+bounces-581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D238B8035BE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F7E1F21250
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9AE2575B;
	Mon,  4 Dec 2023 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRdfsI7H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3F249ED;
	Mon,  4 Dec 2023 13:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C17C433C8;
	Mon,  4 Dec 2023 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701698369;
	bh=isgD4mMOA0as7oH+Mok9vL3AUe3om/TUtSL0dMQF8Hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cRdfsI7HPmvTeIVhshhx/n3A3qJpRQDGNfx4oeukEGhwbZos3s8gZS8zs7s07PRrz
	 Nif1ILicVHf/NZ/I/51IgZ8vS+WtiYis2nMmH88Q4wtISsWgji3sZ830G8KPlqHqYk
	 cLmiVBaoaZMv0ohRy96S8zAnLwOjE0XKcztX7lR8KTKZNdFDPaNBi0C6IEQ3e02cUZ
	 PzWMjNlNe8U68gmu/eomcqJwe4VfOFr8triYokUwFeu2PF2u/NjJyn/B3OCESUbQzO
	 3Bq732g9oOobslralYhgH6VAPH9SLQk9vt4ash+tZwZoK8AqKyBU2shxhXYMCbBFBM
	 +tXcwCOnkUeUw==
Date: Mon, 4 Dec 2023 13:59:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/3] iio: light: add support for VEML6075 UVA and UVB
 light sensor
Message-ID: <20231204135920.16c7e826@jic23-huawei>
In-Reply-To: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
References: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 18:34:27 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds support for the Vishay VEML6075 ultraviolet sensor,
> which offers UVA and UVB measurement channels and I2C communication.
> 
> The device bindings and a simple example are also provided.
> 
> This driver has been tested with a Gravity VEML6075 UV Sensor Module in
> open air conditions.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

