Return-Path: <linux-iio+bounces-28076-lists+linux-iio=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-iio@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGsYLTjOb2mgMQAAu9opvQ
	(envelope-from <linux-iio+bounces-28076-lists+linux-iio=lfdr.de@vger.kernel.org>)
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 19:49:28 +0100
X-Original-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7957149C89
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 19:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 159D0826D9F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D08315775;
	Tue, 20 Jan 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQasfe+F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898F30148D;
	Tue, 20 Jan 2026 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925675; cv=none; b=AcG4PMmtfoNacUo/KtWuNecZJMw4AY2FZ/+FCGKoLf0vqPthEcAHnjDrnjqjB+X7xq1AIIID4WRyQqTaRS4dlPlnmS3JpdNR/f3gKkk6PuOmqu1Cw0xspduVILQHMGFxTV4FTRoeyxrrmRTWR6hbsV0hVCyqzYdyCA3oizjvNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925675; c=relaxed/simple;
	bh=JNT2f2dE4pnR/9SONUjEhBzxkqljmW567+W7v2XsEN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu3xvoh2ilgpA0BB60NnFQ0PKJi4qMMVIHFkvgUEIygHt7q7qz0csNR/cCQvLCoNFRs46yq13vWTGS6BGYz40lkNcljH3/4R9ioQvZJRvQXq8QxDt+Sc7z8s0nrIS1WbkTgJU68gAtX3fh6jLec+4YwmmW3GVqpwsUL6zhxjX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQasfe+F; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768925672; x=1800461672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JNT2f2dE4pnR/9SONUjEhBzxkqljmW567+W7v2XsEN4=;
  b=ZQasfe+FW+oSccePNaOY03Dt6dheBSm/316OlLFJ6xvh3xT7o5DmPo2N
   1s+3BtDE/cjBvXydxDBX+9vklIPyDdk/3Yskb08TYoGCyhzU8b3vlie+z
   Dq2TDEYcuk3mSXbwj1DIxv5ps/g9/K8/yDPZpofCYzQOgaIwKW574sSKW
   GYGnYRXSuoSSUXxjp0HaYjPXmjQG6/6VDLH25rauNgY0jzCw8cuN6/P4k
   xtcrZGUU6ZmYN4bDFftANcyOVF4Q6O+CbtVeV8s84WrED0MogItdFJUwu
   pr03VPUIcv69aPVWELJfRQ3ZI560sD6GvHlrf9H12xU04ajJ3nMUqzXBh
   g==;
X-CSE-ConnectionGUID: NsGOx5n+S4ejJIMYniorxg==
X-CSE-MsgGUID: 5TpTkGqLR1KoC/pm68C9RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81247407"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81247407"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 08:14:30 -0800
X-CSE-ConnectionGUID: qB7CyKsHTZiltU4XdbCcig==
X-CSE-MsgGUID: /Pem3BNWTRiWUY3VYKbvOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206509077"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 08:14:27 -0800
Date: Tue, 20 Jan 2026 18:14:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <aW-p4F4lG-zhPJ7H@smile.fi.intel.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
 <20260115-rfd77402_v5-v5-3-594eb57683e4@gmail.com>
 <aWioYpYPAPOGmnHD@smile.fi.intel.com>
 <CAHc1_P6Cv3fAKjSnPKgagi8t1R1RHsavSHGns3veXNynoTghLw@mail.gmail.com>
 <aW5_I7KuiVGg0v_O@smile.fi.intel.com>
 <CAHc1_P5fnWYw4i2kBdAg1MtChD673g3j_mL+=Mg70ptLpeaCjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc1_P5fnWYw4i2kBdAg1MtChD673g3j_mL+=Mg70ptLpeaCjw@mail.gmail.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,linuxfoundation.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-28076-lists,linux-iio=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-iio@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-iio];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 7957149C89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:29:50PM +0530, Shrikant wrote:

...

> > > > > +     i2c_set_clientdata(client, indio_dev);
> > > >
> > > > Is it used?
> > > Yes, it is used in rfd77402_init().
> >
> > Can it be passed directly?
> >
> > In other words, can we refactor code to get rid of the i2c_set_clientdata() and
> > respective getter calls?
> Yes, I can pass struct rfd77402_data *data as an argument to rfd77402_init() and
> then I can avoid the i2c_set_clientdata() and respective getter calls.
> But for that I
> also need to update the rfd77402_resume() as below:
> 
> static int rfd77402_resume(struct device *dev)
> {
>     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>     struct rfd77402_data *data = iio_priv(indio_dev);
> 
>     return rfd77402_init(data);
> }

Ah, this makes a lot of sense now. But leave this call only for the PM
callbacks. In other words, please change the parameter of rfd77402_init().

-- 
With Best Regards,
Andy Shevchenko



