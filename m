Return-Path: <linux-iio+bounces-8690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D766F95B6F5
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7567EB28012
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D971CB30A;
	Thu, 22 Aug 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/BPo3Zx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE21C9440;
	Thu, 22 Aug 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333814; cv=none; b=HJ+S15I9Lgu45mKOdiVM7Omg3ykuJ6IWrN9Za2uYOEOFi+cwGI+plRl0Rh9JS4SqQ+9S8rq7e76tJJ3Uwo6a2ix9URzBRQENnsPrRSa2fqXpP11zJZOx2VK55KJp5CCIHREbRddz9Vqu4bnd3gC7lzdpE38WKs0VvF/9NwBiA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333814; c=relaxed/simple;
	bh=BgJ/l3mLoRCmwuPasSyagHjNSTpSdxRXrQBy8TafvrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GFbzKrNnTn5WwuSwqFfHJZ8wL7A0QYpEtMC1WjrgwfsdzZjGIahR5g7SVRmQaazql6//Aa3xVSVVOLqo1T3C0i9OACsgNhLlPuWg/hYQXbs8mFdRq0+PwciYKyDxoiW35qb0Ndb88niwkatrFeEnhfci0sHjpTeLw2C4H0oc2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/BPo3Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2D3C32782;
	Thu, 22 Aug 2024 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724333814;
	bh=BgJ/l3mLoRCmwuPasSyagHjNSTpSdxRXrQBy8TafvrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a/BPo3ZxjQoZHELA1xASGiCDPMFsQ+/njjHcPiKgKEx9xhANryJCun1aXaAvP75x3
	 OaASKC0dJbaeombrq1i/HZsjNqi+6uwdqNX0jE0V3GwDjjE5XVofgcHlK0UPYBuxuw
	 5raa7jTuOkLpOjaj4s3c42LWilBe2O54a9S0MD/Mjm+p2kHIFI6ZzPYs2IOjaFfxKw
	 rm9LXKYCT2tEjdD6y/GMc91Qzw11JeZMcy/cbF0KNp1cM9I/GQl7+BO6pdO6xxVic/
	 iKfvPw6pUwjN5oYIMz67jKLvpTGJtcX1E80ymuLBxlzAwSoF10ppyoIAyePyh/mc72
	 ctvLM9tH+w/iw==
From: Lee Jones <lee@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org
In-Reply-To: <20240820-device_child_node_access-v3-2-1ee09bdedb9e@gmail.com>
References: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
 <20240820-device_child_node_access-v3-2-1ee09bdedb9e@gmail.com>
Subject: Re: (subset) [PATCH v3 2/2] leds: as3645a: use device_* to iterate
 over device child nodes
Message-Id: <172433381069.1325598.16630400730677266254.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 14:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 20 Aug 2024 21:02:27 +0200, Javier Carrasco wrote:
> Drop the manual access to the fwnode of the device to iterate over its
> child nodes. `device_for_each_child_node` macro provides direct access
> to the child nodes, and given that the `child` variable is only required
> within the loop, the scoped variant of the macro can be used.
> 
> Use the `device_for_each_child_node_scoped` macro to iterate over the
> direct child nodes of the device.
> 
> [...]

Applied, thanks!

[2/2] leds: as3645a: use device_* to iterate over device child nodes
      commit: 1041e1d4f061e65a3c47cff34709864293f07284

--
Lee Jones [李琼斯]


