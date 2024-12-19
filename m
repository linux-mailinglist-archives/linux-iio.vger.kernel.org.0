Return-Path: <linux-iio+bounces-13677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C89F82B2
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5471894D66
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA51A0BFE;
	Thu, 19 Dec 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ5klVLY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AE19DF99;
	Thu, 19 Dec 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630466; cv=none; b=B9dMWa3JF9dtzqLeQr3Sm2FrRui1oXPAO3tYNg1z0CSMHMOp20MS02GOfQb6S0oNLT0g4SaRD7YYOpSMf/xuG/CJ4TLHfPBL3bAtMbPAS/QUXx9ZRc8DYqy6GM5UFUQHh1ubqD+1j/xGoMLqKsSMeXgjcBb6mmXu2W62Iql3Gqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630466; c=relaxed/simple;
	bh=vYrLMIoh8if7mNNwfS2c8sOSya3b7R5FT45cdStkNG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRcFxP+BRP7s8hVP4SPb/GTrISN6/LVm9Qsu94Cksa8317D1nZtxuODwRlUZ3dnJ77Kz5KxT0luX1t/Lx6XJbOwn6jJkyse0mEbn82aLT132mWcYDaHVFfjE7bF5Jyjhi4P+DRPaBcuR0Al+7AQCDrCmWnBhoy/ub1NWrV2FprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ5klVLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDC1C4CECE;
	Thu, 19 Dec 2024 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630465;
	bh=vYrLMIoh8if7mNNwfS2c8sOSya3b7R5FT45cdStkNG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sJ5klVLYhlG66pDh4rl0lQV6BkwlMSb6t8ylRTSXZoIPlZzDPkgThmZ+teKVZry+2
	 H86CcYl1w/gqksRoSgWRVidxEYvSnYufa/4/WFW9wWdrg8hnUpZp/Epff449wAtXC5
	 jbQEtmTFV8qXYOR7t58S4NM6VtPMg06Rqqy73+lnR47lIqPPTXF5Xx16cLXonmmxkY
	 h6g7eGyPewc8BTtaj8R9DsJE5nN0GWopSkjWLd3/R2jJ2NsBQNrgbAcY5fj1iIunSC
	 lvcljPywn5VCgRoiyT4Se9k55PM+Lgij/Go55bGNs9e0RpmDDOomZUYprJyBHCD/lv
	 sJRhbNAM20Sag==
Date: Thu, 19 Dec 2024 17:47:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, lars@metafoo.de,
 krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, jackoalan@gmail.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: common: ssp_sensors: drop conditional
 optimization for simplicity
Message-ID: <20241219174736.7bf2fdc2@jic23-huawei>
In-Reply-To: <Z2M7E9gmJyFkNEcD@vamoirid-laptop>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
	<20241214191421.94172-4-vassilisamir@gmail.com>
	<5e133bba-ee3e-498f-80ea-375dd857c057@baylibre.com>
	<Z2IMQXJC-A0TjQK2@vamoirid-laptop>
	<82e97712-3765-4d93-bdb5-f50fa7025e81@baylibre.com>
	<Z2M7E9gmJyFkNEcD@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 22:13:55 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Wed, Dec 18, 2024 at 09:17:44AM -0600, David Lechner wrote:
> > On 12/17/24 5:41 PM, Vasileios Amoiridis wrote:  
> > > On Mon, Dec 16, 2024 at 03:57:44PM -0600, David Lechner wrote:  
> > >> On 12/14/24 1:14 PM, Vasileios Amoiridis wrote:  
> > >>> Drop conditional in favor of always calculating the timestamp value.
> > >>> This simplifies the code and allows to drop usage of internal private
> > >>> variable "scan_timestamp" of the struct iio_dev.
> > >>>
> > >>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > >>> ---
> > >>>  drivers/iio/common/ssp_sensors/ssp_iio.c | 9 +++------
> > >>>  1 file changed, 3 insertions(+), 6 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > >>> index caa404edd9d0..6b86b5315694 100644
> > >>> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> > >>> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > >>> @@ -8,6 +8,8 @@
> > >>>  #include <linux/iio/kfifo_buf.h>
> > >>>  #include <linux/module.h>
> > >>>  #include <linux/slab.h>
> > >>> +#include <linux/unaligned.h>
> > >>> +#include <linux/units.h>
> > >>>  #include "ssp_iio_sensor.h"
> > >>>  
> > >>>  /**
> > >>> @@ -70,7 +72,6 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
> > >>>  int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> > >>>  			    unsigned int len, int64_t timestamp)
> > >>>  {
> > >>> -	__le32 time;
> > >>>  	int64_t calculated_time = 0;
> > >>>  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
> > >>>  
> > >>> @@ -82,11 +83,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> > >>>  	 */
> > >>>  	memcpy(spd->buffer, buf, len);
> > >>>  
> > >>> -	if (indio_dev->scan_timestamp) {
> > >>> -		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
> > >>> -		calculated_time =
> > >>> -			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> > >>> -	}
> > >>> +	calculated_time = timestamp + get_unaligned_le32(buf + len) * MEGA;  
> > >>
> > >> Don't we still need to cast to 64 bit to avoid multiplication overflow?
> > >>  
> > > 
> > > Hi David,
> > > 
> > > Thanks for your message!
> > > 
> > > Aren't we already covered by the fact that MEGA is defined as an
> > > unsigned long?  
> > 
> > That is only 64-bits on 64-bit architectures, so could still overflow on
> > 32-bit architectures where long is 32-bit.
> >   
> 
> Hi David,
> 
> Hmmm, I think you are right. I can fix it in next, iteration. I will
> wait also for Jonathan's comments on the rest of the series.
> 
I tweaked it and applied.  Also dropped the initial assignment of calculated_time given it is now
always set before use.

Thanks,

Jonathan


> Cheers,
> Vasilis
> 
> > > 
> > > 	include/linux/units.h:12:#define MEGA 1000000UL
> > > 
> > > Cheers,
> > > Vasilis
> > >   
> > >>>  
> > >>>  	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
> > >>>  						  calculated_time);  
> > >>  
> >   


