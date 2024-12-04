Return-Path: <linux-iio+bounces-13077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6149E35D1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 09:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A05316408E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 08:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1A196C7B;
	Wed,  4 Dec 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz193Ehn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364C18B460;
	Wed,  4 Dec 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302100; cv=none; b=fiNHlPkeQ1+c8Nq5EZlGyU9lNzv68UxbunofGwVSfwBCJ1KcMw0rhcIC8scNjDIFCMC2iJu6S2ouQ01Dk5521JjLg3Fa74bU/n5vbqvRdG4ZloZuqKZdjCtVHP6hq2eAII6rRPvTfjnMDegH+djJNCiZcfG4+YF00xGlFWOJ8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302100; c=relaxed/simple;
	bh=CEme4bK3HvAXUHsxp0VvxIuIYtf8ma7gcwcUEEAvrcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+H92hEoRhH1pF+k6Je1q97Kc5yGq1kFNpcdAXQY+bvq7SHT+xnYI0B/p3qAVvpG6nRI39FegLw67n3kJIVX/rQgfjL+NK2xLvjU+vi5ektvqRLjST1iGyWKnhwIV+x6lTH1WKgzxGb6JCSKh/Lr+bHGLE24cepsP5ZnlpNunJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz193Ehn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa531a70416so409544066b.0;
        Wed, 04 Dec 2024 00:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733302097; x=1733906897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMjUUcp4s9WK33JeqEJM6ue595vQiRg0HZzRgWfe0OI=;
        b=Oz193Ehn3r7i5ZZMYJZkpunkZGbWZIzBQqXOgvELzhGEDd+xfU7T0putVlZpg+Vx1p
         6Xkk8IO9BHMY0Hial1qj9sCqab6xyTb6CPqvnvj+OEQ5kMsj5sG+EQB/QX994Q5+7TRw
         B8iOt6+SSdNjXUEVnssGct409yI1VvR/ozYbMw83H3Ul/j16m0gCwFLQLvH59jPvM14M
         0++J4rXuyZNQSFVwPll3vMgqvxL74+8KBlkT44HygLExBj/Xmrno/T/BH3aJXcHsFX9w
         kGNFCMBsz8Y2ss9mznzHpKIxSGgZPXkm0Z2jPS9aSzKx5Vx2/U6S5Qi9VEtEvq1YnW+L
         clHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302097; x=1733906897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMjUUcp4s9WK33JeqEJM6ue595vQiRg0HZzRgWfe0OI=;
        b=DWJQnYIqaTDWqAE4/8b0ZwSTDXmnbhX//c1yiQ73QXDJ+cuI4KeSvv2c64LAwY4oBJ
         RvHqKMqIA2lMXIRjNil4918VQiBFGE+C21vJzJN2oGIc62kZh0q8bg/0UJ2KHgzEjcF1
         lQXiriXHKEs/LQrSA57dpTRApQhsGXWSy65gqoRzSMion0ZL52LtQjzJKNLej4GhiDEW
         GLfzCXalPXOoTz4e34tDHXJYF18XaDODrnu+YgMbPoFCt+269d+yz16/7rmpM+274sCk
         Fxmo0l2Dq+BaPUfNLXiiOF3vO6CoNNk8xSTI3y7QBPkRHARr8oTMfylh5Zfa+8bZdAnj
         0FMg==
X-Forwarded-Encrypted: i=1; AJvYcCUaELdOlIBhCXjCKAlvFP8nV62lKNABf0CX1di3YDJM/R7natiL64o1DjzYnF5KZng/T3PxJIWupN15@vger.kernel.org, AJvYcCXBa85dbx2+TmF8krYFVjYR/8ynXMBDrNunyiA/gX27AYM1gPzRoz3i3c60YFnY/aC1r5tZDh4EQsDN@vger.kernel.org, AJvYcCXhvIJE76hrYgtwzmgRdpU6Ok1D7fjSepjLAeG5wHx+2E1ZOesjG0wvYrayYyrw85h5ZOHwanBgma9txdTt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5q2HH8SAC+sek0AQw0PYhsncdSfgS2siej6PtsBaHYE4OZvSM
	CFutlEhkvHMgMARFrSG4SPm3g9+nrLZdRLAUkQkVAlUbNHj9IOpzxJNCw64S/iasxEnrdJ4bfhO
	sxkiYIIQ7WLJu1JxZwvEGX5TOZTo=
X-Gm-Gg: ASbGncvQ3brcseZs4zG+aP6plw70grWD0mUgnA4FObDMEj0hxm/686M7PbF+sifpjwL
	DzRj3UPJs2jMn2liSTy5VlnN8VZCC/pQ=
X-Google-Smtp-Source: AGHT+IEV994LEINSr66a32qFp1PLrkVFbJKep+D0UOrnqshNaXQqn1YPwdFJS2NDx4pAab/+t04tbGLuIAzMXMB5q68=
X-Received: by 2002:a05:6402:51ca:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5d10cb56467mr6229120a12.11.1733302096963; Wed, 04 Dec 2024
 00:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-2-j2anfernee@gmail.com> <4c5044a0-8286-463c-ace9-78a4245f112e@kernel.org>
 <CA+4VgcKWAOh=sQ=wUUPD89ORjYqZP0EDqJfqFT7FjNPppf=4Ow@mail.gmail.com> <4a223d37-4fe4-4ec3-a5de-def15b8b3761@kernel.org>
In-Reply-To: <4a223d37-4fe4-4ec3-a5de-def15b8b3761@kernel.org>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Wed, 4 Dec 2024 16:47:40 +0800
Message-ID: <CA+4VgcJs7kwHyjj0VtVkicK7j+XNh6aAcexg+cVp5sgPNnRzrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andriy.shevchenko@linux.intel.com, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com, 
	alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com, 
	ramona.nechita@analog.com, mike.looijmans@topic.nl, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Krzysztof Kozlowski,

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=884=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:13=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 04/12/2024 04:10, Yu-Hsian Yang wrote:
> >>> +  reg:
> >>> +    maxItems: 1
> >>
> >>
> >> No other properties? No resources?
> >>
> >
> > The difference is to remove read-vin-data-size property and default
> > use read word vin data.
>
>
> No supplies? No interrupts?
>

We would add interrupts and reset-gpios but not include in required block.
Add these two properties in todo list.
+  interrupts:
+    maxItems: 1

+  reset-gpios:
+    description:
+      Reset pin for the device.
+    maxItems: 1

Besides, I found a mistake that the Node name should follow.
> +        nct7202@1d {
So, correct it as
 +        adc@1d {

>
> Best regards,
> Krzysztof

