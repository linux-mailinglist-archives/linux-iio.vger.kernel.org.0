Return-Path: <linux-iio+bounces-11620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2A9B6682
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 15:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79EA1C20A40
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17681F4FD1;
	Wed, 30 Oct 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTGx8hof"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888E1953BA
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299819; cv=none; b=glqEGz7s5ULa5xHClJUEBt139VnOTK6SwUcNnqKobarwZ843/s9ev2MyRgkVFnYQGIsPhohJmRcf2cGVbeyeknEr0UyEdz13zIfu7Sa3jmkl4aeVuJ8qc4en93vr8yFpac+5xVeLeYgtBCrfmtaDBuv1mvJrF+wMvW1q9W3acvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299819; c=relaxed/simple;
	bh=vGZPOscC/WLpKO/GvQL7X9mk9cc3Qn1JwV0+R4bbwJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps1L2P3TJPo96xWDYtXlkFUAUSLzGOv7xATf+mOfwSGZkUKzx3xIOGN4AvyxDRLPecEQl/gxz0j5nBNCupNvzhziRd5c39Vmo9mSbwGN0q5uVEPuLAw1sQPyEFN0DNzISZOyggaeF+AxXwu+1yjRBsDKV1dxrcit1vOjFG4RoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTGx8hof; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730299818; x=1761835818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vGZPOscC/WLpKO/GvQL7X9mk9cc3Qn1JwV0+R4bbwJk=;
  b=lTGx8hof8W32sDS4kdQ3P0yjl4Hbtpjr4HIMz0qqQr+CyN3Qogv2vC+X
   q3LPEoPk2YvD3Bfc0jrIsQyGFTYxszAcUTLwJCAO34oV3PNo67PJf91vD
   t8VM0Jp8K61J8r+ye3CUKNPFby2lA6S8rhv4ubcnjAGE9FWLQlvKvcvp5
   zuqjzE3vFrYQE/NHkXBfQHLIHKauYgcLMMyhQTWB4e6OsdhcGcuSk6huA
   LvLJyZpwvvsQQpuTcQa/ISgVgq9ORBG/Vn8aPZXnGt7pyWBgSktv9AFS4
   iJoE8sBx5uUQ+U0bLs2O3j16GkOzF2ZNbFDEo7ZFQOrNjJQFK6KUhlzZO
   g==;
X-CSE-ConnectionGUID: 1ZzPZqw0QKmLe+QNLJBxjA==
X-CSE-MsgGUID: KURfZfN+Rva+Cbs3oamSHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30108905"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="30108905"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:50:17 -0700
X-CSE-ConnectionGUID: +pX4kLagQgKtGvOnO77wHQ==
X-CSE-MsgGUID: BsQQVWvlRhSul6HtUnLKzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86890137"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:50:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6A1W-000000094QU-0ONH;
	Wed, 30 Oct 2024 16:50:14 +0200
Date: Wed, 30 Oct 2024 16:50:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: light: isl29018: Replace a variant of
 iio_get_acpi_device_name_and_data()
Message-ID: <ZyJHpaWms8Fe2x94@smile.fi.intel.com>
References: <54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 30, 2024 at 12:53:57PM +0300, Dan Carpenter wrote:
> Hello Andy Shevchenko,
> 
> Commit 14686836fb69 ("iio: light: isl29018: Replace a variant of
> iio_get_acpi_device_name_and_data()") from Oct 24, 2024 (linux-next),
> leads to the following Smatch static checker warning:
> 
>     drivers/iio/light/isl29018.c:724 isl29018_probe() error: uninitialized symbol 'ddata'.
>     drivers/iio/light/ltr501.c:1514 ltr501_probe() error: uninitialized symbol 'ddata'.
> 
> drivers/iio/light/isl29018.c
>     701 static int isl29018_probe(struct i2c_client *client)
>     702 {
>     703         const struct i2c_device_id *id = i2c_client_get_device_id(client);
>     704         struct isl29018_chip *chip;
>     705         struct iio_dev *indio_dev;
>     706         const void *ddata;
>     707         const char *name;
>     708         int dev_id;
>     709         int err;
>     710 
>     711         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>     712         if (!indio_dev)
>     713                 return -ENOMEM;
>     714 
>     715         chip = iio_priv(indio_dev);
>     716 
>     717         i2c_set_clientdata(client, indio_dev);
>     718 
>     719         if (id) {
>     720                 name = id->name;
>     721                 dev_id = id->driver_data;
>     722         } else {
>     723                 name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
> --> 724                 dev_id = (intptr_t)ddata;
> 
> How do we know that iio_get_acpi_device_name_and_data() will succeed?

Ideally we need to file &ddata with NULL in such case, but it will be
equal to 0, so it only works with the chip_info in place.

Let me look into this once more, thanks for the good catch!

>     725         }
>     726 
>     727         mutex_init(&chip->lock);
>     728 
>     729         chip->type = dev_id;

-- 
With Best Regards,
Andy Shevchenko



