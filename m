Return-Path: <linux-iio+bounces-12558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECE9D6A44
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B00161872
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3AB13CFA8;
	Sat, 23 Nov 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNJ5KCdX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882F17C2;
	Sat, 23 Nov 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380220; cv=none; b=Zm0f1LM5koIpW9irmun5c6K6R0cSQaGdPQWYmF/cIpfPtLllFvs86utA4f94AIRvIHDKSdDDXErCsmXVUkw/zWNwSbHpn/v3ikdHT5rGFkZ+3PELGLN4bDQcPQttGTxg5sCY1BWJxjqT9r9nBgfzSope7QdiO8FmlIl9Z9bUM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380220; c=relaxed/simple;
	bh=gEN+6UlC6bDyYXGMy02g0HVZ3kyIwQPnNjkS0Ttjsy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiqbWuFKULpCHnOA5bU6K7EKwQ6K1rCmr8VlkudqqDcuf7jmieSy25ouNiJOFw0AJRlgI+qGm4xsnCSXQ84byuiu/N8HqcgWF+nPSAeGXMP+bAkddnjSwtMllrtXznNB3+Su0RVIxJQvtmIWFYyrfFZGpo10sCIgnpCElnKG/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNJ5KCdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E93C4CECD;
	Sat, 23 Nov 2024 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380219;
	bh=gEN+6UlC6bDyYXGMy02g0HVZ3kyIwQPnNjkS0Ttjsy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lNJ5KCdXWgpGQf8DMXPPeGtZ8JTM8VmHeO5bQIVm5VPrWIUWL4Aw3yTvuW2HbpFEn
	 XGC71PcfPYCsHj4f3i6zsMg6N6LeLzeGuL0cP8Pv6/+EyhjfGt9D0hkbP+VEw4k7QR
	 C2tLLqsds3cqx3aNGXtzUEmhFVNDtM+9sLxhCOUd2HEwAUp/npxn08xP7jM2Jddee0
	 zXN5vp9J94kVO+ilhnr+qw1vEwMQN+11EfdINwoAtFvkUlP7LrzABQPKWnp/D62qPf
	 XacSdW7M0CKwmG8HD1iCKgsoou1Z3/z61OrukP2Gw0zJrmEgKTW4lcnquHuAcczE6j
	 oo6mR4oe7ASWA==
Date: Sat, 23 Nov 2024 16:43:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] iio: accel: kx022a: Support KX134-1211
Message-ID: <20241123164333.66cf89aa@jic23-huawei>
In-Reply-To: <833f2f066e12021bfbca25d84f9c4673b902a8bc.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
	<833f2f066e12021bfbca25d84f9c4673b902a8bc.1732105157.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:21:46 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM KX134-1211 has very similar register interface as KX132-1211
> does. The main differencies are the content of the "Who am I"
> identification register and different g-ranges. The KX132-1211 can
> measure ranges from +/- 2g to +/-16g where the KX134-1211 supports
> measuring ranges +/- 8g to +/- 64g.
> 
> Support the ROHM KX134-1211.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Reset of the series looks fine to me.

