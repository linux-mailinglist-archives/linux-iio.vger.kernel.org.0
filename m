Return-Path: <linux-iio+bounces-22790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0233B28CCF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28DFAC866F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED928FFC8;
	Sat, 16 Aug 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlxM3M5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AE1BC3F;
	Sat, 16 Aug 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339847; cv=none; b=BRKPqXo82YO2zdhAZxoYs3Sc0GYzKIn7tnxsAuyTo4zawMYZNGOFnHhVtig5nUe/e1c2wfPd9ER3+ekz4ZBJUJh37wbhnVIKvH4kFslc04bJESql1WjoZ/Aw2ksAszsZue5jT6nM9RnSCXefWMnvVTmKx8Av1lsppJTtF9nlZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339847; c=relaxed/simple;
	bh=q4RSZ0OyCd9Xi9QA2zHc8zfFbKlMQ/MIajyfHJrcspY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPGogG08I5LoAET8AIXGn6ijGOhp5lN90eGtp7IRGhmUTZMMb4VsCaSDmoxK0DNYnj4+q3YA13TehNMEqRwwyi84GHM/QMElofpItvcBivwCWhnYYqdhiEZiU+Rp8WgEJd7QhKfRmhIgcc04XRmh0RzHuBITeLS7AWzKniT/PbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlxM3M5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7D3C4CEEF;
	Sat, 16 Aug 2025 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755339846;
	bh=q4RSZ0OyCd9Xi9QA2zHc8zfFbKlMQ/MIajyfHJrcspY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rlxM3M5CtVgx/30XuqAkSlcf7TlkzvM5T7wziOlT6E6NoKma9pe4CTp8+B3zTXqKh
	 hyYBNRvlH3ixJNzRLL0nBt2l+GbX26KKiaHUrckzkBHP4JstvZ9HznwwySLoNEbuhz
	 HgIS2sni1eGYjyfC1CCXb+f/7TSEXMVpaUcE2e4Igbdwd2yvKLlJ9ihGMDR2ztmhNl
	 KMQDAsEykYu37svydwwoe0wBYdWx4fPS54UI9sS06CJThGHJRYgHY9prwbYS+9tFWS
	 Wikva0vlfJ6L1Ap8GOZuLklEirh0e3qgHK0OKVM2VRgiGbIUcYJAWOTwS/F2gO5Qu0
	 CPaTRa8M+zO1w==
Date: Sat, 16 Aug 2025 11:23:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: ltc2497: add lltc,ltc2495
 bindings
Message-ID: <20250816112355.79747df6@jic23-huawei>
In-Reply-To: <20250815-fanatic-benevolent-whippet-ce6f19@kuoka>
References: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
	<20250814-ltc2495-v3-1-c2a6cecd6b99@gmail.com>
	<20250815-fanatic-benevolent-whippet-ce6f19@kuoka>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 10:57:21 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, Aug 14, 2025 at 01:00:17PM +0200, Yusuf Alper Bilgin wrote:
> > Update the binding documentation for LTC2497 to include LTC2495 to
> > enable support for its internal temperature sensor, which requires a
> > different I2C command format and a new IIO channel.  
> 
> Your patch #2 says they are compatible, so either this patch is wrong
> (and you are supposed to use fallbacks) or patch #2 is wrong/incomplete.
Agreed.  Going too fast here, and discussion on v1 wasn't finished.

Jonathan

> 
> Best regards,
> Krzysztof
> 


