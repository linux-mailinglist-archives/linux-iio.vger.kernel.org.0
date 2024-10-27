Return-Path: <linux-iio+bounces-11389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC09B1D2C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1042B1F21663
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DEE13B5A0;
	Sun, 27 Oct 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHEG+7YP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4D78C9D;
	Sun, 27 Oct 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023962; cv=none; b=g+QpS9GZq8mxKk4IFIOAChcVtZ21NW5FOzMb5e+71fixb3oRWpfJKRdaGPYOoTLGNbyzBqzTKR6Y1xMSGsDP8BfIK+lFt1UtkbivuBPkpaAAWhVyO37Bs42Zdn/4YIIn7lOIgv8UsM7uY8Ai0Jmu28skEjuC6/Rg9DkctEgaiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023962; c=relaxed/simple;
	bh=Ub6bxs8fZpkoIBEW1NqDGUXsJe2cgnoISFhRkxIEFPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IieBJenYqMGGjNcBBwMwJkYz2iYEtvMsTjP7N1hyigmeyuii4r45ucTr79kXoB/ZkizW/HNeViWnu+mdKrmLfDY73XhCqQ2TvqRePqwW3JjQemGIj0LJPHVrkKu43AUygDuS6AdBuX/2jNVP0mRizz5fTJ3QlXvimhsfUs+OBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHEG+7YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82C2C4CEC3;
	Sun, 27 Oct 2024 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730023962;
	bh=Ub6bxs8fZpkoIBEW1NqDGUXsJe2cgnoISFhRkxIEFPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BHEG+7YP0pAfGmaRKpovCJ5CG2i8O5mNUnW5OK1fmQkDJ3LDnUO5adTumypfYyiMj
	 KtDCXyuzLwv/WqYIQnCSCfoF9wbwBvx0o3AW3FrENskSc3Jooq9i7TI3aosf8+jt7d
	 qEGijL1vFeaiW/Q5JUciBAfQqwGgabiySbg1xkdLKkw8/Jjqvccn4zMfNTD3sDK3aA
	 c6AfUmvLyL8BzdZhK7o60KLhLVJyqJX85V5NGJsJavl9HTczuUbB7SQ5w4Olc9ZFm2
	 gV9AUFcIWvgnWFrCbdYbQs0HU/7Vnq2f+TODo72VX4lB5aFxUPb8dyfMU6Acbn8+P/
	 vl+CdTvJymwxQ==
Date: Sun, 27 Oct 2024 10:12:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] iio: chemical: bme680: Add SCALE and RAW
 channels
Message-ID: <20241027101234.259ecbb8@jic23-huawei>
In-Reply-To: <20241021195316.58911-9-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-9-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:11 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add SCALE,RAW channels to the device. Even though PROCESSED should be
> kept for backwards compatibility add comment to avoid using it if the
> value is not actually reported in IIO values.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

