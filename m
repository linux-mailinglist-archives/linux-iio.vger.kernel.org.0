Return-Path: <linux-iio+bounces-25628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81DC1C7B6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 18:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663CD5885F0
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46CD346763;
	Wed, 29 Oct 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg4Y5Fqu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0F31283D
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758374; cv=none; b=ViWfNQUsS5OuA/6/m8YoL4UIS/jU02aINaP5oV70Y/jBvdDlkwnhr1DO/6B6O4wHY7IgYe4nnnJlivkcgtooFsKIQPnW/eg37vaxaxRgXU1B38cjMM0MbV+28XaexcJ5NqYJJj5vS0ByGFErNwBDSacpS4zBDwFVQAmzLVhSHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758374; c=relaxed/simple;
	bh=uC9UtG1Fr3nkcml/pRdAfhXZa8c/EgGRc1KcEkhsiPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYa7v07zJwjS8eleV+LcO3yeuMy1wUUeqyNcFhwFRTKreVT2BC/U0VF4qBAnowF15PO1BmnbbAqvT9xDmUPmq6lxv5wpLyMdUI2SOsL613srfoo5KoJla+9eTOdeOjt91CH9/3xMJvJkI6Qi8vswV2jMxtN7NqMh5Warzx8SIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg4Y5Fqu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27053843bso246959b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761758372; x=1762363172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCQGHjv2L44j3MTwWgphNqvwmgFbsURD1Ek139X5tpY=;
        b=Eg4Y5FqupsHMH+sAHutea09YggvUzXDUMSN0TGglaS0+K3nPBRitT1NL4xOdLkdS8E
         fH5jv28Y3wDN8zRWhwkRC14gH7KKCElxrUUvlovnqYJLXlkSZf69yaC1FBSTK3QIAPCd
         xU228LMNk5xuIuO4qMQo041MLdxCfICgh95EjVFjJyPfbXjXslVv+RXDtvS8mV2HI4I5
         HVHnHCyfm9HeZ47pXqXJHD1hkqMsoHzFnkRyFU/R+HpDTRMjNlxPEqqJCH8vYZBZN2jr
         14Nbv23e1XpT4i/9hJEhKPucriMzFiZFJoUpeXIdwCU5TQHmZDAouDlClP1/qULNY/kR
         jsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758372; x=1762363172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCQGHjv2L44j3MTwWgphNqvwmgFbsURD1Ek139X5tpY=;
        b=q/BusMVKAnVaSsFY/tW3fIifyNKfJKK4kihzWCYs252KgwR83VmWFt8H2pOqB/1tfx
         lWFCKz+vSQdfiq4GiyGzsl2W5S47sN2po0BZUhviELTn6Qegpr8aulokuOR8G35IEtX3
         V0KgsjC7/ZCPTS0nDVG+UK64AU0JQ3mT8aERPAD0VY5i+m4IagHJF4AG0pavAXm6b8Tu
         F+yoKLMobq9HUsA6HDXVT3UVyKUM8jv5NhAGPXkonDxpLtAocq3TlgrBxfoqfsaqB5te
         j/fPH8toTibXjZ6NLNOKLbkzDOXms/9B/Q+rQTqLuFgW36fUSbyOkT2dAyEvAXqIridn
         OcKA==
X-Forwarded-Encrypted: i=1; AJvYcCVf4a2yw6gD8fJmbtDMyobeecS+lKVilXQTBVEXdUNWvJm3M+6s786CRX4D5fbk8KkJ61xT9/75g1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lCYwPnMdm1Vbjpzs6tY4t/EfIhVF2Ni4dSc2WyMGxGxbFUiB
	/Y2Zp6aat+2hMYFuSHiidB5RrOtfNtjTXgW+LOzrcdxwPNvASFBmmQrB
X-Gm-Gg: ASbGncv2YvFc3nYFWSmkww8cT2TWrzoBv5P2G81TiPPDdiJK2MyAFzR+i+R0R3Fnqru
	gZO4HBPDk6RuDKGr+IIYrhLpTw0Ptkbe5YONj4MNrThBoMI4LRwXvIXNJ24p8xLsXxxAN1a1Jh/
	NU+oN0WPhU9G7kma3wuQ1k8oIv5rr0a0UOD5+NNXSyIai5ZeztYkrFk6OH4FJVqKMQ4K7S0M+bd
	5E9zJtY88TvO3SVkczePqqcoLWaQ5HcKyH1+wPmQ57HClMp1aOf3SBLiPQR1QyR90+AgiNVZmO+
	N6z4dpn8nVoKZuNdHHguITWSfg6Tfh4Tsi/dvYIv2XWLiZCYpk6KRImCDAQOPx6KQX0d7CB9JLw
	Oy/ybpLuOa+Wx4pEKaOPKMvjWI9YkwGCMrrFc/VMdqTLGKymHx3+j96ZXfffoBn6HuhOh72KHzb
	Vk40BwlMUPxS83KeQBtSNU
X-Google-Smtp-Source: AGHT+IGhZQVt8RAWqegksuHsY2aWHJeEyR48Taz4SwETmTmkW3PRPM7LH76hMjd7YkUyKwNfMhXirw==
X-Received: by 2002:aa7:9902:0:b0:7a5:396d:76c4 with SMTP id d2e1a72fcca58-7a5396d7d74mr2196746b3a.23.1761758372250;
        Wed, 29 Oct 2025 10:19:32 -0700 (PDT)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a414032c71sm16054214b3a.25.2025.10.29.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:19:31 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:20:42 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: mpl3115: add ctrl_reg4 to mpl3115_data
Message-ID: <aQJM6u9pGSdds0X3@debian-BULLSEYE-live-builder-AMD64>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028213351.77368-2-apokusinski01@gmail.com>

Hi Antoni,

The patch itself looks good to me.
I just wonder if it would make more sense to squash it with patch 2 since part
of the code here is changed again in that patch (the mpl3115_set_trigger_state()).

On 10/28, Antoni Pokusinski wrote:
> Cache the value of CTRL_REG4 in the mpl3115_data structure. This is a
> preparation for adding support for the threshold events.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index c212dfdf59ff..4cc103e20a39 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -83,6 +83,7 @@ struct mpl3115_data {
>  	struct iio_trigger *drdy_trig;
>  	struct mutex lock;
>  	u8 ctrl_reg1;
> +	u8 ctrl_reg4;
I think this ...

>  };
>  
>  enum mpl3115_irq_pin {
> @@ -376,6 +377,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
>  		goto reg1_cleanup;
>  
>  	data->ctrl_reg1 = ctrl_reg1;
> +	data->ctrl_reg4 = ctrl_reg4;
>  
>  	return 0;
>  
> @@ -390,12 +392,15 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mpl3115_data *data = iio_priv(indio_dev);
>  	u8 ctrl_reg1 = data->ctrl_reg1;
> -	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
> +	u8 ctrl_reg4 = data->ctrl_reg4;
and also this is changed again in patch 2.

I don't see much advantage in having it separated from patch 2.
Might be simpler to just squash patch 1 and 2.
>  
> -	if (state)
> +	if (state) {
>  		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> -	else
> +		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
> +	} else {
>  		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> +		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> +	}
>  
>  	guard(mutex)(&data->lock);
>  
> -- 
> 2.25.1
> 

