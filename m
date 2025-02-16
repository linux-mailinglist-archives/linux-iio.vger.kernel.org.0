Return-Path: <linux-iio+bounces-15572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B053A37523
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5B716EB5D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF01192B77;
	Sun, 16 Feb 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWaibguL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4415F3FF;
	Sun, 16 Feb 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720358; cv=none; b=q9tsbxapKmU7xP4Iuv8X3KFwpcDa7nVZQ9qQbQghzZcwA15u1RjayHkh+zE7V2zRS7MCZKU4R2HdUxXQvEKjargRbz5c35G8aAVifzwGB3SU89CZGgs5aDFUC/g55ZaxsDmdC6GqqiEjW65L5r6EzbUXQjGOz5/1nxRrlIvLXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720358; c=relaxed/simple;
	bh=oYWfdMk4zc/CP1Qi+zyDHu/NZtY0zPRAGOxMUVd418c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Daoh/2MkivmeSeWXmsCPnJ3afxkGz65K6D+TMXfvr3fVq7TVhEExGa3kd7Gb93bho3McXI4mAfUbW6UPnl8JnAAKUe22jMJMprUwRCRXq5EjdcOEVqoAntepJZJnDOMXy+VKFmmIloiyzx+47q48NG4Sq2XQlqfg/65EAlTrhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWaibguL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0821C4CEE9;
	Sun, 16 Feb 2025 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739720357;
	bh=oYWfdMk4zc/CP1Qi+zyDHu/NZtY0zPRAGOxMUVd418c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZWaibguLuSz3ed5OSK5rwAPfxQRmErSipouP04ETiTth3UyJrfOmB1WGpom3mBqg+
	 S/cB3XIjLE42YaD/02QbK6tWk13rl1ZTF/GViJa6zNuevw88fTRwST3u814HSQfgwa
	 EfdARTs0MAlKYzzGUpfnGP3L7/gE263GwWPb8UX/Ko9ONwL6N88v/TOfqN8Bjy0SYQ
	 VAX7HTNRQZ+7cYN6jeu9XhubKyLg5CZxW6i8o3Njl5ciEHXaCbjHz/j6+1ESJTir/5
	 AOFkg6EIwNwjr2PeriEQhi1/h62hL6ZEAvbYwlaSoSsLW5LvoyTKO9UslGyupriokL
	 zekguPDFs6VVg==
Date: Sun, 16 Feb 2025 15:39:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, oe-kbuild-all@lists.linux.dev,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
Message-ID: <20250216153906.6191fded@jic23-huawei>
In-Reply-To: <202502160240.IoVS8Klu-lkp@intel.com>
References: <20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a@baylibre.com>
	<202502160240.IoVS8Klu-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 03:00:59 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Esteban,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on a64dcfb451e254085a7daee5fe51bf22959d52d3]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/dt-bindings-iio-adc-add-ADI-ad4030-ad4630-and-ad4632/20250214-202727
> base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
> patch link:    https://lore.kernel.org/r/20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a%40baylibre.com
> patch subject: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250216/202502160240.IoVS8Klu-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160240.IoVS8Klu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502160240.IoVS8Klu-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/adc/ad4030.c: In function 'ad4030_get_chan_scale':
> >> drivers/iio/adc/ad4030.c:375:27: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]  
>      375 |                 scan_type = iio_get_current_scan_type(indio_dev,
>          |                           ^
> 
> 
I applied
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index ed31a3d1d13b..d026535e5d9b 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -369,7 +369,7 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
                                 int *val2)
 {
        struct ad4030_state *st = iio_priv(indio_dev);
-       struct iio_scan_type *scan_type;
+       const struct iio_scan_type *scan_type;
 
        if (chan->differential) {
                scan_type = iio_get_current_scan_type(indio_dev,

Whilst picking this up.

> vim +/const +375 drivers/iio/adc/ad4030.c
> 
>    365	
>    366	static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
>    367					 struct iio_chan_spec const *chan,
>    368					 int *val,
>    369					 int *val2)
>    370	{
>    371		struct ad4030_state *st = iio_priv(indio_dev);
>    372		struct iio_scan_type *scan_type;
>    373	
>    374		if (chan->differential) {
>  > 375			scan_type = iio_get_current_scan_type(indio_dev,  
>    376							      st->chip->channels);
>    377			*val = (st->vref_uv * 2) / MILLI;
>    378			*val2 = scan_type->realbits;
>    379			return IIO_VAL_FRACTIONAL_LOG2;
>    380		}
>    381	
>    382		*val = st->vref_uv / MILLI;
>    383		*val2 = chan->scan_type.realbits;
>    384		return IIO_VAL_FRACTIONAL_LOG2;
>    385	}
>    386	
> 


