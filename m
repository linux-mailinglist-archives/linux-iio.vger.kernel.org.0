Return-Path: <linux-iio+bounces-17760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDFA7DEF9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E01888459
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7F253B6A;
	Mon,  7 Apr 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEa/Ibsv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6B248886;
	Mon,  7 Apr 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032118; cv=none; b=UdExGfoWOiE5CgJg6S3uL3JHV11gBsc1zXf7G1uWDXXUOKImmtv/mNVC4ZBKL7PoLDMgMJbWLqTxb3v7LNm0Qe/WRmzQLIFV0OjxDukzU913ihG5ieSgq0EwXejXnPCWrUSx/oDj3JlGMEXKhra1Ssm/BNZbVWyoYAP3x+pzFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032118; c=relaxed/simple;
	bh=V/kH4k91TKPs+AzEORJvwkcToawBFh+wxqDR82wVnZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kISIM5bl5bxX12g9ONyZrg5g0eqp+tyKfxl8epw12ty4RrbpXpSEYdongYOgTM5rfoqUIGOFqAdanzq1U0P/Qif/McbQtxfy4QZ8EX7Auoi9C3d+7lTk7oxGRGOcgIjvPCMgO6xeFWcru5ImVA/IBXXGM85kkIWpxIJ7Ef0KwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEa/Ibsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A95C4CEDD;
	Mon,  7 Apr 2025 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744032117;
	bh=V/kH4k91TKPs+AzEORJvwkcToawBFh+wxqDR82wVnZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEa/Ibsvs0y65fDo6FRf6d/Z6DvEaCgPX75o320p0x1gN1UDi663BMUrP+LX3o4P8
	 E0drx8PxP71ibevpOOVbs/7fWBR9H5vca3ZvIUfmB5uitcTzDO3eNEEiz3I3r4c+xp
	 ty6kBWupB99nxopCK6AMgIPEb5/cjlAl5QozeExpfndxdB54ot7wzQGcl9rfdyO4Uz
	 FPXR6VwvAAhf6ireSe7fhlCh+MVomMQ1qfpO5QYQ3hsXrh50J3GFFnKkulw1rgbYis
	 XBmGhOI6lIkKwDoe/0DA9JF2JdI0pmqure3y3PLDmILwi4iSmxgknwJMFgtGJEj1PK
	 wxZRMumRBum+w==
Date: Mon, 7 Apr 2025 08:21:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor+dt@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: adi,ad7606: add SPI offload
 properties
Message-ID: <174403211547.1955434.17881089530676144254.robh@kernel.org>
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
 <20250403-wip-bl-spi-offload-ad7606-v1-1-1b00cb638b12@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403-wip-bl-spi-offload-ad7606-v1-1-1b00cb638b12@baylibre.com>


On Thu, 03 Apr 2025 18:19:04 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add #trigger-source-cells property to allow the BUSY output to be
> used as a SPI offload trigger source to indicate when a sample is ready
> to be read.
> 
> Macros are added to adi,ad7606.h for the cell values to help with
> readability since they are arbitrary values.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 8 ++++++++
>  include/dt-bindings/iio/adc/adi,ad7606.h                  | 9 +++++++++
>  2 files changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


