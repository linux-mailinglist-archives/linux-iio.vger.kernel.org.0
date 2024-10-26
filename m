Return-Path: <linux-iio+bounces-11308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CFC9B172D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61522846DB
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029751D1F70;
	Sat, 26 Oct 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8ZPt9CZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32618800D;
	Sat, 26 Oct 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729939589; cv=none; b=kGI0XW+57cGdebc9NpR20NKZ3aaVgWsh6qGFJ7oTufT46CaM5vbGl0gr5GYNUts8sp1BEgreJddshf9jtsNVnEEBPSzN3BWhQ3i8RQowqYOw0mvHmLV4JpJRCfTGBAu8Io9XbY6lHr0fJ5M5Xvl7QgAFvTteA8hWLEVOmVsn4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729939589; c=relaxed/simple;
	bh=mqkiXrE+2VKtYMF3SragPuOpt4qdlaPZaeC4+8lAmYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJigndhxRoRjgq61HR8ZnhLQWQ0GRH/2Nvd6EhFv5gM75lJ9G843VtByFSnHhhFV7ixOYVIK0nGNu0lMWkkda/btFtdy5138PwgR4GHYVwaoDSKShEkNWIuCCRq9NWMPKm6W18Jxuil4XwlnwZayQLNXBMEiYIALnBCxDdc2Prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8ZPt9CZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767A2C4CEC6;
	Sat, 26 Oct 2024 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729939589;
	bh=mqkiXrE+2VKtYMF3SragPuOpt4qdlaPZaeC4+8lAmYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8ZPt9CZD2S4csEkuu14BI2alkpcwc+VyaE0pjkfAEAzrzYL+zkaaGq7gkbPvDtOE
	 bETy6UYP13RHCcHFjX+J3Ma8FoweJlZa2IEDpeg+n+DTCK+ClE8Cjz6Pw2wDcSMRQc
	 +rlgGhJS8VBAwVSbMRAgihIo/PBsXT8gBKWdS7nC7m/t/EgJmqjzvOCwfR/M7zfgLN
	 TN08SDjZYLnavR9vXP3KmePwd+XzfUJL8pfrYWbEXvsTOlZHFhZjo/uQbbOQyHX+Rt
	 hF+40AyAQzt8L6B4u9WsYjL8wU3+oZnCbJJMdWC89LnKA4UxUAUdYSmU4jpeXAA9ZC
	 2GlrJrNYr9Xew==
Date: Sat, 26 Oct 2024 11:46:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com,
 conor.dooley@microchip.com
Subject: Re: [PATCH v2 0/5] iio: adc: ad7606: add support for AD760{7,8,9}
 parts
Message-ID: <20241026114621.01991ae5@jic23-huawei>
In-Reply-To: <127a3066-1ee0-43ca-8214-05c9409e0138@baylibre.com>
References: <20241025095939.271811-1-aardelean@baylibre.com>
	<127a3066-1ee0-43ca-8214-05c9409e0138@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 10:13:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/25/24 4:59 AM, Alexandru Ardelean wrote:
> > This change-set adds support for AD7607, AD7608 and AD7609.
> > These parts are simpler parts for the AD7606x family. They support only
> > HW-only mode like AD7605, but they support oversampling like the other
> > AD7606x parts.
> >   
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied to the togreg branch of iio.git and pushed out as testing initially for
all the normal reasons.

Thanks,

Jonathan

