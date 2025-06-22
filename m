Return-Path: <linux-iio+bounces-20860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F3AE3051
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C239A16C7F3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877011E834C;
	Sun, 22 Jun 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxmkVWeM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319F1A29A;
	Sun, 22 Jun 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750601562; cv=none; b=pTXtwsXOmfytKuVVNidzYsxmU/jBSOM2YfnYOPegY3W7RFMfQgXSHTs3LTkHzxP79GLtEssX/kqQXOZkhA0bhUfrz+vEL2r/euvOxcE4K1hOlMdQ/qyQSuWF+uBCt+3IJanbGWc9JZUEF4lxXR9MQxXuTaESEpxxEMccpJkIE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750601562; c=relaxed/simple;
	bh=9VDxcEDeTXSz1b5+DV5HGAIX25Kp6FJniTBdDExX7gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrY2PWJ8EPC+8TslmPpAboiEIf8MHG8Dp1tNPanvR+aDLbOD/Qgbqm5DNd4fc2kEHQmKDzJGpFkT7GEfUujSDL6YaGVVuWc5j2u4k+MtTfh1LjkFvKIZFDdbCZbai8T+zl1aSZ1t3TtxcsW6BGn+rvtUIcM5Y0c0zX+K7tYfhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxmkVWeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47874C4CEF0;
	Sun, 22 Jun 2025 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750601561;
	bh=9VDxcEDeTXSz1b5+DV5HGAIX25Kp6FJniTBdDExX7gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxmkVWeMSIIOOfC+VevmCSdp6/dYJtwapGDfSAmKhXcEDvO0d19Y6DxfXFvzYBDBK
	 otsZw1LZdOMeTbXIjBOLt4eMFWgFz3TV0U2IwfbvXyExeui+H/AFRHmYy5BZmhR/eN
	 8bEzddXTJLlw6JDhbV24OBKHZO/JjJ1n4UbRb7/e/zwCQPfkQcXFrIS6ReC9rTP+y3
	 vr51nZ3XyHWQU0rFvAUE+Rgihn4g8Ok/TQWbmFcHFuTgtbWiCka/weJpCP/P7fHu0F
	 idJY95TfK7+xzcLqXk0wSC84LZ0BVKP6+bl//Uea2hZq9JTkt9ytEtlcRsOf9MTzfm
	 4lj5meFjmdVIg==
Date: Sun, 22 Jun 2025 15:12:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 broonie@kernel.org, lgirdwood@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v6 06/12] iio: adc: ad4170: Add digital filter and
 sample frequency config support
Message-ID: <20250622151229.4e56e8ae@jic23-huawei>
In-Reply-To: <202506201000.WjqDvyXl-lkp@intel.com>
References: <bc0261373936511a6ae5b25082e36ac5f112f6db.1750258776.git.marcelo.schmitt@analog.com>
	<202506201000.WjqDvyXl-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 10:38:58 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Marcelo,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-Add-AD4170/20250619-014200
> base:   4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
> patch link:    https://lore.kernel.org/r/bc0261373936511a6ae5b25082e36ac5f112f6db.1750258776.git.marcelo.schmitt%40analog.com
> patch subject: [PATCH v6 06/12] iio: adc: ad4170: Add digital filter and sample frequency config support
> config: microblaze-randconfig-r133-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201000.WjqDvyXl-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 8.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20250620/202506201000.WjqDvyXl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506201000.WjqDvyXl-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/adc/ad4170.c: In function 'ad4170_read_avail':
> >> drivers/iio/adc/ad4170.c:1237:18: warning: array subscript 4294967274 is above array bounds of 'int[3][18][2]' [-Warray-bounds]  
>       *vals = (int *)st->sps_tbl[f_type];
>                      ^~
> 
> 
> vim +1237 drivers/iio/adc/ad4170.c
> 
>   1219	
>   1220	static int ad4170_read_avail(struct iio_dev *indio_dev,
>   1221				     struct iio_chan_spec const *chan,
>   1222				     const int **vals, int *type, int *length,
>   1223				     long info)
>   1224	{
>   1225		struct ad4170_state *st = iio_priv(indio_dev);
>   1226		struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
>   1227		enum ad4170_filter_type f_type;
>   1228	
>   1229		switch (info) {
>   1230		case IIO_CHAN_INFO_SCALE:
>   1231			*vals = (int *)chan_info->scale_tbl;
>   1232			*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
>   1233			*type = IIO_VAL_INT_PLUS_NANO;
>   1234			return IIO_AVAIL_LIST;
>   1235		case IIO_CHAN_INFO_SAMP_FREQ:
>   1236			f_type = ad4170_get_filter_type(indio_dev, chan);
> > 1237			*vals = (int *)st->sps_tbl[f_type];  

I think this needs an error check as the function can return -EINVAL ?

>   1238			*type = IIO_VAL_INT_PLUS_MICRO;
>   1239			switch (f_type) {
>   1240			case AD4170_SINC5_AVG:
>   1241			case AD4170_SINC3:
>   1242				*length = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl) * 2;
>   1243				return IIO_AVAIL_LIST;
>   1244			case AD4170_SINC5:
>   1245				*length = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl) * 2;
>   1246				return IIO_AVAIL_LIST;
>   1247			default:
>   1248				return -EINVAL;
>   1249			}
>   1250		default:
>   1251			return -EINVAL;
>   1252		}
>   1253	}
>   1254	
> 


