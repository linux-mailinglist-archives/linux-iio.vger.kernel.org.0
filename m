Return-Path: <linux-iio+bounces-22561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF960B206DB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C7318C1FAD
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E392BE64E;
	Mon, 11 Aug 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF1mOksH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D5F1BD035;
	Mon, 11 Aug 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910400; cv=none; b=RANCXNNGxGzMUFklww2k1EIIQ+Q5dOWlUoVdcqeKqqY87wEcJMSGyKJkO9DvkJIFv07b5EMyJUOgOY9SKdoPE5L5otE19fH5wC9rkS4loIXHxuZZCnMBw6T4w2/VzRaqlitYURFHzRNoBJyt3TduJtaMozYptkNzv8klej9UtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910400; c=relaxed/simple;
	bh=LZcoR/xATPZ3E93WOMFKDmKrokbkIF//xS87GYAIMfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLr55XkobzYyuTFiEWUmEFi9M+rudACxVQeavBUI++4bLhvu6y5frcC9hjiSBCnFR2SGmT3KybHbcAre/WF6CFF2Z+1yqEqrR9xABehuO2L2gmQZWRi7KqvMdU1/LZflg0W7G3dbzTBJx5inTtfP6H7HM26SIYhGN3g3Ow3JDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF1mOksH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so28755145e9.1;
        Mon, 11 Aug 2025 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754910395; x=1755515195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Z9yrq+CHgIWUPq4di1MEdrMrTcRW2w/rjOeoMpk2n4=;
        b=JF1mOksHyrMIcxbjcI7MMZJMhvHjfxbLxb4eN+e9Fq5UrOFJDGu7jH3VcFu5y4X1QI
         tQKjospx4Etwy+jkAiLJeDJMeXISh0KwfA/vDSFg3p/L1wlkZUqKsZgAXlQBgQqUvOQM
         uQAWLeaA0x5k/R+sNgv5qpK2jvSJN+sCYXGIiZDP4XxnrqxWXtcFfqAMmbwS1FMXu0gp
         OBR6DjyIELRUqSctMGIpDXdpM/omfe4U6hk1w+nutnOm+6P5gGZdYnfiq3gxz5xoImYJ
         IkGARo4uVvL5ysOBvxVvV0V4KW30US9QS9pcYaW7n4DbnfXWuH/ha4OBRb1WcSBgfxAw
         Zjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910395; x=1755515195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z9yrq+CHgIWUPq4di1MEdrMrTcRW2w/rjOeoMpk2n4=;
        b=YvD+rmM+otbvJkdYu0V+/RI7bRR+CkL8iKJivfuVB6ip5Vj2KtCxwUocad7+aU+S3x
         Sklwt5bqQWopzR98iJtw6DboswxYhPDGJCN0boi4SJ3ZTcdnyrIl/f3jo6sf1iVccv9i
         yF7qQcwps6S4fK9qFtaPzNEseWeeR3fhm3/fLwUWtcVd3NOogQoZMZiGyW/l5fU8a7f7
         J+7LpARXEuM1+16jaDC4DlZUW5i3bdBJEzcL0iWwUDv2jzWqRFuB+NrKoOqeuxQ/Gp9+
         AtvJRepRRd+0ZnyEyf7qoOkNaYLHFaszyzJ3GSfvy7tsPHWlAbpTuVXXHEjt8bDqh3Rx
         XZXA==
X-Forwarded-Encrypted: i=1; AJvYcCVnx6zyg0FHwpmTmHcgESqv5wVef9b+4zbx119nZ3VNRNvWgQ7tbA9g3WBregkpVNLYMsMEJ8geqwif@vger.kernel.org, AJvYcCXIUYgOLqIFhJ2I5/t0/bvhIlM7534bkq0JK59wgs2v96CyKPaKT/+ygxMBYGCszkXn21MN9uwPqgqD@vger.kernel.org, AJvYcCXOE3kI3ZqzRRG3ojcQ2ygBKM78l5sx7YyVg0pf1jvHa6yOxhJa4HvtauPtvqxmQbViR81RvLuFGvHGSH+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz052CP8vVy5g+sLrChgQ2uExFJnQOY4b5JataOIeYaIrVHpMCX
	2DQdOhw7gfyMaf6YqSuIDrXzyp31rBMWBEzzOpL+Z9tXb0xoS7vp15J3
X-Gm-Gg: ASbGnctlWa0VNQPoMH4v9RA42mIgOnlfbqQlLoCtTaPys8IWwoaqPB0j0680L+R36nI
	ACFTmladzVZDNtZtiHU+aCCxCZ4b4dLS7Yn0RcPTJ4SRiLao7UhKLqelRdIf1ogD/vaNsEL+XLx
	EEEMjKTegfUMb2DjlXAJF3wkWRhOqEOSbRS2BuSyZjIApseSTAOdiEzff3glKwe3he61PNhvezT
	dY/vUThM74YhPchq2vyJM/8X/lFXyHIE4tUHUy3iW8ZngP/ChhS62vD7bJZ+n/oHeB6mxNJCeC0
	Pd4k38ukfcDQUBdCqv6npDbvN7dclpkTZjCzg6MAqV5pcrr0kVz6AYvMY+UsVrgByMYVmUMjsfE
	LsR0VUQfcGpW0ZQ==
X-Google-Smtp-Source: AGHT+IEt5UuGb8DOlBVMmK7oaEDH1W1SPNHPJ7PsR6m9IoCJ3Hs0Jwv2F42crF2ql7tBcRRzLxFXRw==
X-Received: by 2002:a05:600c:4686:b0:459:d6a6:792 with SMTP id 5b1f17b1804b1-459f4fb2d08mr102100615e9.29.1754910394463;
        Mon, 11 Aug 2025 04:06:34 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm374390205e9.14.2025.08.11.04.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:06:34 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:06:51 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <n35dcx77xlk7liosc6qdef423cuawvykrbn557qj72k5enear2@2akn2l3btwab>
References: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
 <20250728144901.3f646a4c@jic23-huawei>
 <20250809210438.23fb5fd0@jic23-huawei>
 <d6n24lux6pv47mb3z2bfdbtn5olsm46rdbnkwhjurkwh4a27kl@hkcedsvni4il>
 <d68f4783-ffdd-4fda-8ae4-65a211f9ffb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d68f4783-ffdd-4fda-8ae4-65a211f9ffb1@kernel.org>

On Mon, Aug 11, 2025 at 11:52:23AM +0200, Krzysztof Kozlowski wrote:
> On 11/08/2025 11:50, Nuno Sá wrote:
> >>>> I don't know who from Analog should maintain these devices, so I chosen
> >>>> author from Analog of one of last commits.
> >>>>
> >>>> Marcelo Schmitt, could you confirm that you are okay (or not) with this?  
> >>>
> >>> Nuno, Michael, other ADI folk.  Can someone confirm if we are making these Marcelo's
> >>> problem?
> >>>
> >>
> >> As amusing as it would be for me, I definitely can't pick this up without
> >> some tags from ADI folk and Marcelo in particular!!
> > 
> > Normally in situations like this, it defaults to me but I'm happy if
> > Marcelo is comfortable in assuming maintainership for these.
> > 
> > That said, I do think that for the adis* drivers it makes sense to be me.
> 
> 
> Do you mean that adis16240.yaml should be for you?

Yes, and adis16480.yaml.

> 
> Just to be clear: I have no clue who should be maintaining these. For
> sure emails should not bounce...
>

Agreed! And thanks for doing this btw. For sure me (or someone else in
Analog) should have done it before.

Thanks!
- Nuno Sá
> Best regards,
> Krzysztof

