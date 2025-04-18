Return-Path: <linux-iio+bounces-18258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0E0A9391E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932C88A6F36
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BBB202F6D;
	Fri, 18 Apr 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozI3u+Tx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC01FAC29;
	Fri, 18 Apr 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988973; cv=none; b=hYV6C5Aw9nINdg3F+YLZD/a1tExZraWLoJ+cQb1K9VscagGJ9+BTkX3XEeVRPvNln4dXRSXMR762og+BZLCSCaskI1yz8RDggZc4bY1zlyrwq8Vfuh68lOHSXjz4jCyCUKf3J45F8AptyuRI/cdb02RVGJGVgpu5XlIaPF282rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988973; c=relaxed/simple;
	bh=OjvDIgahnZog5eJn8g2EKzm+1K2gEPP7qqBE5WS9ucY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJKt0kj8/9X65XTdL6OhXTr7+uZedB+oIDeeMK1lwNO6pbZjO8PVAdXydSWCDDC6x4k73/pZ3TXzmbBL7eoK57jXbpzAW1ZAOC4C0asqQBftsmgVTQoEtUfe1zM01yM1j/bS4ncRRnUe1dsqME03c3L/QEt1WYCKz7Jn3IqMyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozI3u+Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6D5C4CEE2;
	Fri, 18 Apr 2025 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744988972;
	bh=OjvDIgahnZog5eJn8g2EKzm+1K2gEPP7qqBE5WS9ucY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ozI3u+Tx7lvInAjyN8zoQlgZhwS1RX+enBxm2JRv6FjAWwSNpEVe8QVge6Bwsjse+
	 n1K0Sv21l/UCp1S6hx8PRCmkm2egZRYLaeIC7Wlni9zEctU7qfEcbEYiaDOaRKmZhI
	 Wr1JFSlQOhKRRct+871eJ9VwOxeowlawv5RaSIVPCoo/vxrFqU+0lQfsAz+z7yuL7+
	 i/kPV1IrSs8UIrbdd/z9Aj/e93P6xR8UUlU1GF5Alu8MadIA5Q4cF7km0Sv7nrTP5g
	 ir+N8W32qis2OvbWRBMXxGH5EVCcT3I2F4uIncyQEM4U134IHAHaOFwQm81UaGPgWy
	 L/mE6B6bJdH/Q==
Date: Fri, 18 Apr 2025 16:09:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Andreas Klinger <ak@it-klinger.de>, Petre Rodan
 <petre.rodan@subdimension.ro>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 7/8] iio: imu: inv_mpu6050: align buffer for timestamp
Message-ID: <20250418160922.33bffa7f@jic23-huawei>
In-Reply-To: <20250418160238.204701e7@jic23-huawei>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
	<aAEzlZoZTsQuWgZa@smile.fi.intel.com>
	<20250417184620.00006ae6@huawei.com>
	<FR3P281MB175712512B0A88FAC9DFA009CEBF2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250418160238.204701e7@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 16:02:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 18 Apr 2025 11:26:39 +0000
> Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> 
> > On Thu, 17 Apr 2025 19:46:00, Jonathan Cameron wrote:  
> > > On Thu, 17 Apr 2025 20:00:05 +0300
> > > Andy Shevchenko <andy@kernel.org> wrote:
> > >     
> > > > On Thu, Apr 17, 2025 at 11:52:39AM -0500, David Lechner wrote:    
> > > > > Align the buffer used with iio_push_to_buffers_with_timestamp() to
> > > > > ensure the s64 timestamp is aligned to 8 bytes.      
> > > > 
> > > > Same question as per previous patch.
> > > >     
> > > In this case I don't think we know the position of the timestamp
> > > so a structure would be misleading.
> > > 
> > > The comment above the define certainly suggests it is variable..    
> > 
> > I confirm timestamp position is changing depending on channels enabled. It
> > can be at address 8, 16 or 24.
> > 
> > If there is only 1 sensor enabled (6 bytes of data), timestamp is at address
> > 8. 2 sensors (12 bytes of data), timestamp will be at address 16. 3 sensors
> > for MPU-9xxx (19 bytes of data), timestamp will be at address 24.
> > 
> > If the buffer is aligned on 8 bytes, it will always work without any problem.
> >   
> > > 
> > > /*
> > >  * Maximum of 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8.
> > >  * May be less if fewer channels are enabled, as long as the timestamp
> > >  * remains 8 byte aligned
> > >  */
> > > #define INV_MPU6050_OUTPUT_DATA_SIZE         32    
> > 
> > Thanks,
> > JB  
> 
> I applied this one as it stands with fixes tag and +CC stable.
> 
> Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
> 
> I thought about seeing if all the cases that are fixes are separable enough
> to take through togreg-fixes whilst the with_ts() series goes through togreg
> in parallel.  I might see if that is doable easily.
> 
I have done so and it seems fine as we didn't rename anything...

52d349884738 (HEAD -> fixes-togreg) iio: adc: ad7266: Fix potential timestamp alignment issue.
ffbc26bc91c1 iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
5097eaae98e5 iio: adc: dln2: Use aligned_s64 for timestamp
1bb942287e05 iio: accel: adxl355: Make timestamp 64-bit aligned using aligned_s64
f79aeb6c631b iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
6ffa69867405 iio: chemical: pms7003: use aligned_s64 for timestamp
bb49d940344b iio: chemical: sps30: use aligned_s64 for timestamp

Now on the fixes-togreg branch of iio.git.
> Jonathan


