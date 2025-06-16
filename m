Return-Path: <linux-iio+bounces-20722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0AADB849
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 19:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162343A8DA7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0078288C9F;
	Mon, 16 Jun 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Oz4CNc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB251581F0;
	Mon, 16 Jun 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096588; cv=none; b=kpyVWQwNtuJMBBIpQChL8BCMLJ1bvrA5zGtJwoeuNywNXIgGeC4Oaqe+sKrEdoaaLCwygaSSXsLTABt2/7bK6j+0n2vR2wQV8COkHEt3Pg7zZ6ooZl9wiI2ysHiMq8rNRrCh5mv8n14c+fs6k01g2HDxhcvLRdg2OBiGpkEbEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096588; c=relaxed/simple;
	bh=JPNMiFMc4QqzmFlTXtt8gX9899PW6Tou+z2XL9IAKaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHQr1HMCx4EUntgk+jOJk8VgLZG91eG16B4jfSAFLrfxakaNPeEVgSwfpC6yD4aoVdXuCt2YhkGTDyNg5EBNiVeWKnKBIiHczbppr27Su0j8MDrdlet0PXwMzQYI+NOXURRLbYao9YDfsH7wh4JthKeksxztRzfYdCyF3vrmrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Oz4CNc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2f1032e1c4so5340667a12.3;
        Mon, 16 Jun 2025 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750096586; x=1750701386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afOWJh3aFPVPv4E1oohhmDl122IjFo4haUaVn/RE93c=;
        b=Z8Oz4CNcfHKvM/wXU5HPXbLVTwjukBwTnIxDVLD1M6q+2+HuTUFXSec7/HYb9pmKPw
         IAn3rR/uPdE5QidoAYNK2NB7NfXuXl5Davke0OjS03pd4G5h+hUbwXACldgD/xTZPDL/
         jHiIS3xA9V6Ju1zdOzWvA+1WYL3oInr18m++q6qJdAGXXKd+ULQ5tea6AbdBn/3zw0YW
         PypMODn0e7Ikx5FMfLGOKvPn5khvlkGFZwKdQTEUX2VlrvoXsukz+Xw1NuFXNOD6L5YN
         U1DdhFe4/sb7rzvk/zIxbszwc43esMTfW0lzVLgwBVOnk7b/IYk3ZyKtQ7FYJCNspXhb
         ciHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750096586; x=1750701386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afOWJh3aFPVPv4E1oohhmDl122IjFo4haUaVn/RE93c=;
        b=lQN6na5dAjL32wpk9p+C+xgZqVhkzuN5+jvPoFoXnMghTzo7CsBPq7I1CuBkLZlezu
         hA9b6wZNJp0fWwl2txL/tjXWvql2BamsQ1K2SCNS4FRz5rYKxBVU4yWTi6T3RcKCwrQH
         YBSrLZicKM/FI+1BzJUJpe4a8CIa0dllsGk+8PkWfs4KGqJZTYHCClCRMSkp607n4Zky
         8vG+Qm+UKX2QnnW89ZGwb2Grl0Tau7gLU9mjMhC7gBKGSr0i+g12Gj+8rF1D5+4wBpLS
         ESvbrJho6Q98FlZ2KKksTlmVAV6PcLjp9j4oub//Jx92xUsLtMHdkdOAUO1VNojQYZpZ
         lk+A==
X-Forwarded-Encrypted: i=1; AJvYcCU3B0RRzpb9Bx2jOmGILtD9X7Yu3yMgk5kknaiiqWS5SQZMSCGifvASLYpNQ5h1jlq2h05Fu2HFE7DsCA==@vger.kernel.org, AJvYcCVh2zYqnQFwBzZ9dqr8PMJVEpPpGgB+rUp1xPLvBoQEtiTLuItt7StaogGKBe0DXFlaAp1sxqFSb3/Z@vger.kernel.org, AJvYcCVoNIrmbwyzuYWXqkAulbp1v/nHqLBD2nsAEfcWH9C6ykZDWY6XTrZKJMEye7H6wykjpsLS3+dz/86zR2QH@vger.kernel.org, AJvYcCXguQaAH5Rf1l/AEZ4dzZYNiLkHLiQWhHS2PxdAUzFJdTMHe9Qd1wu46YXR5bj+gBRnvG8tStukHDt+@vger.kernel.org
X-Gm-Message-State: AOJu0YybpNIH7+dI+ZWwOa7ZqA4k75+JmYeITcNWpANwXKG4jNBH5Era
	01MtBsvFs3mRdlcueYM9RKagBRXAyxvgMO2SttK657djBnXixzyBvXyE
