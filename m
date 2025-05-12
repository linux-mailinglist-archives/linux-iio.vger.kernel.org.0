Return-Path: <linux-iio+bounces-19460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C188AB383D
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 15:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AFF17C105
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD7293757;
	Mon, 12 May 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1mrVFg/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F912D7BF;
	Mon, 12 May 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055760; cv=none; b=om+rEeQiVtrKYMQrFeWojgpXuuzsM2uW6/RJ+vGwywK7c8SL4d8ODmhOhxQ2kRissp3gKu44swhjI2Vfa/VvMbK1VfK0Hrh1w1QpUcSODoR2d3Yo5Y1cP+far4JzojYTgLY9uAJC5hVA49jI1xwGPcNV9bzD62A3R8SQ4cAe/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055760; c=relaxed/simple;
	bh=N+0LFGTtI6zB+BSNgrVSHcilV81hSz+0mu8K+VGrGKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYUbykmvOU7Rf26M0YbDp+5X/ka8INczsGnO1/nirQoTGjHXLlEWLnanAPJHCnBhUO5H4qL3ZJVwJf3zxjKrYfGlRwKpX8vl1Klz0oSr2jTQE0JSC32NXHojvTWRB+NXd99ZZnxSqtYljYHRuWFwwornkI+vRYzc2dnvXKtAspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1mrVFg/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747055758; x=1778591758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N+0LFGTtI6zB+BSNgrVSHcilV81hSz+0mu8K+VGrGKw=;
  b=a1mrVFg/9jyxt7ZswjRlBcFkjn+Fo86bTDkGxLCPcmk6E+8Iqv2N+W+x
   0uBxa8YRGJpiQQey4VS8T1poFw5memjjC1RI5lMKBbR679hK1SFIu7Yzy
   rcIEil5FK0JFn6rIE5NHPx46ULkINvUs6s3eyOme6SKyUykUwQPNzM0lM
   WeK5mVzhkcIxXs0A9KYKkQlzBbpEUGCZ8dKYpEl5Bh1qeRLfiINUfaNyK
   e/outxpQZoWdzssUpWX53uqCwQp2t5gr5hGvPfPYilHAb58R7v4Hymu79
   eJrv862jWj92IxclJoFXwNIOkkEJr5+kbyqJy1KkPtMvd7ylrg5AYg5HO
   Q==;
X-CSE-ConnectionGUID: 82/VeHVETf2UzY6bNe3bjw==
X-CSE-MsgGUID: xNexGs2hRJKMK3vo4dU39w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="74243965"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="74243965"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 06:15:57 -0700
X-CSE-ConnectionGUID: mF0Tr4TVTgSXs/DMLsD7rQ==
X-CSE-MsgGUID: /tqYRHGYSri+FGM+Rb+4MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="138329163"
Received: from tronach-mobl.ger.corp.intel.com (HELO [10.245.84.129]) ([10.245.84.129])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 06:15:51 -0700
Message-ID: <c26c38da-401e-4044-8b9e-cd5547e61677@linux.intel.com>
Date: Mon, 12 May 2025 15:15:49 +0200
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

Thanks for the fix, applied to drm-misc-fixes

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


