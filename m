Return-Path: <linux-iio+bounces-1810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ADC83573B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76541C20A80
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD7381DA;
	Sun, 21 Jan 2024 18:20:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1E38380;
	Sun, 21 Jan 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705861223; cv=none; b=WMxm0qXsKlPvHkexHUuEuRrKqE75qPzgdwr54tzMR8g116q9lQYQbe3yySnDsB471OLjQ053gzewvcHrjEDz3C7ffDq95z9u6dZ4wYbPX2bUPEFxHI4G6gpObF82VSDa4eC+4CjMVLdsmx2YQCDqGw1cS1q4jSueKEWFyTdDKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705861223; c=relaxed/simple;
	bh=WvNOMjwWrXowVuGeUoVHXTocMC9fsQ9/LstdJJfS44g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMbzn7X+KoUPGIG0LD7FHC9TBG9x/3tN28Bffc1bi9IHqxrfv6FVkVEyW7mqDeja3ORUFOJ7THGCffwKURWdplNCme5AlFMDbtu8t9n5hrrVOHdycyNQ//UvP1zLlggfystu7250s2txIA4SPp99si93LBPSbPT0ETW40YPVGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A31B0100DCEF4;
	Sun, 21 Jan 2024 19:20:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7408B2C4F32; Sun, 21 Jan 2024 19:20:12 +0100 (CET)
Date: Sun, 21 Jan 2024 19:20:12 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 01/13] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <20240121182012.GG7075@wunner.de>
References: <20240114172009.179893-1-jic23@kernel.org>
 <20240114172009.179893-2-jic23@kernel.org>
 <20240121180603.GA13937@wunner.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121180603.GA13937@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jan 21, 2024 at 07:06:03PM +0100, Lukas Wunner wrote:
> On Sun, Jan 14, 2024 at 05:19:57PM +0000, Jonathan Cameron wrote:
> > v1: Thanks to Andy for reviewing the RFC.
> >     Add check for if (!IS_ERR_OR_NULL(_T)) to allow the compiler to optimize
> >     cases where it knows the passed in parameter is NULL or an error pointer.
> 
> Heads-up:  Using IS_ERR_OR_NULL() in DEFINE_FREE() macros bloats
> the code with additional IS_ERR() checks and NULL pointer checks.
> 
> See the detailed explanation in this patch which adds a DEFINE_FREE()
> macro for x509_free_certificate():
> 
> https://lore.kernel.org/all/70ecd3904a70d2b92f8f1e04365a2b9ce66fac25.1705857475.git.lukas@wunner.de/
> 
> I'm wondering if a solution might be to stop returning IS_ERR()
> from "constructors" such as x509_cert_parse() and instead assign
> the created "object" (x509_certificate) to a call-by-reference
> pointer and return an integer.  If the returned integer is not 0,
> inhibit "destruction" of the "object" with no_free_ptr().

Another idea would be to use a call-by-reference pointer and check
the pointer instead of the return code.

E.g.:

DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
	    if (_T) x509_free_certificate(_T))

...

	struct x509_certificate __free(x509_free_certificate) = NULL;
	int ret;

	ret = x509_cert_parse(&cert, buf, len);
	if (!cert)
		return ret;

