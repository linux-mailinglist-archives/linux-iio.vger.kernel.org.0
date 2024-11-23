Return-Path: <linux-iio+bounces-12554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18B9D6A22
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E32AB21254
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C136126C03;
	Sat, 23 Nov 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYZoh5n/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F142A91;
	Sat, 23 Nov 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379326; cv=none; b=eYsUw0NAOgeEzB234LUy2wKmcn5w8QxrWR9/XvCS5fHtaxMr6ew95pCZMLV4gsLensXwgHFQk0iWcBSnPL7WdiKqiIdEETPI0ETgJNNhQ3U5s5Mwyc8WLDSXPT6w5IEH+DK31mXuIFuqrbOVuwO3lZiXK5ggFhugZTrIm/XsYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379326; c=relaxed/simple;
	bh=kySpFhbuDlK79L1DXJDJGSiLkLqr7ztdRw+nazqxhk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWIXbmuYbl726PPhtF5WdGcVurb0IhekNMwJwkkox9XNKGpy4s0s/t/NYyOHxcIkyjU7vAS8v46tGIKGohnag2t8Id9i61rP5yQCjWoncpqcYkwbPFLnbW3W9k2c+s1oaTk3EzuwbggwbrvM78i69xVk7Q0JUcuCnRKuXss0P1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYZoh5n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD54C4CECD;
	Sat, 23 Nov 2024 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732379326;
	bh=kySpFhbuDlK79L1DXJDJGSiLkLqr7ztdRw+nazqxhk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EYZoh5n/6zejnro07l1COqZe5lFqSkOLB5y/Ykl2Pwp9Cr+nyXqlQumnXiPdax+Ax
	 z03ZfNwkxgW6BVuozi5//n1UrWBn3mPUXR+MhvfC7i/HnnowJnLD7Qz+6GQWIYNR3Y
	 0JAN/3RpgPU7t1Dwn57aRsaQUmhRofjcvSVPXAKz8lxs8V5OC+yVXmKvPW40nfmea1
	 v9IMDF6LfgI3lzkaasW3avwjkH0D/sm1Ol2Kh7dTOPW0OWG8cPvPhLea2XMgG0vo1R
	 /HM+vy05cKRsFc+/dbw3snjnxdzz9xpW9eYgdJyFircroL9Og06a8RmjZeEXvuoKXT
	 AA1IpnsvdtMrQ==
Date: Sat, 23 Nov 2024 16:28:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <matteomartelli3@gmail.com>, <lars@metafoo.de>,
 <andy.shevchenko@gmail.com>, <marius.cristea@microchip.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <20241123162838.1005e0f2@jic23-huawei>
In-Reply-To: <20241115133436.13204-1-victor.duicu@microchip.com>
References: <20241115133436.13204-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 15:34:36 +0200
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read the shunt resistor value and label from the ACPI table.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Matteo Martelli <matteomartelli3@gmail.com>
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>

Looks good. Applied to the testing branch of iio.git which will be rebased after
rc1 is available.

Thanks,

Jonathan

