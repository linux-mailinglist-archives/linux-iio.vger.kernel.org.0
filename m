Return-Path: <linux-iio+bounces-7639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6CF932E7D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BFDB2252A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3BD19EEAA;
	Tue, 16 Jul 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE3Erc6h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2B1DFF0;
	Tue, 16 Jul 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148214; cv=none; b=Vdr5pZlqukoqYdq9tIdYeFvzdk61phu6JQeXVcHSXTHZFUUwahzItdNXajYmWIDPJ5JEbzh5XkIYgv2rb6V6TjQMdHu4DG/H6OBr8zqYAWZXvUYiKz0uMT7YX4WcyMnmnSB1e/jd4sdgs29znNZm5Cnc9YqntiSY7Dk3YHbWKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148214; c=relaxed/simple;
	bh=zzYp98HGQ5H5wsFS2vl2WIqZ0vEM7Lw4VSiJ90lUJGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXkBQYw4YuiEuASbW+OkCkfDgc9RAxl6xC4QDdK4WVJiCNbZ+LixTe1/56SfOT/CD2hyOowge+5f6OM1/cWtMM324Gm8FRgF3UvsBAeqE0br7ZXhk1vnNby36xMNS4SB/pOdRAGkrWNzqmiURnokzooOrASGzPgqHNqBsHzZyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE3Erc6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B72FC116B1;
	Tue, 16 Jul 2024 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721148213;
	bh=zzYp98HGQ5H5wsFS2vl2WIqZ0vEM7Lw4VSiJ90lUJGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OE3Erc6hr2cL6zB85u3uYoBBOvdBJCvrkPvs31CZ8+nDhbt+n4HYSnwnZmPaAViTu
	 9+eyeoV8+7W+zy13lpa+oJztIkgA9P/anHFwkYlyfaBYk/MPSINnJ+kHpxRdccBwYK
	 r6eG6tiwdr1sWY9ukA9mfaHwCJldjezADXluraMHznmQXIjtNbWnGWAxletQkcUxkG
	 XnfhVBVG1Q0oV5uWOIAzG8QXb2RxS1f22i5YQCK5RjD5TgKAYHPEqkOUXqm5qlS+Vg
	 vTpGpgVInYoXwgdcbBbqdr3L71FV3dEFSoR0vht4t6ZoT9+HX0Fgx57ITQtrA+uSyZ
	 JHcNmdsWAJRiw==
Date: Tue, 16 Jul 2024 17:43:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Message-ID: <20240716174328.15c250a9@jic23-huawei>
In-Reply-To: <be34b0b571ddc33351e9eb123410a210@disroot.org>
References: <20240712152417.97726-1-kauschluss@disroot.org>
	<20240712152417.97726-3-kauschluss@disroot.org>
	<20240713130620.79d47130@jic23-huawei>
	<be34b0b571ddc33351e9eb123410a210@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 20:02:57 +0000
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> On 2024-07-13 12:06, Jonathan Cameron wrote:
> > On Fri, 12 Jul 2024 20:54:02 +0530
> > Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> >   
> >> Add the compatible string of stk3013 to the existing list.  
> > 
> > Should include how this differs from existing devices such that it doesn't
> > make sense to use a fallback compatible.  
> 
> STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
> being marketed as a proximity sensor, it also appears to have ambient
> light sensing capabilities.
> 
> Add the compatible string of stk3013 to the existing list, as a part not
> compatible with other devices.

That would be fine, but I'm not seeing any driver code changes, so when
you say not compatible, in what way? If it's register changes in features
we don't support yet or something like that, just add some examples.

A different whoami register value isn't sufficient as after the fix
you have as patch 1 that will only result in a message print.

Obviously doesn't help much for this addition as you are adding the
bypass of the whoami and the new ID in the same series, but we want
to set a precedence for future devices to use fallback compatibles
now that path works.

Jonathan

> 
> I hope this is good enough. I couldn't find anything more convincing.
> 
> >   
> >> 
> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> >> ---
> >>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> index f6e22dc9814a..6003da66a7e6 100644
> >> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> @@ -19,6 +19,7 @@ allOf:
> >>  properties:
> >>    compatible:
> >>      enum:
> >> +      - sensortek,stk3013
> >>        - sensortek,stk3310
> >>        - sensortek,stk3311
> >>        - sensortek,stk3335  


