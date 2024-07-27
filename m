Return-Path: <linux-iio+bounces-7976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9B93DFA5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ED3281F95
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD96156657;
	Sat, 27 Jul 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBlFGSQ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09E4C9B;
	Sat, 27 Jul 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088820; cv=none; b=Ca3DDp+5/vaZMarmk3drGaX+PU/tnQuWMt6XPmXyLsZbp56YLoTJlHU3tPBx78OFEEHwRCsv3JN9wqwRfSDNb8TOTK1zMNo09hYdDbrqDeg0lbEFR2OS6ikWMT5e1k81KjKgDYojcB943VmsRxwzzU7Yw+v2nvwungGjLNYGHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088820; c=relaxed/simple;
	bh=kng2a24IIhui3ei3nXplkXa+REq/o4eUmggboW0tYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Udm39JXiAX60qnPxpwdMAlQQ/7ewATyToi2RLyJQP7RkNPSI9RF4q4re7nX6MWDeKaQl6Oc8SnHikPQikU+oopb50vouHKe4YVoM8DdshjUBk66sOJgRxUtNaKvtBO9JTU7+kLgD67JxuuohokRmkgpwJmGzYhXVmyiobSUsLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBlFGSQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDFEC32781;
	Sat, 27 Jul 2024 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722088819;
	bh=kng2a24IIhui3ei3nXplkXa+REq/o4eUmggboW0tYEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBlFGSQ0Gaa1m/TmqfRjy2wAhLODtlax6ymklp7wArD/kpJawijK7sklYdpIWNm37
	 UYzz5GLh9DoiGC+c4oWN+7ZpyZ8AlL/CnkUBQqpkM2zBPihdbAwjOAM6e+QmmV6uhx
	 aCQc/CcRY7OjkuZVRi9k95XMdDStH6l1l6vbh3WuhF4bsBDkW4GkAGG2Q+uRL4nh4A
	 AJ/eUPsrS6z0IrqK1HOA1I2SIbdk30kc4r9w+/2g7bTSD2JiBJLW9oaaNTjTaB5etP
	 wP/lihvLlAh+6EuLdcsY9b5wb7uAmlHrKMmZPrIYycaY78TBJO+h7aZUVNNYNKnVgY
	 cVZvW2rCntZyA==
Date: Sat, 27 Jul 2024 15:00:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>, Krzysztof
 Kozlowski <krzk@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
 "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lorenz
 Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>, "Frauendorf
 Ulrike (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai
 (ME-SE/PAE-A3)" <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Message-ID: <20240727150011.019344c6@jic23-huawei>
In-Reply-To: <20240724-ogle-equal-d14de4318080@spud>
References: <20240724125115.10110-1-Jianping.Shen@de.bosch.com>
	<20a8ad37-f6ce-4342-a2f7-bf3495dfeb69@kernel.org>
	<AM8PR10MB47219903C83BA4F0AFE2DAA3CDAA2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20240724-ogle-equal-d14de4318080@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 16:25:39 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jul 24, 2024 at 02:19:25PM +0000, Shen Jianping (ME-SE/EAD2) wrote:
> > Anyway, please send bindings with driver in the same patchset.
> >   
> > -> It's fine for us. Nevertheless according to the Devicetree (DT) binding submitting rules 1.1  
> > 
> > " The Documentation/ and include/dt-bindings/ portion of the patch should be a separate patch." See -> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> > 
> > Shall we still put the binding and driver in the same patch ?  
> 
> No, different patches please. Also, please fix your mail client so that
> it quotes emails properly.
To add a little more detail.
We are looking for a cover letter and a pair of patches.
1st adds the dt-binding docs.
2nd provides the driver.

The cover letter provides a brief summary of the whole series and provides
a convenient name for tracking it as a whole.

Take a look at how other recent driver addition patch series have been
broken up.

Jonathan

