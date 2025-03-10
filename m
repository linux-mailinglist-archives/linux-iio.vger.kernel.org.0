Return-Path: <linux-iio+bounces-16655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47AA58E17
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 09:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195FE188E4FE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE7C22370A;
	Mon, 10 Mar 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeCcaNX7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFE2236EE;
	Mon, 10 Mar 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595044; cv=none; b=OKAEigsAajACsPEM7G1aNCKt0zrcWSC0DKks3ckZ4QkXfi0sBVB+Bfu6Kvive1cIQrhi0/UMXrRhR34FtwYBkGVyE9mesGJvU72h0eKuYy/WI4oY1uKHuHhwqGPcS1xi7IXS3rhEE24nfu4m+l6QRaFrr/9ebfMufHG/1qfa6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595044; c=relaxed/simple;
	bh=wDUt90Ru1pIsLbuQaEl1/JJ92mn4IFdSALT9enUC0Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZIKRT3z1zdQ00AsGtLGuvkN7N+ajufz473asw+8/nstr2zEqPGvYCbZzBD9IHhsMqtkQ89BXXaWpnglfuM0mvni/cY6SH32Ae6mTptmLpqPtOnIIMLSYbrWNopFf9y3HRqFxTe7yMJXmdnGntVo3I3kcDMZ6I7TqMPXCqoL0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeCcaNX7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741595042; x=1773131042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wDUt90Ru1pIsLbuQaEl1/JJ92mn4IFdSALT9enUC0Zk=;
  b=NeCcaNX7i9BJWq4O6CV+jxRS4NbMYDJShewxSWeslW+RqWxkaNIciz9/
   1oDxIdzkwBl1QmFlNOCIb6fPphpdR0EjsCCO61LwHFyKKMmD/wKEtLE4t
   tHabTQj6bRWnBfdxn6FK1okU4sYZX8um/Nab0BUivVEb/mc4kl9o3o2MP
   DGL02yQhXsfRiS4pACU90fDPi98S4Tn43a9fAQp5/hyulF5X/nL9tGbf/
   6xXC5P9xjJEIi7wbEY8/uCz3p32qpyLceDGYvTEnQSdNtaczbL4zgvT4n
   07QIRhWzpWkuvd7Pd3AqCN1HJ7oPMyARDPY2oVRIMTXRP2aDVjoIMNsn7
   Q==;
X-CSE-ConnectionGUID: FssS8ukdRlintfeHZuHctA==
X-CSE-MsgGUID: z/qQHn14RzCewYUPudVCww==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42452034"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42452034"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:23:57 -0700
X-CSE-ConnectionGUID: +bOE7dHbRoqsk9GwXYWRSQ==
X-CSE-MsgGUID: uueDdXFiROSxh6W7LvQjPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="125170132"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:23:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trYQO-00000001Bqq-066w;
	Mon, 10 Mar 2025 10:23:48 +0200
Date: Mon, 10 Mar 2025 10:23:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 02/10] property: Add functions to count named child
 nodes
Message-ID: <Z86hk7iXRA5GeOtr@smile.fi.intel.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <5e35f44db2b4ed43f75c4c53fd0576df9ad24ab2.1740993491.git.mazziesaccount@gmail.com>
 <Z8WZh5EzFqxvU5rb@smile.fi.intel.com>
 <39cbe817-fef4-405c-b30c-79b592c0bcfe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39cbe817-fef4-405c-b30c-79b592c0bcfe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 10, 2025 at 08:23:15AM +0200, Matti Vaittinen wrote:
> On 03/03/2025 13:59, Andy Shevchenko wrote:
> > On Mon, Mar 03, 2025 at 01:31:45PM +0200, Matti Vaittinen wrote:

...

> > Also do we care about secondary fwnodes?
> 
> We have the device_get_child_node_count().
> device_get_child_node_count_named() should follow the same logic.

Okay, so we don't care about them right now.

-- 
With Best Regards,
Andy Shevchenko



