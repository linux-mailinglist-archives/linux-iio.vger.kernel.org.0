Return-Path: <linux-iio+bounces-13073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F59E32A7
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 05:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171C516871C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 04:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5B155C8C;
	Wed,  4 Dec 2024 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfqFAy1k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE99219E4;
	Wed,  4 Dec 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733286464; cv=none; b=E2NVL4C93NqDFKH+tN4DAUCN7GftpLt5syJMVSmuQfZvODt5qGeEQchg8TPeQcqsHiBmsHmcwoa+09z/xubfi6BWbLGkuz3Ri6EQvS9YggMnLT6tMsxEmpPnbpXWL2VVt/GAb4ajkqAXek0Zm52fN0TNhPu440iCcOulRhWPI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733286464; c=relaxed/simple;
	bh=s0E3gcq3e6cneHEa28ew8UWbRCJ77LQjBy4rKqIhalM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfCr9o4imPags8PNIQqNpG8XUEK3Kv3XC+my8S1IAEkBpZes5gqaRPlmi3rYPQiqreMlSnNIqhZqsyyOSUnQoKiHGDUm0StaAvl/DhmNxHDbn2aAywcYpieMaDLNyVw9FF3xMFvoUlVIebsuSYuzb1XXfiCvYkEqX8bT2xnIAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfqFAy1k; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733286463; x=1764822463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=s0E3gcq3e6cneHEa28ew8UWbRCJ77LQjBy4rKqIhalM=;
  b=CfqFAy1kUNC25yO9IYYtXfIgNKdqkWpVtMrgCJI0gIN9foCGye7blJaq
   QdT2o7lnad1h/mEpKsTuox81fdqPyYoGVjE6G+YKGcOonDRQeARaWSjey
   yIXNiq0yJMtPwytDJZWyspdc/DLMZgw5qE3v75FDrauOeIR3p7A3514fh
   NqaW2wQhQ4UO7T5x4bG7W6srbDUoLAiBD05hLxUZESBb7fUm3XeS2xE8q
   xnudDiaLyBygBIDb8JreDyY0qpVjZobVmhfSmMBrDkEsP5hetWF8czcgX
   +c90YKm5Yx/0u6/jdai3yrI1/xxora+RXqLwriBjwT5Vp8npexceocY3m
   g==;
X-CSE-ConnectionGUID: O0gCT30sSxSZzz2TTI9oVw==
X-CSE-MsgGUID: mHXO/tnGQTaJgjOCaNfSgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44196054"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44196054"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 20:27:42 -0800
X-CSE-ConnectionGUID: GNeRPHi7Ro6aYZQf33DG4g==
X-CSE-MsgGUID: VwKyph+eRS2iBB2CaT/B+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93988426"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 20:27:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIgz6-00000003dvG-1beY;
	Wed, 04 Dec 2024 06:27:32 +0200
Date: Wed, 4 Dec 2024 06:27:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com, tgamblin@baylibre.com,
	matteomartelli3@gmail.com, alisadariana@gmail.com,
	gstols@baylibre.com, thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com, mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <Z0_aNIrNvLxqcRHv@smile.fi.intel.com>
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com>
 <Z08MkR40fjfW3MXZ@smile.fi.intel.com>
 <CA+4VgcJW=9rtuqr3VZbfA8QxgYAR+KvfAHdf_0xv4XLQtVVQJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+4VgcJW=9rtuqr3VZbfA8QxgYAR+KvfAHdf_0xv4XLQtVVQJw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 11:20:20AM +0800, Yu-Hsian Yang wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> 於 2024年12月3日 週二 下午9:50寫道：
> > On Tue, Dec 03, 2024 at 05:15:40PM +0800, Eason Yang wrote:

...

> > Second, why do you need two regmaps? How debugfs is supposed to work on the
> > registers that are 16-bit if you access them via 8-bit regmap and vice versa?
> >
> > Can't you simply use bulk reads/writes when it makes sense and drop 16-bit
> > regmap completely?
> 
> Read VIN info can use word read or byte read, and other registers
> should use byte read.
> 
> For a reviewer's comment, If the i2c controller allows word read then the
> right thing is to always use it.

But how does this differ to bulk read of two sequential 8-bit offsets?
And if there is a difference, shouldn't this be addressed on regmap level for
all? Like testing for the supported flags and access registers based on the
controller capability and user request.

-- 
With Best Regards,
Andy Shevchenko



