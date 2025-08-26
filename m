Return-Path: <linux-iio+bounces-23278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CB2B351D5
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 04:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D2E1B26E33
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 02:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85EB275B08;
	Tue, 26 Aug 2025 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOejUMsJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE1244691;
	Tue, 26 Aug 2025 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176152; cv=none; b=ryxyQIf12q3VdZ3VIARFTi8Ke1/HjK3nHJn/wx3SkoIipHcjex7wUr3m4WWIGLPLHgZ1U6ikGEQsGBVXrQHK0v6aLU2EN5pH35uQALCVqZEf78SQ/wJXiCTumzi3cxBE8n/kKWmUfn2N3mocAky5apmBfb534BR5nYdaycY7b6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176152; c=relaxed/simple;
	bh=zYkRdlO0U18XSPpspud7s26YJzfHgvzhI+jZoKSfTqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf7KFMIDGTjU3asiicro74QoMek8TgVBkRgcRXdJ3rBPXpwxn+fvQ9ZO2g7y7kkXXm7oEWhkCZAEUqYInOcQdT/SbEJeuXVav+z81LrXyKNUn1TntQfPllXEGBhyw2ti92AmpJfgWZua9sZP8yE9iqlTQ2n4Ry8ZMo45EjeC+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOejUMsJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-771e4378263so1353767b3a.0;
        Mon, 25 Aug 2025 19:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756176150; x=1756780950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xR6DYc89vuHriP+8uKQP0na1daOwB9mmorwHUhrAVP8=;
        b=gOejUMsJyMKqXvuTGFSsdqWcOKTX0TZwj0NBjIw1WPLYbAFSppL0P0HgaZfHNL74Lz
         CTjTILG9dCSMz6wUBx9BYYDjYXC3Ntk5YISmHac/P8ljRwyG94kG6WWZ8R+ksyqON8Qn
         eiT0sarR4q+jye0hLfa4DHkT5lAIk/MrQEbdZ3E6c87GQeJIWeIn+YNcjU5IOIjJjEri
         XSKhbzMWkyTWDP6aoJjNqa3YTt0VRZd+donYDZkIUzB7jn/e97ccnNcgWXbNtUYOGZna
         jdxG0abGcEbxVaeH26V37REiSxkDwTpQGXmEhz5KT5pxnjHsuTPRzEgZAGtSmPONAIfq
         Zv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756176150; x=1756780950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xR6DYc89vuHriP+8uKQP0na1daOwB9mmorwHUhrAVP8=;
        b=dpivTou03yXDgNeBOubbGcAOym/kump1ozWiHvNjdD2ZoSoB9gIdDHjjtn08PjDPHI
         0jTP5ZJWzr5+4nXhF/gQIeXD947WWHdsFxuBO3K+Glpkaoc2VKCO3B/mJLCsnvwgcRy5
         dKaxlNq9Vo34S1CxjAm/T4+gLCTO7XRjuBVtTaVl2LRblvMGjsX56OkUK+evyWH2ZeQv
         7O8spae+I/ZSynTf6x6CEWCcIAPB+bRO2pQRc/LrT2DhCXuGle5Hmq9ywpZaLrjdokjB
         oEiTU8ujrd1viaIepuy3Mcqm5/hUtImmhqDl8xgKswFUVST9Y2XUBCrGyiMQnlZ3HkQ4
         gbzw==
X-Forwarded-Encrypted: i=1; AJvYcCU28gm6N+4S7zMDbeKu3YVeRKF+Ajntaf1DGzZkBXsfaDC83OWCoCh1XVWVoWoXgf18BHIyRVnw6Bz1dtpagPvXEsQ=@vger.kernel.org, AJvYcCWsXCYp9wTG3BD/ESHpBTlYg+CsODvXW5kQYNmDCrmOWVhwm4MxGJzRZdYWEHNIit4/m+xZHl41fLE=@vger.kernel.org, AJvYcCXXlMQ+bnfgXD9rQZZzSjjKmQZXEaHRV2fUxPWzK03MWCwd1jYyVaVfBCOWT2hSPzjsCXSeYAqy0AzlHGk6@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLVOxsFC0+WmPfSnAIigQUIfi80Q/+rtWAbbSIoR8bATCkTzC
	3NjwSzZZOd5UtJRNU/4FdSutlVGxG8shiNeC+l6GQcY1dF376uAKTplP
