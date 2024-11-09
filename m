Return-Path: <linux-iio+bounces-12069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4744F9C2D83
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C9C1C2102F
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D81922F1;
	Sat,  9 Nov 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOkDO4+9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99115098A;
	Sat,  9 Nov 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731158471; cv=none; b=NJhgcMeFYf3x89P8zAtcUfzZZoMyJ3WeTExqRtnMctkKbgHlkQSVyb7f9VbkeTWLkHSaoYjq9HgKrpNN0No4N6XypUinXYzGYTubw78/UIl1oMvYT0e5lCB/ACbaIjM7vlT9LiHVxAxMLYY1MxZX/6qKpcFE7OhmKXXinolwcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731158471; c=relaxed/simple;
	bh=8HxP5y3oRo0+Y2U3FnB66HnVy4it2wNsyZ5AAWMeRxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVuGNEAi0B8V6SBPQ5CFVBhT+b7IcuLNmoJ4+91uh2ZzptuPpfuRQMMENmApZ7MH7TKLC2g2kaHumWhe+m/jArZGyhleneoPGlmawjVlya1fcOOO2PGzMpj5yuEZ9ccMCbcKuY1n9WFaqFdwzxKz/7IkXPiCZ+7st4iBTrHkE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOkDO4+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5A1C4CECE;
	Sat,  9 Nov 2024 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731158471;
	bh=8HxP5y3oRo0+Y2U3FnB66HnVy4it2wNsyZ5AAWMeRxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZOkDO4+9fukaFekFvgGd7K3yqj7jb/9QvtiUruVMvPTbUd0J71n4kjWz/LKzPHAEf
	 RXsIMHMSw05JsGAfocvr5Ndpc+mmT0lYWu/1Gj46kr9T4Oz5E7heYpNwDt/SGXhP1N
	 R5OGlYYkKms8tOSlAKoV6be3Q93TImWPtxCwDEJa59z1q04/c0hk+8vfoH+3Mmkhgs
	 J1IJRKaMvQhkdloaQ2u/HwtgMEbfRSL5W+jVMaA88msndyCdHqB0kPj4+c/3AUCXYB
	 v8Lffs/Au/z1u59jxBYt+lLLVWUzeVSKc5ZVqKALEpl8GXs9MpnlXl2QB0rYL2MhAN
	 EoJSgHIxFPtPw==
Date: Sat, 9 Nov 2024 13:21:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6030: add support for triggered buffer
Message-ID: <20241109132105.0a6bfc0b@jic23-huawei>
In-Reply-To: <17464711-bdc2-46c9-a216-93851112abbb@gmail.com>
References: <20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com>
	<202411081703.Ft0YjqcK-lkp@intel.com>
	<17464711-bdc2-46c9-a216-93851112abbb@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 11:33:27 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 08/11/2024 10:41, kernel test robot wrote:
> > Hi Javier,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on c9f8285ec18c08fae0de08835eb8e5953339e664]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/iio-light-veml6030-add-support-for-triggered-buffer/20241108-042332
> > base:   c9f8285ec18c08fae0de08835eb8e5953339e664
> > patch link:    https://lore.kernel.org/r/20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56%40gmail.com
> > patch subject: [PATCH] iio: light: veml6030: add support for triggered buffer
> > config: i386-randconfig-062-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081703.Ft0YjqcK-lkp@intel.com/config)
> > compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081703.Ft0YjqcK-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411081703.Ft0YjqcK-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)  
> >>> drivers/iio/light/veml6030.c:958:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 @@     got int [addressable] reg @@  
> >    drivers/iio/light/veml6030.c:958:39: sparse:     expected restricted __le16
> >    drivers/iio/light/veml6030.c:958:39: sparse:     got int [addressable] reg
> > 
> > vim +958 drivers/iio/light/veml6030.c
> > 
> >    944	
> >    945	static irqreturn_t veml6030_trigger_handler(int irq, void *p)
> >    946	{
> >    947		struct iio_poll_func *pf = p;
> >    948		struct iio_dev *iio = pf->indio_dev;
> >    949		struct veml6030_data *data = iio_priv(iio);
> >    950		int i, ret, reg;
> >    951		int j = 0;
> >    952	
> >    953		iio_for_each_active_channel(iio, i) {
> >    954			ret = regmap_read(data->regmap, VEML6030_REG_DATA(i), &reg);
> >    955			if (ret)
> >    956				goto done;
> >    957	  
> >  > 958			data->scan.chans[j++] = reg;  
> 
> chans is currently declared as __le16 chans[2], but it should be u16
> chans[2], as regmap already handles the endianness.
> 
> Then the direct assignment does not raise any warnings. When at it, I
> will define reg as unsigned int.
Make sure you update the chan_spec as well to reflect that are CPU endian.

This makes sense because the registers are 16 bit on this device.
> 
> >    959		}
> >    960	
> >    961		iio_push_to_buffers_with_timestamp(iio, &data->scan, pf->timestamp);
> >    962	
> >    963	done:
> >    964		iio_trigger_notify_done(iio->trig);
> >    965	
> >    966		return IRQ_HANDLED;
> >    967	}
> >    968	
> >   
> 
> Best regards,
> Javier Carrasco
> 


