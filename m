Return-Path: <linux-iio+bounces-1809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D1835730
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 19:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CFC2820CB
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE092381D8;
	Sun, 21 Jan 2024 18:06:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA83771A;
	Sun, 21 Jan 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705860375; cv=none; b=N24YxiVG3Oll93Esmg/ZU7b8IZoupE5nCM7+ut8WzduQXO3Z9kVYcG0x9m7IC1nzPpqCe2RE2ZoBnSgREEFeJ1dXlHUnyyZZbcLHuRR/U4y3aCiBQWA2ttMzEsAFk1yVy3hkto7/vr1YixZjt7W9CyT/m9eUyT0Su4AjdANfVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705860375; c=relaxed/simple;
	bh=81aKm7pGIU9mO5TTr5l32nCFEOMw/mDBv9eGLSJb1Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8o9v/yKOhGkaU7VlzAgoPWFiD6scZsQ2TeFFrbRV0uH/g+MPlskevdkOcfGoQN0Z2uYGOeE+zQHZ3w0FZRm1ZlvSrg/sUcU0mDXJB3jGJZ580pmA9MVqUbZUFbAyV/Jo92P+ntriUDw/2PPRoD5SzqYwkSBTDeUHj1HcZqX4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 50F96300002CB;
	Sun, 21 Jan 2024 19:06:03 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 433952C4F2B; Sun, 21 Jan 2024 19:06:03 +0100 (CET)
Date: Sun, 21 Jan 2024 19:06:03 +0100
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/13] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <20240121180603.GA13937@wunner.de>
References: <20240114172009.179893-1-jic23@kernel.org>
 <20240114172009.179893-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114172009.179893-2-jic23@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jan 14, 2024 at 05:19:57PM +0000, Jonathan Cameron wrote:
> This allows the following
> 
> struct fwnode_handle *child __free(fwnode_handle) = NULL;
> 
> device_for_each_child_node(dev, child) {
> 	if (false)
> 		return -EINVAL;
> }
> 
> without the fwnode_handle_put() call which tends to complicate early
> exits from such loops and lead to resource leak bugs.
> 
> Can also be used where the fwnode_handle was obtained from a call
> such as fwnode_find_reference() as it will safely do nothing if
> IS_ERR() is true.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v1: Thanks to Andy for reviewing the RFC.
>     Add check for if (!IS_ERR_OR_NULL(_T)) to allow the compiler to optimize
>     cases where it knows the passed in parameter is NULL or an error pointer.

Heads-up:  Using IS_ERR_OR_NULL() in DEFINE_FREE() macros bloats
the code with additional IS_ERR() checks and NULL pointer checks.

See the detailed explanation in this patch which adds a DEFINE_FREE()
macro for x509_free_certificate():

https://lore.kernel.org/all/70ecd3904a70d2b92f8f1e04365a2b9ce66fac25.1705857475.git.lukas@wunner.de/

I'm wondering if a solution might be to stop returning IS_ERR()
from "constructors" such as x509_cert_parse() and instead assign
the created "object" (x509_certificate) to a call-by-reference
pointer and return an integer.  If the returned integer is not 0,
inhibit "destruction" of the "object" with no_free_ptr().

Thoughts?


> +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))

If you do not align the "if" to the opening parenthesis,
checkpatch --strict complains:
"CHECK: Alignment should match open parenthesis"

If you do align to the opening parenthesis, it complains:
"WARNING: Statements should start on a tabstop"

I chose the latter for x509_free_certificate() for aesthetic reasons.

Either way, checkpatch still emits:

ERROR: trailing statements should be on next line"
#183: FILE: crypto/asymmetric_keys/x509_parser.h:49:
+	    if (!IS_ERR_OR_NULL(_T)) x509_free_certificate(_T))

Can't make it happy with these new-fangled DEFINE_FREE macros it seems. :(

Thanks,

Lukas

