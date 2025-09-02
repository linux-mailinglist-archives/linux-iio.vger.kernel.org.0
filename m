Return-Path: <linux-iio+bounces-23663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C118FB41012
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE82480487
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48D27144A;
	Tue,  2 Sep 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9mYVEen"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98E1DA4E;
	Tue,  2 Sep 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852560; cv=none; b=KANyprc7lmwN20PzT9EKMr4YpJXGs8C3QqBfMsOlixixw6zCNbr16PYRHLzNJguyZnpULnCArRazBawRhabN0R2fsUWPoCKJBeoERutxLYhlyppniZOeY90Cm35PAR8eb3Zz6uAXh5MYrQIOqvFD14tq1NpwqoYmTJ4IytBVHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852560; c=relaxed/simple;
	bh=LjD5KvjEiKeBwYilJ2v1IVnwSvuALHZGcPKF3GzasZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lajqk8Kh9KGYGzzmCGq89QhVygiI6+YogUW509OZn6iT5c357JXfzykf1JPO1V3S+OnfjKzFzMnviITXt9Pe+H+ewgBvGFHtHFJOMB/oCQv7sVTOmEkYGPwTO64XVo1BBQmzW4M3P1pxCG4URDNfnfaqZ/H7/edw3ysCoxpAegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9mYVEen; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e87055f827so86884685a.1;
        Tue, 02 Sep 2025 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756852557; x=1757457357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRPgYtyRbW+x8nqcCwemvwxk70B14d1QXLSO0znwE9Q=;
        b=U9mYVEeng33yBtztUWC2h1FfZcuQQujf/kayq/FNwqW1OXKuyMHWWPf4TxJgdg6T0n
         dJxndejYIm6EftmxNt49kLYD4hmDRM9Km/d17ybzyP7Y0KQ5ohRgXH9No5yAuWE/MHeo
         ap5nF7YXoy4cAX6ojKtTYdjwEgIdimEv+DulYdc+yO+8XCnW0iQyomlX4bNrxAay2Zu1
         F0AnwbjfwpWyYhaCfDfbQ2VSiPoDSZIp0CN0VupjgYbssFWFy3QnDuSSD89JsZtyY3T5
         3qGo5qspHriso7GaTFqjt5gbJ1/r7hM/jj2GCf/YdjgEDNV2s5UPoKf61AT3k63hsbIT
         SA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852557; x=1757457357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRPgYtyRbW+x8nqcCwemvwxk70B14d1QXLSO0znwE9Q=;
        b=S83dpeOUcVAyft0XN6Ks5rmzvcr5/ND4UGoxgdUEGGimALG1Sxa7je1W/dAv2C2fhp
         Ve5j/TvnW6E19tBuYPcbXTlnhPL6ly7JZtmo1nsIksAEOW+DKLly0jk/m1ugjssEm+lL
         1Dh6YvYw/xCl47Ui4YN44cGoFK0viYZHspNNsp6haC4sZybuZM3MtBCn8tKP6OPVyRR3
         cfGCdvpMoFlFM4Ow7EUgr0s1xMDfgyz6GDijNonijf3+cB39yGrp7pfpVDHRaXvAMaFE
         Jyo7ehYw36e3uaCBr14utNl/QbKxQLlBvL4xMuwQQ2LgLreLObWT9k4lk/FD60Cs311G
         r/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlmhr2SZiSzaL2196bXiGAIrjuAe7sg2uPahDKQPrkDt1c/h8EltZwdJbKVNd0LzEVdPccZGE5XrYM@vger.kernel.org, AJvYcCXXfpcKCzBYuzVb1+DaQ/TfDl+tB03lJd/abXNF/U2Hivwa+78DuJ1Er7eS3ZqcVzfcjGe4AvCgLV+B@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqs68/+rQbbqdgJUjNeaMzKxlFxtuyLCLzKsRBJvkVNelaAjc9
	VtW/SvZATgVYu5NcNevRM2bJaaxUQljc3QBE2iHRHJ9LoQel2ZKu22uZ
