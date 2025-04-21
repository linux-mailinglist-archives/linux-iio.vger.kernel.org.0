Return-Path: <linux-iio+bounces-18465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2FA95348
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1656C1886287
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDFF19E83C;
	Mon, 21 Apr 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEGUQZQ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311133086
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247978; cv=none; b=jhEWoP1XL5a3x+LY3EmpGj4M2fK5ydu0fYSGHRI1UavuFBOGdBQG0DakKQeP4fAh7jgyR5AJ/sTR7KFCPyF0s9sL9us3A/w/jZAUjV4Az95Juve9Vd6c/TVvnd09LNKu8QiuyhWqnN6Xl9czEGvCWgj7ocaC5KLtxfklX7SQ1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247978; c=relaxed/simple;
	bh=0hWFNlZe8dvZNYxfWYy8DTOqgHO6+lKptKxQk4OwZGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLjkaILuUHBvdV4hxnWQkAmNe6C/mdthdaYKFfC02mhjEnls4nd3K4rCW0IeQ6/COwqInNBHSnxbpSox/NtonDaovzy5ST+g5tAkAk51znCgNggd2VChBCJkiMxa5ATdkoGp7uOPnegg486xdz6iWgagEv/UCzj/ii2g6ntvbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEGUQZQ7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac339f53df9so711188666b.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745247975; x=1745852775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIxcWLrj6nmTJbRd/lg9BBXWepxY7q8r/JbufnuDXs0=;
        b=FEGUQZQ7T2vJVKlFsN+sLEe36YM+qSCFPuYJ0DOF4lD6VEcUJnbOC9wX4bXuIGmcDJ
         vawfTWJN76k/D1ee3ZV7YHMnoQO0+KkQwyYPlNQsxuSYI5PPN4kqABDwQ0uVhCBhanVn
         q1S6t6aeEyMWou3g9v3IA8f69kXsGQcpCX8jf7w8GPgsHQNPM4ZfCdWwO6naxqICit8w
         thBTiOlGUg3h8xViK0Y4iXehluCa74wKiatT5C3LxngJyamzzBEYqAyFkFQ+aePwAC60
         2bIkmJ7ai38vtzQMKaPnBhTVh0mATddsbWn+kadUSwZWk3rjfCFY3m3RFLG915wMHih5
         pk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745247975; x=1745852775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIxcWLrj6nmTJbRd/lg9BBXWepxY7q8r/JbufnuDXs0=;
        b=e5VCGPJvnK5nz+1lD+hP8U4YF4Dh03cBasZzQSPC9qNRSjDT/ibHL52XCgHwyWa5ll
         WJP42Xdx2jwyGob/ZLLwh4LlGFrX6V8SFVHTIaYyVm449gYyySB/AT/8Bh7oBVYZxUxg
         qK2gQ1mT8lgS2RExV9j9XygdI1KeDvxU5E5UYLCoIZ4Uhz3yAuYgQvpBU6YETag8df1s
         8UCffpnSWPDyZc12L/tCR/IOun9Z1rgs/JEiAH1UJwo/r8xZ/+pW73rGcGKKwk0n8mKE
         WgwVU2j5K1ObFRFJcm6IGQ8fgoFqxyNNKJJZZ01KnWTuoJI85eyIqQkKzAXkoVRzJyWm
         49IA==
X-Forwarded-Encrypted: i=1; AJvYcCX6VIW9VFKaF1lCz1VlPox1DpH4q8CdylCEZWvkqZEfCxCjClcHY7O/wlnLS5HHS+KEQO8Mjb/JthM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDuiQHEKa8qoVsaxe3Rd/rD+F4BtkExU2ZXRa5s5bDC1qyia+
	ICR8MNEvhtvw+fLm0x1cQMn3vqlWIT+5AH7xyxGv0+0amJjZ4ocP0vvphE0U8MbcNq0xd77GgSa
	4VUqSJg0RwQqsR7ftu3sd5QibDkg=
X-Gm-Gg: ASbGncun2VGMdBmzHorKxKKjbU1QTyFA0uzZwU3T4r20d0EJnSWJEXdfMhkXnFJHRlW
	+lckj6C0JVK9HJYgITqf4K/YBEV6sHQGhOs42Zdjv9nsIkIs9mHdnfDBPXzLXRqkdbfl1S89rgn
	UsF8i0sl7cFM7fRrcpSbzKT8vxk3rF4iFevvfetR75mynrFzQvqb+nFr8=
X-Google-Smtp-Source: AGHT+IEjHAkMIwKBtx7jkxP3iLSZZ/6xn9NRYEV9mt7ZkKe2vF9UrDl9kQqb7E4/dhver7J2ZzQPBAvZ72k2kBoNFaQ=
X-Received: by 2002:a17:907:d8a:b0:ac6:b729:9285 with SMTP id
 a640c23a62f3a-acb74e2f9b1mr1086586566b.55.1745247974709; Mon, 21 Apr 2025
 08:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420222512.173029-1-arthurpilone@usp.br> <20250421140842.08e4d26b@jic23-huawei>
In-Reply-To: <20250421140842.08e4d26b@jic23-huawei>
From: Arthur Pilone <art.pilone@gmail.com>
Date: Mon, 21 Apr 2025 12:05:49 -0300
X-Gm-Features: ATxdqUEH9sY_HSKs8_8-gGHML5aJVidgL4GDliptkMDmUQ6KCsgA9xGLx4lRucg
Message-ID: <CA+m-LuUn0awgWBK6TfKo0z_BYf9+5ZJdyNVF3vN+ywquPYsE0A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7091r-base: Move reg volatility check to
 new macro
To: Jonathan Cameron <jic23@kernel.org>
Cc: marcelo.schmitt@analog.com, linux-iio@vger.kernel.org, 
	bruno.stephan@usp.br, aschwarz@usp.br
Content-Type: text/plain; charset="UTF-8"

Thanks for the comment, Jonathan.

Jonathan Cameron <jic23@kernel.org> wrote:
> I'm late to the game but to me, simpler to not have a macro but avoid
> duplication by having one function call the other. Also a more
> minimal comment can convey the point you want to make.
>
...
>
> On Sun, 20 Apr 2025 19:25:12 -0300
> Arthur Pilone <art.pilone@gmail.com> wrote:
> >  EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, "IIO_AD7091R");
> >
> >  bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
> >  {
> > -     switch (reg) {
> > -     case AD7091R_REG_RESULT:
> > -     case AD7091R_REG_ALERT:
> > -             return true;
> > -     default:
> > -             return false;
> > -     }
> > +     /*
> > +      * The volatile ad7091r registers happen to be precisely the
> > +      * two read-only registers.
> > +      */
> > +     return AD7091R_IS_READ_ONLY_REG(reg);
>
>          /* The volatile ad7091r registers are also the only RO ones. */
>         return !ad7981r_writeable_reg(dev, reg);

Perfect. Addressed your suggestion on v3:
https://lore.kernel.org/linux-iio/20250421145534.91146-1-arthurpilone@usp.br/T/#u

