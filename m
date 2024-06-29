Return-Path: <linux-iio+bounces-7052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2E091CE7F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AA11F21D79
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AF132101;
	Sat, 29 Jun 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg5RChyH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D827456;
	Sat, 29 Jun 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719684496; cv=none; b=kHi+PGasqa1Dki0muwsxZUQTss534BQeKtUuUr49FnMfmxRaIgqulS/UuoqYaj33dV8PDnqnfPW6iNoEX3ypD0m2um8Ms1MCKK8sRZaRUAX1TfnGXgNTGNZTiTbIqcjv8O1QvvCkf9qB9R4sSbDm2Zp7Pmmm7trvRCZifmwZZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719684496; c=relaxed/simple;
	bh=0ljs0rXImWw/M8gBi4V2AHUkfLRew3MstanE8aLR9L4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyJcWXDzMAFIML+tSeWzPNBwLZxMA9O3H/AmtmKls4PVfVaHS/SJ9jhMpotEtGWza8wt01odyOxoRDO/oBfl4GW4jWRxzjE79dKIjoGGVZ3sk089n8tYQ5RKSlgIclkHJ1YjhHOEnhCoe3WSYMiFlgmnsY5OctDPYW8J053mczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg5RChyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4947C2BBFC;
	Sat, 29 Jun 2024 18:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719684496;
	bh=0ljs0rXImWw/M8gBi4V2AHUkfLRew3MstanE8aLR9L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cg5RChyHGBbLU+0c4I6XHWLUC3F6wPGvHA6qawAFwdBs8bG/8oTf9JId/9RKGTl2w
	 7NA9PVLwEz36EuFbRsBZgvSGRqD9XrhK4yRzTF0BCJwECow9Rdm+687Cun9SQbRk4o
	 18Gbcteb1aDschTDV6MCLgHoCcRoZamT0PojXuYwe5R1qPGM9Fk5l/Kk4IYZqwKuol
	 3iauaKXZXLWUuDqM0OcqUU2rOZfzmrmHURgrRe584TDcKX8bKSXTgR3JIeYt6tJkVm
	 GOo4RliTZFfzfIUGOHY3YLDN/FuU+CvVo7YW67TyG3bsTWwzcWryQhcOP2AlJIndFa
	 6Mm52byLpS1BQ==
Date: Sat, 29 Jun 2024 19:08:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Message-ID: <20240629190808.39178cd2@jic23-huawei>
In-Reply-To: <20240626-junior-tag-cd3e27c4b140@spud>
References: <20240625165122.231182-1-kauschluss@disroot.org>
	<20240625165122.231182-2-kauschluss@disroot.org>
	<20240626-junior-tag-cd3e27c4b140@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 17:06:48 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jun 25, 2024 at 10:21:06PM +0530, Kaustabh Chakraborty wrote:
> > Add the compatible string of stk3013 to the existing list.
> > 
> > Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> > ---
> >  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > index f6e22dc9814a..6003da66a7e6 100644
> > --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > @@ -19,6 +19,7 @@ allOf:
> >  properties:
> >    compatible:
> >      enum:
> > +      - sensortek,stk3013  
> 
> The driver change suggests that this device is compatible with the
> existing sensors.
> Jonathan, could we relax the warning during init
> 	ret = stk3310_check_chip_id(chipid);
> 	if (ret < 0)
> 		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
> and allow fallback compatibles here please?

Yes. Please do. This dates back to when my understanding on what
counted as fallback compatible and we are fixing that in drivers
as we touch them to add new parts.


> 
> >        - sensortek,stk3310
> >        - sensortek,stk3311
> >        - sensortek,stk3335
> > -- 
> > 2.45.2
> >   


