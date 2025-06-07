Return-Path: <linux-iio+bounces-20289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D8AD0D8D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3281B172FD8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91865221FA6;
	Sat,  7 Jun 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtJFaQc8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FECA5A;
	Sat,  7 Jun 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301702; cv=none; b=sKB+zDHvGPu6BDD2k3XBChrtRgAJnDiLw7gZU8Wvip79zn/Kui0qvcskO4YDpBk+l3ylQfYouRk6wLsUjAzoCsy1/Qe1pM243djsP+NJtRtn7eBEq8BEKo2aBUBkDFNKiQ2yumrmpQoOt/Swvfy+k6WYm7nsub9rB76tmUZ2EpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301702; c=relaxed/simple;
	bh=yhoju7r33G8rTolP8uGuqI1d8kbL53ldIMQ+cw+zaBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEyP4GlFulS58ZUe7KO8pvFu/DYxCV2mAIlg2Uwq+IZ/as5bCoKoAJrOSxsdpKKXpdmTUhqBAKONT5SAN9es4JVhyxE6sQXbTI8sDVMl9608HBlNf54XSJj/OlcH+vd9791c6dafb5Vu12w4eRoErg2o4zY96qN0czX3Y1V6NwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtJFaQc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DCDC4CEE4;
	Sat,  7 Jun 2025 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749301701;
	bh=yhoju7r33G8rTolP8uGuqI1d8kbL53ldIMQ+cw+zaBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtJFaQc8n6srES9D67KgwVj0HeR2/pM79QAXzEkcUTCTcExCEN5WXA9hIVWNEeH80
	 gUqOvruxNxYncVEAPcDcqh5Mu3zyYhlNjDEv8KzChQVHUS0h3Z7K7yh4WwZ2KBSINn
	 nSejnzW23RS4BR8Y2aQtOVI4Ei5NDyuvRsciEW0s87sEKlDOiKpgy5zwIClmMMqc0M
	 EEgqwjh7XYx2kPu6WobG1Ovxg2qQPNZirS3H/RNeBlSky3waoclnMEKpNSIiDonXl2
	 fzbTQ+ov4NqXjpWw2DIbmNvuUeURvkj3p/M322rdQagZEiWWGt8EZFMOlMLHwhsbIh
	 C/Rq5WJramDTw==
Date: Sat, 7 Jun 2025 14:08:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 0/7] iio: adc: add ad7606 calibration support
Message-ID: <20250607140811.4bff9232@jic23-huawei>
In-Reply-To: <aEM-C0HHPcYTTpBd@smile.fi.intel.com>
References: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
	<aEM-C0HHPcYTTpBd@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 22:14:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Jun 06, 2025 at 04:19:15PM +0200, Angelo Dureghello wrote:
> > Add gain, offset and phase (as a delay) calibration support, for
> > ad7606b, ad7606c16 and ad7606c18.
> > 
> > Calibration is available for devices with software mode capability. 
> > 
> > Offset and phase calibration is configurable by sysfs attributes, while
> > gain calibration value in ohms must match the external RFilter value,
> > when an external RFilter is available, so implemented through a specific
> > devicetree "adi,rfilter-ohms" property.  
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied to the testing branch of iio.git.  I'll rebase that on rc1
shortly and push out as togreg.

Thanks,

Jonathan

