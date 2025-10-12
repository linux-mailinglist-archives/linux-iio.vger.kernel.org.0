Return-Path: <linux-iio+bounces-24996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B5BD090E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E973B8E67
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FBE2EE274;
	Sun, 12 Oct 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbPLiupN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD162ECE87;
	Sun, 12 Oct 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291918; cv=none; b=UUhSwgjML9oETolz79BOkBVVmii+KKWJhevYq/e9NCqlIlHk4en1GPnDfJXXsQd6nrirsvg+WpCTAg6AXwMYFr8ptJlAIZG9WiHkHxybvYDO2VrY0lmSUM9sjhRd87vyhKXkHduPUp1LJJo/pdR+A0P+eecxeAXcKtToq4JpheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291918; c=relaxed/simple;
	bh=RPG0WyII0YAY55w44Mz2+LSbIkTmztwPaxqTUd1Ef+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAQdq1GOi1xg/wrqnJCVN9qwg43ZnPgGWmBvFrg39sUfbcosRmIzYIeSgc03F8U18N3g2Uab5BJbKuXabbFW2skc7+FXp78snlVFGrO82145Z7MhHGnThg1pXZehqchoqf/Rof0PoSLy4hGDwz5uWzxASri1LjH1UgHw1d4bD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbPLiupN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FE7C4CEE7;
	Sun, 12 Oct 2025 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760291917;
	bh=RPG0WyII0YAY55w44Mz2+LSbIkTmztwPaxqTUd1Ef+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbPLiupNbVVV2+F4kC1btPfSig4ChLSIw4FgEJF9rFC218LuoMarljOj5I6yaR+xH
	 AyZAxY3oyuHXpfPxra55KDV+JtN+s+sYdEcveC14Oew4Llri4aK1WhpHFwD1Mc+/rc
	 RfWgaRQfpdkwPVUPStquP//cYrHhGzYvK5Wv2Ljhy1NC1opIbhklv0PxxkT24WE5Wf
	 OQP6J3DI0b/9Sb/gD4M7RoKGhcc+N4YEvJnd3IOU/1h+tF8qbIIeMvnMo1ipdXIBOV
	 ov8Ii6qCuRTJLXjhGt9H/8+6i7jvB51mnaiGqGoLYOmD0Q76zfrcwsJVVn865vg+2d
	 H/yY7vOr+SYzw==
Date: Sun, 12 Oct 2025 18:58:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v5 0/2] iio: imu: smi330: add bosch smi330 driver
Message-ID: <20251012185826.13abef25@jic23-huawei>
In-Reply-To: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
References: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 17:31:47 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Jianping Shen <Jianping.Shen@de.bosch.com>
> 
> Add the iio driver for bosch imu smi330. The smi330 is a combined
> three axis angular rate and three axis acceleration sensor module.
> This driver provides raw data access for each axis through sysfs, 
> and tiggered buffer for continuous sampling.
> 
> dt-bindings:
> v1 -> v2
>     - Add missing type to drive-open-drain
>     - Adapt description of drive-open-drain
> 
> v2 -> v3
>     - No Changes
> 
> v3 -> v4
>     - No Changes
> 
> v4 -> v5
>     - No Changes
> 
> imu driver:
> v1 -> v2
>     - Strip back to a more minimal initial driver
> 
> v2 -> v3
>     - reorganize the driver as 1 core module, 1 I2C module, and 1 SPI module.
>     - remove build time INT pin choice
>     - change temperature channel definition
>     - improved reading data from sensor
>     - simplified timestamp acquisition
>     - some other minor finding fixes
> 
> v3 -> v4
>     - move #define from header to c file
>     - add sanity check to i2c message size
>     - use available_scan_masks to simplfy the copying data to buffer (dependent on [PATCH RFT] iio: Fix core buffer demux failure to account for unwanted channels at tail)
>     - allow setting output data rate for acc and gyro separately
>     - some other minor finding fixes
> 
> v3 -> v5
>     - fix kernel test robot finding
>     - some other minor finding fixes
Fixes on top once a patch is applied. I 'might' merge them down or I might
decide to keep them separate. That normally depends on the state of my tree and
what else is going on.

This change log is also not informative enough.  Should say what the robot
reported and what you did to fix it.  Also give a lot more detail on those
other minor fixes.

Anyhow, I'll wait for the fixes as separate patches.

Thanks,

Jonathan

