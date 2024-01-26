Return-Path: <linux-iio+bounces-1929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C10B83E09D
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 18:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A681C22A98
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD5208D7;
	Fri, 26 Jan 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="IfoXomhK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8F208A7
	for <linux-iio@vger.kernel.org>; Fri, 26 Jan 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290850; cv=none; b=PNB3/p4Y1ktyPRI5+en3w3Gp1XYJMWgWBlZbmzHuL0mCoFhwQgMGwn9mENFLAXvb5IzLk/WmF3bKH+ycCCriXSMxFQvAlQ5XU+oMP3985QwJrC2Jf3mCg0cErKvHz1zbTRobw9md9W3PpPw9wej/ekHMZV8Y1LWNUgpSHQKvrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290850; c=relaxed/simple;
	bh=LYAUFYI3PPskX/K+nNIULnwnwvRLyCKhmBoErZbeIEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5lRal1yMqBwj8PZ3tWIoU9+qWjt0OjlcVazGP4zzNuHY9kxIA3T4qN32ioU35nwhWlvI3XMwLiwrnkBmQ/KlTZkqGTOyhtNR+9XX/UUbtzxQ2M9/J2PjaaXWCk0jKQSpTwRmeH7Os4ujukgEb2E6TnchxMgcCFa6ZZcJMjWG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=IfoXomhK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ddce722576so526809b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jan 2024 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706290847; x=1706895647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nW/G1leX3fQbY5zUt2hlw0gvCqeqoiW1Fa0PytKdtZg=;
        b=IfoXomhKI9nWITFaj3yLc3TfO1vrHGAyjGDpvtIj1witwUaQ3bsEkYxeA0FXYewT0z
         7f5CssJaQAxKG8JsgukzTMQ5RuUQh8xo5pZ5z6I6IBtvs2o7BeTpIUQINvgNBWII7uod
         PqXD4ZLX1TCE4HLYp+PLARaDOWRlbC4LvMX0hdKD4h87v2arLUz9mxAJuW3yCFDv+llb
         MaUyz2pMRsOaeSJpI9pRGZo9C+hq5EAfepa+FnE86y8HODOCUZiePoOwP8xs1/BbOwGN
         R1zAzW30H/k+wdGMLy68VyBtRAknO4M+fVY0XP/gbsz2BpFQ2O8PhVUqCO0q7cO/D9yh
         0lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706290847; x=1706895647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW/G1leX3fQbY5zUt2hlw0gvCqeqoiW1Fa0PytKdtZg=;
        b=XBAdA0cSi/+ZI4cChUqXrzK6+DCj/2ITUh6mayhtUbfQypUqyfXrfeVa5DeT72kPBK
         fhj2k7opZsPdHTI+XAeenqIc6V0uTV1VAzHsbvh/bMbl5BwyRe3VE7A1h9pBf+KrVBHP
         kiZ8H51Ji5MQxe0qSm17BK0w5nXlGm7EFvDGOO3pnRioo8mRMgok4cf5hpY+JroszOq7
         /R9o7tTCWyyD3lCX5fGrU+YdkY1f81DZsqxAZ5KW3zNTPeKzPNWT/L64b/92GwRWwvSY
         lepgHAqDElYRm6RgYDIrNuC6KULeud+seI3qk+P88Ia4cfmzqD+s2OtvzDUmA33P4tBu
         s+ag==
X-Gm-Message-State: AOJu0YzzoCPGg+hDGsBlTgRTXnBdgceysX8dT1WKSH7LGZpJr1Hf1ZoH
	cLAtTW4MPVIhg0Va/Bc++yXSF3yIz1k6tGVQqSmyhtrm9Erv56TBgiMrsCX+V3C/6iXw9vNwUnN
	QKcqbV4qKg0dTJ+CALK9SGCfAMynhbqZzMbHKrQ==
X-Google-Smtp-Source: AGHT+IEcSrQaMAvEaXVvHb7l4qcln7TODr9I1zAzX1B7RypHiTg+jJOTUgiHySRU59MmQB9TqZwYmHPyouHWF5zed9A=
X-Received: by 2002:aa7:8886:0:b0:6db:de89:d0f1 with SMTP id
 z6-20020aa78886000000b006dbde89d0f1mr175972pfe.28.1706290847494; Fri, 26 Jan
 2024 09:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud> <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
 <20240126-scale-serrated-33686467d91b@spud>
In-Reply-To: <20240126-scale-serrated-33686467d91b@spud>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 26 Jan 2024 23:10:36 +0530
Message-ID: <CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
To: Conor Dooley <conor@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Conor,


On Fri, 26 Jan 2024 at 22:22, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jan 26, 2024 at 09:55:20PM +0530, Naresh Solanki wrote:
> > On Fri, 26 Jan 2024 at 21:47, Conor Dooley <conor@kernel.org> wrote:
> > > On Fri, Jan 26, 2024 at 05:25:08PM +0530, Naresh Solanki wrote:
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > > index dddf97b50549..b4b5489ad98e 100644
> > > > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > > @@ -39,6 +39,9 @@ properties:
> > > >      description: |
> > > >        Channel node of a voltage io-channel.
> > > >
> > > > +  '#io-channel-cells':
> > > > +    const: 1
> > >
> > > The example in this binding looks like the voltage-divider is intended
> > > to be an "IIO consumer" but "#io-channels-cells" is an "IIO provider"
> > > property.
> > >
> > > Are you sure this is correct?
> > I'm not aware that #io-channels-cells is only for IIO provider.
>
> #foo-cells properties are always for resource providers
>
> > But I do get some kernel message as mention in commit messages
> > if this is specified in DT.
>
> Can you please share the DT in question? Or at least, the section that
> describes the IIO provider and consumer?
Below is link to complete DT:
https://github.com/torvalds/linux/commit/522bf7f2d6b085f69d4538535bfc1eb965632f54
>
> It should look like the example:
I reference the below example previously but didn't help.
If io-channel-cell isn't provided then there is print in kernel dmesg as:
OF: /iio-hwmon: could not get #io-channel-cells for /voltage_divider1

Thanks,
Naresh
>
>     spi {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         adc@0 {
>             compatible = "maxim,max1027";
>             reg = <0>;
>             #io-channel-cells = <1>;
>             interrupt-parent = <&gpio5>;
>             interrupts = <15 IRQ_TYPE_EDGE_RISING>;
>             spi-max-frequency = <1000000>;
>         };
>     };
>
>     sysv {
>         compatible = "voltage-divider";
>         io-channels = <&maxadc 1>;
>
>         /* Scale the system voltage by 22/222 to fit the ADC range. */
>         output-ohms = <22>;
>         full-ohms = <222>; /* 200 + 22 */
>     };
>
> Thanks,
> Conor.

