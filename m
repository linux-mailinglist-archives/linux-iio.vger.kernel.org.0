Return-Path: <linux-iio+bounces-13342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A89ED66D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033C8188A489
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F40231A59;
	Wed, 11 Dec 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOKrypyn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28041C548F;
	Wed, 11 Dec 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944545; cv=none; b=q+t2p2ckj+Ra58jLtfTwTlkQVGsN8viJMuUwEJhlVZzE7YxmEJzjcmTAOw1NiCfEIHBNh+JelVmtg0HKnhbK5oMECnmS3wFvtWIgtW2h8aFybOQlRrf4Ze6eXDW6Fbgz1/ov0IW3ehnpsXf3s7oLdhUB3+Attih/gbdV0e8YvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944545; c=relaxed/simple;
	bh=TycHuwKOqMmwmgXtlpvbcP6Cd7VjA6M0ekrYMGO/yEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6y1JWkehDF55nFYy2PR64XUvjwRi66AiyGf4ZPJR4XIqNR8olrd/m4YVx+DqrNjw2eD+q9OpZnEPEUH22ddIDCrd73SBkaklOFwS5fSx6e1awqkU+920srK6LYlgDQRuoRgsNLjRHwuavTAWalSIwHg1mRuWm94gh2CsF0tbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOKrypyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2E1C4CED2;
	Wed, 11 Dec 2024 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944545;
	bh=TycHuwKOqMmwmgXtlpvbcP6Cd7VjA6M0ekrYMGO/yEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HOKrypynG4At1cB14qOLL/okQZnfH9pGms2vTOQTsuWpmc3DqdEVOuG5Acsxv+faT
	 j4Haut7R+d2d1Kz+QdZoJa3LEq4Qkwhg872K9rTqXE7LDiQPIB9Nw07pAdNEtBA4K1
	 gF02VL4duNd5yPCfVqAVN1C5XyUSm8NI0hiIomaJNqEX+Y9S1G+gg8t+PrYesTkJDQ
	 Df33m49aHVpa9hMpxr1GsrHr/8yhcOVraVRpWAxINJmSCWzezSVSVS+P9FPiteXI87
	 3LNpR3cQd3i8rBHtUyAuaihf9RZfY5bJ822lk6zEUzHpNS0nlQEkoIsH9JAlEDebU4
	 M+1PVhiLgEpMA==
Date: Wed, 11 Dec 2024 19:15:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Lothar Rubusch <l.rubusch@gmail.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <20241211191536.224c89e9@jic23-huawei>
In-Reply-To: <dc914326-7eae-4e4a-8c93-ae1a7007bcc9@stanley.mountain>
References: <20241205171343.308963-11-l.rubusch@gmail.com>
	<dc914326-7eae-4e4a-8c93-ae1a7007bcc9@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 11:47:37 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hi Lothar,
> 
> kernel test robot noticed the following build warnings:

Ah. This was the report you were referring to I guess.  Just fix these in v6 version
of this patch.

Thanks,

Jonathan

> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Lothar-Rubusch/iio-accel-adxl345-refrase-comment-on-probe/20241206-011802
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20241205171343.308963-11-l.rubusch%40gmail.com
> patch subject: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark events
> config: nios2-randconfig-r072-20241210 (https://download.01.org/0day-ci/archive/20241210/202412101132.Kj6R6i3h-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 14.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202412101132.Kj6R6i3h-lkp@intel.com/
> 
> smatch warnings:
> drivers/iio/accel/adxl345_core.c:441 adxl345_event_handler() warn: unsigned 'int_stat' is never less than zero.
> 
> vim +/ret +321 drivers/iio/accel/adxl345_core.c
> 
> 55d2386488598bb Lothar Rubusch 2024-12-05  433  static irqreturn_t adxl345_event_handler(int irq, void *p)
> 55d2386488598bb Lothar Rubusch 2024-12-05  434  {
> 55d2386488598bb Lothar Rubusch 2024-12-05  435  	struct iio_dev *indio_dev = p;
> 55d2386488598bb Lothar Rubusch 2024-12-05  436  	struct adxl345_state *st = iio_priv(indio_dev);
> 55d2386488598bb Lothar Rubusch 2024-12-05  437  	u8 int_stat;
>                                                         ^^^^^^^^^^^
> 
> 55d2386488598bb Lothar Rubusch 2024-12-05  438  	int samples;
> 55d2386488598bb Lothar Rubusch 2024-12-05  439  
> 55d2386488598bb Lothar Rubusch 2024-12-05  440  	int_stat = adxl345_get_status(st);
> 55d2386488598bb Lothar Rubusch 2024-12-05 @441  	if (int_stat < 0)
>                                                             ^^^^^^^^^^^^
> signedness bug
> 
> 55d2386488598bb Lothar Rubusch 2024-12-05  442  		return IRQ_NONE;
> 55d2386488598bb Lothar Rubusch 2024-12-05  443  
> 55d2386488598bb Lothar Rubusch 2024-12-05  444  	if (int_stat == 0x0)
> 55d2386488598bb Lothar Rubusch 2024-12-05  445  		goto err;
> 55d2386488598bb Lothar Rubusch 2024-12-05  446  
> 55d2386488598bb Lothar Rubusch 2024-12-05  447  	if (int_stat & ADXL345_INT_OVERRUN)
> 55d2386488598bb Lothar Rubusch 2024-12-05  448  		goto err;
> 55d2386488598bb Lothar Rubusch 2024-12-05  449  
> 55d2386488598bb Lothar Rubusch 2024-12-05  450  	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
> 55d2386488598bb Lothar Rubusch 2024-12-05  451  		samples = adxl345_get_samples(st);
> 55d2386488598bb Lothar Rubusch 2024-12-05  452  		if (samples < 0)
> 55d2386488598bb Lothar Rubusch 2024-12-05  453  			goto err;
> 55d2386488598bb Lothar Rubusch 2024-12-05  454  
> 55d2386488598bb Lothar Rubusch 2024-12-05  455  		if (adxl345_fifo_push(indio_dev, samples) < 0)
> 55d2386488598bb Lothar Rubusch 2024-12-05  456  			goto err;
> 55d2386488598bb Lothar Rubusch 2024-12-05  457  
> 55d2386488598bb Lothar Rubusch 2024-12-05  458  	}
> 55d2386488598bb Lothar Rubusch 2024-12-05  459  	return IRQ_HANDLED;
> 55d2386488598bb Lothar Rubusch 2024-12-05  460  
> 55d2386488598bb Lothar Rubusch 2024-12-05  461  err:
> 55d2386488598bb Lothar Rubusch 2024-12-05  462  	adxl345_fifo_reset(st);
> 55d2386488598bb Lothar Rubusch 2024-12-05  463  
> 55d2386488598bb Lothar Rubusch 2024-12-05  464  	return IRQ_HANDLED;
> 55d2386488598bb Lothar Rubusch 2024-12-05  465  }
> 


