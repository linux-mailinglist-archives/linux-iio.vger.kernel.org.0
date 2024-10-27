Return-Path: <linux-iio+bounces-11372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38269B1C90
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE971F218EB
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91787558BC;
	Sun, 27 Oct 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lncoz8Ik"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48771CA5A;
	Sun, 27 Oct 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730019652; cv=none; b=dhKxySJ9cBFlAa2teQyPDA6k+f79V7HWYgCf7z3IDSC95ykCDa8/nJpVA7wRn9Bhd6JBy1Xo7+rJeaGRybhq8BZwvtgiWmr0WHJtrEFHSz5PplC9W/Y3/cVe+SBrwHq5wMuk3t0qCByxYsJia0JUh/y9/E+Ly+LSfq7NNc4xyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730019652; c=relaxed/simple;
	bh=TP5q4TPV0efyvcZ61NS9u4MC3kSo24Qws5zpXGj5VdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn8AbHeRMYuKwHBDdojY+NRZFn+iETUFUlS2hG/C/5L1TGSutTGitHBMsCXODfuUOGoUZmodEM8srIbayxma9lgCZR81aJaw9C2Tj3xz4kGeWlrd528+AQPVxHA3r8sUlARnO5PA1KQ5CqlF44i9M03/5kcIfHizA7C47zkfWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lncoz8Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6BCC4CEC3;
	Sun, 27 Oct 2024 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730019651;
	bh=TP5q4TPV0efyvcZ61NS9u4MC3kSo24Qws5zpXGj5VdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lncoz8IkVfpPsqSxOUUKd03JtnD1pRrGwjbsUoD/xOxiCJI7XMc8AXCmqPKUGfEQG
	 ublEQKfrkwBEIU5+EQvPkfJ6ZWHLyijFW4Rs1Rh1k+4JwkgoZRDR0ZXwxMomnxZ9OV
	 CA1Zj9IZ1GdvFe3JJGYTXaStFYXcOk2vU2Fderd7m1HgMICDb0CAmp/RzW8cRHxjJW
	 4mgcxB5g2nuN7AUdT3MA0+3VshZYr3B6qLCVx9VT0Ciw8IE2dx+GIUaszP9pzO90yN
	 NgsH3SMRsd1WzNNnnyqO/SWOejK1vPh1A7ISeix8/ipQwT7Dm30+1OFRshLMGvsMjX
	 GZNXEl8R4eW/w==
Date: Sun, 27 Oct 2024 09:00:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: magnetometer: add support for the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Message-ID: <20241027090046.63c50599@jic23-huawei>
In-Reply-To: <20241026182643.1e6057e5@jic23-huawei>
References: <20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org>
	<20241026182643.1e6057e5@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 18:26:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 21 Oct 2024 14:38:52 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
> > The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
> > mainly used in 3D sensing applications for head-on motion.
> > 
> > The device is configured over I2C, and as part of the Sensor
> > data the temperature core is also provided.
> > 
> > While the device provides an IRQ gpio, it depends on a configuration
> > programmed into the internal EEPROM, thus only the default mode
> > is supported and buffered input via trigger is also supported
> > to allow streaming values with the same sensing timestamp.
> > 
> > The device can be configured with different sensitivities in factory,
> > but the sensitivity value used to calculate value into the Gauss
> > unit is not available from registers, thus the sensitivity is
> > provided by the compatible/device-id string which is based
> > on the part number as described in the datasheet page 2.
> >     
> > The datasheet is available on the product website at [1].
> > 
> > [1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
> > 
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>  
> Nice work. Applied to the togreg branch of iio.git and pushed out as testing
> to let 0-day take a first look at it.
And dropped again so you can respond to Andy's feedback.

Thanks,

Jonathan
> 
> Thanks,
> 
> Jonathan
> 


