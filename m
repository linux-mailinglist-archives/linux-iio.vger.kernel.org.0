Return-Path: <linux-iio+bounces-8068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4621E941F69
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 20:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F5E281C9A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A83618A6DD;
	Tue, 30 Jul 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTUqP+sO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9018A6D1;
	Tue, 30 Jul 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363573; cv=none; b=RWGMtRqgSHSfqaUrZoXF/u1U2c4tsFCvGZIIl3+jdlGeUx+Bw8Q+qCE2chdtiAOFoPzxC52mFkHl/gJppDYJ5kXPWuiNqHBuxvQqtc/Py1oE4q3o83JPyY5+CMPvuijQhcezC69y9WZzWcJmbXA77ARelezM1Mk/24vZNa8W+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363573; c=relaxed/simple;
	bh=RxSnMRhu64wq5qQ8HmvF7KxdiaI0InhhbVSiBN9Xnfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJzSRM1CWaxiRgjDFlLXG63hbFyEmRj/qaqmePvRkH8BKdjn4FkRzdFvyzAs/2a8STslEHiWwtHYZ0q1uu2yGYFANhpVAf4cgA//YMJdeaAknqrlWbzlxH3KTk+9XQdJ3SkCZPXkHbi5sY1G7cXuOp+1jYhPj6v+GIv/czt69dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTUqP+sO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3A9C32782;
	Tue, 30 Jul 2024 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722363572;
	bh=RxSnMRhu64wq5qQ8HmvF7KxdiaI0InhhbVSiBN9Xnfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OTUqP+sOp7QOtjw6saoR1RZk04qvW2elmg1Mn0i7f7Avb9A/Oe+CCIrirogkRUhiA
	 gvsdvm3SxoX7OGrxzIwB/ZB1wpnQ5QfOIVXOyHHrpxmwcqw3LixqQX5TIYbKzpK5l4
	 +FMpGs6JanFz9brHTiquhDZjsEcZ0qufTaVqqXn4FRJ71Op74hR4yRTgv6LgOUnBVh
	 a9PYti3+e4jIBc/542LUREFSb2e4gdSIbOgYBVg80cA7p0Q6jamQ8ZMgrtgRIFenlf
	 MhRH9I9lnFI5Sbsvn/WtA4HEVu6wQyVf2ZhX2XCZGBGapC1/Yb3QowtDzpvlFflpYX
	 EQDucApEt142w==
Date: Tue, 30 Jul 2024 19:19:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] *** Add ADF4378 Support ***
Message-ID: <20240730191923.0ad01e2f@jic23-huawei>
In-Reply-To: <fc357a23-0d4d-47e8-95fd-6abb4a33e301@kernel.org>
References: <20240729095047.25040-1-antoniu.miclaus@analog.com>
	<c93a6bf3-7360-4696-833d-82726d10f604@kernel.org>
	<CY4PR03MB339984EFB38E801AEEE1368D9BB02@CY4PR03MB3399.namprd03.prod.outlook.com>
	<fc357a23-0d4d-47e8-95fd-6abb4a33e301@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 10:42:51 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 30/07/2024 10:23, Miclaus, Antoniu wrote:
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk@kernel.org>
> >> Sent: Monday, July 29, 2024 5:58 PM
> >> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; Lars-Peter Clausen
> >> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> >> Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh@kernel.org>;
> >> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> >> <conor+dt@kernel.org>; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
> >> linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >> kernel@vger.kernel.org
> >> Subject: Re: [PATCH v3 0/2] *** Add ADF4378 Support ***
> >>
> >> [External]
> >>
> >> On 29/07/2024 11:50, Antoniu Miclaus wrote:  
> >>> Add support for ADF4378 high performance, ultra-low jitter, integer-N
> >>> phased locked loop (PLL) with an integrated voltage controlled
> >>> oscillator (VCO) and system reference (SYSREF) retimer ideally
> >>> suited for data converter and mixed signal front end (MxFE) clock
> >>> applications.
> >>>
> >>> The main difference between ADF4377 and ADF4378 is that the second one
> >>> provides only one output frequency channel which is enable/disabled via
> >>> one GPIO.
> >>>
> >>> Both the driver and the bindings are updated to reflect that difference.  
> >>
> >> That's a v3, but where is the changelog?  
> > 
> > Each of the two patches has their own changelog.
> > For the cover letter there's no changelog since it was added with v3.   
> 
> Ah, ok, it was not that easy to find, without any spacing from the diffstat.
> 
> Best regards,
> Krzysztof
> 
Applied to the togreg branch of iio.git and pushed out as testing initially
for 0-day to take a first look at it.

Thanks,

Jonathan



