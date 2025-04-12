Return-Path: <linux-iio+bounces-18028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD814A86EB2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE21D8A228A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826F204F99;
	Sat, 12 Apr 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ4ntRBu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4919ABC3;
	Sat, 12 Apr 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481846; cv=none; b=HPpNZrKxIQ7sXXYa4QVmjNaiM96fQ+HuopMgOdZh733EkehNqmef3Y4YhVlK44xDx6mbvu+5H3iswu2dWO/ULhWh7Hlc4SvKZTZCC8XI7qMPzn43JYQNucZ6l02bcGP/x9ubhdt2rH7aXuoT6JLZI8GJBU8ox9c3kyCfOAaY5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481846; c=relaxed/simple;
	bh=NtCwYDAbpoNRLu5ed5yAbLfhJNl++H9kwSfF4Fq7qh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfuzUwPnhkomftBu8u2dpiDtqM1pYfpo6OoZRT8p1iTLtQ6hRySC0xmoxYFbuSrhE3OfGpy0v+Ze6AXOFtuWnDNr9KsH86kCWO0rzWB2DwewmLwpejXtC6zcJQYVuK1yZ1chJ0iSnm0t4fhQ1NyTbXrkcz+3xbwwg50/HgnCWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ4ntRBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92878C4CEE3;
	Sat, 12 Apr 2025 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744481846;
	bh=NtCwYDAbpoNRLu5ed5yAbLfhJNl++H9kwSfF4Fq7qh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQ4ntRBu0KKaoxHGyugbyHFN2mYiKovOIyAtJ/jPGa3LiF2TY+EQ6nHg7I7+2Y6y2
	 kTSDf54r6lSP7YIAuVa3HYGtkKzRu8iy7jDF2E3wAfPwGV1q7fvDeE2ZPJfOivZtiV
	 RQlcf0rmfZ/KjA2IbK3xrdrrEv17EuRehUcx2kXrvopWzAWRarLG39tIqZQhh7+R1G
	 qoSbZbPUA10w3u+DrCVdsLVMwn15IfQL6xk3ZlXLnDMDQl2BAZuq5Dcc+ZAc1+wuWX
	 w98uactJ8u2svIegtJpQfS+/2iGBwB52uI+2IW/P2Q3fL3r76VF9K6kpwZp6pSvT4Y
	 R5zZt25Ut+UIQ==
Date: Sat, 12 Apr 2025 19:17:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: remi.buisson@tdk.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: iio: imu: Add inv_icm45600
 documentation
Message-ID: <20250412191717.7f5ddfe4@jic23-huawei>
In-Reply-To: <4460df06-6da1-4b23-8789-82945e90a09c@baylibre.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
	<20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
	<4460df06-6da1-4b23-8789-82945e90a09c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 16:18:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/11/25 8:28 AM, Remi Buisson via B4 Relay wrote:
> > From: Remi Buisson <remi.buisson@tdk.com>
> > 
> > Document the ICM-456xxx devices devicetree bindings.
> > Describe custom sysfs API for controlling the power modes.
> > 
> > Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> > ---  
> 
> IMHO, it is more logical to have the dt-bindings patch first in the series
> before the code that uses it.
> 
> >  .../ABI/testing/sysfs-bus-iio-inv_icm45600         |  37 ++++++
> >  .../bindings/iio/imu/invensense,icm45600.yaml      | 136 +++++++++++++++++++++
> >  2 files changed, 173 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600 b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..8d2d9b68ad9e35fe0d6c157e984afc327eab92ec
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600  
> 
> 
> ABI documentation is separate from dt-bindings and needs to go in a
> different patch.
> 
> Also, it looks like /sys/.../iio:deviceX/in_accelY_power_mode is
> already a standard attribute in Documentation/ABI/testing/sysfs-bus-iio
> so we could add to that instead of creating a new file.

Just a quick side note.  Those powermode interfaces are hard for userspace
to reason about, so where possible it is better to set power mode in response
to more explicit demands such as sampling frequency.  I can't remember when
I got persuaded to let that one in. I checked - long ago and we still only
have 2 users :)

> 
> And there is Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
> that has the same attribute essentially. So it would be good to
> delete this file and consolidate everything in the main file.
> 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..51455f0b5cb90abdd823f154e45891ad364296e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> > @@ -0,0 +1,136 @@  
> 
> ...
> 
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#  
> 
> Since this can be connected to different buses, I don't think we want
> to always ref this. It gets included implicitly for all child nodes on a
> spi controller node anyway.
> 


