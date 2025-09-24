Return-Path: <linux-iio+bounces-24388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C1B983BF
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 06:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB2A17D145
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCA13DDAE;
	Wed, 24 Sep 2025 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FOBIri9F"
X-Original-To: linux-iio@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CCC141;
	Wed, 24 Sep 2025 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758689206; cv=none; b=UY1Ky31zy5gWnFQ/fcPNZxnZtPh1hnJs+9fltR+3Z6IEzGngGNItWICtrBkvmCv+bOf+bXtc5/Vvg6kG7YHQUg11Nx17zbwSGo0CGZ56B/mLTsqY1j5zvzAJis7bXVaSaL5SlPy3yjdZzSk6TS1ZfeR3C+zJrgM2twsDoLso1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758689206; c=relaxed/simple;
	bh=aPDi6HfLDo8HixHLXGDjIDTg9tbdmzQ0sDAanigPmtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB6+ke0iE8N6EzqPH0J1JmHuos3PGYQiGEBeCg+YFwCs/wy5c1+5ASDCqGNM4OaZVoSPIkifyYUczHlCLj3+3eSDuYvJQ2UYXkYvuYuKeaDRTMrmLKCJwBa7sWAexktOc6DPN9txcRI2205bs64Ocbxyd53i1I81ori34JSmeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FOBIri9F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RkLRvQZ1pJDjFKqcdEOfms3PU7vhy75lRDym+uqbBoo=; b=FOBIri9FzEVTxXv+9fYoq3Z2rE
	vpR6JxZVT2mJB1V0GJywPZ+IMgRZceH1KpgGp/vSh4DJbCL3nbqd4K+XM+nqx3IA3T6i/ZWdM2wVj
	VbJToi3h+KFb4BAVyvoy2Jk1MsXsJ0y4Ji3sQw0HihX1VlION4UmmvOWdMJIK1JzR3cBuP5Kilis8
	5gwVqscMJYAghnELwq7ZtWZopuhT08CJczWJMvD7FcTV0Xw2gaM7G62vs66nKqSls74vhdeOIKlb7
	ccz+x9HkJ2ik62nTHHDHy/UTUY9TSsaR437nqgA5Svr2feR4ZknOXntgHzfI1Ib3NB7WmxoReIEXy
	MJRk30vw==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1HOr-0000000FWW9-1Egc;
	Wed, 24 Sep 2025 04:46:41 +0000
Message-ID: <e233370f-f23b-47b4-a31e-25c2df99a0f5@infradead.org>
Date: Tue, 23 Sep 2025 21:46:40 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: iio: ade9000, adis*, adx*: Convert IIO
 subsystem cross-references
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux IIO <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20250922063754.21190-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250922063754.21190-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 11:37 PM, Bagas Sanjaya wrote:
> Cross-references to iio_tools.rst (IIO Interfacing Tools) and
> iio_devbuf.rst (Industrial IIO device buffers) are shown in inline
> code instead. Convert them to proper cross-references.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   Documentation/iio/ade9000.rst   | 2 +-
>   Documentation/iio/adis16475.rst | 4 ++--
>   Documentation/iio/adis16480.rst | 4 ++--
>   Documentation/iio/adis16550.rst | 4 ++--
>   Documentation/iio/adxl345.rst   | 4 ++--
>   Documentation/iio/adxl380.rst   | 4 ++--
>   6 files changed, 11 insertions(+), 11 deletions(-)

Much better. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy


