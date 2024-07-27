Return-Path: <linux-iio+bounces-7982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2193DFE7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4CB1F21B98
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A018132E;
	Sat, 27 Jul 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGVvsfQK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6C1741D9;
	Sat, 27 Jul 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722093052; cv=none; b=sO9lzIUIrT+wo4tLkLSuKfXMQnVMJEQCY2miivobTCv5J1dNaBx3qhx5Nz9zUVer2GCig9Bi84lLkwopPD8wJY2/CatyB0VR1EwKta/+zIHOv8T3qNz7gC9ed0E80NSRuBIjd5VapW+6yTiplMZj6LtJrnAs0uF4qfgJDLGZGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722093052; c=relaxed/simple;
	bh=7mts/eMFhwQuLK44GnWhdhfkk0mKpYxPPMqwbdP86xY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7UthEAfiEqYiN0V4kSZKkAcMrTTLmUjZZ2KwYxYqqoAzlK9EW0xYYTxLHZTlLkZIV4pmH/XCCJW03xmRQQfRTIZPC34RsBBBQ4+MpwQwCjQNFTr2cJCeUlaRI/q7NRzXT53Na1eRnz22I/hhZx8BZDJ3iqWYSyS/0XBiSnWUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGVvsfQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036EBC32781;
	Sat, 27 Jul 2024 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722093051;
	bh=7mts/eMFhwQuLK44GnWhdhfkk0mKpYxPPMqwbdP86xY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sGVvsfQKoLRxz/Pqd/sd5Czy7Tr3LuM9cORRuIfYivLMe8hCl5SJ+0AVca1Gwfxvz
	 UeHFZYrXZZeWNGr58RX8ZomuQsDSstEZsk6qMWNTdRWMzbx2fEiTSmniyJ6CJpJp4Z
	 H42DELSnUibpt6z9+BXuWe4522PcYN+WyhtLOMeDkuYr/fAg9mr9RYMuiHOYFL5EBr
	 if+tsEXevPI0gN8K+x0JRe8/WI7+VTOwZyB80i3jUvJS1V6xMMgl4zIlJxdYuGvL5C
	 jGvxvnyD7Uhp00lO4Fn9eus4NCSwBm5PfQDrzkxYgbmRucGqQ+70D8ZPUpo9dATDN0
	 996TW37ZMXlew==
Date: Sat, 27 Jul 2024 16:10:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 linux-iio@vger.kernel.org, Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad7192: Fix 'single-channel'
 constraints
Message-ID: <20240727161042.3a19a105@jic23-huawei>
In-Reply-To: <172201986894.1860751.13842106591481858905.robh@kernel.org>
References: <20240723230904.1299744-1-robh@kernel.org>
	<172201986894.1860751.13842106591481858905.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 13:52:58 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Tue, 23 Jul 2024 18:09:03 -0500, Rob Herring (Arm) wrote:
> > The 'single-channel' property is an uint32, not an array, so 'items' is
> > an incorrect constraint. This didn't matter until dtschema recently
> > changed how properties are decoded. This results in this warning:
> > 
> > Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dtb: adc@0: \
> >   channel@1:single-channel: 1 is not of type 'array'
> > 
> > Fixes: caf7b7632b8d ("dt-bindings: iio: adc: ad7192: Add AD7194 support")
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >   
> 
> I have other fixes for rc1 already, so I've applied this one.
> 
> Rob

Cool
For the record (no need to add to patch!)
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

