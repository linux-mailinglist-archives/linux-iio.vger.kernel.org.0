Return-Path: <linux-iio+bounces-21100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE15AECACE
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 02:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DE818996D5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 00:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F425227;
	Sun, 29 Jun 2025 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zqJMAeKh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCA290F
	for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751155241; cv=none; b=X2uSzdA/lNZIUhmU+kGJTyX6Rp+iVlUHuDHLjmKPP4FTc3iy3oGncgMKp8Tw4F0uEfRhR8ROUC1rfk7J2SJl4cuvhZebjLYv719/XGNXJpKSq/U3vuzSt1r++ceElKHXjVuyPpIJ2p9nHUAfdkEiEJm8jCng9BhRLF4UNdyvvYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751155241; c=relaxed/simple;
	bh=lp6NElhwTfDU/LWo/wfJbtHgIjn1qqaa+v6RzzVUEJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3zQKfRJ/sVUjypHHWxFFETsszePG4uzpuWiu461RuAdBIfFqkpwkK2OBUFHDBLqtUpza9au0V5GteeuTd3xAPGPSUp8giAAGY7wrNMJ2CSbv0eIkCuLDxJqL7NJhNLgLHesrtej2m5V32pz2fix0KHHLSgGLIBf/Q/gz8EV3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zqJMAeKh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74af4af04fdso2311972b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751155239; x=1751760039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAilxmNWyRl4r1PMhugpcq3yEAPzS9qmF0tbTSHWud4=;
        b=zqJMAeKh4CSB6bKcEYLJSnyQ2tdLkGUC4xli4/Ozj/STrxSveqn03eMZvePYTQEGXt
         c9h/PpuOLtLm1OLJ1Xz0yIbMDH8ecCfbpHBggj0aU//l59g8DNug6wKmpyg5CIqisvnk
         TWA94+WVaOKoeRKAbzmpGMmVBx7SiBaw24n+fwI39UrcgtkwVPZQWKrKSZLd71qzUb02
         BjrVpF+zyLyZp3/AqJTKkLeCvR746wAi/l9OF5xmjZLx60Jkm1LYjhPEsOO5dYz9UJv3
         Avqo3DNgK9X0sa4BoBEzVk0IJoEbCATHRmz9xchYCFg5KuvYEaTxo3C40CgDh174ZMtl
         oYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751155239; x=1751760039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAilxmNWyRl4r1PMhugpcq3yEAPzS9qmF0tbTSHWud4=;
        b=gFDg9he4R9vhf54APztkjt997BWyWoR2BUaGQjkBiZM1mLAVrCJnErush8Bq2ViY0f
         I37cgLWIhQlzMEo2Yj5ea6pb8c8p7L+9GW1qXWwM3iVBDsrT0+IC4hnmnl2ewfwGVUj9
         Sc+k7ANlDiaT45hDH+S3bNBnzjWnQoWfHoowHumW0bQfkY0ov+RJYtCCjrWAp8/dNzK6
         JWvVdLW/YJ5A99bJVF8l4ce6m1YvI+PEhCNzZ2r4K7tTfrUoBnWa2cWjWUyM63GGsmjg
         IpZHegxk01/rv5xag+KRzBfRxZ+lNvNMT1OL4O+xSbUThX2VGRFFAAbhR/OCYrHN4X56
         HLvA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Bi1WN/hD7mXmfoM5+GTjSCQwHsWzB10mPbYmGFpL5be50tn5Vpeo+O8a0lKhL2cLkfZT62QMAlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuw+fLvcou6czMfl15eoKpzEmxpeHeLSlYj8PWFa+VYNarJLEL
	DwXUFJeit7FLZnIpxrbcMBWOQZhnC/WqvamPQzf5aXRykMTiATqd/K/FHQOHXcxME64=
X-Gm-Gg: ASbGncvhRK8JqzHfHQPWXavkvn+9QgvHJL4MSfA2ifBtRD4ZK78YYu2gcc7OjMOG1FI
	CDxhZslNG02bWCnliXqXfOhFoO2NNPfG7zaTQ5oOO2EwV/w3AUgTMB+5qQGXwzI39UyvWOaqhMf
	4MT4kYq+n2eZdM9OqXk/jmu0BV/wOW7npGNrXNbq+jHo1zosiMtWnZOyS3CK/KSZHBBG+XtvBT/
	5knwYTUDpz9Fa5ZiaMb00TrytZ/b1P+Z9XFdMaD/EJd6mvGTSfEDY9sqadDEZevZuOdxXD5qA4R
	mQ8wC778uC1+DQh0tiLs8NWTA2ykSSYznViRE6Sp30NF23MGlhBK+iLIhSZ96loaOfLBXIKM1xS
	w5H5x4gkzXWqF/ypviMMcsA==
