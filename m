Return-Path: <linux-iio+bounces-749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EBF80A316
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51ED1C208E8
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473891C2A5;
	Fri,  8 Dec 2023 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuT/58I1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9719A5;
	Fri,  8 Dec 2023 04:21:13 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso1511475b3a.0;
        Fri, 08 Dec 2023 04:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702038073; x=1702642873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBylJguRLtCHJTwufQYDaqjtAAVjosYGjLO6kCTyNVk=;
        b=LuT/58I1mwKjxmk524Z8WM/1YmKuvxHt5/LbppJYNCas+jLMgwmdz8/R+4QMU2V+VM
         5iFLbYqhWAvF2BPhglGA2VeUN6ai1WAggcP3eL7N0CTc8dViW00xIRmZ7bZslZUBx/G6
         IlgPQ5Op1k2M2nLRFVqRtUnx7pm8rVs9cEJREwRzYEhSeFvipBnhVYb9MwcatPpx3VeH
         uZiq/gNxdCcgIBU2xYd+fvzVNzDxuynBS4sKKGxkf+iTklF1mrERABEZ3+JyUSWdGPU/
         +M+LEGxAT5Wn3IrxMFOcgaUh2ITm3OC4fao9wiYmTT7AjioHRmJxGB1ciw2fh7+d4VHs
         On+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702038073; x=1702642873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBylJguRLtCHJTwufQYDaqjtAAVjosYGjLO6kCTyNVk=;
        b=AKN2P5o80cybba3rMd8mU3hRtD6kDnsXyePROwYQuslyB29yEtzhBJUiPv9Yuv/hv4
         Grx9rGTVVfE3PxHLzYT9hzZ4iaixneJ4lOwz27zVbysKA68uqvufEk1tLTj8XVuoC35e
         4J1khic2r54sUOJgdj2kWs9AudP+5PR6udWl7Z8OGHLLvJdIsF2tPQJop+qIDpJPl1qR
         7mY2Ml2jzyIFxNXwtc3xuhRz1KRekNDQdtCSvyEpmLxf2Y5ZL5O59Dzj5x3IsPccu0/p
         7Aw9Bb2luRgmfiSv2Q61/EQCU86ITC3rcEpJspdZizATV5n5tfViJDz+AgaXPBC4/unN
         17/A==
X-Gm-Message-State: AOJu0YxqbCP51TXmlU4dKKQXqZw7Px/USgr1sunHCj/Mt0t4gn/AM/nD
	iyi1nX6Pfh8FxlqRhCcU0nY=
X-Google-Smtp-Source: AGHT+IG9q/TwR3OEzg/OABKdlXCvWeyF224LiGWiBOg7ST2oapE9nW1A/gpab/BOiiu2ftWDyLkrCw==
X-Received: by 2002:a05:6a20:2618:b0:18b:31eb:8b66 with SMTP id i24-20020a056a20261800b0018b31eb8b66mr3058841pze.50.1702038072764;
        Fri, 08 Dec 2023 04:21:12 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b006ce6bd9703csm1436765pfv.194.2023.12.08.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:21:12 -0800 (PST)
Date: Fri, 8 Dec 2023 09:21:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/13] scripts: checkpatch: Add __aligned to the list
 of attribute notes
Message-ID: <ZXMKLHelamS0EzvJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <e8d5343a0a6b5d976873d3896ad9ab0c88505c6d.1701971344.git.marcelo.schmitt1@gmail.com>
 <c2138d24bcaec664e9239e6e1bade6116db04027.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2138d24bcaec664e9239e6e1bade6116db04027.camel@perches.com>

On 12/07, Joe Perches wrote:
> On Thu, 2023-12-07 at 15:37 -0300, Marcelo Schmitt wrote:
> > Checkpatch presumes attributes marked with __aligned(alignment) are part
> > of a function declaration and throws a warning stating that those
> > compiler attributes should have an identifier name which is not correct.
> > Add __aligned compiler attributes to the list of attribute notes
> > so they don't cause warnings anymore.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > The patch that would trigger the mentioned checkpatch warning in this series is
> > patch number 12 (iio: adc: Add support for AD7091R-8).
> > 
> >  scripts/checkpatch.pl | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 25fdb7fda112..e6773ae0ad08 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -512,6 +512,7 @@ our $Attribute	= qr{
> >  			__ro_after_init|
> >  			__kprobes|
> >  			$InitAttribute|
> > +			__aligned|
> 
> __aligned takes an argument so I think there needs
> to have something like the use of __alloc_size below
> this addition
> 	__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)
> 
> maybe
> 
> 			__aligned\s*\([^\)]*\)
> 
> though even that would work well with most uses it
> would not work with things like
> 
> drivers/crypto/inside-secure/safexcel_hash.c:   u8 cache[HASH_CACHE_SIZE] __aligned(sizeof(u32));
> 

Will think of something that may work for all cases and include in v4.

Thanks

