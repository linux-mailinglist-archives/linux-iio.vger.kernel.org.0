Return-Path: <linux-iio+bounces-23163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00DB32648
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 03:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B50A1B61F9F
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569871C84B2;
	Sat, 23 Aug 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmcHuJ7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEDCAD4B
	for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755913795; cv=none; b=IQ0wycibJnNfqDaq7Sd9kKikFXmo21BpaDbIxrVC2bbviZcVu10KEVPicA6gn+9ZZRITI/wt8Yaic9qDDhQKz65pYc8UUKjNbAvxQSa5GgR5T+w1ZUSbd+jGbskDOZu5COeQvkuqX0BXTaaHFGYlwAFoLVTOR4/Ff0da2Xh8vNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755913795; c=relaxed/simple;
	bh=wYteqE0aKnD426DWmNaWKQfe9QGYxEItZXnrQs8i6jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2+CBKSo78pdtZY3XzItiYoQ/NTXNYEvZaAKdFeyeg+0u+j0Tnp0v9DhjD95QsognNf7eyXwjGHc5odBHXQndPCKe7kv05b6nhOJTlD4/YhOn5KIJklR2Hu9EEuvDW5ZGM6AyArywFEAdYWC0BpntA4tCbtLEVnz/PnRJwku9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmcHuJ7s reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244582738b5so23179705ad.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2025 18:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755913793; x=1756518593;
        h=list-id:precedence:dkim-signature:in-reply-to
         :content-transfer-encoding:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipPc4V15HDdiIPDzQvJpe9DKR7y7xzPkKym2S+s13kw=;
        b=gDYqpdlUx2lD6GlL2kG0oPvaDUzeOovo5y718u+ADfPQBxzokwMWse+/7CCpBdzOVk
         6d+VCHse0adWueplwD9bmaYZ5u5pOn3ihjDs5VxL4kk2v/Yb4Bi67LMbXNNcjbu2bFXc
         tUuScH9SkbghUQw2z8psYbJpSC4tF4qx0iPurPiImgss57ew2zrhNqU6g5UOGiU+Wk4S
         g2UKFSRt6K41OM44k5Atj4wYAK6Y5qJ8n8TIdS/Q8gqLNmDoFPR9geTbOVGON1CJKX12
         gBTb6geUAWNZwzC2D85atOptTMMViLW9hGrZEm61HpoitHhWnhy0nOQaBvsmoQxNF/7P
         KM7w==
X-Forwarded-Encrypted: i=1; AJvYcCXn7jhLW6N9uElDOehQ+2eu0riBgiwTR0HVpSuXUpwZmWhjN55DWNcUewk4AGj4fmu9VS6i+0iqOj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuhHdFAwee7r1Q4R0z9z6vlkEYixI87fxXLXM3/J9n7qys6Io
	0jGf8R591fM33tyLukHo+y+bgJUtq6T3WJDnbgsm6IifsgZD3dMXvDjOSQpqmUNX
X-Gm-Gg: ASbGncsvx4MvKxyVMZW134NTh9L3xQcCb9o6cuzeYg+5blyjyYHeE4BfUeiENAeDz5M
	qm6W9A/KLv56eO1wFhoe6MkdbrxeKqBFwV9QJpQ84rfmxhbrGTES/y3UR1ZygnXCtM6K5b7jZ1V
	CL+fMSB6U4e7sjHNQIaphEIWGsfZKIxFyazs75nXGWMV2sayQohbRL3Hn0VlSBCWmZMsvsffeX8
	lH7hsgkL5blV/UjTLujNEw9m9AY2aBq4ceeXZEuMBP/GAote6GHSdrlUQex0WAbXF/Q1WCGUfJt
	yyHbdgc/Y9K+GtKNoHF7xtNx8oOT08oDXXs1CSQE3y2RG5/f5G8TEbxVzGVfxzp/1wiPXHTeLaQ
	pUZb6XkSRvv75Dfn+xxdBKrzWKR3iYA==
X-Google-Smtp-Source: AGHT+IFIrj4d9QviDIppwbw9T9KU4pJkGlbXnigVQZMc+JA4IhVp12lKiEt46pmG8jyd9ZgMxDREqQ==
X-Received: by 2002:a17:903:3850:b0:234:a734:4ab1 with SMTP id d9443c01a7336-2462edecb80mr62579895ad.3.1755913792569;
        Fri, 22 Aug 2025 18:49:52 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7703ffebd33sm1129655b3a.29.2025.08.22.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 18:49:51 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:50:12 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	linux-iio <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, marilene.agarcia@gmail.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v9 2/2] iio: adc: max14001: New driver
