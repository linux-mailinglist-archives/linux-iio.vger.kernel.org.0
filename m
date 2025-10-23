Return-Path: <linux-iio+bounces-25362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77DBFFE62
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F73F4FA7BF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7E2EC0BD;
	Thu, 23 Oct 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctLIHAw2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CF2F6196;
	Thu, 23 Oct 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207828; cv=none; b=F9rp45Q/pX95GwxFGnfd/wg02DC2HCZfVYM882qlmnGAV1yngPkX6JBZSL8y3BL2vnv7c8G+BA0WaIH7zMyUBDY4z0+R8Ah3dNjW0ElKh6tVe82oUCT8NufSWpkWOCo0pzBfeSMFRst5ipTJJw1qgTP/fT2FezpUawrIGevcsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207828; c=relaxed/simple;
	bh=ptxKv8x6ylevA5yI5wa4vryf/6lVRy0gbUbnxJJtU2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6z+Tfl6KR9jrDL0eKnZVhYXlS4n0L/60WH9+3VphcpwjWt6ac4ApcD4bHsIeAlCYcy1nyPh8e+3bVgkVRnnbnTjekEkyTnD7pbf9fgRm64g0D5IbEswpwTbAji9+PwsBzoxdzipHkRIUNmfDAy+AtnnhCNKckavIuU1us82cwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctLIHAw2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761207827; x=1792743827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptxKv8x6ylevA5yI5wa4vryf/6lVRy0gbUbnxJJtU2c=;
  b=ctLIHAw2kJ0egEAGrF1G88enkF8ZcHTPGLMOi7Y7Mb/fiE9sEYyBXAdB
   lFVoLGVSWrKPb3nsnBzKtKJa8TZ8tMudUc3fu294q4gwShu5pHIkizE9M
   jWPsSC1Cz9aMfflkr5PYai6c5vtBhc/TCVafe6d4tX/scQMGAFcx0e1ha
   jSlsrFYBR0++UyBMd4JuB7Bde7G3Mkfx2y54U8Ote9NlNlCPL7SqNCO22
   9mnDTuI+yMVVVkioKv5rVIWmZuX4cGGUgJqVYVEw7iE/94izS9N+M/xkv
   woHIFu/uCqVDjxeLvUrMRrJj4G2niAlAO4jRGtCivp2BFUwgd+jtAn29d
   w==;
X-CSE-ConnectionGUID: QCSiRrf0TpCu6/V3ttL8Vg==
X-CSE-MsgGUID: 1FLG44dyRRe54pdhWC+8lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50950423"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="50950423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:23:46 -0700
X-CSE-ConnectionGUID: xewb7CYnSHm2QYHap8wVgA==
X-CSE-MsgGUID: lpfHCmtBSPKbcNs6POSKHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="183270380"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:23:42 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBqbj-00000001tXy-1owL;
	Thu, 23 Oct 2025 11:23:39 +0300
Date: Thu, 23 Oct 2025 11:23:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/5] i3c: Add HDR API support
Message-ID: <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 14, 2025 at 12:40:00PM -0400, Frank Li wrote:
> Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
> I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
> Technical Overview.
> 
> i3c_xfer will be used for both SDR and HDR.
> 
> Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
> CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.
> 
> Add i3c_device_do_xfers() with an xfer mode argument, while keeping
> i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
> with I3C_SDR for backward compatibility.
> 
> Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
> 'rnw', since HDR mode uses read/write commands instead of the SDR address
> bit.
> 
> Add .i3c_xfers() callback for master controllers. If not implemented, fall
> back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
> all controllers switch to .i3c_xfers().
> 
> Add 'mode_mask' bitmask to advertise controller capability.

...

>  static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
>  {
> -	if (!ops || !ops->bus_init || !ops->priv_xfers ||
> +	if (!ops || !ops->bus_init ||
>  	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
>  		return -EINVAL;
>  
> +	if (!ops->priv_xfers && !ops->i3c_xfers)
> +		return -EINVAL;

I would find the logically coupled proto-based xfers:

	if (!ops->i2c_xfers && !ops->i3c_xfers)
		return -EINVAL;


>  	if (ops->request_ibi &&
>  	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
>  	     !ops->recycle_ibi_slot))

>  }

...

> -enum i3c_hdr_mode {
> +enum i3c_xfer_mode {
> +	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
>  	I3C_HDR_DDR,
>  	I3C_HDR_TSP,
>  	I3C_HDR_TSL,
> +	/* Use for default SDR transfer mode */
> +	I3C_SDR = 0x31,

Why has this a specific value, while the rest have not? If it's HW mandated,
the all of them has to be assigned properly to avoid potential bugs.

>  };

...

>  /**
> - * struct i3c_priv_xfer - I3C SDR private transfer
> + * struct i3c_xfer - I3C data transfer
>   * @rnw: encodes the transfer direction. true for a read, false for a write
> + * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
>   * @len: transfer length in bytes of the transfer
>   * @actual_len: actual length in bytes are transferred by the controller
>   * @data: input/output buffer

>   * @data.out: output buffer. Must point to a DMA-able buffer
>   * @err: I3C error code
>   */
> -struct i3c_priv_xfer {
> -	u8 rnw;
> +struct i3c_xfer {
> +	union {
> +		u8 rnw;
> +		u8 cmd;
> +	};

What field is used to distinguish the union member in current use?
In another word, union must be accompanied with a selector.

>  	u16 len;
>  	u16 actual_len;
>  	union {

>  	enum i3c_error_code err;
>  };

...

> +/* keep back compatible */
> +#define i3c_priv_xfer i3c_xfer

How many of the current users do this? Can't we just rename treewide?

-- 
With Best Regards,
Andy Shevchenko



