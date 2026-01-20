Return-Path: <linux-iio+bounces-28069-lists+linux-iio=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-iio@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC+IM4Sib2l7DgAAu9opvQ
	(envelope-from <linux-iio+bounces-28069-lists+linux-iio=lfdr.de@vger.kernel.org>)
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 16:43:00 +0100
X-Original-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18B46736
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC5D88868D1
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E374428487;
	Tue, 20 Jan 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cec9WbSE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3121ABBB;
	Tue, 20 Jan 2026 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915998; cv=none; b=D0hJPJ4X22ocPIup3otXBCIDvSo4dpOr3PsPBpn/dWxmHUVN10xcd3eApKPvZ5nzve6lq0wBamDFMuCeM1jXbDAT3GpJ3kwNBuAH9Dy81Eoh0H5ThklTZNAhwJTgeE1jNUbenvefuZ9n7belVYv1Nn4ddmOtaTpk+seavwzuKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915998; c=relaxed/simple;
	bh=GIOzOTlp7owvKo92obQsxJC8PP7pS9cc1nZmcdA5CAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gccyR73PUAeMkxhi3x8pkPH8hZoaQX8HSNzWxwB4Yo5ZT/Z2lS4Q7YVTSPaiMi4bHvRT0dVY02/dCZ0AKoLq9BELOvaYHm5v2G4O308ZCNX87/kgvHQiBjj+dZFygwwqYY59Yh9leIcW8EDNQw54PjGe7+C7VBFvi0j8oHiSDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cec9WbSE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768915997; x=1800451997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GIOzOTlp7owvKo92obQsxJC8PP7pS9cc1nZmcdA5CAc=;
  b=Cec9WbSEKN+SdJfU5ydWrQpxL6DuCghhjn6dOe+hmK+DiATwVYH72KL2
   Ile5VynP+wpar+K0J4NmpunRyOCkg13ksX29auP4iPM4iAA8ZwlcpzLgn
   PiqrDrahKrkoiwreqyMwLAhu3Lh2wNp2BP9YdE4eomp5MYeJdz913snSn
   tBXYkbXZTNzCdIfwPGek5bgVYhxnpI41j2dAlSe2PWx87dP6ywlwVdXiU
   AmfPsnRbOnIr/EIyKwpBHjQzwFPBKbzTJ+oFrtUBtYoOtILuas4hVTxIH
   HAMcf0Fc25zXtwIqHzyHKX75jHqyw4GNix3JrAWnCHEvuhDd9hcwFy5MJ
   g==;
X-CSE-ConnectionGUID: Lhxd8WISSx6CaYG/wRy4gg==
X-CSE-MsgGUID: OuxdIPHtTEqsImcAGT5HxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80755070"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="80755070"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:33:16 -0800
X-CSE-ConnectionGUID: Sd5VE9M4TSSJFWrtc77Uwg==
X-CSE-MsgGUID: tVkFmS2TR32cclsa62e8ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206159934"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:33:12 -0800
Date: Tue, 20 Jan 2026 15:33:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: petr.hodina@protonmail.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: add AMS TCS3400 RGB and RGB-IR color
 sensor driver
Message-ID: <aW-EFdqRQRFDJ-EO@smile.fi.intel.com>
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
 <20260119-tsc3400-v1-2-82a65c5417aa@protonmail.com>
 <6ad1855a-acf9-43e9-a8ab-303f553eae77@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad1855a-acf9-43e9-a8ab-303f553eae77@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,baylibre.com,analog.com,ixit.cz,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-28069-lists,linux-iio=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-iio@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-iio,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,digikey.com:url,protonmail.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 5F18B46736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:03:26PM +0100, Konrad Dybcio wrote:
> On 1/19/26 6:19 PM, Petr Hodina via B4 Relay wrote:

> > Add support for the AMS TCS3400 I2C color light-to-digital converter.
> > The driver supports RGBC and RGB-IR modes, programmable integration
> > time, optional interrupt-driven buffered capture, and regulator-based
> > power control.
> > 
> > Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> > ---
> 
> FYI this is the driver that shipped on Sony phones:
> 
> https://github.com/LineageOS/android_kernel_sony_sdm845/blob/lineage-23.0/drivers/misc/tcs3490.c
> 
> And it seems there's a datasheet available:
> 
> https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/897/TCS3490.pdf

Thanks for finding this! It can be transformed to Datasheet tag
in the commit message.

-- 
With Best Regards,
Andy Shevchenko



