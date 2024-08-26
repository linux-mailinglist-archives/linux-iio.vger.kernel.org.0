Return-Path: <linux-iio+bounces-8799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB6895EF36
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF601C22600
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1BB14D28A;
	Mon, 26 Aug 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DboTE/v/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19447321D;
	Mon, 26 Aug 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669891; cv=none; b=bWbDm4nio+H+GkJ+FHJxw+ZFkrx4flawtNwOLjZh8p5lfPdEU2uUph4CNncZwvdeZAfDhLj4Ne8R+SLxdXNelDN+y34WdK/K3N+ROocLFa0QTdlK9xbfURV4oc0eS8/r+77pnRc5qoZh/SEsdGZTwNOFDr+suctpvVLezn//V6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669891; c=relaxed/simple;
	bh=hcaKc0Ezkqyp7WoNsBchrZvC12LrMBAs0TyShg0N7+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gv6YLgT5bqBcHrGE5155usrOGAndFxj56mhqRPPyc9TeC51wNY6dvzsC7W1xnuZrFuVQLkcU2/M4prOY272hSg4d83jjbkbPo9i4Sx9iKgAawGAv57OetgH+4QQsHPPHFCpRoVCaQ8fGUks2plTM2KCK9E71q9koo7spnYc9vzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DboTE/v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EFFC58131;
	Mon, 26 Aug 2024 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724669889;
	bh=hcaKc0Ezkqyp7WoNsBchrZvC12LrMBAs0TyShg0N7+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DboTE/v/Nk3IY08xhzY82zVzS8bcN5kjdDejAygo4TiIEbxK0MnNxaSNjSPBNEKkD
	 KvLpnchoflTtEGkYrXANdZU1szTXJym3xGmzpynA3oKx5JPpOaVcc/fF4DPGg+IK8q
	 AfZ0l47AC/nO38QYvtpqjlk0bk48p2yA5Ejt22KToHXF0+oOBb9BsXd5rdMjPE0X7I
	 8s4l3JXuUcWxpKQRm+oxPtjh1+jlIL2nJPD6s9z8zVNnE0lTzn/c4OGoCCFjbxoeuE
	 Z1jCPdwxcTuxTDGii3IblPbDqI/rNLvW39c69BgJqo8taw358b9z+QGKczVxa/e1Nq
	 u2V+PbneDoGmA==
Date: Mon, 26 Aug 2024 11:57:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: ad4695: implement calibration support
Message-ID: <20240826115756.01cd41d3@jic23-huawei>
In-Reply-To: <202408211207.fmYTjQDK-lkp@intel.com>
References: <20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
	<202408211207.fmYTjQDK-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 12:21:09 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi David,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 0f718e10da81446df0909c9939dff2b77e3b4e95]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad4695-add-2nd-regmap-for-16-bit-registers/20240821-000102
> base:   0f718e10da81446df0909c9939dff2b77e3b4e95
> patch link:    https://lore.kernel.org/r/20240820-ad4695-gain-offset-v1-2-c8f6e3b47551%40baylibre.com
> patch subject: [PATCH 2/4] iio: adc: ad4695: implement calibration support
> config: i386-buildonly-randconfig-002-20240821 (https://download.01.org/0day-ci/archive/20240821/202408211207.fmYTjQDK-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408211207.fmYTjQDK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408211207.fmYTjQDK-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/adc/ad4695.c:735:6: warning: unused variable 'ret' [-Wunused-variable]  
>      735 |         int ret;
>          |             ^~~
>    1 warning generated.
I dropped this whilst applying.

> 
> 
> vim +/ret +735 drivers/iio/adc/ad4695.c
> 
>    728	
>    729	static int ad4695_write_raw(struct iio_dev *indio_dev,
>    730				    struct iio_chan_spec const *chan,
>    731				    int val, int val2, long mask)
>    732	{
>    733		struct ad4695_state *st = iio_priv(indio_dev);
>    734		unsigned int reg_val;
>  > 735		int ret;  
>    736	
>    737		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>    738			switch (mask) {
>    739			case IIO_CHAN_INFO_CALIBSCALE:
>    740				switch (chan->type) {
>    741				case IIO_VOLTAGE:
>    742					if (val < 0 || val2 < 0)
>    743						reg_val = 0;
>    744					else if (val > 1)
>    745						reg_val = U16_MAX;
>    746					else
>    747						reg_val = (val * (1 << 16) +
>    748							   mul_u64_u32_div(val2, 1 << 16,
>    749									   MICRO)) / 2;
>    750	
>    751					return regmap_write(st->regmap16,
>    752						AD4695_REG_GAIN_IN(chan->scan_index),
>    753						reg_val);
>    754				default:
>    755					return -EINVAL;
>    756				}
>    757			case IIO_CHAN_INFO_CALIBBIAS:
>    758				switch (chan->type) {
>    759				case IIO_VOLTAGE:
>    760					if (val2 >= 0 && val > S16_MAX / 4)
>    761						reg_val = S16_MAX;
>    762					else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
>    763						reg_val = S16_MIN;
>    764					else if (val2 < 0)
>    765						reg_val = clamp_t(int,
>    766							-(val * 4 + -val2 * 4 / MICRO),
>    767							S16_MIN, S16_MAX);
>    768					else if (val < 0)
>    769						reg_val = clamp_t(int,
>    770							val * 4 - val2 * 4 / MICRO,
>    771							S16_MIN, S16_MAX);
>    772					else
>    773						reg_val = clamp_t(int,
>    774							val * 4 + val2 * 4 / MICRO,
>    775							S16_MIN, S16_MAX);
>    776	
>    777					return regmap_write(st->regmap16,
>    778						AD4695_REG_OFFSET_IN(chan->scan_index),
>    779						reg_val);
>    780				default:
>    781					return -EINVAL;
>    782				}
>    783			default:
>    784				return -EINVAL;
>    785			}
>    786		}
>    787		unreachable();
>    788	}
>    789	
> 


