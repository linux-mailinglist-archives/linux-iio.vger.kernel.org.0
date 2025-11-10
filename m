Return-Path: <linux-iio+bounces-26149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07146C48326
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 18:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DC864F1B9E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425392F6931;
	Mon, 10 Nov 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwEkKaEv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71548285071;
	Mon, 10 Nov 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792896; cv=none; b=Lk3c20nG5NjMvWokt9kfrb/cMn+JFOTLGKleCvYeW+kj+6RteblbGP+FQVpD49haxxuJhMqZzNOkUeK6IZmLsABn0mweamttq9B6jTCLkjGna1NYpbot1rZzSsfSpim7NkwwdZ9a/0dLt9LR4c4XvMzGUNJRH87u2MoQPUX9Is0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792896; c=relaxed/simple;
	bh=+JaRnn6TOFncnY8V8tno8RX9mMo3XnHLQl5ZHhchGwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI2+79UM9j5ioqixZWDV/vPuNhDiKYIM8X0jOY3sJpLzmfYhR3lEu+qTXZUWkIJYhkxXasp4SIbzRJ/Kd79lZDl4aBpc4j0oW3GaAbFWqrzM1a9Wuj4W7h3RfP+WVk9iv8kjgvE9BEDz/W7lGj2bkhANMjoed23X9YZIcyUmT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwEkKaEv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762792895; x=1794328895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+JaRnn6TOFncnY8V8tno8RX9mMo3XnHLQl5ZHhchGwM=;
  b=TwEkKaEv1/cUSGxDDzvdXOlyr7/B8sqpB0o7FlUygLjSr0SJTjgmVHUF
   jlqFrwTy62rzRQOiFd+ofVYPCTPX/Qxu4FU6hjItr++PmYlUx+IGk8P9B
   nellj32u8vZ785UygSZhyWUKP07CFLTffoZFk+gEoaJIZpX0J6ZiF19Op
   BsxKzGvIRJ3IOIAc/iANpQEB9JFK4SNMNsTJhSF60qmnyWyKNUEArZCXF
   aG5EyWkskZTpNhBVS6AIZ61Wtb9YUa/5V3tCpSqIAU8Oqz7g69hIQNTSq
   uJYDCNOHYcde8XhjwZ3HJ+Q6jCoL3sh+H8U6vVjr2NQ2Rca5A4d4pGG1R
   w==;
X-CSE-ConnectionGUID: IVNECE2HQyWga069usm/ug==
X-CSE-MsgGUID: o93Db2ewSzSG29PL51HLFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75532349"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="75532349"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:41:34 -0800
X-CSE-ConnectionGUID: OkxH/shdQ7O3addLoVZBbg==
X-CSE-MsgGUID: HTwgO6D2RVyzJn4eMqNJbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="193096616"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:41:31 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIUxL-00000007W2x-3TGZ;
	Mon, 10 Nov 2025 18:41:27 +0200
Date: Mon, 10 Nov 2025 18:41:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] iio: frequency: adf41513: driver implementation
Message-ID: <aRIVt5zpWmlBVjyh@smile.fi.intel.com>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
 <20251110-adf41513-iio-driver-v1-1-2df8be0fdc6e@analog.com>
 <aRITLaJir-2IoclU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRITLaJir-2IoclU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 06:30:38PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 10, 2025 at 03:44:44PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> In any case, I stopped my review here, you have more than enough to fix.
> Please, come next time with a tag from one whose name is in the MAINTAINERS.
> From now on it will be my requirement as a reviewer of IIO subsystem.

And to be more clear on this requirement (for all submissions from @analog.com
and related): A name from approximately below list I want to see as Rb.

	Antoniu Miclaus <antoniu.miclaus@analog.com>
	Marcelo Schmitt <marcelo.schmitt@analog.com>
	Michael Hennerich <michael.hennerich@analog.com>
        Nuno Sá <nuno.sa@analog.com>

(those people seems experienced and I have heard of / from).

-- 
With Best Regards,
Andy Shevchenko



