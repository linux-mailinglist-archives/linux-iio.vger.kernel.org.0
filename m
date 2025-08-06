Return-Path: <linux-iio+bounces-22357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4844BB1CD58
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 22:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D587518C63DE
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2021B9F1;
	Wed,  6 Aug 2025 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvos31dC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90921638D;
	Wed,  6 Aug 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511344; cv=none; b=rbNys6pKAHo9cwQzhOIq2S5lJwlFioMMJ3ut/u5Q8/Ok7tlK2nK8iGKoQ/N79UtUzfIcSv8dai9CkLdxpa6Djo/YXA+4gb5ZxqbphtbRjAxEokNo4TW7hXjyoqrOTuHYqAZ5TcqDk1BIy1tAhKZwi0pFFEEPRc/sFUcFU0f2BSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511344; c=relaxed/simple;
	bh=Wbb4RuzKsB71SRRRPfXztsTswMx+TnNch/4d5So0fG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZY0FnLpw/PXE5boMR0I7mj3/pNmOq6k6+PudwIe5O54EXMoDOn0mV7lca53WunUML0KkypVHKEJnAbJQIWOQ054DBMHPu7BscBdH8EkwcAX24PFrqE6AhPrx4n1u5nygbkL709yClWAWAvYxXSNlalGyQn3BACHbJkXZo6Et0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvos31dC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754511343; x=1786047343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wbb4RuzKsB71SRRRPfXztsTswMx+TnNch/4d5So0fG8=;
  b=mvos31dCcxh2pNvBD5MQeO60FGAq8nmlawbVyzMdWjIndtVqlqp3Jz08
   Wh6FdVnZkzF2kKbz6nuyQfyw6Gu+9Dw7CjjYsqicW257n7UIEJovf/3kG
   fS9s/KdLPERMgcCSOWZHI6zJ3MRGxDh96Y/FAN8O7Pjn8o9v/61PzgDIO
   ZPuM5OD0mRXatFgIYQX/NhvgSgIThKgctnBwCEFnO9kzMjW68SC5Ov9OV
   yNhg8ggdHe62wAbAxmJK+RDVzzmpMhTBJE6EA3b33SreNOnHJ/HLPTkHJ
   7n1auvYjq+op/F9CusP2VRf/zxnxTnn+8NYOhavGu6yJZWGsYAyQ5L4Ut
   g==;
X-CSE-ConnectionGUID: n4tp2t/NSki1ibS+JkvInA==
X-CSE-MsgGUID: iAell7WYQAaPHEiWlO6Yvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56706442"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56706442"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:15:43 -0700
X-CSE-ConnectionGUID: hVfycj8hTjyQuoFiJhJzkw==
X-CSE-MsgGUID: aVY7zgKVTd6NO4XXSp/4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164878779"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:15:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujkXx-000000046et-2Eh4;
	Wed, 06 Aug 2025 23:15:37 +0300
Date: Wed, 6 Aug 2025 23:15:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad799x: add reference voltage capability
 to chip_info
Message-ID: <aJO36Ul5ozQaJUkH@smile.fi.intel.com>
References: <20250806090158.117628-1-stefano.manni@gmail.com>
 <20250806090158.117628-2-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806090158.117628-2-stefano.manni@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 11:01:57AM +0200, Stefano Manni wrote:
> If the chip supports an external reference voltage
> on REFIN pin then the "vref-supply" regulator may be used.
> 
> This commit partially refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> to add the capability of the chip to have an external
> voltage reference and then remove the ugly conditional check
> on chip id.

Suggested-by?

...

> +	if (chip_info->has_vref) {
> +		st->vref = devm_regulator_get_optional(&client->dev, "vref");

> +

Redundant blank line.

> +		if (IS_ERR(st->vref)) {
> +			if (PTR_ERR(st->vref) == -ENODEV) {
> +				st->vref = NULL;
> +				dev_info(&client->dev, "Using VCC reference voltage\n");
> +			} else {
> +				ret = PTR_ERR(st->vref);
> +				goto error_disable_reg;
> +			}
>  		}

Can be written as

		ret = PTR_ERR_OR_ZERO(st->vref);
		if (ret) {
			if (ret != -ENODEV)
				goto error_disable_reg;
			st->vref = NULL;
			dev_info(&client->dev, "Using VCC reference voltage\n");
		}

> -	}


-- 
With Best Regards,
Andy Shevchenko



