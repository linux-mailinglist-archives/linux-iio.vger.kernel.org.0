Return-Path: <linux-iio+bounces-12940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381129DFED0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 11:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F5D16371A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93B1FC10C;
	Mon,  2 Dec 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcqIsGqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373F1FC0F1;
	Mon,  2 Dec 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135137; cv=none; b=aq/DVmf2tY0CJkYitYbtLG5Y7pLexreDTKCpC/crmmJFpdOFjVEHaqr46/7GMXOKuU+5GJrqAWaI/k3kMZwUwaok41Z0ydd0gOUdaRxBzSio23cmSGnHZNRtV6/OBa5QItBHHDPjl1+q4FqZ/vHDAjGilTmu4NA7XC2jTySpDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135137; c=relaxed/simple;
	bh=sfXpJT1s17rQbX+XpjPOQ5N1pYmn6N1R89Yl9PbRhng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTr2NKPsqZoATa1uwZUkloieY5599MaoiWc31yU+w3f0/PeZnqkGsO6iJXRKjPaiv9hSmqskGqr96u/UpOqWdYemZLgTJY92oigM4F/G/exUix6g+Sqfi66QzOW+rsYwle0EJJ0pf3uRlvTuGBms55Baa2sHNi68NNJEs2uR8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcqIsGqz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733135136; x=1764671136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sfXpJT1s17rQbX+XpjPOQ5N1pYmn6N1R89Yl9PbRhng=;
  b=kcqIsGqznv2OHwDk2fGaMnh1HZdtuwk5M128Ixfeyow777HIs+TMu5Qd
   Pq9gXqosTFSuRy8sdyHlUx8bwDMVgDYyRE/ZL/v2S+FB5RRLkTRTDNEtg
   VRNZfw5nz2OJuUkbglf2cRFjN6RxBMBoJRbqxkA4paiKEm9oCnHJNyZMU
   poHOW92YGua9dGxnme/cWV0aadSXthRMdtC/81TJZgWdepo6YWacXXu7n
   PGeCSS3j27ZYCzce6LesCZlS9Pw4mcWDfwyN4rJ/eEVXk/d1/CjZRWQBJ
   AATcITtLGnjf8LOosITaYWonBzespGrBsRMjRENd21ayUHyrQV6kxMc8k
   w==;
X-CSE-ConnectionGUID: KhZcexIBRCKVPiqfZmQQ0g==
X-CSE-MsgGUID: vroHt+IhT+GP4i1QnMNh8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="44674861"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="44674861"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 02:25:36 -0800
X-CSE-ConnectionGUID: VKo2MdWuQXaW0GvXph8fOQ==
X-CSE-MsgGUID: pHwGe0BwQGeUyl6kL4RAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="92900460"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.72])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 02:25:33 -0800
Date: Mon, 2 Dec 2024 11:25:25 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iio: accel: kx022a: Support ICs with different
 G-ranges
Message-ID: <4waoywlqb63yav6q3rdvqnwbihxccgl6p5y7f72yzdadnlzezz@g4fz63owgguj>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
 <fc667b1495adf4e3f29ecbb336495c1f18b47e61.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc667b1495adf4e3f29ecbb336495c1f18b47e61.1732783834.git.mazziesaccount@gmail.com>

Hi Matti,

Sorry for the late answer. I know that this was already applied so maybe
you can post a really small follow-up patch ?

> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 7060438ad88c..36e9d9de8c13 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -161,6 +161,8 @@ struct kx022a_data;
>  struct kx022a_chip_info {
>  	const char *name;
>  	const struct regmap_config *regmap_config;
> +	const int (*scale_table)[2];
> +	const int scale_table_size;

Could you please add kernel-doc for these two new elements like the others already
have ?

>  	const struct iio_chan_spec *channels;
>  	unsigned int num_channels;
>  	unsigned int fifo_length;
> -- 
> 2.47.0
> 

--
Kind Regards
Mehdi Djait

