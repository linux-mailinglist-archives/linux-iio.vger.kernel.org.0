Return-Path: <linux-iio+bounces-16156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B022BA48A5B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 22:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994D63B601A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26069270ECE;
	Thu, 27 Feb 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="PEcFMusR"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-15.pe-b.jellyfish.systems (out-15.pe-b.jellyfish.systems [198.54.127.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667398BEC;
	Thu, 27 Feb 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691255; cv=none; b=dbwNne4LRs8sgAhbCyY3OClK6F7+ofADF5tBdiphXlqFt1zmsgL4iRGFu7IuHPPAiNLKy2S+XNbCP/y3oO/4m05kXgTgm3r/OmBSpRzDZqZGQ5+D2tbM2pUJLxQJw4V+wVyRSpBA5PZEfr8EcNztkNtq+56W8beLhp/yRzNyyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691255; c=relaxed/simple;
	bh=CHpD4CPGPUIyS+PYE6bP5+7Njrc+9jjZ0GXIxK4trAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd+Nd//naCrHhGEBImI1RU4bf1sYtF+E+rYaTzqGmNrbRebyu1ZUZNi0PZwq/wrTP5krz6bcHw1NOomF/6m3s5DtxxLIen9dwWtAaEeZQRWZb4jxCxMEe0yuS+c9VTqF25cSd0OYU/kJoX/1wwbTASqbw7402lr6SXhrNd32osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=PEcFMusR; arc=none smtp.client-ip=198.54.127.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z3klf69lGzDqT2;
	Thu, 27 Feb 2025 21:20:46 +0000 (UTC)
Received: from MTA-15.privateemail.com (unknown [10.50.14.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z3klf5SD3z3hhVZ;
	Thu, 27 Feb 2025 16:20:46 -0500 (EST)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
	by mta-15.privateemail.com (Postfix) with ESMTP id 4Z3klf43fVz3hhS0;
	Thu, 27 Feb 2025 16:20:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1740691246;
	bh=CHpD4CPGPUIyS+PYE6bP5+7Njrc+9jjZ0GXIxK4trAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEcFMusR7Av/fBAh0iIF2lhfbzHlHQtD3NkN/RlBSlUmYl90jbF9TvPVxFRswj7mA
	 o1g5wawkWUU+Nbeb3b+Y55iM3yJguGuKZUwziHM7Cx3jnBxg4yh9E4fCYMyWRfpCf0
	 hRkhS0j74yLX599z6rDhbUv40926SwowNtLBUJm5cVjxvHPPo+mwRUlMMhOqr22tXC
	 jD90iIUmbzqSBg/8ITp9dbmkEAwLBOTYR+CrAfoAv8C1nuSei/R2MNrrv9Z7sR8EZ1
	 4KN4/Awne+vKQKgtoMoUBPxIObgQVuM7Pjv7sGpTQHnMHH22cRsOetE8ObNoEtUuu0
	 TBTfF4Ekjqrtw==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-15.privateemail.com (Postfix) with ESMTPA;
	Thu, 27 Feb 2025 16:20:31 -0500 (EST)
Date: Thu, 27 Feb 2025 16:20:32 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: filter: admv8818: fix range calculation
Message-ID: <Z8DXIGxA5mJK0oPN@65YTFL3.secure.tethers.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <202502280434.DHtcsf7x-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502280434.DHtcsf7x-lkp@intel.com>
X-Virus-Scanned: ClamAV using ClamSMTP

On Fri, Feb 28, 2025 at 04:23:44AM +0800, kernel test robot wrote:
> Hi Sam,
> 
> kernel test robot noticed the following build errors:
> 
--- snip ---
> >> drivers/iio/filter/admv8818.c:304:34: error: use of undeclared identifier 'lfp_corner_target'; did you mean 'lpf_corner_target'?
>      304 |         ret = __admv8818_lpf_select(st, lfp_corner_target);
>          |                                         ^~~~~~~~~~~~~~~~~
>          |                                         lpf_corner_target
>    drivers/iio/filter/admv8818.c:283:25: note: 'lpf_corner_target' declared here
>      283 |         u64 hpf_corner_target, lpf_corner_target;
>          |                                ^
>    12 warnings and 1 error generated.

Well this is embarassing. I must have have had a fat-finger accident when
inspecting the result of applying the patch to torvalds/master.

I will fix this in v5 once we come to a concensus on the DTS changes.

--- snip ---
>    303	
>  > 304		ret = __admv8818_lpf_select(st, lfp_corner_target);
>    305	exit:
>    306		mutex_unlock(&st->lock);
>    307		return ret;
>    308	}
>    309	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

