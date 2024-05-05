Return-Path: <linux-iio+bounces-4816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D038BC2F8
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 20:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742BC281641
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7555FDA5;
	Sun,  5 May 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t//V001M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D451E861
	for <linux-iio@vger.kernel.org>; Sun,  5 May 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714932162; cv=none; b=jbOqHVdMy/08saP33cZT7qxOfovE1D0Qedaeew/NIzGSOLpLZKxeMw2nY0ucJjaKpjI5OrDStfwHQQ82+BR3KOVuljQWV+R1msnjfkrEPGTA7Z5MGhUowm08yqlD4bHOCffWFZzGWc7xjqBgYbN9D4SJLm0hPmcwqfQZUe9vj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714932162; c=relaxed/simple;
	bh=Mpio2TrqfhOMhGaabF3Leqs5HM5QI0ysCl4XaqFJSCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CB/ux9/uJOPAg+DHUJ3ISsHY2s5lkVY23wRf9SKDCXZWWoR6+F/YEBCg5ESmLEG2W0wKYUDB8QMiaT8HrrbnyHU/Zhj1sDMEHbQs8jjj+jAbNPhFRI6PayHoFfImnMTRtonfHBNwpksvfekDA8BGb+wejuTwAxZCmXHebgWwGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t//V001M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24994C113CC;
	Sun,  5 May 2024 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714932161;
	bh=Mpio2TrqfhOMhGaabF3Leqs5HM5QI0ysCl4XaqFJSCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t//V001M4LC8AlKhx0O41rixhwnClVlzJ8/DBKUW+ppZGgtuqTtcWsSeVDeIOxMBi
	 QtifuoRU/8XR+yr3oIl6vLERrhyVq10YhvSZm4vcnkNnsvUIrxElj1NhkjuTInQE2p
	 yxIronyBqhBy3y6SFNJzX6CYn0ZKI2Wavjx2xrem7AGl9DhwhLu7hHzIm6peYwZJAv
	 FO3+FxrysrE7Ql2VRNRFZaVAHcAvd3tzMzqr9D2z54aL2cqsIY4/0tMjnBYeimAkwe
	 HfDFAn9gF7WYbqrClvP19Sydbv3AFH+lmmc0QzIbS/pedTwz8wigAoJSPM3YfAscXg
	 3BeJ3WaoMxS4A==
Date: Sun, 5 May 2024 19:02:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angel Iglesias <ang.iglesiasg@gmail.com>
Cc: Adam Rizkalla <ajarizzo@gmail.com>, Vasileios Amoiridis 
 <vassilisamir@gmail.com>, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: Replying to: [PATCH] iio pressure: bmp280: Fix BMP580
 temperature reading
Message-ID: <20240505190224.6b3c8d66@jic23-huawei>
In-Reply-To: <bcd4495c4dd988263acb257c0ccef27c7fe49020.camel@gmail.com>
References: <043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com>
	<20240502171616.154085-1-vassilisamir@gmail.com>
	<ZjPYLtGAFtI5iN8E@adam-asahi.team.saronic.dev>
	<bcd4495c4dd988263acb257c0ccef27c7fe49020.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 May 2024 09:13:33 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Thu, 2024-05-02 at 13:15 -0500, Adam Rizkalla wrote:
> > On Thu, May 02, 2024 at 07:16:16PM +0200, Vasileios Amoiridis wrote:  
> > > Hi Angel!
> > > 
> > > Indeed the datasheet says that the pressure is a signed value. But this
> > > comes
> > > in contrast with 2 things:
> > > 
> > > 1) The BMP58x sensor does not have a compensation function so the value from
> > > the
> > > sensor is a pressure value just in different unit from the one reported by
> > > IIO.
> > > And the sensor is able to report in between 30-125kPa according to the
> > > datasheet which are both positive values so it makes more sense to be an
> > > unsigned value.
> > > 
> > > 2) According to the BMP5 sensor API [1] provided by Bosch, the pressure is
> > > declared as an unsigned value.
> > > 
> > > So, what should we trust?
> > > 
> > > [1]:
> > > https://github.com/boschsensortec/BMP5_SensorAPI/blob/master/bmp5_defs.h#L895  
> > 
> > The pressure sensor reading cannot be negative, as the pressure range of the
> > sensor
> > is 300 - 1250 hPa,so this change does not need to be applied for
> > bmp580_read_press().
> > Also, the overflow issue does not happen with the pressure reading since the
> > value
> > read back from the device is scaled up only by 2^6 for pressure vs 2^16 for
> > temperature,
> > so multiplying by 1000 even for the maximum value would still fit in a 32-bit
> > signed
> > integer. Temperature ranges above ~32.767C, however, will overflow a 32-bit
> > signed
> > integer when multiplied by 2^16 * 1000 which is why this change is necessary
> > only for
> > temperature readings.
> > 
> > Hope this helps clarify.
> > 
> > Best,
> > Adam  
> 
> Crystal clear. Thanks to both of you for the clarifications :)
> 
> Acked-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Kind regards,
> Angel


