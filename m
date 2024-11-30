Return-Path: <linux-iio+bounces-12847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8D9DEFB9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 10:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D8A160455
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2491514F8;
	Sat, 30 Nov 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+7eNGmd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65F33F9;
	Sat, 30 Nov 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960571; cv=none; b=HVnY38Csxi+3r7V03w5Wshk90Jm2AwW9d3fBJm0YayuSOGeAL+fatkj1P/7+otn9mNf7WfwFaci3U38LxdA4D8lYJNEKcfT+luXjgya5dR8TzY/1f2grRtI+bnmJEwJYg7bfD9XUexfTwPSIoBRcxvkjYZfTJfdkVSz5btItOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960571; c=relaxed/simple;
	bh=WabwCSy4qiBKUD5ZmeCP7I8gRV16Q+/szbVIJ0Q6FrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9GpRukwKh/KmNTZmfgoFMFaW+pn+9wRSGBwHr92WC4Fro7mupyNFuowqcZZw4NmpjShxkbcjyG8eZsf0NJFLOhv6RpLrHCdlKuJeK1uuP15IFBQ1jMfZjNplrkqGLg5qVSKiQk6rZWlU8Cg1FFCYbXeMh5JrrYjrwcSQxujKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+7eNGmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADC7C4CECC;
	Sat, 30 Nov 2024 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732960570;
	bh=WabwCSy4qiBKUD5ZmeCP7I8gRV16Q+/szbVIJ0Q6FrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+7eNGmdsNKSzl384qHvT4cSrCHB8/ujBcfztr5GTkQsRvhbs9N/NMed06v7WkJKJ
	 iOD6EyGwuqDcjYaak2kRu3rugVoGvbz7oH+qZtfdkPLYharBxE501xY7nhLEIELoK1
	 BoAgV+Z2E1IkGPXDyCf/Te1BkquqW3W65Nqm459PzVekxCdyvx4Z707fDX3nTDE/ug
	 ga3Xu9fm+fQw56NPJ7KUzVB39cecaG3oXr6Vwt8LO9TT9L6dcACFQL03RKVV7cjknV
	 EHxtDMj0JnRqncQzYYgK5uTqnRB4v1jCYE5dziq90I960XwHUejHdBHEh4QoFkQ4oI
	 IQujrhzki+E7w==
Date: Sat, 30 Nov 2024 10:56:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: fxls8962af: add wakeup-source
 property
Message-ID: <k4udl2se7swwlqcq763bwydifkfwdzwem2crwroo2ohmv5j33o@zr25gt2r2x6h>
References: <20241129-fxlsdt-v1-1-ff7697a47cca@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129-fxlsdt-v1-1-ff7697a47cca@geanix.com>

On Fri, Nov 29, 2024 at 04:01:24PM +0100, Sean Nyekjaer wrote:
> Add the wakeup-source to enable this device as a wakeup source if
> defined in DT.

That's a circular argument. Especially last part "if ...".

Explain the hardware aspects / reasoning.

Best regards,
Krzysztof


