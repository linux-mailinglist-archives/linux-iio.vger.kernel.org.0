Return-Path: <linux-iio+bounces-4184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5089FE99
	for <lists+linux-iio@lfdr.de>; Wed, 10 Apr 2024 19:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB91F2371B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Apr 2024 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A517BB2D;
	Wed, 10 Apr 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qddJ6NjW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5F17B4F8;
	Wed, 10 Apr 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770438; cv=none; b=k6gAdiXNq5hWvqKRPxJ4iJ76zSfWqHTDlYmN0WiQh3qGOxiqF0k5U7b8IWMwXJrc2BX3NvJZqBshlox1aXARqCDLjc6A5iKYdoJ/J6FL7Vyk2wEWOgAhAs08q7sJPLEXRC0j0S+01YmsD6eAhwuv9urJX2j2aPItLY6tfnG4pSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770438; c=relaxed/simple;
	bh=FVEbt/gY3pwVZCMARf+nPQHhp7GBhBacGu6RmqqN3w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyoFZCQy87hs1PEBTz72FqREqWpUEKPIJDSc9UJutv+C70g+vqH9V7ewM1imS9d4J7hbUh0HCjYnfOELabnXZ/yzr7byQQRLSzhIce8ItiNPDqLSVsfkNP63S1S3uQDzA9QI8m4Cjw1PJgQDlDrEOOHTHfl3CXBRIZlRoMm8jHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qddJ6NjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0F6C433F1;
	Wed, 10 Apr 2024 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770437;
	bh=FVEbt/gY3pwVZCMARf+nPQHhp7GBhBacGu6RmqqN3w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qddJ6NjWlgKEDq3denGBeetfdD3quYuwiT0VaQnAtL9wpUGuz13WbnhC10Y7/Mkr2
	 5R/x3v+OBKB1NECnCflaRm95xtCDd5mu3VRusKAJEmQRae9MmeeMwwkZ1ooQAC02z/
	 JOIw1ueP/3ynArY1M0pPN1DsXEECwV+RZAJbMyAOAvsljkCnf5UsG5ip069bsMB//l
	 pGSsMEWZWL0vCwXqIOs9kRQJtM5P0CqXc4rv1KeYuftl6+BDxuH0zO1MuiZpVsllAT
	 DElyHYqhsN77GO73xWRfsfMhBnsmvktYpm0+PS+NQdcwJrGFb68V874BmVIICNOFEN
	 cjotehIDX2QNA==
Date: Wed, 10 Apr 2024 12:33:55 -0500
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/11] dt-bindings: iio: dac: add docs for AD9739A
Message-ID: <171277043314.785673.13483143132107132297.robh@kernel.org>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
 <20240405-iio-backend-axi-dac-v2-7-293bab7d5552@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-iio-backend-axi-dac-v2-7-293bab7d5552@analog.com>


On Fri, 05 Apr 2024 17:00:05 +0200, Nuno Sa wrote:
> This adds the bindings documentation for the 14 bit
> RF Digital-to-Analog converter.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   | 94 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 ++
>  2 files changed, 102 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


