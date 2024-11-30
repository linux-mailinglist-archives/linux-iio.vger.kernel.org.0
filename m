Return-Path: <linux-iio+bounces-12856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FB9DF125
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360122813AC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AB19B3C5;
	Sat, 30 Nov 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0/Qg4re"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EED380;
	Sat, 30 Nov 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977045; cv=none; b=g+MiM+LmWINCZnN94pjbb5ZYXUyjiKZAiQudDvN8+ZMwuGaFHXjEVDlueww44fokleb4Bq/Bs+CKLf/xX9KvTplhjkM3UGRq4tpLpXZyqGig3195O7xMW2cerXBOVKWoAGrQFSicFrsAmFNn0cuzMplK3naiETGdSjtC6vHEON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977045; c=relaxed/simple;
	bh=xdtrYB4S1ocuPwahWlI7HRMD8kk04evLx9rswib4cgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqaJ3XmiWoPvpCuAhcbIiLs4EvtQaef7Aa2n4lf5eOipjkzqKCjdH9Sef3fiUg+85ZGqI3qWYmwtmGdCfBLre0olFPUA7qb3osvnkBJ0qbTDG8GKRNG/obdZN81AruJ1vFWRX7PfDhFafbxxFLRjZAt+szLmJvGKLaePDeWv9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0/Qg4re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2413C4CECC;
	Sat, 30 Nov 2024 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732977044;
	bh=xdtrYB4S1ocuPwahWlI7HRMD8kk04evLx9rswib4cgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0/Qg4rep2JcPevU3atX+y4vRNlGqF2JWpb6diW4KzLTGUX2HRr4qB3xIG/Rov5qZ
	 68LmnuIXM/dYZFm3MXOqeYrMa9WbttumGz0Y/qOpuIcY+9kQNqTb33nEOS4OT4FAjI
	 q89NjWwicxSZkVajkQZWaXLKKZ+iNqYMBkpNzi6wWi9M+QmUTHbsN/yRb4uhV/0K2b
	 uQIKs40thqtDUNDJkMNQR7fnKKvbaX8jSeYxxuPY1rCwSVJZaD9jToxYDfItzRIS8h
	 +vSVCyeUcBvsXGzrbynvb1y5GmU6lBuxogeyR7QQVjvSXZME14YD+X6x8r9lRlGfA+
	 QQbw5hcptCMXg==
Date: Sat, 30 Nov 2024 14:30:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, ajarizzo@gmail.com,
 ak@it-klinger.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] iio: pressure: bmp280: Minor cleanup
Message-ID: <20241130143035.03218d3b@jic23-huawei>
In-Reply-To: <20241128232450.313862-1-vassilisamir@gmail.com>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 00:24:47 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> This series adds the SPI interface description on the device-tree file
> of the sensor, adds proper self-described sized variables and performs
> a minor optimization in time variable names.
> 
> Vasileios Amoiridis (3):
>   dt-bindings: iio: pressure: bmp085: Add SPI interface
>   iio: pressure: bmp280: Use sizeof() for denominator
>   iio: pressure: bmp280: Make time vars intuitive and move to fsleep
Hi Vasileios,

I took a quick look and nothing to add to the other reviews.

Thanks,

Jonathan

> 
>  .../bindings/iio/pressure/bmp085.yaml         | 35 +++++++++++++++++
>  drivers/iio/pressure/bmp280-core.c            | 39 ++++++++++---------
>  drivers/iio/pressure/bmp280.h                 |  8 ++--
>  3 files changed, 59 insertions(+), 23 deletions(-)
> 
> 
> base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195


