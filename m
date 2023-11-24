Return-Path: <linux-iio+bounces-316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08477F72E3
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD31C20E17
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B061EA8F;
	Fri, 24 Nov 2023 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0X2Fgzt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0602D5A;
	Fri, 24 Nov 2023 03:39:29 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5cce3010367so16905597b3.0;
        Fri, 24 Nov 2023 03:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700825969; x=1701430769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb10WU8tv9EHtRhhETzeYrXTjtAxyQNnbRx/PI9eif4=;
        b=B0X2FgztqDFY4cOMMaQiFtEqKgUMtuo+605cSAA+dooJlw8tG9hMS6rvecF6LZR2fX
         dB4srRw7X4x2E0k/Su3mI/MKoX+g02plTaNOuZ9DfPaTR6dnpvglNAgF5It7B+HaZqiU
         5nxVu80ck3zhcDTqtjHNCwgyZa/G3L2+PwpPskfjkRpLiq3niLKJeYRnoreI0dCiubis
         +Tx2TxIaQ01WvJJWLsdo3hGetHvk0OZ/MOnVVhDKoNx/3O1HDl0BPA8ZsT03bta52+hE
         Z/PAn1j8GsjmKcptKQlCjHfX2aqmDP7f6qC/NwIWHTa35qpeTwuOgxmjCR4JubJ6X3Tu
         jUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825969; x=1701430769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb10WU8tv9EHtRhhETzeYrXTjtAxyQNnbRx/PI9eif4=;
        b=TqT/HkDlA12T/RDv+vEe950HA0cta23P/7LhWbax/P9xOMCkqr48bDx6vQf+3Pr3Vg
         oh2lJKY4IxrXkLbcaFNHvhjqDI0nzjEaPm79vobj+3CpE/QlFvqijlJ2Ab1bB5Bst2Pp
         NsmTYYXSBHVNES6bGe77e7jlgIhKNKxbbiA6wQ0VlEY/A8fnj5fZFrRVLO1N3b2jP857
         +fU8oSWN1HwdBnR/LoCr2rAZDi/WZeJkbflARzVFGi/xfUNqf4eYqosIVWK8dLPOqKfQ
         KZ27n4tINlxqbq63Upy2gfhWXZqWPyqufKFbAWbRAdHtT1835ZQf1g5+h3dfgudBe6XG
         fV2g==
X-Gm-Message-State: AOJu0YwwPkHkVqkf2mF7w8cXgb66oiMCoP3cQjNdkbJC/WTQNDqo1xE8
	qeH4Re0ivG4tl3u6X8g4xOx/ExfitrpDnswPLDPtUhiNJJxk4g==
X-Google-Smtp-Source: AGHT+IFlgdpvIKIPHZcqtrrFQ+m65hOVgTUW/zmNJlDs8CCf1nV9Q6cL/Zmdm2kSYp2dC3KLqGXCd1Fr33dz632JH38=
X-Received: by 2002:a81:4981:0:b0:5a7:c8a9:79e8 with SMTP id
 w123-20020a814981000000b005a7c8a979e8mr2362179ywa.4.1700825968843; Fri, 24
 Nov 2023 03:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118105815.17171-1-579lpy@gmail.com> <20231118110232.17261-1-579lpy@gmail.com>
 <20231119-donated-hypnotist-33529b63bee8@spud>
In-Reply-To: <20231119-donated-hypnotist-33529b63bee8@spud>
From: peiyu li <579lpy@gmail.com>
Date: Fri, 24 Nov 2023 19:38:52 +0800
Message-ID: <CAELPsEaQZ1a-JO2Vne_MZXWN+nVh7LEw1z_wbHVjiLrKPtd_rQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: humidity: Add TI HDC302x support
To: conor@kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 21:41, Conor Dooley wrote=EF=BC=9A
...
> > - change the maintainers to me.
> > - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
>
> Does that even compile? It was the binding I wanted you to change, not
> the driver. Take a look at the example-schema for how to do this.
In example-schema.yaml, I did not see another way of writing "compatible".
So does this mean I need to add an example contains
compatible =3D "ti,hdc3021", "ti,hdc3020";
> Cheers,
> Conor.
Thanks,
Li peiyu.

