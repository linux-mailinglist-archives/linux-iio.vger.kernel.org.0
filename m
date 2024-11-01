Return-Path: <linux-iio+bounces-11770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4076F9B91A0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05026283BFC
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5019F422;
	Fri,  1 Nov 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpBLwyjQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54F19F42C;
	Fri,  1 Nov 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466773; cv=none; b=gJ3euLP0flV2TdvGQfaHqRm+0KbPq6QG4lhAzretF0TzWu4Zqh/NjBbGdMCWI/0JYqQDxxAixLYw7q92It/XkqYMQnJTQjbx3fW8OTCdLvItqZPE39E0aRTsLJ5sW0KRrG76YOVa/vBf9+0VqLl/Vh3rtAnA4q/rq2VKFEmo/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466773; c=relaxed/simple;
	bh=8St1NBkIbA60waTMCFM+q8fN8QOD9BHxWzTgED/aY6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RncDL6UaNujmGthWd0QGCbH59I+19Ft8LaREvSI2Xjyrn7dMARjAA4fndENmBCEVpvMwHfCL0Qw3BkyMtj4OQIW9CxEeBAdTmjXZzZetmAssxAc6objxxV2UIjfymCjRAayTOVDU/u9jNf7/biI95ivIWDKN4g5PXBONux6dSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpBLwyjQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730466773; x=1762002773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8St1NBkIbA60waTMCFM+q8fN8QOD9BHxWzTgED/aY6Q=;
  b=YpBLwyjQUvGZoAu0B1snZ5a5MvRISmt5eSd78G6hu5JvZz8d4ugOMS8u
   X87/z8ihhEZJJ11h8BaX9ue9easGM9K/++D2/ywWoI759ts0oPdM7vut8
   0VEu0TmvgHg2dWv8ln4b7SUAs/S6hJXZarZR2urbJ2+kpKaQGdx2q7xnk
   3hrW6UbWhEyQ+XfDoW86OARJi8gxAl8WRUGa1aRTRKgI9sH7tA7Cwrspx
   J5nW/L0SiF2V3stg05/m3w1L1AacA/uAus1wdTCkp6BrTtlAnwodKO6R3
   /2WOLYbT4dL0ZX1jaJuKGagfukjXxM1aHTxJRYQ7cwsJ2sqXc29ibe7Fj
   g==;
X-CSE-ConnectionGUID: mkoSMDuvRkiu551/vdWawQ==
X-CSE-MsgGUID: ypFkz85CTOeW4CKVUlmS6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30088206"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30088206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:12:52 -0700
X-CSE-ConnectionGUID: 7VB+dO8WR+C8998TRDEAYA==
X-CSE-MsgGUID: mEOfkwj6QUmrUA+FmRgbow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83099919"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP; 01 Nov 2024 06:12:50 -0700
Message-ID: <524e3174-cfff-495c-ba0f-f02d78c2f0bc@linux.intel.com>
Date: Fri, 1 Nov 2024 15:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: intel-qep: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>,
 William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241028091312.17045-2-pstanner@redhat.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241028091312.17045-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 11:13 AM, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>   drivers/counter/intel-qep.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index af5942e66f7d..ee2bae27b728 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -408,13 +408,9 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   
>   	pci_set_master(pci);
>   
> -	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> -	if (ret)
> -		return ret;
> -
> -	regs = pcim_iomap_table(pci)[0];
> -	if (!regs)
> -		return -ENOMEM;
> +	regs = pcim_iomap_region(pci, 0, pci_name(pci));
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
>   
>   	qep->dev = dev;
>   	qep->regs = regs;

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

