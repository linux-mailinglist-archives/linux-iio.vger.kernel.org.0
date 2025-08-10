Return-Path: <linux-iio+bounces-22518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6298B1FB9D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340557ABB39
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE21DE4C4;
	Sun, 10 Aug 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENCkH2nv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FA42AB4
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754849484; cv=none; b=pd0SMQ8cvXd4tegmGngkr9nd6A+tSJXAK8zC5uEC6r06kx0E29WY7ZM/ErM25ApzkLQRWOd/gYak0ONRSBqN6RJIVFw8IPAP12iINkcQ61XOF8RrlhDlcUdbdg7/G6YSv11CZAQurnb5vbY7dz74cm7xJOUTQJ0n8aDOxFPlVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754849484; c=relaxed/simple;
	bh=EWQVnFYkmSir/fDr+0qAkKvu7pCW7H+tGEQTZF8GGGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJs6VZKQ3JC9NIp9nV/qU8yzMec8zO3Z1b+7Fhyal7DgecThGEUY6Lryrzcbg3XNIF86QkfkptQSOMyGC7h2EDkSS8RtwMmIID1Q1CqNTaxSY6RYReIfa+23ZVa6R6Bs2lERhp2UlAK4sTBoHfmBuUDT7Rtrjo7r1kRCV0W0yA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENCkH2nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE9CC4CEEB;
	Sun, 10 Aug 2025 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754849484;
	bh=EWQVnFYkmSir/fDr+0qAkKvu7pCW7H+tGEQTZF8GGGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ENCkH2nvZjWvAGSjew5AeYVccmgHd9teIwq9pvHuZIwrBgkpLNC6AQNjq29tdT+VU
	 ep+7KcOLHwWJADkkvTdbv+iwkMw4fOrvHQ3U6ZnInWkQ3jSZGZ7VS4V8kKsqsmV2A6
	 A00ZUyUSAEqgk8/t1QPF+lJERR5z+IP7DzMY/nHeLJ1Cg+Pn9Im73bYOdkAhbyrfsv
	 tKT1mW22qZYyaSs9/xxqAhLQ5QlFAvRvLlDBBztSxofEg3TdAQvNhs1Ay7IblWSwN4
	 qwg7U2V+N4ezPbwt3kM3nayW+iR4M/QdFzZWD1diNh7rB5Z8dDlngCAcNMwZNYXMxL
	 MnKZaOcBDv/EQ==
Date: Sun, 10 Aug 2025 19:11:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ASSI <Stromeko@nexgo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement
 sampling_frequency for BMx280
Message-ID: <20250810191117.37c26fa8@jic23-huawei>
In-Reply-To: <874iunknar.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
	<CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
	<874iunknar.fsf@Gerda.invalid>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Aug 2025 19:29:48 +0200
ASSI <Stromeko@nexgo.de> wrote:

> Andy Shevchenko writes:
> >> +       .sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */  
> >
> > Why is this comment repeated all over the code? Any justification why
> > it's so important, please?  
> 
> It's just a reminder that this value isn't actually used by the driver
> to do what it says in the datasheet, but instead for effecting the
> switching between MODE_FORCED and MODE_NORMAL.  If you'd really want to
> run the sensor with no standby between measurements there'd need to be
> an extra invalid value (like -1), that then would need to be guarded
> everywhere against getting used as an array index.
Call it BMP280_ODR_MODE_FORCED rather than making it 0HZ related?
Using the value 0 for the sysfs interface doesn't make much sense though.

Even if it is a pain to work out, we should estimate what it means to
use force mode wrt to how fast a single sample can be obtain.
It may be that is such that we don't bother with the other slow sampling
frequency modes if they are slower as they aren't useful vs only reading
when we want to.

Jonathan

> 
> 
> Regards,
> Achim.


