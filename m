Return-Path: <linux-iio+bounces-25272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B6BEE389
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 13:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA983E399A
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A25B2E542A;
	Sun, 19 Oct 2025 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bwgf/HkA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95F21638D;
	Sun, 19 Oct 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760872141; cv=none; b=rtEXdULO6fCt3WX8I6WvGzcfchdhHrmASqF76hkBwbt61DbJV6ac/YpBZJx2qotVOSP/0lhKlC/dzluml7xuuJdJVzgMryx3J4kApKahQCx/VjwZGEbKx1O9L9/2L479dSiWIY+tv8UNPSuuUJ1jcu4nc/PUOy39K44WL8XmhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760872141; c=relaxed/simple;
	bh=8i9FdePFrtBrXAb51G3I5Acpt+dTF5XDFaehuqxByeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnqOOFGt2sGqMw+GrWU/frEzNN2PHS3b7Eohs+9maH0TgKfL0v/dgvFuCihPar+HoWhkQAmEDCmyK8uzWD3UuVjMxydS1OKeu9a7y1ktZwGW1JrFCZfT99Xtt/DSO1GLafkcRuPc2DggyX0qAIul7jRX2lKPivhcq10IaMnerUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bwgf/HkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60317C4CEE7;
	Sun, 19 Oct 2025 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760872141;
	bh=8i9FdePFrtBrXAb51G3I5Acpt+dTF5XDFaehuqxByeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bwgf/HkA6nlh0T86b8rzCaTrsyhr1S4RYIhPhkoDbBKaZmMeRN5VfZcewRvavgce/
	 INi+h8xDOxPNb0fszdyZNj/QZ8Myh3mCYSkvbvUTXYkm1BOTmyWlfDXClTZdeHIdTc
	 Ag4j5uBEGarAc8cuVeDaPRFz1u1+YOZfS22vwCH17L4HUcDPPhNoMr7lfgMeCUvBMb
	 qokJLBBAbs4o7x/1b5L2F5A5lCLKCVnIXERE5v+UWkwR5pN3C++4inXvCJm9JNwLLV
	 jBB50wFqaC8q3zagT6IiZLJiuY8UKIWavoPsFPgZpdZQ/7OAvpzyC+izkMLfMh13YP
	 +fWtK3qnnqXzg==
Date: Sun, 19 Oct 2025 12:08:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v5 0/2] iio: imu: smi330: add bosch smi330 driver
Message-ID: <20251019120854.45583b24@jic23-huawei>
In-Reply-To: <20251012185826.13abef25@jic23-huawei>
References: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
	<20251012185826.13abef25@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Oct 2025 18:58:26 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 9 Oct 2025 17:31:47 +0200
> <Jianping.Shen@de.bosch.com> wrote:
> 
> > From: Jianping Shen <Jianping.Shen@de.bosch.com>
> > 
> > Add the iio driver for bosch imu smi330. The smi330 is a combined
> > three axis angular rate and three axis acceleration sensor module.
> > This driver provides raw data access for each axis through sysfs, 
> > and tiggered buffer for continuous sampling.
> > 
> > dt-bindings:
> > v1 -> v2
> >     - Add missing type to drive-open-drain
> >     - Adapt description of drive-open-drain
> > 
> > v2 -> v3
> >     - No Changes
> > 
> > v3 -> v4
> >     - No Changes
> > 
> > v4 -> v5
> >     - No Changes
> > 
> > imu driver:
> > v1 -> v2
> >     - Strip back to a more minimal initial driver
> > 
> > v2 -> v3
> >     - reorganize the driver as 1 core module, 1 I2C module, and 1 SPI module.
> >     - remove build time INT pin choice
> >     - change temperature channel definition
> >     - improved reading data from sensor
> >     - simplified timestamp acquisition
> >     - some other minor finding fixes
> > 
> > v3 -> v4
> >     - move #define from header to c file
> >     - add sanity check to i2c message size
> >     - use available_scan_masks to simplfy the copying data to buffer (dependent on [PATCH RFT] iio: Fix core buffer demux failure to account for unwanted channels at tail)
> >     - allow setting output data rate for acc and gyro separately
> >     - some other minor finding fixes
> > 
> > v3 -> v5
> >     - fix kernel test robot finding
> >     - some other minor finding fixes  
> Fixes on top once a patch is applied. I 'might' merge them down or I might
> decide to keep them separate. That normally depends on the state of my tree and
> what else is going on.
> 
> This change log is also not informative enough.  Should say what the robot
> reported and what you did to fix it.  Also give a lot more detail on those
> other minor fixes.
> 
> Anyhow, I'll wait for the fixes as separate patches.

The lack of a fix patch (as requested) is blocking me pushing my tree
out for linux-next to pick up.

As such I have rebased to drop the original patch and merged this one.
Hopefully that won't cause any other developers significant pain. It
is only something I considered doing at all because I was holding my
tree waiting for this fix and so it was only out as testing (which I
tell no one to rely on remaining stable!)

Please take this into account in future.  If we'd been near the end of the cycle
I'd have reverted your driver and told you to resend it next kernel
cycle and you would have been back 3 months.  Note I considered reverting
your series and waiting on the requested fix patch but decided to let it go
this time.

So this version is now pushed out as testing.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 