X-Gm-Gg: ASbGncvfTmAFIJ4HxWr969I0F+8KdFvEvPNTWiSkFCZiBb7w6LgsDYv8lQkeQE26I2S
	2Cvxg5gP7FEpinj2iSRCHLHALepOf+u5/FJr3QY06w9jtRfHSMYKZyXo830+pJyjnAH2ZiAqzGB
	tR2GdYFEen0xWemubyIzjFbOjehYoHdFI2RIv0+g6LzvN0jkUsNw7PBKZT/88lUFsdA4acoQh65
	Ck8BzKahUSX68mBh5ktusIeSrdnGvqdQKHojouRhKlgJzLNBQt49JrDhSuQmcz1jPKnmF34pDmU
	JkSigTlKyoE8WCn8bp96gwBe12Qz6HDhyz+rblpHtCNag6PzfmxsS6rc8j/J4etgw1Ll8JwZ+Zo
	OdbXR+8bZUJ8uzbSxRB7zmRk=
X-Google-Smtp-Source: AGHT+IFpXXOz6jvKmc98oCi1NCiBQLg+bmp0DWJBuKZIBlouXbVcIiSBZxDk5lZs14cKqzF4SAkDxQ==
X-Received: by 2002:a05:6a20:258c:b0:23d:ded5:12b9 with SMTP id adf61e73a8af0-24340d91d6fmr19374286637.32.1756176150053;
        Mon, 25 Aug 2025 19:42:30 -0700 (PDT)
Received: from dixit ([2401:4900:1c42:3335:1f6f:7d68:6bb2:7634])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8b4b98sm7835430a12.19.2025.08.25.19.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:42:29 -0700 (PDT)
Date: Tue, 26 Aug 2025 08:12:11 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Haibo Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andreas Klinger <ak@it-klinger.de>, Crt Mori <cmo@melexis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/10] iio: Drop unnecessary -ENOMEM messages
Message-ID: <aK0fA4QnFKH5AQas@dixit>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
 <20250825093150.3ba23f2a@jic23-huawei>
 <20250825123919.3c228ef7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825123919.3c228ef7@jic23-huawei>

On Mon, Aug 25, 2025 at 12:39:19PM +0100, Jonathan Cameron wrote:
> On Mon, 25 Aug 2025 09:31:50 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 22 Aug 2025 09:19:48 +0530
> > Dixit Parmar <dixitparmar19@gmail.com> wrote:
> > 
> > > The drivers do not require their own error messages for error
> > > -ENOMEM, memory allocation failures. So remove the dev_err
> > > messages from the probe().
> > > With these patches, all the iio drivers now has uniform handling
> > > of the -ENOMEM while device_allocation and trigger_allocation
> > > calls.
> > > 
> > > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>  
> > Series looks fine to me, after the minor tweaks to commit messages
> > that Andy requested.  However as it touches a lot of drivers
> > I'd like to leave it on list a little longer.
> 
> I changed my mind after taking the dev_err_probe() series earlier.
> I'm rather too busy at the moment, so clearing this out now will reduce
> what I need to keep track of.
> 
> Fixed up the () that Andy asked for in commit messages and applied
> to the togreg branch of iio.git, pushed out initially as testing.
> 
> There is still the rest of the week (probably) in which I can add
> tags etc if anyone wants to give them before I push that out as
> a non rebasing tree.
> 
> Thanks,
> 
> Jonathan
Thanks Jonathan.

