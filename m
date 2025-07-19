Return-Path: <linux-iio+bounces-21777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAACB0B048
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA72564C3E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535122157B;
	Sat, 19 Jul 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfPm4gpD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2D14883F;
	Sat, 19 Jul 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752931978; cv=none; b=rQZ53UftUfbrs6f0RU4lyF12nXypjiBqACFp2tNysubi2/buNTeZJnX+0YpvsdMmH6ZVPBEvuJoJhVRP8cdxN1OSkhwmLb44QBoPrrPJLISBdlbIgpkQjLJh+6NoqPxtmtiD1xcMKeCCeFQP2fQZ2ulKaIHi0RCxIucBEUzzKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752931978; c=relaxed/simple;
	bh=SBYcDz1ru58OTFpL1ENwBR1B6jCp0163ii6LzeGWhxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRQ7kdwjGn63Bafv6A5S3CC7+QcEGWJP2xkLACCiKRM9DyoExiD9V4PUlTXmk1MCUllpSXTUr34WqWF6tQEW8edZdemPeerWTt7C8e2itWm5M8ASq0wEGlQBas3EaPJRWF2D9GMgdpheVjMnCBYWVaLWT7DBNbVtrcbQiA2u/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfPm4gpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B084C4CEE3;
	Sat, 19 Jul 2025 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752931978;
	bh=SBYcDz1ru58OTFpL1ENwBR1B6jCp0163ii6LzeGWhxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfPm4gpDc7Dw7wQ6b1C7StxCzMxqwRDYrq/FMZ7rTlxo7QoGaenAiYoZANZ/KRIF1
	 PZ6l5qpID3qXdoALvxPyKnwZ90g4hdrF1hx0+iv5Hl0t8Y0O28NeGwL9E9GXjC43nK
	 IdcYSRmGPTqkqvo9TA8P2vlQINGVjnQKknC6THyPNKCBupzx7TWD3buDvCr3/PK1lx
	 yyQRtApiLxzch0WuK8SAw1w7xPLbiyDSQd21q8XrMJMqvNj77+scBkzGPbshD2UNhR
	 iCzu4ZbMvfJ8wnDBRXhhulkGjNkSu7iVoIiypoVT5nUcWJmPsaBN3OZvdDSzpQ3rNz
	 9CESsyQimu2tA==
