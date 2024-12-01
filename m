Return-Path: <linux-iio+bounces-12915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D029DF59E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2B5162A73
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D31C4A21;
	Sun,  1 Dec 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeOtXVn8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751B18A932;
	Sun,  1 Dec 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057826; cv=none; b=kCXpMHFZ3cbMkJvGUvYJuiQVrcZtDcRdSY+If3SVvd7W3mLZoVDR1yEg36NhNobpLzLMc93euDyZkVgS0Iq2tXdyadIYAQLCukl0Z2fu0T7w1t4ywMW4505hokyABnLic7559jR+AMShirGfnnff/sf2FWDu+IvBQ1m2lsnQFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057826; c=relaxed/simple;
	bh=8Qg+8F4qKFLuWjxUeaZr6aF++PUXiGiSZL/rEn0/KBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeWxHtBg7DvpvJ7Mrd50jpdCA55D3O8uy5oBQcXHdKfSzdk+BvILref57sSzL0mMliJ2fqG4+4ZXckRI50W0BEibP6jPBJVEsBNPwk/hbfVmKpseph5KK1Mn51mb59l4MSIM2+qNaEZuX10sJyG9cxphy5rb4AqUqpvVLs+nYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeOtXVn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DB4C4CECF;
	Sun,  1 Dec 2024 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733057826;
	bh=8Qg+8F4qKFLuWjxUeaZr6aF++PUXiGiSZL/rEn0/KBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QeOtXVn88wIP3f9OznjUAFM5GrgQEz6QNt5QeWtGd0xMuyPalXSIm9CutfxaiUORR
	 e77Asrsz5aLSJPl9TH5bnJ9q9UPYBi9dD6XJk2JiTTfHr07ENqgcltPS8xGp4ueDdv
	 g2YVk/IhEeETfQYQcCj6FuAPH/I3PHDsJetsNXWXY2mRDNBIFPxusvTfXmDtriE0xB
	 j48ODu4MUMUDHGqgrO/sp5HWUQAD6OaInaZPIoJ/UC5kVnIZHImmtwGJVlQkZQ1/4j
	 bKWREBOEw6YFQauPCgsF4SDxP4BnaoLNSiuIpV13yn2hd1oghPNTAb1LdP/uGjzGjZ
	 11GU0hQsZNnhQ==
Date: Sun, 1 Dec 2024 12:56:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
 <kernel@axis.com>
Subject: Re: [PATCH v8 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241201125656.731105d0@jic23-huawei>
In-Reply-To: <20241126155312.1660271-3-perdaniel.olsson@axis.com>
References: <20241126155312.1660271-1-perdaniel.olsson@axis.com>
	<20241126155312.1660271-3-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 16:53:12 +0100
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> 
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Forgot to say.  continuous is spelt continous in various places.
Please tidy that up as well for v9
Thanks,

Jonathan

