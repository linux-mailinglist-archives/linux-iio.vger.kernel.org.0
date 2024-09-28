Return-Path: <linux-iio+bounces-9848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A5989097
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7914A1F22529
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47661BC39;
	Sat, 28 Sep 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpLpMmx8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA1210FF;
	Sat, 28 Sep 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541958; cv=none; b=Tkn+qAdGpVN4UvILL20BGc+9EeCSHdHY9mfRDMkLuEdM8wSgHeTasrHyAo7SMV8jojxMop1ep7IGNJRb2UN6Y0KY3hV1JCY51ST5Qo2UzUciBSH+FhXs86OMQdscIXCVP1P+7qtUJfE+ApkGAbRdq7gEbLHYO/ICQ/q5rmnenKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541958; c=relaxed/simple;
	bh=WApryzmH66rukuAuy+jm07E9eoB/7WIDC7wHujna7y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T80I+uTc3sx5ZIehOKOP/ttYSOKLp7MDC37RimAlEu9UrTpsknO9NNGOhZz2pdb5OtZai4Vbt8HysSaKVrA5Ilh4J3IIMnCGGpQsKvlyrjgVIMUZz9JG7aOtNIPgZMAiK0Pi+ct1kdZLxtYXoyPoYLtabM0rQU6phR0mq0NSetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpLpMmx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E657C4CEC3;
	Sat, 28 Sep 2024 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727541958;
	bh=WApryzmH66rukuAuy+jm07E9eoB/7WIDC7wHujna7y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rpLpMmx8AjGcuQXN8MNECLy4E/iwF6q9BHVj6Dt4PN1eUjzckcJJs5DRjlht1+XsC
	 SqmnhxKv+UTssd9y4HkyRX9T9aAy25/RDkKJ9Z8+Q9zHQ/er0z6R5ZnsBSokJJQn7Q
	 Js1QffEi5tWmm7qNYbYY/5TsWYFC+UAJEZPY1F66I0qb6a+FeeLahmr/xZu1peIlVm
	 scoSDY18T/d6lZ9jfkdDmMtlEHj9zQl2by6+U8lQYAYTU5qSA2tY3qf0b5RdCznGfN
	 Ent15CLUhmJK7OoQ+WZhNANYcYIaDIJpwhBdxbejm2uWElXvcmvHqGgpTJp0W8MBs4
	 ossKbmOZ8eWow==
Date: Sat, 28 Sep 2024 17:45:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add
 iam20680ht/hp bindings to mpu6050
Message-ID: <20240928174550.47cec40f@jic23-huawei>
In-Reply-To: <685c0c28-9439-45da-8bc1-19c2c56b2053@kernel.org>
References: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
	<20240923-inv-mpu6050-add-iam20680-ht-hp-v2-1-48290e0b9931@tdk.com>
	<685c0c28-9439-45da-8bc1-19c2c56b2053@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 17:38:44 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 23/09/2024 16:53, Jean-Baptiste Maneyrol via B4 Relay wrote:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > 
> > IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.
> > They just have better specs, temperature range and a bigger FIFO.
> > 
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > ---  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Ah. I missed v2 as checked by email address.

As per v1 review I've tweaked this patch description to say they are
backwards compatible rather than fully (as the fifo size is not
discoverable)

Jonathan

> 
> Best regards,
> Krzysztof
> 


