Return-Path: <linux-iio+bounces-3035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7CF8626D8
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 19:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC04282E68
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F043ABE;
	Sat, 24 Feb 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa9VE2eK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980117744;
	Sat, 24 Feb 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708800443; cv=none; b=HU/l0qPCHne7LNuJdzkkbsTIn5bYb9bJcXCCwHrBnFaoOHaIoUJPSgqLs2fs9lGl/PSqW93FY+A6ATGefNFQ9B6JCppddI+RvWYKz3wsc/QINJ40RZ1ExHZLWk2JUZ4kst6idCNaFm5MlgMh/UO7b2GSYoNRI3fTDeW/yjbGQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708800443; c=relaxed/simple;
	bh=/u7KV5J/6HeFWgvGtOFWpmOuDWMQEL8VUHQfRI1Il6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3uws5gwBkITIUDIwjG6EBwvqKBnhxiLyQ0s4+rstsqMemnlAkjqnYN42yMJBNWzaS3zQ/UBbTTyUyNU826J2ewPnkDBlPBdf8kxDuDC7QOkKnck9ZDqoKPoS287ZBK/KYwhvuHgaNuRQVr2iHJAKLpkkV/5G9uGgYnek86JNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa9VE2eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFA7C433C7;
	Sat, 24 Feb 2024 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708800443;
	bh=/u7KV5J/6HeFWgvGtOFWpmOuDWMQEL8VUHQfRI1Il6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xa9VE2eKjYwi1TWCMIpq899IK2Bd1FYwhMejKY2QyNC3LEP2ghrAyaYpoaRn5xsQ7
	 WBvGlL151T+vG+Fjy7khwvYnGiqGgIbeifQpOvEOYY3cuUEWa/nmlOSf72ppLbg4oW
	 nr2NwcsLse9OGX2S7KwBOqOGlP7oRs1yNvhpi2Vb+BPlmK+uFljsjL9Npu0h6ecC3c
	 9tqeYZQdRy+IScUaj+Aydram4QQE7zkOi/3wGhcbspNn3fXNVUaIJNwAwM0rZsTGjX
	 /VVwja70ypAAQ8//sRKdpLnnKQw+xdUBm/gamMGbPh5e6HhIBoVVHNgYVTdAlPF0vI
	 2ylq2eEO/3/1w==
Date: Sat, 24 Feb 2024 18:47:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH 4/6] iio: temperature: ltc2983: explicitly set the name
 in chip_info
Message-ID: <20240224184709.0e84121d@jic23-huawei>
In-Reply-To: <20240222-ltc2983-misc-improv-v1-4-cf7d4457e98c@analog.com>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	<20240222-ltc2983-misc-improv-v1-4-cf7d4457e98c@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 13:55:55 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Getting the part name with 'spi_get_device_id(spi)->name' is not a very
> good pattern. Hence, explicitly add the name in the struct chip_info and
> use that instead.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Good change and it nearly went in clean without the previous so I
dealt with the one context issue and applied it.

Too many patches floating around at the moment so I'm keen to
reduce the number where I can by applying them :)


