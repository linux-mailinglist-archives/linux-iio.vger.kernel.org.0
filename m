Return-Path: <linux-iio+bounces-4822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8CB8BC336
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BC61F213D5
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242986D1BB;
	Sun,  5 May 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWekGzmg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D646BFCC;
	Sun,  5 May 2024 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714936967; cv=none; b=jQ/SGPQ4PUuu9g0P61vPP9MBrdKiLytm+f3JQf6Xo+Z15baa3P6Pfpq8TNOEuuBkhycI/fEYRy1WsnisQLJaQkoJYmjXHbeoj7Ls4+ZHgO1rnboreUM4RCN4uv9GjOvZ7QPXCtkRWl8xRWOpkRAal019dLo//M1i+s2LYd4pqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714936967; c=relaxed/simple;
	bh=Lt8WVoUDyxHbAr6/NPiYItA14a9yJ6MV4bxPM/leayA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdzVc8uTS8yxfJH+Dn7+PPcfiwEMytAlldd7d/MKD7uN2n4BpTMf6ppzvEJblKM1H553qRkQf6WT/m9RVT4qKsi0BMHV53ndQ1XEd8xo+hJCj+O9tE2BndUZryFoIbnwffQ9DXMJ1p81duTk6a/JGUwxbfhtyjOPjfQfQ9i3sD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWekGzmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83D6C113CC;
	Sun,  5 May 2024 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714936967;
	bh=Lt8WVoUDyxHbAr6/NPiYItA14a9yJ6MV4bxPM/leayA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OWekGzmg4cDCyeYscf357lm6Tj2eGXS6Kz6OZoIT1jGc6pK4PkQpnTilhPHAvjqro
	 Mj+veFYDDLHHMG9zv9JFP7JhVWyPAwnz9RBuiNUqwR3goim9QXV1pgc15f/wpJOdoD
	 f63bWecjJBftSfe7eBboTWWbaTcgdp9sZRoR9Yzta1D16nV8mrvH8jC0tYiadLim+7
	 UMiy/ucTYT3qx/fcdGI3w6jDFWDMiv5MxqbDKkBfnVHCsNxs5gBxzIBS2SXrWlTCCW
	 41Wm70UsP7V4/JEbRwiynB+f7Zt6Pu3QKVWkk+AhYb9liwnTr3TqnH9zwnpKXM3Lr/
	 6eVSCM4ZLLyFQ==
Date: Sun, 5 May 2024 20:22:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 07/10] iio: pressure: bmp280: Introduce new cleanup
 routines
Message-ID: <20240505202234.33662b4d@jic23-huawei>
In-Reply-To: <20240429190046.24252-8-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-8-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 21:00:43 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Introduce new linux/cleanup.h with the guard(mutex) functionality
> in the {read,write}_raw() functions.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Looks good to me.

