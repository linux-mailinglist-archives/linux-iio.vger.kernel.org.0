Return-Path: <linux-iio+bounces-790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A278880BA8E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D9280D41
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226AD8BFD;
	Sun, 10 Dec 2023 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NewDbbCH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806979F5
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 11:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF8CC433C7;
	Sun, 10 Dec 2023 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702209536;
	bh=8zLebWkuA4oWeoYEgbs27UYNS0WETolFHBpDkoerBAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NewDbbCHtW4923BRuQ//4rgbuO+G5VVyLF6myQH+lCmzJaVcizgjRuptYs2lAmkSC
	 WPLWwXTR3Xm6QbXVH8UO/9/ftQFRuw/ncs1ZgEF2IFd9Y8ghUh6RKWPhWvGyqBmYMZ
	 dhEb0N6ZVaOWU51txTKWPsCfk/18tb+RKh1BfLEuyNWmxcf1lLqeEUc1/Byvq27Oa0
	 Y0am3QUzqjU1TJ8LmsSrJyPZ2IlZrHWGjZgegAnfGWg17RSyeDNLCoyw8moIS+3Q1Q
	 QVC6lTboL1JZrXciKvqTt1ky/mkD10MRh3fXbVbg2xSXkczobe8Q9PA4Hbzmp7YtFb
	 5uguec3E0Hk3w==
Date: Sun, 10 Dec 2023 11:58:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] doc: iio: Document intensity scale as poorly defined
Message-ID: <20231210115850.63717a3d@jic23-huawei>
In-Reply-To: <20231207134200.329174-1-marex@denx.de>
References: <20231207134200.329174-1-marex@denx.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 14:41:50 +0100
Marek Vasut <marex@denx.de> wrote:

> Add comment about intensity scale being poorly defined and
> having no proper units.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
Applied. Thanks for cleaning this up.

Jonathan

> ---
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 0d3ec5fc45f2f..94b8d8461b7c7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -618,7 +618,9 @@ KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		If a discrete set of scale values is available, they
> -		are listed in this attribute.
> +		are listed in this attribute. Unlike illumination,
> +		multiplying intensity by intensity_scale does not
> +		yield value with any standardized unit.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain


