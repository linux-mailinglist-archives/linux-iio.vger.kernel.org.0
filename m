Return-Path: <linux-iio+bounces-8257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9C9483C9
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 22:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FC42848CB
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 20:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8C16BE32;
	Mon,  5 Aug 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZhzTRRY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344514AD30;
	Mon,  5 Aug 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891539; cv=none; b=dgYzxSBX5FuzieSlY2NtIT0yx0IYZbQUuzV+IezXXPsZa/Yvn6Uc5CnLX1zQq8orsb3GE7QixmV9O8303nQj7CwVjhiBOsutyZLsWkffMyI9h8RKRIiOkIA9gz7yWGqPo0fdcHZ0CNep2bAegZ5UC+jhrn6fiMKC/HsPwtRKASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891539; c=relaxed/simple;
	bh=gjFRACIVY4CZs0fF0gBdmou29vCbYimp5bxsEMOmmUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElRSATfyFYgxeySDj2zghhIhg80/D9w1ajKFqjV5VXREy6qvgUpeAaezF7Jlw7qjfOrFomVA5jZT+G1mCL848BKomtOHTDbLIODwa9OmVNu14A7P3e6cLQhh041RA1kfMicOaVA0k8INX40JuwwJ7RcCtYUhmXocsqps0claLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZhzTRRY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722891538; x=1754427538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gjFRACIVY4CZs0fF0gBdmou29vCbYimp5bxsEMOmmUU=;
  b=OZhzTRRYm8UK5KY/c9S+qE+wM3/jLnYIZNWhIFYX2BfClPxiByo1bHkH
   ZofFGrYwNAUOiOHh55qc/Clzdpc8vLTrCMrw74lzxdPYKRuilrdJr0PTF
   rLYnvEFvgvYw284SLWTfBVyfEmOnCc2R6Y6aGHp8N1mGKuVTxxL1VOqSm
   cwW9u+zlWiUTo+FQY9d18SQpBqeUEUIQky33dA/Lfk0gLMJoLj7JLk/lh
   8h8pE50I8bnThEMfn2gpE/UATGw5d+kogfNuRP/Fds67lvZm6kgbxB7Al
   ssizdAqlP+QYoo65DjiRyq6PTviycOldEEgPsHZ5zVeGvVO9ramZNuowG
   Q==;
X-CSE-ConnectionGUID: mOpC6PxBTs+a2JLCqOLcbA==
X-CSE-MsgGUID: Ql88UsKqTVu3JALm7pVJDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20458765"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20458765"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:58:57 -0700
X-CSE-ConnectionGUID: Hj3XyW2lRdOhBw/BJAV74Q==
X-CSE-MsgGUID: Zt7l1uQRQwi5QRrZTwNguA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="56198727"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:58:51 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9C17411F965;
	Mon,  5 Aug 2024 23:58:48 +0300 (EEST)
Date: Mon, 5 Aug 2024 20:58:48 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Michal Simek <michal.simek@amd.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 4/4] leds: as3645a: use device_* to iterate over device
 child nodes
Message-ID: <ZrE9CF_WlJsS_Ome@kekkonen.localdomain>
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
 <20240801-device_child_node_access-v1-4-ddfa21bef6f2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-device_child_node_access-v1-4-ddfa21bef6f2@gmail.com>

On Thu, Aug 01, 2024 at 08:13:53AM +0200, Javier Carrasco wrote:
> Drop the manual access to the fwnode of the device to iterate over its
> child nodes. `device_for_each_child_node` macro provides direct access
> to the child nodes, and given that the `child` variable is only required
> within the loop, the scoped variant of the macro can be used.
> 
> Use the `device_for_each_child_node_scoped` macro to iterate over the
> direct child nodes of the device.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

