Return-Path: <linux-iio+bounces-25271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5BBEE36E
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 12:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C9618999C1
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649C2E2F15;
	Sun, 19 Oct 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvi4CUAn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF02D94A4;
	Sun, 19 Oct 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871313; cv=none; b=nAg3TN+J6s8I76gfhwiCaCm8YzC372DSnP9j4KllQ83I7201qnZENqkZAwotQIk02ibubv7+gL3qKsdw3FIG0y7ui6G7mF85T/It+lUIzMENeTXUVPmo9GbQrc+ReXiORIhwSU4lDbt4HB2e1lzd7oM8u+3ANuR3DywfPog6EM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871313; c=relaxed/simple;
	bh=+ziRoO8LbcYJBQUd3O3Nu6w/z37nZrkeoqvuFfTnALY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLppU1EvXY13gALKYnXN4h6avT3yZMz2eHGUBJ8zmlfS5opCx3FFsL3C7KkoBEyuSQ/733J0h6CNkj+D9bJijyuPBYqe13ijWH6becgS2brREyeChL8zleYoeb4RoRtYa0hsjxjdDWRzHcRkLzmEgxRD/1OBb+OMmKxJkrM42Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvi4CUAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B34CC4CEE7;
	Sun, 19 Oct 2025 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760871311;
	bh=+ziRoO8LbcYJBQUd3O3Nu6w/z37nZrkeoqvuFfTnALY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvi4CUAn5YHZgRgIQnGJsXEkDbqdJuGnlzuH68lGlwxwb/R9xeYJ2S6V438jAVimC
	 VHw2YKSgg57ZzM1iSu+AeA5AZRN1/On5pgFHOGMban2DENkPkYQ5S1o731shEJbi0d
	 iH2W9dsqAbm3jTH0GyUGRkjTwzrZ/Bd18ezGS0CfsO7h5wqoyYDK4UH2aGR3MkA696
	 SNedRnI16weP4Om/AF1J8x9WWRP6PfVCB1qpJt15mj+ZERn+21hb7zCQyXxpULER2C
	 lfMdijgSVNbIuElN4LJ9T7EObf2I8VxNXJwjS3n9hZ2QMLBGJ1x1y5PZEu8YcxdCU+
	 ORDzX7QuU1obw==
Date: Sun, 19 Oct 2025 11:55:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Remi Buisson <remi.buisson@tdk.com>, oe-kbuild-all@lists.linux.dev,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [jic23-iio:testing 69/79]
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c:41:39: warning: field
 accel within 'struct inv_icm45600_fifo_2sensors_packet' is less aligned
 than 'struct inv_icm45600_fifo_sensor_data' and is usually due to 'struct
 inv_icm45600_fifo_2sensors_packet' b...
Message-ID: <20251019115506.4cd195d8@jic23-huawei>
In-Reply-To: <202510160550.GqthmiPd-lkp@intel.com>
References: <202510160550.GqthmiPd-lkp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 05:18:31 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
> commit: c7dd90861c9052f7e28ef93fa03aeb94cb5dc43b [69/79] iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
> config: arm-randconfig-r072-20251016 (https://download.01.org/0day-ci/archive/20251016/202510160550.GqthmiPd-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510160550.GqthmiPd-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510160550.GqthmiPd-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c:41:39: warning: field accel within 'struct inv_icm45600_fifo_2sensors_packet' is less aligned than 'struct inv_icm45600_fifo_sensor_data' and is usually due to 'struct inv_icm45600_fifo_2sensors_packet' being packed, which can lead to unaligned accesses [-Wunaligned-access]  
>       41 |         struct inv_icm45600_fifo_sensor_data accel;
>          |                                              ^
> >> drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c:42:39: warning: field gyro within 'struct inv_icm45600_fifo_2sensors_packet' is less aligned than 'struct inv_icm45600_fifo_sensor_data' and is usually due to 'struct inv_icm45600_fifo_2sensors_packet' being packed, which can lead to unaligned accesses [-Wunaligned-access]  
>       42 |         struct inv_icm45600_fifo_sensor_data gyro;
>          |                                              ^
> >> drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c:35:39: warning: field data within 'struct inv_icm45600_fifo_1sensor_packet' is less aligned than 'struct inv_icm45600_fifo_sensor_data' and is usually due to 'struct inv_icm45600_fifo_1sensor_packet' being packed, which can lead to unaligned accesses [-Wunaligned-access]  
>       35 |         struct inv_icm45600_fifo_sensor_data data;
>          |                                              ^
>    3 warnings generated.
> 
> 
> vim +41 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> 
> 7e1e1e37402c95 Remi Buisson 2025-10-07  32  
> 7e1e1e37402c95 Remi Buisson 2025-10-07  33  struct inv_icm45600_fifo_1sensor_packet {
> 7e1e1e37402c95 Remi Buisson 2025-10-07  34  	u8 header;
> 7e1e1e37402c95 Remi Buisson 2025-10-07 @35  	struct inv_icm45600_fifo_sensor_data data;
> 7e1e1e37402c95 Remi Buisson 2025-10-07  36  	s8 temp;
> 7e1e1e37402c95 Remi Buisson 2025-10-07  37  } __packed;
> 7e1e1e37402c95 Remi Buisson 2025-10-07  38  
> 7e1e1e37402c95 Remi Buisson 2025-10-07  39  struct inv_icm45600_fifo_2sensors_packet {
> 7e1e1e37402c95 Remi Buisson 2025-10-07  40  	u8 header;
> 7e1e1e37402c95 Remi Buisson 2025-10-07 @41  	struct inv_icm45600_fifo_sensor_data accel;
> 7e1e1e37402c95 Remi Buisson 2025-10-07 @42  	struct inv_icm45600_fifo_sensor_data gyro;
> 7e1e1e37402c95 Remi Buisson 2025-10-07  43  	s8 temp;
> 7e1e1e37402c95 Remi Buisson 2025-10-07  44  	__le16 timestamp;
> 7e1e1e37402c95 Remi Buisson 2025-10-07  45  } __packed;
> 7e1e1e37402c95 Remi Buisson 2025-10-07  46  

So this seems to be a new warning that older versions of clang don't generate (20 doesn't
for instance).

I'm not 100% sure though on the fix.
Is marking struct inv_icm45600_fifo_sensor_data __packed sufficient?  I'll add that
to the tree and push out again.

Jonathan

> 
> :::::: The code at line 41 was first introduced by commit
> :::::: 7e1e1e37402c95acd5ae6aace9e363a982038b11 iio: imu: inv_icm45600: add buffer support in iio devices
> 
> :::::: TO: Remi Buisson <remi.buisson@tdk.com>
> :::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 