Message-ID: <20230720192428.2faaaf68@jic23-huawei>
References: <20230710042723.46084-1-kimseer.paller@analog.com>
 <20230710042723.46084-2-kimseer.paller@analog.com>
 <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
 <11c30a02df784ca78be271fdf9190dad@analog.com>
 <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
 <fe0cd5348f864a6392a7e0e5ca93bec5@analog.com>
 <CAHp75VcpguSN9DkuCtpaB+_=sY7+Ot1MGPWToe-2pYjFXC9=4Q@mail.gmail.com>
 <20230716144223.0d9260d3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716144223.0d9260d3@jic23-huawei>
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18]) by
 smtp.lore.kernel.org (Postfix) with ESMTP id 39CA2EB64DA for
 <linux-iio@archiver.kernel.org>; Thu, 20 Jul 2023 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S231667AbjGTSYq (ORCPT <rfc822;linux-iio@archiver.kernel.org>); Thu, 20 Jul
 2023 14:24:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767A2D6D for
 <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 11:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange
 X25519 server-signature RSA-PSS (2048 bits)) (No client certificate
 requested) by dfw.source.kernel.org (Postfix) with ESMTPS id 7965D61BCD for
 <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 18:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E52EC433C8; Thu, 20
 Jul 2023 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689877474; bh=j6roh86w0wqMDaRHLfYK6RyFNcvUKUKczN6VMLN9uA4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KmcHuJ7sdwa0kFdc3KUH/f/VFrACU5123HkW99KiZYCrxof2niVHD3Gt5sUFxoI5l
 QWcPI0lzhVGefGSd7aG7xCh1pO7y7KYZBhVbNpsWuW78HSILof6yvHEvzFAIBrIV/s
 6yQdth8+l+QbrlXy0awDEfIJoEypc0MwRpE1CS5RPDcbxLb6kx3kvm+ZMtUipfEdHL
 AEZwr55iJ2oph39jUAui+rSWIdveSUoAOX0SlwfK5S2dBb2OSUNQbzfFOIR/Iak9kT
 Yk3hm7oNdna1jNXwl7hng1DRi496kQrN7l4JRPY+pNiodLZj4eAx2Y+WJI5nxXV5yh
 kJ4PdOEXilCyw==
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk

> On Sun, 16 Jul 2023 14:42:23 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 11 Jul 2023 12:08:04 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > 
> > > On Tue, Jul 11, 2023 at 9:55 AM Paller, Kim Seer
> > > <KimSeer.Paller@analog.com> wrote:  
> > > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > On Mon, Jul 10, 2023 at 11:17 AM Paller, Kim Seer
> > > > > <KimSeer.Paller@analog.com> wrote:    
> > > 
> > > ...
> > >   
> > > > > Hence instead of v10, reply with a draft of the comment in the code (I
> > > > > have asked before) that explains these bit twiddlers.    
> > > >
> > > > In patch v9, regarding with my bit arrangement comments, is it somewhat correct
> > > > or do I need to totally replace it?
> > > >
> > > > I am not yet familiar with the terminologies, so I hope you can provide some
> > > > suggestions and I'll definitely send the draft first.    
> > > 
> > > I'm not sure I understand what comments you are referring to.
> > > The v9 does not explain the algorithm clearly.
> > > 
> > > What you need is to cite or retell what the datasheet explains about
> > > bit ordering along with the proposed algo (in AN as far as I
> > > understood). Because I haven't got, why do you need to use be16 +
> > > bitrev if your data is le16 (and that's my understanding of the
> > > datasheet). Is it because of the answer from the device? I don't
> > > remember if it keep the bit order the same (i.e. D0...D9) as on the
> > > wire.
> > > 
> > > For the terminology, use what the datasheet and AN provide you. Also
> > > good to put those URLs to the code and datasheet as Datasheet: tag in
> > > the commit message.
> > >   
> > 
> > Absolutely agree.  The data format is weird enough we need the
> > info to be available for anyone who tries to work out what is going
> > on in the future.  This is a case where I'd rather see too much detail
> > in the comments than too little!
> > 
> > Jonathan
> 
> Note that I had applied (and forgotten I'd done so) this driver.
> Given the outstanding questions and a build issue with clang, I'm dropping
> it for now.  Hopefully that doesn't cause anyone too many problems (those
> based on my togreg branch which rarely rebases)

It feels like in a cartoon, when there's banana peel on the floor and somebody
comes and steps right into it. Oh my, hope at least the title of most
spectacular patch set fail of the year can be ours.

Jokes apart, what would be the best way to collaborate towards
providing/improving support for max14001? I suppose the only option left was to
apply something on top of Kim's patch set, but maybe Kim's work can be improved
with a few things from Marilene's set. Her device tree documentation is more
complete and follows datasheet nomenclature for voltage supplies. Her set also
uses newer regulator APIs and adds support for max14002.

Kim, would you mind if Marilene generates a v10 of your set with the suggested
improvements?

Besides that, I think Marilene has the evaluation board set up to do any
additional tests if needed. 

Let me know your thoughts.


Thanks,
Marcelo

