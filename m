Return-Path: <linux-iio+bounces-7797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99F939470
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 21:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC0A281C33
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB8B171082;
	Mon, 22 Jul 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd83hdB2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAE16EBFA;
	Mon, 22 Jul 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677620; cv=none; b=N9sWvMDtUQidPcaQaK3SwNwXE97iRCgvwJYmfw6G86DvuGEcqVmmiKmYwWXa0FGfbKcJeoGspwO2InN9EmEw88aFnVBnLW1eOCn6eGT4la2NfC1pdRrVhAtyXGrZN5Hga84EtqUUz/3R99Jvp9G3opEqcbOUv+LOvtx8nkugoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677620; c=relaxed/simple;
	bh=Yqr65baffeYIvUVssQtUM7odRlyEeXYOvsvX1kvcm1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbkeAdaKyv30Ea1jx4XtoRxVw44NcA6uAOLt9r4dbUJst+aWTXbE+MX5KYbvS7B3iSjNJ0+GUWuvxmu00B7tatEmcm8ommIF3xNW1souqQP6Hwiauw5yGZuGtAAnF/CiX2DFG2PgNz/HMhUX4QiRpnFbyqRUBlC4Um0b4JXKJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd83hdB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5253C116B1;
	Mon, 22 Jul 2024 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721677619;
	bh=Yqr65baffeYIvUVssQtUM7odRlyEeXYOvsvX1kvcm1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dd83hdB26a3DD5IJkUyt8PjfiY7X/lmGj881c19qu6UVA/nZM+B30zAIhwqojqTNC
	 5XKhPobhkPTOOggGEXUgZEOv9DAckGWJ9MQG7Kdce4Iw2xaDUX5W9yVX0r4rK5a/x6
	 99yFuHqGGK3/Xry+X68ZVWBhIVxoWgIIAxDiq/9lu8Zrwftey9ypNNRF5Sg50GcNsu
	 MHDoWONpf7XV371n8deKanM2Goe0wTFu1okR/3VLZeuduOxPtPsbDGNVYbY0FyaLu6
	 WCJn4459wQaTInng3zqoeCa/An0E13/8o5BI6zQDo7iKZVGioEAe1Xev9h6agCOJDO
	 D95+mZgHVGQKg==
Date: Mon, 22 Jul 2024 20:46:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: iio: adc: ad7192: Add clock
 provider
Message-ID: <20240722204650.25d8ab63@jic23-huawei>
In-Reply-To: <8b616aec-06ce-462c-9161-1c05adcd1069@gmail.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
	<20240717212535.8348-4-alisa.roman@analog.com>
	<20240718-revisable-penpal-bc06ff6366ab@spud>
	<20240720144257.200b4511@jic23-huawei>
	<8b616aec-06ce-462c-9161-1c05adcd1069@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jul 2024 16:35:14 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Thank you for suggesting and taking care of the tweaks!
> 
> I just wanted to point out that some little stray changes found their way into this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=42991c882f7f264ff8533c289edd015bbc0bc5a7

oops.  Messed up rebase mess.  Anyhow, should now be fixed.
Thanks!

Jonathan

> 
> Kind regards,
> Alisa-Dariana Roman.
> 


