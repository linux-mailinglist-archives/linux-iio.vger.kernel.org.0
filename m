Return-Path: <linux-iio+bounces-22789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE31B28CCD
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFB16DCFF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1E28F948;
	Sat, 16 Aug 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/Mxq2yr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255642BCF5;
	Sat, 16 Aug 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339798; cv=none; b=deSDH+1QyFnmFI0Jje6T3wJ3YU46hwlC1k1I7UeIFWCH9H5qHMv+/jqT9WNQM7/V8SaeXBEfS2yAw52SQcKBV5RjR4nRIXWBeo3kHA6F6qmEVhLF1tKqc7TEWAOj4ie0viLtAIYk6BQUcw/BPNUTNy4VRdE41gnamYony08toMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339798; c=relaxed/simple;
	bh=jZPpKfzcezgme07WiUAYhWu+QycIoJb/waNgS7U1ggQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClglaQrCPwrJqkxw9bnfP3sGAu6wrtDYjMqAILM/2QfLQMbLFPaf804BJMj0xcGzD2TVmgl1ugY8oClkKdNPWfVnueCsHs06Iku6NnLAVGdenyRuB+qXAiMQbYOqYSfUJ01IptJ9dcPvgFdg8HIu6v7OxxcSlEU0Q/5l8A7LbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/Mxq2yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55605C4CEEF;
	Sat, 16 Aug 2025 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755339797;
	bh=jZPpKfzcezgme07WiUAYhWu+QycIoJb/waNgS7U1ggQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R/Mxq2yrF1YNrw0Tvjha0/D4vxGTfwyEOJrXQ8Bc2kRjqcGJVjGsPZQdHUJIw3Yil
	 UeT2bnADft86EtBxQSDGr6RTCODQ+hg4Vbjnin67X9ibMSarcscq2FBwvqukY9x5tN
	 QenXTJa6qvWheTt/lZamZP61QVlMdjqPD2thT4WH76hqHb0G9NJCKmbYVovWf3r/dN
	 01LDiGqwREsQohw1x7cU41qZMBA7nQrs/DyDiaNolreCFEZfYPlQeZGISEbIAEevhf
	 9XzFvcRXqEfp4p9yRNkYNo/26UCD1OUsXLEObgmRedpUikUn+SPwa+hYkxVuMOPJ9P
	 OXPaHfoyxNchg==
Date: Sat, 16 Aug 2025 11:23:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: krzk@kernel.org, Michael.Hennerich@analog.com, andy@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
 krzk+dt@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: ltc2497: add docs for
 LTC2495
Message-ID: <20250816112307.642ea373@jic23-huawei>
In-Reply-To: <20250813084444.1842413-1-y.alperbilgin@gmail.com>
References: <0ece8b0e-6c20-42ca-a3a6-4c35ee2be07b@kernel.org>
	<20250813084444.1842413-1-y.alperbilgin@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 10:44:44 +0200
Yusuf Alper Bilgin <y.alperbilgin@gmail.com> wrote:

> Hi Krzysztof,
> 
> Thank you for the review and guidance.
> 
> On Tue, Aug 12, 2025 at 07:04:00PM +0200, Krzysztof Kozlowski wrote:
> > What are the differences, why it cannot be made compatible with 2497
> > (fallback)?  
> 
> The LTC2495 offers a more advanced feature set compared to the LTC2497,
> including:
> 
> - Adjustable input gain
> - A selectable 50Hz/60Hz lowpass filter to reject line frequency noise
> - Selectable speed modes
> - An internal temperature sensor
> 
> All of these features are configured via a second I2C command byte
> (listed in Table 4 of:
> https://www.analog.com/media/en/technical-documentation/data-sheets/2495fe.pdf),
> which changes the driver's communication protocol compared to the
> single-byte commands of the LTC2497.
> 
Is that second byte optional?  Figure 3b seems to suggest so but I haven't
taken the time to read the rest of the data sheet.
If it is never written does this new device function as backwards compatible
with the LTC2497?

If so a fallback compatible is appropriate.  This is used when we have
new newer DT against an older driver that doesn't support new features.

A newer kernel will match on the new ID and hence provide these extended
features you have here.

Note this discussion should have happened before you posted v2, let alone v3 and v4!

Jonathan

> This patch series begins to support reading the internal temperature
> sensor by implementing driver logic for the two-byte I2C command format
> and exposing the IIO temperature channel. Therefore, I added a new
> binding. Without the support for the temperature sensor and this
> different command structure, a simple fallback would be sufficient.
> 
> Let me know if you agree with the reasoning to add the binding. If so, I
> will update the commit messages in v2 to include this justification and
> ensure they follow the imperative mood convention.
> 
> Best regards,
> 
> Alper


