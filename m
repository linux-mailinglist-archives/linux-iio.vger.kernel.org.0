Return-Path: <linux-iio+bounces-8122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373459440D2
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 04:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F2C283AEB
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 02:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F015C0;
	Thu,  1 Aug 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZA0/k13R"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80412139E;
	Thu,  1 Aug 2024 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476636; cv=none; b=g3N67Ml4dRZo1MPD22Gpc2w+7vV4NW0PFhWgDfRaNyFYRDEm1wt2jR+ydOP9WLhuruMCjHXfEeYP3bggiArmlLGkgjxYXVF03dUzXVRyUjD7CQwa5CCYPUQNpPwOkNmcFWX2xX5/Ma3A9WcI/v2PFm13UrGu0T02SbkhnRRfDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476636; c=relaxed/simple;
	bh=AS1LCHXQtKq6pUr6NLuE7aPFuKrQxaWhJ6ltUhBJHx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnCTyaSqL+W1BMa9TlL4DlgWaB89jy766n6Y2TXOJPLjJFv98K4BkwQKwGf7QBR4Q7vkr2T9BP3BWy5b4clwIQ+m64RCyRqA7a/3f5SeIfjbT3gjsM7RjBmRl4I+Nqv4JJroQyFeOzgXpW7mLcpoBy4guTNOFsmh87phLM3QQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZA0/k13R; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722476632;
	bh=AS1LCHXQtKq6pUr6NLuE7aPFuKrQxaWhJ6ltUhBJHx4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZA0/k13RoCLi1mQmZBnLLd2hgir5BGyXO7uh1qdFbf+okSL6+0jY1qv9XVKBw4Nb9
	 3NhSvt1DuycKpU5kJQyH+OR8lbx4iHd/kVGpbIZadSETlczSYmKIIPeSHuHTa+JTVw
	 r/76CHEK79y5qMbXr83J9vB/YSowkNsgkvJcWNR5vTY1ihdZPDPONxoWgnmtn4XaiT
	 f1vyjiW+jwzzunPdj6rHFh0deh4A1QdWvm8cakFR3CuS1wO4x/EQQQVAyOKnQo89qL
	 UxCeZbYfd6aj2E20b++q/CpASU11v8C9t5Sc5rrkaN3GG58Ya2dHv36TQ7bVItWOk+
	 Y/Wv2hjFXddQQ==
Received: from [192.168.68.112] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4457164B84;
	Thu,  1 Aug 2024 09:43:51 +0800 (AWST)
Message-ID: <3770677daec27d5cfa9c952ba03a77875bc24b56.camel@codeconstruct.com.au>
Subject: Re: [PATCH] iio: adc: aspeed: Use of_property_present()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  Lars-Peter Clausen <lars@metafoo.de>, Joel Stanley
 <joel@jms.id.au>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Aug 2024 11:13:50 +0930
In-Reply-To: <20240731191312.1710417-5-robh@kernel.org>
References: <20240731191312.1710417-5-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-31 at 13:12 -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

