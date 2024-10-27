Return-Path: <linux-iio+bounces-11390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F389B1D31
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F2C281E40
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D671384B3;
	Sun, 27 Oct 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siB7qZ7K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D64CB36;
	Sun, 27 Oct 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730024336; cv=none; b=XGrPugKPhHV0VB2RniT6GP5nPaZxZEo1lV6I6c7hfY8Kk/RbSEYpEPs9Ymw+VaWmKybfzZ5z8y1R0j81QwzYq4+LQ0iIyPeuCoyOuEGxaDfx3jmi/jmVEiWncpBdFWrAeB48XkuYbM65k+z23vKb/fmkUBkLkUndp2yzGJqHryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730024336; c=relaxed/simple;
	bh=DZAiTzzDfSKTYhX4YwUN8oAhhtxjZoB0/J5R9UOIc30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FteVL8RRR5cPueKKr1e/LRg6GKFCy3/MyDwxtfzx+/Fuh61VhbYtbF2v2iIKFwUoLpM+TMRcisUVx8B6dXV8Ls1HBA4WwPRvg+XqheZYxw7narqU8W16W1trlHTtBny3tLUt/vZhq1UwvQgCrmGQKKajIG+AfrfJNXPq29wGdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siB7qZ7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF32C4CEC3;
	Sun, 27 Oct 2024 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730024335;
	bh=DZAiTzzDfSKTYhX4YwUN8oAhhtxjZoB0/J5R9UOIc30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=siB7qZ7KcqAlFhPldSWGesfXRFwZfnwrUJB8vX5/XTV9jexU6TcKVoMmtkbNp6xHH
	 tQe6u3vSdAk+1ip3noOcKFz4aA8pGVkBL91LCyy7spO8AV+WimqEWNPgdVdSIC5Xt5
	 be59t8+LcK0dv63y62mogFDyljZyo029+NsURw8JgpCNX4viRSpLqhjCjAL2oQjMx2
	 UtSz1HZ3ujnicDFpo7hGcV9j5Ndh0HOD5h6pOflvf6d7OAin9SzDgfPru1734h4cAu
	 j/qsKEXtVTrhri8/Tgr5BrsDrltR9wWS/8vIzghtNCp2we1ZW40ej2Zt6U9dh86kC7
	 vQ6DLgmN2DmEg==
Date: Sun, 27 Oct 2024 10:18:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/13] iio: chemical: bme680: Add triggered buffer
 support
Message-ID: <20241027101847.0d386058@jic23-huawei>
In-Reply-To: <20241021195316.58911-10-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-10-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:12 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add triggered buffer and soft timestamp support. The available scan mask
> enables all the channels of the sensor in order to follow the operation of
> the sensor. The sensor basically starts to capture from all channels
> as long as it enters into FORCED mode.
> 
> The bulk read, reads a total of 15 registers from the sensor, 0x1D..0x2B.
> Even though some of those registers are not reported in the register map
> of the device, this is how the BME680 Sensor API [1] proposes to do it.
> This allows to have one bulk read instead of multiple ones.
> 
> Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1200
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
LGTM, but can't apply until patch 4 is sorted out.
So let's see this one in v3.

Jonathan

