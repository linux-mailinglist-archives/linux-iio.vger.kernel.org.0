Return-Path: <linux-iio+bounces-2353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8D8504DB
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C0CB20CCB
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E55BAD3;
	Sat, 10 Feb 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI4cRHuB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255954FB3;
	Sat, 10 Feb 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707577959; cv=none; b=hIMVzgAnLg1W96KDlUjh091TYsM0kv+/slZb+rz92l4HyFbR7+Stj5TopBTwjZ3jjbpAOotNxPWln/aDtPGSH9XkIQ7Cfc2uF6WVPthROD9wSMuFdIIqNylYO/197yPRfGkgLvP1aBPWyqx/hwhiS0lzIywBhS7Ner8E3FQD/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707577959; c=relaxed/simple;
	bh=Bqdhe6m0hszTXiqousyJsHzppKR51PKO0JlO3RE6qMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMo0K3P34+rEvhD+rT6tJXEO9U6iNPEMKS3aPRepz//P+tYm4J8cbmn1W9gwjl/6xqlkeT6bHoJezuGQOeqGgTFn4Y3miWPep+jmFgosBExZTc7i1ahy2XkdY652iGvSBiZt8Lqo3qwoyBaHNIlaZBYPyt3TKRh7HEsJBgszmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI4cRHuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADD5C433F1;
	Sat, 10 Feb 2024 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707577959;
	bh=Bqdhe6m0hszTXiqousyJsHzppKR51PKO0JlO3RE6qMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LI4cRHuBhmuYT3wQXMIIYKbPfcTOXbIGi9dxE7c/qyVg6nK4DnkBoLkin8YJzQ242
	 ylm9WJYACDOupoQ/YfoGQwaZN6872OyVt9cbb7SY2Llwjb1ViyL+LBfRdHjznh7+g1
	 alzlLc3yp8mThTM1N2f25OB3/ecqha9xytiEDDhqAj4ZOJaoNDpSOANlez23HoBJBU
	 JIZZ+bBGLqBBr98IvgnksLGJyUCkGePnfmp59Q6aFs+Ecqyqwg0ZDO+5JYdEHLYtAz
	 E2wRsoDkCWOMVxOjCcZYeiLcYhEOlc6n3nkrHc/IjiU/gh91n9/DwaBhakcIH0Nul9
	 5emnwrJcKg2Tg==
Date: Sat, 10 Feb 2024 15:12:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <20240210151228.38702142@jic23-huawei>
In-Reply-To: <170714168769.3273951.16124017499544303407.robh@kernel.org>
References: <cover.1706961432.git.lorenzo@kernel.org>
	<942452ec9626bc1166501cec0fa88c369e28ec6f.1706961432.git.lorenzo@kernel.org>
	<170714168769.3273951.16124017499544303407.robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 14:01:28 +0000
Rob Herring <robh@kernel.org> wrote:

> On Sat, 03 Feb 2024 13:01:38 +0100, Lorenzo Bianconi wrote:
> > Add device bindings for asm330lhhxg1 IMU sensor.
> > The lsm6dsr supports the features and functionality provided by
> > the asm330lhhxg1 via identical interfaces and so is a suitable
> > fallback compatible.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Series applied.

Thanks

