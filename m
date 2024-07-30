Return-Path: <linux-iio+bounces-8067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C79941F61
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 20:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B5281C85
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8F18A6AF;
	Tue, 30 Jul 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltjXVAAD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998021898ED;
	Tue, 30 Jul 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363483; cv=none; b=QM+b1IvV//oevJliMlWvPyiA+rAdg4YyKv3ARrRRpx5tdOpMfxvt+4P4EDP0JYhuyTglkltwO0NMH2HgNE3woA+iVavfMPfMWyGn9B1B+c29n7OX0wBiZrGsaWIRMNLXLk8S8WAjafID+cqJPGgln1buFR8HfToZ+ZB9ER4PEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363483; c=relaxed/simple;
	bh=zFlEhC7BKi3dbVYdpNsfQlgm4kdJEGt4QToRyq/YG3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA2E42zr/3yr+Fs+Yy8EA3ymhnPpXerAaAsoqWxF6AEX8q5o40HTL6ctqDIkGHW+QcbzWHtq8iLqshppUCHjec5z23Zrc1oiFWbQyeohl5/hO7q3ElZtzH3Cp6apJGl36stgTv4yKxjYuL6fH5hzSivVPHtfxEvQLKP4KmEPtGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltjXVAAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE36AC32782;
	Tue, 30 Jul 2024 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722363483;
	bh=zFlEhC7BKi3dbVYdpNsfQlgm4kdJEGt4QToRyq/YG3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltjXVAAD08NZYrmEFeb7QQ7QmuPnb0yFj5nGVojqJ3D3MEMTAr5+Rrzwg7jJ7fqCb
	 nUwUElESkaKn187Aqb2rah32R/0eHLje+2msXr/G8VBE/Bi4BWcYOSkYwrJirxO8eH
	 7zuaBI7Uxc2jvHEg3TRmppcJtKCgv55xU9CgRL3HIYJExSwRrGH+/1MYnbBebSnLQA
	 x0sHMDDPsPAQST45w166PsTimsmx49mTwxZjJBn77BT4kgHyWi19uWF96EVRsV6kaY
	 VoGp3GpOCsCpj6JrxtxHfyRl+AFvtOqg2ZgULV1akwfyvYWVLWvXtIV5ftbhae5gAJ
	 YAVOcdLtLPrOw==
Date: Tue, 30 Jul 2024 19:17:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: light: stk3310: stk3013 support
Message-ID: <20240730191756.5eabd465@jic23-huawei>
In-Reply-To: <20240728180541.3aff18e1@jic23-huawei>
References: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
	<20240728180541.3aff18e1@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 18:05:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 27 Jul 2024 00:23:30 +0530
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> 
> > STK3013 is a part manufactured by Sensortek which is marketed as a [1]
> > "Proximity Sensor". This part is available in several consumer mobile
> > devices, including, but not limited to, Samsung Galaxy J7 Prime and
> > Samsung Galaxy A2 Core.
> > 
> > The existing ambient light sensor seemed suitable for this chip, and on
> > enabling the driver, it was discovered that these "Proximity Sensors" had
> > ambient light sensing capabilities as well.
> > 
> > The downstream kernel driver shipped with this phone by Samsung [2] exposes
> > a sysfs interface for proximity sensing, but leaves out the light sensing
> > features, hence there's no such functionality in userspace.
> > 
> > The following patch series aims to add support for STK3013 as an
> > ambient light/proximity sensor.
> > 
> > [1] https://www.sensortek.com.tw/index.php/en/products/optical-sensor/
> > [2] https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/master/drivers/sensors/stk3013.c  
> Series LGTM. I'll leave it on list for a few more days though for other
> review to come in.
> 
> Thanks,
> 
> Jonathan
> 
Applied and initially pushed out as testing for 0-day to take a first look at
this.

Thanks,

Jonathan



