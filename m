Return-Path: <linux-iio+bounces-23164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB9AB3297E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABD23A2064
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F02E54C7;
	Sat, 23 Aug 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaWmatjq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2741953BB
	for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755962087; cv=none; b=jn0wfS3TFe2yCDAQ1n/rWkWsLmUi/+FNxNs5LAFRniEw/1Wy9V/Is+P+Eb/T93sMnChew/cdQn2l2BOivGayKGW5PSQ4eHD5BeDSJ27NT1ns+rzse73i+XHnGY4ztDL12tsMPt6EabbRoFzJCYVXE25xlqE8KKgmnTuuDyZ1880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755962087; c=relaxed/simple;
	bh=quy58oP9jH9MN6V2qaQGg1fHTvNOl1TXGQY3EyOuyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSJ3DjTHLEMTPrfOvvLm92ptPwJ3mAGSj/Fd5EBu8x8zrFr5pB5V7dsMVgy9iAcm6RVVzhBJHGCqpu56OxfAXpTiOUs28prG02dDFD7X3+bjAESKbSqsFjRJoh408HcO702+piNRb5Gyq3EAq+jWlemuoKvheVmL5iRj3uenQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaWmatjq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso180469b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755962085; x=1756566885; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s97a4+8orRT4LgsAxbeQIdXtKiASQ31ngHGoYVz3Q/I=;
        b=UaWmatjqRdexDulK7TQSirVdyxlw3j3UNFqi5NWCOuXkRyganIpXhuUHKsneagVIGo
         21RgK4I1VJe/+uBcJxBpwdjeCXKou6gFwlmnT91kei9vLesR8loLTfQ72NQ16PE3bQLC
         W21utSaINjmRRLMR7gJ++W0Em2RYABVnXGwCEThIv70sUddq8gDi0FoMqWh5CFx2ZDzY
         +ycgsEEvPkpTz/X+jyOp5xTeI0u1xLSVDHgfGvOg00IFKBJDTKhsOy/ezgRDO3dGQAFO
         aopkbXkdxihWMNmn3pKRSgLZMPHArvMfKpblssKpGBrohlFP7uMcsbtfnqH5CSYTNBKy
         r+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755962085; x=1756566885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s97a4+8orRT4LgsAxbeQIdXtKiASQ31ngHGoYVz3Q/I=;
        b=Va4R1x4kpqa7qMnI5BfV3qle2J6dRq90NLCW9wb+9NO5yvBeuAre8jwtzd1JVXOdPz
         F79EKrkZZ4gyMKLjAa04jeEWdRQgcxjV6EGxKQ5VfEFstehZGLdBo/hk2qjwugY+UEsA
         bh2D8wLDOQVNRsXOgCmExRzeDTADsDz82w2aOziHqpdzXTg74Ezc6r0mpR6omBv3QROi
         FQbA6TRu9IXPjscDgjkM3dnf0mH1pgm9YwRuZz3Bnb9GUTzktTZHqyob4x7fKfiDHm3R
         gFBeDuGoulTNEuhkF87gjO5zxE5ixOsLs01uvtGzOXGn7V+oL5hfN4gfrdMYG3XPQpuk
         mr8A==
X-Forwarded-Encrypted: i=1; AJvYcCWFMQGyqgeZG7O49ZoBpKQsM4lF8RnrEaB1BFny6KrR/2u61FZ8217qOQCt8D6ODRPmkJ0Jz3NIRbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkGEAYxl6JXBjBLYOh5B2NeTAH4kgH68U6T0qMjcGlTB3x3dN
	Dp8h1DGb9Shsy4CiO203R5gF14KoMswF1oWVN3EfRDUIT+GXnAW2gJL/
X-Gm-Gg: ASbGncu7t50Vl8HZSy5T2KfCKsAlWKQaSYC2APDyOr9cVov3PLuTZ4kLozaUwrcAjh6
	BXcdBVkGNv4g80m6+d4hj+Hy/NMQd8Xd1CH7i3nFbPOgZ2/zq5WbmvNWaEirqECMUkPhrA7MXDP
	IbXJqfOzFs0PMYRX8fb8wP+a8UG1VFmddVPb8Yvxi/WmwskHeboxaQddPiPteaEZ9IsvPGNXYS+
	T/yLiYQHIlUH5WJz2ZeyFNn4GsJsBvxb5YPttpwgaouavfZabXoOVu43JBZ1hhVNlJHXiKihPJU
	YB3vZn23fs6OTQXvacm+mYN2Hlp4Z8nAHL0y61lRwX1C4W+arFKA+vZlDxNPkYV9lGnlWEf5O0g
	1r1R3MG5qzyTtPtJLfw9G0YBBudSwWg==
