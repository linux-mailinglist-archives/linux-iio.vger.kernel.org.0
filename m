Return-Path: <linux-iio+bounces-6995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF691B073
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 22:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C801C219F0
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0B19E815;
	Thu, 27 Jun 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seMWQcWx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6519DF9F;
	Thu, 27 Jun 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520329; cv=none; b=A2Io8zlP35RRyi6kRVZF4gIIqucn2bzD2NYwvQnSddbENsFoq7WBZSDhqiZBl/AzbgOQRHSZhI5gt1VWnPOK1v+53hgF+cGWo+m7gJR+ZmeNXDRjKWD/OoklkIbvc4qKZcqO6XagyILyvCwQwsrT26aotpcPst6krnUq4H1JR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520329; c=relaxed/simple;
	bh=f/LUCfA5QLVPUl99ZElq63cLHz53TISpyJapyBPiBF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rch1XmfjKXuPoDgUQ7rC0VzsgCx/EzOdRSWJ96Wi15OlLhuGzlrMY/Pf9MUO9dU0XZfmN3tscujCCYrxEOZh297c5BfuSAdLqHTnTj4Ssc0ALGDWnYnCKUuqF0GekCeqGrx8gJvwcyVPCwTTa8fo3MZ5Fz0j3njcye4eLZKdVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seMWQcWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2F2C2BBFC;
	Thu, 27 Jun 2024 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719520329;
	bh=f/LUCfA5QLVPUl99ZElq63cLHz53TISpyJapyBPiBF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seMWQcWxbnmmUGEsSIBNLCuiNqcp3TmbnpEgEfTuTVTiOz15fREUwIpWJ9urKLU8L
	 l5SHItAGEgaqRDyuBSJOyhmHGaLcOQP+rZYz3vpO2kSd8oku4FzNZuYaqpXOng7oxd
	 N8dx/t+9imWpICv1ieMHK9yCjYhOyy7dlpT/yavMarrcVLIWtcOmSL1B516sz9SUg7
	 0efgzYtLhlPTm/Y03cTDVwMSkeZLt/fjfPeSfjLQ829/TEDYPHYMU2uB6pBjfhLxi6
	 kvylseYzJSN5cDx3XtYoo2YzNZNHMT50MopJL8beZChVOLNaLEyRAuK120nCknkLrl
	 7XO/MNd1KwB6A==
Date: Thu, 27 Jun 2024 14:32:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	dlechner@baylibre.com, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, jstephan@baylibre.com,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings: iio: adc: adi,ad7606: comment and sort
 the compatible names
Message-ID: <171952032004.478307.5280182877867747227.robh@kernel.org>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-2-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-cleanup-ad7606-v1-2-f1854d5c779d@baylibre.com>


On Tue, 18 Jun 2024 14:02:34 +0000, Guillaume Stols wrote:
> AD7606-8 is referred to as AD7606 by Analog Devices. This comment aims
> to avoid confusion. Also the compatible names were not sorted by
> alphabetical order.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


