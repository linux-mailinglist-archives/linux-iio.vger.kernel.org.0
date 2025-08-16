Return-Path: <linux-iio+bounces-22802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75CBB28D99
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13FE7B42FE
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173C12877FA;
	Sat, 16 Aug 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN+fA+et"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5423202963;
	Sat, 16 Aug 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346613; cv=none; b=AoSHIgGFLm6F62lI4YloEncw3GVqofYMwf+sPLqL7bv+DkO6qvyrCGiQOoIXaQRp1zDvlJW2w6n0jvYEauFjRcd198cQiJa3Dm6kEbn/XuUru0qD705LBTjm/xAu2P+UfjqfgR3Xg88XcZFh1TSD1ztFlCLPECXVKryaRMDSSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346613; c=relaxed/simple;
	bh=gfket+V11Lez8BS3IM3c/+h8aRCcutug/kXRynqIesg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aolnzwncWpVhSjrsjSC6bZqr2qvJrjQkOM3u9NBUidEasQC8M2Zt5HwkFpdrBH/AG1AZx5Ptx4TyRSePOEXfydW7nQ6yKpsQ66Ld6sKNupUZxZ4966K4eu3bjPp1Km5xuAf5Owse8YqD6m9VUZ7AyXrIEPmUNKdxYnSksNqUulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN+fA+et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D95C4CEEF;
	Sat, 16 Aug 2025 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755346613;
	bh=gfket+V11Lez8BS3IM3c/+h8aRCcutug/kXRynqIesg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IN+fA+et9rspeMG+wkRMPcbDcbtQL7Bo2+79OZ8yR7aHpq5ZHTBvam+Ze5A61VytV
	 5lh1ljH+RwHZufFeN8gSq+OFc23Eynx9fug7sllhLMfv5L3Wz0TU723l5MqmPXVZJl
	 vIN00gr5svIBW7dMVarqCB8uAkT1Ja3LZBvPNT14VQdEHzYNHRvkUw47ghXugHmLhQ
	 g1CmD13VOTZ7ezcjFB0AJ6r+qXC7o14Z0xd3EF2v1aA4/1Z89pKZX0n2ujht9h5lZ8
	 JYtlQ3ohGcbzfZ67jy2bpqqter+vuVB52B61zYl9jYV9+Q6NR8QcZn/7PU83nDzgeq
	 zSPfrd0M8hbCQ==
Date: Sat, 16 Aug 2025 13:16:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
Subject: Re: [PATCH v4 6/9] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Message-ID: <20250816131643.635ed15c@jic23-huawei>
In-Reply-To: <202508151941.BweGaEVT-lkp@intel.com>
References: <20250814-add_newport_driver-v4-6-4464b6600972@tdk.com>
	<202508151941.BweGaEVT-lkp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 19:31:38 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Remi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on f8f559752d573a051a984adda8d2d1464f92f954]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Remi-Buisson-via-B4-Relay/dt-bindings-iio-imu-Add-inv_icm45600/20250814-170722
> base:   f8f559752d573a051a984adda8d2d1464f92f954
> patch link:    https://lore.kernel.org/r/20250814-add_newport_driver-v4-6-4464b6600972%40tdk.com
> patch subject: [PATCH v4 6/9] iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250815/202508151941.BweGaEVT-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151941.BweGaEVT-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508151941.BweGaEVT-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:908:12: warning: result of comparison of constant 32768 with expression of type 's16' (aka 'short') is always false [-Wtautological-constant-out-of-range-compare]  
>      908 |         if (*temp == INV_ICM45600_DATA_INVALID)
>          |             ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
That one will need fixing up.

>    drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:785:12: warning: unused function 'inv_icm45600_suspend' [-Wunused-function]
>      785 | static int inv_icm45600_suspend(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~~~~
These too me a minute.  You have the deprecated functions for actually filling in 

+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm45600_pm_ops, IIO_ICM45600) = {
+	SET_SYSTEM_SLEEP_PM_OPS(inv_icm45600_suspend, inv_icm45600_resume)
+	SET_RUNTIME_PM_OPS(inv_icm45600_runtime_suspend,
+			   inv_icm45600_runtime_resume, NULL)
+};
+

