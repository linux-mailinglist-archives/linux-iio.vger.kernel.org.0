Return-Path: <linux-iio+bounces-12036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A69E9C1E2B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 14:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9732897EB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549E1EBFFB;
	Fri,  8 Nov 2024 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6W+T92d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8531EBA00;
	Fri,  8 Nov 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072834; cv=none; b=Wcz4qZbcY8JiGbSenuz6YvHT4LplEXDga9GL+3th+s0oI0D0sEjhrZHqrHN0EV7E8Eujd+G+GWNohxCFZDFh5c3qi3VNpSxusweGKUxEL/ZdfswCYwnFUIZgZBcNtxHtvcMRxntW/h1BaO2FOIq7ZzPYTQwNRUzxTguwP9n0Ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072834; c=relaxed/simple;
	bh=JAEOKGBin/BjpP+sOkUXewDZtBs7MLiDqJdiwY11fIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWEs6LQEl425tzXM5/hb6cgYrji3eErE2l1go/bF+Bg3DlpuPQqlHs1LOSxBKblLD506nG12DEzcwlLEnBYiv022hj9kNmcs+uO+k81g5oIfMqIfqkQqKxk0VMZqjWcHT55GMb3N/ZO10yMjTB1i8ua4995OSkSFtdzzTQO74Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6W+T92d; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so276036366b.0;
        Fri, 08 Nov 2024 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072831; x=1731677631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAwIxYg8+dnr1jOWQr9wFbOWatGyVStyXLICiB+s1To=;
        b=d6W+T92d1xqdDwuTYQugsVZSk5POPM+IO0LvAV7yNP1j6ZeJ2+e36hHG2Lce7G1jBh
         3JXfzZf0f/CssQeUz2vypPatkQNz9EcvEI2keuECbxGAw+QWk6hH0oRDdIDIgylgxk2U
         3YtEAe+41STsMh0qDIwJQPeZ9j+Of96rJW1/r15Qq5hVV7FcwadhE07XMvfXwbft1GS6
         tGxj/FIL08an5Xj+1PDmSxjhEprQA/YqZTtuCF6IDDV5oGHOwj3xwvEvUIrURQhP5be/
         Qg752cciGmZ2ilFIULKSu8lywDRvsEBOrs9R1DyYV3O7EgbDCunh4Ec8RIl6aBcnfdZZ
         zqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072831; x=1731677631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAwIxYg8+dnr1jOWQr9wFbOWatGyVStyXLICiB+s1To=;
        b=txFG8w0RcqBOquuY9r673I7zpUdPhbilqxdvXNR3G1U54Dq1LAWXM4K9VUUDI0dWlx
         GLPimbjk9dVkGmAeDIxKKWRjc4gTD15rPQYqJPgfMXzq3LWrhmqZvFUIacblUU+k6LAl
         xFOIQ4/UsGs+eNt8lheuQkLOh3gUXc4KRLJLVvSrM1mmJmHPsyV2g0zvxdFfHZJosCT7
         7LObTM2ZKAlGRHmfYywZgSgILspzrDy6hRZt3YaGazJbV4susEhsp3jKtCCdYhb6Tln9
         T3y6nW9dAejrV4k3HcVtSmgqp+SDNbtyxoDNZDz6o5clEFXx6vVM6+gPvZFTMj36pXsc
         yXcg==
X-Forwarded-Encrypted: i=1; AJvYcCVB2MINckkP+S8/e8W1OsbajCU+m3OTaVdtcIyD9sCeStriK4yywMSzW7nZVI6C5eiersYG+5QYU8M=@vger.kernel.org, AJvYcCXPDm9r/ltnddXzS6uzP+nIKZt4RJUo7eoVnu2GqdPVd0xkKS3kiPila1Hx2MuUWyrkC0iTlt1eAkzu6TiW@vger.kernel.org
X-Gm-Message-State: AOJu0YzopEerHDdUsstq5rM8B0wr5BE5JzOnBYvdgSvcoE7CbW4tjzYN
	eGFeqdTjbDcf7UtYsBxuefifcid8WejWxttJls2UP2dDomVlUC9b1wORgL5qlXOq4J6spso5D5H
	AhBAYvu/kyHcbRIsxwVfXOH4IvSQ=
X-Google-Smtp-Source: AGHT+IEDXgYdDocfjpsZf3BKLs4tZnmRmbMDo7n1mBPdQQRoUfZ+ox6amxEQwJWJd6cxqtVp5JqVPWwVK3nVw9mjuRA=
X-Received: by 2002:a17:907:9344:b0:a9e:c263:29a7 with SMTP id
 a640c23a62f3a-a9eefeecd74mr234054566b.23.1731072830695; Fri, 08 Nov 2024
 05:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108085012.13147-1-victor.duicu@microchip.com>
 <CAHp75Vd924pNBKkoWNse5Bjazrp9+HuqBJ5nj2tdk6vngaOiJg@mail.gmail.com> <6069300280c17c4568bf4e3bcc826797@gmail.com>
In-Reply-To: <6069300280c17c4568bf4e3bcc826797@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Nov 2024 15:33:14 +0200
Message-ID: <CAHp75VdobsXLQXsopyi1Ms3AHxL=wWZMjfLQjRRNWyhr6Q7q7Q@mail.gmail.com>
Subject: Re: [PATCH v8] iio: adc: pac1921: Add ACPI support to Microchip pac1921
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: victor.duicu@microchip.com, jic23@kernel.org, lars@metafoo.de, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:56=E2=80=AFAM Matteo Martelli
<matteomartelli3@gmail.com> wrote:
> On Fri, 8 Nov 2024 11:23:18 +0200, Andy Shevchenko <andy.shevchenko@gmail=
.com> wrote:
> > On Fri, Nov 8, 2024 at 10:52=E2=80=AFAM <victor.duicu@microchip.com> wr=
ote:

...

> > > +static inline bool pac1921_shunt_is_valid(u32 shunt_val)
> > > +{
> > > +       return shunt_val > 0 && shunt_val <=3D INT_MAX;
> > > +}
> >
> > This basically is the (shunt_val - 1) & BIT(31) which can be used
> > inline in the caller. Hence, drop this function and use the check
> > inline. See also below.
>
> I think the current comparison check is more clear. Also my suggestion
> to move the check in a seperate function was to keep it consistent in
> different places since such check can change in future and one might
> change it only in one place, as it was happening during the first
> iterations of this series. However I am fine to remove the function and
> move the check back inline in the caller as the check is now only in two
> places and it shouldn't be a big deal.

Up to you. But then drop the comment (which kinda useless) in the
caller and add in the callee, i.e. in this helper to explain the range
of valid values more clearly, ideally with reference to datasheet text
or so.

--=20
With Best Regards,
Andy Shevchenko

