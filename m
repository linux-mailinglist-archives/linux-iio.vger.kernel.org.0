Return-Path: <linux-iio+bounces-14682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D660A2118E
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 19:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB25E1693CD
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C31E0489;
	Tue, 28 Jan 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/pjIBH0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97881DE8A5;
	Tue, 28 Jan 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088866; cv=none; b=aZxkyvxGsnZ9Ok3aF/4NCl0J5fOXsYhRqNl58dkrMyaOpT3lCix3HYrBQxZnozYTkm55ZZO8mPWEYKyiQa7YqEgf/D1rwU42YAAgqtVsA5PcX28h3mOwKg+QrLIFhO+HzZFn+I7yeSzZ8AIQh0tEgXpNEC6c2j7dpHSMu+Cd1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088866; c=relaxed/simple;
	bh=aTvEQyxqt46VVhHvUbNk648teDKI1caqE/xkT8uVixQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtUbcyH7lf+UpUbiBkBpl8YvFOuo2tmnoxHNof+8gMwgwZc5Ks/2jxrV0RPxYv5JlqIdaWEp3TKfOGOkLYnJtAoA7j4aEz90ddV4X6nhfbY//Lcdxc1A0u6OuwetuyfZotlguokN8/kAPm25QziXg8exPI8EvYNDWiiEv4FeMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/pjIBH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63661C4CED3;
	Tue, 28 Jan 2025 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088866;
	bh=aTvEQyxqt46VVhHvUbNk648teDKI1caqE/xkT8uVixQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N/pjIBH05RidBs0tDBf5hjB56k3Ufua8jnr2cQno2/YbC5uTGTt6BQ6tPoU9KHjwZ
	 545kCyHLlFTWB1vFMDrGpeWzlWZ8f7tASFd9jAlj+vMgqmpWPpylSh7sElJFgII83D
	 h8nPMJCdMW+5CqdIygNY/9JdbsNehudXSIu5BjZUDzV4zTovgKE1/jMkWl8l3K8lWd
	 JrDPPYgdcjYCTRH/D8PLIojdOk8nwcqqIrkFY7U51ZF4YXdcxlJKNUdfXCLBaSWflt
	 kwSg3TbRnOXtXdqkGpuwYzXNCCvtUgMyti5xqqMIQZrw8H9yvB8Is6rUP19pnV+pHZ
	 /5hYylbIvrpzg==
Date: Tue, 28 Jan 2025 18:27:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Thorsten Scherer
 <t.scherer@eckelmann.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 32/38] docs: iio: Allow creating cross-references ABI
Message-ID: <20250128182739.704c7823@jic23-huawei>
In-Reply-To: <71e13fab5e63de2f16d6953cc6ebf3b51f1f9f6e.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
	<71e13fab5e63de2f16d6953cc6ebf3b51f1f9f6e.1738020236.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 01:06:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that Documentation/ABI is processed by automarkup, let it
> generate cross-references for the corresponding ABI file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/driver-api/iio/core.rst | 2 +-
>  Documentation/iio/iio_devbuf.rst      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/iio/core.rst b/Documentation/driver-api/iio/core.rst
> index dfe438dc91a7..42b580fb2989 100644
> --- a/Documentation/driver-api/iio/core.rst
> +++ b/Documentation/driver-api/iio/core.rst
> @@ -60,7 +60,7 @@ directory.  Common attributes are:
>  * :file:`sampling_frequency_available`, available discrete set of sampling
>    frequency values for device.
>  * Available standard attributes for IIO devices are described in the
> -  :file:`Documentation/ABI/testing/sysfs-bus-iio` file in the Linux kernel
> +  :file:Documentation/ABI/testing/sysfs-bus-iio file in the Linux kernel
>    sources.
>  
>  IIO device channels
> diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
> index 9919e4792d0e..dca1f0200b0d 100644
> --- a/Documentation/iio/iio_devbuf.rst
> +++ b/Documentation/iio/iio_devbuf.rst
> @@ -148,5 +148,5 @@ applied), however there are corner cases in which the buffered data may be found
>  in a processed form. Please note that these corner cases are not addressed by
>  this documentation.
>  
> -Please see ``Documentation/ABI/testing/sysfs-bus-iio`` for a complete
> +Please see Documentation/ABI/testing/sysfs-bus-iio for a complete
>  description of the attributes.


