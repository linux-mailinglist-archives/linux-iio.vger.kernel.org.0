Return-Path: <linux-iio+bounces-551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE874801DA9
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 17:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12627281493
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8771C291;
	Sat,  2 Dec 2023 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ehks+CGb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3899D;
	Sat,  2 Dec 2023 08:06:27 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C714028EE6F;
	Sat,  2 Dec 2023 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701533186;
	bh=c3izzflbnvnQn9mjCeWPVgU2PPYA3ayk9O3r2CAxXv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ehks+CGbwv0HvlAuZ+sK1gITTW0vqSbQgBld22yXaTw+YjPb5kPz+p3Tfftalwv8s
	 0I+EALbISNyjTrK4GX2du0dV0o1BLwcFf7Hk1IMPoIlQ1u4en9GfWhrBhTIBo5rio5
	 cDjUuSNPCKylXqnLAKrFZ6JhAW6ke09bwgajsOHI=
Date: Sat, 2 Dec 2023 18:06:24 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZWtWAPcJTNrD9wgv@sunspire>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
 <ZWeNNMfqKquDYI9X@sunspire>
 <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>


hello,

On Thu, Nov 30, 2023 at 03:33:02PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 29, 2023 at 09:12:52PM +0200, Petre Rodan wrote:
> > On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> > 
> > 437:  ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> > 					&triplet);
> > [..]
> > 455:	ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > 						triplet);
> > 		if (ret < 0)
> > 			return dev_err_probe(dev, -EINVAL,
> > 				"honeywell,pressure-triplet is invalid\n");
> > 
> > 		hsc->pmin = hsc_range_config[ret].pmin;
> > 		hsc->pmax = hsc_range_config[ret].pmax;
> > 
> > triplet is got via device_property_read_string(), is there some other property
> > function I should be using?
> 
> I think I mentioned that API, but for your convenience
> device_property_match_property_string().

one of us is not sync-ed with 6.7.0-rc3 :)

cheers,
peter

