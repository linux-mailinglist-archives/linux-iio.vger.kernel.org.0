Return-Path: <linux-iio+bounces-22047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA2B12FB5
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72073B7309
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54BC20A5EC;
	Sun, 27 Jul 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F49NFu9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF911DA55;
	Sun, 27 Jul 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753622861; cv=none; b=RymLEBa3envtjDS1dY8QE/PN5oG2cpx/EhEHDedJe0/QjAwPKZwEPtOw+vt40hHWo8WcpcqiJ3xHLSvYfuYjsQDuyfn+dcJWYLpgxXXkNz8oVDyW75OYy23XbJmJZkDYGMgQMdFx2aA8/myDJ/uhNrNU17lqevHXhiHh42CLN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753622861; c=relaxed/simple;
	bh=Brp/tTAM8oKYnZYv63iWOVwR1lmp2ByX4gdmk680SSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptXA+aohdmfgBPT31c/5W/LsjZ2OVwgiE9Da29sLyTtDXJQknZ5YwCm3MEfx10sfsE6KngN6ZG5Id987QcSrMTIfPOCbQoydFA//1o3FYPmpcwhOENjI9DuMA4zEYassJF+8b2Ma4DMB9eMWurJaXFEEaMC2NvExxxsGhLEtNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F49NFu9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D98EC4CEEB;
	Sun, 27 Jul 2025 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753622860;
	bh=Brp/tTAM8oKYnZYv63iWOVwR1lmp2ByX4gdmk680SSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F49NFu9hqQ8Jj7zfu0+K9FCh3gIZNQn+/d0A1r0M0UIb1TwXFVE6hVQadQQtmiIqb
	 YiKifQ1k0YfsjFRXsIAbBDFIMLAg6mWYt/UlXSBElKbOTCjEqHNNd4LAC+x2+XLpFy
	 IEWrE46gPC/VrU9IPxb/Zrkq9Yy0RpIji05mlQ52EfPjnN8wWjuMPds4xb7O333B+w
	 0SgKMu6iR1wxvyPeX0LvXlJ7Yi8GaI+Mn4KDMYv6Q9Hs63aHZg2CQfswC4i/m/u/EW
	 oW8z3GEpFlzV3oMvEdU/UwFHuMOeIiUhNnhQmdtIpQg3R/S6+QJ1gyAoWm0n030vD0
	 gIYIhxw+lWf0g==
Date: Sun, 27 Jul 2025 14:27:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] Documentation: ABI: iio: add sinc4+iir and dsp
 types
Message-ID: <20250727142736.3b34afe6@jic23-huawei>
In-Reply-To: <20250721112455.23948-4-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
	<20250721112455.23948-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 14:24:44 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add two new filter types to the sysfs-bus-iio ABI documentation:
> - "sinc4+iir" for Sinc4 + IIR Low Pass Filter
> - "dsp" for Digital Signal Processor filtering
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  new in v2.
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 0948611227a8..9f51aff4c3e8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2337,6 +2337,8 @@ Description:
>  		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
>  		* "wideband" - filter with wideband low ripple passband
>  		  and sharp transition band.
> +		* "sinc4+iir" - Sinc4 + IIR Low Pass Filter.

The fact it's IIR doesn't really tell us much other than the particular design methodology.
Maybe sinc4+lp is more generic?  I'd like others to give inputs on this though before
we choose!

J


> +		* "dsp" - Digital Signal Processor filtering.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/filter_type
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type