X-Gm-Gg: ASbGncu6miWvLxcMFZyxaxNIIrGQgWCeg82Fbq4upUmyGCEKG3XmthDJ/IH4m4nl3eo
	vzjop3q9JSqama80tN2Rx3t/Ng+cJ0qbLX4DMLo+TnqIM4iX4Rnct6WiFfa0Jfggh0YElwhqfA+
	bjA03PfWuT3sqskRadQ33xQHlbu8DP5eBCq5QhsKhZ3mxpXsFLtXFBrmzDUXft7M1uPm9ehSbYj
	xrC4lBVMIX5/rJl8nzn+gicxt42ixGakduW5qHG5BV+o0YDfN5Thwr+BDBJhBRbr3m9UwDqu5hV
	fItGtNQtakGSDMlpVLzvdPigjHXU1Z2PJiTQ3MAeDlLbQmljDIuhF8gbgktWnNZHnTl8YYHSfR5
	wZMeQiMtRSu3z4+6+gXhQuTtiqbpNJ3LlF/EJvkUMA9BrlGDzWNPubg==
X-Google-Smtp-Source: AGHT+IFXDmGypJO77ch7xU/ov+7/RDULr8wsdYp2httINoIYtYS9VfrIEg5080KfRvHtScUcSDzbqg==
X-Received: by 2002:ac8:7f42:0:b0:4b3:c4a:25f3 with SMTP id d75a77b69052e-4b313fad06fmr134217881cf.13.1756852557136;
        Tue, 02 Sep 2025 15:35:57 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm19781196d6.3.2025.09.02.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:35:56 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:27:16 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7768-1: add new
 supported parts
Message-ID: <aLbwtONZDkC/01gY@JSANTO12-L01.ad.analog.com>
References: <20250824040943.9385-1-Jonathan.Santos@analog.com>
 <510f6efb-ada3-4848-ac8e-16fa5d1b5284@kernel.org>
 <aLPE3yiSTReS7B2J@JSANTO12-L01.ad.analog.com>
 <e98ed14b-ed97-4e1c-a758-97b9bfc8ded4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e98ed14b-ed97-4e1c-a758-97b9bfc8ded4@kernel.org>

On 08/31, Krzysztof Kozlowski wrote:
> On 31/08/2025 05:43, Jonathan Santos wrote:
> >>>      maxItems: 1
> >>> @@ -58,6 +66,18 @@ properties:
> >>>      description:
> >>>        ADC reference voltage supply
> >>>  
> >>> +  adi,gain-milli:
> >>> +    description: |
> >>> +       Specifies the gain applied by the Analog Anti-Aliasing Filter (AAF) to the
> >>> +       ADC input (in milli units). The hardware gain is determined by which input
> >>
> >>
> >> I don't think there is no such thing as "milli units". milli is SI
> >> prefix, not unit. So "units" is the unit? Or how exactly?
> >>
> >> Basis points were before since 2022 so I don't get why these other
> >> bindings introduced in 2024 could not use it?
> >>
> >> Anyway, if you ever do not apply reviewers comment, then your commit msg
> >> should explain this. Otherwise you get the same discussion here.
> >>
> > 
> > Yes, you are right. We shouldn't use milli as suffix. However, may I
> > suggest another option?
> > 
> > I believe -permille is more appropriate because it represents a 1/1000
> > proportion, which gives the precision we need to cover all values.
> > 
> > so it would be something like: adi,aaf-gain-permille
> > 
> > Is that ok for you?
> > 
> > Thanks for the feedback,
> > Jonathan S.
> 
> 
> What's wrong with existing unit I pointed out before?
>

Nothing wrong, just thought permille would be a clearer unit than basis
point for the user. But i can proceed with bp, no problem.

> BTW, any idea why your reply-to header is completely corrupted (copies
> in-reply-to...)?
>

Yes, i was including the in-reply- to, sorry about that.

> 
> Best regards,
> Krzysztof

