Return-Path: <linux-iio+bounces-7591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FD593055C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 13:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FC6281A76
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532A7344C;
	Sat, 13 Jul 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB6i54o9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2260263;
	Sat, 13 Jul 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868804; cv=none; b=nqmuKeaMfcEfQXhi/1Bmyt2If+ZtCsyXESvkIqVvKtv8e/d87H3Ir613VZDeDjZw98BWJmxLLozSnboZrSPJz5c7jIT4OKg6C8yz+K0keJeJo2QM3guF2Db8YTOJ+zT4i8J+7WHDhgFglcwr7+B3SAAGQ0uGY9F9xARSLW61DOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868804; c=relaxed/simple;
	bh=LNl41GyuGhQ0j2OQEOuSuugOoEqSw4eJrNiqPr0BM/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbJZP7ovhIx0TU4nDuY5NBRmjaeZSP60iupY9LUTW7oyUFK6mK8aKXTYpe9+iKUgpp5JNEl89x536sVrBmnbIBqk5RnFeZzz9/I/Or4Mo0yNdUd2RgilvhUppcwf5C08hmCDc9zLrbdTPOD7PFElZjsbH3WArNlJFexLO8UgcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB6i54o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C52C32781;
	Sat, 13 Jul 2024 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720868803;
	bh=LNl41GyuGhQ0j2OQEOuSuugOoEqSw4eJrNiqPr0BM/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kB6i54o9IWa+rzA9MONbSDrVL4sKnOlj0QznlLlUu9luW8wh/11IIO4pMn937ej0X
	 cwX9kH1lW6QHzzZXBTVIgmZFJ9l9/CxC5ChCCAp0ij0bVgVs71eWw4+VNiBy0U50sU
	 popKlDoLfnQesKk3FD+pbzbRUZctk2GaNJLweUOltqhmqaHEG+DC1EROpuYoJvmsJM
	 T2zE1kQ6URA63JGZIL1F9uy6a+WEXUodRZ0aUn3b9Y63MrrIIl+RpM0cTgVju5kRni
	 ZsvYud7ads9gOCU8EVfBZEHtd/Z3s0FPXPuYU9l8C0cXLM2aOzsOaUFHLLJ45Czy9A
	 3sFb+XfrOw5aQ==
Date: Sat, 13 Jul 2024 12:06:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Shreeya Patel
 <shreeya.patel@collabora.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: ltrf216a: Document
 LTR-308 support
Message-ID: <20240713120635.69fcdda1@jic23-huawei>
In-Reply-To: <9c6d56a4-6797-4748-b08f-710b4a0b5280@kernel.org>
References: <20240708114227.18283-1-marex@denx.de>
	<9c6d56a4-6797-4748-b08f-710b4a0b5280@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 10:26:17 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 08/07/2024 13:41, Marek Vasut wrote:
> > Document LiteOn LTR-308 support in LTR-F216A bindings.
> > 
> > The two devices seem to have almost identical register map, except that
> > the LTR-308 does not have three CLEAR_DATA registers, which are unused
> > by this driver. Furthermore, LTR-308 and LTR-F216A use different lux
> > calculation constants, 0.6 and 0.45 respectively.
> > 
> > https://optoelectronics.liteon.com/upload/download/DS86-2016-0027/LTR-308ALS_Final_%20DS_V1%201.pdf
> > https://optoelectronics.liteon.com/upload/download/DS86-2019-0016/LTR-F216A_Final_DS_V1.4.PDF
> >   
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied to the testing branch of iio.git which will get rebase on rc1 once available.

One minor request for future series. For any multipatch series it's helpful
to have a cover letter even if there isn't a lot to say.  It always provides
2 things that are useful:
1) A title for the series in patchwork.
2) A place for people to give tags for the whole series in a fashion that
automation like b4 can pick up.

Anyhow, not important for a 2 patch series, but a nice to have!

Jonathan

> 
> Best regards,
> Krzysztof
> 


