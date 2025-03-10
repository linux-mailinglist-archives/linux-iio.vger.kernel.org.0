Return-Path: <linux-iio+bounces-16686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A435A5A1BE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89489173C35
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C489235BF0;
	Mon, 10 Mar 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQkr1HSc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F562356CC;
	Mon, 10 Mar 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630355; cv=none; b=U9KVoHbnaqs9EPoYgLesvIUvX0jnGku4udNBnfx1sOEk6D2JGyS3I7SpIf+AQUnuKmJDDWZ42/q/1c4ZJOn7szrwQqYe0YYwO7E1tavjktGbGELYCMQGTQUHAu1Z8Yhiec6U3HR9BawzyPIGpWnOeN9cUZOk312avIhParh1nRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630355; c=relaxed/simple;
	bh=xutUtI8ncSnysxzMFMlH3TgBkjEFcJ6ylYOCCdQt5sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLQhCfjN1Nq9A/yjDCQzog4oDPGSsNapzc28nTDU5gEzp2cBdBWZX3l/Cu3Q3nYmsazCQaBcoXh1v+G9/YwQzWAUkfVryZPiAKP8G+yqDMBgHy7ePW49/PMwBzBlBmRFX03H2XzKggnKGkbwWU+uQtkf0qaJVsLw6eyjFXlYz50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQkr1HSc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741630354; x=1773166354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xutUtI8ncSnysxzMFMlH3TgBkjEFcJ6ylYOCCdQt5sY=;
  b=FQkr1HScr8iBA6xrY2HK29ZJkkmZ6d9ztleZhLQlrUl6IBwrX5IpZcrV
   opCHADnP3V0nFNg5MYKGDB6oYxCLuVvoBd4gU5HsdwRGwNOqHRfKk5iwR
   Lu+bMDs1x957FWqZxAgxmGV/IuboTgapqxCXTjQc4tHBfy+NidiZOCpp8
   uTQopKT0NOpJH03Kdul/AQobOjZdZFBDpB/mvelICgTq82oQhpJjDNlS1
   FC1clurpE5Y5x3ZRNA2HHM4hHlEzHwFZhsppRogjeW0pNYjtMnRHbgP2v
   2bl1m2Qwt6Gj9Bv42nFupKYaLC0NCfCNImURa4G6puwkaZmY3LS041jZ5
   g==;
X-CSE-ConnectionGUID: GgVKTgTVTAqPCT/Fik9T6Q==
X-CSE-MsgGUID: B98toNZ5TEmsUSr2aGnzyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="45433458"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="45433458"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:12:32 -0700
X-CSE-ConnectionGUID: XTWVcWlLSdaQ6N8oMqzVWQ==
X-CSE-MsgGUID: D3Ts7d9eSaqsvtxwU60bpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120552572"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:12:27 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A1BEB11F7E5;
	Mon, 10 Mar 2025 20:12:24 +0200 (EET)
Date: Mon, 10 Mar 2025 18:12:24 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Subject: Re: [PATCH v6 02/10] property: Add functions to iterate named child
Message-ID: <Z88riPwuTvnAy-cj@kekkonen.localdomain>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
 <ff924f640feeb87819d40557f12a04e607894682.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff924f640feeb87819d40557f12a04e607894682.1741610847.git.mazziesaccount@gmail.com>

Moi,

On Mon, Mar 10, 2025 at 02:55:53PM +0200, Matti Vaittinen wrote:
> Please note, the checkpatch.pl was not happy about the for_each...()
> macros. I tried to make them to follow the existing convention. I am
> open to suggestions how to improve.

checkpatch.pl isn't always handling macros as well as it might. (It's just
hard to parse C using regular expressions and in practice some
simplifications end up being made.)

-- 
Sakari Ailus

