Return-Path: <linux-iio+bounces-12869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA339DF24C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F022AB20D24
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF81A38E1;
	Sat, 30 Nov 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzRHemh4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60F433BC;
	Sat, 30 Nov 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988446; cv=none; b=g/P/F8VozwZsOtaYEpy7KaBo+EhCLM5gB4+fmAx9E8Sn2MZ7vaz1qMBXqXM2tgpd0YCfFMpz0RSknjmImhLLpbsw2gHK9VMFbVZY6enp5KVgU8V9Uy7AOdosEHeJvD/G0AOJoOYzmKq1IX05OM3WbLrTyu8ANzBH/VxogYj9mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988446; c=relaxed/simple;
	bh=IdkFXlEATVkRHKKENN0BfXN7aquijiOhsDPuifFK4eY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CENAY0mqT5Xrc3NvZrUjPPX0cSLtNSGL/dMDnxMSiPxjTASlq7hcs12i4Tp01reKpmGPQgcuFUau1/20HA3D0DOLPxy7PD6dYeB3PzVhBHtnBr1TbPkVFbZMfSVy6pFKbQ8k7Jc8kJPJVkZpP//0+esZxm35S/krNYx/RD1VaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzRHemh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4189FC4CECC;
	Sat, 30 Nov 2024 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732988445;
	bh=IdkFXlEATVkRHKKENN0BfXN7aquijiOhsDPuifFK4eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzRHemh44MNxqzkRCP8c4NhRu2be/TndfIROTXnhGgSakPKcgWHszHIRWgRG6QNZ6
	 3FnDBsBPZjIE/vQPdYUdCnGTYJfZW6Z4a1M9xZekQdoLSafprkhSMH8t6mDijqXfuY
	 zTHKYaDvnC8Dmu9EWrTRegGu3I+I/tBFgVmbfizuWWxcbC+9tq9xtb2t9wkQnyBMNQ
	 knnvfjKEoDMJVxy/78K0qLP/QkR0aTiyMrZqHtmi19JgtIHOpsODcfljoYAv1C8r/V
	 X0O+c86HJFILgdVyq7JmpWh7K0mdh1sHoyToGAyv2ySR/NAIilZvtIui5m9RVBu1SN
	 zcyYnOrqDEZCA==
Date: Sat, 30 Nov 2024 17:40:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: test: Fix GTS test config
Message-ID: <20241130174037.62e3e2d0@jic23-huawei>
In-Reply-To: <Z0gt5R86WdeK73u2@mva-rohm>
References: <Z0gt5R86WdeK73u2@mva-rohm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 10:46:29 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The test config contained a copy-paste error. The IIO GTS helper test
> was errorneously titled as "Test IIO formatting functions" in the
> menuconfig.
> 
> Change the title of the tests to reflect what is tested.
> 
> Fixes: cf996f039679 ("iio: test: test gain-time-scale helpers")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied as a fix.  This could confuse someone at least and is otherwise
a very safe 'fix' to apply.

Thanks,

Jonathan

> ---
>  drivers/iio/test/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> index 33cca49c8058..7a181cac3cc9 100644
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -5,7 +5,7 @@
>  
>  # Keep in alphabetical order
>  config IIO_GTS_KUNIT_TEST
> -	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
> +	tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
>  	select IIO_GTS_HELPER
>  	select TEST_KUNIT_DEVICE_HELPERS
> 
> base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195


