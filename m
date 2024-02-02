Return-Path: <linux-iio+bounces-2104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062008479D3
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391061C24363
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4280601;
	Fri,  2 Feb 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll9QuydX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DF80600;
	Fri,  2 Feb 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902991; cv=none; b=ACjHIfASOoHFA3yKud2lg+5PnbIeofIMyCJLS9J5EVsIDBLyaaMq29q12lrYyctSyhOqiHPttOXbMG4RG07ChnHHLsMwEGtxd1zT2WUSJevqG2JCHG4DwEv5gbvoDG5uYjGDErTUW7HSWkEcM6+nAGG6VI3+A7r/oZEJ4OZAtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902991; c=relaxed/simple;
	bh=cUcFLLlsjk7WbOgGfM+Zedf9W0MOG6p/9qlCVcXVn2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ6Fhsp2UaQmBzDSu4Uu+GQoUUUxcUwoIMREd2eRkr0idyxythXOJnK1+51pr3YWh3UfGNrK7cOB3TVw0FJ92j4mr9GdEHk13Js3C1jmbM+qtebC7N5FgiG+flo2RqTE47SVBPcQrj/ZfaQIg5fQFHOPoFGThm2L0vo3aEI631I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll9QuydX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3889AC433C7;
	Fri,  2 Feb 2024 19:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706902990;
	bh=cUcFLLlsjk7WbOgGfM+Zedf9W0MOG6p/9qlCVcXVn2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ll9QuydXNFX1RbAqrFbL1AGQgoApXwUbnU+TQqCYVfbdT3ZirVzg9pPgfvmDxNrhK
	 w2h9Td1WUJYJZXkMbQUEX8i7zMscKiNugV/xB7IQDzwkH561aSbTqeUzpoPYL15ljz
	 zDQ9aUUYW896QV75x7Cb2WkDo75dT6RHMmXkyOd0Brn1fbgIt6Kkgzi0nro8DoVdmY
	 hdzpnCYFJGdzRRUmrIMMOgSRjLqOVjcNq1oR+0GkfyETwIKWwM7fAg8F2Oja/yZURz
	 g5K09udZCVNX7xqiW3k2zPajjZZGYstrG/0wM7KcHSauQrOcL/6JNiKBHz0w+pcm8h
	 r0AqBY1mSlvsA==
Date: Fri, 2 Feb 2024 13:43:08 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <20240202194308.GA806128-robh@kernel.org>
References: <cover.1706692153.git.lorenzo@kernel.org>
 <93160585e69e4531a981064817ccbb143a6a1f70.1706692153.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93160585e69e4531a981064817ccbb143a6a1f70.1706692153.git.lorenzo@kernel.org>

On Wed, Jan 31, 2024 at 10:11:31AM +0100, Lorenzo Bianconi wrote:
> Add device bindings for asm330lhhxg1 IMU sensor.
> The asm330lhhx supports a subset of the features and functionality
> provided by the lsm6dsr via identical interfaces and so is a
> suitable fallback compatible.

A subset cannot fallback to a superset.

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index 28b667a9cb76..316601b2da7a 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -49,6 +49,9 @@ properties:
>        - items:
>            - const: st,asm330lhb
>            - const: st,asm330lhh
> +      - items:
> +          - const: st,asm330lhhxg1
> +          - const: st,lsm6dsr

Assuming this is correct and the commit msg is wrong, can't this be 
added to the existing entry?:

items:
  - enum:
      - st,asm330lhhx
      - st,asm330lhhxg1
  - const: st,lsm6dsr


>  
>    reg:
>      maxItems: 1
> -- 
> 2.43.0
> 

