Return-Path: <linux-iio+bounces-25479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD3C0E895
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22998465D6A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190E30ACE1;
	Mon, 27 Oct 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h224KjVj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B6309EF8;
	Mon, 27 Oct 2025 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575667; cv=none; b=lG0tZ2YeJQRvd0hDrqcwlKZ1n65W0melhaXIVRkdBQxvnRaAFOJDIXqBxi+tDDYp/mh5rCOizKZku1zNBnjBRCaZiGhXGn8HhBqDiZPqk1mnhvPPeGjXk2ky5mqsZTadhuFrWhPWHgwUb31FaeCGlxtJGWy4WFjlQXNtmZ2G+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575667; c=relaxed/simple;
	bh=3BUReYlOzngeuFRFVLLxCuG7HZalr/p0ZbTC1njvP88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2La7hC3ftvHbraG7FaP8/Qfqfgm1izD8x22oK2ra0Y+8OHlauZYhXHBi5VXlP+yvzp/7WhLlWrO+6UseKPKsAc3MAb+A0/C0nODfMvxRVwlv8m9vlBBFBTBv7tMMb/bUgHqp2b/2SREFgifeBvUdorQ3II+CtMGxhKQvNsoRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h224KjVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17723C4CEF1;
	Mon, 27 Oct 2025 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575666;
	bh=3BUReYlOzngeuFRFVLLxCuG7HZalr/p0ZbTC1njvP88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h224KjVjl9o6I9deOL0VK/uKS0uNWL474/ttqvvxnKuTQW6PBwcxdzkZX3dIisXpN
	 cOeXiMke/XGeYXXR0kqQzFlBvPeJ8kRqibB9omtJm1fe668dilZ86cPQaFCZ8j05z1
	 1dgVPbLOrPlnGICHnZJfoLhYZJ3B7Bfh8c7oARPTUO3AHwfQAdw3DryDAMrMJdmy7f
	 JpCYjs8CBLyHSedsarszE1ClLoLrR+m/Lj3FUu2Xl0dvET6QFju1pGHmQxfHU1gdM3
	 EQrbfOIfRlwASZdlXDtFYh+s/6ipXM/h0Tiqujsw8Rk+iaKEWtxxwv8umuUF/ci3UJ
	 dGvgacR7syAWA==
Date: Mon, 27 Oct 2025 14:34:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, dlechner@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
 vassilisamir@gmail.com, salah.triki@gmail.com, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v4 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251027143419.6b6e42f0@jic23-huawei>
In-Reply-To: <aP85UwWqkuE_rQKn@smile.fi.intel.com>
References: <cover.1761372227.git.akhilesh@ee.iitb.ac.in>
	<cb51289f0f1c38a7ea24ee5ba3566c787f203ce7.1761372227.git.akhilesh@ee.iitb.ac.in>
	<aP85UwWqkuE_rQKn@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 11:20:19 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Oct 25, 2025 at 11:50:55AM +0530, Akhilesh Patil wrote:
> > Add driver for Aosong adp810 differential pressure and temperature sensor.
> > This sensor provides an I2C interface for reading data.
> > Calculate CRC of the data received using standard crc8 library to verify
> > data integrity.
> > 
> > Tested on TI am62x sk board with sensor connected at i2c-2.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks as ever for reviewing Andy.


Akhilesh,

Nice little driver. Good work.

Applied to the testing branch of iio.git for now to let the bots poke at it.

thanks,

Jonathan

> 


