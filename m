Return-Path: <linux-iio+bounces-11360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635B19B1A0F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D9E281D09
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D71714B4;
	Sat, 26 Oct 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQwC9XFc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237B81732;
	Sat, 26 Oct 2024 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729963642; cv=none; b=qp8d3eSrI8W42JpNxetLuQ7jsnqbLDfl2dVGfZ/B3050j/RDmDJeq3fyJZ76ddORNfXZ3RuUEBmxI1PqxBDF7/VeM4UMqjG+ElICiDNPECbnPL8rThCVz++cW5ImAap3Jhgf/jb6ucL7lqkg/zaVCDVqYMPaSlMKg6hOQtipBn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729963642; c=relaxed/simple;
	bh=jZRias5RVKKNYt0/mTffjvcTSnIKR1gVsDGJpVQK20g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxjQLTCMlW7kJdw3Oh0AuwsodrpVjns4l/uzhI4SutIdbB7IbpuRpX0xNEPFqXqWcZFLrnJn6HgpqY/RDasaDNymiRthkindG9bksRhxysnT1vi3I3Eq+oFxZQRC2No/38Rjk4x5LN4w6rz2wUg4yFlU+NB5Ad51l2NEb/2KhDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQwC9XFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D271C4CEC6;
	Sat, 26 Oct 2024 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729963641;
	bh=jZRias5RVKKNYt0/mTffjvcTSnIKR1gVsDGJpVQK20g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQwC9XFcBGUv/dvTzl9WAKyQ6m35n6PYaGnS8Mi6ZiUD18ltJoYQg0LxTObIyJalD
	 K4dRDXZjTa0tqwC6qzOpORF8Y/Zqf9Zknqilgz8Eb202EVCfYynFxso/eA4qs33egp
	 KnbGOlbEIOIpAg8LnPXrpTpj6ME+A4h7UqHLYi1KRr8J6/GE7ouGA3heT8qPprvR1L
	 dVnwrDb76UGsg0KCdCGnRfc3TvL/HFkAp4V9J+cj3Gn0ItbI5eCOFzvSGF3wvWqePB
	 g08NsqNPenzQkzcosqXK0k+hPaLoVKK3D1AhLVHD//vSxkCpXolkeuwNdAcx0T7XpY
	 JMOwwE38fyKDg==
Date: Sat, 26 Oct 2024 18:26:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: magnetometer: add support for the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Message-ID: <20241026182643.1e6057e5@jic23-huawei>
In-Reply-To: <20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org>
References: <20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 14:38:52 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
> mainly used in 3D sensing applications for head-on motion.
> 
> The device is configured over I2C, and as part of the Sensor
> data the temperature core is also provided.
> 
> While the device provides an IRQ gpio, it depends on a configuration
> programmed into the internal EEPROM, thus only the default mode
> is supported and buffered input via trigger is also supported
> to allow streaming values with the same sensing timestamp.
> 
> The device can be configured with different sensitivities in factory,
> but the sensitivity value used to calculate value into the Gauss
> unit is not available from registers, thus the sensitivity is
> provided by the compatible/device-id string which is based
> on the part number as described in the datasheet page 2.
>     
> The datasheet is available on the product website at [1].
> 
> [1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Nice work. Applied to the togreg branch of iio.git and pushed out as testing
to let 0-day take a first look at it.

Thanks,

Jonathan