should be
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm45600_pm_ops, IIO_ICM45600) = {
+	SYSTEM_SLEEP_PM_OPS(inv_icm45600_suspend, inv_icm45600_resume)
+	RUNTIME_PM_OPS(inv_icm45600_runtime_suspend,
+			   inv_icm45600_runtime_resume, NULL)
+};
+
Or use _DEFINE_DEV_PM_OPS() to set all this.

>    drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:820:12: warning: unused function 'inv_icm45600_resume' [-Wunused-function]
>      820 | static int inv_icm45600_resume(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~~~
>    drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:860:12: warning: unused function 'inv_icm45600_runtime_suspend' [-Wunused-function]
>      860 | static int inv_icm45600_runtime_suspend(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:879:12: warning: unused function 'inv_icm45600_runtime_resume' [-Wunused-function]
>      879 | static int inv_icm45600_runtime_resume(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    5 warnings generated.
> 
> 
> vim +908 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> 
> 8891b99381240f Remi Buisson 2025-08-14  887  
> 2570c7e48ace35 Remi Buisson 2025-08-14  888  static int _inv_icm45600_temp_read(struct inv_icm45600_state *st, s16 *temp)
> 2570c7e48ace35 Remi Buisson 2025-08-14  889  {
> 2570c7e48ace35 Remi Buisson 2025-08-14  890  	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
> 2570c7e48ace35 Remi Buisson 2025-08-14  891  	int ret;
> 2570c7e48ace35 Remi Buisson 2025-08-14  892  
> 2570c7e48ace35 Remi Buisson 2025-08-14  893  	/* Make sure a sensor is on. */
> 2570c7e48ace35 Remi Buisson 2025-08-14  894  	if (st->conf.gyro.mode == INV_ICM45600_SENSOR_MODE_OFF &&
> 2570c7e48ace35 Remi Buisson 2025-08-14  895  	    st->conf.accel.mode == INV_ICM45600_SENSOR_MODE_OFF) {
> 2570c7e48ace35 Remi Buisson 2025-08-14  896  		conf.mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
> 2570c7e48ace35 Remi Buisson 2025-08-14  897  		ret = inv_icm45600_set_accel_conf(st, &conf, NULL);
> 2570c7e48ace35 Remi Buisson 2025-08-14  898  		if (ret)
> 2570c7e48ace35 Remi Buisson 2025-08-14  899  			return ret;
> 2570c7e48ace35 Remi Buisson 2025-08-14  900  	}
> 2570c7e48ace35 Remi Buisson 2025-08-14  901  
> 2570c7e48ace35 Remi Buisson 2025-08-14  902  	ret = regmap_bulk_read(st->map, INV_ICM45600_REG_TEMP_DATA,
> 2570c7e48ace35 Remi Buisson 2025-08-14  903  				&st->buffer.u16, sizeof(st->buffer.u16));
> 2570c7e48ace35 Remi Buisson 2025-08-14  904  	if (ret)
> 2570c7e48ace35 Remi Buisson 2025-08-14  905  		return ret;
> 2570c7e48ace35 Remi Buisson 2025-08-14  906  
> 2570c7e48ace35 Remi Buisson 2025-08-14  907  	*temp = (s16)le16_to_cpup(&st->buffer.u16);
> 2570c7e48ace35 Remi Buisson 2025-08-14 @908  	if (*temp == INV_ICM45600_DATA_INVALID)
> 2570c7e48ace35 Remi Buisson 2025-08-14  909  		return -EINVAL;
> 2570c7e48ace35 Remi Buisson 2025-08-14  910  
> 2570c7e48ace35 Remi Buisson 2025-08-14  911  	return 0;
> 2570c7e48ace35 Remi Buisson 2025-08-14  912  }
> 2570c7e48ace35 Remi Buisson 2025-08-14  913  
> 


