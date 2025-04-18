Return-Path: <linux-iio+bounces-18257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C11ECA93917
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D97B369D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDEF202994;
	Fri, 18 Apr 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEwhf/fz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E61FBEA2;
	Fri, 18 Apr 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988571; cv=none; b=kHhaNfLOPTly4S+PIRVV7D0pDVBKMZgKeEbYI1UoJCF4Y5GquAP35SQaGDC37IYIFZXIIZE0bRQBtbe8+TSNTvpNUPRC7tNqbou1pLqVg5aOnMa5XqK+3noeyvb/Q7NMf14X4iYWwlump4ov7CZPHEmX8Ow2Ui9B7KVmreiUClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988571; c=relaxed/simple;
	bh=w2SpzO0xz6fx5J/fpntEEf1UqwhZaVfP36baHvy0z+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5b6D/6WywAw08RrPC4WrE3+MRFfl6Dgws2spNe+lEqATQzQjtQMXNaA9t+978mKB4UA1sIINE2GIrUA+poZCxKTRLa3ncYqJVaIdtbOuhFWZm202F4W/6eBqLrjOfe0EoeBlGV7HYP8jGNxHldzSNI9yFyfO9pbkzZfjO2hFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEwhf/fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B5BC4CEE2;
	Fri, 18 Apr 2025 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744988570;
	bh=w2SpzO0xz6fx5J/fpntEEf1UqwhZaVfP36baHvy0z+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mEwhf/fzByQdSLeT3Cu00zEzaaOGeQnOsE8nqnjaQioNNFWBeo4YURAhkgXffpi2W
	 hnT9ZrvKsEpJaQs4Q5p1UIU0nK/DHdfHyQQMWSbcg09goV0uTlBLCoRKXLgRPT3P1R
	 8+ik9tBNd8aSreN+sX9TOb445OFww7oWo3ICiCCA3JBvgzkcMq8m6M0DC6zMGXwDbA
	 WDU6SQo647rlTslsurH7D7xF029OAGqfTgH/Xm3V70F13gFetzh1C56cHqS+JX9djB
	 A+0Eedl8HHYigtnzfgDJAYilMm777v0sKsD5fqvIqgJCm9THRSQ0XKMkHVBXMqGPnl
	 wFZi67jUe48Gg==
Date: Fri, 18 Apr 2025 16:02:38 +0100
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
Message-ID: <20250418160238.204701e7@jic23-huawei>
In-Reply-To: <FR3P281MB175712512B0A88FAC9DFA009CEBF2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
	<aAEzlZoZTsQuWgZa@smile.fi.intel.com>
	<20250417184620.00006ae6@huawei.com>
	<FR3P281MB175712512B0A88FAC9DFA009CEBF2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 11:26:39 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> On Thu, 17 Apr 2025 19:46:00, Jonathan Cameron wrote:
> > On Thu, 17 Apr 2025 20:00:05 +0300
> > Andy Shevchenko <andy@kernel.org> wrote:
> >   
> > > On Thu, Apr 17, 2025 at 11:52:39AM -0500, David Lechner wrote:  
> > > > Align the buffer used with iio_push_to_buffers_with_timestamp() to
> > > > ensure the s64 timestamp is aligned to 8 bytes.    
> > > 
> > > Same question as per previous patch.
> > >   
> > In this case I don't think we know the position of the timestamp
> > so a structure would be misleading.
> > 
> > The comment above the define certainly suggests it is variable..  
> 
> I confirm timestamp position is changing depending on channels enabled. It
> can be at address 8, 16 or 24.
> 
> If there is only 1 sensor enabled (6 bytes of data), timestamp is at address
> 8. 2 sensors (12 bytes of data), timestamp will be at address 16. 3 sensors
> for MPU-9xxx (19 bytes of data), timestamp will be at address 24.
> 
> If the buffer is aligned on 8 bytes, it will always work without any problem.
> 
> > 
> > /*
> >  * Maximum of 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8.
> >  * May be less if fewer channels are enabled, as long as the timestamp
> >  * remains 8 byte aligned
> >  */
> > #define INV_MPU6050_OUTPUT_DATA_SIZE         32  
> 
> Thanks,
> JB

I applied this one as it stands with fixes tag and +CC stable.

Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")

I thought about seeing if all the cases that are fixes are separable enough
to take through togreg-fixes whilst the with_ts() series goes through togreg
in parallel.  I might see if that is doable easily.

Jonathan

