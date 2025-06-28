Return-Path: <linux-iio+bounces-21041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A6CAEC848
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35AB1898C85
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92892192F9;
	Sat, 28 Jun 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlGpa1Th"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D61E0B91;
	Sat, 28 Jun 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124560; cv=none; b=FiUkBYlaWrle2GxrNpuH7GzXs/Ki8/WENjmimQYtmBs4Mr3vaZcLqYMkj4eK3mhbEi/Mbyb1aNFOEzgg+YEfmksQAC/UP+m3QUDExLzUMSENAwVsC0CmufucLoX+ooThQWntxhZyK6N6QzNUVoTBh4LJ83jILAhgcYcXxxWrjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124560; c=relaxed/simple;
	bh=S7skJZrJtN6IdApQAoJaXlS5QjuMn8o+4whvVcO3QGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVtENlo4Vr9QCyPDw48/VjXtisr/9KF63Qr7z2eyEph3oOx5UQxC3wDSJhLlNJi03aCK01m8JDvJmG0Qj4bEPM5Fgagk8ZhMXusvno79aRsd7qPhKj7BVgrYxa3I7fOF4lu2FcZdxRzJ0qv8nUOtrmwm8EE9+aA3fWTlkVL3vrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlGpa1Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B331C4CEEA;
	Sat, 28 Jun 2025 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751124559;
	bh=S7skJZrJtN6IdApQAoJaXlS5QjuMn8o+4whvVcO3QGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rlGpa1ThDqni1GnKpoXkqEf4HiaRNndARCXKzTYFCKbHZCdlP8cDCFH5NqqX+AHnm
	 techoQwJ+74TfMcr9vwMaPPt0zXrFF06Zai55VRtxWcs30EmUI0YdJ/3bIINHnj2bd
	 xc7mJPu31P0CpKiycRebAqj2XpLqHK+LkXneLcJ0UbpVjuud4iO6PAgs05W4FEvOvM
	 NCMLrN4Cpv1JhsOQmkfKau15BYN38ZIBe/PnBhBXlhLQ7Cx9hs33chOl2r+jg23MY9
	 FLKmwwO5s9tGykhPxYFBFF+f3woLvBU/Zf8eWk4+rAbeJ/9ancW3ezl9oBA8VqQrUR
	 8tIz4wDbwRAjA==
Date: Sat, 28 Jun 2025 16:29:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sukrut Bellary
 <sbellary@baylibre.com>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
Message-ID: <20250628162910.1256b220@jic23-huawei>
In-Reply-To: <4d01de83-7b85-4127-960d-0563359a0844@baylibre.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
	<20250625170218.545654-2-l.rubusch@gmail.com>
	<8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com>
	<20250626192802.0079d579@jic23-huawei>
	<CAFXKEHZ8zDEXLT57BD5Dg1mTN-Gj0Z7uhxX5Xx=XH0wFeAhe6g@mail.gmail.com>
	<4d01de83-7b85-4127-960d-0563359a0844@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 11:27:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/26/25 4:33 PM, Lothar Rubusch wrote:
> > Hi guys,
> >   
> 
> ...
> 
> > Perhaps just one little question here to you. You used the regulator
> > name "vdd" where others
> > before used "vref". At the end, this seems to be pretty free,
> > depending on how it is set in the
> > DT or how you name it in the DT (in my case it was "5v0", but I wanted
> > to keep the convention,
> > if so).
> > 
> > So, my question is, is there a naming convention what to take for a,
> > say, default
> > regulator naming or fixed 5V regulator?
> >   
> 
> I don't think there is a naming convention for supplies other than making
> it match the pin name from the datasheet.
> 
> If we were to try to come up with some standard naming convention though,
> I would not include the voltage value in the name. Rather, the properties
> should be named after the function that it does, like vref-supply for an
> external reference voltage, vio-supply for I/O pin voltage supply,
> power-supply for a whole-chip or main supply, analog-supply and digital-supply
> for chips that don't have a whole-chip supply but rather split the
> analog and digital circuitry. These are the most common ones that I have
> seen on ADCs.
> 
> The fact that the TI chips in this driver use "vref-supply" doesn't really
> make sense in the DT bindings. V_REF is an internal signal in the ADC.
> In other words, it's kind of abusing the binding to specify the reference
> voltage without actually saying that the chip also has power supplies.
> 
> Chips like adc128s052 should really have va-supply for the power supply
> connected to the V_A pin that also serves as the reference voltage and
> vd-supply for the supply connected to the V_D pin for the digital I/O
> supply. And adc121s021 would only have va-supply because there is no
> separate V_D pin for a separate I/O supply.
> 
> But there are lot's of ADCs already incorrectly using vref-supply like
> this, so not sure if it is worth trying to fix them or not. But if we
> wanted to fix it for these TI chips, I would suggest to deprecate the
> vref-supply and add the actual supplies to the DT bindings and implement
> a fallback in the driver to check for vref-supply if the other supplies
> are not given so that we don't break existing dtbs.

Agreed. vref-supply should only be used if it's an external pin labeled
vref.  (which is fairly common).  Where it's labeled V_A like here we
should name it after that.  Fix would be as you suggest with the fallback
to cover DT bindings in use.

Jonathan



