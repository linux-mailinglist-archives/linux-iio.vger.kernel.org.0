Return-Path: <linux-iio+bounces-25033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC40BD48A7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F5F4C004E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA173081B9;
	Mon, 13 Oct 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="cGmoK95N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD123081B2
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369139; cv=none; b=WbY7b/UB38IeORQwtXu46jdgLcXXyIr8KfqJsFY9KVDiFKk0UG2NTs7rw+lfKqkUch+QNuLHjBXan01WNQ4+832ONBEZvmoX+jYD9wy2u1E77iyVLf1w/6JO2hmTSuOi64HbRpp5B0G/ADl1kt+56nL1i53F9KKs7A4xgP3Rb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369139; c=relaxed/simple;
	bh=VH/jjwDLkiSGiAr4JG89l4anPAc3ygJofrUXtkBMnrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvHmWqljoPF7UNuOWAuwEdAL8P7+DEAVPyTUNBOS3yzz+QXtvRdfa30+xthU6AMyMSBBO7FrHbgrjlIKHfd0wlD5QLqZW5eZp3t0g/0xc5R8ayz7c0sSfJHuyf9JdTftyJDtU2NH4RUz9JFWu/cm8JYv9tZ5CASDCO0inozqhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=cGmoK95N; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id A8A24103847E
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 20:55:30 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in A8A24103847E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1760369130; bh=VH/jjwDLkiSGiAr4JG89l4anPAc3ygJofrUXtkBMnrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGmoK95NAv8CM1VB0uMl3a2sfWTHQGZGw0gqZtp1vXMgyLaqVXz3l8kr5IDoekCQW
	 Ed+msU3LxHDMDydJm1VmBQ56oLJ8zbviPnJzxsa86iqMv4ImrXL723N3U5u4/paXm7
	 9FmNBKYblzlvU6d0Ro6CUcdg/vATJG5DETvCyXW0=
Received: (qmail 23344 invoked by uid 510); 13 Oct 2025 20:55:30 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.394388 secs; 13 Oct 2025 20:55:30 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 13 Oct 2025 20:55:26 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 3F13A341504;
	Mon, 13 Oct 2025 20:55:25 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id F0F151E81581;
	Mon, 13 Oct 2025 20:55:24 +0530 (IST)
Date: Mon, 13 Oct 2025 20:55:20 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: Add Aosong adp810
Message-ID: <20251013-152520-1561165@bhairav-test.ee.iitb.ac.in>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <5ddfc7d318a7d3a42cfce4a33ad62f3d2be91a11.1760184859.git.akhilesh@ee.iitb.ac.in>
 <aa5d7fb2-2143-43b1-8780-87b69479a17b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5d7fb2-2143-43b1-8780-87b69479a17b@kernel.org>

On Sun, Oct 12, 2025 at 05:13:53AM +0200, Krzysztof Kozlowski wrote:
> On 11/10/2025 14:25, Akhilesh Patil wrote:
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/aosong,adp810.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: aosong adp810 differential pressure sensor
> > +
> > +maintainers:
> > +  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > +
> > +description: |
> 
> If there is going to be any new version, drop |.

Sure. Fixed in v2.

> 
> 
> > +  ADP810 is differential pressure and temperature sensor. It has I2C bus interface
> 
> Wrap at 80 (see coding style).

Fixed.

> 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

Hi Krzysztof, Thanks for the review.

Regards,
Akhilesh


