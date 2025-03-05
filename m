Return-Path: <linux-iio+bounces-16430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B226CA502EC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652987A4EE7
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0872248863;
	Wed,  5 Mar 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmuMJjje"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0625221F29
	for <linux-iio@vger.kernel.org>; Wed,  5 Mar 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186706; cv=none; b=fxsM08JO+3BllXTc0BhB1cSsmI10V8t0fTXmTfvMO8IVqK425MNnkpArrV7GdzbiMy5U3RwBFneNnnK3hWD/1GWFDyYof+A1QWx3kg+4tthhq3MCRBRJ5Rx53SFjMF5at++Dlso7ptdXpr1rulIiUve6kjfSLabPGReAChs+kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186706; c=relaxed/simple;
	bh=11+2hXWIOCvnwbxDVuBqP0czhfBdeye/7HCep7J7QTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtBRQwesBMsKxWpKrvnJkWb83JGT1Z7U/wJGGC1kGck7tCtar2b6qx7gIc9Cdu6V2SRzkOLgd6q0j6QcOACyqi+AaLOJCF0jRaKDddZ7NDfq6HqCHtWK+PZLNzGGRCqnzCOTUUX+gQZJHTWEUiQJnlhKzptl2Oo2u12wbirGffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmuMJjje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F278EC4CED1;
	Wed,  5 Mar 2025 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186706;
	bh=11+2hXWIOCvnwbxDVuBqP0czhfBdeye/7HCep7J7QTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OmuMJjjetrj0IjQ9tIBE3MqLKZF0lE3w/6xq/8rh8pq0wmAz4mKjadlRRBRYC9qQy
	 ZteXg6FnVHIg0vQI+V/dLxMLMN32o1AcECiZTK7KEMjo43pWjgfBj7TuIPSIF4B/Nx
	 gTcUtmOdq100QFrAYTdsBHfH2G78HV+Bj7XGbtunOQ/T2OabPWXljo0ugoELU6Ur7S
	 cc922T2vgsFMw5eciA1gg8Fw67xCy3yjPj6jwzdT1TL58dDJR3T3j8S13lYX9Rn9Dx
	 6gQKVE0oAfj/din17sHoBcGeh5aUMgWYeMEXbk5nIEQkSeZHfikDyanYFKcl4H36vM
	 J/7b6bQ0UEX2g==
Date: Wed, 5 Mar 2025 14:58:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>, Rodrigo Carvalho <rodrigorsdc@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] staging: iio: accel: adis16240: Drop driver for this
 impact sensor
Message-ID: <20250305145803.30e1cecf@jic23-huawei>
In-Reply-To: <20250222152021.1039675-1-jic23@kernel.org>
References: <20250222152021.1039675-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 15:20:21 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Whilst an interesting part, no one has done significant work on this
> driver since 2019.  The recent changes are all as a result of adis library
> improvements having to incorporate this device.
> 
> https://www.analog.com/en/products/adis16240.html now lists this part
> as obsolete so the chances of anyone working on it are likely to be greatly
> reduced.
> 
> So drop it.  We can always bring it back if anyone does have interest in
> this device and is willing to invest the time to make it suitable for a
> staging graduation.  How to handle the hardware triggered short bursts
> of capture has never been resolved and is a somewhat challenging ABI design
> problem.
> 
> Cc: Nuno Sa <nuno.sa@analog.com>
> Cc: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Gone.

By which I mean I applied the patch.

Thanks,

Jonathan

