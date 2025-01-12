Return-Path: <linux-iio+bounces-14203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD4A0A967
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144D3165E33
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF00A1B4157;
	Sun, 12 Jan 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Oe7h0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D4F224D7;
	Sun, 12 Jan 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736687076; cv=none; b=ot6sTzDPK23Tqmo36q9Ei8CFoOFWi33LvdcDrL9l0GLAsBaiyHUXK1eaJU2pohPpTM1gSOQ/PozD/MyvVErDlFzHFVkyxfOxTXztD4YIQ4iDUcjPiPII3/16Kzkzrjw69+BKlnHt4u624zwm9tQySl1QdWMYoFjYaNu+8KtWsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736687076; c=relaxed/simple;
	bh=5z7pUTVj8hCbgOiWle6Q+0t/vIfOR2hASvkUXFUt1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4+hFcxkkLKSi9He7Tqt6sDJ+QVNh/Cy6hZxzDOeDWn96Lrb47E1kCX0BzWwduIxmhYqL/u0kCGbutKFWR7MHVkuHeYswlNczXvTZg41n/uMagReBEW1zsXOpjigMCESLzUafsq2R98dBDjVsQNuSZXolNKShaigSfrlm2mS/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Oe7h0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A278C4CEDF;
	Sun, 12 Jan 2025 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736687075;
	bh=5z7pUTVj8hCbgOiWle6Q+0t/vIfOR2hASvkUXFUt1DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i8Oe7h0fyqP0hNqJn8ZtGt7GfKoMOO4OWQvAn2Kk4OBddA9KfyOPLL5kWR10MK6Mh
	 EOhV5iPVkfsu5v6oBUWYndyjgkhFbE30OSscsrqpNKDa1/qEAgwI4QwIJUeIu0CcXC
	 xGjel2KZqSkm4+6sJSoKh4lhJmgLI97toV8KELpOEEUKlgO7xcrKMLoNxRoCUrzNmb
	 8iETBSjFJwb/VqVk7aB5EKBFZZd2FWBdsFuglnLqBf/Ek4zKrn2Askvhi58KgWbztu
	 PqL8LSY1Inl0OB4WoFUcJSzQSt/pCfFLvTQ8HckWJQNwV+yddocy7fHp8LpD6QRep6
	 k/gWv4mW3/xdQ==
Date: Sun, 12 Jan 2025 13:04:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com, PopPaul2021
 <paul.pop@analog.com>
Subject: Re: [PATCH v1 15/15] iio: adc: ad7768-1: add filter type and
 decimation rate attributes
Message-ID: <20250112130426.29b660b1@jic23-huawei>
In-Reply-To: <5d492f38-b103-4850-8d13-ef1fd1d2c483@baylibre.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<b88a167234c49a66792c0d3e182bb40b5b695b5c.1736201898.git.Jonathan.Santos@analog.com>
	<5d492f38-b103-4850-8d13-ef1fd1d2c483@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 17:50:56 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/7/25 9:27 AM, Jonathan Santos wrote:
> > Separate filter type and decimation rate from the sampling frequency
> > attribute. The new filter type attribute enables SINC3 and WIDEBAND
> > filters, which were previously unavailable.  
> 
> See related comments in my reply to the documentation patches about wideband vs.
> FIR and decimation rate vs. -3dB cutoff.
> 
> > 
> > Previously, combining decimation and MCLK divider in the sampling
> > frequency obscured performance trade-offs. Lower MCLK divider
> > settings increase power usage, while lower decimation rates reduce
> > precision by decreasing averaging. By creating a decimation attribute,
> > users gain finer control over performance.  
> 
> It seems like we would also want a power_mode attribute. We already have an
> attribute for this for used by accelerometers so there is some precedent for
> such an attribute.

I'm not sure that attribute was ever a good idea :(
So would prefer we don't use it again unless we are really really stuck.

Usual assumption tends to be if anyone wants to reduce power they
should be able to do so with other controls (i.e. reduce sampling rate or
oversampling). Those are easier to interpret than magic low power mode
attributes.

Jonathan


> 
> > 
> > The addition of those attributes allows a wider range of sampling
> > frequencies and more access to the device features.  
> 
> 


