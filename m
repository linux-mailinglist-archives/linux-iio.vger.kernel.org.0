Return-Path: <linux-iio+bounces-16519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC142A5680B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C718889CC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16809219A64;
	Fri,  7 Mar 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxh0/UOm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C044219310;
	Fri,  7 Mar 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351462; cv=none; b=TfvCV7TbZRcT+/Knzp2pw1/RSHbng/soRDKgk2hRdPsjqf20kNms6s9KR279XSVXHlsK392I177MEXi3NWcTzQ6LO6ruDY0+XS/WlkWx8lD0tGXVWF5bQMiW0qRld5gNbclUok3p2yM92vg8VoTURkNN08yJB/IAJkbqLSqkduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351462; c=relaxed/simple;
	bh=pEgUfTgW2S7gBugBF/6PSUkopxJLG2pTgy1gx153wqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6HQdhFYy1+SaFrNnT3O8YSUMuEwQ0ql4Qd8JoVKYGBL0ZLGee0vNXrAB4o3OpkSU4PswJplKgeGvWxk1DNdkM//JkFvo7J67BU1MXDTOj21WigUmInY/oNyDh2Icz8CLb8QYqRm7Nel5Q4GP+yMvKhVV9vooGZg0L3zy05fON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxh0/UOm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so510748a91.1;
        Fri, 07 Mar 2025 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741351461; x=1741956261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwzKC+BoRKyvxXzUfOtE+LFJN29dSh3BAY3ttGocc2c=;
        b=Jxh0/UOmevRHjzzZjYWsRHvv1L2i/OxlhCT7byC/Kp5gZG7WKsN4MY0KpwU8hZxQIg
         zY30/AcVL89cC14u1NdP4OeUujNUHUYFTLymqTVMhugZNw8mwKahRkmaoJqcLKjsPUNm
         6s5WkVCw40kAdqMZX1r2MNhFoNJR2oANbF9iLYOiqJp+Y7u87cqpURqIm9tWHFMHxOk2
         dfq0OMyqXfU7cv29dfzh9xN7mAinZAgl8O8bO67VYOlg0tsLrGkhwzpQtG00bKwQi+3k
         o+E0y4Ng3HSzh+zoomJJOEyMM5As2iZgBzdh4lrgI4CUv6bvjJCC4fankflUYwlgB9qM
         Yswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741351461; x=1741956261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwzKC+BoRKyvxXzUfOtE+LFJN29dSh3BAY3ttGocc2c=;
        b=oWqDsRHLHFatFeUHJn9hxzcLg/cYpuCRSezwgDXp/Ra+t/g54Ou+qK9EBp8UzB3uvU
         RNOiGFGWm+VxeMZKaSMOydN7c0unGXkUxHPc0PdSg1Glf/KGErcxeXGfgBYmH9ISdzBY
         +GD4j8sJxeImonWiQoME4tcvBcPcLKe+7GhypnzE3ulvk22t4flU4fHciUxmiBj4/px0
         0ddzfuxWeKPwrHMoNNsQJaSvffnoOeNzvwP2mFfEntzrOecEtge6rK6ftG93sdDofQTJ
         m//M9DUs92HoDxaEeXGjfQ9RsuYMpg2Dmr0WgcGhBWC2h4MfhEeVcRj3ODpwhLjxRTHC
         xRWw==
X-Forwarded-Encrypted: i=1; AJvYcCUn3oRIWvZepOE/gXf/Wpl2NOhqImRXdsewcPC1RpA1CmIltZe8pRTsxh543a6p5JSM2WJKq+YyZyyDpw==@vger.kernel.org, AJvYcCXWgtvjqfDPamsCJffaPzQSfHWAHSVrnH8hg2eHLm4UpvNhxjs69t0EpdNrgPYcaOJlHalTlmuG2dwdplUZ@vger.kernel.org, AJvYcCXfGxrjameF/s9Fc6aC0MLsV8nImEbTqTlMzbWYuz9D/pr8V3hFjvH6D4Ps/DtBvN73YtLgc7EN96UB@vger.kernel.org
X-Gm-Message-State: AOJu0YxobDIZN9mmPfaGsGQ34GR/ioFxAUOX4lgJLRNTqq39jTap5iWN
	++ZpAt/W1X+vI1eXH8rvhf9prhU/2Vc1Y30aImRFRzM0UNxtnHEn
X-Gm-Gg: ASbGncuPEDzhjmhBgAVkChp5BB4W9Y3E0BscA5xu5rLR6fhnfjquu3p8DVkF99D9T3t
	S0MEXHidtj3wzJuJOi5luBXrK+x2gb8shc1HcrLriQc/aCYhjK4WU8S8ig7Tgth6pDjHejco7Cb
	4CzQqwtRT5iK50IStuIzRlk1pEETw7RSlUmFDCh/l11q3BuouOJ6AzvAfSzVHVCMdaNJ25ITX2t
	SDt4A/CU+dd6/hBVKjcZ3QlekbLPPe4dxzcEXS5GXPJLbDxqzZ1j0aGLZ/py0uq7EwvC+IaiDIn
	xm/CL8hOr5m30V61EmNZeePFHee9tTuDr7Yc/Xw3UJnO2oYE4j1RcA==
X-Google-Smtp-Source: AGHT+IHMu9qUUyOvbqivlw3hkwW3To7hdGzWlPlEcierAxxBBP/Hf/0k3ExYeldcV6lFv+wY39JSVg==
X-Received: by 2002:a17:90b:4c8a:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-2ff7b59dec9mr5451858a91.4.1741351460582;
        Fri, 07 Mar 2025 04:44:20 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109def8bsm29093965ad.8.2025.03.07.04.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:44:19 -0800 (PST)
Date: Fri, 7 Mar 2025 09:45:13 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
	dlechner@baylibre.com, jonath4nns@gmail.com
Subject: Re: [PATCH v4 06/17] Documentation: ABI: add wideband filter type to
 sysfs-bus-iio
Message-ID: <Z8rqWR7OKZMIcmB6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <b390ec6d92dd742ace93bd8e40a0df4379b98e23.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b390ec6d92dd742ace93bd8e40a0df4379b98e23.1741268122.git.Jonathan.Santos@analog.com>

On 03/06, Jonathan Santos wrote:
> The Wideband Low Ripple filter is used for AD7768-1 Driver.
> Document wideband filter option into filter_type_available
> attribute.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

LGTM

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

FWIW, ADAQ7768-1 datasheet provides more info about what wideband should mean
for these devices.
"The wideband filter offers a filter profile similar to
an ideal brick wall filter, making it ideal for frequency analysis."
The proposed doc seems to portray that to some extent.

> v4 Changes:
> * None.
> 
> v3 Changes:
> * None, since we still did not agree on a better name for this filter type.
> 
> v2 Changes:
> * Removed FIR mentions.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..9b879e7732cd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2291,6 +2291,8 @@ Description:
>  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
>  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
>  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> +		* "wideband" - filter with wideband low ripple passband
> +		  and sharp transition band.
>  
>  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
>  KernelVersion:	6.6
> -- 
> 2.34.1
> 

