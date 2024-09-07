Return-Path: <linux-iio+bounces-9291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7D970300
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E771C217B1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFF16087B;
	Sat,  7 Sep 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFexnj8j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C901591E0;
	Sat,  7 Sep 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723787; cv=none; b=gBbwvrdSjZR4RSIUnc53Bd+HdCUHQ3oph74cptpZMnMiwZbv6hqfR37Uy342Hfmgqqo//rXEp2hgkR8Vt6R4x7z0ugLTb2jeWzBF3Yn1HeYK8Q3GPu1QU7VWBLUXfp4IPtevWFvHjBAlV4OJnoI56uvVMxj9WgtxQUHoNNfBjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723787; c=relaxed/simple;
	bh=cT9h0opxtSxWLcz2zZsod2/jfC7uX0kOkmLnUNh4JKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNY/QM8hkexHK3ToZ4jDNZHqCjZxDRbPXL0kpViaUHCtVtqg8mwI5GWpXUSw7S5kpJuaTxC8Pzi7K48NTE08jsNemrXecjrdh5zJOi0QjLs3Qk4tHtMJUdzQ7GyyRH4wgR121jx0VB5JX0OPk0s6HZSuclPvSvjZzU59PkWkzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFexnj8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23669C4CEC2;
	Sat,  7 Sep 2024 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725723786;
	bh=cT9h0opxtSxWLcz2zZsod2/jfC7uX0kOkmLnUNh4JKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NFexnj8jRt6TFldvobsdfPosKNehr97560sbIzZ0mM5BzTuaqxJqF/Yuvjjs3NIoY
	 yt4F3L7PIVohwoQLowdy4unOQLQV2Q2PPZ9f3Fz4jfbv6p9ii67wMBW10KJZfC0hdY
	 sw8AqegUzLbtkpUWEI0UnpbveW/CylhyyVx5mkqMU0id/+aENiF63q2l2M7usO13W7
	 9RjwduO1QH9jWy7XtJDMxBBcz/mfQeJUIRHhXfCG9BD0wmBTgk1r8+Z7KmsdKbLyuF
	 J4R87Jso2KKpG+4aR5idDqqQSi4v6GljOgIUlCokerz+vmpQVNBroQEGLYaqmEQ0N/
	 LmlsLFHv88bYQ==
Date: Sat, 7 Sep 2024 16:42:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner
 <dlechner@baylibre.com>, Michael Hennerich <michael.hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 00/22] iio: use dev_get_platdata() to access
 platform_data
Message-ID: <20240907164258.70772206@jic23-huawei>
In-Reply-To: <ZtdOB3VRN0QCGWU9@smile.fi.intel.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
	<ZtdOB3VRN0QCGWU9@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 20:57:27 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Sep 03, 2024 at 01:16:45AM +0300, Andy Shevchenko wrote:
> > Unify how IIO drivers access platform_data field of struct device.
> > In simple and straightforward cases constify the local variables.
> > 
> > (Not tested)  
> 
> Jonathan, in case you are fine with the series, feel free to squash, e.g.,
> changes against hid-sensor drivers.
I don't follow, but maybe that will become clear once I've looked
at rest of the stuff I haven't read yet.

Anyhow, applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.  Another series that will probably be 6.13 material.

Thanks,

Jonathan
> 


