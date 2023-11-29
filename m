Return-Path: <linux-iio+bounces-493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1C7FD925
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 15:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C2B21319
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B730659;
	Wed, 29 Nov 2023 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usQAeTpp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5DC2FE2D;
	Wed, 29 Nov 2023 14:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD0BC433C8;
	Wed, 29 Nov 2023 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701267645;
	bh=ilqRE+p2fOw9a0JlFxXvmLieJ549kSYDkFaGPRRW8oQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=usQAeTppBB5TlyqxaUvm+41VSl5IEzYDcwModnXtK+ilMiYYiZNMrGCbjgRdZXH/p
	 7dbuv2jwzNtp5Du9YUsXip+eBl0GMPECNrAzKSBpNPdrJYpApOeTO4Yk6eYGfiCG5Z
	 U5F4XF3VeQXjWf3HSVlVEs4AdNgM6M0FS1acS3in6ezgGKlmMHXPUcU+DJsbfJufr6
	 TzeJkANcn3GU2M7GZiXB8s1i73Lx36tezfKVwFBWdIYfixNZTpARyWIZ4XoMoy8ixh
	 3I84Uyv8YYD3+0pUHFFXCaKPdBuTF30Tu7TxB8uOBSzdACibLuOQpvE0nzEdwkoAHZ
	 HLnyY+98+UN1w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bbfad8758so2243772e87.3;
        Wed, 29 Nov 2023 06:20:45 -0800 (PST)
X-Gm-Message-State: AOJu0YxMIn8A116RYvHh6I4XaAKjyUuECqakwDgeOn8TAJ8A8/2dV8sV
	MIDEqIAfYuuLBOmvXHsfROXWxVpAelh5QPMTDw==
X-Google-Smtp-Source: AGHT+IGQ6dT1phTdaBB2cnieLq1FHpCwg9+LMFYxy4gEJXci5LIhzhHGeiWIcYiUZnTGssn08SW/cPnCLwYi8FMKZP4=
X-Received: by 2002:a05:6512:114d:b0:509:4599:12d9 with SMTP id
 m13-20020a056512114d00b00509459912d9mr16626681lfg.6.1701267643713; Wed, 29
 Nov 2023 06:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
 <170126087595.1991744.9053853140300681368.robh@kernel.org> <3df72c05-7b79-4804-a220-5e342d6e5dd2@linaro.org>
In-Reply-To: <3df72c05-7b79-4804-a220-5e342d6e5dd2@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 Nov 2023 08:20:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhAX0vQ6LPN9ZfO4R44HZ3qrfb0oN9A9jo9+Jd2ePFLw@mail.gmail.com>
Message-ID: <CAL_JsqKhAX0vQ6LPN9ZfO4R44HZ3qrfb0oN9A9jo9+Jd2ePFLw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: honeywell,mprls0025pa: drop ref from
 pressure properties
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Andreas Klinger <ak@it-klinger.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:29=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/11/2023 13:27, Rob Herring wrote:
> >
> > On Wed, 29 Nov 2023 12:10:41 +0100, Krzysztof Kozlowski wrote:
> >> The dtschema treats now properties with '-pascal' suffix as standard o=
ne
> >> and already defines $ref for them, thus the $ref should be dropped fro=
m
> >> the bindings.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> dtschema change was merged:
> >> https://github.com/devicetree-org/dt-schema/commit/2a1708dcf4ff0b25c4e=
c46304d6d6cc655c3e635
> >> but not yet released as new dtschema version.
> >>
> >> This change should be applied once new dtschema version is released or
> >> Rob says otherwise.
> >> ---
> >>  .../devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml | 2 -=
-
> >>  1 file changed, 2 deletions(-)
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/iio/pressure/honeywell,mprls0025pa.yaml: honeywell,pmin-pascal: missing ty=
pe definition
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/iio/pressure/honeywell,mprls0025pa.yaml: honeywell,pmax-pascal: missing ty=
pe definition
> >
>
> That's expected, depends on the dtschema change.

Well, it wasn't because dtschema version used is git tree. However,
the CI job was using master rather than main branch. master falls
behind when I use the web interface... Now fixed the CI job to use
main.

Rob

