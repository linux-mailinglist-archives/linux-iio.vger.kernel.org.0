Return-Path: <linux-iio+bounces-19458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C07AB34EE
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 12:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637897A7CFA
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E604265CA5;
	Mon, 12 May 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeJ0af0/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC922500CF;
	Mon, 12 May 2025 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045932; cv=none; b=YZilpYC0mu9Loj2+S/wdNM5sV2UTFkutCsrpMmgQFOjeM04LPoUu7sCZYCMw6S5j6AMMTHFcjUtBvf6iqWtOCXzdDbBwpjZoEa7pdvddFNeOq4ESElbR8i/cphWczDmfreG93tDX+h5A3sOFoWg3y5yMfrNnp6d9krQhaLxKsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045932; c=relaxed/simple;
	bh=LNx6d+LGN0UuAE1Kev9HiY5qljRgbBixlBjM7cy0ht4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+0vkwfoa9BfBOz76JhyD1SCU+q72Ss5C2HyK20BqfeJk7+iUv7a/LQ1wvcY2WnHgKdzXhCUJzlYaRfFMZKZ6v56G/4k9swjBc5gEZF1s6/muhiTDWI4kPrK2bLw9IHwNo3ANgTFZWrcvHLmWvFrJKjxhTm9w5idn7TmZ06a7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeJ0af0/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747045931; x=1778581931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LNx6d+LGN0UuAE1Kev9HiY5qljRgbBixlBjM7cy0ht4=;
  b=PeJ0af0/Pxq1vXe/yO/buDoD60wqeDV6ygTuqnofUSnA69enGLFM885J
   qZVDFvCxW0SurCPUC8qEQZ0iJDPM5HB1eC/aXuKBwdQitukTdzxzxnK9i
   St8S2H8I7qsdHYOzmOlCbalUVMl2nvZTJz3iY6bMfc/eh7drVbsKOV05O
   LWZm+1nxLu3KKgEamLI2xnZ6bDpFLYjc3+ymhX/dEYIzVpbbnzGm7k3+P
   lzCDKpTT4CLyCEaZQ6TipfesuDf4XjJiGqV+uNq6D9GmhBhyb2JwTRmsG
   51Dz4CUzhrb3h66kIjKNull7clkzbIZdumiPX+/9vGvvmEl5pAmX5dBUq
   w==;
X-CSE-ConnectionGUID: 7pQ8W5rsS+uyPz4g/qdM/A==
X-CSE-MsgGUID: r+oddfWmSSCrJG5nP7+TKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48832450"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48832450"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 03:32:10 -0700
X-CSE-ConnectionGUID: /G0itieJSEKZW5XGggzgTA==
X-CSE-MsgGUID: y/nPGEjAS+ypF8F9DpOSLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="174474865"
Received: from snowacki-mobl1.ger.corp.intel.com (HELO [10.245.253.141]) ([10.245.253.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 03:32:04 -0700
Message-ID: <60cf19a2-4f55-4330-991d-5ec76ab5a5f3@linux.intel.com>
Date: Mon, 12 May 2025 12:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] accel/ivpu: Use effective buffer size for zero
 terminator
To: Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 Markus Burri <markus.burri@bbv.ch>
References: <20250508130612.82270-1-markus.burri@mt.com>
 <20250508130612.82270-3-markus.burri@mt.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250508130612.82270-3-markus.burri@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

On 5/8/2025 3:06 PM, Markus Burri wrote:
> Use the effective written size instead of original size as index for zero
> termination. If the input from user-space is to larger and the input is
> truncated, the original size is out-of-bound.
> Since there is an upfront size check here, the change is for consistency.
> 
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---
>  drivers/accel/ivpu/ivpu_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
> index f0dad0c9ce33..cd24ccd20ba6 100644
> --- a/drivers/accel/ivpu/ivpu_debugfs.c
> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
> @@ -455,7 +455,7 @@ priority_bands_fops_write(struct file *file, const char __user *user_buf, size_t
>  	if (ret < 0)
>  		return ret;
>  
> -	buf[size] = '\0';
> +	buf[ret] = '\0';
>  	ret = sscanf(buf, "%u %u %u %u", &band, &grace_period, &process_grace_period,
>  		     &process_quantum);
>  	if (ret != 4)


