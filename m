Return-Path: <linux-iio+bounces-11381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1D9B1CFB
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E135D1F221B3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68939126C16;
	Sun, 27 Oct 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhOsz2rN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21103AD51;
	Sun, 27 Oct 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022823; cv=none; b=dQgvoH6POl7ok3hcKES0IZuQefvGJhZ4hpkqixbIgB7lzidyIaaZ7XZjHlVnS3mraiM3wX3L8wEbPEAoyzAdjbC/oTw3FKPMbtTSQTI6SU1TIdBSXbSjRHmuCH6vB6SVYKJsFd1ArJI4o15Hiet7KIpL6Nded5xuyr6G74LL858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022823; c=relaxed/simple;
	bh=GaoOS/yew5+t+aedZ47Jm1YV/Hg6vI1S1LmM1zMo3As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqtCFDRat/c/wMmdQpQc93s0gHa/h9oV35+OG0EwNQ8xDnPOj/bDNqng41V9N0hUwSFtDVheiiXSHHsXTGiV1ps0OSvzPu6aZ/aqihp5bA7RcnSfV68fTST7m15h/6HzE7CyADkraFQQDrIy5OHGa5zEmfTagCkIrM1cf8vR3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhOsz2rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA76C4CEE4;
	Sun, 27 Oct 2024 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730022822;
	bh=GaoOS/yew5+t+aedZ47Jm1YV/Hg6vI1S1LmM1zMo3As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhOsz2rNog3QYCgGn/ME1PIWq5AwrQxQHt2SWP/IY7Xd+QKwUhXNYs9O1xp9SDHiz
	 M7mhV8csmYfHziNCP0jDbIEmprl91Ki3jMbaYLvSNDuKuyI6NPIv12G3mnxNfoG/eR
	 3qdgnpfa8FUQo7ffgqt41WdIHJiFAL08VfT5L9NWHIe0XhIRRCva+mkpda+djqOtdK
	 w8YHmFfxtHPxIZ4tb7D+FGivDLZSSdLAW5cG5QD9U8FsoBl9t+zYHh1Y6LgNNHnwls
	 NOPRyTl/ti27VW/vHoYKwGRwlKOTTf+IGUKUDM9aT6bJffZC1g7BXQNWgBmEQ0djo8
	 s+cwZX0x81YDw==
Date: Sun, 27 Oct 2024 09:53:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] iio: chemical: bme680: optimize startup time
Message-ID: <20241027095335.1fdd4cdf@jic23-huawei>
In-Reply-To: <20241021195316.58911-3-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:05 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> According to datasheet's Section 1.1, Table 1, the startup time for the
> device is 2ms and not 5ms.
Ok.  If this were just in the probe path  (which it is today)
I would not bother with the risk for a 3msec potential saving.
However, you are going to reuse it in runtime resume where the effects
will be more obvious. 

Hence applied to the togreg branch of iio.git and pushed out as testing.
*fingers crossed* no one has out of spec wiring that needs a little longer
than the spec says.

Jonathan

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index dc9ff477da34..f5be4516dde7 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -65,7 +65,8 @@
>  
>  #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
>  
> -#define BME680_STARTUP_TIME_US			5000
> +/* Datasheet Section 1.1, Table 1 */
> +#define BME680_STARTUP_TIME_US			2000
>  
>  /* Calibration Parameters */
>  #define BME680_T2_LSB_REG	0x8A


