Return-Path: <linux-iio+bounces-12382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E379D1807
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 19:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83A0282C8A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 18:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E51E0DE5;
	Mon, 18 Nov 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jce1xy1P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746F1D61AC;
	Mon, 18 Nov 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954341; cv=none; b=e8EMMSlnOS7lFpOKciaAiGSdb/p0KA+L/ui02FtE5BNrdcZXyI+oqItfeuyxroQVcse36lNZX7+6HEsWJpu2PcyCz242wX34gpGMoAl1sr/YfS2hzwspliE2/HG5p2iohhgg2+CUPrNxqM/zVQA7LWcja0/KbOA52iZTOFBfTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954341; c=relaxed/simple;
	bh=yFn0tJijQZFmFg88hJ68YZX375dvs6spHAH+USzPzBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWTTi2RKWp9/LUT4bQ6aCE5TD126CsXX6XGzmt7JytcRIXjPJSLrgUvg+AJDzIBB+9twvLSkO3IFm5r6CfiE8xKpVc2P75C9Hye832/wDsaxN3tu85JR+MWgZ8drvjeeqAoOW6NjkRFLphZyvUka37/ReFhBuerI7/1nF0CPXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jce1xy1P; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7240d93fffdso2791408b3a.2;
        Mon, 18 Nov 2024 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731954339; x=1732559139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTB7RgwTfhvCIzEpViaY1/6qLz0FmLYHoX7cNTTXKCk=;
        b=Jce1xy1PGBjjmfZ/mtyVxbViZqVnPWPsFPFN3tbIa/4j08ShFOc+ayDeWYT7LajrSv
         8BWG32itsgjzVlmEhRGEPh67xRhWkoTW+mKK7xtihABffWLdKYuaLLAwDAao9qzoNvFa
         Q/Sji5v43p9pQu5abiU0rSUgHUd4NhoY2xoNNms6G+HWBnkQHx8/SRwetUlpjMCr6fqu
         23UbXKcb978lKdSzlp5q2MQUkct7a21/l+Rkgq9kCzx2Xe6F1Hm/09Y3+duwWJ7Hl1Pp
         bkKRlfdnQWn46ohh1YvN+a8XmoL5rZDbj27J7z9my0rvE50uOZUU5d90qgndY8AC6QMX
         ZTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731954339; x=1732559139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTB7RgwTfhvCIzEpViaY1/6qLz0FmLYHoX7cNTTXKCk=;
        b=SVtmtEL1TWnB4JdsPQ+jmQW9Rkh9pEgBGkx8u8HFBUaFYuNrt5zjJBfBXD6RYhJTaU
         PraOf0WIm8iig+lNlZ9Gsl4xilvB8p0zLFGnuLFamzje/Q9x/Uy9+DXMCya9P/gvwpgF
         QGPc+nTC3LT7jYp5HIPJnP7rQfFaFnyi59AnmHkF2yy23bCXUHxQEbpNfiTbfIAeBbST
         CnP2+yVyeRAnrD4eY+4WMQujrJyt2jFs0LS6oPUK3WTvl39bjEaCJot8+0UUEC+7utq6
         uawG7xUixzY8lBGKYcKzsrhd/LQ81aVMazXniap0akQJMSEKVuJtL2JvzJyF7TrXWHid
         IeLA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4RDfW+7sDa7PZ6+a3mtdz9ohQu08one3IDHFvAU4AoIhwQFbrg29Ojyij0L5U4gltVGoDPztjuBT@vger.kernel.org, AJvYcCXRL80PNJwdcspDNxqPJwaCKkL8Sp+XqTph2r17F1z7lCuHMhjzhfXEGhGeZLshL2SE/7WkbE7VtD/7@vger.kernel.org, AJvYcCXUxeqZ1VzPKGx7sO6NIQPZY412JklHSPevvFlgkCFQk55UKqCCUYgIUg2vXRT74oC3xL1bG1UcQunQRxkE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ11A8jRfkX44xmg3duVKte64IHtlXfUOlaaxBMl8RQ8h3CbPX
	p4cjHKZxqXND03nr2/kYtV1mmBKTalWfuJS5iiYAINl1m0hs0892
X-Google-Smtp-Source: AGHT+IF9uKw+s+7Bo36sXReNFc5IVWD9Rexu3HwgZIgIrKS0xYYCdO9aGauhBrYZo1fTeyv1lq9RWA==
X-Received: by 2002:a05:6a00:4fd0:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-72476ccbc21mr19152314b3a.20.1731954339070;
        Mon, 18 Nov 2024 10:25:39 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eefdcsm6556440b3a.14.2024.11.18.10.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:25:38 -0800 (PST)
Date: Mon, 18 Nov 2024 15:25:58 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <ZzuGtvdrD6D06rEp@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
 <0b8a2d07-feea-409f-a850-7ee0c752a949@baylibre.com>
 <Zzsj9_HVBO5wrJv_@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzsj9_HVBO5wrJv_@debian-BULLSEYE-live-builder-AMD64>

On 11/18, Marcelo Schmitt wrote:
> On 11/15, David Lechner wrote:
> > On 11/14/24 5:50 PM, Marcelo Schmitt wrote:
> > > Extend the AD4000 series device tree documentation to also describe
> > > PulSAR devices.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad4000.yaml          | 115 +++++++++++++++++-
> > >  1 file changed, 114 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > index e413a9d8d2a2..35049071a9de 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > @@ -19,6 +19,21 @@ description: |
> > >      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> > >      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> > >      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7694.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
> > 
> > It would be nice to sort these lowest number first.
> 
> Ack
> 
Actually, I didn't get how I'm expected to sort those.
Isn't ad4000 < ad7685?
Or did you mean to put adaq at the end?

ad4000-4004-4008.pdf
...
ad4020-4021-4022.pdf
ad7685.pdf
...
ad7988-1_7988-5.pdf
adaq4001.pdf
adaq4003.pdf


[...]
> 
> > And with this many chips, it can be easy to overlook a small difference
> > in one chips, like ad7694 not having VIO pin, so is it really fallback
> > compatible? Easier to just avoid the question and not have fallbacks.
> > 
> The absence of a VIO pin does not change how the driver handles the devices.
> They are compatible from software perspective.
> 
[...]
> > >  
> > >  allOf:
> > > +  # AD7694 doesn't have a VIO pin
> > 
> > It sounds like using not: could make this if: a lot shorter.
> 
> Ack
> 
> > 
> > Also, it looks like ad7983 doesn't have the pin either.
> 
> Ack

I forgot the ad4000 driver fails if VIO is not provided so I was wrong when I
said AD7694 was software compatible with the other ADCs.
I see now AD7694 also doesn't have SDI pin.
Aside from the VIO and SDI pins, AD7694 is similar to AD7685 both being 16-bit
precision 250kSPS pseudo-differential ADCs.
The AD7683 part you mentioned is similar to AD7988-1, both 16-bit
pseudo-differential 100kSPS.
To avoid complicating things, I'm dropping support for AD7694.
AD7685 and AD7988-1 are the parts with features similar to AD7694 and AD7683,
respectively.

