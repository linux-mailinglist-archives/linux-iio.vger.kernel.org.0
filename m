Return-Path: <linux-iio+bounces-24309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F78B8C5A7
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 12:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DAA1BC47DB
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0192F5A1B;
	Sat, 20 Sep 2025 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8HztFD7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BD1EDA0F;
	Sat, 20 Sep 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758364576; cv=none; b=hS7ROx/RhVgJj3VTWDyR8ZN1jRbphiYshwCqgNnZN7TiCHzaOO1aC7/wXWFJsThlTG1x6RiflszVAwIKYq+ouKZkq4EBbM2pAu0Z4EIY0aixkOOaPuXazTMMjdRk+bzb1hXUVf8IXQUMA+IX1AITr4PsVnq/y+oEdIQ+qYIjlBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758364576; c=relaxed/simple;
	bh=B9MbXqYa6HGC9wBLtN6HQbq+MYDUhVblKq9WsO5oNRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBbOuswhu7zWDy0hsyBf9Pax1cTBM5pEfYkkSV5Eb1sQd9jHIGAx1AMl/jC/ajpXOjplnPVg9cdzeBu/k9ejp9UbFRhua4UFbl9O9Qvu48zQYoEvBSDFxDguL8+jKxtESbr/8XecS+bDAcU1SxP4mRz2AFZ8ldEzxF+45KGMAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8HztFD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2DEC4CEEB;
	Sat, 20 Sep 2025 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758364576;
	bh=B9MbXqYa6HGC9wBLtN6HQbq+MYDUhVblKq9WsO5oNRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8HztFD7km48qKM5eRIpw++ODjFiSJaph4Iiy6PpxRhz4WyJgEfDk53tCuxkCee4N
	 JFoNa8sL7FjivXtf0HKuo7u07kvP1TpDN4+RFXdGJ7LEVpLO0LtJxobVWZbGUHg4oq
	 v8T5a1GqlH/YPo5kCu4/wIYg/vMqiKwdwUVwykjvO3WanE8c2/puxSczkBg4/BHff8
	 wmPe8E7nmVO8a+OCC8IFjPrwy4EOLepcq345OTZD5d8FMULGrm/MBeM20BwRh+49sd
	 iZkcsQ5weKnX+WCzrOl/uSv+A7oaB6V/NpEw056yFhpNPWH/KBDdwrbyjjXURlKqY6
	 VHn0YOM9ogWWg==
Date: Sat, 20 Sep 2025 11:36:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/8] iio: adc: ad4030: Fix _scale value for
 common-mode channels
Message-ID: <20250920113605.3d309a6a@jic23-huawei>
In-Reply-To: <280f7145-8800-4f50-b316-3a604150a980@baylibre.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
	<b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
	<280f7145-8800-4f50-b316-3a604150a980@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 14:32:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/18/25 12:37 PM, Marcelo Schmitt wrote:
> > Previously, the driver always used the amount of precision bits of
> > differential input channels to provide the scale to mV. Though,
> > differential and common-mode voltage channels have different amount of
> > precision bits and the correct number of precision bits must be considered
> > to get to a proper mV scale factor for each one. Use channel specific
> > number of precision bits to provide the correct scale value for each
> > channel.
> > 
> > Fixes: de67f28abe58 ("iio: adc: ad4030: check scan_type for error")
> > Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

I'll queue this one up now, but not push the branch out yet as it will
make a mess of linux-next (due to ordering of trees).

Jonathan