Date: Sat, 19 Jul 2025 14:32:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <20250719143250.6799eb5d@jic23-huawei>
In-Reply-To: <20250719124711.42fe1a00@jic23-huawei>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
	<20250713152810.4483c786@jic23-huawei>
	<ie3zr2mvuss2f7prksw6nuc3wonig5ju6y6hqq46upvkhovwpa@vtfc3tqwz3d5>
	<76fnxeuufv56fmfvq6odi5xz2yjtjxymz24t436zk7rtuyst4s@oihlvsoxhllp>
	<20250716090010.23ea03b6@jic23-huawei>
	<iwe34sdzsgeqpgqrc7ndbx6n4ef6kiwd4bczbiwbhlfgv3zesx@rnr5l7diy5z7>
	<20250719124711.42fe1a00@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 12:47:11 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 18 Jul 2025 06:40:50 +0000
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > On Wed, Jul 16, 2025 at 09:00:10AM +0100, Jonathan Cameron wrote:  
> > > On Mon, 14 Jul 2025 07:42:43 +0000
> > > Sean Nyekjaer <sean@geanix.com> wrote:
> > >     
> > > > On Mon, Jul 14, 2025 at 07:24:57AM +0100, Sean Nyekjaer wrote:    
> > > > > On Sun, Jul 13, 2025 at 03:28:10PM +0100, Jonathan Cameron wrote:    
> > > > > > On Wed, 09 Jul 2025 14:35:12 +0200
> > > > > > Sean Nyekjaer <sean@geanix.com> wrote:
> > > > > >    
> > > > > > > Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> > > > > > > calls during probe. These are not required when the device is marked
> > > > > > > active via pm_runtime_set_active() before enabling pm_runtime with
> > > > > > > pm_runtime_enable().
> > > > > > >
> > > > > > > Also remove the redundant pm_runtime_put_sync() call from the cleanup
> > > > > > > path, since the core is not incrementing the usage count beforehand.
> > > > > > >
> > > > > > > This simplifies the PM setup and avoids manipulating the usage counter
> > > > > > > unnecessarily.    
> > > > > >
> > > > > > Could we switch directly to using devm_pm_runtime_enable() for this driver?
> > > > > >
> > > > > > At first glance looks like this code is missing the disable of autosuspend
> > > > > > that should be there (which devm_pm_runtime_enable() will also handle).
> > > > > >    
> > > > >
> > > > > I have tried to use devm_pm_runtime_enable() but on rmmod it warns
> > > > > "unbalanced disables for regulator"
> > > > >
> > > > > If I remove this:
> > > > > -	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vddio_reg, st);
> > > > > -	if (ret)
> > > > > -		return ret;
> > > > >
> > > > > Everything seems okay again. I have checked with printk's that
> > > > > inv_icm42600_disable_vddio_reg() is called twice with
> > > > > devm_pm_runtime_enable() used.
> > > > > Does it make sense?
> > > > >
> > > > > /Sean    
> > > >
> > > > with pm_runtime_enable():
> > > > root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-icm42600-i2c.ko
> > > > [ 3793.713077] inv-icm42600-i2c 1-0068: no INT1 interrupt defined, fallback to first interrupt
> > > > [ 3793.727728] inv-icm42600-i2c 1-0068: mounting matrix not found: using identity...
> > > > [ 3793.737660] inv-icm42600-i2c 1-0068: supply vdd not found, using dummy regulator
> > > > [ 3793.856891] inv-icm42600-i2c 1-0068: supply vddio not found, using dummy regulator
> > > > [ 3793.866872] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > [ 3793.920739] inv_icm42600_runtime_suspend() disable vddio
> > > > root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
> > > > [ 3796.954850] inv_icm42600_runtime_resume() -> inv_icm42600_enable_regulator_vddio()
> > > > [ 3796.954910] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > [ 3796.985140] inv_icm42600_disable_vddio_reg() disable vddio
> > > >
> > > > with devm_pm_runtime_enable():
> > > > root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-icm42600-i2c.ko
> > > > [ 3852.873887] inv-icm42600-i2c 1-0068: no INT1 interrupt defined, fallback to first interrupt
> > > > [ 3852.888715] inv-icm42600-i2c 1-0068: mounting matrix not found: using identity...
> > > > [ 3852.898514] inv-icm42600-i2c 1-0068: supply vdd not found, using dummy regulator
> > > > [ 3853.016890] inv-icm42600-i2c 1-0068: supply vddio not found, using dummy regulator
> > > > [ 3853.026860] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > [ 3853.080835] inv_icm42600_runtime_suspend() disable vddio
> > > > root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
> > > > [ 3854.448461] inv_icm42600_runtime_resume() -> inv_icm42600_enable_regulator_vddio()
> > > > [ 3854.448540] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > [ 3854.467061] inv_icm42600_runtime_suspend() disable vddio    
> > > 
> > > As below What is the call path for this final suspend?
> > > Is it coming from update_autosuspend()?    
> > 
> > Yeah it looks like pm_runtime_dont_use_autosuspend() is calling runtime_suspend().  
> 
> ok. So how are we supposed to handle this?  Seems like it would be a fairly common
> situation.  devm_pm_runtime_set_active_enabled() might be relevant.
> I get confused by all the reference counter
> complexity in runtime pm but is devm_pm_runtime_get_noresume() what we want?
> That will decrement the usage count with no action just before we hit the point
> were the suspend or not decision is made.  So I think that will mean the device
> things it is already suspended when you hit the path here and so not do it again?
>  
> There seems to be only one user of this stuff though:
> https://elixir.bootlin.com/linux/v6.15.6/source/drivers/spi/atmel-quadspi.c#L1440
Note that example does a get in the remove callback().   Seems odd but maybe
we need a devm_pm_runtime_*put() that results in an a get in the remove path to ensure counts
all match.

