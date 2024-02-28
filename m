Return-Path: <linux-iio+bounces-3146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F086A8FE
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6001C24ED0
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC52421E;
	Wed, 28 Feb 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Leqv9Ii2";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="OtpPEVFw"
X-Original-To: linux-iio@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506D28DA7
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105497; cv=none; b=aZlAc2OWSb+RcrewbWyNoXzov/ypim0fxXJCK/RwXoMNsJuLKPTwIRfSsLUYikCCHLSjsQv6hejYkuVZd+Ib2keXRNMck7JK4unzBRtpT7oa/9Qew1dfSvccLYpA8ZYMMXlSuueVIxgiqDUFHeKyaLjLzRKQyr50hPrNNtMWzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105497; c=relaxed/simple;
	bh=xCuy4MVwp0NypZyLpDhoJjj6fCLV/bg+BECCVso3xOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra9lDMclIyKtNnX+SQxYF8CExuPGQCw/OthJdLxprCS9RIiigCDvyrPm9KzpyxNqMQUKeTdHzJPMvmXXh9ln4fCPYqEmN3MHemd/7Cz68jXuYtMCQMaFMY5QLDEj0E/1MPYxSxgVtuGg/xucVRHB8aBWKOZ1nhTKByftMUpoF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Leqv9Ii2; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=OtpPEVFw; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1709105495;
	bh=xCuy4MVwp0NypZyLpDhoJjj6fCLV/bg+BECCVso3xOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Leqv9Ii2cuI/9j4Pj6CCYhRoP4Z3fyHRmmLWTbxRgj5KLJD9bAYqFKBtQmqlDXYry
	 KYdYI/gbvH/yB5aTqb+GXe2Intqi3bdDxIgwnUPoCeIYLt4nzGtEOK596k/FsPaSpn
	 Sdx+hADNLjAGAt6vlUIU0VK+UVS/e+EalK51P8nmBcNyxoM8t96DYH8Q/3KzjpWCTO
	 bl/bFtw8o+9ZoYMLV/dP5MT+57O5Iem8JMYsYTHd7S0hnUWzI7Pof0ZQ8GpcTebS+t
	 FUnJGbw2sWzw1+I+KHh+AzmHlraT1YPOemOvDKx6HvseCnvEz/coHL7gsxbghvnZ+O
	 r5xIpfcMEfTdg==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 3E2B9B88
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 16:31:35 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=OtpPEVFw;
	dkim-atps=neutral
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id DB404B88
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 16:31:33 +0900 (JST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bbc40771a9so6185914b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Feb 2024 23:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1709105492; x=1709710292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1r5BtcdAAMK6pyjdadbxQXK81G6GJtZJh++YFz4aZc=;
        b=OtpPEVFwYh5rvvIZRYX0Vfal18hEOYIWRv1ndrwWCL5plSpW0wh7PSZm095w5NNKWu
         E+A71RLPD9b7AsUEvxeFNSvCapqTa5vj0emjX5pMNUmMPBpF7paQ8WLIdCdFN9Gohh5k
         Dyef2lWgczhrR6JXMUrNjuus2htfVq62HQ6iuZPv+Otu9tdpvxDOiX6TFEQAwQXPPHQ/
         WdRs1xcDqFISxwLTFPtPD/SraLdlFmPlnDALVNe5loVNX8yTGHZoaTUzjefcHI4fc9HM
         9V6ChmL4p6hzhrWlsG/bI6P8aoCxswg5S8sW+i7nQklsdRZf/SoSh3d8R0tO5/m/WURt
         1X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105492; x=1709710292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1r5BtcdAAMK6pyjdadbxQXK81G6GJtZJh++YFz4aZc=;
        b=EXc6nxuEzXbBZrw6eUSx9c5Yi5a0tpfsQxAAasMLrGcJ7bkY7DYpTqhDsCw3cVDFLP
         9HAOTrp474TTXQ5HRDB+Sc4Z8NauohCKbFWeklpEV7V8IMyYilDuMvDYz+P/Imb7sxEw
         s2JfMuppgCyoRvoiPvNHyo+w34gYby5f41elpr2YuEQG3Hx9xlszgSTqReuC2QgM/uUR
         zRnC4uq49EnPPatFrrtHwFQXThPR1ERNYtxSaoDf6MVu7vuxkcKxhVG/9zZoTumbkxuC
         ZA1yCUiyEPtgBRQOgr3/c1nwo4pC2b0N3MhtZOXQQlVoMuyOuBWz7ik5n+wQR/+sXIQM
         N/uA==
X-Forwarded-Encrypted: i=1; AJvYcCX6t/a7A2Atk14nHWX/FxNnS2vSx73Zwb9uN0Us2va7OkT7+RWMqvh2kq8oj85VdL6GB1yw3iQgvjVbITehfNNvIGQn84rV1+Pe
X-Gm-Message-State: AOJu0YzNS+YeYF9ZX+PNtjQ114iNejQZEd+P18RBgiPx8aBbjnjylajX
	5Azaqrw70us19akwBIbVGI3F/NrWFWRTCOm9NcSTAIBrMLJxE9XhP9cq4tPWNEf2vgH4nG1bj2R
	SjpIqrYQGw4+UNavk/EQt9Sgnu4J0Hp95eK8XMZmiNqPgaTz1swH8HnKeCCU=
X-Received: by 2002:a05:6808:20a7:b0:3c1:9a76:99ea with SMTP id s39-20020a05680820a700b003c19a7699eamr5102158oiw.44.1709105492533;
        Tue, 27 Feb 2024 23:31:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG5oF6FrhRl5wkv5l81utRatIGtk//bIRrP8Se7SeC21eJl2NX5IYXpppfYh8KxZ4fhGrDLQ==
X-Received: by 2002:a05:6808:20a7:b0:3c1:9a76:99ea with SMTP id s39-20020a05680820a700b003c19a7699eamr5102140oiw.44.1709105492240;
        Tue, 27 Feb 2024 23:31:32 -0800 (PST)
Received: from pc-0182.atmarktech (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id y37-20020a056a00182500b006e558a67374sm1125452pfa.0.2024.02.27.23.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:31:31 -0800 (PST)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rfEPa-00Gr73-22;
	Wed, 28 Feb 2024 16:31:30 +0900
Date: Wed, 28 Feb 2024 16:31:20 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <Zd7hSOw3_zosyrn3@atmark-techno.com>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
 <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>

Krzysztof Kozlowski wrote on Wed, Feb 28, 2024 at 08:16:03AM +0100:
> On 28/02/2024 06:12, Dominique Martinet wrote:
> > From: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
> > 
> > When using dtb overlays it can be difficult to predict which iio device
> > will get assigned what index, and there is no easy way to create
> > symlinks for /sys nodes through udev so to simplify userspace code make
> > it possible to request fixed indices for iio devices in device tree.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

Sorry, I assumed that was already the case and didn't think of checking
that from what I was given, I'll fix the prefix to "iio: core: .." in v2

> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.

Hm, I did check that and do not get any warning about the code itself:

$ git show --format=email | ./scripts/checkpatch.pl -q
WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

total: 0 errors, 1 warnings, 61 lines checked

What are you thinking of?

Regarding the dt binding, I'm not actually changing a binding so I
didn't think of rechecking after adding the note, but I guess it still
ought to be separate; I'll split it in v2.

> > For platforms without device trees of_alias_get_id will just fail and
> > ida_alloc_range will behave as ida_alloc currently does.
> > 
> > For platforms with device trees, they can not set an alias, for example
> > this would try to get 10 from the ida for the device corresponding to
> > adc2:
> > aliases {
> >   iio10 = &adc2
> > };
> 
> Sorry, that's why you have labels and compatibles.

I'm not sure I understand this comment -- would you rather this doesn't
use aliases but instead add a new label (e.g. `iio,index = <10>` or
whatever) to the iio node itself?

Setting up a fixed alias seems to be precisely what aliases are about
(e.g. setting rtc0 will make a specific node become /dev/rtc0, same with
ethernet0, gpio, i2c, mmc, serial...), I'm not sure I agree a new label
would be more appropriate here, but perhaps I'm missing some context?


Thanks,
-- 
Dominique



