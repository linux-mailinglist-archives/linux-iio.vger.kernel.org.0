Return-Path: <linux-iio+bounces-10513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F099B557
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC5F1F228E0
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A61925A8;
	Sat, 12 Oct 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMShh00Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F681E481;
	Sat, 12 Oct 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742315; cv=none; b=G7DuGY0FXISUtsTk4O+geH6feI+Wx7HrmZ/4SJwQ3fFZwPH75MJrLUK5I2ZuKCnK8R25TSp+HcNNkUDkmWsiDRPpRCp00I/o8g4SooJQ3AgZkWb3Qz+/1MKLn2TFNAF4/w860TyNzj+HdIVi4CBcn4IxUD4QktrhQl1G5zxVhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742315; c=relaxed/simple;
	bh=JJmVD95mi9UZD5zEzeQNiy9tp+Bk7gw4BLSwv44/Zww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD71Iddhs0nycRNKAffySBY7sBhVClsvIbBrG27e6D9p82Lbq0ik8IahYDokxG7X6lzRt9fysO9A/8l3vZDtcFatiAhMGOAPr8gcOQjgy6TtQFJrcoPbAtEp0oem/z+45/x9PXU6MdENHRL5tXXAtd3n/wk/EBqWAbuP/MvBkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMShh00Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78096C4CEC6;
	Sat, 12 Oct 2024 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742314;
	bh=JJmVD95mi9UZD5zEzeQNiy9tp+Bk7gw4BLSwv44/Zww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMShh00YU55ALa1BXqIDW4WEdiUyNA8ESpwXWRr+S0/4d13gjaSeD/R8v2t8iOxCm
	 uWxx0thxieS/FJSw98zw0BmWV4Q5zC2IXYqStz3eDlk3iztYADAbLcwprLBGFQuq9S
	 aIRXfkKI9erlO8hNxPhRoorS94JXilGnI1CkqsWBzKd8QeDDXXthCYoen5VIDvknFO
	 NmW78O958AVm/f42874o5ciMBGTowIOwAY42TVt5i/tjXY0zPDOWxxy/wlfD2BUq4F
	 tpZGC6jbEx6Tf1CV84w7OMkUuL/kJjoqc7epA2Zq312pA4UN44bZgcwBz9oVCgB7ft
	 HzxHgVL2MFEIw==
Date: Sat, 12 Oct 2024 15:11:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: light: veml6030: add support for veml7700
Message-ID: <20241012151146.3cd5464b@jic23-huawei>
In-Reply-To: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
References: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Oct 2024 22:36:35 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds support for the veml7700 ALS sensor, which is basically
> a vem6030 within a different package, with no pins for the interrupt and
> the I2C address. The changes introduced are meant to hide the event
> functionality in that case, while borrowing the rest from the veml6030.
> 
> In theory, the interrupt functionality would still be available as all
> the registers are the same, and some polling could be done to read the
> threshold indicators to generate events. I did not find examples in iio
> where the INIT_DELAYED_WORK() queue_delayed_work() mechanism is used for
> that (some drivers do it to read results), so I am not sure if that
> would be the desired approach. I am open for discussions about that, but
> probably to be applied later on.
> 
> While testing this "no_irq" device, I noticed that the veml6035 is still
> using dedicated structs for the iio_info, which were there to account
> for the device-specific attribute values before read_avail() was
> introduced in the driver in later versions of the patch series, and they
> managed to survive until v3 was applied.
> Once read_avail() was introduced, the device-specific structs were not
> required anymore, and they are repetitive. Moreover, the initialization
> of the no_irq iio_info for the veml6035 was not updated to account for
> the new read_avail(), which is a bug if no irq is provided, as there is
> no callback to retrieve the available values.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Series applied to the to togreg branch of iio.git. Pushed out as testing for 
0-day to take a first look at it.

Jonathan

> ---
> Javier Carrasco (3):
>       iio: light: veml6035: fix read_avail in no_irq case for veml6035
>       dt-bindings: iio: light: veml6030: add veml7700
>       iio: light: veml6030: add support for veml7700
> 
>  .../bindings/iio/light/vishay,veml6030.yaml        |  16 ++-
>  drivers/iio/light/veml6030.c                       | 130 ++++++++++++++-------
>  2 files changed, 106 insertions(+), 40 deletions(-)
> ---
> base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> change-id: 20241007-veml7700-83f54cf94262
> 
> Best regards,


