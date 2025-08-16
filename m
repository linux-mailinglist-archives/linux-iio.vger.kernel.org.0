Return-Path: <linux-iio+bounces-22815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD384B28E08
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CB91891D92
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F792E2672;
	Sat, 16 Aug 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLdLj3pV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2B23A562;
	Sat, 16 Aug 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349950; cv=none; b=FwKEDBodr85T93rRi2/JqcNFvwAC9cdpoPOMauG84XeYj0EExzk7OSgpQI8G5YYG6hb00M0nOCdu64eIpAQvsPsSs1C9SMJarghbj9lX2BKJWeEMPXQJ2xDjUIegyDpvlxyUDQ+9egis8hRQS/w798dMrUXG+oMJ0NgPKVNxlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349950; c=relaxed/simple;
	bh=T0ihUu05oB0idqYsW4ppls0Ccy84ClVeS8cutf1iMJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8eYDkmxrGqSzKWOoQ5qXCsXHXYv2lCQVrohB6HIyBvFl2lQqiJDhmJcITj+tWKj7VTmxeKNBir9a2HeviR2GfLA+vXpw42mSNSCp8HfslYpk9ftUBQWo66HesXMcB2itj+9URVhnsgwS1OG+ZGo58HAY3RRjRDnASCmygBaQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLdLj3pV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC68C4CEEF;
	Sat, 16 Aug 2025 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755349950;
	bh=T0ihUu05oB0idqYsW4ppls0Ccy84ClVeS8cutf1iMJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fLdLj3pVC2liA2pM+LgfBMrAYou3OYlJ6bKUpA94Lwn1vQfIzPXwHJt+0smyFtxFB
	 nBI8FHnhdod6JIo0YLjFot69M+j9Md2fuacttWVSugJNVkdvXDwW9WX8lDc/WGorJ+
	 H4RL57YpIucgMV++PMBv5+f1N06hMYXjgmIX70KRtxHe0pNmB1EhRiHsNbg9/MKGby
	 L+1tNTty579ZHXXxe/HRghrT3FC8DocspI1Vzon3KFWed5Mbiv8UX/qGch8Dro62xz
	 +aFAuTuHV5a1IJhkR55mBydlVaUVR6hrtxTuHdlm6hOpTSTYYyxDKKXG/1sp3yEBwe
	 GzjFjfY/pxylQ==
Date: Sat, 16 Aug 2025 14:12:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: ad7768-1: add new supported
 parts
Message-ID: <20250816141220.0dd8d68f@jic23-huawei>
In-Reply-To: <8c27b00c-5b80-400f-8538-b9ad96fd5feb@kernel.org>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
	<ecb7406f54938658b51b4469034d87a57086bd1e.1754617360.git.Jonathan.Santos@analog.com>
	<c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org>
	<aJ0UEUVmIH94Nuwi@JSANTO12-L01.ad.analog.com>
	<8c27b00c-5b80-400f-8538-b9ad96fd5feb@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 08:03:23 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 14/08/2025 00:39, Jonathan Santos wrote:
> >>>  
> >>> +  adi,aaf-gain:
> >>> +    description: |
> >>> +      Specifies the gain of the Analog Anti-Aliasing Filter (AAF) applied to the
> >>> +      ADC input, measured in milli-units. The AAF provides additional signal  
> >>
> >> What is milli unit? Isn't gain in dB, so maybe you want mB? Quite
> >> unpopular to see mB, but we cannot use 1/100 of dB, so I could
> >> understand it.
> >>  
> > 
> > Actually, the gain is expressed in V/V, not in dB. I may have phrased it poorly, but since
> > there are fractional values like 0.364 and 0.143, I chose to represent it
> > in milli-units.  
> 
> Why your reply to is corrupted:
> "c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org"?
> 
> 
> What sort of unit is milli-unit? Isn't this 1/1000 of some BASE unit,
> but you do not have here a base?
> 
> I think you want just basis point if this is V/V (already in common
> property suffixes)
Nice. I didn't know about -bp.   That does sound like a good choice for ratio
stuff and here would be 100x larger actual values which is fine.

> 
> Best regards,
> Krzysztof
> 