X-Google-Smtp-Source: AGHT+IHIJf26L5pUx7VLAHRUw0LoxJ15whIvghHSaohPoTHOcQcwEytJ1rs5J54SO/mjzJ3ezQ7YIw==
X-Received: by 2002:a05:6a20:72a5:b0:220:98bc:e0ce with SMTP id adf61e73a8af0-220a0893136mr13067261637.1.1751155238737;
        Sat, 28 Jun 2025 17:00:38 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31db05fsm4528339a12.66.2025.06.28.17.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 17:00:38 -0700 (PDT)
Date: Sat, 28 Jun 2025 17:00:35 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
Message-ID: <aGCCIwknL25yAyHL@dev-linux>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-2-l.rubusch@gmail.com>
 <8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com>
 <20250626192802.0079d579@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626192802.0079d579@jic23-huawei>

On Thu, Jun 26, 2025 at 07:28:02PM +0100, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 08:24:41 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > Hi Lothar,
> > 
> > On 25/06/2025 20:02, Lothar Rubusch wrote:
> > > Add support for the single channel variant(s) of this ADC.
> > > 
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>  
> > 
> > Thanks for this addition. In principle, this looks good to me but I am 
> > afraid there is another colliding series being worked on:
> > 
> > https://lore.kernel.org/all/20250614091504.575685-3-sbellary@baylibre.com/
> > 
> > Maybe you can align the effort with Sukrut?
> +CC Sukrut.
> 
> > 
> > What I specifically like (and think is the right thing to do) in 
> > Sukrut's series is replacing the 'adc122s021_channels' -array with 
> > individual structures. In my opinion the array is just unnecessary 
> > complexity and individual structures are simpler.
> > 
> > Other than that, this looks good to me.
> 
> 
> Sukrut, perhaps you could add this to the end of your series, rebased
> to those changes?  Would save a synchronization step for your v5 (and
> later if needed)
> 
> No problem if not, but I agree with Matti that we should take your
> series first.
> 
> Jonathan
>
Sure, I will add these adc121s0xx to the end of my v5.
Thanks.

> 
> > 
> > Yours,
> > 	-- Matti
> > 
> > 
> > > ---
> > >   drivers/iio/adc/ti-adc128s052.c | 17 ++++++++++++++++-
> > >   1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > > index 1b46a8155803..cf271c39e663 100644
> > > --- a/drivers/iio/adc/ti-adc128s052.c
> > > +++ b/drivers/iio/adc/ti-adc128s052.c
> > > @@ -7,6 +7,7 @@
> > >    * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> > >    * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
> > >    * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> > > + * https://www.ti.com/lit/ds/symlink/adc121s021.pdf
> > >    */
> > >   
> > >   #include <linux/cleanup.h>
> > > @@ -110,6 +111,10 @@ static const struct iio_chan_spec adc128s052_channels[] = {
> > >   	ADC128_VOLTAGE_CHANNEL(7),
> > >   };
> > >   
> > > +static const struct iio_chan_spec adc121s021_channels[] = {
> > > +	ADC128_VOLTAGE_CHANNEL(0),
> > > +};
> > > +
> > >   static const struct iio_chan_spec adc122s021_channels[] = {
> > >   	ADC128_VOLTAGE_CHANNEL(0),
> > >   	ADC128_VOLTAGE_CHANNEL(1),
> > > @@ -143,6 +148,10 @@ static const struct adc128_configuration adc128_config[] = {
> > >   		.refname = "vdd",
> > >   		.other_regulators = &bd79104_regulators,
> > >   		.num_other_regulators = 1,
> > > +	}, {
> > > +		.channels = adc121s021_channels,
> > > +		.num_channels = ARRAY_SIZE(adc121s021_channels),
> > > +		.refname = "vref",
> > >   	},
> > >   };  
> > 
> > I'd love seeing this array split to individual structs.
> > 
> > >   
> > > @@ -207,7 +216,10 @@ static const struct of_device_id adc128_of_match[] = {
> > >   	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
> > >   	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> > >   	{ .compatible = "rohm,bd79104", .data = &adc128_config[3] },
> > > -	{ }
> > > +	{ .compatible = "ti,adc121s021", .data = &adc128_config[4] },
> > > +	{ .compatible = "ti,adc121s051", .data = &adc128_config[4] },
> > > +	{ .compatible = "ti,adc121s101", .data = &adc128_config[4] },
> > > +	{ },
> > >   };
> > >   MODULE_DEVICE_TABLE(of, adc128_of_match);
> > >   
> > > @@ -220,6 +232,9 @@ static const struct spi_device_id adc128_id[] = {
> > >   	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
> > >   	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> > >   	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
> > > +	{ "adc121s021", (kernel_ulong_t)&adc128_config[4] },
> > > +	{ "adc121s051", (kernel_ulong_t)&adc128_config[4] },
> > > +	{ "adc121s101", (kernel_ulong_t)&adc128_config[4] },
> > >   	{ }
> > >   };
> > >   MODULE_DEVICE_TABLE(spi, adc128_id);  
> > 
> 

