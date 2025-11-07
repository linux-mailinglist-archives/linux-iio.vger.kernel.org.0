Return-Path: <linux-iio+bounces-26005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F52C3E3FA
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 03:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 640BF4E5FD3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0EB221299;
	Fri,  7 Nov 2025 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gra32C08"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DE1D6187
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482657; cv=none; b=CoeskYd8D72nHj+mGL+btSFshAfmxeGJEl7TGYDGq4eArVS3FSt3xsD/cumejr318GwPyEBbH4JTkLa8JeVDA2RmRb4uljCbcU9EPlzKTI2aFwF+juVkTBIE6hFh3AZpaUvC+oi3A5FAnv0JmagJE0eSLghFtODty5mWTa6K1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482657; c=relaxed/simple;
	bh=m/FxyrDohLxVI5g6VU54h2YzJGrnT+5TCt3twZ+P7V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZDxwNTogVWhjf6xPkcsr3havLtIQdPvE0LEzgbJ5fnFUPzuq00rdJ0W66gDyZ7kgwq//Ei8XKk04iHJuVMUSkcHyGvkosU1j+SfxQi1dbp8sTaKpTpeeOeiYAgP4n7IANBRtl6HinKorLnpC0XHN2lVvrXDYJzOUiYAzfvJ/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gra32C08; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-44fff490b19so69579b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 18:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762482655; x=1763087455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QitgsGMcCeaaCUn3+Z4foq6QODVB8MooID8xUuvB0Bg=;
        b=gra32C088VwRq8kYtcqPlenq4JiQibvRRdQ+kGbtzqYKs4VFn3hV+hiOqsGsPIYHvP
         yGxeG0jTqmdZMJQXZV9vVsRWH057BnE2D5Il16K6i6ipSAWuiK68lXbxyVZsIika27TK
         9i9eXZksEUHeGzk8icBx0eut36kI6Y8waKHzU92FeNFEGIRpkn5801tBGQO5GQTbJbl4
         pbLA7ckDjcMEgA0BgMIixV8BIcOZYbi6zlsJvgKYuFLbM5oGOvUB8+C4DvrIEpXhRyfm
         TlSa8R9CookG7Y/ceNCvfpK+bVIYKOrBYR6qWNByOC4hkvQf25vGKB0ltuazzW9f5akR
         0dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762482655; x=1763087455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QitgsGMcCeaaCUn3+Z4foq6QODVB8MooID8xUuvB0Bg=;
        b=CadaBax1uLERg4puvbR/zAlBCNOjFgVGb7IA0TjZ5nxmupCOsvzXJ+3ZrusTjxltM5
         Pl/KLASmappIX5cdGC0hnDIc3Bxsc3MB3wvTzMsrmozPxWyOwL99uMQOfrKBfW0stZrt
         +F0B0a3R8OU+QZNPQU3FV5QLjftRcFw2ikbraaIKYcbU0OcKZdwlOUf5N8mK2qanXVvj
         KEzlqkE2iSIw4UCkveXMLANP1czIxOyqMu+53KJgkSF2JgwpJ5yK9To4Y0LNW6SpiBUn
         C+7qc2vjz+IwVIM8+xUHMgeqiTJN5OaJBinIl6t7wjtA6cFvRdfFze6NcxDh28wdOmFI
         zEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXR+MShrIJs45EvZDgJS5yBVTE1THzZ2NnoavqnL+dNjwldWfZkte/hEd4zEV655rh4urZsP9NBPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6VMy5XoN/dlcQse2QKYzM8MmC/J4lK6Nhl0tMUlwswhYNfsq
	HcotLU1td/E5VoNzU4gG+YQ23N+Nll/cKd093Mw3mhd0pjzrA9LDK3s3
X-Gm-Gg: ASbGncuhYuuoa+t7gPpLmHLk//jM/P5PgVSoQD4MaZmD3m/ZjDY8YSH3563ca3eRHWe
	Zfx5NflyRB70EJTTj6c/jLVIHodF6WDoVId1tKehuMSK/wEffBH/RTzIfaKPCZzBAss4ukgbjaU
	a2a6G82qfDdnUEOUkkRzNnsZp15qXxIJeNvFeF2PUYtON8Z7oN9C9BDU+GBDCZgrOkqtdXdPKxi
	ZEc48AUBbm5JRA9Rkxyp4oAry3XshPTEXe5DuzrvDsnWcfilc2d1n9KSTW6eqNo5m8pIlqInML8
	JjnIEplzVZ7PYddgM35jYPwrb/3U2APd3r1xW7AH+c017KfB2GXoaDbQPWrJtcfRTz7oqfByCWT
	yGGku8sbrrNfYi4rkavdNwTL4n0yqtQvmuVHnG/Q2GYOWteTPTPSOM7YoQwTyLigamOFV0lvjS7
	D6v7BT5WYDrDL7Q0tTl3qS
X-Google-Smtp-Source: AGHT+IH1ZtROpNSLwljnDJvmsH7HrvXKX7fauIOjFJbIdXtQGCfFuG8X9AAIMN1cUxaAcaR9GIlCfg==
X-Received: by 2002:a05:6808:320f:b0:450:1179:5f3c with SMTP id 5614622812f47-45015ebf797mr808667b6e.37.1762482654788;
        Thu, 06 Nov 2025 18:30:54 -0800 (PST)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-656c57d5928sm1611773eaf.13.2025.11.06.18.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 18:30:53 -0800 (PST)
Date: Thu, 6 Nov 2025 23:32:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: ABI: document pressure event attributes
Message-ID: <aQ1aJ2RNMXp9TXzY@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-4-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105095615.4310-4-apokusinski01@gmail.com>

On 11/05, Antoni Pokusinski wrote:
> Add sysfs pressure event attributes exposed by the mpl3115 driver. These
> allow controlling the threshold value and the enable state.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 352ab7b8476c..5f87dcee78f7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
>  What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
>  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
>  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
> +What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
>  What:		/sys/.../events/in_capacitanceY_thresh_falling_value
>  What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
>  What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
> +What:		/sys/.../events/in_pressure_thresh_rising_value
This is how it's currently appearing in sysfs, right?
If so, IIO event sysfs entry generation might need a tweak.

For what matters to mpl3115 event support patch set, I think this is okay.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -- 
> 2.25.1
> 

