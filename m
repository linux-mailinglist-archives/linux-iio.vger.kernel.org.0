Return-Path: <linux-iio+bounces-5047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547BA8C56B2
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DAFB20B96
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F04144303;
	Tue, 14 May 2024 13:14:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3355C36;
	Tue, 14 May 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692470; cv=none; b=ZNylUndMi9k8NEVgmhnxHSY9mA98cWqar4/Lmt+oNQmjXSNOfxSXieGdZPJ6dX6xJw4q82EgqQQEx3enE6aV8aVgOuaSExxLU2058lvPQXFG+ye4mSaKR01JMnHZKlrOMre/AOllIva5SyLkaMBYZEQX0RvKbrTHeHE7pBDKI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692470; c=relaxed/simple;
	bh=aBFCmY6j4ZdKlpS+bF126DoAG+Z5M38yFjHqoFqhRnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYBsWNq8KR2tW41lqHLnZrLimusLT6UgbugWtf/8DFUb1yCHDZVjoLxtaS699TO3NUKsmyrJFshgbR1x+oSk2FJ/3wL7Imm0aCx5aAKs18WrJhB3VDAsk5do4UM+Sz8oUeqEvprdgU/VxegLWFooo4j4oLwftTl9SaWMeKxRCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: KqK7Dr9RQviC6yGtQfvwuw==
X-CSE-MsgGUID: hAMhlfE+Q6W2b9yP8LcOzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11795001"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11795001"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:14:28 -0700
X-CSE-ConnectionGUID: FjXU9ezWSISVotfcWt+PqQ==
X-CSE-MsgGUID: IQn0NWX2RMqvARMjxO5DeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="31221097"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:14:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s6rz1-00000007RDh-3p9c;
	Tue, 14 May 2024 16:14:19 +0300
Date: Tue, 14 May 2024 16:14:19 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, jic23@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, nuno.sa@analog.com,
	marcelo.schmitt@analog.com, bigunclemax@gmail.com,
	dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
	alisa.roman@analog.com, marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com, liambeguin@gmail.com
Subject: Re: [PATCH v8 0/6] iio: adc: ad7192: Add AD7194 support
Message-ID: <ZkNjq8aaBeP89cNf@smile.fi.intel.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514120222.56488-1-alisa.roman@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 14, 2024 at 03:02:16PM +0300, Alisa-Dariana Roman wrote:
> Dear maintainers,
> 
> Thank you all for the feedback!
> 
> I am submitting the upgraded series of patches for the ad7192 driver.
> 
> Please consider applying in order.

Jonathan, LGTM, I have left a few non-critical comments, they may be fixed
when applying or dropped (most of them), depending on your preference.

-- 
With Best Regards,
Andy Shevchenko



