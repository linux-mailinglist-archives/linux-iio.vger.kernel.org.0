Return-Path: <linux-iio+bounces-7589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73A93054E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37184282E81
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C24D5A2;
	Sat, 13 Jul 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzcYypRS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D745C14;
	Sat, 13 Jul 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868422; cv=none; b=DFRnP9AAmZAvEh2VHhYqXXkBL7jpQJz5AdEsotHv7uSV3e6iKEBOUX5Is7NrXiPAmmSkATZJPhCv0m4hmRRJwXHun83LnanhlDJq7tOGm1RaE87e5vo0wbOfbDeuWEdeeusf9jYguDwlmCRafW71/dDb+177eAUFGoYPgPolprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868422; c=relaxed/simple;
	bh=6MwOyZRCjJkxdmlwhPk2vAqrqZ8cTUIQr3o9S8vkzTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+HoY6LMzTv2SIltkx/pUa2s35NgFJ7fz+QAQlX3zDloHD6zDMro0l0+n7T9iGgGINY0T3DYg+0dbTWvUapt4qQvTDU6c8W8OQB7dGm86DU8y3eZ/HnvIqAnFTeLilRDWBEHjMyr83a7XYe7mQvMdHxb4ROs/oTLUg+uB9QMX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzcYypRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880C1C32781;
	Sat, 13 Jul 2024 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720868422;
	bh=6MwOyZRCjJkxdmlwhPk2vAqrqZ8cTUIQr3o9S8vkzTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UzcYypRS1WEGzDC889pQIEhzvsfGPfcvplBJise752vDZBLZQaWMulCUxvkhdzEOq
	 5uaFnEkEfvKqrj2zHcPYnqtzkyy2GrzdnTApothF2r91HJn4EZ4C3I43bQ4V8twPJc
	 iEDNNt9dmWwUHWwcyG52PF2/EY9Kzp9be/kCb5LDVLJW2i1wfA5R3KOHKaQcN+emVK
	 AXcH+mDgdNOqX7c+J8SwK4ctHu/IHEbtly22hzpkl6o+fQU1ve+mkTheZ8rakOI8L0
	 4JGbTQUFbP9hO1/czt2VBxtX5KOiCp9FwlaYYggkG8uqEmzQRUocWaU2wEdV+dbmcc
	 rY4OqmP50RTog==
Date: Sat, 13 Jul 2024 12:00:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: rename bu27034 file
Message-ID: <20240713120013.034b4419@jic23-huawei>
In-Reply-To: <2b66ea94-dd77-4e86-b09b-c00523bdbf75@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
	<f83cf0d6f5b0ed391703ea3908ebd65b3f6e5c87.1720176341.git.mazziesaccount@gmail.com>
	<20240708-eloquent-overdrive-092c7678f913@spud>
	<2b66ea94-dd77-4e86-b09b-c00523bdbf75@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 21:33:02 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 7/8/24 20:05, Conor Dooley wrote:
> > On Fri, Jul 05, 2024 at 01:54:26PM +0300, Matti Vaittinen wrote:  
> >> The BU27034NUC was cancelled before it entered mass production. It was
> >> replaced by a new variant BU27034ANUC (note, added 'A'). The new
> >> variant gained a few significant changes, like removal of the 3.rd data
> >> channel and dropping some of the gain settings. This means that, from
> >> software point of view these ICs are incompatible. Lux calculation based
> >> on the data from the sensors needs to be done differently, and on the
> >> BU27034ANUC the channel 3 data is missing. Also, the gain setting
> >> differencies matter.
> >>
> >> The old sensor should not be out there so the compatible was dropped and
> >> a new compatible was added for the bu27034anuc. Move the yaml file so
> >> the file name matches the binding and change the $id.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> ---
> >> Revision history:
> >> v1 => v2:
> >> - New patch
> >> ---
> >>   .../iio/light/{rohm,bu27034.yaml => rohm,bu27034anuc.yaml}      | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>   rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml => rohm,bu27034anuc.yaml} (92%)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
> >> similarity index 92%
> >> rename from Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
> >> rename to Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
> >> index 535bd18348ac..fc3d826ed8ba 100644
> >> --- a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
> >> @@ -1,7 +1,7 @@
> >>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>   %YAML 1.2
> >>   ---
> >> -$id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
> >> +$id: http://devicetree.org/schemas/iio/light/rohm,bu27034anuc.yaml#
> >>   $schema: http://devicetree.org/meta-schemas/core.yaml#  
> > 
> > IMO this should be squashed.  
> 
> I've no objections to squashing this. The main motivation of having it 
> as a separate patch was to point out the file rename for reviewers and 
> ask if it is Ok. Furthermore, if there was a reason not to do the 
> rename, then this patch could've been just dropped while the rest of the 
> series could've been applied.
> 
> Thanks for the review!
I squashed into previous patch whilst applying.

Thanks,

Jonathan

> 
> Yours,
> 	-- Matti
> 


