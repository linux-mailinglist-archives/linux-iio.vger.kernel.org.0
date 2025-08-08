Return-Path: <linux-iio+bounces-22484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3433B1F051
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 23:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A200177DAE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352428934D;
	Fri,  8 Aug 2025 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj4SIcyR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0941B2186;
	Fri,  8 Aug 2025 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689288; cv=none; b=nxNLhWS59GZUiSi/iNQLt+iuGiq/t+82U3dTRCpDePdn5njU4JTiGMYsAHYci8gdQiICHO11THgDw4RZfqoBXNMdOk1raREH8aJYQbZKJA6zQ8ftnSJ3fLJVYTEMYf/0OZKFQYkDxTZqqL/qkKysp6FIYqFX8w4ddBbpGvaOrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689288; c=relaxed/simple;
	bh=EUyFsWDepLQf9slYx0CGaEWfFA7Fo2yBSKBug7YIlxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI97szY71R55fPZyWmpmyQlBjH3cplLh4eyl7Nz7Vbf59Ng4rcPfW5Bl20neihUcUmogXlsTZ2qqKp53R0l9XfEyhq3W8hQ/jRaV7EAx09O6yC0pJhl1tpgnSEdkbaMeED5rTgO/3sbz+eaYZgFeV6Nr9JB4ssV6/7s+Ro0NBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj4SIcyR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af98841b4abso447044066b.0;
        Fri, 08 Aug 2025 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754689286; x=1755294086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1XvSr0Z8c0tcBi0Igpp3/tumNuUlSwKlMlF92S6NAk=;
        b=Jj4SIcyRjA861DdaWMtzXx6vwSXCN/A3WkKOl6kPF5Ty1Jmhk0h9KlSfLzFThD4FKA
         W+rSsKdOTPelkc0OhjxOk9dM0EXa87yg2zkBCOJWYzVLr9XKoOFjvdtlOFWSroUfguil
         SqV6t76G10XpgunrZG/t5QJjbmHzxnZaiT0Kzys3+unlt5Nyk4uhCp6HEh/VvC4OdBrQ
         TOxnebD39FkrrlWNPdv8owJZ5WJIjxTNKMFZM6Uf8xqL/gdvxFxMv6sXXEAO4SFchGjZ
         peGSrftSlWMc6sjAqSOcN/vh/s/1mb5IsJ4kbgJaA1PO6QSu+aX+h4ZvLTezqPaOxdCz
         5ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754689286; x=1755294086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1XvSr0Z8c0tcBi0Igpp3/tumNuUlSwKlMlF92S6NAk=;
        b=FRe1+2WV6rkohrzQnzzbGEdXsh2K5pPAllGcQ/dyYg4hIGAP0EJWbC6gEmFd/or1U6
         BHfwlTOPFE6K5D554WEA8mqBh2jQBA2lCTgDCmdFarIiuMKzWExyC/RoOFlWL1BW59q8
         /jhyOWV5JxZXXO0td9WY86F8BoPYZdHyGydBu//F3rfE+jfllVuzvYkLc2qNgpSqqnZ1
         c/OW7SnE2I3Aya0z9SB4nqsvgNRlot1ZLfUUWmB/4eghKoY2fyL6wiOEQIKQ1zFNjJhn
         94lPC5ti1byQDlHYMJ0hv8DKYj8uiA+WObeHvUii7kVh8NzVXJB0h0Nprxdbd1C+ZQJF
         zp8g==
X-Forwarded-Encrypted: i=1; AJvYcCVTVEL3Ur15izoMG74TdfxJQFvFkWgj93jJmLnuK4WIzNJ/6MIxXK8CG6z/S99+gLwX7Wz8E6f+b5y9Uz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYf09yR29LvoPsn3A+DtHcGo4jVAGI+1zv+rh/kZ3mfPNXlJoP
	X0zHtnVBSl0XNPNZDTKo7l//kEoyzT9vViC8XvXX5GLQGZuW5v1+f9VVbSe8MM4p/G0cwZww/i2
	ZJlV7NjVyzWd9FypD0l9cvm/UwxT+pTJ7Zymw3FWq/w==
X-Gm-Gg: ASbGncvSlXCEN1OF+We7k0rOT/L9xVwJrCnv4t2Se1hjkiow9nYiEcmHJuimnzblpGY
	EIG/IZDf9ybdaYg2+coen0c3tiKh2rMd7kkR4i/LCI/GWcYXTT6Mgo1HX0PKIkrrCC83zM87kuN
	TTl9JOXoCTLTOX1NrvH0eu+m/U7HNfEkAzJXO3ogSLlNLeDsCrC4fTyJUykVgNTEw6vcpBpQj4G
	Fk6ZYUS9w==
X-Google-Smtp-Source: AGHT+IHmhEAlzRvkf6wjcSOd/S2U0XTlzAcXIOGzJEtOBux9NN6OjAtgRw5JAZxtIqo4hkug++yxWkyntZdNWzIZd2o=
X-Received: by 2002:a17:907:2d12:b0:af9:3727:99e0 with SMTP id
 a640c23a62f3a-af9c64beedfmr416874466b.38.1754689285470; Fri, 08 Aug 2025
 14:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808190203.7493-1-marcelo.schmitt@analog.com>
In-Reply-To: <20250808190203.7493-1-marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 23:40:48 +0200
X-Gm-Features: Ac12FXxBRbRCiNfVt2mBckcWWtKdfrzCQL62KocilrSxqSiGoiHBXmlEIR24WHg
Message-ID: <CAHp75Vc1KgiDUUEjeEKdrSfom6NThPG-383O=sezydnrZLoGqg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update max30208 maintainership
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dave.hansen@linux.intel.com, andy@kernel.org, dlechner@baylibre.com, 
	jic23@kernel.org, nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:02=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Update MAX30208 temperature sensor driver maintainer.
> The previous maintainer's email bounces and no longer works.
> Also mark the driver as supported.

Reported-by:
Closes:

?

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> -S:     Maintained
> +S:     Supported

Just curious, are you really having this as a day job task?

--=20
With Best Regards,
Andy Shevchenko

