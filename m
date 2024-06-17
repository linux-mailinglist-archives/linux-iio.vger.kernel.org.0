Return-Path: <linux-iio+bounces-6412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B61390BAC7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34F9281E3D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64B1990C6;
	Mon, 17 Jun 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3a+VOwH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250618A934;
	Mon, 17 Jun 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652174; cv=none; b=AgI+iG2vPsbovymPNcSgmbA8dB4FF1d+CfH3b2juHHy4u5AxvrFrtgI5dMLxoMH4C7blU1Yluqwdc/UqFUj+6XpOcMd0Qjrk6lvAROU9et6BroJb0tn4lpz4ni8zptCQi3+najCaajhnfA41roS3qGTLWHEj+Bq5L03BXLOS67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652174; c=relaxed/simple;
	bh=0xNaKn2xWF6bxabpRd4RKTDYic7VVfS6pZN9IV7cp3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3TsGaN/zfZKXoVygveM5Vp7Si6MP/BpkrTB53koOG7xgVTCMM/etosKuiboj/XqgDr3IwzRvQyx5/pSaDnuSJX+QbH+1PH4LTqq/FNdDLNfb0I5Jxg2FJ+yrCMzLrxbYTWjWfMuIJVRRNlIjAKt/W3rkCSooZwCSEoqFIuqZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3a+VOwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96D6C2BD10;
	Mon, 17 Jun 2024 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718652174;
	bh=0xNaKn2xWF6bxabpRd4RKTDYic7VVfS6pZN9IV7cp3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R3a+VOwHGJVAok1i+lKdJsVSCtkWLT37AYTqHIhdRUeqWK25CA6CCmke1Np4kzbny
	 M0T9AENH0lisJ0mBmRBGBthJXzuohnWV0eos2ZLpF6BwZc3N7XkGXpkda8O1DVBT2K
	 /+vIA240fc0RZUCKscyiNKupacOI7BkZ9M8aTWFoiI+Lzql16+f0FxQfVTF9WhxWvr
	 WjZMlcROA1tcW0XZqarED+JWL7ORd/cYlzudw1zE3fWS9oEwMV5XTwz65HoIhCINhR
	 H9XPkP0RJJCdCXWAqgb8WPxNJgnSyi7/A96iWrEfGiODIUoYsj7SNOH4FRD0j8ee3h
	 zQpZJ5Qyn9JGA==
Date: Mon, 17 Jun 2024 20:22:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Yasin Lee <yasin.lee.x@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, oe-kbuild-all@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
Subject: Re: [PATCH v5 3/3] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <20240617202248.35994484@jic23-huawei>
In-Reply-To: <202406171946.qe83Tde0-lkp@intel.com>
References: <SN7PR12MB8101D4BC788B5954608D677DA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
	<202406171946.qe83Tde0-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 19:34:30 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Yasin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on robh/for-next linus/master v6.10-rc4 next-20240613]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/dt-bindings-iio-proximity-Add-hx9023s-binding/20240616-154122
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/SN7PR12MB8101D4BC788B5954608D677DA4CC2%40SN7PR12MB8101.namprd12.prod.outlook.com
> patch subject: [PATCH v5 3/3] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
> config: arm64-randconfig-r132-20240617 (https://download.01.org/0day-ci/archive/20240617/202406171946.qe83Tde0-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240617/202406171946.qe83Tde0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406171946.qe83Tde0-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iio/proximity/hx9023s.c:955:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 @@     got int diff @@  
>    drivers/iio/proximity/hx9023s.c:955:44: sparse:     expected restricted __be16
>    drivers/iio/proximity/hx9023s.c:955:44: sparse:     got int diff
> 
> vim +955 drivers/iio/proximity/hx9023s.c
> 
>    931	
>    932	static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>    933	{
>    934		struct iio_poll_func *pf = private;
>    935		struct iio_dev *indio_dev = pf->indio_dev;
>    936		struct hx9023s_data *data = iio_priv(indio_dev);
>    937		struct device *dev = regmap_get_device(data->regmap);
>    938		int ret;
>    939		unsigned int bit, i = 0;
>    940	
>    941		guard(mutex)(&data->mutex);
>    942		ret = hx9023s_sample(data);
>    943		if (ret) {
>    944			dev_warn(dev, "sampling failed\n");
>    945			goto out;
>    946		}
>    947	
>    948		ret = hx9023s_get_prox_state(data);
>    949		if (ret) {
>    950			dev_warn(dev, "get prox failed\n");
>    951			goto out;
>    952		}
>    953	
>    954		for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
>  > 955			data->buffer.channels[i++] = data->ch_data[indio_dev->channels[bit].channel].diff;  
>    956	
This looks very odd.  Diff is an int filled with get_unaligned_le16()
which you then write to a __be16 here.

It should remain little endian, if that is appropriate, throughout.

Also, very long line. Use a local variable for
indio_dev->channels[bit].channel.

>    957		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
>    958	
>    959	out:
>    960		iio_trigger_notify_done(indio_dev->trig);
>    961	
>    962		return IRQ_HANDLED;
>    963	}
>    964	
> 