X-Google-Smtp-Source: AGHT+IGCMHkC7oPd6dN0lv8M5BnhAIwj39d6zTy0nmvwFSpmW0s6Fg4XliRVjQN75EuHhzskB28Ntw==
X-Received: by 2002:a05:6a20:4325:b0:243:78a:8280 with SMTP id adf61e73a8af0-24340dbe648mr11149161637.56.1755962084908;
        Sat, 23 Aug 2025 08:14:44 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254a1e3ffdsm2628435a91.8.2025.08.23.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 08:14:43 -0700 (PDT)
Date: Sat, 23 Aug 2025 12:15:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	linux-iio <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, marilene.agarcia@gmail.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, Marcelo.Schmitt@analog.com,
	dumitru.ceclan@analog.com, Jonathan.Santos@analog.com,
	dragos.bogdan@analog.com, conor@kernel.org
Subject: Re: [PATCH v9 2/2] iio: adc: max14001: New driver
Message-ID: <aKna-cmHCbkJQ4X7@debian-BULLSEYE-live-builder-AMD64>
References: <20230710042723.46084-1-kimseer.paller@analog.com>
 <20230710042723.46084-2-kimseer.paller@analog.com>
 <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
 <11c30a02df784ca78be271fdf9190dad@analog.com>
 <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
 <fe0cd5348f864a6392a7e0e5ca93bec5@analog.com>
 <CAHp75VcpguSN9DkuCtpaB+_=sY7+Ot1MGPWToe-2pYjFXC9=4Q@mail.gmail.com>
 <20230716144223.0d9260d3@jic23-huawei>
 <20230720192428.2faaaf68@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720192428.2faaaf68@jic23-huawei>

Adding more people to CC and a link to the recent patch set for max14001 [1].

Summing up my last reply, what I suggest is Kim's patch set for max14001 being
updated with enhancements from [1] and a v10 being created.

[1]: https://lore.kernel.org/linux-iio/cover.1755778211.git.marilene.agarcia@gmail.com/

With best regards,
Marcelo

On 08/22, Marcelo Schmitt wrote:
> > On Sun, 16 Jul 2023 14:42:23 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > > On Tue, 11 Jul 2023 12:08:04 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > 
> > > > On Tue, Jul 11, 2023 at 9:55 AM Paller, Kim Seer
> > > > <KimSeer.Paller@analog.com> wrote:  
> > > > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > On Mon, Jul 10, 2023 at 11:17 AM Paller, Kim Seer
> > > > > > <KimSeer.Paller@analog.com> wrote:    
> > > > 
> > > > ...
> > > >   
> > > > > > Hence instead of v10, reply with a draft of the comment in the code (I
> > > > > > have asked before) that explains these bit twiddlers.    
> > > > >
> > > > > In patch v9, regarding with my bit arrangement comments, is it somewhat correct
> > > > > or do I need to totally replace it?
> > > > >
> > > > > I am not yet familiar with the terminologies, so I hope you can provide some
> > > > > suggestions and I'll definitely send the draft first.    
> > > > 
> > > > I'm not sure I understand what comments you are referring to.
> > > > The v9 does not explain the algorithm clearly.
> > > > 
> > > > What you need is to cite or retell what the datasheet explains about
> > > > bit ordering along with the proposed algo (in AN as far as I
> > > > understood). Because I haven't got, why do you need to use be16 +
> > > > bitrev if your data is le16 (and that's my understanding of the
> > > > datasheet). Is it because of the answer from the device? I don't
> > > > remember if it keep the bit order the same (i.e. D0...D9) as on the
> > > > wire.
> > > > 
> > > > For the terminology, use what the datasheet and AN provide you. Also
> > > > good to put those URLs to the code and datasheet as Datasheet: tag in
> > > > the commit message.
> > > >   
> > > 
> > > Absolutely agree.  The data format is weird enough we need the
> > > info to be available for anyone who tries to work out what is going
> > > on in the future.  This is a case where I'd rather see too much detail
> > > in the comments than too little!
> > > 
> > > Jonathan
> > 
> > Note that I had applied (and forgotten I'd done so) this driver.
> > Given the outstanding questions and a build issue with clang, I'm dropping
> > it for now.  Hopefully that doesn't cause anyone too many problems (those
> > based on my togreg branch which rarely rebases)
> 
> It feels like in a cartoon, when there's banana peel on the floor and somebody
> comes and steps right into it. Oh my, hope at least the title of most
> spectacular patch set fail of the year can be ours.
> 
> Jokes apart, what would be the best way to collaborate towards
> providing/improving support for max14001? I suppose the only option left was to
> apply something on top of Kim's patch set, but maybe Kim's work can be improved
> with a few things from Marilene's set. Her device tree documentation is more
> complete and follows datasheet nomenclature for voltage supplies. Her set also
> uses newer regulator APIs and adds support for max14002.
> 
> Kim, would you mind if Marilene generates a v10 of your set with the suggested
> improvements?
> 
> Besides that, I think Marilene has the evaluation board set up to do any
> additional tests if needed. 
> 
> Let me know your thoughts.
> 
> 
> Thanks,
> Marcelo