X-Gm-Gg: ASbGncsvverHfYoMTqtPZ8ifo0IPebm1UsMLK98HGhJbt8R9qvSzIcdrW+U4Y7KNrlC
	lIuJNNtcmRtGMDSCtVbUNYotxNcJhxtn4UqtkCuJfGPWGWROZ5uX85Ih1hMzRKL05veJgpkgeqn
	KmMNcIcpg45x49B3b6F8+8NgrCJpOBQV2Nt94y5djecjhwMNXZooUFgTdRuiA5hXJqPca43uB5Z
	ow4UDDNzQk1sF7pk550wGBIS1O5dNuhflxFEbEuTp6cWsmcUgSbXMVsy0pudZAdjgRw48ZOAkvG
	LB+XzxOjGJpQD11/KrzC3sxQ6f7fcxXM7y07Rx2JzQJJSH8NXcKddpinKg9js5ofwYHiges=
X-Google-Smtp-Source: AGHT+IEOt7ZHJIadPo23AzTPWtHvU8mk9GOWEhQ9gC8eTaJo2rRa/5tPX6XD0fdqF/elVsnGisr+bw==
X-Received: by 2002:a05:6a21:4983:b0:21f:bdd5:d71b with SMTP id adf61e73a8af0-21fbdd5d743mr15116120637.2.1750096586118;
        Mon, 16 Jun 2025 10:56:26 -0700 (PDT)
Received: from localhost ([2804:30c:4000:5900:b4c4:6073:1a92:4077])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748900d255fsm7375942b3a.172.2025.06.16.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:56:24 -0700 (PDT)
Date: Mon, 16 Jun 2025 14:58:12 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v5 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <aFBbNEWZo-7PoI3_@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>
 <20250616-neurology-explicit-ec2a829bd718@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-neurology-explicit-ec2a829bd718@spud>

On 06/16, Conor Dooley wrote:
> On Tue, Jun 10, 2025 at 05:31:04PM -0300, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> > The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
...
> > +
> > +$defs:
> > +  reference-buffer:
> > +    description: |
> > +      Enable precharge buffer, full buffer, or skip reference buffering of
> > +      the positive/negative voltage reference. Because the output impedance
> > +      of the source driving the voltage reference inputs may be dynamic,
> > +      resistive/capacitive combinations of those inputs can cause DC gain
> > +      errors if the reference inputs go unbuffered into the ADC. Enable
> > +      reference buffering if the provided reference source has dynamic high
> > +      impedance output. Note the absolute voltage allowed on REFINn+ and REFINn-
> > +      inputs is from AVSS - 50 mV to AVDD + 50 mV when the reference buffers are
> > +      disabled but narrows to AVSS to AVDD when reference buffering is enabled
> > +      or in precharge mode. The valid options for this property are:
> > +      0: Reference precharge buffer.
> > +      1: Full reference buffering.
> > +      2: Bypass reference buffers (buffering disabled).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    default: 1
> 
> Why make this property a uint32, rather than a string where you can use
> something like "precharge", "full" and "bypass" (or "disabled")? The
> next similar device could use something slightly different then the
> binding becomes pretty clunky.

Oh, good point. Will make it string type (if going to keep the property).

> Can you explain why this is a dt property rather than something
> adjustable at runtime?

The reference buffer configuration affects the allowed absolute maximum input
ratings of voltage reference supplies. Some bindings (adi,ad7192, adi,ad4130,
adi,ad7124) have dt properties for buffering of analog inputs and adi,max11410
has a prop for reference buffering. It looked like adi,ad4170 having a dt prop
for reference buf would make it more consistent with other bindings. Though, I'm
fine with dropping ad4170 reference buffer props if that would be better.

Thanks,
Marcelo

