Return-Path: <linux-iio+bounces-11729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016779B85BE
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C411C218E6
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCD81CC8B7;
	Thu, 31 Oct 2024 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7c2PhMQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266A1C8FD2;
	Thu, 31 Oct 2024 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411565; cv=none; b=Jd5hXapXwi8ESGIF+kiN/WetUV03NxEdg+xHC/ddyRpilPq2BuRpaYaqPzrX92nDATt6bUoxjorRQ2Ct3VqOrwgX9hZcEJvOIBENKeyuIwGkUHZCP1tbhMKgEjOH3A609hb2xScfKaAA6dr5X0qXXI5IE+sgr7vkXOrEOEnhi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411565; c=relaxed/simple;
	bh=S04zhds+KgkztO9Go6G1Kn6KUaaJUECBrILEMcartx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5eQjk1L8OGWm8AJp3hEm04cxCY7/KLx2prHiy6fvKrplIz5CSm/FUbmwcdFrVkdzgIeSGjw2xNG1vGj2pw7X/5jQk8EVwC+BeIV60/TbA/4rnnsfijTBBATonwM4dKtnM4pAAfhWHR+w16SeqUivGaqbdGBqGHz5WOZMlcZ+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7c2PhMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E7C4CEC3;
	Thu, 31 Oct 2024 21:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730411565;
	bh=S04zhds+KgkztO9Go6G1Kn6KUaaJUECBrILEMcartx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7c2PhMQcitNS0m812whJN1n1SkO4Fo5eIdjOho7r41AloxjupiqJhk+1gX7EzAP1
	 ep5x69pBZXAUVVRlmPm60s7Wq8NY2vk/McaVMxC41M9cXCj9xens3uIuAeM8UXNTdk
	 eHJ3kiqqyezzO/XY9NCEg5bmUiJ4Gk9FonFbg5vIq/T8hTQ2qUCo6v2faznk/qUPqI
	 S+WXI+TaWFVyn1Pmk7oQQKUrcSviKzn+Xku/NvAuw7fLL/hWvgbHjrDrmfrVWMPrqW
	 2ZBHPlFxOUW0ArrpWcco3BEwXXwdLgqNgqmrz7rodv7gVn4ZUZTV4TegXSJ9kyxP/A
	 XHGA4l1upfhUQ==
Date: Thu, 31 Oct 2024 21:52:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: light: veml6070: add integration time
Message-ID: <20241031215238.6ba6b98b@jic23-huawei>
In-Reply-To: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
References: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 00:09:56 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds a missing feature in the veml6070 driver to select the
> integration time, which also depends on an external restistor that has
> been added to the corresponding bindings.
> 
> The datasheet provides a Refresh time vs Rset graph (figure 7), which
> does not clearly specify the minimum and maximum values for Rset. The
> manufacuter has confirmed that no values under 75 kohms should be used
> to keep linearity, and the graph does not go beyond 1200 kohms, which is
> also the biggest Rset used in the application note. The default value of
> 270 kohms is the one currently used in the driver to calculate the UVI.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied and initially pushed out as testing for 0-day to take a look.

Thanks,

Jonathan

> ---
> Changes in v4:
> - Add vendor prefix to rset-ohms property (bindings and driver).
> - Drop default values for out-of-range rset and fail the probe instead.
> - Link to v3: https://lore.kernel.org/r/20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com
> 
> Changes in v3:
> - veml6075.yaml: simplify property handling (describe it completely at
>   the top and add block for the devices that do not support it).
> - veml6070.c: use int instead of u32 for the integration times.
> - veml6070.c: refactor default rset value assignment.
> - veml6070.c: drop comment about default Rset and IT.
> - veml6070.c: use units from units.h
> - Link to v2: https://lore.kernel.org/r/20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com
> 
> Changes in v2:
> - Rebase onto iio/testing and drop applied patches.
> - veml6075.yaml: use documented -ohms, top-level definition and
>   per-device restriction.
> - veml6075.yaml: add default value.
> - veml6075.yaml: fix typo in commit message.
> - veml6070.c: adjust rset property name and convert from ohms to kohms
>   to avoid overflows and work with the same units as in the datasheet.
> - veml6070.c: change default to 270 kohms (already used as default
>   value to calculate UVI).
> - veml6070.c: calculate UVI according to the current integration time.
> - veml6070.c: re-calculate measurement time (i.e. msleep()) with the
>   current integration time.
> - Link to v1: https://lore.kernel.org/r/20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com
> 
> ---
> Javier Carrasco (2):
>       dt-bindings: iio: light: veml6075: document vishay,rset-ohms
>       iio: light: veml6070: add support for integration time
> 
>  .../bindings/iio/light/vishay,veml6075.yaml        |  18 +++
>  drivers/iio/light/veml6070.c                       | 131 +++++++++++++++++++--
>  2 files changed, 141 insertions(+), 8 deletions(-)
> ---
> base-commit: e2687d0723257db5025a4cf8cefbd80bed1e2681
> change-id: 20241014-veml6070-integration-time-78daf4eaad2f
> 
> Best regards,


