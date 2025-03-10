Return-Path: <linux-iio+bounces-16660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFEA58F5D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D4A188FB37
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DC224AEB;
	Mon, 10 Mar 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0RyDN56"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A722370A;
	Mon, 10 Mar 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598578; cv=none; b=gXi5IGM2V4S5Kqlj6YKAao2xvQ0q5xvLfv8P/90tsd8Ve7jK7Fp6xzBIJ2jJ+mN8Fug5hBWMIfujFRlItXX16JMy2zKwY2xgcCMSlutZQpc0W6VXaBdYHAa/ujQ+u/rGxsJJHtTm80wQuOB5X6y6xKJ//tb8sV75vCoR91eioTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598578; c=relaxed/simple;
	bh=empWCAwhVVuk9s4CO7cWqo0QILJMSHeFLdCB5/FIrIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH7iF/lSuSLUKy/xFRCOUPvNgY6Zw0+jS07ekiaE9bTFnNhuAW8KUKsRuD1na1kl0AzXxbL0RCFg/s4GjW8spm/gcNcNl5+pBUtvcZOtu6Br3jhrAwClSPJTxm1wFysnmIEBlO9A1qkYem/6tb3ptKOiiuESgPMLi1LjEd3zRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0RyDN56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13F8C4CEED;
	Mon, 10 Mar 2025 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741598577;
	bh=empWCAwhVVuk9s4CO7cWqo0QILJMSHeFLdCB5/FIrIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0RyDN56OHOaAvUzijJ9Q3RwQPzsR4MM/hicIzVUBTn5WLW8VJxj0w1Xk0YeHSnEX
	 5bGfcvrJd2KrzRPpABP1Zi84JoEkxrsDQC94IJNN4o4enZECwHH+oTgVhog9IYfnEO
	 0krTLwTQ3XU7iQHXTP6M7NARwxzi39sOIw9N+RPQ7vjavigBMNj0HFCkH2VuG3QW0o
	 1Qfu8Ia1/ev4hOUHp5Enx+4g5xzYnAUMAKWrJ3D9mXvIJ/dV/LQ8ne2xWjq+ZB8cyP
	 WEtSPnkX0AlsDRlIb5dCnaojOoMPvTuCLqn/ln/XsPnmJ5mQ4dFqhnWOhWlmUwvnfr
	 ekIy2/kdBST/Q==
Date: Mon, 10 Mar 2025 10:22:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, bpellegrino@arka.org
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <20250310-tidy-infrared-mule-a5da3a@krzk-bin>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307150216.374643-1-sam.winchenbach@framepointer.org>

On Fri, Mar 07, 2025 at 10:02:11AM -0500, Sam Winchenbach wrote:
> Adds two properties to add a margin when automatically finding the
> corner frequencies.
> 
> Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> ---
>  .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


