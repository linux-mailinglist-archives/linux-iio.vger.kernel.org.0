Return-Path: <linux-iio+bounces-27293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AF3CD4486
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 029183004CAF
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA967302767;
	Sun, 21 Dec 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJdyQaQE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325A1FC101;
	Sun, 21 Dec 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766344075; cv=none; b=QMsU+c0QBwgVme9NkRdqFHUbfBMX0C4i/nk0YkH6us+nvGQVneePSWwPpFLCrA7ES3AryRPnwLqZVYKfZpGC/347hpRXV8AN/nASU7Xl/JqWVnoOLpriWnbHfpxOQjqOY5FbUVMvYw2iJQCfKIrngm1whZpR9v2FWzKng70peO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766344075; c=relaxed/simple;
	bh=5qRIeksMsfEJsG09uI0wVp8Q5PSrhw5lrhG/r6Dm2Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgKsaCzpkWfx4/b81+2aoo5xhHeEeSD8rdVSksdW7ddOi3cs2rOeCzGqgrGllXcvwbTTxj0eiqlJ6INYISP7IkNNIOAdZ2W/13noT6POXsJgwYuXvBb4hgMZ4W+HSTsQjqbGvCQok0NKfRXvVOw55cpp2D2PdcYLtX4c/Tjpp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJdyQaQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394FAC4CEFB;
	Sun, 21 Dec 2025 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766344074;
	bh=5qRIeksMsfEJsG09uI0wVp8Q5PSrhw5lrhG/r6Dm2Bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NJdyQaQE0RKum87djB/p76VFtKzoStwkO6UQuhuJKEO51HPv4aOci1PpiVqRCfo13
	 6bqbA4/TPkTyB7oFKolG4gZTCbRxHGzpQZAR3xXaN17wp8uTA9g+HgEhCg9ewCByE/
	 BFWLAFExrSjQIiHg3jBi/ggBBxTmitBuM9Qq+tI3irDy1FeBGJULvOf4VhEWjg0vEj
	 hE9OM87+RLGyfxP67EjCP6DC4cOBQHfXN/6rKrRA7tzF+NEqnfetjiObV2AZGdJbtZ
	 nRVdWRWLA8VvW8uzvT1LeObbIP6f8E8Wbh6siljW5LWEjtgwC3/XgDT15OOnufwcb3
	 y2nIzcR+GtbZg==
Date: Sun, 21 Dec 2025 19:07:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-iio@vger.kernel.org,
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org,
 linux@roeck-us.net, Carlos Song <carlos.song@nxp.com>, Adrian Fluturel
 <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20251221190742.4162108b@jic23-huawei>
In-Reply-To: <202512202141.aAwyC19D-lkp@intel.com>
References: <20251215-i3c_ddr-v12-2-1ae31225b4d9@nxp.com>
	<202512202141.aAwyC19D-lkp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Dec 2025 22:34:47 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Frank,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-trivial-devices-add-MEMSIC-3-axis-magnetometer/20251216-010451
> base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
> patch link:    https://lore.kernel.org/r/20251215-i3c_ddr-v12-2-1ae31225b4d9%40nxp.com
> patch subject: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
> config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512202141.aAwyC19D-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202141.aAwyC19D-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512202141.aAwyC19D-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/magnetometer/mmc5633.c:362:2: error: cannot jump from switch statement to this case label  
>      362 |         default:
>          |         ^
>    drivers/iio/magnetometer/mmc5633.c:357:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      357 |                 guard(mutex)(&data->mutex);
>          |                 ^
>    include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
>      414 |         CLASS(_name, __UNIQUE_ID(guard))
>          |                      ^
>    include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
>      168 |         __PASTE(__UNIQUE_ID_,                                   \
>          |         ^
>    include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
>       16 | #define __PASTE(a, b) ___PASTE(a, b)
>          |                       ^
>    include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
>       15 | #define ___PASTE(a, b) a##b
>          |                        ^
>    <scratch space>:9:1: note: expanded from here
>        9 | __UNIQUE_ID_guard_966
>          | ^
>    1 error generated.
> 
> 
> vim +362 drivers/iio/magnetometer/mmc5633.c
> 
>    343	
>    344	static int mmc5633_write_raw(struct iio_dev *indio_dev,
>    345				     struct iio_chan_spec const *chan, int val,
>    346				     int val2, long mask)
>    347	{
>    348		struct mmc5633_data *data = iio_priv(indio_dev);
>    349		int ret;
>    350	
>    351		switch (mask) {
>    352		case IIO_CHAN_INFO_SAMP_FREQ:
{
>    353			ret = mmc5633_get_samp_freq_index(data, val, val2);
>    354			if (ret < 0)
>    355				return ret;
>    356	
>    357			guard(mutex)(&data->mutex);
>    358	
>    359			return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
>    360						  MMC5633_CTRL1_BW_MASK,
>    361						  FIELD_PREP(MMC5633_CTRL1_BW_MASK, ret));
}
Needed to add scope for the guard to apply to.
If this is all that comes up I'll fix it whilst applying.

thanks,

Jonathan

>  > 362		default:  
>    363			return -EINVAL;
>    364		}
>    365	}
>    366	
> 


