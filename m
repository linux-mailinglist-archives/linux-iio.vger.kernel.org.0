Return-Path: <linux-iio+bounces-14165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633BBA0A876
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0C43A8052
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A244D1A8F9A;
	Sun, 12 Jan 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuKlBk99"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE46FB0;
	Sun, 12 Jan 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736679817; cv=none; b=ZIjke16mikpVav/h3KBcsgD+OTI5k0nqcz5bfhSfpQsy2QtcyE8RQaMZIArGXSS/lm6yf4uVXLmklviHqvcLo+uLHDn37T4FSJLh0cp3VCwCARi3S/Sc+F6jXRPTRsXWHK1NuPPDN45TOmCsspPmvL9/Gpi7NhIY80M0o4w1+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736679817; c=relaxed/simple;
	bh=NVwZCBnG4weSFJDV1Rj4jqxbw2cVgB+PMBAKBV1zN0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFNpY9qk6LxAm742qS9fF0TtSXsdg6hi0CfvCo4hOMZWTshIukN3FyP7kGAuFp4f46tk5GGNR6LBAb+3YBRNH+NACT1QdDdG1znhOdhZBV6+cCbhQjn5iAXmCPI6vpcW991NZJ1g/LSM6r+I2DlBCi6wW7FzUyDEXgYg/i3oKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuKlBk99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C7C4CEDF;
	Sun, 12 Jan 2025 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736679816;
	bh=NVwZCBnG4weSFJDV1Rj4jqxbw2cVgB+PMBAKBV1zN0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuKlBk99UBofgd8b/GC2ca5r5xySJ4wvvDjMf49MmL4qr5f/hBBPzXsY5YrTDR3AN
	 g6FJRZpSGDEH/JIUvSseLy3+Aik1dMWNg+cbLhuwtM3EKpRrYXLEfuad9BEku0AqWV
	 VSnIpFRpsNEd7Gh1ZunTFHx0QszFdHyNKz5R3SJRGslyXU1V4mj5AiYIDx0/VR6k6p
	 +QDmJkzH73LpLaX8pNJfnKl4uOpUVawehuVz+qhu+8OjjH/dvFbg7Au5T5uvu5Ni54
	 r7LimmrRVncklCVpt0KbZo2OJEYIiIxGs/8DzwCBxFphourbalCXMwThRwruQ/NK4O
	 xcGxbn9HnjRmg==
Date: Sun, 12 Jan 2025 11:03:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: iio: accel: mc3230: document mc3510c
Message-ID: <20250112110326.214c0adb@jic23-huawei>
In-Reply-To: <cdbcb8eb-b3f4-4a2c-b303-0ebedbab06b7@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
	<20250111-mainlining-mc3510c-v1-4-57be503addf8@gmail.com>
	<cdbcb8eb-b3f4-4a2c-b303-0ebedbab06b7@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 00:46:09 +0200
Markuss Broks <markuss.broks@gmail.com> wrote:

> Hey Vasiliy,
> 
> On 1/11/25 10:11 PM, Vasiliy Doylov via B4 Relay wrote:
> > From: Vasiliy Doylov <nekodevelopper@gmail.com>
> >
> > The MC3510C is a 3 asix digital accelerometer.
> > It handled by the same driver as MC3230.
> > Document it as a trivial device.
> >
> > Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> > ---
> >   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index fadbd3c041c8c39faedfe62874d4eba25a0bf30e..6c34e4c0dcc6df5a4d8edc5effb80980de820db9 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -187,6 +187,8 @@ properties:
> >             - maxim,max6621
> >               # mCube 3-axis 8-bit digital accelerometer
> >             - mcube,mc3230
> > +            # mCube 3-axis 8-bit digital accelerometer
> > +          - mcube,mc3510c
> >               # Measurement Specialities I2C temperature and humidity sensor
> >             - meas,htu21
> >               # Measurement Specialities I2C pressure and temperature sensor  
> 
> DT bindings changes are supposed to be on top of the series for the ease 
> of picking them by DT bindings maintainers.
True they should be earlier, but not that the DT binding maintainers
pick them up.  They review them and then they almost always go with the
patch through the subsystem tree in question.

Jonathan

> 
> - Markuss
> 


