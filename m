Return-Path: <linux-iio+bounces-25454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21670C0CA0B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 10:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 473A54F1D33
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334CD2ED164;
	Mon, 27 Oct 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USdvLj2b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372812E8DF3;
	Mon, 27 Oct 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556827; cv=none; b=nPgRNHPjkHfAKhO3zPTw0fsLnDik7mIWBysXo/siN/No2j20eK+kEsERgFT2KqR8OYrxoRE7sLgGTORUWmukld2QjqZpgBf58p087OeZ2jKSpnfk1QW8y4MKLMdfw6ME+KJk8cNhOfCDZZ16p8XXC5GQbbXNgxSKnByUpQGw7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556827; c=relaxed/simple;
	bh=gu5MxH5sG3fDzaQ9kU6hnz6FMzhah4jViGZGU19k1a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDQFFuIjJ1g7kI0qUP//H+Doo7QGkdHle3fRbPuWS69PaZrQ9i9En08T51XWY6GYri1unVM20PnSnKmQ5kX6VKywzVZeCqgFn/jXbJGvY9LoPT0rDjTSRouTi/edm8J5RpSFbapipo/5BGKoksgBe468vjRN2sAYpPpaYZOswcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USdvLj2b; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761556826; x=1793092826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gu5MxH5sG3fDzaQ9kU6hnz6FMzhah4jViGZGU19k1a4=;
  b=USdvLj2bBCyfTC6mRRgDTY9wAa9Nh6U5Kx3Lw90/bVVQej5QmaJNlxwW
   6uR1GDKOMkJ+svSTSc4Vvxykzs/NpP5A0c4PckzIr9HVd/15Oala5e0RV
   c13KH0VMTlViNRZBOsSvNDOafK39rtnT4laL6MAF+m+rTDVfzIektAKwZ
   a74GNbi9wpb8DvmPVIx3udykV/e+Cf5c0KqaoWfB7UJijEREbvGwWOORY
   D/W5SX316kc0cG6JN5LEE9BlszJnhR6kxIRSVLfhhmHJPSVrq5YtIusyU
   qup0VqsLRJGEuTJM9SMPY4tB+EJQ6VlXJDBVzwATf0Co1b6/mgcKOEljq
   Q==;
X-CSE-ConnectionGUID: VENHXK9LStupCtvp62QjkA==
X-CSE-MsgGUID: k52jQMNfT2+bEh6mCutJ8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63669177"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63669177"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:20:26 -0700
X-CSE-ConnectionGUID: JJR21utGSf+SkQNhDEUtLw==
X-CSE-MsgGUID: PWxOW3svRki5zuAOe197Dw==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:20:22 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDJOl-00000002xjF-1m0G;
	Mon, 27 Oct 2025 11:20:19 +0200
Date: Mon, 27 Oct 2025 11:20:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v4 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <aP85UwWqkuE_rQKn@smile.fi.intel.com>
References: <cover.1761372227.git.akhilesh@ee.iitb.ac.in>
 <cb51289f0f1c38a7ea24ee5ba3566c787f203ce7.1761372227.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb51289f0f1c38a7ea24ee5ba3566c787f203ce7.1761372227.git.akhilesh@ee.iitb.ac.in>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 25, 2025 at 11:50:55AM +0530, Akhilesh Patil wrote:
> Add driver for Aosong adp810 differential pressure and temperature sensor.
> This sensor provides an I2C interface for reading data.
> Calculate CRC of the data received using standard crc8 library to verify
> data integrity.
> 
> Tested on TI am62x sk board with sensor connected at i2c-2.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



