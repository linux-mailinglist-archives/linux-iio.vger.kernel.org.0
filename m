Return-Path: <linux-iio+bounces-26930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9227CAC51C
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 08:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B333085EF2
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0763128D0;
	Mon,  8 Dec 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Vgcq+C+u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9773128C9;
	Mon,  8 Dec 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178158; cv=none; b=O73Q4SkFBSorfEIpT/eYczLiWIdjwyEzoMRzKSQZ0VL4mJNLplscb9hIg1JoO7iWwkwvQTI+8CSUqyZ7JYSBS5zxRI0yJLvohzFwUjT7d10lXjUG9Q1VHIuLbE6MkuYVnlbrXOCVgacefcPWgDUbch/3AqBt4LMY0OjkfUe3wzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178158; c=relaxed/simple;
	bh=/XGaaRvQJHtlKeU3In7WDJW6yzqqNyAHP4oVug9zJKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piPWD5lhSVzeaNsxwW/MwxxeHFDHFuNuFDUxT9R1v5HtHZvqKmqbg1Ppq5ij3/e7ZDQ4YWYjwAOM7uS9+duAJyCM0HR5gLD98L5lrD7dWxgkMBFpKgyI9OYTTvQmRGLlgP0O7BnaOk1qZ/3vi2vbRy3iwP/79HRIJrBQvzG7ZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Vgcq+C+u; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:bad8:b512:830b:aef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id A75AD160209;
	Mon, 08 Dec 2025 09:15:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1765178147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZKBqkNfnM3gCLK3FT5mBJHZ+s9kOQKRix1cDQHOv8c=;
	b=Vgcq+C+uyHbvkGRKznmPaWX5yiqeu53Dd2JY93MCbwcSHNY75a6eAyYxiYtHTDigk1m+05
	vM7oP7lVrINwc77Kxk3pWz342nUwaIbnJbEdsQBAJ12iWayevmirZKX9OWFqi2ftFPJH46
	I6wuKZlQRMU69Lrno0e/BBYXEZHUZwQKUXVz77zbegsVKhY0z8xO3Rk1UADXTywNqZ4egH
	R8sH8L/pOJUoNkKE1v0Gqh6ltsq5dYKnNI9IhAQkcYr8yyxQMBw+QPzW2CAL91OuLPQvFh
	3bEp6O/gyaH5ejB768Vexv8wUSwoy2PTlzpX/E6Vs0k3YnCYEXzcTclkabgbFw==
Date: Mon, 8 Dec 2025 09:15:39 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: pressure: add
 honeywell,abp2030pa
Message-ID: <aTZ7G8M-FvmEuQ8X@lipo.home.arpa>
References: <20251207-honeywell_abp2_driver-v4-0-b52a4b96bbf7@subdimension.ro>
 <20251207-honeywell_abp2_driver-v4-1-b52a4b96bbf7@subdimension.ro>
 <44adc9d6-2520-4282-8c6e-1fedf5319e77@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44adc9d6-2520-4282-8c6e-1fedf5319e77@kernel.org>


hello Krzysztof, 

On Mon, Dec 08, 2025 at 06:01:46AM +0100, Krzysztof Kozlowski wrote:
> On 07/12/2025 07:00, Petre Rodan wrote:
> > Adds binding for digital Honeywell ABP2 series pressure and temperature
> > sensors.
> > The i2c address is hardcoded and depends on the part number.
> > There is an optional interrupt that signals the end of conversion.
> > 
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.

[..]

> If a tag was not added on purpose, please state why and what changed.
> </form letter>

I removed the tag on purpose since the yaml file was modified in v4 as per the
changelog that is below the commit message.

> I will not be doing work twice and, without explanation, forcing me to
> do that is disrespectful to my time.

sorry about that. the single thing that changed was that

---- 8< --------------------------------------------
@@ -76,8 +71,7 @@ properties:
   spi-max-frequency:
     maximum: 800000
 
-  vdd-supply:
-    description: provide VDD power to the sensor.
+  vdd-supply: true
 
 required:
   - compatible
---- >8 --------------------------------------------

I checked the resulting file with make dt_binding_check, yet I was not sure if your previous tag would still validate the work.

best regards,
peter

