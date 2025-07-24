Return-Path: <linux-iio+bounces-21988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF0B10EB8
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5F1161FBE
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2BE2E9EC6;
	Thu, 24 Jul 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRemamHC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB41991DD;
	Thu, 24 Jul 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370899; cv=none; b=TcEBegy6LiLuZsXN+JNtPj/w7SbQYzvZjzVQlFIZhYPtJ3G48bcgdrFwo9wubSeViN+z8/5OWQqntaQfwxINnjP6u6Fv0iWCl5wB3yBTm5h6W4eAwJazYH6CCEorOp5VvVhIDh2cZD2s1BtSdojGbhOTjAVbDhFKvKn793SlsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370899; c=relaxed/simple;
	bh=Sm/Zvebbu1bNwWT2jtlvN/rqsm/jqBuHeyrtvaK/OJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI3WKXYPj++jeJoFdpgKCFG4P1JlaAqmG4gZ4VburzPRKytV8xPiKqoOYSKdgdVreFploc80amGnk6az+4gPiNnQCUhwERMoQY+QNbPnHUxsmVoeKM/mGp8Vpy+jz+0jZgwu4ZPKum3JDlOo+9Cp7pjut+jdai2z4YteNoCokVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRemamHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE35C4CEF7;
	Thu, 24 Jul 2025 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370898;
	bh=Sm/Zvebbu1bNwWT2jtlvN/rqsm/jqBuHeyrtvaK/OJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sRemamHCavmxiqkxiIpSQdeLtkQcomj/lJUyJSltGBqApqQdW9FQZGytGLdxzhZq5
	 1yqFeLAMj2oTonRHrszzvqB8nfjluRi0No8YDT1mqVzWtFWNVPo8TJsbqZixsD+HGt
	 yS/+0Ul/5ZNnysMh33CIp6DCoikuwanXMrPjfxxAvoXpVIZ+h9+vOlBXI04mlwOPiF
	 3FW5sTQM5ZM65l+48C5fXc+yhmMndyS4itCsJkyzy1guWSzuEL5FYscOYFQoIJyRqx
	 V1nVJy+sSKHrzNIIgr1eX4bCkKcXuBOLOO9MyQ/r3xUcI2Jmmt5p/vSq5J5VuSzrZC
	 ZgWhFqpr3Zyhw==
Date: Thu, 24 Jul 2025 16:28:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lothar Rubusch
 <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <20250724162810.214414fe@jic23-huawei>
In-Reply-To: <aHd1qDR3jNTKBbun@smile.fi.intel.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
	<20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
	<aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
	<j7vqnxx3d6cws2zsveqohr6iqtno5thlauypnowlijifiwx5ow@6arfipnjkfh7>
	<aHd1qDR3jNTKBbun@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 12:49:28 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 15, 2025 at 08:52:41PM -0300, Gustavo Silva wrote:
> > On Tue, Jul 15, 2025 at 10:37:21AM +0300, Andy Shevchenko wrote:  
> > > On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:  
> 
> ...
> 
> > > Is this already documented in ABI?
> > >   
> > Not yet. Should this have a device-specific ABI entry?  
> 
> I don't know, but what I can say is that change is no-go without documented ABI.
> 

Indeed. Seems this particular combination has yet shown up (or we missed
it for docs).  Add appropriate events/in_accel_value_available
entry to Documentation/ABI/sysfs-bus-iio

Whilst you are there, good to check that all the other ABI for this device
is listed in there.  Given we mostly construct ABI from a bunch of parts, it
is easy to miss entries for particular combinations of channel type and thing.

Jonathan

