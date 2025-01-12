Return-Path: <linux-iio+bounces-14163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD1A0A86A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DFA3A4D42
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8E1A9B32;
	Sun, 12 Jan 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHQ2fjPI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A471A840D;
	Sun, 12 Jan 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736679162; cv=none; b=YXReRZGu5Y57tzSGD4sFL5W66rvdhJdjtG5fzYeG57sEokmTPQdYp7nHBP9k5tF7g2aWi8SRWrN6RRH0dJKBy/B/YDKhdciPTiPWoWvWEL2vdXHs7WjZ5njM9Lp0ldtJWHUKH8sOQ7lvUGN/a0tDMTbtJBPZnN5fEXn6CUZxEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736679162; c=relaxed/simple;
	bh=4lumjgvM5AAraEfMIkVeS5ZInuXs+iJJJx+hp9QLicE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqrvA1xJChIeXYKSnPDl8WOz29EdW1X8VICcd/71we0a21uz/24H2D+4aBfV+x/Vfql0jYPxx1PxaEIT5uWV+UgrRdNF8z3z++6iDD0ixJKjMRnlGfHMvwZX7sccfCS9SA/80bnogj5a8h/WCRaxfbMJOnN3otZdN8daBjRPVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHQ2fjPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09428C4CEDF;
	Sun, 12 Jan 2025 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736679161;
	bh=4lumjgvM5AAraEfMIkVeS5ZInuXs+iJJJx+hp9QLicE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EHQ2fjPI+rBK+K2ba7FZIV4sCDx+U32uuGBgcu2CtRQFCNn26zUbfweDeScDiTg0I
	 Psff7XDbek2v5KtX2yJ6v8/0JDHu59CW6infNvchrYyJtet0TK2Po23+ArM64zGVIL
	 QDckPD3awcdZpVvphhiTHKgUmLvwynYzJhwtAMvCmcLAljA4JCN6oc+1gqhyiu9Rf/
	 BiWZ0R13mmAh42XDMZY6hao6lQnrZOtPB3uWlJUDaulpweREmsBo1mGq7E3gC/RNsj
	 ct9lODAvrcoLjhuJHysVvORTJXenOsyDUneKWHfoQJogIad1tBEuDrJxXqVqL69Bx/
	 m0PJCZjgMpfoQ==
Date: Sun, 12 Jan 2025 10:52:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: accel: mc3230: add mc3510c support
Message-ID: <20250112105233.283f3d49@jic23-huawei>
In-Reply-To: <8d5a2647-a130-4d99-a3e1-3abd1d336bbb@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
	<20250111-mainlining-mc3510c-v1-3-57be503addf8@gmail.com>
	<8d5a2647-a130-4d99-a3e1-3abd1d336bbb@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 01:04:34 +0200
Markuss Broks <markuss.broks@gmail.com> wrote:

> On 1/11/25 10:11 PM, Vasiliy Doylov via B4 Relay wrote:
> > From: Vasiliy Doylov <nekodevelopper@gmail.com>
> >
> > This commit integrates support for the mc3510c into the mc3230 driver.
> >
> > Tested on Huawei MediaPad T3 10 (huawei-agassi)
> >
> > Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> > ---
> >   drivers/iio/accel/mc3230.c | 55 ++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 44 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> > index 3cad6f2d7a2a79df38f90e5656763f6ed019a920..ebbb96c658d87a83007c7c3c7212ce9ebf039963 100644
> > --- a/drivers/iio/accel/mc3230.c
> > +++ b/drivers/iio/accel/mc3230.c
> > @@ -22,20 +22,41 @@
> >   #define MC3230_MODE_OPCON_STANDBY	0x03
> >   
> >   #define MC3230_REG_CHIP_ID		0x18
> > -#define MC3230_CHIP_ID			0x01
> > -
> >   #define MC3230_REG_PRODUCT_CODE		0x3b
> > -#define MC3230_PRODUCT_CODE		0x19
> >   
> >   /*
> >    * The accelerometer has one measurement range:
> >    *
> >    * -1.5g - +1.5g (8-bit, signed)
> >    *
> > - * scale = (1.5 + 1.5) * 9.81 / (2^8 - 1)	= 0.115411765
> >    */
> >   
> > -static const int mc3230_nscale = 115411765;
> > +enum mc3xxx_chips {
> > +	MC3230,
> > +	MC3510C,
> > +};
> > +
> > +struct mc3xxx_chip_info {
> > +	const char *name;
> > +	const u8 chip_id;
> > +	const u8 product_code;
> > +	const int scale;
> > +};  
> The struct members are usually ordered alphabetically. Also, const 
> specifiers for u8s and int are redundant, you will only want it for the 
> pointer, usually.

No they are not usually ordered alphabetically (in kernel code anyway)
Much more important characteristics apply when choosing structure ordering.

1) Comprehensibility - keep related items next to each other.
2) Slight potential performance benefit from frequently accessed items as first entry.
3) Padding concerns.  pahole will help but generally it is easy to work out
   from first principles.

In that order.   Sure you can do alphabetical if none of the above apply, but
it is far from a critical factor.

Const specifiers here are harmless as anotation but not necessary as you say.

Jonathan