> > 
> > root@v4:/data/root# rmmod inv-icm42600-i2c inv-icm42600
> > [  291.511085] inv_icm42600_runtime_resume() -> inv_icm42600_enable_regulator_vddio()
> > [  291.511165] inv_icm42600_enable_regulator_vddio() enable vddio
> > [  291.532398] inv_icm42600_runtime_suspend() disable vddio
> > [  291.538517] CPU: 0 UID: 0 PID: 331 Comm: rmmod Tainted: G        W           6.16.0-rc1-00202-g7fe6e564b5c9-dirty #146 VOLUNTARY
> > [  291.538559] Tainted: [W]=WARN
> > [  291.538566] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> > [  291.538575] Call trace:
> > [  291.538590]  unwind_backtrace from show_stack+0x10/0x14
> > [  291.538643]  show_stack from dump_stack_lvl+0x54/0x68
> > [  291.538679]  dump_stack_lvl from inv_icm42600_runtime_suspend+0x68/0x6c [inv_icm42600]
> > [  291.538728]  inv_icm42600_runtime_suspend [inv_icm42600] from __rpm_callback+0x48/0x18c
> > [  291.538775]  __rpm_callback from rpm_callback+0x5c/0x68
> > [  291.538815]  rpm_callback from rpm_suspend+0xdc/0x584
> > [  291.538853]  rpm_suspend from pm_runtime_disable_action+0x30/0x5c
> > [  291.538885]  pm_runtime_disable_action from devres_release_group+0x180/0x1a0
> > [  291.538917]  devres_release_group from i2c_device_remove+0x34/0x84
> > [  291.538949]  i2c_device_remove from device_release_driver_internal+0x180/0x1f4
> > [  291.538976]  device_release_driver_internal from driver_detach+0x54/0xa0
> > [  291.538998]  driver_detach from bus_remove_driver+0x58/0xa4
> > [  291.539030]  bus_remove_driver from sys_delete_module+0x16c/0x250
> > [  291.539065]  sys_delete_module from ret_fast_syscall+0x0/0x54
> > [  291.539089] Exception stack(0xd0ab1fa8 to 0xd0ab1ff0)
> > [  291.539108] 1fa0:                   be94fe46 be94fd1c 017ccfa4 00000800 0000000a 017ccf68
> > [  291.539126] 1fc0: be94fe46 be94fd1c 017ccf68 00000081 00000000 00000001 00000003 017cc190
> > [  291.539139] 1fe0: b6c8be41 be94fadc 000179cb b6c8be48
> > [  291.685102] inv_icm42600_disable_vddio_reg() disable vddio
> > [  291.694566] ------------[ cut here ]------------
> > [  291.694621] WARNING: CPU: 0 PID: 331 at drivers/regulator/core.c:3016 _regulator_disable+0x140/0x1a0
> > [  291.708496] unbalanced disables for regulator-dummy
> > [  291.713391] Modules linked in: inv_icm42600_i2c(-) inv_icm42600 inv_sensors_timestamp [last unloaded: inv_icm42600]
> > [  291.723939] CPU: 0 UID: 0 PID: 331 Comm: rmmod Tainted: G        W           6.16.0-rc1-00202-g7fe6e564b5c9-dirty #146 VOLUNTARY
> > [  291.735620] Tainted: [W]=WARN
> > [  291.738598] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> > [  291.744789] Call trace:
> > [  291.744807]  unwind_backtrace from show_stack+0x10/0x14
> > [  291.752614]  show_stack from dump_stack_lvl+0x54/0x68
> > [  291.757704]  dump_stack_lvl from __warn+0x7c/0xe0
> > [  291.762437]  __warn from warn_slowpath_fmt+0x124/0x18c
> > [  291.767602]  warn_slowpath_fmt from _regulator_disable+0x140/0x1a0
> > [  291.773812]  _regulator_disable from regulator_disable+0x48/0x80
> > [  291.779843]  regulator_disable from devres_release_group+0x180/0x1a0
> > [  291.786231]  devres_release_group from i2c_device_remove+0x34/0x84
> > [  291.792446]  i2c_device_remove from device_release_driver_internal+0x180/0x1f4
> > [  291.799699]  device_release_driver_internal from driver_detach+0x54/0xa0
> > [  291.806427]  driver_detach from bus_remove_driver+0x58/0xa4
> > [  291.812033]  bus_remove_driver from sys_delete_module+0x16c/0x250
> > [  291.818160]  sys_delete_module from ret_fast_syscall+0x0/0x54
> > [  291.823934] Exception stack(0xd0ab1fa8 to 0xd0ab1ff0)
> > [  291.829007] 1fa0:                   be94fe46 be94fd1c 017ccfa4 00000800 0000000a 017ccf68
> > [  291.837205] 1fc0: be94fe46 be94fd1c 017ccf68 00000081 00000000 00000001 00000003 017cc190
> > [  291.845397] 1fe0: b6c8be41 be94fadc 000179cb b6c8be48
> > [  291.850632] ---[ end trace 0000000000000000 ]---0
> >   
> > >     
> > > > [ 3854.477170] inv_icm42600_disable_vddio_reg() disable vddio
> > > > [ 3854.483835] ------------[ cut here ]------------
> > > > [ 3854.483912] WARNING: CPU: 0 PID: 582 at drivers/regulator/core.c:3016 _regulator_disable+0x140/0x1a0
> > > > [ 3854.497853] unbalanced disables for regulator
> > > >
> > > > Is the way from here to remove the devm_add_action_or_reset(dev,
> > > > inv_icm42600_disable_vddio_reg... ?    
> > > 
> > > That will make a mess if runtime PM is not built into
> > > the kernel which is why an PM state in remove should return to the state
> > > before it was enabled in the first place (i.e. on!).
> > > That final runtime suspend surprises me.    
> > 
> > Got it :)
> > 
> > /Sean
> > 
> >   
> 
> 


