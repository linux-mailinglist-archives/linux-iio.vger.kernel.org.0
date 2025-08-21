Return-Path: <linux-iio+bounces-23099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC83B2F6BA
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 13:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63108681477
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E61318133;
	Thu, 21 Aug 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cgxl8QDr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43664310635;
	Thu, 21 Aug 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775549; cv=none; b=As1MZgp4gZXambophf4oX4LdP2Q0KYjBuKiVLg2Czxmj0S2tZhgiyAlnTA1lOp0EbX+Mu25unGoH6vVLsbahZdl/jUtri+fUax5YRDkIo0y6z6Si8DVsGmwsdqqMD19DXa6ZDdIwkCBLeYegXp/YAXIq4GoyPIxkcQXXlUFRfXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775549; c=relaxed/simple;
	bh=4pORI6xjNhwbpoM/w8dJqel+hqomC9hCoOagNkF9XcM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6odGuGXQH6K5bHWHLkgFruColxsTzry0p/RT83IfxdL8Z3ZSCEKjguoP224iZEUcRwA47SguZhkDZMOQj5/1kTbO9tUin7n/OUxM+dnd/0GdhH3IyD4qls31MJmyJYPYeeRs2KZfmsfAbw0/ZgWgg89cppUGfu0PmD22Oq7DRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cgxl8QDr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755775548; x=1787311548;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=4pORI6xjNhwbpoM/w8dJqel+hqomC9hCoOagNkF9XcM=;
  b=Cgxl8QDrvzaG4qwsoXqn0xrwyjXq1g5u2mtF4NCV2lLVCJw/dAjSNykF
   AhQsIL7jhrwbLBGy67Shiz+L/migY/Zjb4AsKTOFbfTeCyzJI20gfava3
   uoM+K9pxS+8Nc3Fr7Yv29Rxqvy/ZQbAOIa1TxXfIrzSY+7jhmfAwzEWdn
   12is/83u6C/36fG12QzF2qo/2/5TOybXGFGBm8fsFsxG2Q1KneVkU8Tiw
   XqkFmQXDuUBsamm/Xx1yV+a8lD/eHKWAnSXOP6+oub1QP1uwj1WVio363
   KRWE7zPidhNTZKaew18hfqXQWAp6xEXgyjgUKQU+a+Mqp+F0wQiFvTn1S
   Q==;
X-CSE-ConnectionGUID: EliDzzLwSjmG8LIEI3Lxuw==
X-CSE-MsgGUID: NzrfSAtJRWyJNG7j4FpSyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61873714"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61873714"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:25:47 -0700
X-CSE-ConnectionGUID: eJsmLuwyQcyZCgw0GIoNYA==
X-CSE-MsgGUID: IrxfszFXTLCN4KXnq1e6gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173668311"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:25:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1up3QN-00000007DSf-18oZ;
	Thu, 21 Aug 2025 14:25:43 +0300
Date: Thu, 21 Aug 2025 14:25:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <aKcCN_W1A4SIE9VE@smile.fi.intel.com>
References: <20250818035053.32626-1-bcollins@watter.com>
 <20250818035053.32626-4-bcollins@watter.com>
 <aKbn39Ek1pOVO7rb@smile.fi.intel.com>
 <2025082107-spiritual-centipede-ae66d0@boujee-and-buff>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082107-spiritual-centipede-ae66d0@boujee-and-buff>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 21, 2025 at 07:14:21AM -0400, Ben Collins wrote:
> On Thu, Aug 21, 2025 at 12:33:19PM -0500, Andy Shevchenko wrote:
> > On Sun, Aug 17, 2025 at 11:50:51PM -0400, Ben Collins wrote:

...

> > Since it seems the comments were ignored, I stopped here. Please, find previous
> > emails, take your time and fine grain the result for the next version.
> 
> You're looking at v4. The latest is v7.

Nice, please make sure you are not so quick with new versions.
Can you Cc me for v8? Or at least give a pointer to v7?

-- 
With Best Regards,
Andy Shevchenko



