Return-Path: <linux-iio+bounces-26700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B54CA044C
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFF330BE6BA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683103502AA;
	Wed,  3 Dec 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4E+eFUy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FC34FF4E
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779401; cv=none; b=lvxAlwda1w5MfpjiVKkYe4cYwJ+c4AFKTkvBc8+jn6qqj6iZPngWLz+LANJ/es/mNtzjrWEwsWQIx+ENRrl/+glk0NteQ+Qu4AywOFZeoZ/sra7Dyt72hdvN4IrQNMMSQh04+Mk9EQUcDDnZLcZtO/dFGCCHfHmMyTFpL0BUcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779401; c=relaxed/simple;
	bh=jg1DU953IcKgLd66oFBdK2TaQwvz6Q50xoaLLzy++TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTcJULngdpM2vGRLxKumM3q7svRwhGwIcliAAsY7pPRYTkiaxrcdI1pjZHiSn6L1aNPHXkILTBj54q/cECH95hv0AdTnVMKl+5sMrh0hnFderRxP7KDwAXvyc/nU0e7r9Nu1LBX6yHdKxM4dAcz+b6+7RahSzjjYCAPhlcPgYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4E+eFUy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764779400; x=1796315400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jg1DU953IcKgLd66oFBdK2TaQwvz6Q50xoaLLzy++TM=;
  b=a4E+eFUy7qvrlo1lYJU9KZk7CgxNJ66ElswrkR8ndXAAJ1hwZxxs0brC
   pEpgx8fDLeS+SrCvKl4EK6ySwiRHpfCxk6N7fCYav/uMqDMttuWx2/pbp
   QszLBDzfP0jEPozHyFeJQ0YC5ZyfuFW4sZSHjUypZeD4uElY/xOkTG2+H
   wSI3ubQsZL5xd/TfFPPDTD2SGOthKYkCx75t1NZOL7WRO0YgXAmkYPifP
   cPl3uLd9/+eMwgdwXC7qXa/fDmF9udsYp07cB4Odt7efWtqXGLXOo+ADd
   7Y6FyC3Y89qPPiJHHI85XqgX8o96xCS4vZTABZUpyMa3QYJSR+AY7Cq9+
   A==;
X-CSE-ConnectionGUID: +XLGSgeaQkKXFQY+i+7/cg==
X-CSE-MsgGUID: P72tCDsLRk2wiY0+0aHA1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66822743"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="66822743"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:29:59 -0800
X-CSE-ConnectionGUID: EHEA6ZHFQVG5OUd/b4BpQg==
X-CSE-MsgGUID: S9u2tDPWS3KCOZ8iQzJQWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="194771045"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:29:58 -0800
Date: Wed, 3 Dec 2025 18:29:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 4/6] iio: buffer-dma: Fix coding style complains
Message-ID: <aTBlg2rW0rrjHh73@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-4-0e4907ce7322@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-4-0e4907ce7322@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 03:11:39PM +0000, Nuno Sá via B4 Relay wrote:

> Just making sure checkpatch is happy. No functional change intended.

...

> -static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
> -	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
> +static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(struct iio_dma_buffer_queue *queue,
> +							       size_t size,
> +							       bool fileio)

What about 80 rule?

static struct iio_dma_buffer_block *
iio_dma_buffer_alloc_block(struct iio_dma_buffer_queue *queue, size_t size,
			   bool fileio)

(And personally I think that in 2025 we should grow up and forget about this
 and move on to 100, but... not a maintainer here :-)

...

> -static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
> -	struct iio_dma_buffer_queue *queue)
> +static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(struct iio_dma_buffer_queue *queue)

Ditto.

static struct iio_dma_buffer_block *
iio_dma_buffer_dequeue(struct iio_dma_buffer_queue *queue)

...

> -		if (block != queue->fileio.active_block
> -		    && block->state == IIO_BLOCK_STATE_DONE)
> +		if (block != queue->fileio.active_block && block->state == IIO_BLOCK_STATE_DONE)

Ditto.

		if (block != queue->fileio.active_block &&
		    block->state == IIO_BLOCK_STATE_DONE)

>  			data_available += block->size;
>  	}

...

> +	/*
> +	 * mutex to protect accessing, configuring (eg: enqueuing DMA blocks)

A mutex

e.g.:

(this is Latin exempli gratia)

> +	 * and do file IO on struct iio_dma_buffer_queue objects.
> +	 */

...

> +	/* spinlock to protect adding/removing blocks to the queue list */

A spin lock

-- 
With Best Regards,
Andy Shevchenko



