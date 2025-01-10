Return-Path: <linux-iio+bounces-14103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE9A0961F
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 16:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA7916ADFB
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93D211A0E;
	Fri, 10 Jan 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4U/6uXE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540120E035;
	Fri, 10 Jan 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523769; cv=none; b=GFpm5cKRw3JCv7tnatpkMBMcE91cVw7laiN4RYOel/7fy7Jdf7LV7icSKlywxC6xKsDrIrVWxPJEFhDSVBNLOi4ZElgAKCpviOY8PIv4aKr5Riq9gtQvXm07lXtbHIn0Tt9xQkC1POn7UvbvmyxmdzsYTpol/4e7u3TSROqJz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523769; c=relaxed/simple;
	bh=F145dwAnWMHUbYxWkZNKLYYzrnV3SdztVfzH/safPO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmxtcDkhJWqF4jFToM9fVyTAsmBGjKKVx1Go0M2GlYUG9p2szV+6UGTQkC6WCEcmiduOV5sDwoqjXq0+AzerelssmWSOHZXjmXNgdfPIZcL5cV5GJ/zsfugpL6qYyLfw2A8VEfukUQGQEouDDjBP8wMVqE5W3xS3BMeXjk0BZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4U/6uXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03D6C4CEE0;
	Fri, 10 Jan 2025 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736523768;
	bh=F145dwAnWMHUbYxWkZNKLYYzrnV3SdztVfzH/safPO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4U/6uXEM/W4wiIZtc6Woq8tEPj8LQ1Fm6Lc3GVnFdos7AsRyxlM3lpeQVttDtlip
	 /LEMrEqSZn3/XozjlAyHbFBGtvOXvghsrViN+VUxqxpwKXB9L9Fs2/mXfQo8we3ph7
	 bf5FCI4pgP5hjtAx48FCjD0LiYghAy1spRtm2fxZnhCqXsp1doYWBCMEaeNFDQlsve
	 Z0PPUoEmmsqIxTJd6ucxALCcKBzgTWyOCrg/PC5IvB6/+88nFQjU+fdPNs2kF8xFyO
	 KeSCtF54Rtc/Xs0YV3cymsfd35Jx7/YCybf6zLuv1JdnYMRFWeWz35qprdr1/Q9Ie+
	 Vle1EYu2AI2Ig==
Date: Fri, 10 Jan 2025 09:42:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Sankar Velliangiri <navin@linumiz.com>,
	linux-kernel@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: Correct indentation and style in DTS
 example
Message-ID: <173652376728.2921641.1113859782852568912.robh@kernel.org>
References: <20250107125848.226899-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107125848.226899-1-krzysztof.kozlowski@linaro.org>


On Tue, 07 Jan 2025 13:58:47 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/iio/dac/adi,ad5380.yaml           | 18 +++++++++---------
>  .../iio/humidity/sciosense,ens210.yaml         | 12 ++++++------
>  .../iio/temperature/maxim,max31865.yaml        | 18 +++++++++---------
>  .../bindings/iio/temperature/ti,tmp117.yaml    |  6 +++---
>  4 files changed, 27 insertions(+), 27 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


